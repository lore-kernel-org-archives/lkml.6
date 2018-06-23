Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231BEC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C8B24D2E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wnklzv1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8B24D2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeFWVaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:30:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59110 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeFWVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:30:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5NLESNo181900;
        Sat, 23 Jun 2018 21:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=yAWnR92hGClOwVBRb+CMaBA4bPP1ueE7jmesojzIORs=;
 b=Wnklzv1Vvb3kxfi6abgd3+X2b87e9AMQDup5XxCddOdzYRGHysM5fMGoTunBjkFK2Y11
 vf6ggQxExfA57oXaZy6NqJqmNeGMozJGDaLWQqQkG/O15spj55jZsBLIha8VpyvUZ9uk
 lQvP1S9LERwOjMHpaYlqgA80OPx5nSyZmUQtItu6Kue1kLBzQ+Kvib6RtNXBjZoywkPI
 /LUx3Otp4xjqs2EIHkKNNElTNZbB5Xy9b/ru5Gkp2eZTzE8751FOkoABl/w7nWU44JFB
 +1Z3K1/YJdvjWd8wOL9hlSYf3p7+b786XuWH3/E/qJIzPFkfTazYrwE0BjZ/b6kazx0h 4Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jsfg0rvaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 21:30:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5NLUCEL020612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 21:30:12 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5NLUCcF013397;
        Sat, 23 Jun 2018 21:30:12 GMT
Received: from mail-oi0-f45.google.com (/209.85.218.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 23 Jun 2018 14:30:12 -0700
Received: by mail-oi0-f45.google.com with SMTP id l22-v6so9178907oib.4;
        Sat, 23 Jun 2018 14:30:12 -0700 (PDT)
X-Gm-Message-State: APt69E2l41eWxkGi9FmgdSVEmnulllykRGvskB9C7nbYKmKTegRxup9g
        rJFaD3ES2TazCUFPGNIFgyZNVnnjUz+BgWYOklg=
X-Google-Smtp-Source: ADUXVKKKTO2HZ1zOWU+Plz7oMoNGdjjeRuoYBvNowvLaMyJN7oPjSd8LTM9tonDdX6880Ey72abITxxv897bUOmXgsw=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr3973390oig.339.1529789411688;
 Sat, 23 Jun 2018 14:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sat, 23 Jun 2018 17:29:35 -0400
X-Gmail-Original-Message-ID: <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
Message-ID: <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
To:     tglx@linutronix.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8933 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=530
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806230241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So you forgot to answer this question. I did not find a system yet, which
> actually exposes this behaviour on mainline.
>
> Is this an artifact of your early sched clock thing?
>

Yes, it is. Let me explain how it happens.

So, the problem is introduced in patch "sched: early boot clock" by this change:

-       if (unlikely(!sched_clock_running))
-               return 0ull;
+       /* Use early clock until sched_clock_init_late() */
+       if (unlikely(sched_clock_running < 2))
+               return sched_clock() + __sched_clock_offset;

As soon as sched_clock() starts output non-zero values, we start
output time without correcting the output as it is done in
sched_clock_local() where unstable TSC and backward motion are
detected. But, since early in boot interrupts are disabled, we cannot
really correct invalid time, and therefore must rely on sched_clock()
to provide us with a contiguous and sane time. In earlier versions of
this project, I was solving this problem by adjusting
__sched_clock_offset every time sched_clock()'s continuity was changed
by using a callback function into sched/clock.c. But, Peter was
against that approach.
