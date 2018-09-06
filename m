Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F502064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F502064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeIFSH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:07:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729104AbeIFSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:07:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86DUAG9142014
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 09:32:25 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mb3jw4uy0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:32:24 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 6 Sep 2018 07:32:24 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 07:32:21 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86DWKkU51970066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 06:32:20 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5722D7805F;
        Thu,  6 Sep 2018 07:32:20 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D82107805E;
        Thu,  6 Sep 2018 07:32:17 -0600 (MDT)
Received: from [9.102.0.183] (unknown [9.102.0.183])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 07:32:17 -0600 (MDT)
Subject: Re: [RFC PATCH V2 1/4] mm: Export alloc_migrate_huge_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906123111.GC26069@dhcp22.suse.cz>
 <20180906123539.GV14951@dhcp22.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 6 Sep 2018 19:02:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906123539.GV14951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090613-0012-0000-0000-000016AE33A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084383; UDB=6.00559689; IPR=6.00864382;
 MB=3.00023143; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 13:32:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090613-0013-0000-0000-0000544EAB15
Message-Id: <50682adc-5be9-1fac-fd84-abc6bbea7549@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=935 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 06:05 PM, Michal Hocko wrote:
> On Thu 06-09-18 14:31:11, Michal Hocko wrote:
>> On Thu 06-09-18 11:13:39, Aneesh Kumar K.V wrote:
>>> We want to use this to support customized huge page migration.
>>
>> Please be much more specific. Ideally including the user. Btw. why do
>> you want to skip the hugetlb pools? In other words alloc_huge_page_node*
>> which are intended to an external use?
> 
> Ups, I have now found http://lkml.kernel.org/r/20180906054342.25094-2-aneesh.kumar@linux.ibm.com
> which ended up in a different email folder so I have missed it. It would
> be much better to merge those two to make the user immediately obvious.
> There is a good reason to keep newly added functions closer to their
> users.
> 

It is the same series. I will fold the patch 1 and 2.

-aneesh

