Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9DDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2864820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bf6kblgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2864820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbeGLDUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:20:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47372 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeGLDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:20:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C2xVWp087857;
        Thu, 12 Jul 2018 03:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=rlyvIzhW4LZzHijrk0sDKnt0+ffPulpEADPN1zENXGY=;
 b=Bf6kblgOlu5mH99bDlxOJdbDmoZFsREpqVC5MoXjIY1Iqt6tKs8ijZ4/dXFvnuqhCv73
 Nhh+solpHpLAAxW44Nw1tONHa1PZXMPgv7y/bEJhdCOHnqbwQ7s0FxYW0JSe3JosWPUI
 4JGqfrCFDtroGcRv9wTE8Tu1rnaNKOBptcxFG/oNp53IQIgi6/EbZKnMGlQP4FWBD3jp
 6+SmCsUzNpmfogGbxWk1uVviOOINtfvc8D/cUfROs3mTTo+TlgoMpADfU2JmiZhLXpb3
 Fy1iajf666pHVO7G+cDv/S8mVWTJu7HBpv8CVU3X9p5iVFm2m0OWr3yAG5WosF+GK7ju iA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k2p76185x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 03:13:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C3DJbe007083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 03:13:20 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6C3DJVn016445;
        Thu, 12 Jul 2018 03:13:19 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 20:13:19 -0700
Received: by mail-oi0-f54.google.com with SMTP id k12-v6so53120124oiw.8;
        Wed, 11 Jul 2018 20:13:19 -0700 (PDT)
X-Gm-Message-State: AOUpUlFHNA6FwQIcwf8Uc7/J3zaqlyJEyzTfAl1Qy/6NcCBEncdeGrE0
        G/nbGoJKbhBGdVTRtZ6uEQovIFjfg3BKUn2asHw=
X-Google-Smtp-Source: AAOMgpcu60ZmP7UE8b9L2X3UJYBVjc0Xv83s7WG1vRrH1fApZmHx739f0cMGCSv+r2Eol5n4TUrNY9SH3qosRsT57lY=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr552529oia.156.1531365198994;
 Wed, 11 Jul 2018 20:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180706161307.733337643@linutronix.de> <20180706162049.848458491@linutronix.de>
In-Reply-To: <20180706162049.848458491@linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 23:12:43 -0400
X-Gmail-Original-Message-ID: <CAGM2rebkNJzNDieAJWR=xj9sr1TGJeqxabgBvbJBGELjyk6JRg@mail.gmail.com>
Message-ID: <CAGM2rebkNJzNDieAJWR=xj9sr1TGJeqxabgBvbJBGELjyk6JRg@mail.gmail.com>
Subject: Re: [patch 7/7] x86/kvmclock: Switch kvmclock data to a PER_CPU variable
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=730
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
>  #define HV_CLOCK_SIZE  (sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)

HV_CLOCK_SIZE is not used anywhere anymore, can be deleted.

> +#define HVC_BOOT_ARRAY_SIZE \
> +       (PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))

This works, because sizeof(struct pvclock_vsyscall_time_info)) == 64
bytes, but static assert that verifies that IS_ALIGNED(PAGESIZE,
sizeof(struct pvclock_vsyscall_time_info)) would guarantee that no
random data is ever exposed to vdso.

Otherwise looks good to me:
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
