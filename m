Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D50AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B602243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B602243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbeKOBLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:11:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbeKOBLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:11:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B70D630024A5;
        Wed, 14 Nov 2018 15:07:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-210.ams2.redhat.com [10.36.117.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FA9361470;
        Wed, 14 Nov 2018 15:07:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Daniel Colascione <dancol@google.com>, nd <nd@arm.com>,
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
        <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
        <1C1B38FC-1266-4A91-B8F6-20A0C49ED1E2@amacapital.net>
Date:   Wed, 14 Nov 2018 16:07:17 +0100
In-Reply-To: <1C1B38FC-1266-4A91-B8F6-20A0C49ED1E2@amacapital.net> (Andy
        Lutomirski's message of "Wed, 14 Nov 2018 06:46:47 -0800")
Message-ID: <87va4zaeai.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 14 Nov 2018 15:07:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

> Thread cancellation is a big mess, and we only really need to support
> it because on legacy code. The whole mechanism should IMO be
> considered extremely deprecated.

The part regarding legacy code is not true: people write new code using
it all the time.  It's true that this feature is difficult to use, and
it is often employed in cases where it is not needed or
counterproductive.  However, there are cases where code becomes simpler.

Thanks,
Florian
