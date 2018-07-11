Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD7EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6C720C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6C720C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbeGKRPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:15:23 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:56969 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390017AbeGKRPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:15:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EA1D31802A37A;
        Wed, 11 Jul 2018 17:10:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: duck95_a486b15c84c
X-Filterd-Recvd-Size: 2624
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Jul 2018 17:10:04 +0000 (UTC)
Message-ID: <c13fc12e859f7bdb300f08ad805cdf6d7ec09f52.camel@perches.com>
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
From:   Joe Perches <joe@perches.com>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Date:   Wed, 11 Jul 2018 10:10:03 -0700
In-Reply-To: <2d2f2b2b-394a-506f-c870-33520335250b@linux.intel.com>
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
         <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
         <2d2f2b2b-394a-506f-c870-33520335250b@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 09:53 -0700, Jae Hyun Yoo wrote:
> On 7/10/2018 10:42 PM, Brendan Higgins wrote:
> > On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> > > There are some log printing without a newline character. This
> > > patch adds the missing newline characters.
[]
> > > diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
[]
> > > @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> > >           */
> > >          if (bus->master_state == ASPEED_I2C_MASTER_START) {
> > >                  if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> > > -                       pr_devel("no slave present at %02x", msg->addr);
> > > +                       pr_devel("no slave present at %02x\n", msg->addr);
> > 
> > Unless something changed in the last couple versions of the kernel, this is the
> > only line that actually changes anything. dev_* inserts a newline for every
> > call.

Not true.

Any printk without KERN_CONT inserts a newline
if the last character
emitted is not a newline.

dev_<level> uses can also be followed by pr_cont.

So this patch does reduce the possibility of
interleaved messages from multiple processes.
