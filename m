Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B19C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837FB2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yHWeOELc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837FB2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391151AbeGLCUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:20:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732787AbeGLCUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:20:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C24Jht062859;
        Thu, 12 Jul 2018 02:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=Y6dBFGVoDAz7IQ6zPrrZpxvCxdpK6OnFEwoRufT551A=;
 b=yHWeOELcS1E0rX6jB0ZjCn4IQXr/1ELkdzaKx+3ZuV4x6PWV9eCYUJdcmfx8pXEIyyRF
 tB6/89E/R8G6UJ/uMRvNmKjPsH7niyagnKV17/uY26b+/l7IXsGzCjaKFTB6+o2OxfeM
 /45+rd9vM6KeRwrb1T/4Qx0dCHRuhJo4272Jx1GFP9/QE5ckiqyzKmju9rjAsw/HJVq8
 vCl+C1plkVYku9pX5yUZL/krf2w0PSC0p3stlP+K1RsC5FaxDxAZLnYAzssNuHVjrQgV
 c4a+ooBuzgJkxkhj7CNxUH3syJEiJd95KHNV2Iq9D4McZOC6RGkoJ1mp20nJB2s504Ei 4w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e0fjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:13:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2D9gs006925
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 02:13:09 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6C2D9hs006178;
        Thu, 12 Jul 2018 02:13:09 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 19:13:08 -0700
Received: by mail-oi0-f48.google.com with SMTP id q11-v6so27389106oic.12;
        Wed, 11 Jul 2018 19:13:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlGTyzcGSdI6pbC8qPmoMXbjtqIuh31pJjMBlL/nqVm4L0RynMfs
        WZtFqEjIoWUiiv6SIV4cYGlJoilt5jWeNQrsa30=
X-Google-Smtp-Source: AAOMgpfB+c+bw6WKQeyMUsOv4JRSqzQjaU51Z8MkpibS0Wn68SQJcsEwe0cPbPdELt3bvxv8J9bDwnVbSGrqvB8nbm8=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr309170oih.65.1531361588293;
 Wed, 11 Jul 2018 19:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180706161307.733337643@linutronix.de>
In-Reply-To: <20180706161307.733337643@linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 11 Jul 2018 22:12:32 -0400
X-Gmail-Original-Message-ID: <CAGM2reaKmu=h8QosuoJvJzzdTy2QfGRp9YxaKK-9UzpsfL-MoQ@mail.gmail.com>
Message-ID: <CAGM2reaKmu=h8QosuoJvJzzdTy2QfGRp9YxaKK-9UzpsfL-MoQ@mail.gmail.com>
Subject: Re: [patch 0/7] x86/kvmclock: Remove memblock dependency and further cleanups
To:     tglx@linutronix.de
Cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=664
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So this still will have some overhead when kvmclock is not in use, but
> bringing it down to zero would be a massive trainwreck and even more
> indirections.

Hi Thomas,

In my opinion, having kvmclock page in  __initdata for boot cpu, and
setup it in init_hypervisor_platform(). Later, switch to memblock
allocated memory in x86_init.hyper.guest_late_init() for all CPUs
would not be too bad, and might be even use fewer lines of code. In
addition, it won't have any overhead when kvm is not used.

Pavel
