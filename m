Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC7420821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC7420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJaSdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:33:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727436AbeJaSdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:33:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9V9ZD1S067174
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:35:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nf9rhrce2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:35:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 31 Oct 2018 09:35:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 09:35:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9V9Zcgl63635472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 09:35:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26357A4053;
        Wed, 31 Oct 2018 09:35:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D97C3A4040;
        Wed, 31 Oct 2018 09:35:37 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.191])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 09:35:37 +0000 (GMT)
Date:   Wed, 31 Oct 2018 10:35:36 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm: introduce mm_[p4d|pud|pmd]_folded
In-Reply-To: <20181031090255.bvmp3jnsdaunhzn7@kshutemo-mobl1>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
        <1539621759-5967-2-git-send-email-schwidefsky@de.ibm.com>
        <20181031090255.bvmp3jnsdaunhzn7@kshutemo-mobl1>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18103109-0016-0000-0000-0000021CDFAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103109-0017-0000-0000-000032750916
Message-Id: <20181031103536.0cab673d@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=980 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 12:02:55 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Mon, Oct 15, 2018 at 06:42:37PM +0200, Martin Schwidefsky wrote:
> > Add three architecture overrideable function to test if the
> > p4d, pud, or pmd layer of a page table is folded or not.
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > ---
> >  include/linux/mm.h | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0416a7204be3..d1029972541c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h  
> 
> Shouldn't it be somewhere in asm-generic/pgtable*?

If you prefer the definitions in asm-generic that is fine with me.
I'll give it a try to see if it still compiles.

> > @@ -105,6 +105,46 @@ extern int mmap_rnd_compat_bits __read_mostly;
> >  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
> >  #endif
> >  
> > +/*
> > + * On some architectures it depends on the mm if the p4d/pud or pmd
> > + * layer of the page table hierarchy is folded or not.
> > + */
> > +#ifndef mm_p4d_folded
> > +#define mm_p4d_folded(mm) mm_p4d_folded(mm)  
> 
> Do we need to define it in generic header?

That is true, it should work without the #define in the generic header.

> > +static inline bool mm_p4d_folded(struct mm_struct *mm)
> > +{
> > +#ifdef __PAGETABLE_P4D_FOLDED
> > +	return 1;
> > +#else
> > +	return 0;
> > +#endif  
> 
> Maybe
> 	return __is_defined(__PAGETABLE_P4D_FOLDED);
> 
> ?
 
I have tried that, doesn't work. The reason is that the
__PAGETABLE_xxx_FOLDED defines to not have a value.

#define __PAGETABLE_P4D_FOLDED
#define __PAGETABLE_PMD_FOLDED
#define __PAGETABLE_PUD_FOLDED

While the definition of CONFIG_xxx symbols looks like this

#define CONFIG_xxx 1

The __is_defined needs the value for the __take_second_arg trick.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

