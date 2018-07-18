Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E03FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF95D2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="azdtECHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF95D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeGRCfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:35:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35552 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbeGRCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:35:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I1xtuq156686;
        Wed, 18 Jul 2018 01:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=3K7dODvDLZCT6t5t0vDDX/QTnGD7urDieh1YXC0n6UY=;
 b=azdtECHCGwQP6pxt4Q3FS3T4CS3+0DqQT+h2cJ0Qq0UPfeQp2bM8E75PH2ohcrg4o4ve
 3G5mGRht7uC7sqC0IiIYqsbZEe93OpKyTThlRMhkDzCxUbZwSgmhJOmA8KnsylUuZ0Qb
 7FKPYM0Gdjc0qBS9JogwSrvIUBK8EoaLgwadYJa/nSA+HNE+gy2dU4h9iZ/SR+ukeWsC
 nS1EutFyKPe+8nI7I9wEWrFadRh9+8uR09FPsKdGY/9dC0HysfttfaHW9R0uhyrqoPLh
 MHNNGCiVCVVfKho/1js3I20ow4m3hQyP3e+lGkG5hl/bDUOJm6E5GsRxk5hmevlLkBjz yw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k7a3tb2xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 01:59:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I1xq5r009133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 01:59:52 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I1xqRj004580;
        Wed, 18 Jul 2018 01:59:52 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 18:59:52 -0700
Received: by mail-oi0-f48.google.com with SMTP id s198-v6so5775591oih.11;
        Tue, 17 Jul 2018 18:59:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlHdQcA1wPMyH08RzVs+2939MPSP4zS9Ij1483P1YfdhPKNUfiMM
        x9skTEJazb4uUaaDAJ3EOkDbsaPyCxkds3VUcA4=
X-Google-Smtp-Source: AAOMgpcgvGulxLG8gSKKbjIYOlMgfaA5/Q+2ji8sce/sp+jTPH0sC6xqgZXJdw7h2AqXMabRc2erb53HiGeB8/EDdo0=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr4591566oia.229.1531879191321;
 Tue, 17 Jul 2018 18:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-8-pasha.tatashin@oracle.com> <93178b98-8464-ae36-3536-0baa639b3467@oracle.com>
In-Reply-To: <93178b98-8464-ae36-3536-0baa639b3467@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 17 Jul 2018 21:59:15 -0400
X-Gmail-Original-Message-ID: <CAGM2rea50hAAa2L2_zPYgY6-08eTMWVRjoP_KAZpRg21TEd11Q@mail.gmail.com>
Message-ID: <CAGM2rea50hAAa2L2_zPYgY6-08eTMWVRjoP_KAZpRg21TEd11Q@mail.gmail.com>
Subject: Re: [PATCH v13 07/18] x86/xen/time: output xen sched_clock time from 0
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=670
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static u64 xen_sched_clock(void)
> > +{
> > +     return xen_clocksource_read() - xen_sched_clock_offset;
> > +}
>
>
> Should other invocations of xen_clocksource_read() also be offset?
>

I do not believe so. Look in arch/x86/kernel/kvmclock.c
kvm_clock_get_cycles() is not normalized for instance. We need to
normalize kvm_sched_clock_read() and xen_sched_clock(), because it is
used by printk() as a sched_clock() prefix. So not to be confusing we
print time starting from 0, but the other instances where
xen_clocksource_read()  is used do not need that.

Thank you,
Pavel
