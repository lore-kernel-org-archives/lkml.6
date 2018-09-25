Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B341C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFA0206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFA0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeIYWgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:36:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbeIYWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:36:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PGRV1O027329
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:28:31 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqr4ds9kv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:28:30 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 10:28:29 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 10:28:25 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PGSOd462914708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 09:28:24 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C4F16E056;
        Tue, 25 Sep 2018 10:28:24 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E39856E054;
        Tue, 25 Sep 2018 10:28:19 -0600 (MDT)
Received: from [9.77.205.177] (unknown [9.77.205.177])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Sep 2018 10:28:19 -0600 (MDT)
Subject: Re: [PATCH v3 06/20] tpm: move tpm1_pcr_extend to tpm1-cmd.c
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-7-tomas.winkler@intel.com>
 <20180919140634.GA27854@linux.intel.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Tue, 25 Sep 2018 21:55:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180919140634.GA27854@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092516-0004-0000-0000-0000149188F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009769; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093506; UDB=6.00565184; IPR=6.00873543;
 MB=3.00023498; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 16:28:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092516-0005-0000-0000-000088EF80A4
Message-Id: <7af3302c-3c46-ebc7-bf9b-704c8eaaa6b7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/19/2018 07:36 PM, Jarkko Sakkinen wrote:
> On Tue, Sep 18, 2018 at 12:34:45PM +0300, Tomas Winkler wrote:
>> Move tpm1_pcr_extend to tpm1-cmd.c and remove
>> unused pcrextend_header structure.
>>
>> Fixes warning:
>> drivers/char/tpm/tpm-interface.c:609:38: warning: ‘pcrextend_header’ defined but not used [-Wunused-const-variable=]
>>   static const struct tpm_input_header pcrextend_header = {
>>                                        ^~~~~~~~~~~~~~~~
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Can someone with a working IMA environment to test it? Don't have one
> right now (should probably setup).

I think I can try testing this patch sometime next week. I will test the 
updated version.

Thanks & Regards,
     - Nayna

>
> /Jarkko
>

