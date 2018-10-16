Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1E52145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My69ashd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1E52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeJQDqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:46:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeJQDqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:46:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so27258931qtk.13;
        Tue, 16 Oct 2018 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fRhZjdGmtoKtxQaf8IQJ4nAMyo9DCYwUF2p+joWy7+0=;
        b=My69ashdfFTmolRzcZmSmtneaXdCIgh7HgH8PfMJMFjYW/nRCy+e5iH8E7BD28kZNG
         LirC/gOkbk7IbiTSy8zJgu51qRu+rgn2tVwxKBAH2U1/gPqLPtqh/KWNTa0D+mZsWAPR
         uaopZCIKM/6WAyMEE896gSWdmbAq8lxn6n76230cRebrtB08m0IhXyQh6yWs/Jbg3M08
         gR+M3ygUjXM51jmA4FzCt2x/f0ZhPpGdugKWMzffVLprbJfnUNWGXExRg1izDv/g1h4y
         qdTui+AXvIskPwHbnLfU6WO/0h+UpwnQjL17VeiT+iqy991Qt0Ju9Gy56mZQeknSRBFV
         wgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fRhZjdGmtoKtxQaf8IQJ4nAMyo9DCYwUF2p+joWy7+0=;
        b=Cf7n+RlfjKfYQyw5pk2SvuPiMhnsZyKCr0eUSyqkJXbNR3AOIb5IuHCZ8O3nju4vwu
         QJwgjX8aocflb6UVnQwnMQHGSy3jPoSMrXlqsdq1SbHs+kMm8chUBCdzfGLZjDuo1fPp
         9T/w+bywIMJEbcJK8g5r0EozppR/i93rjeur4WX2qdvGKzY32Z9AIrAKDJ05pEEr6I1S
         /exuI5yNFUZdLDw8hOkjXMlRLwF2Vz1AcXtyYdolAAtUyJaEq7VgZKjbkuVcAdNq/stC
         Bk4lzv2DqWzGFOR93crLl4mt65Fpm+/U306xIt4Z6Jb51t2L18PQSHBtpGGbBf36Wg1E
         d0yQ==
X-Gm-Message-State: ABuFfojQll0+dimQslJWjo4oXvytlrME/l4obAlILV4CAQnrRakfLcBj
        zdGe5a3C4v4NP1ndRHgciw==
X-Google-Smtp-Source: ACcGV638Fgbd/MzUpN5+b2W0KdQJlTKpei+165HW4lvoQn902r1uev8xjWrwoynt42cXvD7PGzPhOg==
X-Received: by 2002:a0c:ec0d:: with SMTP id y13mr23090801qvo.188.1539719677881;
        Tue, 16 Oct 2018 12:54:37 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id n85-v6sm8400040qke.76.2018.10.16.12.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 12:54:37 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:54:30 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181016195429.tovdgqq77gz3eek2@gabell>
References: <20181010194443.sgdvplwdnltshwwi@gabell>
 <20181011002955.GJ25297@MiWiFi-R3L-srv>
 <20181011055154.GB6667@localhost.localdomain>
 <20181013201958.zfzv5ahhe3xz7bwi@gabell>
 <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016191113.GI5212@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:11:14PM +0200, Borislav Petkov wrote:
> On Tue, Oct 16, 2018 at 11:13:54AM -0400, Masayoshi Mizuma wrote:
> > Hi Boris, Baoquan and all,
> > 
> > I have created a RFC patch for adjust KASLR padding size.
> > This patch is based on Can's v8 patch [1/3], and the Can's patch
> > will be changed in the future, so this patch is just RFC.
> > 
> > Welcome to any comments and suggestions. Thanks!
> 
> ...
> 
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index a06cbf019744..c987c725e93a 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -191,7 +191,8 @@ struct boot_params {
> >  	__u8  _pad7[0x290-0x1f1-sizeof(struct setup_header)];
> >  	__u32 edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
> >  	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
> > -	__u8  _pad8[48];				/* 0xcd0 */
> > +	__u8  _pad8[40];				/* 0xcd0 */
> > +	__u64 possible_mem_addr;			/* 0xcf8 */
> 
> Where in the example I gave you with add_e820ext() do you see members
> being added to struct boot_params?
> 
> Take a look at it again pls.

Ah, sorry, I misunderstood your suggetion...
In parse_setup_data(), the data is picked up from boot_params,
so I thought it is also useful for this sitiation.
I'll try again, thanks!

- Masa
