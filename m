Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D7C206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D7C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeGSHlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:41:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730195AbeGSHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:41:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6J6rxta035052
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 02:59:33 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kahqsrqj8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 02:59:32 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stewart@linux.ibm.com>;
        Thu, 19 Jul 2018 00:59:31 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Jul 2018 00:59:28 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6J6xRWM8061370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 23:59:27 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 143966E050;
        Thu, 19 Jul 2018 00:59:27 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A03B6E04C;
        Thu, 19 Jul 2018 00:59:25 -0600 (MDT)
Received: from birb.localdomain (unknown [9.102.57.239])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with SMTP;
        Thu, 19 Jul 2018 00:59:25 -0600 (MDT)
Received: by birb.localdomain (Postfix, from userid 1000)
        id 175824EC69D; Thu, 19 Jul 2018 16:59:21 +1000 (AEST)
From:   Stewart Smith <stewart@linux.ibm.com>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au, linux@roeck-us.net
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/2] hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
In-Reply-To: <1531937610-6454-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1531937610-6454-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1531937610-6454-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date:   Thu, 19 Jul 2018 16:59:21 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18071906-8235-0000-0000-00000DD48F21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009390; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062932; UDB=6.00545790; IPR=6.00840784;
 MB=3.00022198; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-19 06:59:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071906-8236-0000-0000-000041EF2904
Message-Id: <87lga7r9rq.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807190076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
> which measures various system and chip level sensors. These sensors
> comprises of environmental sensors (like power, temperature, current
> and voltage) and performance sensors (like utilization, frequency).
> All these sensors are copied to main memory at a regular interval of
> 100ms. OCC provides a way to select a group of sensors that is copied
> to the main memory to increase the update frequency of selected sensor
> groups. When a sensor-group is disabled, OCC will not copy it to main
> memory and those sensors read 0 values.

OCC is an implementation detail rather than a core part of this firmware
API.

Why not something like this:

OPAL firmware provides the facility for some groups of sensors to be
enabled/disabled at runtime to give the user the option of using the
system resources for collecting these sensors or not.

For example, on POWER9 systems, the On Chip Controller (OCC) gathers
various system and chip level sensors and maintains their values in main
memory.


> +static int init_sensor_group_data(struct platform_device *pdev,
> +				  struct platform_data *pdata)
> +{
> +	struct sensor_group_data *sgrp_data;
> +	struct device_node *groups, *sgrp;
> +	enum sensors type;
> +	int count = 0, ret = 0;
> +
> +	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
> +	if (!groups)
> +		return ret;

Why not look for the compatible property?


-- 
Stewart Smith
OPAL Architect, IBM.

