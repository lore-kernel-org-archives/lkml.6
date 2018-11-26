Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAF4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716062086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IcW5i7zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716062086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeK0GPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:15:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34578 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeK0GO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:14:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQJF46a063732;
        Mon, 26 Nov 2018 19:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tgcc78J+MzML82ghQXxe2Pg/oEL/WgfibsJSZAMtFqM=;
 b=IcW5i7zVoVKqkLQM8Z9+KyxZtvKOTZNdTMrFMLGVaDr6wVluolQxTWIkMXGdZXnwkicV
 /t3ifnRFBnGkRQlSTNWy0wFg7DxJmGm95iQ9533cJRhCcVicBTCdztGFlFCUQtZi/Ely
 4lf/z8A7ueRxyvVpdG5bQ9de+ej+lST3zTpPpioG6e5lWj3S+kD07OCR1uFiLaPsjQ5w
 cXptWd/yT6X+J/Cs0qsuOISAB179geol8mLM8G4ChV6vyA1ZIgluCe5RO8R1btKUrm0k
 9YoBGDT5g35EPqaHjDHOLDrTisdlBs3X/yCLqkOxgTwL3tb8YYzTcAXVKlZ8sJ61bMEw 1Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nxxkq7sju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 19:19:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQJJZYr021908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 19:19:36 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQJJZ6Q032129;
        Mon, 26 Nov 2018 19:19:35 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 11:19:35 -0800
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <20181126101434.GB10878@ulmo> <20181126191405.GM53235@atomide.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <92d5936c-d0c4-a12b-a363-116517ddfe64@oracle.com>
Date:   Mon, 26 Nov 2018 11:19:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126191405.GM53235@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=548
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 11:14 AM, Tony Lindgren wrote:
> * Thierry Reding <treding@nvidia.com> [181126 10:14]:
>> On Mon, Nov 19, 2018 at 09:14:06AM -0800, Tony Lindgren wrote:
>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>>>
>>> So it seems that commit df545d1cd01a ("mfd: palmas: Provide
>>> irq flags through DT/platform data") wrongly sets the
>>> PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
>>> while it should set it on IRQ_TYPE_LEVEL_LOW.
>>
>> Oops, sorry, you seem to have come to pretty much the same conclusion as
>> I did. I think what we need to do is find a copy of the TRM and see what
>> exactly the right behaviour is. Or we need to find someone that can take
>> measurements of the PMIC interrupt pin.
> 
> Yeah so either tegra inverts the PMIC interrupt twice now,
> or we have also omap5 wkupgen also inverting the PMIC interrupt
> once.. Santosh, do you remember if omap5 wkupgen might be
> inverting the palmas interrupt?
> 
 From the memory, omap5 wakeupgen doesn't invert the irqlines and
not anything specific to PMIC specially either.
