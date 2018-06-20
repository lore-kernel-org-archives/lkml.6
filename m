Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F195AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BA4208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BA4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeFTIeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:34:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754592AbeFTIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:34:01 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVYYw-0000w9-62; Wed, 20 Jun 2018 10:33:58 +0200
Date:   Wed, 20 Jun 2018 10:33:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Evgeniy Dushistov <dushistov@mail.ru>, y2038@lists.linaro.org,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: use ktime_get_real_seconds for sb and cg
 timestamps
In-Reply-To: <20180619154752.3768171-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1806201033350.10546@nanos.tec.linutronix.de>
References: <20180619154752.3768171-1-arnd@arndb.de>
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

On Tue, 19 Jun 2018, Arnd Bergmann wrote:

> get_seconds() is deprecated because of the 32-bit overflow and will
> be removed. All callers in ufs also truncate to a 32-bit number, so
> nothing changes during the conversion, but this should be harmless as the
> superblock and cylinder group timestamps are not visible to user space,
> except for checking the fs-dirty state, wich works fine across the
> overflow.
> 
> This moves the call to get_seconds() into a new inline function, with
> a comment explaining the constraints, while converting it to
> ktime_get_real_seconds().

Acked-by: Thomas Gleixner <tglx@linutronix.de>
