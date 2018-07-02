Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C74824F22
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELIiFLeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C74824F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeGBUMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:12:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGBUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:12:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62K9Uve071538
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=DES1M921eeKjlRonDOHuV8f9yX3mY/spvPlrqQMM1jk=;
 b=ELIiFLeVx56rCn6Ohb5X0Ph8CVuSeZutO2Efx8Tw/48FBWQTy7pVINA0eSv4x1oXVK2W
 /AU/rF16dkmWwknvlNk56wIiOCyuqz/6CMgiYP5VYE6oUm3AO3OGC1Na9RlMfzo5+Gre
 XOhKVujZOLFoVEqxxgHznpq73WcTJ0k8lJYzsjOFVS9pk+g7UogtEcGcEIWl/QVWw/D1
 A9QncJB6N2Pwm//yxMULsqBM/q8yXxnEEAN+vlcHt0+FI3qcUPQSqA1AT30NasHvqr3r
 iRnLTdgpEHf9PXZI/Lw7fXIQe/x9yrxgzJ3OFGUNZWAltT1kysDWeZLW+3ePFizeNArp 1g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jx2gpwus5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:12:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w62KCoiI004939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:12:50 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62KCoEv016209
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:12:50 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 13:12:49 -0700
Received: by mail-oi0-f47.google.com with SMTP id s198-v6so14890011oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:12:49 -0700 (PDT)
X-Gm-Message-State: APt69E1e5wfx/Y+E14BAiP3kSXr4zal1lwUm91FkI2DjxihQXWu6FjFr
        pmHOmWJGwtjl40fQE8LyoDanqnoOwKikZEfFjDA=
X-Google-Smtp-Source: AAOMgpdibw3MHUn5JksnqiyfgrENPYwM5nhdkmyZZR8N3h5MDZK1CNB+hdz7VWFv5juBl8fSraZXz+cupbj43ImBfcU=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr11687904oig.221.1530562369270;
 Mon, 02 Jul 2018 13:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-3-pasha.tatashin@oracle.com> <552d5a9b-0ca9-cc30-d8c2-33dc1cde917f@intel.com>
 <b227cf00-a1dd-5371-aafd-9feb332e9d02@oracle.com> <38a2629d-689c-4592-9bd7-a77ab1b2045c@intel.com>
In-Reply-To: <38a2629d-689c-4592-9bd7-a77ab1b2045c@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 16:12:12 -0400
X-Gmail-Original-Message-ID: <CAGM2reb5KG1k1A9NRk8XZ6GyJ3AejvE0WN0CNr9WH4UvSEGLZg@mail.gmail.com>
Message-ID: <CAGM2reb5KG1k1A9NRk8XZ6GyJ3AejvE0WN0CNr9WH4UvSEGLZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
To:     dave.hansen@intel.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, rientjes@google.com,
        mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=735
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:00 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 07/02/2018 12:54 PM, Pavel Tatashin wrote:
> >
> >
> > On 07/02/2018 03:47 PM, Dave Hansen wrote:
> >> On 07/01/2018 07:04 PM, Pavel Tatashin wrote:
> >>> +   for_each_present_section_nr(pnum_begin + 1, pnum_end) {
> >>> +           int nid = sparse_early_nid(__nr_to_section(pnum_end));
> >>>
> >>> +           if (nid == nid_begin) {
> >>> +                   map_count++;
> >>>                     continue;
> >>>             }
> >>
> >>> +           sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
> >>> +           nid_begin = nid;
> >>> +           pnum_begin = pnum_end;
> >>> +           map_count = 1;
> >>>     }
> >>
> >> Ugh, this is really hard to read.  Especially because the pnum "counter"
> >> is called "pnum_end".
> >
> > I called it pnum_end, because that is what is passed to
> > sparse_init_nid(), but I see your point, and I can rename pnum_end to
> > simply pnum if that will make things look better.
>
> Could you just make it a helper that takes a beginning pnum and returns
> the number of consecutive sections?

But sections do not have to be consequent. Some nodes may have
sections that are not present. So we are looking for two values:
map_count -> which is number of present sections and node_end for the
current node i.e. the first section of the next node. So the helper
would need to return two things, and would basically repeat the same
code that is done in this function.

>
> >> So, this is basically a loop that collects all of the adjacent sections
> >> in a given single nid and then calls sparse_init_nid().  pnum_end in
> >> this case is non-inclusive, so the sparse_init_nid() call is actually
> >> for the *previous* nid that pnum_end is pointing _past_.
> >>
> >> This *really* needs commenting.
> >
> > There is a comment before sparse_init_nid() about inclusiveness:
> >
> > 434 /*
> > 435  * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
> > 436  * And number of present sections in this node is map_count.
> > 437  */
> > 438 static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> > 439                                    unsigned long pnum_end,
> > 440                                    unsigned long map_count)
>
> Which I totally missed.  Could you comment the code, please?

Sure, I will add a comment into sparse_init() as well.
