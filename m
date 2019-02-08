Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF34C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471712084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBHQTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:19:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbfBHQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:19:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18GDs72051505
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 11:19:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhaygxwyb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:19:10 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 16:19:09 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 16:19:05 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18GJ4A414614720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 16:19:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AA9EB2065;
        Fri,  8 Feb 2019 16:19:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1D5B205F;
        Fri,  8 Feb 2019 16:19:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 16:19:04 +0000 (GMT)
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
 <89f94ccb-d63e-271c-a91b-cfe63e40f776@linux.ibm.com>
 <20190208160723.GA23755@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 11:19:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208160723.GA23755@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020816-0040-0000-0000-000004BEC780
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010559; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158143; UDB=6.00604226; IPR=6.00938676;
 MB=3.00025495; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 16:19:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020816-0041-0000-0000-000008C9E3E2
Message-Id: <479945da-8e97-2ff5-c1c6-f77aaec86519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=940 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 11:07 AM, Jarkko Sakkinen wrote:
> On Fri, Feb 08, 2019 at 10:45:53AM -0500, Stefan Berger wrote:
>> On 2/8/19 10:42 AM, Jarkko Sakkinen wrote:
>>> On Fri, Feb 08, 2019 at 09:42:16AM -0500, Stefan Berger wrote: > On 2/8/19 9:05 AM, Jarkko Sakkinen wrote:
>>>> At least tpm_nsc_send (tpm_nsc.c) and tpm_inf_send (tpm_infineon.c) are also
>>>> returning the number of bytes sent. I would consider tpm_crb the outlier
>>>> that returns 0 and should return the length even though we don't need it...
>>> That would be absolutely wrong way the fix the *actual* issue i.e.
>>> callbacks returning garbage (sometimes just passing the length parameter
>>> back as a return value).
>> Then I guess you have to fixes those other two files as well...
> That's still a better option.

tpm_tis_core.c's tpm_tis_send_main() also needs fixing...


>
> /Jarkko
>

