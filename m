Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705C321104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705C321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeK1IsQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:48:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbeK1IsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:48:16 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARLiejh138270
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:48:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p18jfp1dg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:48:57 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 27 Nov 2018 21:48:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 21:48:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARLmmru53215338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 21:48:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61160A405F;
        Tue, 27 Nov 2018 21:48:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A298A4054;
        Tue, 27 Nov 2018 21:48:48 +0000 (GMT)
Received: from [9.148.204.175] (unknown [9.148.204.175])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 21:48:47 +0000 (GMT)
Date:   Tue, 27 Nov 2018 23:48:45 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181127211600.GB3235@lianli.shorne-pla.net>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com> <1543182277-8819-5-git-send-email-rppt@linux.ibm.com> <20181127211600.GB3235@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 4/5] openrisc: simplify pte_alloc_one_kernel()
To:     Stafford Horne <shorne@gmail.com>
CC:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
From:   Mike Rapoport <rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112721-0008-0000-0000-0000029973B7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112721-0009-0000-0000-00002203B917
Message-Id: <7843DE67-DCC3-48BF-873F-71D87B08EDA8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 27, 2018 11:16:00 PM GMT+02:00, Stafford Horne <shorne@gmail.com> wrote:
>On Sun, Nov 25, 2018 at 11:44:36PM +0200, Mike Rapoport wrote:
>> The pte_alloc_one_kernel() function allocates a page using
>> __get_free_page(GFP_KERNEL) when mm initialization is complete and
>> memblock_phys_alloc() on the earlier stages. The physical address of
>the
>> page allocated with memblock_phys_alloc() is converted to the virtual
>> address and in the both cases the allocated page is cleared using
>> clear_page().
>> 
>> The code is simplified by replacing __get_free_page() with
>> get_zeroed_page() and by replacing memblock_phys_alloc() with
>> memblock_alloc().
>
>Hello Mike,
>
>This looks fine to me.  How do you plan to get this merged?  Will you
>be taking
>care of the whole series or so you want me to queue this openrisc part?

I was thinking about merging via the -mm tree.
Andrew, would that be ok?

>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>
>Acked-by: Stafford Horne <shorne@gmail.com>

Thanks!

>> ---
>>  arch/openrisc/mm/ioremap.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
>> index c969752..cfef989 100644
>> --- a/arch/openrisc/mm/ioremap.c
>> +++ b/arch/openrisc/mm/ioremap.c
>> @@ -123,13 +123,10 @@ pte_t __ref *pte_alloc_one_kernel(struct
>mm_struct *mm,
>>  {
>>  	pte_t *pte;
>>  
>> -	if (likely(mem_init_done)) {
>> -		pte = (pte_t *) __get_free_page(GFP_KERNEL);
>> -	} else {
>> -		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
>> -	}
>> +	if (likely(mem_init_done))
>> +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
>> +	else
>> +		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>>  
>> -	if (pte)
>> -		clear_page(pte);
>>  	return pte;
>>  }
>> -- 
>> 2.7.4
>> 

-- 
Sincerely yours,
Mike.

