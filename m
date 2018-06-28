Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54703C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF63F25E23
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VKovN3jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF63F25E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeF1DUD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:20:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57458 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbeF1DUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:20:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5S3J9RF122120
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=90CmZm36Pi4VWI7duTIG4R+1FJ2DdgHFg3dvS/8BaVU=;
 b=VKovN3jFe2KLf6aoXW1h5zBUBIWZiRAsXjwI2WS7UjzZasrcGZcy43Br8pz0TmzUbM1b
 MToBtdtGSBysTLYA4HtG6u4L0pXUSatRA2ZMW2BltKd8zSZZ+owJnykxv7ZUXcaBseG6
 gOkbGvaMVVaK8rIyenpWY08pA2v10ZbN7y+m48u7noyVNOgBI9tHfxRfjMWgLjNxMhVH
 kEUOszlwPtChR/kym7C5snz2KEar6RBmu5nTaTr+YZJcZyC32YWd1Js4vPibB3g06ash
 cvZNbVFU3f8IlCbWu3fd7/cad/C2KDftADOxveon8K2LJNQF5IX6wa6feYKF/xfCz6H6 Vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum58026f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:20:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5S3Jx8r013893
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:20:00 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5S3Jxvx000780
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:19:59 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 20:19:59 -0700
Received: by mail-oi0-f53.google.com with SMTP id n84-v6so3827789oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 20:19:58 -0700 (PDT)
X-Gm-Message-State: APt69E3wgDVhjEwLVErgYeoY4tw0wKsFNUkGNs5SRfmNnGtwfo2eeafx
        vUF+6VVQz5ABZgfuwhFKj9UCXQRjnlVnp8GfCQ8=
X-Google-Smtp-Source: AAOMgpdnFMtwXmhhouoD2sogDM6P2VVTM7kis21aiCsPjvEvquf81+HB4RLtPsSOadHXz2EJCVwDwYHZNRh+F5CxxgA=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr5053639oig.339.1530155998748;
 Wed, 27 Jun 2018 20:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com> <20180627013116.12411-5-bhe@redhat.com>
In-Reply-To: <20180627013116.12411-5-bhe@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 27 Jun 2018 23:19:22 -0400
X-Gmail-Original-Message-ID: <CAGM2reaWkmCF_DWY1jETsC=NOPC7TGFq3VX06YrTDLAp+X2+AQ@mail.gmail.com>
Message-ID: <CAGM2reaWkmCF_DWY1jETsC=NOPC7TGFq3VX06YrTDLAp+X2+AQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/sparse: Optimize memmap allocation during sparse_init()
To:     bhe@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=455
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Baoquan He <bhe@redhat.com>
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Please remove duplicated signed-off

>                 if (!usemap) {
>                         ms->section_mem_map = 0;
> +                       nr_consumed_maps++;

Currently, we do not set ms->section_mem_map to 0 when fail to
allocate usemap, only when fail to allocate mmap we set
section_mem_map to 0. I think this is an existing bug.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
