Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850BDC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5157A222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550022314;
	bh=hllCbHgEVPlzFQ9DtutJC8caAJrD+2k4qw0FnL5t6qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BVF57s3Pnb6EhGmBcrlzSegVmbMf7IAbKabY0MF3LN9B/bSH7hqR9jGczk7ikUV2C
	 VNPdI3AeNojeh3lcPK2c/f1JSVW4zxas61P8+vF74ULaDwe7wDtrIocA7gbgUy+gBj
	 QamS/Iq4cakKxpCx+OXlcm/ZooTWyjQv0pqmWcTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbfBMBpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfBMBpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:45:12 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCF1222BA;
        Wed, 13 Feb 2019 01:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550022311;
        bh=hllCbHgEVPlzFQ9DtutJC8caAJrD+2k4qw0FnL5t6qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjtd83Feav0TixOtfOPfNLkXjnkC7zYaMBrcTPYZgfUG5137uAaZEiRWkYOaywpnp
         PU952thf2fh7tFHaDk/m9C/WTHzazS+nYbh4uD47qxpxQl1x0CGRT1V+pm79NOhRuc
         LR3S+J8J6yeJkTh6dV9mt4neaaXq7CpJBF9rd8ZQ=
Date:   Wed, 13 Feb 2019 09:45:04 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Message-ID: <20190213014400.GA9895@guoren-Inspiron-7460>
References: <1549861699-11875-1-git-send-email-guoren@kernel.org>
 <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
 <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:36:04PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 11, 2019 at 7:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> > >
> > > arch/csky patches for 5.0-rc6
> >
> > The bulk of this seems to be new hardware support code.
> >
> > Please send it during the 5.1 merge window, not as fixes at post-rc6 time.
> 
> Aside from this, I also noticed that the new code is for drivers/irqchip,
> which is a separate subsystems with its own maintainers, who were
> neither on Cc nor did they Ack the patches.
Yes, there are:
	dt-bindings: csky,apb-intc: Add vector irq mode
	irqchip/csky: Add support-vector-irq for apb-intc
	irqchip/csky: Optimize remove unnecessary loop irq handle
	irqchip/irq-csky-mpintc: Add triger type and priority
	dt-bindings: interrupt-controller: Update csky mpintc

I just send these patches to the mail-list before, but not get Ack. I'll add
Cc in these patches and resend them to the mail list.

> 
> Generally, those should get merged through the respective subsystem
> trees as listed in the linux/MAINTAINERS file.
Ok, I'll remove them in this pull request.

Best Regards
 Guo Ren
