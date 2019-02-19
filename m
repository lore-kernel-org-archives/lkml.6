Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6851BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4267F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfBSBep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:34:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730247AbfBSBeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:34:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DC58134B80DBC91AA33;
        Tue, 19 Feb 2019 09:34:42 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 09:34:35 +0800
CC:     <liuyu712@hisilicon.com>, <john.stultz@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>
Subject: Re: [PATCH v2 00/10] Add support for usb on Hikey960
To:     Valentin Schneider <valentin.schneider@arm.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <b1aca3d0-547a-51bd-5bff-69652484b6cc@arm.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <5e884818-7afe-e76c-a181-81d3b78f40bf@huawei.com>
Date:   Tue, 19 Feb 2019 09:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <b1aca3d0-547a-51bd-5bff-69652484b6cc@arm.com>
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

On 2019/2/19 1:30, Valentin Schneider wrote:
> Hi,
> 
> On 18/02/2019 11:23, Yu Chen wrote:
>> The patchset adds support for usb functionality of Hikey960, includes:
>> - dwc3 driver for Hisilicon Kirin Soc hi3660
>> - usb driver for HiKey960 board
>> - some adjustment in dwc3, usb gadget and typec driver
>> - dts for support usb of HiKey960
>>
> 
> I want to try this out on my HiKey960, but I can't get the USB A ports
> working (tried USB stick and USB eth adapter).
> 
> On top of the arm64 defconfig, I've enabled (with menuconfig):
> 
> 	CONFIG_PHY_HI3660_USB
> 	CONFIG_HISI_HIKEY_USB
> 
> Am I missing something? FYI up until now I've carried over Fan Ning's old
> USB patch-set and that works fine, so I think it might just be a
> configuration error from my end.

This patch set based on Heikki Krogerus's patches.
Have you applied https://do-db2.lkml.org/lkml/2019/2/13/106 first?
And these configs should be set to y:
	CONFIG_TYPEC
	CONFIG_TYPEC_TCPM
	CONFIG_TYPEC_TCPCI
	CONFIG_TYPEC_RT1711H

> 
> Thanks,
> Valentin
> 
> 
> 
> .
> 

Thanks,
Yu Chen

