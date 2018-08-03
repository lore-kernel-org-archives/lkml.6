Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC2CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6AE2174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6AE2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbeHCMGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:06:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732587AbeHCMGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:06:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73A8uJh111594
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 06:11:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmm1r2hnd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:11:05 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 04:11:04 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 04:11:01 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73AB0Oi65994894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 03:11:00 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DF236A04D;
        Fri,  3 Aug 2018 04:11:00 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A8986A04F;
        Fri,  3 Aug 2018 04:10:57 -0600 (MDT)
Received: from [9.124.31.153] (unknown [9.124.31.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 04:10:56 -0600 (MDT)
Subject: Re: [PATCH 1/4] ima: add support for arch specific policies
To:     kbuild test robot <lkp@intel.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
 <201807281011.3IfKWpyx%fengguang.wu@intel.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Fri, 3 Aug 2018 15:38:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <201807281011.3IfKWpyx%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080310-0012-0000-0000-00001696A816
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009476; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01069467; UDB=6.00549964; IPR=6.00848025;
 MB=3.00022478; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-03 10:11:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080310-0013-0000-0000-000053E70437
Message-Id: <b47cddd8-44ea-1175-a6ee-25f06ad4a185@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/28/2018 07:54 AM, kbuild test robot wrote:
> Hi Nayna,
>
> Thank you for the patch! Perhaps something to improve:

Thanks for the report. I will address or squash the changes with the 
existing PATCH 1/4 in the next version.
The warning about NULL dereference in PATCH 4/4 is related to changes in 
PATCH 1/4, so will fix in PATCH 1/4 itself.

Thanks & Regards,
     - Nayna


>
> [auto build test WARNING on integrity/next-integrity]
> [also build test WARNING on next-20180727]
> [cannot apply to v4.18-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Eric-Richter/ima-add-support-for-arch-specific-policies/20180728-072442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> reproduce:
>          # apt-get install sparse
>          make ARCH=x86_64 allmodconfig
>          make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> security/integrity/ima/ima_policy.c:198:23: sparse: symbol 'arch_policy_rules' was not declared. Should it be static?
>>> security/integrity/ima/ima_policy.c:199:23: sparse: symbol 'arch_policy_entry' was not declared. Should it be static?
>     include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
>     include/linux/slab.h:631:13: sparse: not a function <noident>
>     include/linux/slab.h:631:13: sparse: call with no type!
>
> Please review and possibly fold the followup patch.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

