Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CFECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FF920673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CIXpKmxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FF920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeGRCOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:14:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51510 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRCOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:14:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I1YKif168897;
        Wed, 18 Jul 2018 01:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=DOv1mAkL1aMLDz8MX2V5SYhP+2MHPCPDfqA1pl9otyg=;
 b=CIXpKmxkmgCbXHVff+EAD/aHozWj1/3QBgHm/L3zXKK8gtFR2QLTcQq1Iy2TOGzr8/yL
 9zd4+qVsomAgan6+v3juyPD8ryTPXBsug8cMvGFssZqxCg0scHCllO9lFJ0h2MQzhBWn
 QTQKUdEf55iesPTrcSeKEk1AXCHe8Q71FH3YHP7TbLwuqp4CY0GjiPGaPmawvT2uYlVU
 nzlLHlzEobcTkO+lzdPn3maX1yU+EyfukL+TWjsrBDxDEpMs57iAGQpOearPV09lOlwN
 1wS29M9kKwYZvSANShRPqgfaRgVtSDEVjUuYu4UmxoCRK6p2h1i3NTi8QqOmHSueDykK qA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3t329j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 01:38:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I1cdNo001864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 01:38:40 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I1cdqL026575;
        Wed, 18 Jul 2018 01:38:39 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 18:38:39 -0700
Received: by mail-oi0-f44.google.com with SMTP id q11-v6so5690945oic.12;
        Tue, 17 Jul 2018 18:38:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlGJk+J6cVqx/gFlc14AO9pKaMFh28al3R97V/piFNcKITKqlenB
        cxBy3cHbkvZUpuTxBfXejWTTaKoqVkdzQIHRvzw=
X-Google-Smtp-Source: AAOMgpd1pidf8C1z58MBtrj211IxGRk3Uz45WMmdRPnWJx4wznwdr8QX/ktsZC6VCBtQHskDUANQdM9chrAaXEgxWfE=
X-Received: by 2002:aca:b541:: with SMTP id e62-v6mr3757618oif.136.1531877918775;
 Tue, 17 Jul 2018 18:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-7-pasha.tatashin@oracle.com> <cf7ef6d0-8650-3e8a-0e15-5150b58d1b50@oracle.com>
In-Reply-To: <cf7ef6d0-8650-3e8a-0e15-5150b58d1b50@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 17 Jul 2018 21:38:02 -0400
X-Gmail-Original-Message-ID: <CAGM2reZTfuMhKZLApidBcenbeJTYt6n_56htaK5YkDPseb_Bqw@mail.gmail.com>
Message-ID: <CAGM2reZTfuMhKZLApidBcenbeJTYt6n_56htaK5YkDPseb_Bqw@mail.gmail.com>
Subject: Re: [PATCH v13 06/18] x86/xen/time: initialize pv xen time in init_hypervisor_platform
To:     boris.ostrovsky@oracle.com
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
        jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
> > +     HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
> > +
> > +     /* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
> > +     xen_vcpu_info_reset(0);
>
>
> I don't believe this is necessary, it has been done in
> xen_start_kernel() for PV guests.

We need it, because HYPERVISOR_shared_info has changed from dummy.
And, to output timestamps we must have access to the actual shared
page.

> > +
> > +     /* pvclock is in shared info area */
> > +     xen_init_time_ops();
> > +}
> > +
>
>
>
> >  }
> >
> > -void __ref xen_init_time_ops(void)
> > +void __init xen_init_time_ops(void)
> >  {
> >       pv_time_ops = xen_time_ops;
> >
> > @@ -542,17 +542,11 @@ void __init xen_hvm_init_time_ops(void)
> >               return;
> >
> >       if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
> > -             printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
> > -                             "disable pv timer\n");
> > +             pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
> >               return;
> >       }
> > -
> > -     pv_time_ops = xen_time_ops;
> > +     xen_init_time_ops();
>
>
> As we discussed elsewhere, now that HVM guests call this routine as well
> we need to make sure that x86_init.timers.timer_init is not updated
> there for HVM since those guests expect a "real" timer to be connected
> to IO-APIC.

Yes, I decided to keep xen_init_time_ops() and xen_hvm_init_time_ops()
separate. The unification does not save that many LOC, but increase
the complexity.

Thank you,
Pavel
