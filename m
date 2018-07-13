Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71CB2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKTiaZnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71CB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeGMLZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:25:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53106 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeGMLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:25:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DB3tCQ141842
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=Y6rkzpdUVm1ogzKSqKirwvVGObETzHyD6kawtwV/hhQ=;
 b=hKTiaZnbwPM0QAH5Dxo0X4NoSzE44+Saae+3fvlNZg/lQll1pLxUN6bgSEj4fkkpC2U7
 HJOl3oz4MeXdlGf9hjpPN6ybaFo59y9WG8FCjv/cLG9ZGKbWTNi2aptvnT2JDZbY/9JM
 Ck7zMUu2kILWMX7qOWvT/KtVf4Y0J4H4eKI4tQ/GGOVzO5f8PYr94FQEn7QynVFXASBP
 Xz5QLoP0VpHzaupZPiN4fHPOgjZfRsGKYz2FIgSRRkLEtP6EQ//Y2JaoX1NCtjhDZfqT
 +X309CEc+psrdrr84N0zpRgFxBWScIKUqWxvdQ0qtsTg2XxrmL8rz++dCv030P1M2mS8 JA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2k2p76fbk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:11:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBBJUn015476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:11:19 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6DBBIs6002248
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:11:19 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 04:11:18 -0700
Received: by mail-oi0-f47.google.com with SMTP id k12-v6so61487965oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:11:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlG94PkHtu4nbLmLxcd44IHW5o2qhJMb0mvvFYd3iodiBZ55GpS1
        R1RhOM+vC+7o6ipBsrPn3W0emTBcSSdv5yk6BHY=
X-Google-Smtp-Source: AAOMgpep60XNL+5vxIv5v/6p+JVNdSBWg0Ucc13fe7RJUAqV5MZOzjDFlP6a9SwhR9V8HCYEiEH2O3DXgcrU4d7y+7Q=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr6894561oia.156.1531480278151;
 Fri, 13 Jul 2018 04:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180712203730.8703-1-pasha.tatashin@oracle.com> <20180713095934.GB15039@techadventures.net>
In-Reply-To: <20180713095934.GB15039@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 13 Jul 2018 07:10:42 -0400
X-Gmail-Original-Message-ID: <CAGM2reavPdp48_=cw1g3Jmz2+ZLU9DkOQbdwAu17v39OCkjVPg@mail.gmail.com>
Message-ID: <CAGM2reavPdp48_=cw1g3Jmz2+ZLU9DkOQbdwAu17v39OCkjVPg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] sparse_init rewrite
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> About PPC64, your patchset fixes the issue as the population gets followed by a
> sparse_init_one_section().
>
> It can be seen here:
>
> Before:
>
> kernel: vmemmap_populate f000000000000000..f000000000004000, node 0
> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
> kernel: vmemmap_populate f000000000000000..f000000000008000, node 0
> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
> kernel: vmemmap_populate f000000000000000..f00000000000c000, node 0
> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
>
>
> After:
>
> kernel: vmemmap_populate f000000000000000..f000000000004000, node 0
> kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
> kernel: vmemmap_populate f000000000000000..f000000000008000, node 0
> kernel: vmemmap_populate f000000000000000..f00000000000c000, node 0
> kernel: vmemmap_populate f000000000000000..f000000000010000, node 0
> kernel: vmemmap_populate f000000000010000..f000000000014000, node 0
> kernel:       * f000000000010000..f000000000020000 allocated at (____ptrval____)
>
>
> As can be seen, before the patchset, we keep calling vmemmap_create_mapping() even if we
> populated that section already, because of vmemmap_populated() checking for SECTION_HAS_MEM_MAP.
>
> After the patchset, since each population is being followed by a call to sparse_init_one_section(),
> when vmemmap_populated() gets called, we have SECTION_HAS_MEM_MAP already in case the section
> was populated.

Hi Oscar,

Right, I also like that this solution removes one extra loop, thus
reduces the code size. We were populating pages in one place, and then
loop again to set sections, now we do both in one place, but still
allow preallocation of memory to reduces fragmentation on all
platforms. However, I still wanted to see if someone could test on
real hardware.

Thank you,
Pavel
