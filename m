Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0925C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766A72086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfBHPqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:46:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727479AbfBHPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:46:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18FcxQA101610
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 10:45:58 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qhbfhbtnp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:45:58 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 15:45:57 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 15:45:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18Fjsvm24248522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 15:45:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26FB7B2067;
        Fri,  8 Feb 2019 15:45:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1610BB2065;
        Fri,  8 Feb 2019 15:45:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 15:45:54 +0000 (GMT)
Subject: Re: [PATCH 1/2] tpm: Unify the send callback behaviour
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org
References: <20190208140600.24996-1-jarkko.sakkinen@linux.intel.com>
 <20190208140600.24996-2-jarkko.sakkinen@linux.intel.com>
 <b53745b6-ed49-9e97-6f56-1378561888eb@linux.ibm.com>
 <20190208154244.GA3963@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 10:45:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208154244.GA3963@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020815-0068-0000-0000-000003910DE4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010559; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158132; UDB=6.00604264; IPR=6.00938665;
 MB=3.00025495; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 15:45:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020815-0069-0000-0000-0000476F540F
Message-Id: <89f94ccb-d63e-271c-a91b-cfe63e40f776@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=817 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 10:42 AM, Jarkko Sakkinen wrote:
> On Fri, Feb 08, 2019 at 09:42:16AM -0500, Stefan Berger wrote: > On 2/8/19 9:05 AM, Jarkko Sakkinen wrote:
>> At least tpm_nsc_send (tpm_nsc.c) and tpm_inf_send (tpm_infineon.c) are also
>> returning the number of bytes sent. I would consider tpm_crb the outlier
>> that returns 0 and should return the length even though we don't need it...
> That would be absolutely wrong way the fix the *actual* issue i.e.
> callbacks returning garbage (sometimes just passing the length parameter
> back as a return value).

Then I guess you have to fixes those other two files as well...

>
> /Jarkko
>

