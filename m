Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0631BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BDA273AD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ku+XKKA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BDA273AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966492AbeF1OKP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:10:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeF1OKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:10:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SE8ZaR058582
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=kqKYphjlijNWV+rEhV8WBq6g2+q8VsGx7QlEWWMkNk0=;
 b=Ku+XKKA+BvS7Kmd8WOqaXZ6/HYkXVpPikO/fpnJMX1a7weQ5tSdJ+qLZ8pTSIm1Am+MT
 H7OAHyX4OrM4qt9k3KeQRe1kTQ9Nr+4Up+Ni8IUos5bqFme9LLEx3QqxID+LYu/qxM/4
 D//5K2e4rt44ao8LjBmon5rV+A2YSx8Yqf86WgrClhFLK3UEdPJj4hz2tz9oI3fCSOmq
 v/4X2CEDLxmhhLy8BA1SoTBg7KkOFPJmayRY1WwaoeSGvDeoS5HzqTuTsn3eKyjgLDlW
 K2Fsr9hnEEM648M0diyFIkT7MoPGy09IiGLc+oOnqu+yWDtIVqvzzJDyUri+PajMMIwq GA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jum0aaf35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:10:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5SEACLX021001
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:10:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5SEACQt014858
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:10:12 GMT
Received: from mail-qt0-f174.google.com (/209.85.216.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 07:10:12 -0700
Received: by mail-qt0-f174.google.com with SMTP id l10-v6so4823318qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:10:11 -0700 (PDT)
X-Gm-Message-State: APt69E3Ep32dvjBWEsu4XRTXxfS5l3WPqM1WL3ctyIVzhcK0p/kI8kqh
        R9Hvs9ZtPzv3gPpBbmn3WRzJjQYVxJq+dyxzkg8=
X-Google-Smtp-Source: AAOMgpfIiLZ8HCP87mttrtLKwEOs80sUyyJVOsZ4Pay1czu2gMyftg+DinFkH5A/+qEQOC6vh8ibjbSOxvgXPyXmfb8=
X-Received: by 2002:a0c:9448:: with SMTP id i8-v6mr9255269qvi.231.1530195011259;
 Thu, 28 Jun 2018 07:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180628062857.29658-1-bhe@redhat.com> <20180628062857.29658-5-bhe@redhat.com>
 <20180628120937.GC12956@techadventures.net> <CAGM2reZsZVhhg2=dQZf6D-NmPTFRN-_95+s61pC7Axz5G5mkMQ@mail.gmail.com>
 <3e014554-abf9-8a18-e890-be43d48d5eb0@intel.com>
In-Reply-To: <3e014554-abf9-8a18-e890-be43d48d5eb0@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 28 Jun 2018 10:09:06 -0400
X-Gmail-Original-Message-ID: <CAGM2reasSYwj7DtCiSFctA4q8eP9FShiAj5ou=xz4Pbk4C7mzw@mail.gmail.com>
Message-ID: <CAGM2reasSYwj7DtCiSFctA4q8eP9FShiAj5ou=xz4Pbk4C7mzw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/sparse: Optimize memmap allocation during sparse_init()
To:     dave.hansen@intel.com
Cc:     osalvador@techadventures.net, bhe@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=462
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this at a point in boot where a BUG_ON() generally produces useful
> output, or will it just produce and early-boot silent hang with no
> console output?

Probably depends on the platform, but in KVM, I see a nice panic
message (inserted BUG_ON(1) into sparse_init()):

[    0.000000] kernel BUG at mm/sparse.c:490!
PANIC: early exception 0x06 IP 10:ffffffffb6bd43d9 error 0 cr2
0xffff898747575000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc2_pt_sparse #6
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.11.0-20171110_100015-anatol 04/01/2014
[    0.000000] RIP: 0010:sparse_init+0x0/0x2
[    0.000000] Code: fe 3b 05 ba d0 16 00 7e 06 89 05 b2 d0 16 00 49
83 08 01 48 81 c3 00 80 00 00 e9 73 ff ff ff 48 83 c4 10 5b 5d 41 5c
41 5d c3 <0f> 0b 48 8b 05 ae 46 8f ff 48 c1 e2 15 48 01 d0 c3 41 56 48
8b 05
[    0.000000] RSP: 0000:ffffffffb6603e98 EFLAGS: 00010086 ORIG_RAX:
0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb6603e80
[    0.000000] RDX: ffffffffb6603e78 RSI: 0000000000000040 RDI: ffffffffb6603e70
[    0.000000] RBP: 0000000007f7ec00 R08: ffffffffb6603e74 R09: 0000000000007fe0
[    0.000000] R10: 0000000000000100 R11: 0000000007fd6000 R12: 0000000000000000
[    0.000000] R13: ffffffffb6603f18 R14: 0000000000000000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffffb6b82000(0000)
knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff898747575000 CR3: 0000000006e0a000 CR4: 00000000000606b0
[    0.000000] Call Trace:
[    0.000000]  ? paging_init+0xf/0x2c
[    0.000000]  ? setup_arch+0xae8/0xc17
[    0.000000]  ? printk+0x53/0x6a
[    0.000000]  ? start_kernel+0x62/0x4b3
[    0.000000]  ? load_ucode_bsp+0x3d/0x129
[    0.000000]  ? secondary_startup_64+0xa5/0xb0
