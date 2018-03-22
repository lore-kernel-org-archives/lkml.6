Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2215319-1521706355-2-10464309339883444482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521706355; b=QIYCnDWv+RsVhDoZakz1/Rr68omseXffkGGYms/U+zTqkgO
    ndJ1fDiAErfjyF8SMH/hKN3j1EN4xYvG65R5NCqIY4WcptZQHBznbhGY0b1wxTTj
    VF+CzSjjkkaFtvKaGSfyBt+xpXOviqHfpCb2HoHC0B9cn/YCKpIt/4mkkCzndrZH
    x/NltALHA9XV+WH/0lAvo/R26WR3dCVQ2Uf34od0lhM5D6bR7UC/y5sLrDwhMz7+
    f2/BO/bqIqlM2l6uifzjCSiJFmkpL8ZwODJqFfUQQuFNanEVOCPaG4Lxwslkb0em
    u6ueHzCkbA1JGNTu9RimLjqjtSGZmZX4mwSemAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521706355; bh=MnidoV
    EL4ehdnj0a2wnIyKwWhGind11kCullvhsh14M=; b=ZvXf0u+3QJFU4zh2/kJcbd
    36esfcYIzaQzD0D7FaWZbfXNohu0eDi7HaWlbW1kYUDvEJVtioH3/2mo3gPVhYid
    TU4hAV5fvBBtrSrT9YktGVRbrVdd/qSqmnYGUVXEDXAjrd5xHIEUJchJRuJxYbMZ
    G6OXW1RLbPtmzQsHa/Fmo7EGxjUpWHm5xw+AYeo+x4hAmtvZ2WJNWJ47R5uzpK2q
    EqLEHDAs0zvSyGrlZQuS6i2hVLzufUCTcHC5vcdffh5dYWjRlByLonYAznjIuMly
    LLNM/HtWSb+iq8lVPeiRdS6f4He2bA0fgECtm9Uldjr+qyEVorNTJCfB9LJtudqg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCVIM0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 04:12:26 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11982 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752493AbeCVIMY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 04:12:24 -0400
X-UUID: d18f9537c6f64f51bea17d148d4d6f58-20180322
Message-ID: <1521706339.3717.141.camel@mhfsdcap03>
Subject: Re: [usb-next PATCH] usb: xhci: skip phys initialization of shared
 hcd
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Roger Quadros <rogerq@ti.com>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 22 Mar 2018 16:12:19 +0800
In-Reply-To: <99d5db89-0ba3-84df-5238-6edd6a3d99a1@ti.com>
References: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
         <ae71fdae-43aa-9df3-3f81-8a92460d61b9@ti.com>
         <1521633020.3717.128.camel@mhfsdcap03>
         <99d5db89-0ba3-84df-5238-6edd6a3d99a1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hi,

On Wed, 2018-03-21 at 14:27 +0200, Roger Quadros wrote:
> On 21/03/18 13:50, Chunfeng Yun wrote:
> > Hi Roger,
> > 
> > On Wed, 2018-03-21 at 11:05 +0200, Roger Quadros wrote:
> >> Hi Chunfeng,
> >>
> >> On 21/03/18 08:12, Chunfeng Yun wrote:
> >>> The phys has already been initialized when add primary hcd,
> >>> including usb2 phys and usb3 phys also if exist, so needn't
> >>> re-parse "phys" property again.
> >>>
> >>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >>> ---
> >>>  drivers/usb/host/xhci-mtk.c  | 1 +
> >>>  drivers/usb/host/xhci-plat.c | 1 +
> >>>  2 files changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> >>> index 7334da9..6bb23fb 100644
> >>> --- a/drivers/usb/host/xhci-mtk.c
> >>> +++ b/drivers/usb/host/xhci-mtk.c
> >>> @@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> >>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> >>>  		xhci->shared_hcd->can_do_streams = 1;
> >>>  
> >>> +	xhci->shared_hcd->skip_phy_initialization = 1;
> >>>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> >>>  	if (ret)
> >>>  		goto dealloc_usb2_hcd;
> >>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> >>> index 6700e5e..65a4294 100644
> >>> --- a/drivers/usb/host/xhci-plat.c
> >>> +++ b/drivers/usb/host/xhci-plat.c
> >>> @@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> >>>  		xhci->shared_hcd->can_do_streams = 1;
> >>>  
> >>> +	xhci->shared_hcd->skip_phy_initialization = 1;
> >>
> >> I think this is unnecessary.
> >> There aren't separate PHYs for the primary and shared HCDs right?
> > Yes, the primary and shared HCDs will get the same PHYs provided by
> > "phys" property.
> > 
> >>
> >> Also how can you be sure that phy_init() has been done for all platform HCD users?
> > Here I assume that "phys" and "usb-phy" properties are not used at the
> > same time. There are two cases:
> > 1. Using "usb-phy": no "phys" to be got by shared HCD.
> > 2. Using "phys": the primary HCD will get those phys, so shared HCD can
> > skip them.
> 
> Now I see the problem.
> But the right fix should be in core/hcd.c
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 2884607..1d1da12 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  		}
>  	}
>  
> -	if (!hcd->skip_phy_initialization) {
> +	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
It's a better way.
Thanks
>  		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
>  		if (IS_ERR(hcd->phy_roothub)) {
>  			retval = PTR_ERR(hcd->phy_roothub);
> 
> > 
> >>
> >>>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> >>>  	if (ret)
> >>>  		goto dealloc_usb2_hcd;
> >>>
> >>
> > 
> > 
> 


