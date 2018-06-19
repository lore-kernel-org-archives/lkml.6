Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8803C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60413204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p5Ck556M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60413204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757287AbeFSOYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:24:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55012 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757091AbeFSOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:24:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JEJQiv170003
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=7MEDc7lezLFksSusVQ9M2G3eeFXAiy3gOxfgpTLkY7I=;
 b=p5Ck556MqZxUEWINSdsuMmL6lYut+8C4TXEX/o+dD6xkyNM7RHYgcKivKhD16ruHNf4p
 gD0YEztZBxSE9MzzaMYH/JVBSaRWzUA+r61HK9wwMTPW6qXXtnYjtDgpoJPFSrxkbZpa
 h7aE7UQ9WERQvvH0I0yOx+ccn2Xri/L4ka6WzGDt7RhnqaFIIP4At/Mr5nGpKix7Ijha
 0H5rSFcFLUNW274AIm0n5C3YsUXlIF9gQmSgnIYgc3y/sVNhbO5SVFF/TZmdGjfGdxEa
 uZQFtN2+3999E+8KCNVkwAZIbDD3WAg7hUCanx6iv0UzPtCgK2RHCP9Ny+uchF63T8Jh KQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgwrcg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:24:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JEO4w4000866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:24:04 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5JEO3SA025667
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:24:04 GMT
Received: from mail-ot0-f181.google.com (/74.125.82.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 07:24:03 -0700
Received: by mail-ot0-f181.google.com with SMTP id d19-v6so22747923oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:24:03 -0700 (PDT)
X-Gm-Message-State: APt69E03ftiBkEXr5UoWMm+Fxy2BDwJrSvVqdR1NJXfn7pI1dMqJRQWo
        X+1QAxeALQHHERsg+u6NVk+vMaaZ7nlAyAHCJiE=
X-Google-Smtp-Source: ADUXVKKGBQHTtTGda3UsJ+Lk41vEAcf0BWSzIt3rhGP+goQcR8maAEyApt3DaLNefcYAPq9m261UyLS/E4f3XpVe+R4=
X-Received: by 2002:a9d:4305:: with SMTP id s5-v6mr9769584ote.11.1529418243020;
 Tue, 19 Jun 2018 07:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-4-pasha.tatashin@oracle.com> <CAHp75VdRxpSYJE17bjGvRAjCq5vjf23L=HT5oA6OhPSCzJJ0FA@mail.gmail.com>
 <CAHp75VdLoSDYvX6ZiRKJq0RRtz4nbkNwsjSFxbOsNeJofoUJVw@mail.gmail.com>
In-Reply-To: <CAHp75VdLoSDYvX6ZiRKJq0RRtz4nbkNwsjSFxbOsNeJofoUJVw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 19 Jun 2018 10:23:27 -0400
X-Gmail-Original-Message-ID: <CAGM2reZR9iwUoBynrBRbjJAZ1D5WqAKdSzc=xQPWstXs1nN-nw@mail.gmail.com>
Message-ID: <CAGM2reZR9iwUoBynrBRbjJAZ1D5WqAKdSzc=xQPWstXs1nN-nw@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] x86/time: read_boot_clock64() implementation
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
> > > +{
> > > +       u64 ns_boot = sched_clock_cpu(smp_processor_id());
> > > +       bool valid_clock;
> > > +       u64 ns_now;
> > > +
> > > +       ns_now = timespec64_to_ns(now);
> > > +       valid_clock = ns_boot && timespec64_valid_strict(now) &&
> > > +                       (ns_now > ns_boot);
> > > +
> >
>
>
> > > +       if (!valid_clock)
>
> Are we expecting more often clock to be non-valid?
> Perhaps change to positive conditional?

Hi Andy,

Sure, I will change to:
if (valid_clock)
...
else
...

>
> > > +               *ts = (struct timespec64){0, 0};
>
> I dunno if additional variable would be better for readability, like
>
> struct timespec64 null_ts = {0,0};

I don't mind adding ts_null, but I think, as-is ok here,

> ...
> *ts = null_ts;
>
> > > +       else
> > > +               *ts = ns_to_timespec64(ns_now - ns_boot);
>
> But I'm fine as long as Thomas is okay with this code.
>

Thank you for the review!

Pavel
