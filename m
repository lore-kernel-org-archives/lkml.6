Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A04C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EECA27070
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltVVuOtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EECA27070
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966675AbeF2P4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:56:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934265AbeF2P4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:56:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TFrZ2j174536
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=TY1YYAcIHzAo9BBk7NLTm4ti7dXwo5mERv4FwCyNrps=;
 b=ltVVuOtL+lQ5tUMCLuWBwOU364mq5cC7o7zyrsP8U4TWMcVTiv406EuegPPt+4BgcyPs
 6SeFLHlFmO7uKER/HqEcvbXPJH8biW14BgxEJzBhUNU/Mz7t+AeuvLJZG12BPeCkJYez
 fsgfsyp8sBHXdtRGcpK608XB4RpnhhRPPIfhovKe2/UOl37t/ki4AQ3+g4LPZ4Z/4/uM
 FerZgRkxT/rwVtEN/LA+J5wH8Uj/GDMqp+P9HCDz+R+Bsf7hVa14V/KRTLvvzOgU8nWz
 LGJVjqvlxYvOKUtIrCFQjeo9Xb1xM6l5WYJCVqU26U1TOVjnFJaDCubN2VLIh5n//1CO 5A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum5871hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:56:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TFuZhv009055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:56:36 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5TFuZQI013447
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:56:35 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 08:56:35 -0700
Received: by mail-oi0-f51.google.com with SMTP id s198-v6so5009719oih.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:56:35 -0700 (PDT)
X-Gm-Message-State: APt69E0HghrePzg1bRM2qVeEv9v3dSnAoaTGgIE93/Qwci28WZefNlQC
        vry1VXt4nDuUZ7rsKSLKTCs5YJBChEh63kkNHjY=
X-Google-Smtp-Source: AAOMgpdkE/xLF9eindvH6zrOEv0hWh9WTIeEYbXEiyg1BjnxsZT3zrODj/j1xnrpMYD3lupKODxhQbGIAAh4tv1gkhM=
X-Received: by 2002:aca:3243:: with SMTP id y64-v6mr9135305oiy.136.1530287795160;
 Fri, 29 Jun 2018 08:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180628173010.23849-1-pasha.tatashin@oracle.com>
 <20180628173010.23849-3-pasha.tatashin@oracle.com> <20180629144059.GB23545@techadventures.net>
In-Reply-To: <20180629144059.GB23545@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 11:55:59 -0400
X-Gmail-Original-Message-ID: <CAGM2reZV7tG0FEZV94_-6EXxBEwXkZSuoSn93M=8s4VmRNDCPA@mail.gmail.com>
Message-ID: <CAGM2reZV7tG0FEZV94_-6EXxBEwXkZSuoSn93M=8s4VmRNDCPA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
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
        rientjes@google.com, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=715
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> besides this first for_each_present_section_nr(), what about writing a static inline
> function that returns next_present_section_nr(-1) ?
>
> Something like:
>
> static inline int first_present_section_nr(void)
> {
>         return next_present_section_nr(-1);
> }

Good idea, will add it, thank you.

Pavel
