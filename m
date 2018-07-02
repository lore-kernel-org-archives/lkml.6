Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6144DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B52433F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVfpknOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6B52433F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeGBD2p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:28:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33748 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeGBD2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:28:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w623P0ZB159052
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=wvHhgbO4yKNSAVhGyD4ISzgT3jQhv5ogNGTPOXGBynY=;
 b=fVfpknOIb5To4pRQivqxmGW+iv1wEbVbQLZ3NG0xfaPPxhDv5ZCpfS/MGHnftOvrGYRn
 +vUVg9zNw4L6EuMZ3zDtfU7RqYTY2bM+dQUWKXagFNe2gR8MDIEjfPXTfkvyHoB+EjOk
 /c/ii/OeHtWFWpiOFhAE1MdP+Si7pFFdIZeK+DiZwilv3M2AHBCEqjL+/So1n5fXvcXw
 ntJGAKcoXIyiFjg8JkDyfjizfV9cM0suuXV+3KL0SpAStaDaIJ3nFl/xcZBCoNQyqqnF
 9QetuzebVb93h7KBbSUo1IOixHxWYlDcUqY17f28xW0vYsSz4svhw+An/EpZMg3lTsUa JA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jx1tntp6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:28:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w623ScgA009967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:28:39 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w623ScjV016462
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:28:38 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 20:28:38 -0700
Received: by mail-oi0-f51.google.com with SMTP id m2-v6so5793744oim.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 20:28:38 -0700 (PDT)
X-Gm-Message-State: APt69E3IZkvyvqkU+aW6jq4oRzKgzOtbEKMORDID7aS8MPNG0ZdzVm8j
        4k1CJR/ZOtGk3c2bCZzCrrTFUHNAjzWt5ZWlXIo=
X-Google-Smtp-Source: AAOMgpcs05rKEyUB95WSkkD8UYfbCVuYWS0WpSL+oXkJD5zPUFW3yOXPIKB8YqDvgr4GaABJCRRywI/GJ9Lb+xSedJU=
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr8862450oig.163.1530502118146;
 Sun, 01 Jul 2018 20:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <20180702021121.GL3223@MiWiFi-R3L-srv>
 <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com>
 <20180702023130.GM3223@MiWiFi-R3L-srv> <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
 <20180702025343.GN3223@MiWiFi-R3L-srv> <CAGM2reatQzroymAb8kaPKgd8sEehtScH9DAELeWpYCaNNnAU6w@mail.gmail.com>
 <20180702031417.GP3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702031417.GP3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 23:28:01 -0400
X-Gmail-Original-Message-ID: <CAGM2reYBO11oaetHr0C4KgGegh9yUNZD0x4vzDW6bz8URUowcw@mail.gmail.com>
Message-ID: <CAGM2reYBO11oaetHr0C4KgGegh9yUNZD0x4vzDW6bz8URUowcw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
To:     bhe@redhat.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=573
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, on the first failure, we even stop trying to populate other
> > sections. No more memory to do so.
>
> This is the thing I worry about. In old sparse_mem_maps_populate_node()
> you can see, when not present or failed to populate, just continue. This
> is the main difference between yours and the old code. The key logic is
> changed here.
>

I do not see how  we can succeed after the first failure. We still
allocate from the same node:

sparse_mem_map_populate() may fail only if we could not allocate large
enough buffer vmemmap_buf_start earlier.

This means that in:
sparse_mem_map_populate()
  vmemmap_populate()
    vmemmap_populate_hugepages()
      vmemmap_alloc_block_buf() (no buffer, so call allocator)
        vmemmap_alloc_block(size, node);
            __earlyonly_bootmem_alloc(node, size, size, __pa(MAX_DMA_ADDRESS));
              memblock_virt_alloc_try_nid_raw() -> Nothing changes for
this call to succeed. So, all consequent calls to
sparse_mem_map_populate() in this node will fail as well.

> >
> Forgot mentioning it's the vervion in mm/sparse-vmemmap.c

Sorry, I do not understand what is vervion.

Thank you,
Pavel
