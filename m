Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C4ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154D520651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154D520651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJWLyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:54:44 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:52332 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWLyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:54:44 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.201])
        by lucky1.263xmail.com (Postfix) with ESMTP id C37729A2;
        Tue, 23 Oct 2018 11:33:16 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.36] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id C070638A;
        Tue, 23 Oct 2018 11:33:12 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: tony.xie@rock-chips.com
X-FST-TO: tony.xie@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: tony.xie@rock-chips.com
X-UNIQUE-TAG: <83ab091dd92a5e2cc69e9106708cacb4>
X-ATTACHMENT-NUM: 0
X-SENDER: xxx@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.36] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 21656V2NIDM;
        Tue, 23 Oct 2018 11:33:16 +0800 (CST)
Subject: Re: [PATCH v4 1/5] mfd: rk808: Add RK817 and RK809 support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
 <20180911123907.GN4185@dell>
From:   tony <tony.xie@rock-chips.com>
Message-ID: <219a9cdd-00d7-2920-4986-dcc1c8a27f6c@rock-chips.com>
Date:   Tue, 23 Oct 2018 11:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911123907.GN4185@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 03 Sep 2018, Tony Xie wrote:
>
>>      The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>>      and handheld devices. It contains the following components:
>>
>>          - Regulators
>>          - RTC
>>          - Clocking
>>
>>      Both RK809 and RK817 chips are using a similar register map,
>>      so we can reuse the RTC and Clocking and regulators functionality.
>>
>> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
>> ---
> It's often helpful to place a Changelog in this space.
     I will output the changelog in the first mail when send-mail.
>
>>   drivers/mfd/Kconfig       |   6 +-
>>   drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>>   kernel/reboot.c           |   1 +
>>   4 files changed, 391 insertions(+), 6 deletions(-)
> I just reviewed v4.
>
> It looks like the review comments are still relevant.
     I will commit the v5 today which includes some modification base on 
your comments base in the v3.
>


