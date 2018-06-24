Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC8C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201B824EF0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201B824EF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFXNK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:10:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeFXNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:10:26 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX4me-00055N-Av; Sun, 24 Jun 2018 15:10:24 +0200
Date:   Sun, 24 Jun 2018 15:10:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     air icy <icytxw@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: UBSAN: Undefined behaviour in kernel/time/posix-timers.c:705
In-Reply-To: <CAAzSK-zX4VuHwSc2mE5dagnfRyiCmV1S=RJZ1P3MKqLdqjmdNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806241507590.8650@nanos.tec.linutronix.de>
References: <CAAzSK-zX4VuHwSc2mE5dagnfRyiCmV1S=RJZ1P3MKqLdqjmdNA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, air icy wrote:
> ================================================================================
> UBSAN: Undefined behaviour in kernel/time/posix-timers.c:705:20
> signed integer overflow:
> -1863446814 + -1863446813 cannot be represented in type 'int'

Yuck. Both numbers are bogus if I looked at the correct place.

> bugzilla url:https://bugzilla.kernel.org/show_bug.cgi?id=200189
> 
> This bug can be repro, if you need this, please me.

Reproducer please.

Thanks,

	tglx
