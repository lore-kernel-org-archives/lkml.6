Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F49C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6520836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFUKIg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:08:36 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:43620 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932677AbeFUKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:08:35 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 21 Jun 2018 19:08:32 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 21 Jun 2018 19:08:32 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 21 Jun 2018 19:08:30 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180621100830.GC28024@X58A-UD3R>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
 <20180620174037.GZ3593@linux.vnet.ibm.com>
 <20180621063949.GA28024@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621063949.GA28024@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:39:49PM +0900, Byungchul Park wrote:

[...]

> I applied what you suggested and re-named rcu_nmi_{enter,exit} to
                                               ^
                        rcu_nmi_{enter,exit}_common(bool irq)

> rcu_irq_{enter,exit} and applied the same re-naming to
          ^
     rcu_irq_{enter,exit}_common(bool nmi)

> ->dynticks_nmi_nesting as well, since those are not things to do with
           ^
    dynticks_nmi_nesting -> dynticks_irq_nesting

> nmi anymore but both irq and nmi.
> 
> I think "irq" is better to represent both irq and nmi than "nmi".
> Please let me know if you don't think so. I can get rid of the re-
> naming from the patch.

--
Thanks,
Byungchul
