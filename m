Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC0C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB27F2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfBEJK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:10:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36543 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbfBEJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:10:58 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1597eXZ008909;
        Tue, 5 Feb 2019 10:10:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qdjdnjqy7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Feb 2019 10:10:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4790948;
        Tue,  5 Feb 2019 09:10:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D55182499;
        Tue,  5 Feb 2019 09:10:40 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb
 2019 10:10:40 +0100
Subject: Re: [PATCH v2 0/2] Add STM32MP157 discovery boards support
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
References: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b42eb57e-a413-d65a-e040-b380d859423f@st.com>
Date:   Tue, 5 Feb 2019 10:10:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in title, it's a v1 not a v2.

On 2/5/19 10:07 AM, Alexandre Torgue wrote:
> This patch series add support of two new discovery boards based on
> STM32MP157 MPU: stm32mp157a-dk1 and stm32mp157c-dk2.
> 
> stm32mp157a-dk1 board embeds a STM32MP157a SOC with AC package (TFBGA361,
> 148 ios) and 512MB of DDR3. Several connections are available on this boards:
> 4*USB2.0, 1*USB2.0 typeC, SDcard, RJ45, HDMI, Arduino connector, ...
> 
> stm32mp157c-dk2 board complements stm32mp157a-dk1 board with a display panel
> (otm8009a) and a Murata Wifi/BT combo. It embeds a STM32MP157c SOC with AC
> package.
> 
> Those patches enable basic support for a kernel boot.
> 
> regards
> Alex
> 
> Alexandre Torgue (2):
>    ARM: dts: stm32: add initial support of stm32mp157a-dk1 board
>    ARM: dts: stm32: add initial support of stm32mp157c-dk2 board
> 
>   arch/arm/boot/dts/Makefile            |  2 +
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 77 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-dk2.dts | 75 ++++++++++++++++++++++++++++++++++
>   3 files changed, 154 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2.dts
> 
