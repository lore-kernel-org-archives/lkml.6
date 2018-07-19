Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF50EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6C82084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDxCgBlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6C82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbeGSTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:23:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51312 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbeGSTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:23:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JIcn5F052141;
        Thu, 19 Jul 2018 18:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=87VTLnUIlx6TAiR23fp4/8KHP1Y+ZidcrJZDxikoaBA=;
 b=VDxCgBluaZnuToldJWmYaEx5/4oXho27OAwRtRoPHRgkauBWqDnbjif3WRIW4rr1rPUq
 7qjxWH2oVyCR3hyrHy0CZGRTP1o60cPndd4ItFFCqMewauB8N/sPp9WTkODKM/83Gs2Y
 tMnVa0wX+jxgNVhEXxaJwLTHXLWymuoUB5yLiHdZ4CxrEIoOw00N0855DlQhcBXhgeK5
 V0xh5PgrrHB4Jg9z+UtiSjy25YiIgPUvFPRnptzzxCn1rsCRbTPNBXTHeG/1dYmkCHRz
 NP6S8vKQauumJHIIO6kyTAkKlFgT7Jzd57CLspafqPKITpGBe18BMHLGjILLtpYH4z5T FQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k9yjx8cfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 18:38:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JIckIu028445
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 18:38:46 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JIckeI020950;
        Thu, 19 Jul 2018 18:38:46 GMT
Received: from mail-oi0-f49.google.com (/209.85.218.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 11:38:46 -0700
Received: by mail-oi0-f49.google.com with SMTP id n84-v6so16784048oib.9;
        Thu, 19 Jul 2018 11:38:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlGsLedVYyqoneFj0T/Cny1zRwVS27KPStsoZofQ/7W72kBh8eWs
        YHHFlgKKc+/CnIPTtkHlPL4qOa1FovF0u8KATrc=
X-Google-Smtp-Source: AAOMgpfBDG0IB+tiSoEV9nmPz6bRUkjk0REz3dxre4xZUbfYvEc6nSdtCyx+6DVRSDPOYbVm8o6CnWTcyYoW7ZZ28Ao=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr11184837oih.65.1532025525817;
 Thu, 19 Jul 2018 11:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
 <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com> <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
 <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
In-Reply-To: <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 19 Jul 2018 14:38:09 -0400
X-Gmail-Original-Message-ID: <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
Message-ID: <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:49 PM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> > So create two functions. native_...early..() and native....(). The early
> > one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
> > with the late one which contains all of it.
>
> Good idea. Actually, the late one will contain only hpet/pmtimer and I
> will set it only if tsc frequency was not determined only.

If we determined tsc early in boot using one of the quick methods:
from cpuid/msr/quick_pit, can we assume that frequencies of all other
CPUs will be determined the same way? Or do we still have to fallback
to PIT/HPET/PMTIMER? I wondering if we support heterogeneous
multi-socket platforms with different CPUs, because that the only
platforms where I see such scenario is possible.

Thank you,
Pavel
