Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F1C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uqwYQN4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F1C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbeG3PF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:05:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeG3PF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:05:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UDT72Q152558
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=w8cJnMlMTVvhmpqHOrQyrXCgRfDvLFxNh07Vmz04Sjs=;
 b=uqwYQN4vag6BBtxd0GRsMnJDeg78SQv8gUtRQvLky4k5WqmAs7yEgdHVhVCplGlcNaD7
 P29UGhBaYIfDsdvnA2UV40XpycRXPdafKJPEJ9dq6bUpqjXGhyfMoT89HPjnmSEX7oZm
 u6hTKIQjcCFXlCDrRYAOHUHowEfVg8ERYWOhqKoZXADykBCVoVIs0E1XaTQNec02kamU
 xL9bkO9Au/a1mFmiDCWr5iJWbHmCyPa2+aaUkCjq/fc2CdHS8zkyVL/taapwurbIbu8l
 vL1MI3tjVknk96ioMbSQ9BJnZrPWaWDj/0iXfpqesDxw2ukHGvZaOG7Oj7UoXzfLqSB0 OQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kgfwsvgj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:30:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6UDUqDA001255
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:30:52 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6UDUpFF013112
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:30:51 GMT
Received: from mail-oi0-f41.google.com (/209.85.218.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 06:30:51 -0700
Received: by mail-oi0-f41.google.com with SMTP id w126-v6so21203207oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:30:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlFj3FHi7sJBAsO3Lc+iP86Oc86iTcn+MTi9mYch7l+GwK6QUKeR
        HApMy0h/LMYtvrXMpzVapquE56TKcJ4NfkBdbS8=
X-Google-Smtp-Source: AAOMgpeqLLt7NMHCy+ovSrdt6loEhpUsBRMtLDBulQXm5e3QUs9Pxmcii2z5eehg1Kw81dJzVDCEGUNm95voM68hs9s=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr16712167oig.221.1532957450740;
 Mon, 30 Jul 2018 06:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180727165454.27292-1-david@redhat.com> <20180730113029.GM24267@dhcp22.suse.cz>
 <6cc416e7-522c-a67e-2706-f37aadff084f@redhat.com> <20180730120529.GN24267@dhcp22.suse.cz>
 <7b58af7b-5187-2c76-b458-b0f49875a1fc@redhat.com>
In-Reply-To: <7b58af7b-5187-2c76-b458-b0f49875a1fc@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 30 Jul 2018 09:30:14 -0400
X-Gmail-Original-Message-ID: <CAGM2reahiWj5LFq1npRpwK2k-4K-L9hr3AHUV9uYcmT2s3Bnuw@mail.gmail.com>
Message-ID: <CAGM2reahiWj5LFq1npRpwK2k-4K-L9hr3AHUV9uYcmT2s3Bnuw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: inititalize struct pages when adding a section
To:     david@redhat.com
Cc:     mhocko@kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, jack@suse.cz, mawilcox@microsoft.com,
        jglisse@redhat.com, Souptick Joarder <jrdr.linux@gmail.com>,
        kirill.shutemov@linux.intel.com, Vlastimil Babka <vbabka@suse.cz>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        malat@debian.org, Mel Gorman <mgorman@suse.de>,
        iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 8:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.07.2018 14:05, Michal Hocko wrote:
> > On Mon 30-07-18 13:53:06, David Hildenbrand wrote:
> >> On 30.07.2018 13:30, Michal Hocko wrote:
> >>> On Fri 27-07-18 18:54:54, David Hildenbrand wrote:
> >>>> Right now, struct pages are inititalized when memory is onlined, not
> >>>> when it is added (since commit d0dc12e86b31 ("mm/memory_hotplug: optimize
> >>>> memory hotplug")).
> >>>>
> >>>> remove_memory() will call arch_remove_memory(). Here, we usually access
> >>>> the struct page to get the zone of the pages.
> >>>>
> >>>> So effectively, we access stale struct pages in case we remove memory that
> >>>> was never onlined. So let's simply inititalize them earlier, when the
> >>>> memory is added. We only have to take care of updating the zone once we
> >>>> know it. We can use a dummy zone for that purpose.
> >>>
> >>> I have considered something like this when I was reworking memory
> >>> hotplug to not associate struct pages with zone before onlining and I
> >>> considered this to be rather fragile. I would really not like to get
> >>> back to that again if possible.
> >>>
> >>>> So effectively, all pages will already be initialized and set to
> >>>> reserved after memory was added but before it was onlined (and even the
> >>>> memblock is added). We only inititalize pages once, to not degrade
> >>>> performance.
> >>>
> >>> To be honest, I would rather see d0dc12e86b31 reverted. It is late in
> >>> the release cycle and if the patch is buggy then it should be reverted
> >>> rather than worked around. I found the optimization not really
> >>> convincing back then and this is still the case TBH.
> >>>
> >>
> >> If I am not wrong, that's already broken in 4.17, no? What about that?
> >
> > Ohh, I thought this was merged in 4.18.
> > $ git describe --contains d0dc12e86b31 --match="v*"
> > v4.17-rc1~99^2~44
> >
> > proves me wrong. This means that the fix is not so urgent as I thought.
> > If you can figure out a reasonable fix then it should be preferable to
> > the revert.
> >
> > Fake zone sounds too hackish to me though.
> >
>
> If I am not wrong, that's the same we had before d0dc12e86b31 but now it
> is explicit and only one single value for all kernel configs
> ("ZONE_NORMAL").
>
> Before d0dc12e86b31, struct pages were initialized to 0. So it was
> (depending on the config) ZONE_DMA, ZONE_DMA32 or ZONE_NORMAL.
>
> Now the value is random and might not even be a valid zone.

Hi David,

Have you figured out why we access struct pages during hot-unplug for
offlined memory? Also, a panic trace would be useful in the patch.

As I understand the bug may occur only when hotremove is enabled, and
default onlining of added memory is disabled. Is this correct? I
suspect the reason we have not heard about this bug is that it is rare
to add memory and not to online it.

Thank you,
Pavel
