Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EEEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD712083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="SRE815C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBEGFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:05:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39548 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEGFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:05:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so2281220wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R58VXnmcQsUtQ66r5EJzM8NXDWdDZjbuPCSxVpk2C04=;
        b=SRE815C4N3sktm3vi9fx669wnGcjRJT9I7x1DlNmRwortUl/zUl0f6xdrnjuamG0lJ
         V+w/NRC2xDQ838y/irmlvhp1kG+5Fpiy2d2IKKMNXjoxY37/f2f1gwm+JAc4dDGdSKBo
         K1p5gkLFxZ73jk7SP0Mv349nWkqfkRcDOdamk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R58VXnmcQsUtQ66r5EJzM8NXDWdDZjbuPCSxVpk2C04=;
        b=qoApHiFePQP8FhNMIn5B8wxSaUW+dRSwE8yCIn/KpOTDRNzO+15YH9RVgME6ccE2bq
         aOgN7v+DAkSviELSCP9ghSuxXJ7zqfgKeGo8ITzW9LPeRQNExdZu1D5wI1/f7Qv8djXo
         guw+Guri7jNrPVp2rDMA/H9EwVmRpFOGBsdyhz8iPcrbNI94FBouWVF3XODkFusif9Z2
         JQkU8xLNW/PgWfF1MxEZGA7d2j4VmJF4ZVzeYlgAkFx/4DxmYzqBF3Z1JLlQFenaUKHh
         h4LszPmw+slsE8IZrdVy0Hj5rcqamRHtZcEY7HtvU0I7bXUHx9XsomsH22LrvvNkl2rO
         JqeQ==
X-Gm-Message-State: AHQUAuY1EetNGvqkZfaDk42g+/x7FaFgTx91mdlHVdyUBC1fIjxaNkM3
        EAYPtcdljTSmKTaBKRTttl1cagrqvYhH2suLgdR64yG6p3DnuA==
X-Google-Smtp-Source: AHgI3IYdRky9neI+cisyum0AuGIDv/vJG5HiERzlGTNDOxIyK8MM4wPBtU8pcm7t4qEqVmdBSe+Hu5fzkT9sVsunRew=
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr2253821wme.143.1549346729826;
 Mon, 04 Feb 2019 22:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-8-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-8-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:38:03 +0530
Message-ID: <CAFZiPx3soEXCKixiix=L+Bvy2-V2rqvxdHEeYDgdnnra+AMq4g@mail.gmail.com>
Subject: Re: [PATCHv3 07/27] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> As the .map_bus() use the WIN_NUM_0 for CFG transactions,
> it's better passing WIN_NUM_0 explicitly when initialize
> the CFG outbound window.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index b2cc9c097fc9..df71c11b4810 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>          */
>
>         /* config outbound translation window */
> -       program_ob_windows(pcie, pcie->ob_wins_configured,
> -                          pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
> -                          resource_size(pcie->ob_io_res));
> +       program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
> +                          CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>
>         /* memory inbound translation window */
>         program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> --
> 2.17.1
>
