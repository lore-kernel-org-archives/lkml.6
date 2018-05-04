Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEDIZr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:25:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751790AbeEDIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:25:45 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] powerpc/hugetlb: Enable hugetlb migration for ppc64
In-Reply-To: <69b4fae5-d413-4866-7ce4-3873d3c6590f@c-s.fr>
References: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <1494926612-23928-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <69b4fae5-d413-4866-7ce4-3873d3c6590f@c-s.fr>
Date: Fri, 04 May 2018 13:55:31 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18050408-0044-0000-0000-0000054EE221
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050408-0045-0000-0000-000028900D3E
Message-Id: <871serrfno.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 16/05/2017 à 11:23, Aneesh Kumar K.V a écrit :
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/Kconfig.cputype | 5 +++++
>>   1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index 80175000042d..8acc4f27d101 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -351,6 +351,11 @@ config PPC_RADIX_MMU
>>   	  is only implemented by IBM Power9 CPUs, if you don't have one of them
>>   	  you can probably disable this.
>>   
>> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
>> +	def_bool y
>> +	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
>> +
>> +
>
> Is there a reason why you redefine ARCH_ENABLE_HUGEPAGE_MIGRATION 
> instead of doing a 'select' as it is already defined in mm/Kconfig ?
>

That got copied from x86 Kconfig i guess.

-aneesh
