Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA42098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIXRPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:15:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbeIXRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:15:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OB9XmI036187
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 07:13:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mpx2x1wwx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 07:13:38 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 24 Sep 2018 05:13:37 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 05:13:33 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OBDWAS41877692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 04:13:32 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C8F56E04C;
        Mon, 24 Sep 2018 05:13:32 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 660906E050;
        Mon, 24 Sep 2018 05:13:29 -0600 (MDT)
Received: from [9.124.31.41] (unknown [9.124.31.41])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 05:13:29 -0600 (MDT)
Subject: Re: [PATCH v3 3/6] ima: refactor ima_init_policy()
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com
References: <20180921083429.c7sikis5bzxdifny@mwanda>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Mon, 24 Sep 2018 16:40:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180921083429.c7sikis5bzxdifny@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092411-0036-0000-0000-00000A3DA88D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009762; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092921; UDB=6.00564833; IPR=6.00872958;
 MB=3.00023478; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 11:13:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092411-0037-0000-0000-0000490CDC41
Message-Id: <83d87b89-d1df-5e13-23d9-1ee2e8c9a75f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 02:04 PM, Dan Carpenter wrote:
> Hi Nayna,
>
> Thank you for the patch! Perhaps something to improve:
>
> url:    https://github.com/0day-ci/linux/commits/Nayna-Jain/Add-support-for-architecture-specific-IMA-policies/20180920-035110
>
> smatch warnings:
> security/integrity/ima/ima_policy.c:489 add_rules() warn: should this be a bitwise op?
>
> # https://github.com/0day-ci/linux/commit/84a2e186f940ebc6c34e6d276e55f665167a5bb8
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 84a2e186f940ebc6c34e6d276e55f665167a5bb8
> vim +489 security/integrity/ima/ima_policy.c
>
> 6f0911a6 Mimi Zohar 2018-04-12  477
> 84a2e186 Nayna Jain 2018-09-19  478  static void add_rules(struct ima_rule_entry *entries, int count,
> 84a2e186 Nayna Jain 2018-09-19  479  		      enum policy_rule_list file)
> 84a2e186 Nayna Jain 2018-09-19  480  {
> 84a2e186 Nayna Jain 2018-09-19  481  	int i = 0;
> 84a2e186 Nayna Jain 2018-09-19  482
> 84a2e186 Nayna Jain 2018-09-19  483  	for (i = 0; i < count; i++) {
> 84a2e186 Nayna Jain 2018-09-19  484  		struct ima_rule_entry *entry;
> 84a2e186 Nayna Jain 2018-09-19  485
> 84a2e186 Nayna Jain 2018-09-19  486  		if (file && IMA_DEFAULT_POLICY)
>                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 84a2e186 Nayna Jain 2018-09-19  487  			list_add_tail(&entries[i].list, &ima_default_rules);
> 84a2e186 Nayna Jain 2018-09-19  488
> 84a2e186 Nayna Jain 2018-09-19 @489  		if (file && IMA_CUSTOM_POLICY) {
>                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> It does look like it should be "if (file & IMA_CUSTOM_POLICY) {" but I
> haven't looked at the context besides what's here in this email.
Thanks Dan for noticing this. Yes, I will fix it and post the v4 version.

Thanks & Regards,
     - Nayna


>
> 84a2e186 Nayna Jain 2018-09-19  490  			entry = kmemdup(&entries[i], sizeof(*entry),
> 84a2e186 Nayna Jain 2018-09-19  491  					GFP_KERNEL);
> 84a2e186 Nayna Jain 2018-09-19  492  			if (!entry)
> 84a2e186 Nayna Jain 2018-09-19  493  				continue;
> 84a2e186 Nayna Jain 2018-09-19  494
> 84a2e186 Nayna Jain 2018-09-19  495  			INIT_LIST_HEAD(&entry->list);
> 84a2e186 Nayna Jain 2018-09-19  496  			list_add_tail(&entry->list, &ima_policy_rules);
> 84a2e186 Nayna Jain 2018-09-19  497  		}
> 84a2e186 Nayna Jain 2018-09-19  498  		if (entries[i].action == APPRAISE)
> 84a2e186 Nayna Jain 2018-09-19  499  			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
> 84a2e186 Nayna Jain 2018-09-19  500  		if (entries[i].func == POLICY_CHECK)
> 84a2e186 Nayna Jain 2018-09-19  501  			temp_ima_appraise |= IMA_APPRAISE_POLICY;
> 84a2e186 Nayna Jain 2018-09-19  502  	}
> 84a2e186 Nayna Jain 2018-09-19  503  }
> 84a2e186 Nayna Jain 2018-09-19  504
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

