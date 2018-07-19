Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2952084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0Zg6tgOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2952084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbeGSPIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:08:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37762 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeGSPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:08:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JEO1JD084642;
        Thu, 19 Jul 2018 14:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=cHUg93UkF+c/u+TRPTi00fBOys5t6igZEdD8xX1CLxk=;
 b=0Zg6tgOF9OaT+EKX6kXR7ede+UTXWzq0iqnOQv9svwLWqxs1Uxr3wsyDpaICh161+ZbA
 gStoC58U1L0HtyFo/sN8rKuWMgb1TD96DDPjukZH4M6m/51FEgbVeAYNN6RcsWe+gQ7b
 1Dg2JYCyyvqzzgYZtZa2AMMFG6ap/sofJa452iTKtRp93SwVlag+rjDfenTcC0OLuJPw
 sbI3iz61lufW0l+2kjzdVisSFRpCVZU/FX7ipX6L8SBi1qdo9UMDzbJVcSV8S3aMGTRM
 7ZJE+G+yXPQiEZhP4FUW+lImDAJLThvX8J9zGnpLcggwD9IEFS9qdegzUuGREdWIlsIc /Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k9yjgqb82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 14:25:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JEPHYL012528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 14:25:17 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JEPHpa026618;
        Thu, 19 Jul 2018 14:25:17 GMT
Received: from mail-it0-f47.google.com (/209.85.214.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 07:25:17 -0700
Received: by mail-it0-f47.google.com with SMTP id g141-v6so7555194ita.4;
        Thu, 19 Jul 2018 07:25:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlH4RtQcnchyc5AT7qJXDh3uaERbjkdRpH3ro4uCmV7P2QyRO57m
        CJrjZwJ13kImm09ZIXTORhDmyG+pjEhXTm2ESGU=
X-Google-Smtp-Source: AAOMgpfwvJOPSJ8IBIS/lBwzpRKAbUBIW4L+KyLpT5Oxc5Y3cMfLRMvs2xOH5baZZNV047JbF8EvK+cPpcOpX0nCklg=
X-Received: by 2002:aca:db09:: with SMTP id s9-v6mr11712772oig.339.1532010316272;
 Thu, 19 Jul 2018 07:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-26-pasha.tatashin@oracle.com> <20180719104838.GC2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180719104838.GC2494@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 19 Jul 2018 10:24:40 -0400
X-Gmail-Original-Message-ID: <CAGM2reZYcKqoSBZQmUP-CMO=2bLznahLjzp=t0xiTxGsAMsEng@mail.gmail.com>
Message-ID: <CAGM2reZYcKqoSBZQmUP-CMO=2bLznahLjzp=t0xiTxGsAMsEng@mail.gmail.com>
Subject: Re: [PATCH v14 25/25] sched: use static key for sched_clock_running
To:     peterz@infradead.org
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 6:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 17, 2018 at 10:22:11PM -0400, Pavel Tatashin wrote:
> > sched_clock_running may be read every time sched_clock_cpu() is called.
> > Yet, this variable is updated only twice during boot, and never changes
> > again, therefore it is better to make it a static key.
>
> Right, so the focus was always on making the sane TSC case fast, and if
> TSC isn't stable we'd just make do and not care too much.
>

True for CONFIG_HAVE_UNSTABLE_SCHED_CLOCK, but for other systems like
SPARC, it hurts to have this variable accessed every time, even though
they have a sane sched_clock().

> But this certainly isn't wrong, so ACK.

Thank you,
Pave
