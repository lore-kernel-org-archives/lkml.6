Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66011C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226F52083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226F52083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeFSWhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:37:43 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:50854 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750949AbeFSWhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:37:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D46BA181D3419;
        Tue, 19 Jun 2018 22:37:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hall50_7cd9f9c20dd23
X-Filterd-Recvd-Size: 2121
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 22:37:37 +0000 (UTC)
Message-ID: <3013aae1803c096645887864d1b161efbfba7c77.camel@perches.com>
Subject: Re: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded
 name
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        netdev <netdev@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 15:37:36 -0700
In-Reply-To: <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
         <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
         <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 00:36 +0300, Andy Shevchenko wrote:
> On Mon, Jun 18, 2018 at 2:08 PM, Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com> wrote:
> > Switch hardcoded function name with a reference to __func__ making
> > the code more maintainable. Address below checkpatch warning:
> > 
> > WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
> > this function's name, in a string
> > +               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
> > 
> > WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
> > this function's name, in a string
> > +               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
> > 
> 
> For dev_dbg() the __func__ should be completely dropped away.

Not really the same.

dev_dbg without CONFIG_DYNAMIC_DEBUG does not have
the ability to prefix __func__.

