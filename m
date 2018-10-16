Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1102020881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1102020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJPPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:25:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbeJPPZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:25:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9G7XcSW035509
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 03:36:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n5ayy9wne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 03:36:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 16 Oct 2018 08:36:35 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Oct 2018 08:36:32 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9G7aVj215728812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Oct 2018 07:36:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C81A4057;
        Tue, 16 Oct 2018 10:36:01 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE077A4040;
        Tue, 16 Oct 2018 10:36:00 +0100 (BST)
Received: from osiris (unknown [9.152.212.171])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Oct 2018 10:36:00 +0100 (BST)
Date:   Tue, 16 Oct 2018 09:36:29 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG -next 20181008] list corruption with "mm/slub: remove
 useless condition in deactivate_slab"
References: <20181009063500.GB3555@osiris>
 <CAFgQCTsnWRyN--dS0oVCzPykkt33M=9so2sv2a3+iu-kCdpV7A@mail.gmail.com>
 <CAFgQCTtQ2+bu44top5Fy=7KWRVrpFLnsRGupksK1ixR9oFZs+g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFgQCTtQ2+bu44top5Fy=7KWRVrpFLnsRGupksK1ixR9oFZs+g@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18101607-0008-0000-0000-000002800708
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101607-0009-0000-0000-000021E9652B
Message-Id: <20181016073629.GA3194@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:29:28PM +0800, Pingfan Liu wrote:
> > I think it is caused by the uinon page->lru and page->next. It can be fixed by:
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index 3a1a1db..4aa0fb5 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -56,6 +56,7 @@ struct kmem_cache_cpu {
> >  #define slub_set_percpu_partial(c, p)          \
> >  ({                                             \
> >         slub_percpu_partial(c) = (p)->next;     \
> > +       p->next = NULL; \
> >  })
> >
> > I will do some test and post the fix.
> >
> Please ignore the above comment. And after re-check the code, I am
> sure that all callers of deactivate_slab(), pass c->page, which means
> that page should not be on any list. But your test result "list_add
> double add: new=000003d1029ecc08,
> prev=000000008ff846d0,next=000003d1029ecc08"  indicates that
> page(new) is already on a list. I think that maybe something else is
> wrong which is covered.
> I can not reproduce this bug on x86. Could you share your config and
> cmdline? Any do you turn on any debug option of slub?

You can re-create the config with "make ARCH=s390 debug_defconfig".

Not sure which machine I used to reproduce this but most likely it was
a machine with these command line options:

dasd=e12d root=/dev/dasda1 userprocess_debug numa_debug sched_debug
ignore_loglevel sclp_con_drop=1 sclp_con_pages=32 audit=0
crashkernel=128M ignore_rlimit_data

You can ignore the dasd and sclp* command line options. These are
s390 specific. The rest should be available on any architecture.

