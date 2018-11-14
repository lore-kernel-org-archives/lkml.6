Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02CDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FC5223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FC5223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbeKOEex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:34:53 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:53019 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeKOEex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:34:53 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gMzvr-0003eq-Ig from joseph_myers@mentor.com ; Wed, 14 Nov 2018 10:30:31 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 14 Nov 2018 18:30:28 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gMzvn-0005QZ-Kz; Wed, 14 Nov 2018 18:30:27 +0000
Date:   Wed, 14 Nov 2018 18:30:27 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <carlos@redhat.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, <dancol@google.com>,
        <nd@arm.com>, Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        GNU C Library <libc-alpha@sourceware.org>,
        Firoz Khan <firoz.khan@linaro.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <CAK8P3a1S65QSRruig+hg_03XbcNges1oR0YWivypvcp7r79Lew@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811141825210.16571@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <20181113193859.GJ3505@e103592.cambridge.arm.com> <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com> <fb340c72-c484-7f55-a2bd-71e072d7f1f5@redhat.com>
 <CAK8P3a1S65QSRruig+hg_03XbcNges1oR0YWivypvcp7r79Lew@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Arnd Bergmann wrote:

> Firoz Khan is in the process of doing part of this, by changing the
> in-kernel per-architecture unistd.h and syscall.S files into a
> architecture independent machine-readable format that is used to
> generate the existing files. The format will be similar to what
> we have on arm/s390/x86 in the syscall.tbl files already.

Will this also mean the following are unable to occur in future (both have 
occurred in the past):

* A syscall added to unistd.h for an architecture, but not added to the 
syscall table until sometime later?

* A syscall added to the native syscall table for some ABI (e.g. 32-bit 
x86 or arm) but not added to the corresponding compat syscall table (e.g. 
32-bit x86 binaries running on x86_64, 32-bit arm binaries running on 
arm64) until sometime later?

Avoiding both of those complications is beneficial to libc (as is a third 
thing, avoiding a syscall being added to different architectures in 
different versions).

-- 
Joseph S. Myers
joseph@codesourcery.com
