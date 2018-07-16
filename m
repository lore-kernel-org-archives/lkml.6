Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF64ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZS+8/efr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A466C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeGPODu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:03:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbeGPODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:03:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GDYE7V159954;
        Mon, 16 Jul 2018 13:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=OQKKuSNbv+RWJeKT49Mom/AN79Yj+PRhrcHGtNNecus=;
 b=ZS+8/efrfwf5k9vyUkKUzaJTuye3H4inv71Ot5EfzA9slYQSfVAX/SD+P5vk2r4GxqoY
 UtgUoo5CL3vhF+D0w6UgmuwWR9tg6byWqyEOh2nb/TFb9wgygJn8BNPKyJ20d5ZHmrmn
 XQBz0BzX6iOWBXFDYxiRfs11UiROyC8n9EQcELUP72ENKfMODfSEoo3q2xNNqQWVy05b
 IY0zfMslt8jijP9fed98sKuvEMGKsxiE/A1wcgm3Kn5XLLW6YGz1i8vDORhRdqqDmQzA
 aBrHP/tdBJ1fVgCqpdurkz9+nVDpTdqyUh7p0N3ScdrULbk6lMkP7hH9MQdrGCyZ5maI DQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k7a3jmesc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:36:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GDaGfX031961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:36:17 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GDaG68006938;
        Mon, 16 Jul 2018 13:36:16 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 06:36:16 -0700
Received: by mail-oi0-f44.google.com with SMTP id w126-v6so74779622oie.7;
        Mon, 16 Jul 2018 06:36:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlGzRbSTQ+KFJgoW0LnL5NsKDh7RXin1/H7njrpWCqshdgpNISFg
        ji/R/KUP6vhHT7hQFi4MiGm8RS08khKB38hJ+Bo=
X-Google-Smtp-Source: AAOMgpd4G4wfPCcN5BT3ZwGUepTlshLw8iM/ajxcF95TvZBaSM+AjJazXzdP71LWjAMCwXxlskM76UCf7MzZQPTQTkk=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr19410820oiy.191.1531748175811;
 Mon, 16 Jul 2018 06:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com> <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
 <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com> <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com>
In-Reply-To: <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 16 Jul 2018 09:35:40 -0400
X-Gmail-Original-Message-ID: <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
Message-ID: <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
To:     douly.fnst@cn.fujitsu.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8955 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 5:33 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>
>
> At 07/13/2018 07:30 PM, Pavel Tatashin wrote:
> > On Fri, Jul 13, 2018 at 3:24 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> >>
> >>
> >> At 07/12/2018 08:04 AM, Pavel Tatashin wrote:
> >>> During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
> >>> and the second time in tsc_init().
> >>>
> >>> Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
> >>> the calibration is done only early, and make tsc_init() to use the values
> >>> already determined in tsc_early_init().
> >>>
> >>> Sometimes it is not possible to determine tsc early, as the subsystem that
> >>> is required is not yet initialized, in such case try again later in
> >>> tsc_init().
> >>>
> >>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> >>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> >>
> >> Hi Pavel,
> >>
> >> Aha, a complex solution for a simple problem! ;-) And I did find any
> >> benefits of doing that. did I miss something?
> >
> > Hi Dou,
> >
> > I had this in previous version:  init early, and unconditionally
> > re-init later (which required to resync sched clocks for continuity,
> > and check for some other corner cases). Thomas did not like the idea,
> > as it is less deterministic: it leads for code to work by accident,
> > where we might get one tsc frequency early and another later, and so
> > on. The request was to initialize only once, and if that fails do it
> > again later. This way, if early initialization is broken, we will know
> > and fix it.
> >
>
> Hi Pavel,
>
> Yes, right, I have seen the purpose in v12.
>
> >>
> >> As the cpu_khz and tsc_khz are global variables and the tsc_khz may
> >> be reset to cpu_khz. How about the following patch.
> >
> > Could you please explain where you think this patch can be applied,
> > and what it fixes?
> >
>
> This patch is just an simple alternative to realize what you want in
> your patch. your patch is also good but complex, and need some scrub.
> eg:
>    - Is it suitable to using the WARN_ON()
>    - the name of determine_cpu_tsc_frequncies() function,
>     s/frequncies/frequencies/. BTW, How about tsc_calibrate_frequencies()
>    - ...
>
> BTW, before this patch, seems we need make sure xen should work well, I
> can investigate and try to test if we can also move the pagetable_init()
> to the front of tsc_early_init() for you.

v13 has xen patches, so xen timestamps work early as well now.

Thank you,
Pavel
