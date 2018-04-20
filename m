Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-990390-1524210397-2-11207752521764290812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524210396; b=lDLEoJK7s7jSd+eoxtCGJ4gharSXU1xOrRZ+6snVIPQHtxmrLG
    qrE6E/FMbgfjDgeOEC687CfJQjucdUxLDDDxSbO8dStDFgHmJCSWjRacBgEZROAM
    Bm1Jp69pa/oqL4ac7CvT5Jx/IUN6GR167k0k5PZzLlW9OO0OD41ipkYOlloeHLp5
    Sm3p3AYTlsg+lCm1kbgH7UcXwyY59Gl3yMYH4D4AQXQ9wj13NIckh5X6X5zQaEEv
    oyyb3YWjjO2JJ3M6cYLeb1DXk073VmKumCoUpt8AKtOfDiVPSpXx4tO9Zpf4UJmm
    LlppkDkv+FW0W8/+kMeASNbwCLSi61nnFoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524210396; bh=o51+anHjus
    7rVpMq7pqCm8IDX76kW2yR8LBUZFEfE9Q=; b=ry9yFvD+wL+VZWNtOXckv4s7nc
    YHk+2nWNNne5A1XkPrXcx49m4mffEAmBJ3YJHWDqrWNqS7H9vnj1VyTjGHspXzB/
    2t7o66JH+TjBuKAv4DgPHrYG9aTGJhtBbhEHLc6iqXND1v2Jw+vk9DcbaOnFQ3PJ
    6SeuiyYbYwI5C7nHJSVk2lrOiivivoObkCyqp6pbbOE9IGzWHLFs5WBmhbsKhuMl
    vs6MrPdfJRSCme363nw7aFrVhYID5PWsokxah3i1GNy+1vmwcrxALWDjrMme3DHq
    LURz6CM94/ZBwg3E3DCdONA+bPAepnpwxtMgNV53coHgbvMhvRj9Zm0HLVBA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHy6BDzOBv/WYTZtYfVDcz8u03eMDcu6ngbR+lmVn2KsiPpebdRVPELGLjULoXk/xUMGD9NqsPL9IQLMCz1ba0ziCLWDaHI8uUghOZJAv0ty01bIVT6b
    PsAbGtTC6boinSsbxPA6k3H8D5jI5d7zVuvb5IaVTiSXcDsj5CDyeQDq/TpwnPnJP2VMpXb7e7jylhtsB1krXCeRhWXB65SIij5vUxhsOFyojOAHxqjEmjlO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LDBv8-xUAAAA:8 a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=v-Wz_vH9cs9CTqFaDe4A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=DZeXCJrVpAJBw65Qk4Ds:22
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeDTHqe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 03:46:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753620AbeDTHqc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 20 Apr 2018 03:46:32 -0400
X-UUID: e41ed9a2e8364901b10c5eb53fdcc5c5-20180420
Message-ID: <1524210384.25162.1.camel@mhfsdcap03>
Subject: Re: [PATCH 55/61] usb: mtu3: simplify getting .drvdata
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Fri, 20 Apr 2018 15:46:24 +0800
In-Reply-To: <20180419140641.27926-56-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
         <20180419140641.27926-56-wsa+renesas@sang-engineering.com>
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

On Thu, 2018-04-19 at 16:06 +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/usb/mtu3/mtu3_plat.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 628d5ce356ca..46551f6d16fd 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -447,8 +447,7 @@ static int mtu3_remove(struct platform_device *pdev)
>   */
>  static int __maybe_unused mtu3_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
> +	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> @@ -466,8 +465,7 @@ static int __maybe_unused mtu3_suspend(struct device *dev)
>  
>  static int __maybe_unused mtu3_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
> +	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
>  	int ret;
>  
>  	dev_dbg(dev, "%s\n", __func__);

Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks



