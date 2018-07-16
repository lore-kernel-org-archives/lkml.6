Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4421208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4421208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeGPRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:17:40 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:41238 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeGPRRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:17:40 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 035B2901DB;
        Mon, 16 Jul 2018 19:49:24 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id E5E792208EC; Mon, 16 Jul 2018 19:49:21 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id E6BC92206C6;
        Mon, 16 Jul 2018 19:49:21 +0300 (EEST)
Date:   Mon, 16 Jul 2018 19:49:21 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1807161948380.27791@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee> <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com> <alpine.LRH.2.21.1807051254050.21817@math.ut.ee> <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Everything below here is is 'bad', which can be an indication that you
> misclassified one of
> the commits above as 'good' when it should have been 'bad'. The most likely
> explanations are that you either typed the 'git bisect good' by accident, or
> that the failure is not 100% reliable, and it sometimes works fine even on a
> broken kernel.
> 
> 0bc5fe857274133ca0 follows directly after 3a443bd6dd7c, "net/9p: correct the
> variable name in v9fs_get_trans_by_name() comment", which is marked "good",
> and can't really be good if 0bc5fe85727413 is bad and you are not using the
> 'qed' driver.
> 
> I'd retest 3a443bd6dd7c again to see if that should have been 'bad', and
> if it was, test v4.17-rc4, which is what the net-next tree was based on.

Yes, the same prebuilt 3a443bd6dd7c appeared to be bad when retesting 
it. Building v4.17-rc4 now.

-- 
Meelis Roos (mroos@linux.ee)
