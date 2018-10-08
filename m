Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC1C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A37D20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwDuWi1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A37D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJHSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:07:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32942 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:06:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so20425901qte.0;
        Mon, 08 Oct 2018 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsQchzbGLRE68nGUEMCPC60hFY9w/QJ/gEMhfj6FOYM=;
        b=kwDuWi1KQJZLiAbno9lcQkoFM5Pq0ZyhgtKkxxHgO8hGIA1BHY9UN2HUCfJso3/Xuy
         WTOgqPs307HWttu2zGlbglRdFMtBT8EYZh7nGnmyVta2Tci647vdXzxIp9mwRxTsD00k
         gI5fKTyAgVk4sWwaoTmdjdO6muhjTOMkbZU3yDaxcQ84l0Kk5O1FDcduwwQ7lZuqqaSp
         FAAwHSidd4AoR3jrw+To+vZh/wLELhOYEkojOMR96+PgFdLxpDUH2Qh1xIXvz3jjOyar
         TDlur3JLCv1HBTZDjZcpCk1zWaJwr83qA162djq3FBZDwitAoneacGQLosQUYxdslnl6
         4akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsQchzbGLRE68nGUEMCPC60hFY9w/QJ/gEMhfj6FOYM=;
        b=Z1Zh2T0/e5oirkTarPhbPxOBAD0G068JnvyfMq9Z+wF38VBVZvT+od9gEjJr2eRyb+
         JddjfDQIrkQvrgQOheqYeHMDotyI1O/iUytkb8CPVqgXGNczAD1DHBtILmav51BIPunQ
         6FVjtMGiTRAZ37zU5sEsoX62pMLRt10S4KkrHoWieoUS225FthaWda66n8cdJAib2Kp3
         2/xk3cbpSIu0zXHFGv5+7OLib0ze+GATjmGDAwNW2J8qTaJxpPEFHjrszDXjYv2U5iSm
         Max5IBNJtwQOZfRs36r+AOfMY1wITeR4lkTUoH5+MLYfxPRxWKAwiwLl/0nbzK6BWS6J
         ROvw==
X-Gm-Message-State: ABuFfoislqytA1LE6r8PlBiedQFExxln2HmsDJr1SOPIp6QEPAX3tGXc
        VDoMGCR8dPZ5JE9hY4UI6jmasOn66F8KEy14WTA=
X-Google-Smtp-Source: ACcGV61qtHv9ZhgHuT7X/zZUSf2bjuN2ftH0ssBAJr8BozefLY62ycugpxGJxW7+Taf3BgC8AW0MdoyOkLnb32GL/BQ=
X-Received: by 2002:aed:2684:: with SMTP id q4-v6mr4028911qtd.293.1538996150721;
 Mon, 08 Oct 2018 03:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181008144438.53e6fdbc@canb.auug.org.au>
In-Reply-To: <20181008144438.53e6fdbc@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Oct 2018 13:55:39 +0300
Message-ID: <CAHp75Vc3yT9ut1yJtME_NCkjL8mxUdp_by9q=YxjwcS+D+GHoQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with the tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:44 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drivers-x86 tree got a conflict in:
>
>   drivers/platform/x86/intel_int0002_vgpio.c
>
> between commit:
>
>   f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")
>
> from the tip tree and commit:
>
>   96402de65afc ("platform/x86: intel_int0002_vgpio: Enable the driver on Bay Trail platforms")
>
> from the drivers-x86 tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

Looks good to me!

> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/platform/x86/intel_int0002_vgpio.c
> index e89ad4964dc1,c958a628c375..000000000000
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@@ -57,11 -54,7 +54,7 @@@
>   #define ICPU(model)   { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
>
>   static const struct x86_cpu_id int0002_cpu_ids[] = {
> - /*
> -  * Limit ourselves to Cherry Trail for now, until testing shows we
> -  * need to handle the INT0002 device on Baytrail too.
> -  *    ICPU(INTEL_FAM6_ATOM_SILVERMONT),        * Valleyview, Bay Trail *
> -  */
>  -      ICPU(INTEL_FAM6_ATOM_SILVERMONT1),      /* Valleyview, Bay Trail  */
> ++      ICPU(INTEL_FAM6_ATOM_SILVERMONT),       /* Valleyview, Bay Trail  */
>         ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
>         {}
>   };



-- 
With Best Regards,
Andy Shevchenko
