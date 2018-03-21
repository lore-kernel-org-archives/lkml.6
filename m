Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3497624-1521623163-2-16598961571566542750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623162; b=KjlEAzy65kKXrQEuUZ51IoEN7zsbqv/zyiaOBKKb0mJFQlj
    7SLarhK8tbCzZDpUhAN/aYMbapt7bRX09GWxEMH3M1RsmeoZS2+ZchXRVyg9emWF
    6/cY0oL7VaaU6qjeECDAo98I8x+ec5CPrSiNQDGOkrYolNstECV7LGz7p7KAnp/e
    Vxh6cFB//ORQM9RLOp7w7QDgFHMB5WZ+WPqsfF2xi82LhnjbpDhgRoGd2C/yX01+
    /ANH491V0nw54MvdUKiJFX/3ug+IRw/sBF302BtGxIFvE6DqzB/kvh2yEC0dDrHA
    4o8gIhZhcASwABsXriskOUUAjwwPOmiIBiqfMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521623162; bh=TNIiQZC5BFV4quc56TE1cQhTXWfTOgf7UKQWjDl79R8=; b=u
    O2CEW6VseDVMqAAxDmqt7HREN+8+0n/feF2KBbQqBskN3/gBv5X+q2/cpFYLudmV
    +Oas/9SgbxnmjMwG+RRmVNUKFsEwVi80LzQI6e7eefCGZx3cbMwCXAIB+5BlCy18
    hb4xZgVt1K2syHbm20qk0q0NYHPbZhbOVN50P1+qrOzbmS10tDMfjgypJ3FDTgIx
    AhImAYyOzQjsPdfau04X3Kiy3J5J6EMpHh67pF3y589ocsRUIWQAZu66FCIcoZNL
    Pn2GNxpMGxaMxaQfSgJcG1v3O9ZredJ+GHs5bnGiN2G6DCZnV87T3mopVwbAi6Jd
    6ztswx3nlFPlO1KW/Z39Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=hkfWReIz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=hkfWReIz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCUJFu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:05:50 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:51683 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeCUJFq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Mar 2018 05:05:46 -0400
Subject: Re: [usb-next PATCH] usb: xhci: skip phys initialization of shared
 hcd
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <ae71fdae-43aa-9df3-3f81-8a92460d61b9@ti.com>
Date: Wed, 21 Mar 2018 11:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chunfeng,

On 21/03/18 08:12, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk.c  | 1 +
>  drivers/usb/host/xhci-plat.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 7334da9..6bb23fb 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>  		xhci->shared_hcd->can_do_streams = 1;
>  
> +	xhci->shared_hcd->skip_phy_initialization = 1;
>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>  	if (ret)
>  		goto dealloc_usb2_hcd;
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 6700e5e..65a4294 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>  		xhci->shared_hcd->can_do_streams = 1;
>  
> +	xhci->shared_hcd->skip_phy_initialization = 1;

I think this is unnecessary.
There aren't separate PHYs for the primary and shared HCDs right?

Also how can you be sure that phy_init() has been done for all platform HCD users?

>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>  	if (ret)
>  		goto dealloc_usb2_hcd;
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
