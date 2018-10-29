Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A989920827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMecPuiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A989920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeJ2SXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:23:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33733 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbeJ2SW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:22:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id i15-v6so8407559qtr.0;
        Mon, 29 Oct 2018 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoqYs6NSAhfLeJtb581/UsPM1PbQQwbB0IuK1vc27Uw=;
        b=iMecPuiJ2pRCandJJyDoxaHbW60FH0rB4pXfl3JmI1AgXIGDka6BQsPTSC84tVDK3r
         752Lww2fKCbxG0+W71Am28ztviWZ4SEx00GPZi0HwKKLWrnYue/JE0WMZYSkyVVgEivO
         FBHpwbLFaMJyAtZ4q3WmJVli68egHUKFp2BjAA4AK5ZUTNF6BC2MC3XMHmibgbwS9DcD
         QZTFSA9TpaaFUwk8jThY0/eD82q8hPPi/4VqM7z6ez6rTb7DnnUF7D58wCXKtSm9yzE/
         Em+wtYUD4UK+a5nJ3llZO7UmM14W7Nnyoei/uEvuDpKKrVxJj9vec3gLR8loVkwz4ueH
         71Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoqYs6NSAhfLeJtb581/UsPM1PbQQwbB0IuK1vc27Uw=;
        b=RT+3D7Jx1zoKkpUz7RcLJxAglVX/Y/lEb4LqObsFnnkuC/4uJkYmwU9VDSCaLYHPu6
         00vRuvzDX2wESBXCkAgdAKk4ayhfV0nC/lcQax2aNNH7hGhMID3SBh4ctHISPPVMwnQP
         g41do6oRhsOwLU0jFqKeHgXWdPv7XA1sOfYMsNplWeEIKgVVe+PT6G8P91H9UU1qWzb4
         gaT9wrBicT+hTyU2qSnoDlG2P1ZQl6SbaVf3yCF79BRajDUZc4PiJqWiQb0WPaJK+kKd
         XLRSSx3OrgXQKWlvd0jDVLa5mH5fDtX0hvJzF3V5vr+GdBUzeK7Sl02XL+40SZafSL5+
         wtzw==
X-Gm-Message-State: AGRZ1gJWLoueBA85wEIsUw7ju4NMKNtzpvmveduUZypHbub/9JdJZAG1
        buNmkCmSbQ7U3v83PhEVCy6+gJkrCQYIiOVDRhw=
X-Google-Smtp-Source: AJdET5fGB6uW0ps/TqH1JrKkCLB75vMo9s20VdYJXfWNP3K8p0HuasAbhsSWfwEWm235VFIl2xgJPSM1itZrCAAvCRY=
X-Received: by 2002:aed:3e56:: with SMTP id m22-v6mr2768336qtf.99.1540805708176;
 Mon, 29 Oct 2018 02:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181029142907.54af8715@canb.auug.org.au>
In-Reply-To: <20181029142907.54af8715@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 11:34:56 +0200
Message-ID: <CAHp75Vfcsq_+vE8fH2EsPnEnyPbf6DqYE0m=oJH0_bHHV=y_EQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 5:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drivers-x86 tree got a conflict in:
>
>   drivers/platform/x86/intel_telemetry_debugfs.c
>
> between commit:
>
>   f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")
>
> from Linus' tree and commit:
>
>   1a7938a632ce ("platform/x86: intel_telemetry: Get rid of custom macro")
>
> from the drivers-x86 tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks!
This looks correct to me.

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/platform/x86/intel_telemetry_debugfs.c
> index cee08f236292,30988e31c713..000000000000
> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> @@@ -319,8 -308,8 +308,8 @@@ static struct telemetry_debugfs_conf te
>   };
>
>   static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
> -       TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_debugfs_conf),
> -       TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
> +       INTEL_CPU_FAM6(ATOM_GOLDMONT, telem_apl_debugfs_conf),
>  -      INTEL_CPU_FAM6(ATOM_GEMINI_LAKE, telem_apl_debugfs_conf),
> ++      INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
>         {}
>   };
>


-- 
With Best Regards,
Andy Shevchenko
