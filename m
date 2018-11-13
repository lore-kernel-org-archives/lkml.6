Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18942175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBtiMNns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18942175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbeKNCKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:10:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37899 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbeKNCKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:10:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so20296440qkg.5;
        Tue, 13 Nov 2018 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T2t5vzOSqDOk91wFmuQdsNFjj6Roz7TaDtVU5YSptrM=;
        b=ZBtiMNnsOEyD2HuMTsZ2vtwbyKRa79C3bgV2Ce12uGfe6LytoZ2iObCrULK1XJdFhN
         jqr79fZ4+PDyTlYjzwQTgouGr96/BphtEnyQTHl6z+YH3ALOyrcwdFQ+3ijJt1FUEu5u
         7QGt1EtcL2D5/181yAznDwWrjEEAcU8mu401kEGsrm940iilmkPH3tJvvdJxxpaap7BW
         YUd8MamVWB3rP6Go6yOxtiHmaYL7zkRh46abQ8MoB6XMlbipBk40OaO+JjcFqvFFMcHm
         4My6+RT650ym7X7dgZbAN+5vR+0Nl0acPaZXIlb0A3FgR9mMAAlFcFaFGit9+Vucu2MI
         NY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2t5vzOSqDOk91wFmuQdsNFjj6Roz7TaDtVU5YSptrM=;
        b=gAB0kIT8GBr8hDzx1UbapfNMAaX3TmxDM0X4Q3CLVzuglXBcFuM9TIAITmZZE7SAwM
         4zIUAJLfhiT95YIHDTPNWdCgvDBkIAH99BsANylfI5ZeL0POqCCYrbi38b+Rmsl2D4Zc
         RLuIK3q7ZkZRBDLpvS1vRglmCAiXvpSR3QlOlJx3PtQKCKHiS8mNS1AbQDEJ7HEn7POA
         cg1M9xoN9S3TZTRbnQi8+CSHVo3MEh/ZjHll8AYaTU5nfwFmU+6lFLaJhKrm6fhXNRCj
         p0vunYxqNFn6vFSaFga2V865kDD0G+DjH5Oxg/3r322SiRc966n4FcHCJIT4YkfxcL6r
         TtIA==
X-Gm-Message-State: AGRZ1gKD0TXeWyl5WM/A36GJk9cgav7NdbolPKdjmCdVs/sf1ClnCkG+
        J2zMzMn+vYLI7BXizDroYw==
X-Google-Smtp-Source: AJdET5cPLQrdg6e33KLKtoPHBc1KR3GQy+WDF98LxJ1FlHw0+ZjpkTFu6k1ovAo9f53jIUIv/HSFyg==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr5274501qtp.92.1542125479049;
        Tue, 13 Nov 2018 08:11:19 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j89sm11525815qkh.34.2018.11.13.08.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 08:11:18 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:11:11 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>, bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181113161111.6jwm36fpxk5xjtn5@gabell>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181112174343.mvjri2okwboew2nw@gabell>
 <20181113021218.GD7453@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113021218.GD7453@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao and Boris,

On Tue, Nov 13, 2018 at 10:12:18AM +0800, Chao Fan wrote:
> On Mon, Nov 12, 2018 at 12:43:44PM -0500, Masayoshi Mizuma wrote:
> >How about the following get_acpi_rsdp()...? It doesn't use kstrtoull().
> >
> >static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
> >{
> >#ifdef CONFIG_KEXEC
> >        unsigned long addr;
> >        char val[32];
> >
> >        if (cmdline_find_option("acpi_rsdp", val, sizeof(val)) > 0) {
> >                char *e;
> >
> >                if (!strncmp(val, "0x", 2)) {
> >                        addr = simple_strtoull(val + 2, &e, 16);
> >                        if ((addr == 0) || ((val + 2) == e))
> >                                return;
> >                        *rsdp_addr = (acpi_physical_address)addr;
> >                }
> >        }
> >#endif
> >}
> 
> Thanks for the suggestion.
> I used this function. In the old version, Boris said simple_strtoull()
> is the old function and told me use the new kstrtoull().

I think it's not very good idea to use kstrtoull() in
arch/x86/boot/compressed/* because some tricks are needed to
use the function, looks like Chao is trying...
It is the simple way here to use simple_strtoull() defined
in arch/x86/boot/boot.h, I think.

I know checkpatch.pl says an warning about simple_strtoull(),
however, I believe the warning is for simple_strtoull() defined
in lib/vsprintf.c.

Thanks,
Masa
