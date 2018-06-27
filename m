Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA6EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CD625D8E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uljN4Brw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD625D8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935089AbeF0RsM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:48:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38666 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934627AbeF0RsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:48:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5RHdXOZ105372
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=WJ9yV/ShHcBKhdSFN0ip8XOS0BKKZdSKcIUg3X5aE0g=;
 b=uljN4Brw/By/xwjwrVOVdSfDM/HXB31Z5FqPqc8yqeV0yMLrBfrBygKX0T7iQ7KFmzsK
 Ft1k2FruXjn3eNt7wotLD6/OcArIPlbDvD2RqQFDDEjDBGLdAGe0EUaOk77Lpe6cEcck
 8aTFTUt4neJxot+12Tk9n03IZbQbX7wyIy1QjHqRjn6kOky4enkfLJA6vtVn7ytPPOrD
 39JmNJpVVn4ipKbC9kVN4ZsoRXhA1DGRLkr/dSKsycxUUYFxF6qMdYLTjlMOKvGPVHJt
 LhCYgiMlEecduGvRLb3aL96gXbi8HLq4lh3Umxj6J/BpExI75AmkttY/6skzT9H+FxkU 0g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jukhsdyng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 17:48:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5RHm8vQ030368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 17:48:08 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5RHm8sm018004
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 17:48:08 GMT
Received: from mail-ot0-f179.google.com (/74.125.82.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 10:48:08 -0700
Received: by mail-ot0-f179.google.com with SMTP id w22-v6so3135155otk.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:48:08 -0700 (PDT)
X-Gm-Message-State: APt69E3exzsM8ggnvsiMudytCHbAeehl5fhTUngU046RYvCSa+Ksnq2a
        Jt5631VltoG+X8dQ7JxIjksLBlm93MU2j2j/TQs=
X-Google-Smtp-Source: AAOMgpdvgdv/Ww/1uJpMpcrZYLvKwL7FYd/XtPxRzpP7PkTiKoW9DfPgcT8opEju+Il06o1GqK3IOngVQCgJ6nua4u4=
X-Received: by 2002:a9d:20c5:: with SMTP id x63-v6mr781927ota.11.1530121684537;
 Wed, 27 Jun 2018 10:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com>
In-Reply-To: <20180627013116.12411-1-bhe@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 27 Jun 2018 13:47:28 -0400
X-Gmail-Original-Message-ID: <CAGM2reYKn80fn8Nb_AT4ybVih4c7cd8+U1nDfJ-C0fwM+DB4jw@mail.gmail.com>
Message-ID: <CAGM2reYKn80fn8Nb_AT4ybVih4c7cd8+U1nDfJ-C0fwM+DB4jw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mm/sparse: Optimize memmap allocation during sparse_init()
To:     bhe@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=633
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work made me think why do we even have
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER ? This really should be the
default behavior for all systems. Yet, it is enabled only on x86_64.
We could clean up an already messy sparse.c if we removed this config,
and enabled its path for all arches. We would not break anything
because if we cannot allocate one large mmap_map we still fallback to
allocating a page at a time the same as what happens when
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=n.

Pavel
