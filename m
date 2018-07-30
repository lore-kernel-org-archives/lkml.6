Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA0920893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QlIIJB4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA0920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeG3PUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:20:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeG3PUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:20:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UDhvJw164253;
        Mon, 30 Jul 2018 13:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=DD60IoeXMYjlvYKgQPIVaEQ17v4KxRwCXRLrs3PftYM=;
 b=QlIIJB4p/0YaiTE713+1Xv3+fJFzOMmqw4wsLwR2Z3Za446NV6afizfpBO9zJjv729sp
 FZepCzZySUKRq2eBecesYZqKMWa/D2iAWqHYRPey56zAHaA4N0XKtcJGxMUVQXMd/PJc
 ai+pB9ZL+AAyDmAAYT0/epD2N4UHo7jZGvg1lFEMhFqW11Wrc5vzG0PyG5z5dpnVOsyC
 FpVfxfblamIsd7g8Axet7NiUPCvw+YDFVGn5X5o+9Z+Ecvlu7dnnXcXDurzdD+mscRP2
 P4V/O1Ol4HzJ9xPl5DaOqkewT/n9hlBY2HPYR/fLLefFumB3y91afkeCqMdQcb1TFMsM 9w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kgfwsvjkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 13:45:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6UDjHmA007657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 13:45:17 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6UDjHl1024872;
        Mon, 30 Jul 2018 13:45:17 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 06:45:17 -0700
Received: by mail-oi0-f48.google.com with SMTP id b15-v6so21276300oib.10;
        Mon, 30 Jul 2018 06:45:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlFz9IHezkwp2K6Egv0/GZ5lssBMoQNLPItkfFZql6vp1ekdvnUc
        RRnPvnC8QrC0LeEczjV0A8mbahElOhdh47yiyh0=
X-Google-Smtp-Source: AAOMgpcmd4xlafCbPe1QmlXkkQVor6DLrz1pSQ6q4135hACJjpAqhnrrYBi25IBoF7CBRmOVvKWMWmeBRK+L25WoL1c=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr16763749oig.221.1532958316995;
 Mon, 30 Jul 2018 06:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
 <20180724195215.GA22496@roeck-us.net> <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
 <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
 <ddb6bc3d-b764-3115-ebc7-54c70c967f24@roeck-us.net> <CAGM2reaUEOMbbtfbLY2n66jJV=ZH0Wy7GtX-tfCG62U7Uhn14g@mail.gmail.com>
 <CAGM2reYevKGh7pqvK5O7oLB5FYkuU31v7t_AMDYt0=Q+jsVEqw@mail.gmail.com> <20180730123631.GO2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180730123631.GO2476@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 30 Jul 2018 09:44:41 -0400
X-Gmail-Original-Message-ID: <CAGM2reZxGzjfs8pEBsZ3CHdVFOZu7fz5_XRifcqj6E87qZiA9g@mail.gmail.com>
Message-ID: <CAGM2reZxGzjfs8pEBsZ3CHdVFOZu7fz5_XRifcqj6E87qZiA9g@mail.gmail.com>
Subject: Re: [tip:x86/timers] sched/clock: Enable sched clock early
To:     peterz@infradead.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=483
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -       if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
> > +       if (cd.actual_read_sched_clock == jiffy_sched_clock_read) {
> > +               local_irq_disable();
> >                 sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
> > +               local_irq_enable();
> > +       }
> >
> >         update_sched_clock();
>
> I'm thinking maybe disable IRQs for that entire function, instead of
> just the register call.

Sure, I will send a patch.

Thank you,
Pavel
