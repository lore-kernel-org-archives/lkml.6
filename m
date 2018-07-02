Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD578C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936A024438
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvvdVP+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936A024438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeGBSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:48:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeGBSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:47:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62Ihi4K045846
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 18:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=ZIkE43OsP+f1wxQnMisjMJTu0aHy09tgboJbEKPjTB0=;
 b=JvvdVP+Ylyu9lQJ72pjKX1dGLxUHwf8xvEAxt/ZFJVUH4Uosegr44/nMzIz4s17mNHh/
 OfS7KqvFACmmZTgU6BGqvl4KI46A7kId0CqbYydpIqhqBmaGrrsLDROMZjHJ84E13/oy
 TX62t/15Vn6KA1pbRiZC8NF7WhxpfnVOrgp66yyt+r8+KvW8ewD+yCHIz4Xt+1K1Rb4h
 OCq9IC26JR2bsgFEI2H4l9Y06HFGmnD7hOn7K600PDsKYeji0/v7yZjGLjsD5Zld4GUS
 Z0J0QQkAlVa2vE28YmwKaqOkKbWCWIuEDKpGzVW1dbdWMi1tsFHN/lh4980Y4HmKBfh2 rA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jx1tnwp28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 18:47:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w62Ilu97023014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 18:47:57 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62IlucV027851
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 18:47:56 GMT
Received: from mail-oi0-f50.google.com (/209.85.218.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 11:47:56 -0700
Received: by mail-oi0-f50.google.com with SMTP id w126-v6so10999205oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:47:56 -0700 (PDT)
X-Gm-Message-State: APt69E1y21Vw7oY6L24PYjCWarc+foeyJaoa0C2i4sb8LXHuZ8M8L5HT
        mioNLw7OlwaAhbnW82yZbD403wkSkQYvb/x4Kyg=
X-Google-Smtp-Source: AAOMgpfOevZqunnbXZlc3Jm/h45YuSxdvQbL7R65Lad9AaGamtJ3fcoMEIFk6L2c/vETsDBOEI/B7KO9Y2rMHUlbRKU=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr18189902oig.339.1530557276529;
 Mon, 02 Jul 2018 11:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180702154325.12196-1-osalvador@techadventures.net>
In-Reply-To: <20180702154325.12196-1-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 14:47:20 -0400
X-Gmail-Original-Message-ID: <CAGM2reZz3=OM7W_VbCGgnAMumo+AiPaG7sGUaichG_QNngYKsg@mail.gmail.com>
Message-ID: <CAGM2reZz3=OM7W_VbCGgnAMumo+AiPaG7sGUaichG_QNngYKsg@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: Make sparse_init_one_section void and remove check
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:43 AM <osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> sparse_init_one_section() is being called from two sites:
> sparse_init() and sparse_add_one_section().
> The former calls it from a for_each_present_section_nr() loop,
> and the latter marks the section as present before calling it.
> This means that when sparse_init_one_section() gets called, we already know
> that the section is present.
> So there is no point to double check that in the function.
>
> This removes the check and makes the function void.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thank you Oscar.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

> ---
>  mm/sparse.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
