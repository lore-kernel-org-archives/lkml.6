Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C4FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5432168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzXsxFdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5432168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeI1Tmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeI1Tmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:42:43 -0400
Received: from localhost (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1171C214C3;
        Fri, 28 Sep 2018 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538140738;
        bh=TPYS32XGTAZ10xgYc68TDtudhEyoQVPQnzHSYnDQ+fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzXsxFdNyo4fxntV8NxrketTNi3GaR+Ei6gRzsuaHgTFFKQfOozNpOFI3BmqMjtCJ
         KKFEgACS1z7tgVpOjyUX35dvctoJtmgr5snqTN4/SfZ7056ydpQvmFZwOyzx5PwiEU
         fwAfq5tQQUG0cXiA4cpyqU0E2H4TeTBd3HOoKV+A=
Date:   Fri, 28 Sep 2018 15:18:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20180928131855.GB8795@lerouge>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:05:46PM +0200, Thomas Gleixner wrote:
> On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
> > On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
> > > I tested it and Frederic is right, it doesn't help. Can it be somehow related to
> > > the cpu being brought down during suspend? Because I get the warning only during
> > > suspend when the cpu is inactive already (but still online).
> > 
> > It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
> > 
> > Does this script eventually trigger it after some time?
> 
> Any update to this?

Heiner? Can you please test the script I sent to you?

Thanks.
