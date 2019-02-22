Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AB520823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfBVHcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:32:42 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:18330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725824AbfBVHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:32:42 -0500
X-UUID: ce0137083c094382bb53c6894846ca8d-20190222
X-UUID: ce0137083c094382bb53c6894846ca8d-20190222
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1067774073; Fri, 22 Feb 2019 15:32:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 15:32:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Feb 2019 15:32:18 +0800
Message-ID: <1550820738.2210.39.camel@mhfsdcap03>
Subject: Re: [PATCH v2 08/10] hikey960: Support usb functionality of Hikey960
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chen Yu <chenyu56@huawei.com>
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Fri, 22 Feb 2019 15:32:18 +0800
In-Reply-To: <c02407b4-1825-83f5-2aff-dd41ae16e2ab@huawei.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
         <20190218112310.17860-9-chenyu56@huawei.com>
         <1550544615.2210.27.camel@mhfsdcap03>
         <c02407b4-1825-83f5-2aff-dd41ae16e2ab@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-19 at 11:20 +0800, Chen Yu wrote:
> Hi,
> 
> On 2019/2/19 10:50, Chunfeng Yun wrote:
> >> +	if (ret)
> >> +		hisi_hikey_usb->typec_vbus_enable_val = 1;
> >> +
> >> +	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
> >> +			hisi_hikey_usb->typec_vbus_enable_val ?
> >> +			GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
> >> +	if (!hisi_hikey_usb->typec_vbus)
> >> +		return -ENOENT;
> >> +	else if (IS_ERR(hisi_hikey_usb->typec_vbus))
> >> +		return PTR_ERR(hisi_hikey_usb->typec_vbus);
> >> +
> >> +	gpiod_direction_output(hisi_hikey_usb->typec_vbus,
> >> +			!hisi_hikey_usb->typec_vbus_enable_val);
> > maybe a simple way if use fixed regulator?
> > 
> The hardware of the Hikey960 board has been fixed, and the type-c
> port can act as UFP. So it is better to close the vbus when Hikey960
> connect to host(e.g PC).
I guess you misunderstand what I mean?
Please refer to bindings/regulator/fixed-regulator.txt
If you control vbus by gpio, you can use fixed-regulator, it will be
easy to make compatible with other cases, think about using a LDO to
control vbus
> >> +
> >> +	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch", GPIOD_IN);
> >> +	if (!hisi_hikey_usb->otg_switch)
> >> +		return -ENOENT;
> >> +	else if (IS_ERR(hisi_hikey_usb->otg_switch))
> >> +		return PTR_ERR(hisi_hikey_usb->otg_switch);
> >> +
> >> +	gpiod_direction_output(hisi_hikey_usb->otg_switch, USB_SWITCH_TO_HUB);
> >> +
> >> +	/* hub-vdd33-en is optional */
> >> +	hisi_hikey_usb->hub_vbus = devm_gpiod_get(dev, "hub-vdd33-en",
> >> +			GPIOD_OUT_LOW);
> >> +	if (IS_ERR(hisi_hikey_usb->hub_vbus))
> >> +		return PTR_ERR(hisi_hikey_usb->hub_vbus);
> >> +
> >> +	gpiod_direction_output(hisi_hikey_usb->hub_vbus, HUB_VBUS_POWER_ON);
> > ditto
> >> +
> >> +	hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
> >> +	if (!hisi_hikey_usb->role_sw)
> >> +		return -EPROBE_DEFER;
> >> +	else if (IS_ERR(hisi_hikey_usb->role_sw))
> >> +		return PTR_ERR(hisi_hikey_usb->role_sw);
> >> +
> 
> Thanks
> Yu Chen
> 


