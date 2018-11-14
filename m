Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CF521582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CF521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeKNVnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:43:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeKNVnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:43:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFB93306B62A;
        Wed, 14 Nov 2018 11:40:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-210.ams2.redhat.com [10.36.117.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50B915D9CC;
        Wed, 14 Nov 2018 11:40:51 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <877ehjx447.fsf@oldenburg.str.redhat.com>
        <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
        <875zx2vhpd.fsf@oldenburg.str.redhat.com>
        <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
        <20181113193859.GJ3505@e103592.cambridge.arm.com>
        <69B07026-5E8B-47FC-9313-E51E899FAFB0@amacapital.net>
        <20181114105449.GK3505@e103592.cambridge.arm.com>
Date:   Wed, 14 Nov 2018 12:40:44 +0100
In-Reply-To: <20181114105449.GK3505@e103592.cambridge.arm.com> (Dave Martin's
        message of "Wed, 14 Nov 2018 10:54:51 +0000")
Message-ID: <877ehfdgzn.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 14 Nov 2018 11:40:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Martin:

> Fair points, though this is rather what I meant by "sane essentials".
> Because there are strict limits on what can be done in the vDSO, it may
> be more bloat-resistant and more conservatively maintained.
>
> This might provide a way to push some dumb compatibility kludge code
> that receives little ongoing maintenance outside the privilege wall,
> whereas it has to sit in the kernel proper today.
>
> In theory we could opt to advertise new syscalls only via vDSO entry
> points, and not maintain __NR_xxx values for them (which may or may
> not upset ptrace users.)  Anyway, I digress...

Is the vDSO available across all architectures?  (I don't think we use
it on all architectures in glibc.)

If not, a vDSO-based approach would merely lead to even more variance
between architectures, which can't be a good thing.

Thanks,
Florian
