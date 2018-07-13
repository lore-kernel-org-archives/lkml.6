Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780F32089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VPJB5CFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780F32089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGMMwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:52:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41698 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbeGMMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:52:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DCYA2l055774
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=uOajn5ShGIQ08Uf4JiFQzhE/+Po3zmUxdLgg/h/toqI=;
 b=VPJB5CFniuIii2D2h5NNBQi0xeqEQgGoOy/FwpvRASGT3OBiCXAt3unT2sOn9cb5umDj
 0tUWVURDxU+cUJocUEJXvTUAdDHgRMEGdd67FaP90gMS83bzSSFje/vVMwYrHIiMQyFo
 ZPPB0DmXTLjTz/7t7IxumUY++Lp5r245bZ3CF4mUByPNybqgzrQxfoRWJRufo3ly/KJc
 nuDMhdOoq6jALFC8GIHsRPZ1d/ubXdW4e/yXJOSLYldiiIxwneBMbhjqs17jxnmMEvfU
 KZGcEGa0xs8PoEMZDDoBceaESVesSQNsDMzYwvZZPOIcTU/0dtdbWpocMnILm5se4bqV aA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e7nv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:37:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DCbkjY005994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:37:46 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6DCbkDE031454
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:37:46 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 05:37:45 -0700
Received: by mail-oi0-f47.google.com with SMTP id k81-v6so61900010oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:37:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlGGGlaqqKZFIIoqlC8P7AW+xe9kDI1cmRPs4Sy/KpN13sSGaPLi
        B1eledy4/wQKRaBpnKExmZbVGtoP728VO6Mqenc=
X-Google-Smtp-Source: AAOMgpdkNNiW8Ygk4Ao6kdxdV4rad4RTRAHazUJTlr47YN+ZdWrogjHgtE+lP//gf2tE5ihE3140zloHJ9kBYtAdKp4=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr6219927oih.65.1531485465311;
 Fri, 13 Jul 2018 05:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
 <20180712203730.8703-5-pasha.tatashin@oracle.com> <20180713120340.GA16552@techadventures.net>
In-Reply-To: <20180713120340.GA16552@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 13 Jul 2018 08:37:09 -0400
X-Gmail-Original-Message-ID: <CAGM2reaE8hX=5x9bqp1-8+4Ax7UFTgHACoXiq4QvDc=-H8=0Bw@mail.gmail.com>
Message-ID: <CAGM2reaE8hX=5x9bqp1-8+4Ax7UFTgHACoXiq4QvDc=-H8=0Bw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] mm/sparse: add new sparse_init_nid() and sparse_init()
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=499
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>
> Looks good to me, and it will make the code much shorter/easier.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>

Thank you!

Pave
