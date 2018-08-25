Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AC6216E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AC6216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeHYWHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 18:07:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHYWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 18:07:45 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftdHz-0002Id-8j; Sat, 25 Aug 2018 20:27:59 +0200
Date:   Sat, 25 Aug 2018 20:27:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Query on skip_onerr field in struct cpuhp_step
In-Reply-To: <a8599754-5c8b-1667-1685-901f53319064@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1808252025590.1195@nanos.tec.linutronix.de>
References: <c228c495-63fa-5af9-32ff-355410d78cc8@codeaurora.org> <alpine.DEB.2.21.1808211557180.1535@nanos.tec.linutronix.de> <a8599754-5c8b-1667-1685-901f53319064@codeaurora.org>
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

On Tue, 21 Aug 2018, Mukesh Ojha wrote:
> On 8/21/2018 7:27 PM, Thomas Gleixner wrote:
> > > If it is specifically was dependent on notifiers, did we missed to remove
> > > it as the notifiers are gone or the usecase still there?
> > As the comment says....
> 
> Thanks for your reply
> Sorry, for further question but i did not get the comment ..did you mean, we
> can remove this from the structure as notifier are not their now. ?

Yes, that's why the comment for that member says: Remove after conversion.

> Also if you are aware with the history, can you tell , why would i want to
> avoid a call in undo_cpu_up path?

Because the notifiers worked completely differently. Go back in the
git history where the initial conversion from notifiers to the state
machine happened.

Thanks,

	tglx
