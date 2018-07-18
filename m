Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A27ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03A62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V/WIr3dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03A62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGROMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:12:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44018 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeGROMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:12:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6IDYF8Y060506;
        Wed, 18 Jul 2018 13:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=dZRph/gIfUB3wE6mu78uooo1qdPlKxJFMgbM64jynd4=;
 b=V/WIr3dAodU0YTzqfRxP91Jd/8oYpFNrdqKmpd90u3ZJeiOhp9FdZki13adMWblA7nhQ
 QhEMjcNPSLrhoj/3dTCdIBP8DeML8RxIjFr0CO+HhP2fc5RMydJYiKBqMi5hmYpfKgwD
 tgKDSVjS/MndZ3VAa8z4O+m5AdhsaWL1pruFwfpzAXo9wIiAe9KmLB2WFAIBF9BwZerT
 NyQdCHu3RflO47fFZh7Ly3hiBwinhmS1ikycLtZYN2qyQ7yOHtRR6Af1+UaiUA7O1VQ+
 FxBzuKPmMwzNrhHVSXfoANFprbXP/E8MQ8Al+4UoRQTRDIckDQb2bPLcvo3rMaIVFGr7 xg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k9ykc1mte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 13:34:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6IDYDsm006232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 13:34:13 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6IDYCD9024356;
        Wed, 18 Jul 2018 13:34:12 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Jul 2018 06:34:12 -0700
Received: by mail-oi0-f42.google.com with SMTP id d189-v6so8787491oib.6;
        Wed, 18 Jul 2018 06:34:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlEWeCriqMeeFTsLUyLwsLwXkuMcFthGD9dSXgaVpMDI7L1y9owf
        +p2GiUCq6J1+Ej5NCAL7/IbqkVSy4imfpOhpFQ0=
X-Google-Smtp-Source: AAOMgpc9gp3TOdNpjsDd2F+CNK2KabwKGwClOVWDGGPnsn+FJEovnKV1M9+6g32wTIowS/75Q8Tpl07vMrn1Hw+5D80=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr6787446oiy.191.1531920852183;
 Wed, 18 Jul 2018 06:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-9-pasha.tatashin@oracle.com> <ddda16df-cca6-8b9d-6f66-6ff5ecc21a03@redhat.com>
In-Reply-To: <ddda16df-cca6-8b9d-6f66-6ff5ecc21a03@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 18 Jul 2018 09:33:36 -0400
X-Gmail-Original-Message-ID: <CAGM2reY_uf2C2ox4kEmTSuSDm1PbXazTYHuT4shYiZ3WK3vTdQ@mail.gmail.com>
Message-ID: <CAGM2reY_uf2C2ox4kEmTSuSDm1PbXazTYHuT4shYiZ3WK3vTdQ@mail.gmail.com>
Subject: Re: [PATCH v14 08/25] x86/kvmclock: Avoid TSC recalibration
To:     pbonzini@redhat.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Paolo for letting me know. I will remove this patch from the
series, or it can be removed by whomever adds the series.

Thank you,
Pavel
On Wed, Jul 18, 2018 at 7:14 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/07/2018 04:21, Pavel Tatashin wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > If the host gives us a TSC rate, assume it is good and don't try and
> > recalibrate things against virtual timer hardware.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >  arch/x86/kernel/kvmclock.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index ed170171fe49..da0ede8ac8f6 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -141,7 +141,16 @@ static inline void kvm_sched_clock_init(bool stable)
> >   */
> >  static unsigned long kvm_get_tsc_khz(void)
> >  {
> > -     return pvclock_tsc_khz(this_cpu_pvti());
> > +     unsigned long tsc_khz = pvclock_tsc_khz(this_cpu_pvti());
> > +
> > +     /*
> > +      * TSC frequency is reported by the host; calibration against (virtual)
> > +      * HPET/PM-timer in a guest is dodgy and pointless since the host
> > +      * already did it for us where required.
> > +      */
> > +     setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > +
> > +     return tsc_khz;
> >  }
> >
> >  static void kvm_get_preset_lpj(void)
> >
>
> This patch (really a similar one) has just been sent to Linus.
>
> Paolo
