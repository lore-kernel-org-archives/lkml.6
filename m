Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C847AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A97E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A97E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeKUH1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:27:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:27:21 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPD47-0001s4-KI; Tue, 20 Nov 2018 21:56:11 +0100
Date:   Tue, 20 Nov 2018 21:56:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Qian Cai <cai@gmx.us>, akpm@linux-foundation.org,
        yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] debugobjects: scale the static pool size
In-Reply-To: <4a4398f6-74a6-9e89-21bc-41c02edda90a@redhat.com>
Message-ID: <alpine.DEB.2.21.1811202155380.1665@nanos.tec.linutronix.de>
References: <20181120201432.2163-1-cai@gmx.us> <4a4398f6-74a6-9e89-21bc-41c02edda90a@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1720567222-1542747371=:1665"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1720567222-1542747371=:1665
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Nov 2018, Waiman Long wrote:
> On 11/20/2018 03:14 PM, Qian Cai wrote:
> >  static struct debug_obj_descr	*descr_test  __read_mostly;
> 
> The calculation for ODEBUG_POOL_SIZE is somewhat hard to read. Maybe you
> can do something like
> 
> #ifdef CONFIG_DEBUG_OBJECTS_WORK
> #define ODEBUG_WORK_PCPU_CNT    10
> #else
> #define ODEBUG_WORK_PCPU_CNT    0
> #endif
> 
> #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
> #define ODEBUG_TIMERS_PCPU_CNT 10
> #else
> #define ODEBUG_TIMERS_PCPU_CNT 0
> #endif
> 
> #define ODEBUG_POOL_SIZE (ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * \
>                          (ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))

Yes please.

Thanks,

	tglx
--8323329-1720567222-1542747371=:1665--
