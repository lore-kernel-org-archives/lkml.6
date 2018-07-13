Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24454ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE8F2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pZUWZ4rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE8F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeGMLa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:30:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbeGMLa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:30:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DB3nhD138997
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=wbNbtvvIQV1t8e3EsQSmIXWWBY9bUFqK5Qxtm3raHvI=;
 b=pZUWZ4rJ8XncwPYnRwFGaFlmCIPMNq5KuQIpdaGfHfesUj+w90bdF+uiVnpAge0UuYO5
 RywPxWdZhpfT3B3m+NkJ/EVYch9R7ultV/Ad9Pd501vbxMrtZkTZSnLTttvzLwCZ6cSx
 bZQHmoxUbvmhsYLDrH1NtrJxKbiefN1FlQhpeMoa+WBMiLv6SoObE6L23DSxEdPudFB+
 XShWUQmQyekuv71PnJFVz0LW6yEwaUBD2ucVK97DE+Qhaya4SB4tHowT56+HOepkfL9i
 1/vvd15QW7utrm1shRWkcWfYQUmgVYb+I56WlpNdNQa+gwKeeICBFoOdwB7l0pHBna0L sA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k2p7vq9r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:16:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBGBhq029396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:16:11 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6DBGA2X014697
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:16:10 GMT
Received: from mail-oi0-f45.google.com (/209.85.218.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 04:16:10 -0700
Received: by mail-oi0-f45.google.com with SMTP id d189-v6so61519641oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:16:10 -0700 (PDT)
X-Gm-Message-State: AOUpUlE6EMFD/1LdNCkd59IP8jf+IvQYMrVIlNc6EiEsYpr2SiZhYMlJ
        aZpnDMZniNvjKQpavIf18IZH3YiJF0Bhm9hI0Vo=
X-Google-Smtp-Source: AAOMgpckE/oSkHQ+18vCN/VZRMdD6Nw+80FZgGYG3OjaGtwKVYseDxmf42mUfqhLyQAGERyFYxzUe+OkDStpqg1IrgU=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr6788094oia.229.1531480570291;
 Fri, 13 Jul 2018 04:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
 <20180712203730.8703-6-pasha.tatashin@oracle.com> <20180713090949.GA15039@techadventures.net>
In-Reply-To: <20180713090949.GA15039@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 13 Jul 2018 07:15:34 -0400
X-Gmail-Original-Message-ID: <CAGM2reZs_jvgCXfu7Rd6bmQiRhYZQQC18oAFxe5j0jA+Ndt2rQ@mail.gmail.com>
Message-ID: <CAGM2reZs_jvgCXfu7Rd6bmQiRhYZQQC18oAFxe5j0jA+Ndt2rQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] mm/sparse: delete old sprase_init and enable new one
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 5:09 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
>
> > -#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> > -static void __init sparse_early_mem_maps_alloc_node(void *data,
> > -                              unsigned long pnum_begin,
> > -                              unsigned long pnum_end,
> > -                              unsigned long map_count, int nodeid)
> > -{
> > -     struct page **map_map = (struct page **)data;
> > -
> > -     sparse_buffer_init(section_map_size() * map_count, nodeid);
> > -     sparse_mem_maps_populate_node(map_map, pnum_begin, pnum_end,
> > -                                      map_count, nodeid);
> > -     sparse_buffer_fini();
> > -}
>
> From now on, sparse_mem_maps_populate_node() is not being used anymore, so I guess we can just
> remove it from sparse.c, right? (as it is done in sparse-vmemmap.c).

Missed this one, even more code can be deleted! :) I will include this
in updated patches, after review comments.

Thank you,
Pavel

> --
> Oscar Salvador
> SUSE L3
>
