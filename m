Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E3C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4066920652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCZ+nYMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4066920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJND6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 23:58:33 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43228 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeJND6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 23:58:33 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so6144435ybe.10;
        Sat, 13 Oct 2018 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRUXtCn6SsUBDs0rSt+/tWSBKRHnU8NnoYqhbnsXLok=;
        b=tCZ+nYMswK7+OEyoIRnfP0roDFvyREjqRF6CUnZfXzKsN/0Xa4sTTxNtaYw7NgQWZA
         64CcjK4Ix/d+ms3rJWPfP/ZwaW0lo5eJdQOYz9jHLeAZkQw4DkIfDt+75tv4G5nxn2Zh
         y36D5u8Xu4v+4fEOijHfKKaidnUQ4QwUVEujjDWw4FlXIXi90J5i4sb1jL811Hwib9e2
         qc+QzhI9QVQPjd4NGu9kLv4/pOHK2DQDnABMRkpNPm+a1YhYAlQQE0Iym4MGeZKX57Ng
         IXNbSs4aRAwgJLAMPoD6Zwt9xiZ8eQyObVhckyORc820CVjqkpmEjdzRA7ltfzQhJy6/
         hQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRUXtCn6SsUBDs0rSt+/tWSBKRHnU8NnoYqhbnsXLok=;
        b=Be5m71/hBS2Hnd2IzKq0rMTtgcYFlJ05B6Sa91wusHbhPdI3xvtDc+qNDokALUIIYp
         s+EacMhWFHITN+x10WwWo9nYW196mPIiIhqwUur13n1tFKSeNglZBom3cSNCto4TuMiS
         RHLEaTyQnqhIJS1jdy9VPgGh7i57lwSWaj/D9tun7vYDtPtEUzkUJ2X2EfaNiYOLQ26l
         geaYOGDlBvynt7uPmW8dZ7dv6XDtU1F4rhtyt5Dse1dhyh7vTvVKyksgLdZwzAfFgKFh
         kt2IkduOZUX84RKlLt3WDOXn3Jk4On2VnS++ORUlHLMxOeMB6EB9G0EyeCsORu9QE3b3
         JNWw==
X-Gm-Message-State: ABuFfohiEvZAbDHiFz4/CQ4lYwpbxcXv+i2TCY1gtEpNudsG6nhUm852
        ngbBKtME9VzFYdV9CB2ykA==
X-Google-Smtp-Source: ACcGV60UEghO9igg+Km6P5P2NVen+GCKUAvaUB1HUzmGTSGDEAmS6XGsohgM2VQqRqeO+Q0SlnaI9g==
X-Received: by 2002:a5b:b89:: with SMTP id l9-v6mr5748597ybq.259.1539462006430;
        Sat, 13 Oct 2018 13:20:06 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id o131-v6sm1345749ywb.107.2018.10.13.13.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 13:20:06 -0700 (PDT)
Date:   Sat, 13 Oct 2018 16:19:59 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181013201958.zfzv5ahhe3xz7bwi@gabell>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010085920.GB5533@zn.tnic>
 <20181010090620.GF25297@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.1810101113070.10278@nanos.tec.linutronix.de>
 <20181010091923.GC5533@zn.tnic>
 <20181010093057.GA22088@MiWiFi-R3L-srv>
 <20181010194443.sgdvplwdnltshwwi@gabell>
 <20181011002955.GJ25297@MiWiFi-R3L-srv>
 <20181011055154.GB6667@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011055154.GB6667@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan and Chao, thank you for your comments!

Boris, the patches has been merged to linux-next.
Should I create a new patch for linux-next?
I'm trying to make the padding size set automatically.

Thanks,
Masa

On Thu, Oct 11, 2018 at 01:51:54PM +0800, Chao Fan wrote:
> On Thu, Oct 11, 2018 at 08:29:55AM +0800, Baoquan He wrote:
> >On 10/10/18 at 03:44pm, Masayoshi Mizuma wrote:
> >> On Wed, Oct 10, 2018 at 05:30:57PM +0800, Baoquan He wrote:
> >> > On 10/10/18 at 11:19am, Borislav Petkov wrote:
> >> > > On Wed, Oct 10, 2018 at 11:14:26AM +0200, Thomas Gleixner wrote:
> >> > > > Yes, it's different, but if the SRAT information is available early, then
> >> > > > the command line parameter can go away because then the required
> >> > > > information for Masa's problem is available as well.
> >> > > 
> >> > > Exactly. And I'd prefer we delayed the command line parameter until we
> >> > > figure out we really need it and not expose it to upstream and then
> >> > > remove it shortly after.
> >> > > 
> >> > > So I'd suggest we move Masa's patches to a separate branch and not send
> >> > > it up this round.
> >> > 
> >> > Yes, sounds more reasonable if we can reuse functions in Chao's patch 1/3
> >> > to solve the padding issue.
> >> 
> >> Thanks for your comments! Yes, immovable_mem[num_immovable_mem] in Chao's
> >> patch may be useful for calculating the padding size. If so, we don't
> >> need the new kernel parameter. It's nice!
> >> 
> >> Do you happen to have ideas how we access immovable_mem[num_immovable_mem]
> >> from arch/x86/mm/kaslr.c ? It is located to arch/x86/boot/compressed/*, so
> >> I suppose it is not easy to access it... 
> >> I would appreciate if you could give some advice.
> >
> >Hmm, they are living in different life cycle and space. So we can only
> >reuse the code from Chao's patch, but not the variable. Means we need
> >go through the SRAT accessing again in arch/x86/mm/kaslr.c and fill
> >immovable_mem[num_immovable_mem] for mm/kaslr.c usage, if we decide to
> >do like that.
> 
> Reading three times is redundant, but reading two times is needed.
> Becasue the ACPI code run very stable, but we need more information
> before that.
> As for Masa's issue, I am wondering whether we can tranfer the
> information or only the address of SRAT table from compressed period
> to the period after start_kernel().
> 
> Thanks,
> Chao Fan
> 
> >
> >Thanks
> >Baoquan
> >
> >
> 
> 
