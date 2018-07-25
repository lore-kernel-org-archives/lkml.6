Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1C20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gv8xbmnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B1C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeGYOoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:44:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeGYOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:44:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PDSkYq073303
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=ouZhRUno+yhT7ja8hhiKepUlXSAvtL2erzA+uKY3vdY=;
 b=gv8xbmnRyzJy97JrVfi2roPFvAElCNpP5ZiZQZaICfrBxFhbr+bbVVplP0nQqQuO/NFu
 eU1WuZMXCDm/luPcRuIj18e6QMjmsbvI8p+zUfnLnLX3Exq1/nCoq+a6UKOu26aV0bSb
 CVPb1TK88Mc2QX3Pfsp6HYmqTADkhn2VXDmaVDu2bvkxmZoOLXY2lzlcHynaethgZRXc
 kw0oNhHMcU4N941DQVrTfQigS3DUywN47Xg6mSCQE7KI5Gaw0P2Eelp00jE3vxl59OUc
 TX8Rt+BfV9KqZLJv9imw9JlnuVFqijVO+xFeE4cUNr4MM7C89lXnOxLtS+Z4hZJuOD9T hw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kbv8t5dmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:33:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6PDX8U9001003
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:33:09 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6PDX81Z000480
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:33:08 GMT
Received: from mail-oi0-f45.google.com (/209.85.218.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 06:33:08 -0700
Received: by mail-oi0-f45.google.com with SMTP id y207-v6so13858533oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 06:33:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlFjjyAXv411PCoARzWsdo4R7SWZawhoTGj9towvR5KeB1wUjh6h
        ASpu6gNYFk1m4QGDDUsG8HOocnj6CFOYrs2cPoo=
X-Google-Smtp-Source: AAOMgpfuX+Qj4sl2GNF214UuNuu32KIc3LSP9u0o6P7i+FyaRFBjbp4Nq5Ah15DgeqM7uMxt0JSjeIbv5FbNBrrs8xI=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr3512372oia.229.1532525587474;
 Wed, 25 Jul 2018 06:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-3-pasha.tatashin@oracle.com> <20180725121459.GA16987@techadventures.net>
In-Reply-To: <20180725121459.GA16987@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 25 Jul 2018 09:32:31 -0400
X-Gmail-Original-Message-ID: <CAGM2reZJHc4NYFnQPxJ3wwYXAnicVSqZzndHHpZFeeKHAmzY2Q@mail.gmail.com>
Message-ID: <CAGM2reZJHc4NYFnQPxJ3wwYXAnicVSqZzndHHpZFeeKHAmzY2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: calculate deferred pages after skipping mirrored memory
To:     osalvador@techadventures.net
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 8:15 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Tue, Jul 24, 2018 at 07:55:19PM -0400, Pavel Tatashin wrote:
> > update_defer_init() should be called only when struct page is about to be
> > initialized. Because it counts number of initialized struct pages, but
> > there we may skip struct pages if there is some mirrored memory.
> >
> > So move, update_defer_init() after checking for mirrored memory.
> >
> > Also, rename update_defer_init() to defer_init() and reverse the return
> > boolean to emphasize that this is a boolean function, that tells that the
> > reset of memmap initialization should be deferred.
> >
> > Make this function self-contained: do not pass number of already
> > initialized pages in this zone by using static counters.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >  mm/page_alloc.c | 40 ++++++++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cea749b26394..86c678cec6bd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -306,24 +306,28 @@ static inline bool __meminit early_page_uninitialised(unsigned long pfn)
> >  }
> >
> >  /*
> > - * Returns false when the remaining initialisation should be deferred until
> > + * Returns true when the remaining initialisation should be deferred until
> >   * later in the boot cycle when it can be parallelised.
> >   */
> > -static inline bool update_defer_init(pg_data_t *pgdat,
> > -                             unsigned long pfn, unsigned long zone_end,
> > -                             unsigned long *nr_initialised)
> > +static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> >  {
> > +     static unsigned long prev_end_pfn, nr_initialised;
> > +
> > +     if (prev_end_pfn != end_pfn) {
> > +             prev_end_pfn = end_pfn;
> > +             nr_initialised = 0;
> > +     }
> Hi Pavel,
>
> What about a comment explaining that "if".
> I am not the brightest one, so it took me a bit to figure out that we got that "if" there
> because now that the variables are static, we need to somehow track whenever we change to
> another zone.

Hi Oscar,

Hm, yeah a comment would be appropriate here. I will send an updated
patch. I will also change the functions from inline to normal
functions as Andrew pointed out: it is not a good idea to use statics
in inline functions.

Thank you,
Pavel
