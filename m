Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB1FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECE82154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECE82154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbeIUHTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:19:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbeIUHTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:19:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC4E49E1DB295;
        Fri, 21 Sep 2018 09:33:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 09:33:26 +0800
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
To:     David Miller <davem@davemloft.net>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920.085055.1188796939437872993.davem@davemloft.net>
CC:     <dmitry.tarnyagin@lockless.no>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <michal.simek@xilinx.com>,
        <hsweeten@visionengravers.com>, <madalin.bucur@nxp.com>,
        <pantelis.antoniou@gmail.com>, <claudiu.manoil@nxp.com>,
        <leoyang.li@nxp.com>, <linux@armlinux.org.uk>, <sammy@sammy.net>,
        <ralf@linux-mips.org>, <nico@fluxnic.net>,
        <steve.glendinning@shawell.net>, <f.fainelli@gmail.com>,
        <grygorii.strashko@ti.com>, <w-kwok2@ti.com>,
        <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <83d29681-b008-9b1f-5961-e23f0174d5f4@huawei.com>
Date:   Fri, 21 Sep 2018 09:33:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180920.085055.1188796939437872993.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 23:50, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Thu, 20 Sep 2018 20:32:44 +0800
> 
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, so make sure the implementation in
>> this driver has returns 'netdev_tx_t' value, and change the function
>> return type to netdev_tx_t.
> 
> I would advise you not to send so many of these changes as a group.
> 
> If one of the patches needs feedback addressed, which is already the
> case, you will have to resubmit the entire series all over again with
> the fixes.
> 

Yes, I will send it separately after test and review again.

Thank you for your advice.

> .
> 

