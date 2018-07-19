Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C98CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A1920673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q+ioJDCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A1920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbeGSPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:00:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:00:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JEDPEq040689;
        Thu, 19 Jul 2018 14:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=5ZLM4hHToWws5+QxYzDQonJhtHL5XZXhSYI63RH/nVw=;
 b=q+ioJDCZBtXn9bXxlXn5P3iebbS7/Tqd+0FNs/pcSOUo6OJzUvAQvjKon/dY6CiaUnRi
 EfA8lhxC0D/91MvuZ7BveQK3JLzeiewLpxD3L7yac56tOYwjeuWuwsJ1GBbx0vCdPiCl
 2ahShdo9vnbZZfrFqnE7i0tSuLfWitjVsnNRoPXD7800dnSyIpqkB2DItn0X1TJAR+D5
 upuemekvibLklmfipYr2okefnK/P5aP2bg/iUO5/kPpZrLeC1vGy0F1adVD9IsyJGKSx
 E3tffH0pd/0fh95EGjfiq1/ULYdwaBLeudDeNOVdgy/VTmN7KvJKHiRlBC0tNubfyO/o iw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k9yjx7am5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 14:17:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JEHBO2015547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 14:17:11 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JEHBMZ021657;
        Thu, 19 Jul 2018 14:17:11 GMT
Received: from mail-it0-f44.google.com (/209.85.214.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 07:17:11 -0700
Received: by mail-it0-f44.google.com with SMTP id 188-v6so9797838ita.5;
        Thu, 19 Jul 2018 07:17:11 -0700 (PDT)
X-Gm-Message-State: AOUpUlEKmrf2HWvxRVUMdCzg/MeikcoTaNvC3xtctDmmDKRGCliDLqTj
        RP0DtUpoGwXu3cpKpojjeBXrYTCdi6PN3P9+8Z8=
X-Google-Smtp-Source: AAOMgpfP/TmqOW3w0WoMkFnH/CIBsjTf8ShPv0ZtE9c4ivMavxlZlrZSi/FZ5FL6p7qLLAqeXMBErire3f2WWpfhl7c=
X-Received: by 2002:aca:b541:: with SMTP id e62-v6mr10998621oif.136.1532009830656;
 Thu, 19 Jul 2018 07:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-25-pasha.tatashin@oracle.com> <20180719103903.GB2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180719103903.GB2494@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 19 Jul 2018 10:16:34 -0400
X-Gmail-Original-Message-ID: <CAGM2rebsqJUBSVhN3Ug=wYA+uYzKF06P4afDqEApaWk0bK8-zQ@mail.gmail.com>
Message-ID: <CAGM2rebsqJUBSVhN3Ug=wYA+uYzKF06P4afDqEApaWk0bK8-zQ@mail.gmail.com>
Subject: Re: [PATCH v14 24/25] sched: early boot clock
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 6:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 17, 2018 at 10:22:10PM -0400, Pavel Tatashin wrote:
>
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index 0e9dbb2d9aea..7a8a63b940ee 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -202,7 +202,15 @@ static void __sched_clock_gtod_offset(void)
> >
> >  void __init sched_clock_init(void)
> >  {
> > +     unsigned long flags;
> > +
> >       sched_clock_running = 1;
> > +
> > +     /* Adjust __gtod_offset for contigious transition from early clock */
> > +     local_irq_save(flags);
> > +     sched_clock_tick();
> > +     local_irq_restore(flags);
> > +     __sched_clock_gtod_offset();
>
> I think we want to keep __sched_clock_gtod_offset() inside the IRQ
> disabled region.

Fixed.

>
> And I just looked at my patch:
>
>   https://lkml.kernel.org/r/20180626090003.GA2458@hirez.programming.kicks-ass.net
>
> and that had a comment about how we wanted to set the gtod offset
> _before_ setting sched_clock_running, yet here you do it the other way
> around. Hmm?

Fixed, and added your comment.

Thank you,
Pavel
