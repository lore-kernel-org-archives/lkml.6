Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE7C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E6218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAYAK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:10:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbfAYAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:10:29 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0P04CDQ050912
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 19:10:28 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q7mk5gkcd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 19:10:27 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Fri, 25 Jan 2019 00:10:26 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Jan 2019 00:10:23 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0P0AMAc13828324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 00:10:22 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 495F6AE060;
        Fri, 25 Jan 2019 00:10:22 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 468FBAE063;
        Fri, 25 Jan 2019 00:10:21 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.148.194])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jan 2019 00:10:21 +0000 (GMT)
Subject: Re: [RFC 1/6] powerpc:/drc Define interface to acquire arch-specific
 drc info
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Juliet Kim <minkim@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Thu, 24 Jan 2019 16:10:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012500-2213-0000-0000-000003444F7A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010471; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01151309; UDB=6.00600056; IPR=6.00931649;
 MB=3.00025277; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-25 00:10:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012500-2214-0000-0000-00005D1A86A4
Message-Id: <05aba638-f683-e7d5-ac69-053f24e3c49d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2018 12:50 PM, Michael Bringmann wrote:
> Define interface to acquire arch-specific drc info to match against
> hotpluggable devices.  The current implementation exposes several
> pseries-specific dynamic memory properties in generic kernel code.
> This patch set provides an interface to pull that code out of the
> generic kernel.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  include/linux/topology.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index cb0775e..df97f5f 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -44,6 +44,15 @@
>  
>  int arch_update_cpu_topology(void);

On another note a kern doc comment for this function would also be nice.

-Tyrel

>  
> +int arch_find_drc_match(struct device_node *dn,
> +			bool (*usercb)(struct device_node *dn,
> +				u32 drc_index, char *drc_name,
> +				char *drc_type, u32 drc_power_domain,
> +				void *data),
> +			char *opt_drc_type, char *opt_drc_name,
> +			bool match_drc_index, bool ck_php_type,
> +			void *data);
> +
>  /* Conform to ACPI 2.0 SLIT distance definitions */
>  #define LOCAL_DISTANCE		10
>  #define REMOTE_DISTANCE		20
> 

