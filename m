Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2820862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKEScI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:32:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbeKEScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:32:07 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA59CwJ6133116
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 04:13:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2njh3b5pf1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:13:19 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 5 Nov 2018 09:13:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 09:13:06 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA59D5GK43188346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 09:13:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF509A404D;
        Mon,  5 Nov 2018 09:13:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9160A4051;
        Mon,  5 Nov 2018 09:13:04 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.64])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Nov 2018 09:13:04 +0000 (GMT)
Date:   Mon, 5 Nov 2018 11:13:03 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        pasha.tatashin@oracle.com, vbabka@suse.cz, riel@redhat.com,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Create the new vm_fault_t type
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
 <20181103120235.GA10491@bombadil.infradead.org>
 <20181104083611.GB7829@rapoport-lnx>
 <CAFqt6zaVUT0RGpz+jE4c7rb5prOtDhnxOy-NAiFM9G6jMwofVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zaVUT0RGpz+jE4c7rb5prOtDhnxOy-NAiFM9G6jMwofVg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110509-0028-0000-0000-00000312FDBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110509-0029-0000-0000-000023CF3F6A
Message-Id: <20181105091302.GA3713@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 11:14:17AM +0530, Souptick Joarder wrote:
> Hi Matthew,
> 
> On Sun, Nov 4, 2018 at 2:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Sat, Nov 03, 2018 at 05:02:36AM -0700, Matthew Wilcox wrote:
> > > On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:
> > > > Page fault handlers are supposed to return VM_FAULT codes,
> > > > but some drivers/file systems mistakenly return error
> > > > numbers. Now that all drivers/file systems have been converted
> > > > to use the vm_fault_t return type, change the type definition
> > > > to no longer be compatible with 'int'. By making it an unsigned
> > > > int, the function prototype becomes incompatible with a function
> > > > which returns int. Sparse will detect any attempts to return a
> > > > value which is not a VM_FAULT code.
> > >
> > >
> > > > -/* Encode hstate index for a hwpoisoned large page */
> > > > -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> > > > -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> > > ...
> > > > +/* Encode hstate index for a hwpoisoned large page */
> > > > +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> > > > +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> > >
> > > I think it's important to mention in the changelog that these values
> > > have been changed to avoid conflicts with other VM_FAULT codes.
> > >
> > > > +/**
> > > > + * typedef vm_fault_t -  __bitwise unsigned int
> > > > + *
> > > > + * vm_fault_t is the new unsigned int type to return VM_FAULT
> > > > + * code by page fault handlers of drivers/file systems. Now if
> > > > + * any page fault handlers returns non VM_FAULT code instead
> > > > + * of VM_FAULT code, it will be a mismatch with function
> > > > + * prototype and sparse will detect it.
> > > > + */
> > >
> > > The first line should be what the typedef *means*, not repeat the
> > > compiler's definition.  The rest of the description should be information
> > > for someone coming to the type for the first time; what you've written
> > > here is changelog material.
> > >
> > > /**
> > >  * typedef vm_fault_t - Return type for page fault handlers.
> > >  *
> > >  * Page fault handlers return a bitmask of %VM_FAULT values.
> > >  */
> > >
> > > > +typedef __bitwise unsigned int vm_fault_t;
> > > > +
> > > > +/**
> > > > + * enum - VM_FAULT code
> > >
> > > Can you document an anonymous enum?  I've never tried.  Did you run this
> > > through 'make htmldocs'?
> >
> > You cannot document an anonymous enum.
> 
> 
> I assume, you are pointing to Document folder and I don't know if this
> enum need to be documented or not.

The enum should be documented, even if it's documentation is (yet) not
linked anywhere in the Documentation/
 
> I didn't run 'make htmldocs' as there is no document related changes.

You can verify that kernel-doc can parse your documentation by running

scripts/kernel-doc -none -v <filename>

> >
> > > > + * This enum is used to track the VM_FAULT code return by page
> > > > + * fault handlers.
> > >
> > >  * Page fault handlers return a bitmask of these values to tell the
> > >  * core VM what happened when handling the fault.
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> 

-- 
Sincerely yours,
Mike.

