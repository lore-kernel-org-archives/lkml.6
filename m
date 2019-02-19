Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A752147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfBSDzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:55:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfBSDzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:55:48 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BDEE2F09CBD2DE91B58D;
        Tue, 19 Feb 2019 11:55:42 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 11:55:33 +0800
CC:     <liuyu712@hisilicon.com>, Rob Herring <robh@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Binghui Wang" <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-2-chenyu56@huawei.com> <20190218201824.GA23724@bogus>
 <a944cd27-f7d5-eece-1ef5-c7dc5dbc311b@huawei.com>
 <1550545405.2210.30.camel@mhfsdcap03>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <5ee91d42-ab9d-1bd2-d39e-8af4d69a5c19@huawei.com>
Date:   Tue, 19 Feb 2019 11:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1550545405.2210.30.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/2/19 11:03, Chunfeng Yun wrote:
>>>> +
>>>> +Example:
>>>> +	usb-phy {
>>>> +		compatible = "hisilicon,hi3660-usb-phy";
>>>> +		#phy-cells = <0>;
>>>> +		hisilicon,pericrg-syscon = <&crg_ctrl>;
>>>> +		hisilicon,pctrl-syscon = <&pctrl>;
>>>> +		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
>>>
>>> Are most of the registers within one of these blocks? If so, make this 
>>> node a child of that node.
>> I met a problem when I made this node a child of the syscon node,
>> the driver "phy-hi3660-usb3" was not probed.
>> Do you have any idea about how to make it probed when it is a child node?
> call of_platform_populate() in parent node's driver,
> but I don't know whether it's a standard way
Yes, this function is used in dwc3 driver to probe the child node.
But I think it is not a good way to modify the syscon driver.
>>>
>>>> +		hisilicon,eye-diagram-param = <0x22466e4>;
>>>> +	};
>>>> -- 
>>>> 2.15.0-rc2
>>>>

Thanks
Yu Chen

