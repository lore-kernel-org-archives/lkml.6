Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC9DC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC7820665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOH0msCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC7820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeJWE7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:59:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:59:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MKYExV053497;
        Mon, 22 Oct 2018 20:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XHyNwLF3WfJn2+I4lLilabah77XmtUREkOx8TPwzgt8=;
 b=iOH0msCmciwQni/yrzeU8uC5NcfxgFSTcHlkg723A+Ip5kK7z+fhUJ7e/f2UDKUEaNgu
 Q08EeQrggYl5U2Zn6gpM7eZgwbivFgAnP0qSxOps4yOvUYhsU1h7kCBK0vfq7jHia0yD
 RTgS7BaF0IC2s3D04pqj1e1JKws6bURCalsAkVwtQ3hXwvJ92PZiSNLUX4zYwX35gKhK
 q52sYp7TP6jJKzbDoby2XdIsxO8Fa+/Sh89yQ1UwsPlciR2C5OIsEjfLyL068vHRVbII
 JQQmEOhVjIrsL74a3ETm4mqvpEZ7p67DbGd/889BE6uu1pcDiKkDRiVT2mj7u6s2nTPi Pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n7usu13kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 20:39:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MKd5d5020189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 20:39:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MKd4KN012901;
        Mon, 22 Oct 2018 20:39:04 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 13:39:03 -0700
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
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <942981b8-7536-2b6b-ad49-dc59671cbda6@oracle.com>
Date:   Mon, 22 Oct 2018 13:39:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018154017.7112-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=752
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 8:40 AM, Lokesh Vutla wrote:
> TISCI abstracts the handling of IRQ routes where interrupt sources
> are not directly connected to host interrupt controller. This series
> adds support for:
> - TISCI commands needed for IRQ configuration
> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers
> 
> More information on TISCI IRQ management can be found here[1].
> Complete TISCI resource management information can be found here[2].
> AM65x SoC related TISCI information can be found here[3].
> INTR and INTA related information can be found in TRM[4].
> 
I didn't read the specs but from what you described in
INTA and INTR bindings, does the flow of IRQs like below ?

Device IRQ(e.g USB) -->INTR-->INTA--->HOST IRQ controller(GIC)

The confusing part is aggregator and can multiplex as well
as grouping but seems like its event grouping or multiplexing
than actual device IRQ grouping or multi-plexsing.

What am I missing ?

Regards,S
antosh
