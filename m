Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5332B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5332B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeKFPpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:45:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729416AbeKFPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:45:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA66K4Ba168297
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 01:21:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nk573rxaa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:21:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 6 Nov 2018 06:21:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Nov 2018 06:21:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA66LaaY62980182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 06:21:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB56D11C05B;
        Tue,  6 Nov 2018 06:21:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C917811C050;
        Tue,  6 Nov 2018 06:21:35 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.135])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Nov 2018 06:21:35 +0000 (GMT)
Date:   Tue, 6 Nov 2018 08:21:34 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, riel@redhat.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Create the new vm_fault_t type
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
 <20181103120235.GA10491@bombadil.infradead.org>
 <20181104083611.GB7829@rapoport-lnx>
 <CAFqt6zaVUT0RGpz+jE4c7rb5prOtDhnxOy-NAiFM9G6jMwofVg@mail.gmail.com>
 <20181105091302.GA3713@rapoport-lnx>
 <CAFqt6zYbb9xpnOhhoESq3BbF4aD0_UKzh=MrwJ-i+NiUqNh7+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYbb9xpnOhhoESq3BbF4aD0_UKzh=MrwJ-i+NiUqNh7+Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110606-0008-0000-0000-0000028BE6AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110606-0009-0000-0000-000021F61E82
Message-Id: <20181106062133.GB4499@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 07:23:55PM +0530, Souptick Joarder wrote:
> On Mon, Nov 5, 2018 at 2:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Mon, Nov 05, 2018 at 11:14:17AM +0530, Souptick Joarder wrote:
> > > Hi Matthew,
> > >
> > > On Sun, Nov 4, 2018 at 2:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >
> > > > On Sat, Nov 03, 2018 at 05:02:36AM -0700, Matthew Wilcox wrote:
> > > > > On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:

> > > > > > +typedef __bitwise unsigned int vm_fault_t;
> > > > > > +
> > > > > > +/**
> > > > > > + * enum - VM_FAULT code
> > > > >
> > > > > Can you document an anonymous enum?  I've never tried.  Did you run this
> > > > > through 'make htmldocs'?
> > > >
> > > > You cannot document an anonymous enum.
> > >
> > > I assume, you are pointing to Document folder and I don't know if this
> > > enum need to be documented or not.
> >
> > The enum should be documented, even if it's documentation is (yet) not
> > linked anywhere in the Documentation/
> >
> > > I didn't run 'make htmldocs' as there is no document related changes.
> >
> > You can verify that kernel-doc can parse your documentation by running
> >
> > scripts/kernel-doc -none -v <filename>
> 
> I run "scripts/kernel-doc -none -v include/linux/mm_types.h" and it is showing
> below error and warning which is linked to enum in discussion.
> 
> include/linux/mm_types.h:612: info: Scanning doc for typedef vm_fault_t
> include/linux/mm_types.h:623: info: Scanning doc for enum
> include/linux/mm_types.h:628: warning: contents before sections
> include/linux/mm_types.h:660: error: Cannot parse enum!
> 1 errors
> 1 warnings
> 
> Shall I keep the documentation for enum or remove it from this patch ?

The documentation should be there, you just need to add a name for the
enum. Then kernel-doc will be able to parse it.
 
> > > >
> > > > > > + * This enum is used to track the VM_FAULT code return by page
> > > > > > + * fault handlers.
> > > > >

I think that the enum description should also include the text from the
comment that described VM_FAULT_* defines:

/*
 * Different kinds of faults, as returned by handle_mm_fault().
 * Used to decide whether a process gets delivered SIGBUS or
 * just gets major/minor fault counters bumped up.
 */



-- 
Sincerely yours,
Mike.

