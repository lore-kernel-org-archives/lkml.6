Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356320BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZ085K6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356320BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbeGLCcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:32:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbeGLCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:32:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C2OoCG036995;
        Thu, 12 Jul 2018 02:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=36iQGRfuF3dn7hjwaxpfiC0XnouY/ps7ZQsCX36wUB4=;
 b=PZ085K6PCMaUp1vncYL1QNRI8pcfRJlgFXbAh59QaP1M5ELHGuGzTt2+Dmdt9cEfmNeh
 hU9Cof5kgtrKCQgGu/xiOfNmCVYvQZ7Vz/76XXoYNse0bsKHSaV9ctXSAKnQibY9S82J
 kNKkqSAIoxkd19M66N/2Di3Ed+pZimBXnAcP6oznawJkPfe5dDYUKY5f6j/eTFmrRw1u
 sHSGvHjhMDdCt9FMNFS0FwDP46KWcrmm8SJtg9lZ/DUh4gnuuptgI+FgB8iqaf3T5VVi
 70ID9EHX6q8QopdL5pXUZ/WTmuvfweU+ItMWIrfnpgjVLlvJMfQrM+/fbDL5cQc25jCf 2A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k2p7vger5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:25:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2P1gG014371
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:25:01 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C2P1ti008155;
        Thu, 12 Jul 2018 02:25:01 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 19:25:01 -0700
Received: by mail-oi0-f47.google.com with SMTP id s198-v6so52988630oih.11;
        Wed, 11 Jul 2018 19:25:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlFmmqx/0rRH8vQFd2FwEwsZjX5R2AAwnX1hEFfkxOG/5AZPBimL
        gvusOSZGTR6gkoqoYO4imuubFS0QfS++jLyMmx4=
X-Google-Smtp-Source: AAOMgpfCSHrgRXwlrpo6l/KTYye5ZOvAIsKpHkOa8ak7AxAYLfGJX37WoxHsJThMOudKMefQTRB9PJgtVqTytRG8rz8=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr337635oih.65.1531362300548;
 Wed, 11 Jul 2018 19:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180706161307.733337643@linutronix.de> <20180706162049.482199075@linutronix.de>
In-Reply-To: <20180706162049.482199075@linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 22:24:24 -0400
X-Gmail-Original-Message-ID: <CAGM2rebCvhXrRZq9Cg16ow0+N8AE6Yvou5cF9yuP__t=sePpYQ@mail.gmail.com>
Message-ID: <CAGM2rebCvhXrRZq9Cg16ow0+N8AE6Yvou5cF9yuP__t=sePpYQ@mail.gmail.com>
Subject: Re: [patch 3/7] x86/kvmclock: Decrapify kvm_register_clock()
To:     tglx@linutronix.de
Cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=729
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to what Paolo's noticed, may be change printk to pr_info()
while editing around it:

> -
>         printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
>                 msr_kvm_system_time, msr_kvm_wall_clock);
>
> +       hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
> +       kvm_register_clock("primary cpu clock");

Otherwise,
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
