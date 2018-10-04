Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F00EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE5D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE5D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJDPP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:15:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbeJDPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:15:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w948EKvh035944
        for <linux-kernel@vger.kernel.org>; Thu, 4 Oct 2018 04:23:23 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mwers1bsb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 04:23:23 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 4 Oct 2018 02:23:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Oct 2018 02:23:19 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w948NIn120906066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Oct 2018 01:23:18 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2668B6A047;
        Thu,  4 Oct 2018 02:23:18 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF5C6A058;
        Thu,  4 Oct 2018 02:23:15 -0600 (MDT)
Received: from [9.124.31.179] (unknown [9.124.31.179])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  4 Oct 2018 02:23:15 -0600 (MDT)
Subject: Re: [RFC PATCH v3 1/7] book3s/64: avoid circular header inclusion in
 mmu-hash.h
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <c95148024873842459472bbcc0dd0e65607fd43b.1538396658.git.christophe.leroy@c-s.fr>
 <20181003142400.490fd38a@roar.ozlabs.ibm.com>
 <bed3d788-6633-6eef-30ea-bdfa374e0216@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 4 Oct 2018 13:53:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bed3d788-6633-6eef-30ea-bdfa374e0216@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100408-0016-0000-0000-0000093AEF1A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009819; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097657; UDB=6.00567679; IPR=6.00877697;
 MB=3.00023607; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-04 08:23:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100408-0017-0000-0000-000040949B27
Message-Id: <1516af9d-bb0b-4a2c-71f8-554a3f830281@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/18 1:50 PM, Christophe LEROY wrote:
> 
> 
> Le 03/10/2018 à 06:24, Nicholas Piggin a écrit :
>> On Mon,  1 Oct 2018 12:30:19 +0000 (UTC)
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>> When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h
>>> includes asm/current.h. This generates a circular dependency.
>>> To avoid that, asm/processor.h shall not be included in mmu-hash.h
>>>
>>> In order to do that, this patch moves into a new header called
>>> asm/task_size.h the information from asm/processor.h requires by
>>> mmu-hash.h
>>
>> Doesn't look like you use this header in 32-bit code. Put task_size.h
>> in asm/64/ maybe?
> 
> There is no asm/64/ dir at the time being, only book3s/64/ and nohash/64/
> 
> I'm thinking about leaving it in asm/ but renaming it task_size_user64.h
> 

Quiet a lot of that is book3s 64 specifi because we have there.

#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
/*
  * Max value currently used:
  */


-aneesh

