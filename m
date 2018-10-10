Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED90C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8002085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPf6Y40E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8002085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJKDIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:08:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42802 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJKDIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:08:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id g20-v6so3949556qke.9;
        Wed, 10 Oct 2018 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdEtrSNLUzoVlhC6ltAanlVd2BPIgn9p3chKH4UQUZc=;
        b=BPf6Y40EIw6hNuX4h5eNz6BTWxOruTIyVHtBdRfErIFuHrObQELxDQjZwEK5z8CKZe
         Kwo6RPDDjEQcHUn9/ZgAC2XeItoLDTGQav3u58zkG5ywPVRg/AcNe2jIoqgZbLnjgSGW
         kQ2gL2WTHZSympq8uc2/pF1IOt2adWo9A+N8bfgrtYy2nNw4WVa653UcLycfH8U1sv4+
         9Tna7EEUvUhiLi5hDwVLnKwklNBWpz+EchCXkTh3UZMN2NEMHyJ64/o2JFjorI/OMouD
         WZZ0q6+CHgJq7nlxBcApeDmy9LBAFX5nK6bjoGm1P9CpnowBid7dXqSdiH16hUhRsCXa
         MJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdEtrSNLUzoVlhC6ltAanlVd2BPIgn9p3chKH4UQUZc=;
        b=oFhembAts9sAidma5bDMTipTDUHh4NPxJlHeS4mSIhJVHKSJ0vl7iK1BgIXYBYESkz
         ajDwICSCiL0HiVEEfSiVYOa4Nw5SnKDauA1mDLfKod3jzQ3/QE+lu5PTV473eewpBrtK
         O9hV0R0akxZI0GSv3RdtGoB8kKeldLdkPt2gVEdPfdsm19TP8VzVwOq6ItcUbNg3v4X2
         YQF0fEYbUrfOb51/JoenkK53VfT2zTlC3JQL/rWlckGyATKUEMi4oaDDUHqyx+8Wqsih
         XYmDpiw9Ud1sAH6f30HH+Zam7Z3+i90E8afriX7l+8JIGX1AicKJYKi0TSd6BBS5zhKR
         ZUhw==
X-Gm-Message-State: ABuFfohkIheuZoxdKhW1m0UL5GI0SPOcXqigMefh/5zuX+UU8S5TXD+A
        yLHxOH99OssOq1apxA8g9A==
X-Google-Smtp-Source: ACcGV62tFo2zhS484Uo5gnbPjpAJzyCUIAe1gf3/RjAfV/EXLznnxLdwgGOKgbTTC9bF6TrPVGFDBg==
X-Received: by 2002:a37:6d41:: with SMTP id i62-v6mr28405205qkc.237.1539200691263;
        Wed, 10 Oct 2018 12:44:51 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p64-v6sm7420018qkc.96.2018.10.10.12.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 12:44:50 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:44:44 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, rjw@rjwysocki.net, lenb@kernel.org,
        ard.biesheuvel@linaro.org, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181010194443.sgdvplwdnltshwwi@gabell>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010085920.GB5533@zn.tnic>
 <20181010090620.GF25297@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.1810101113070.10278@nanos.tec.linutronix.de>
 <20181010091923.GC5533@zn.tnic>
 <20181010093057.GA22088@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010093057.GA22088@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:30:57PM +0800, Baoquan He wrote:
> On 10/10/18 at 11:19am, Borislav Petkov wrote:
> > On Wed, Oct 10, 2018 at 11:14:26AM +0200, Thomas Gleixner wrote:
> > > Yes, it's different, but if the SRAT information is available early, then
> > > the command line parameter can go away because then the required
> > > information for Masa's problem is available as well.
> > 
> > Exactly. And I'd prefer we delayed the command line parameter until we
> > figure out we really need it and not expose it to upstream and then
> > remove it shortly after.
> > 
> > So I'd suggest we move Masa's patches to a separate branch and not send
> > it up this round.
> 
> Yes, sounds more reasonable if we can reuse functions in Chao's patch 1/3
> to solve the padding issue.

Thanks for your comments! Yes, immovable_mem[num_immovable_mem] in Chao's
patch may be useful for calculating the padding size. If so, we don't
need the new kernel parameter. It's nice!

Do you happen to have ideas how we access immovable_mem[num_immovable_mem]
from arch/x86/mm/kaslr.c ? It is located to arch/x86/boot/compressed/*, so
I suppose it is not easy to access it... 
I would appreciate if you could give some advice.

Thanks!
Masa
