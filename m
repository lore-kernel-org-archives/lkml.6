Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F763C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4565E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfAJPPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:15:44 -0500
Received: from manchmal.in-ulm.de ([217.10.9.201]:39986 "EHLO
        manchmal.in-ulm.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfAJPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:15:44 -0500
Date:   Thu, 10 Jan 2019 16:15:40 +0100
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Breno Leitao <leitao@debian.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <1547133048@msgid.manchmal.in-ulm.de>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net>
 <20190109143811.GB29274@kroah.com>
 <20190109194048.GA11505@roeck-us.net>
 <20190110065207.GA17195@kroah.com>
 <20190110131743.GE20217@kroah.com>
 <1547130295@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547130295@msgid.manchmal.in-ulm.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Biedl wrote...

> Sorry for not getting back to you earlier. Building yesterday's
> release (v4.19.14) *failed*, bisect led to
>
> | commit a9935a12768851762089fda8e5a9daaf0231808e (HEAD)
> | Author: Breno Leitao <leitao@debian.org>
> | Date:   Mon Nov 26 18:12:00 2018 -0200
> |
> |     powerpc/tm: Unset MSR[TS] if not recheckpointing
>
> Reverting that commit seems to be sufficient, build passes then.
>
> Additionally, neither 4.20 nor 5.0-rc1 show this problem. The
> | commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
> builds as well, so I'll try to find the missing prerequisite next.

Cherry-picking

| commit 5c784c8414fba11b62e12439f11e109fb5751f38
| Author: Breno Leitao <leitao@debian.org>
| Date:   Thu Aug 16 14:21:07 2018 -0300
|
|     powerpc/tm: Remove msr_tm_active()

makes the build pass. Bruno, does this make sense?

     Christoph
