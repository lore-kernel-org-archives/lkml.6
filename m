Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146220652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI2CiSZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfBYVpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:45:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45517 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731977AbfBYV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so9183700ota.12;
        Mon, 25 Feb 2019 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rb+eDoBH0SrelCIC05TgS2WqSH0NV9BVc4IXF5AAKxg=;
        b=KI2CiSZiWXBzwzcSLcV/d5zr1+t4fsbzqyPQNyQy25wu43OMfFCieGbbYbXgTLskRC
         PghCwuqPj5LgGoBqq2R2FAud7qGQQ1gjPBmZbNEQeQ1XNTmo+CAkp6PXABH45CDSXGS7
         N0lJ/BVg+CAbT7pJ41BF2Wzq6oJ1aUfmEoILoK0mqtjJA009Y2fYhVDkudnKlUjAfpGj
         fDHCiZDp7XWwHkPTNfYpc13mSGCXu6e8a801bdMOm+kr7XKZBBHxUH2m0Eecp/BH6W2Q
         sCW9RjOjviK8ZTOLuwjekKHbIUMSydlmqYUyhJDul+qOCHuNb+EN5qtwQOJWEB95v2IR
         KH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rb+eDoBH0SrelCIC05TgS2WqSH0NV9BVc4IXF5AAKxg=;
        b=lw5pVVizOEh511nUAVkHSBeDYsFzLyrW7yU0Xv5STEbGzffQGJWiXqBZV/22sSUnJL
         Od1OyQUA7ZEFxSUMjnSPQhEemilVsKNf9TCjeSDU0J6hBMNovTk+m7WV5tdHT/U/M/em
         k/Cz5GHQ0Fh0AXj3bZkxUFFc+IJShUGUTACq4Dp7Wg8SX7Z9Okkw9cG2LM2O7oEGKLF9
         9NTRwTMP3OJRAR+4RGDVN2R2SPD8+sT1KtkuMHu8LULnXUALSiZqdU3fj0f3kieJ5Ofq
         +Flfq1g3h3I+7jHsUqdokvdt+uPgWsiAkxs8xTe+98cWHKnKEzqGFPPtYF699lMgDlVs
         btcg==
X-Gm-Message-State: AHQUAuaQAk8XP2YsawvsrsXR0Eot2/bidZP02TK4H5CwHeZFxFnV37aQ
        fPiuk9T3PprMKCx9lAvDCQALZOLpazcSDxWupwk=
X-Google-Smtp-Source: AHgI3IYrqfogaM4IICgdZxUC4Ns2r6T5prGGdapuqgVjWo67IWOCQfh6yx8Q6B/Qy1heRXny52sz4DcM51SHlQhHttM=
X-Received: by 2002:a9d:4708:: with SMTP id a8mr12475228otf.51.1551130147930;
 Mon, 25 Feb 2019 13:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20190219072358.43493-1-ran.wang_1@nxp.com> <20190219072358.43493-2-ran.wang_1@nxp.com>
In-Reply-To: <20190219072358.43493-2-ran.wang_1@nxp.com>
From:   Yang Li <pku.leo@gmail.com>
Date:   Mon, 25 Feb 2019 15:28:56 -0600
Message-ID: <CADRPPNSxYqCcRR9nLBodJydn=kCdERnX26_7zq_cvfGrZBRWcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 1:24 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will be turned on immediately on related Root Hub
> ports. Then, the VBUS is turned off for a little while(15us) when do xhci
> reset (conducted by xhci driver) and back to normal finally, we can
> observe a negative glitch of related signal happen.
>
> This VBUS glitch might cause some USB devices enumeration fail if kernel
> boot with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
> /LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
> 4GB USB2.0 drives. The fail cases include enumerated as full-speed device
> or report wrong device descriptor, etc.
>
> One SW workaround which can fix this is by programing all xhci PORTSC[PP]
> to 0 to turn off VBUS immediately after setting host mode in DWC3 driver
> (per signal measurement result, it will be too late to do it in
> xhci-plat.c or xhci.c). Then, after xhci reset complete in xhci driver,
> PORTSC[PP]s' value will back to 1 automatically and VBUS on at that time,
> no glitch happen and normal enumeration process has no impact.
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - Rename related property to 'snps,host-vbus-glitches'
>   - Rename related dwc member to 'host_vbus_glitches'
>   - Add member 'host_vbus_glitches' description in 'dwc3'
>
>  drivers/usb/dwc3/core.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |   12 +++++++++++-
>  2 files changed, 58 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a1b126f..02d11bc 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -100,6 +100,41 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>         return 0;
>  }
>
> +/*
> + * dwc3_power_of_all_roothub_ports - Power off all Root hub ports
> + * @dwc3: Pointer to our controller context structure
> + */
> +static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
> +{
> +       int i, port_num;
> +       u32 reg, op_regs_base, offset;
> +       void __iomem            *xhci_regs;
> +
> +       /* xhci regs is not mapped yet, do it temperary here */
> +       if (dwc->xhci_resources[0].start) {
> +               xhci_regs = ioremap(dwc->xhci_resources[0].start,
> +                               DWC3_XHCI_REGS_END);
> +               if (IS_ERR(xhci_regs)) {
> +                       dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
> +                       return;
> +               }
> +
> +               op_regs_base = HC_LENGTH(readl(xhci_regs));
> +               reg = readl(xhci_regs + XHCI_HCSPARAMS1);
> +               port_num = HCS_MAX_PORTS(reg);
> +
> +               for (i = 1; i <= port_num; i++) {
> +                       offset = op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);

Define the 0x10 as macro?  And why don't you have the initial value of
i loop to be 0 to avoid the (i-1) here?

> +                       reg = readl(xhci_regs + offset);
> +                       reg &= ~PORT_POWER;
> +                       writel(reg, xhci_regs + offset);
> +               }
> +
> +               iounmap(xhci_regs);
> +       } else
> +               dev_err(dwc->dev, "xhci base reg invalid\n");
> +}
> +
>  void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  {
>         u32 reg;
> @@ -109,6 +144,15 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>         reg |= DWC3_GCTL_PRTCAPDIR(mode);
>         dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>
> +       /*
> +        * We have to power off all Root hub ports immediately after DWC3 set
> +        * to host mode to avoid VBUS glitch happen when xhci get reset later.
> +        */
> +       if (dwc->host_vbus_glitches) {
> +               if (mode == DWC3_GCTL_PRTCAP_HOST)
> +                       dwc3_power_off_all_roothub_ports(dwc);
> +       }
> +
>         dwc->current_dr_role = mode;
>  }
>
> @@ -1306,6 +1350,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>         dwc->dis_metastability_quirk = device_property_read_bool(dev,
>                                 "snps,dis_metastability_quirk");
>
> +       dwc->host_vbus_glitches = device_property_read_bool(dev,
> +                               "snps,host-vbus-glitches");
> +
>         dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>         dwc->tx_de_emphasis = tx_de_emphasis;
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index df87641..9b3a7ed 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -606,6 +606,14 @@
>  #define DWC3_OSTS_VBUSVLD              BIT(1)
>  #define DWC3_OSTS_CONIDSTS             BIT(0)
>
> +/* Partial XHCI Register and Bit fields for quirk */
> +#define XHCI_HCSPARAMS1                0x4
> +#define XHCI_PORTSC_BASE       0x400
> +#define PORT_POWER                     (1 << 9)
> +#define HCS_MAX_PORTS(p)       (((p) >> 24) & 0x7f)
> +#define XHCI_HC_LENGTH(p)      (((p)>>00)&0x00ff)
> +#define HC_LENGTH(p)           XHCI_HC_LENGTH(p)
> +
>  /* Structures */
>
>  struct dwc3_trb;
> @@ -1024,6 +1032,8 @@ struct dwc3_scratchpad_array {
>   *     2       - No de-emphasis
>   *     3       - Reserved
>   * @dis_metastability_quirk: set to disable metastability quirk.
> + * @host-vbus-glitches: set to avoid vbus glitch during
> + *                      xhci reset.
>   * @imod_interval: set the interrupt moderation interval in 250ns
>   *                 increments or 0 to disable.
>   */
> @@ -1209,6 +1219,7 @@ struct dwc3 {
>         unsigned                tx_de_emphasis:2;
>
>         unsigned                dis_metastability_quirk:1;
> +       unsigned                host_vbus_glitches:1;
>
>         u16                     imod_interval;
>  };
> @@ -1217,7 +1228,6 @@ struct dwc3 {
>  #define INCRX_UNDEF_LENGTH_BURST_MODE 1
>
>  #define work_to_dwc(w)         (container_of((w), struct dwc3, drd_work))
> -

No need to remove the new line here.

>  /* -------------------------------------------------------------------------- */
>
>  struct dwc3_event_type {
> --
> 1.7.1
>


-- 
- Leo
