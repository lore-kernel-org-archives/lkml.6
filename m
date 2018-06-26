Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE45C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143CC26E19
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kK7JXphg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143CC26E19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFZTsc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:48:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48532 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbeFZTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:48:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QJhqck148317;
        Tue, 26 Jun 2018 19:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=9SZwa4tDTNTZ5JsDipqu0QMcSF1kJ/+y1tkGZJa2kLU=;
 b=kK7JXphgUK4n3q49f0f6n7i4SxusT3NEuxRbNfPP6GcY6xO50XN3yJDcAwJTBdlL6sm+
 Z1v3NLcxKEjbtb499jJUIhbY9yZp9xS2bpaNisRC49HiVU9KrHfeG3R2V7HliD20SQFL
 ukTBDYY4Lj0jmB5L3OkgX+r3qmuRosQYWeLS2a5w6g3vkSQmbHWDuVb4RGT8JoDHcVy8
 QaGimYA+/xA+rT+EHRMS8L5cW3mS/gQJEk1yQhhfir/g8uEcGdAON1bbSjBrLqp4YpAA
 LTnj1Yx9Gjy0Y1aNRpJbAdX97dT7X+B2yp/Y8iOd4Xuzyn7+tFVByutMKb15lUkXXBly 5Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtt48p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 19:48:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QJmSg4021246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 19:48:28 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5QJmSCf024063;
        Tue, 26 Jun 2018 19:48:28 GMT
Received: from mail-ot0-f181.google.com (/74.125.82.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 12:48:28 -0700
Received: by mail-ot0-f181.google.com with SMTP id d19-v6so20353955oti.8;
        Tue, 26 Jun 2018 12:48:27 -0700 (PDT)
X-Gm-Message-State: APt69E0HpgEU8gXB2Dh79etogcgY7UwE/oE/vgR1Ymirp/niK5EIGS7H
        DcwWiEm1G+5whWGaQg75i2dqQkIQBWFDtkrZkPQ=
X-Google-Smtp-Source: AAOMgpcVV6nU5r9iBmfrkGS8GjMwgnswb8F9i1qGF/TCz9hYG+zMS+AUjBCryA7IH5VPGxmTdqSZnvG9yN/pYER+EDk=
X-Received: by 2002:a9d:72c6:: with SMTP id d6-v6mr526369otk.345.1530042507304;
 Tue, 26 Jun 2018 12:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
In-Reply-To: <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 26 Jun 2018 15:47:51 -0400
X-Gmail-Original-Message-ID: <CAGM2rebiy7fMssEvnxj9DLNN-SGzgULh7iuMfe4=dgF89H5DFQ@mail.gmail.com>
Message-ID: <CAGM2rebiy7fMssEvnxj9DLNN-SGzgULh7iuMfe4=dgF89H5DFQ@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:42 PM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> Hi Thomas,
>
> On Tue, Jun 26, 2018 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Pavel,
> >
> > first of all, sorry for my last outburst. I just was in a lousy mood after
> > staring into too much half baken stuff and failed to make myself stay away
> > from the computer.
>
> Thank you.
>
> >
> > On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> > > On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> > > And this early init sequence also needs to pull over the tsc adjust
> > > magic. So tsc_early_delay_calibrate() which should btw. be renamed to
> > > tsc_early_init() should have:
> > >
> > > {
> > >       cpu_khz = x86_platform.calibrate_cpu();
> > >         tsc_khz = x86_platform.calibrate_tsc();
> > >
> > >         tsc_khz = tsc_khz ? : cpu_khz;
> > >         if (!tsc_khz)
> > >                 return;
> > >
> > >         /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> > >         tsc_store_and_check_tsc_adjust(true);
> > >
> > >       calc_lpj(tsc_khz);
> > >
> > >       tsc_sched_clock_init();
> > > }
> >
> > Peter made me look deeper into this and there are a few issues, which I
> > missed, depending on when some of the resources become available. So we
> > probably cannot hook all of this into tsc_early_delay_calibrate().
> >
> > I have an idea how to distangle it and we'll end up in a staged approach,
> > which looks like this:
> >
> >     1) Earliest one (not sure how early yet)
> >
> >        Attempt to use MSR/CPUID. If not running on a hypervisor this can
> >        try the quick PIT calibration, but nothing else.
> >
> >     2) Post init_hypervisor_platform()
> >
> >        An attempt to use the hypervisor data can be made.
> >
> >     3) Post early_acpi_boot_init()
> >
> >        This can do PIT/HPET based calibration
> >
> >     4) Post x86_dtb_init()
> >
> >        PIT/PMTIMER based calibration
> >
> > Once tsc_khz is known, no further attempts of calibration are made. I'll
> > look into that later tonight.
>
> I think, there are no reasons to try staged attempts. It usually gets
> harder to maintain overtime. In my opinion it is best if do it in two
> tries, as right now, but just cleaner. The first attempt we get a
> crude result, using the lowest denominator to which current logic
> might fallback if something else is not available that early in boot:
> i.e cpu calibration loop in native_calibrate_cpu() but later get
> something better. Also, even if early clock does not work because we
> could not get tsc early, it is not a problem, we still will probably
> determine it later during tsc_init call.

Actually, nevermind, I looked through the code again, it seems that if
we get early tsc frequency we can keep it, but otherwise just try it
again at later time when in tsc_init(). So, no need for
cyc2ns_reinit_boot(). I still think no need for staged attempts, but
try in two different places: in tsc_init_early() -> works? use that
tsc frequency later, does not try again in tsc_init(), and use the new
one.

In tsc_init we can have something like this:
void __init tsc_init(void)
{
        if (!boot_cpu_has(X86_FEATURE_TSC))
                return;

        /* See if we were not able to determine tsc frequency early,
but can now */
        if (!tsc_khz && determine_cpu_tsc_frequncies()) {
              /* Sanitize TSC ADJUST before cyc2ns gets initialized */
              tsc_store_and_check_tsc_adjust(true);
               cyc2ns_init_boot_cpu();
        }
        ....

}

Pavel
