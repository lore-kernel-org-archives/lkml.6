Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51522C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0265A23D94
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qNUKf05F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0265A23D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGFPEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:04:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeGFPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:04:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w66F4DTe062746;
        Fri, 6 Jul 2018 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=ioYTIstXatHoKWUxeJ9BSeiYteM344FqBVieAB0XrGk=;
 b=qNUKf05FqAqXsaD+zlt7yVgqBhItFdqoF3pyn1SfrOVjH+4GPkQDPbhOqkFEWk7Q2oa+
 NyZrZyGG/WrUbB7BpfkD2rkIOj9QdC7H/+jvSAdSfxGzPQ8NAhGdniH9ursVHYYsk3t4
 iYirsmlWoZGJR7bRZQH3DmuxlfIoEOu+8HpuSEjFOsDmHllsk1VmG3NYlCn6vaJCKlVS
 ro4DQEuc99VAZpfuV2vENuDWOLiHCc5lKnl/DBl3n4tnHBmTxcHCT0NsMVEeASaYHfJf
 zKJ5hc75+QeSRSGUvBIV2XC+IPZbuJHLuCVMNkE9E+7fCUbKefwylZEv82EfJu9cFmoB ww== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k0dnjt4bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 15:04:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w66F4OGC017369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 15:04:24 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w66F4OEn008745;
        Fri, 6 Jul 2018 15:04:24 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 08:04:24 -0700
Received: by mail-oi0-f47.google.com with SMTP id 13-v6so24043136ois.1;
        Fri, 06 Jul 2018 08:04:07 -0700 (PDT)
X-Gm-Message-State: APt69E3xsIIOdXv5qGlA3NoxRIMaj1SLRyq+E8KJoyPjVNmM6PyAhdVO
        pETS4EdMkvjOH3wgbdP1SD9J+fVmQdsV2teL8Ck=
X-Google-Smtp-Source: AAOMgpcWAzspkePTVIQT2M26bue2/O+SswDa6lAvFY04sgmvgBV1Oka+1Tyb/HHRyC9u7eSfusD9xgp8c+nUaZ8A08o=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr10885611oih.65.1530889436802;
 Fri, 06 Jul 2018 08:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-5-pasha.tatashin@oracle.com> <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
 <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
 <52117b6e-cbdc-8583-494b-5e8e5d6d4265@redhat.com> <alpine.DEB.2.21.1807061142320.1664@nanos.tec.linutronix.de>
 <585b3646-5515-240a-db57-406d6c311a43@redhat.com> <alpine.DEB.2.21.1807061243400.1664@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807061248410.1664@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807061248410.1664@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 6 Jul 2018 11:03:54 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ1fkvzECyy4Eo+O9ZE-ddJvE3hFtPGUAv=QJ9Cv_hJvw@mail.gmail.com>
Message-ID: <CAGM2reZ1fkvzECyy4Eo+O9ZE-ddJvE3hFtPGUAv=QJ9Cv_hJvw@mail.gmail.com>
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
To:     tglx@linutronix.de
Cc:     pbonzini@redhat.com, Steven Sistare <steven.sistare@oracle.com>,
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8945 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think using __initdata during init_hypervisor_platform()  +
allocating during x86_init.hyper.guest_late_init() is a good approach.
My only concern, it would mean we need to init/uinit/init clock for
boot cpu. Does it mean the clock continuity is preserved during the
transition? I believe so, but needs to be verified.

Pavel
On Fri, Jul 6, 2018 at 6:53 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 6 Jul 2018, Thomas Gleixner wrote:
> > On Fri, 6 Jul 2018, Paolo Bonzini wrote:
> > > On 06/07/2018 11:45, Thomas Gleixner wrote:
> > > >> One possibility is to introduce another layer of indirection: in
> > > >> addition to the percpu pvclock data, add a percpu pointer to the pvclock
> > > >> data and initialize it to point to a page-aligned variable in BSS.  CPU0
> > > >> (used by vDSO) doesn't touch the pointer and keeps using the BSS
> > > >> variable, APs instead redirect the pointer to the percpu data.
> > > > Yeah, thought about that, but the extra indirection is ugly. Instead of
> > > > using per cpu data, I just can allocate the memory _after_ the allocators
> > > > are up and running and use a single page sized static __initdata for the
> > > > early boot.
> > >
> > > Either works for me.  Assembly-wise, the indirection should be more or
> > > less the same as what we have now; even more efficient because it
> > > accesses a percpu pointer instead of computing it based on
> > > smp_processor_id().
> >
> > Good point. Let me try that.
>
> Duh, that either requires a static key or a static PER_CPU pointer thingy,
> which then wastes 8 bytes per cpu instead of 64 byte if unused.
>
> Thanks,
>
>         tglx
