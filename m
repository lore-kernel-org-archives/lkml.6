Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E731EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9995A24EE6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SriaIi3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995A24EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeGBUFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:05:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59178 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeGBUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:05:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62K4Xcq068300
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=TEJN8oA3WPnzr2WjHrynqpKAj8Q40GvinFvG8oiiKu0=;
 b=SriaIi3YB8Q8O0y0/lVUyciJNgY/VxNj6+3Rc5TlaNjwV1FxFpb7/gdkqf/c6M3AiImy
 khltJDFzGUEmPK76WyNjPf3nemvblfXykPUC15f1IksrFR1poQEWYL3DTXFNRzmDazyQ
 2wGSpXOyics/PfckTGmBkWs3RFaHgaxvo6G8faNTgmtRMPKGT278ORohyaxKZtGllz+g
 5eZmFItN/7kxu3DY8JSEiVL/AnMfIRA1/J+n8Az6XGHFoy3kda7RnBaHg8k41SbYn5r3
 YZQs+urAZQ+zldhgv6qKODAg3X+K9sqGiLF/kDo3mzvunVpn/d/KZArGyyefJDxAVJdl 1A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jx2gpwu7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:05:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62K5e5w004236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:05:40 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62K5eOD012039
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:05:40 GMT
Received: from mail-oi0-f43.google.com (/209.85.218.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 13:05:40 -0700
Received: by mail-oi0-f43.google.com with SMTP id b15-v6so4523354oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:05:39 -0700 (PDT)
X-Gm-Message-State: APt69E0KfLwGXamlMYNSNiPFsZ0Z0zB08mo6eapcc+rrazsuMh7GENK0
        sfKoYWvUw76B6hHDMTEagJHbacE804uc12Q06KI=
X-Google-Smtp-Source: AAOMgpfr6ahQGplezYWwR521bSKZH36gN9RFB9bjiouOr472bZ5tXzDlE8h0MeOJjviEfOogNTXQymeOwupvEirYaCg=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr18228056oia.229.1530561939787;
 Mon, 02 Jul 2018 13:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
 <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp> <20180613090700.GG13364@dhcp22.suse.cz>
 <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp> <20180614053859.GA9863@techadventures.net>
 <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp> <20180614213033.GA19374@techadventures.net>
 <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp> <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
 <20180615084142.GE24039@dhcp22.suse.cz> <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
 <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
In-Reply-To: <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 16:05:04 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ6PTYw3NivSCO5WMCrYGJH_-piz8TtYgpwLWT=SnBGYA@mail.gmail.com>
Message-ID: <CAGM2reZ6PTYw3NivSCO5WMCrYGJH_-piz8TtYgpwLWT=SnBGYA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into memblock.reserved
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@kernel.org, n-horiguchi@ah.jp.nec.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@techadventures.net, osalvador@suse.de,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        willy@infradead.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, dan.j.williams@intel.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=507
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So I expect this patch needs a cc:stable, which I'll add.
>
> The optimiation patch seems less important and I'd like to hold that
> off for 4.19-rc1?

Hi Andrew,

Should I resend the optimization patch [1] once 4.18 is released, or
will you include it, and I do not need to do anything?

[1] http://lkml.kernel.org/r/20180615155733.1175-1-pasha.tatashin@oracle.com

Thank you,
Pavel
