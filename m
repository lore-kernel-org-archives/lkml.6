Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A5313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9M+cHmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeG3PxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:53:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54134 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeG3PxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:53:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UE99r7181399;
        Mon, 30 Jul 2018 14:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=ZtBIuvi7Co+2X6/F8A3oG8s63lXCaAvzqPPMHworNk8=;
 b=i9M+cHmE1wCewi0wKoLLUFAoLhxRCJKQLVVhS01nidSjahVRQOlfeLCX+wfEKs9ZYeOB
 lR19ap9BbVnuZ0EhHVq7a4FdbcEb8ESi8EY0RXbdA3LEEsu+BcCtdBwq7u46rGaeGN5Y
 EDH2Dg7RlumV/RE4H3gGn9oy+kODBTcZuyflgu35qsiJjRsUrdhXbER+jGS5BlaTujsT
 qUJgDoW1fS3sgzRlKLR/tvqnQ30ZqwdakjW8AmXIxp5Sof99uleH7NcP23T2giW4+Fo8
 5T5pHL2fFoOnFpDCiOFSZsR7KbFv8Xx70vNjagFX6T+fynXR71UMZDoliLuSwPyqmf19 9A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4pvmdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 14:18:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6UEI0lw014993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 14:18:00 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6UEI0Yj022061;
        Mon, 30 Jul 2018 14:18:00 GMT
Received: from mail-oi0-f49.google.com (/209.85.218.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 07:17:59 -0700
Received: by mail-oi0-f49.google.com with SMTP id n21-v6so21523557oig.3;
        Mon, 30 Jul 2018 07:17:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlEimkV0sUF0SnSnhYzz8LY04rap2c/BrKPlKZB4ETiJHbUfP/bQ
        Dvcc0g6cFjUDcnu9dvAbxXRfJGeahJH6JKT3f1U=
X-Google-Smtp-Source: AAOMgpcPIQABYbYJfLy4dQLWZenHPW/53g6uh9kbcwKqDHTJnVRh4kg7pM6mKyC+VaG4mqDNXrn5v4KcoV4FXNcoqFQ=
X-Received: by 2002:aca:b541:: with SMTP id e62-v6mr19691074oif.136.1532960279606;
 Mon, 30 Jul 2018 07:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com> <20180730075421.22830-3-douly.fnst@cn.fujitsu.com>
In-Reply-To: <20180730075421.22830-3-douly.fnst@cn.fujitsu.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 30 Jul 2018 10:17:24 -0400
X-Gmail-Original-Message-ID: <CAGM2reanD0S2r+eSUfKCzJwOyJEz+iqNVsy6kHdcPQ4=n5OcdQ@mail.gmail.com>
Message-ID: <CAGM2reanD0S2r+eSUfKCzJwOyJEz+iqNVsy6kHdcPQ4=n5OcdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/kvmclock: Mark kvm_get_preset_lpj() as __init
To:     douly.fnst@cn.fujitsu.com
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=600
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 3:55 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
> kvm_get_preset_lpj() just be called at kvmclock_init(), So mark it
>  __init as well.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Thank you,
Pavel
