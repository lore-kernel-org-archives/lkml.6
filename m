Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56225C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5F3214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5F3214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeLFPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:37:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbeLFPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:37:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB6FYDFF083944
        for <linux-kernel@vger.kernel.org>; Thu, 6 Dec 2018 10:37:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p74ddevg8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:37:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Thu, 6 Dec 2018 15:37:03 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Dec 2018 15:37:00 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB6Faxn541025542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 15:36:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2817911C058;
        Thu,  6 Dec 2018 15:36:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 898F211C050;
        Thu,  6 Dec 2018 15:36:57 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Dec 2018 15:36:57 +0000 (GMT)
Subject: Re: [PATCH v2] misc: cxl: Use device_type helpers to access the node
 type
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <20181205191655.14612-1-robh@kernel.org>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Thu, 6 Dec 2018 16:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205191655.14612-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120615-0008-0000-0000-0000029DE0EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120615-0009-0000-0000-00002208491A
Message-Id: <dcc44aac-8ee4-4f9c-4016-f29f6a4f8c23@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/12/2018 à 20:16, Rob Herring a écrit :
> Remove directly accessing device_type property and use the
> of_node_is_type accessor instead. While not using it here, this is
> part of eventually removing the struct device_node.type pointer.
> 
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Reword commit message as this change was using the .type ptr.

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


> 
>   drivers/misc/cxl/pci.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index b66d832d3233..c79ba1c699ad 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1718,7 +1718,6 @@ int cxl_slot_is_switched(struct pci_dev *dev)
>   {
>   	struct device_node *np;
>   	int depth = 0;
> -	const __be32 *prop;
> 
>   	if (!(np = pci_device_to_OF_node(dev))) {
>   		pr_err("cxl: np = NULL\n");
> @@ -1727,8 +1726,7 @@ int cxl_slot_is_switched(struct pci_dev *dev)
>   	of_node_get(np);
>   	while (np) {
>   		np = of_get_next_parent(np);
> -		prop = of_get_property(np, "device_type", NULL);
> -		if (!prop || strcmp((char *)prop, "pciex"))
> +		if (!of_node_is_type(np, "pciex"))
>   			break;
>   		depth++;
>   	}
> 

