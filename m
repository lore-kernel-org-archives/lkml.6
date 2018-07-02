Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB7E253CA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d1xLec7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB7E253CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932917AbeGBCSv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:18:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbeGBCSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:18:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w622DjgB073010
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=v/54G4QZ2UHf5qE8KA1juWd+B4a5d91MenzoGEe81B4=;
 b=d1xLec7Zc5DIsl/R8a33QNzPWjxpIj6ssqDmERtdDp0e2/SNhR6n4qRb16nfEOvAaASw
 DYLFDGtTF/MeKV/fby9ptH2x9GZiZLpqG3o3CV0Ib/3Uzfp8ATmqVlGDt+MYpgSt0l46
 JW7QPMqe5pfyNGy+mn2kOboIguRqBIHGoBbDgK5OT4XR6w19/depGxFfw56WtC0HC6ay
 b3ZDBe4eDlVencUimM4egO/vbIv5qCdWdp4EKNJosBSz/psoYKTPxkZzpwX+ILJC0j6K
 f0i984JiW5D9ZGiOnsVVpvlVK8Yvx3gSHu7j4rroq/V4H7Yp/ZcwLdFYpY3FgoSL+Y77 yg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jx19sjm7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:18:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w622IiTb029347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:18:44 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w622IitR005815
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:18:44 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 19:18:44 -0700
Received: by mail-oi0-f51.google.com with SMTP id m2-v6so5605185oim.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 19:18:44 -0700 (PDT)
X-Gm-Message-State: APt69E1ZMKvd518GlqI6gEgJ3fTtB6hHiuO8A0Bxj4GTBNDGT+BVnBF5
        p/Lb6L2PLMdWxkGpl0rGUtjmoGc/xOr2NsFReFM=
X-Google-Smtp-Source: AAOMgpemHqAR10PmQgEDP1KgIQ1U+ZmDpc3tIJnNtdVoE/0tUcGzspQTEICCAV+NxsrGSYIw5VW9QRJPrMa02ZgH5H4=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr14555749oig.339.1530497924195;
 Sun, 01 Jul 2018 19:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <20180702021121.GL3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702021121.GL3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 22:18:08 -0400
X-Gmail-Original-Message-ID: <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com>
Message-ID: <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here, I think it might be not right to jump to 'failed' directly if one
> section of the node failed to populate memmap. I think the original code
> is only skipping the section which memmap failed to populate by marking
> it as not present with "ms->section_mem_map = 0".
>

Hi Baoquan,

Thank you for a careful review. This is an intended change compared to
the original code. Because we operate per-node now, if we fail to
allocate a single section, in this node, it means we also will fail to
allocate all the consequent sections in the same node and no need to
check them anymore. In the original code we could not simply bailout,
because we still might have valid entries in the following nodes.
Similarly, sparse_init() will call sparse_init_nid() for the next node
even if previous node failed to setup all the memory.

Pavel
