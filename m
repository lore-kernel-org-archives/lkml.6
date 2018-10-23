Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B7AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A634A2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OAEs6ePE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A634A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeJXB7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:59:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJXB7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:59:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NHNeAW054447;
        Tue, 23 Oct 2018 17:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kaLmPQB51T4mJ7Nmf6eCBc6LYuk35Iii4ZYvo6Rvx9I=;
 b=OAEs6ePEKjZzmkwl9elIolNvVtPzZgRY/QOG5B8lG/uqskRzvFsubjc7lfAdLZ/X5M/C
 WfP5qlUqmM1Yaem+XGDthHjpp9SWI3eDN6Vr/hcjcSmm3zY/tFoMWpUe0+wbH2Yly0QC
 xALITMyivNoukaZaIRwQCLsal4lwuYnVlIHcEo6S0Bl8W7BO2o1SqkkQgGr4WvNiFJCq
 GwdHXXRfoAUkC7MA60rcXbSth0LBeQdkcWH9bYYOio6g3KAGV2JQ221fKOelOzg1U5x+
 m8csLGkJs1MZhBrmak3uXJaRSXqFyN9X/LkaBg0U5G2Pwo6QG1vfa7QnoAlv3aBR3hcs 0A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n7w0qpsv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 17:34:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9NHYNHl003331
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 17:34:23 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9NHYLiv023535;
        Tue, 23 Oct 2018 17:34:22 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 10:34:21 -0700
Subject: Re: [PATCH v2 00/10] Add support for TISCI irqchip drivers
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <942981b8-7536-2b6b-ad49-dc59671cbda6@oracle.com>
 <050161aa-a257-9bf8-b3c9-35b13925b556@ti.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <38811dd7-0645-0439-092d-6759ab52cb0a@oracle.com>
Date:   Tue, 23 Oct 2018 10:34:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <050161aa-a257-9bf8-b3c9-35b13925b556@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 1:17 AM, Lokesh Vutla wrote:
> Hi Santosh,
> 
> On Tuesday 23 October 2018 02:09 AM, Santosh Shilimkar wrote:
>> On 10/18/2018 8:40 AM, Lokesh Vutla wrote:
>>> TISCI abstracts the handling of IRQ routes where interrupt sources
>>> are not directly connected to host interrupt controller. This series
>>> adds support for:
>>> - TISCI commands needed for IRQ configuration
>>> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers
>>>
>>> More information on TISCI IRQ management can be found here[1].
>>> Complete TISCI resource management information can be found here[2].
>>> AM65x SoC related TISCI information can be found here[3].
>>> INTR and INTA related information can be found in TRM[4].
>>>
>> I didn't read the specs but from what you described in
>> INTA and INTR bindings, does the flow of IRQs like below ?
>>
>> Device IRQ(e.g USB) -->INTR-->INTA--->HOST IRQ controller(GIC)
> 
> Not all devices in SoC are connected to INTA. Only the devices that are 
> capable of generating events are connected to INTA. And INTA is 
> connected to INTR.
> 
> So there are three ways in which IRQ can flow in AM65x SoC:
> 1) Device directly connected to GIC
>      - Device IRQ --> GIC
>      - (Most legacy peripherals like MMC, UART falls in this case)
> 2) Device connected to INTR.
>      - Device IRQ --> INTR --> GIC
>      - This is cases where you want to mux IRQs. Used for GPIOs and 
> Mailboxes
>      - (This is somewhat similar to crossbar on DRA7 devices)
> 3) Devices connected to INTA.
>      - Device Event --> INTA --> INTR --> GIC
>      - Used for DMA and networking devices.
> 
> Events are messages based on a hw protocol, sent by a master over a 
> dedicated Event transport lane. Events are highly precise that no 
> under/over flow of data transfer occurs at source/destination regardless 
> of distance and latency. So this is mostly preferred in DMA and 
> networking usecases. Now Interrupt Aggregator(IA) has the logic to 
> converts these events to Interrupts.
> 
This helps but none of the kernel doc you added, makes this clear so
perhaps you want to add this info to make that clear for reviewers
as well as for future reference.

Now regarding the events, no matter how they are routed/processed
within SOC, they are essentially interrupts so I do agree with
Marc's other comment.

Thanks for explanation again !!

regards,
Santosh
