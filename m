Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21640C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C881021775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C881021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeHCSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:05:27 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:33587 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727128AbeHCSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:05:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 638FE100E86C6;
        Fri,  3 Aug 2018 16:08:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cup41_4a15fe994185f
X-Filterd-Recvd-Size: 1736
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Aug 2018 16:08:28 +0000 (UTC)
Message-ID: <bd1182e9417da5f1aa13659870e333d26c4be35a.camel@perches.com>
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
From:   Joe Perches <joe@perches.com>
To:     Linus Walleij <linus.walleij@linaro.org>, fe@dev.tdt.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Aug 2018 09:08:27 -0700
In-Reply-To: <CACRpkdbY3w-ptUOkv5TUZh+5oEGU+4BLO_6=12QecRveTSBKSQ@mail.gmail.com>
References: <20180801111243.2848-1-fe@dev.tdt.de>
         <CACRpkdbY3w-ptUOkv5TUZh+5oEGU+4BLO_6=12QecRveTSBKSQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 23:30 +0200, Linus Walleij wrote:
> On Wed, Aug 1, 2018 at 1:12 PM Florian Eckert <fe@dev.tdt.de> wrote:
[]
> > +       spinlock_t lock;
> 
> I think checkpatch now mandates that you put in a comment
> about what this lock is locking.

Please remember that checkpatch doesn't mandate anything.

Documentation/process/4.Coding.rst does have:

   Certain things should always be commented.  Uses of memory barriers should
   be accompanied by a line explaining why the barrier is necessary.  The
   locking rules for data structures generally need to be explained somewhere.

So there should be some comment somewhere in the code
for the spinlock.

