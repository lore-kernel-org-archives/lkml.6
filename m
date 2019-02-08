Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC73C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF82086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="LTW9Gy9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBHMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:42:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41896 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:42:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so3401295wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcNSWtz/94EAq7Zt0ztZtaogVS62SwmBQ8CLMNUPaIE=;
        b=LTW9Gy9VdLkzCaQ8/6LR1RN5CMBX4DNv4zx8Vt+n9WPe5s5U2j2SkWi9d6uJPlV/zx
         q2zfeEvtPuL0+gE773N8fRvWzd+7hhAGOqytTlwdAVErVEIm+4ioBVY8sc175wb7NQiV
         F8Ywgr5UzWMCXiEm92JA1qgPgSj1rA8WtsmdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcNSWtz/94EAq7Zt0ztZtaogVS62SwmBQ8CLMNUPaIE=;
        b=UBHVaioXlHrRwgOKH6FZ0fOdI1f4uTLOrKS69710JnTB+UQ+EpCGsQjhD0FivOHrZk
         2bcVmqxRwqTp7eAhUtJoXJQOxhp51bpfF+CpIBcLw5/qin9iW+FGSJlg3bz/renFsgTn
         QNHPQbJHZFiayobOIQgX02rGpvphsTWChAitDWktEocYnrpYG87xRXNmHyNChPXMmGbT
         NbgH07S7ttx5WGQGE2DNMWBypXaqvV4NFqlxVZ5+LmVt3Ss98CAP8Ace5cdz6XdguphT
         j2kN/VzewvKFgApTG9G3oebdPn8i9PNqVe016v9ERQuL8R/zxojqCPrdNJ6sg/zxa8DG
         05AA==
X-Gm-Message-State: AHQUAuYVn/u5lBLrh2o8PXxwFFPFaC71xcfgRh3amBckvDYUtmpvtCxf
        lNX6PvxHVTtzDhf+U0ITlNJbe0Sd5rB1b1uKMRlIww==
X-Google-Smtp-Source: AHgI3IaFmjXxGwVIVl/tppCIeLz9HYPH8Ihh1C5K04cAMhMPJi87YuzbKG67WoAepyYFp1mHlKOJKR7kpdPF70VdDj4=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16532537wrr.105.1549629737745;
 Fri, 08 Feb 2019 04:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:14:57 +0530
Message-ID: <CAFZiPx1esvy7uqAymR7oU+hXSAUwLbKgUo3dK3CoHSajsD41-A@mail.gmail.com>
Subject: Re: [PATCHv3 20/27] PCI: mobiveil: add Byte and Half-Word width
 register accessors
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

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> As there are some Byte and Half-Work width registers in PCIe
> configuration space, add Byte and Half-Word width register
> accessors.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 81685840b378..933c2f34bc52 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
>         return csr_read(pcie, off, 0x4);
>  }
>
> +static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
> +{
> +       return csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
> +{
> +       return csr_read(pcie, off, 0x1);
> +}
> +
>  static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
>  {
>         csr_write(pcie, val, off, 0x4);
>  }
>
> +static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +       csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +       csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
