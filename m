Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B0C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E32081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93E32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeKDRuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 12:50:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbeKDRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 12:50:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA48TCPg029951
        for <linux-kernel@vger.kernel.org>; Sun, 4 Nov 2018 03:36:22 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nhsbf6p2q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 03:36:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 4 Nov 2018 08:36:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 4 Nov 2018 08:36:15 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA48aE2b7930360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 4 Nov 2018 08:36:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D83C4C044;
        Sun,  4 Nov 2018 08:36:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B8A4C058;
        Sun,  4 Nov 2018 08:36:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.72])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Nov 2018 08:36:13 +0000 (GMT)
Date:   Sun, 4 Nov 2018 10:36:11 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        vbabka@suse.cz, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Create the new vm_fault_t type
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
 <20181103120235.GA10491@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103120235.GA10491@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110408-0028-0000-0000-00000312903C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110408-0029-0000-0000-000023CECE96
Message-Id: <20181104083611.GB7829@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=595 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811040082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 05:02:36AM -0700, Matthew Wilcox wrote:
> On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:
> > Page fault handlers are supposed to return VM_FAULT codes,
> > but some drivers/file systems mistakenly return error
> > numbers. Now that all drivers/file systems have been converted
> > to use the vm_fault_t return type, change the type definition
> > to no longer be compatible with 'int'. By making it an unsigned
> > int, the function prototype becomes incompatible with a function
> > which returns int. Sparse will detect any attempts to return a
> > value which is not a VM_FAULT code.
> 
> 
> > -/* Encode hstate index for a hwpoisoned large page */
> > -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> > -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> ...
> > +/* Encode hstate index for a hwpoisoned large page */
> > +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> > +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> 
> I think it's important to mention in the changelog that these values
> have been changed to avoid conflicts with other VM_FAULT codes.
> 
> > +/**
> > + * typedef vm_fault_t -  __bitwise unsigned int
> > + *
> > + * vm_fault_t is the new unsigned int type to return VM_FAULT
> > + * code by page fault handlers of drivers/file systems. Now if
> > + * any page fault handlers returns non VM_FAULT code instead
> > + * of VM_FAULT code, it will be a mismatch with function
> > + * prototype and sparse will detect it.
> > + */
> 
> The first line should be what the typedef *means*, not repeat the
> compiler's definition.  The rest of the description should be information
> for someone coming to the type for the first time; what you've written
> here is changelog material.
> 
> /**
>  * typedef vm_fault_t - Return type for page fault handlers.
>  *
>  * Page fault handlers return a bitmask of %VM_FAULT values.
>  */
> 
> > +typedef __bitwise unsigned int vm_fault_t;
> > +
> > +/**
> > + * enum - VM_FAULT code
> 
> Can you document an anonymous enum?  I've never tried.  Did you run this
> through 'make htmldocs'?

You cannot document an anonymous enum.
 
> > + * This enum is used to track the VM_FAULT code return by page
> > + * fault handlers.
> 
>  * Page fault handlers return a bitmask of these values to tell the
>  * core VM what happened when handling the fault.
> 

-- 
Sincerely yours,
Mike.

