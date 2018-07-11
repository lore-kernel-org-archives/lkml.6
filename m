Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C97EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6AD20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6AD20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeGKJsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:48:23 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40188 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeGKJsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:48:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 56699485;
        Wed, 11 Jul 2018 11:44:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VBZOoFxBRIMQ; Wed, 11 Jul 2018 11:44:52 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (no3.u-bordeaux.fr [147.210.245.180])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 53D2138D;
        Wed, 11 Jul 2018 11:44:52 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fdBg3-0008NX-RZ; Wed, 11 Jul 2018 11:44:51 +0200
Date:   Wed, 11 Jul 2018 11:44:51 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jann Horn <jannh@google.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>, kirk@reisers.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180711094451.jm6bbbytoapuy4tz@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jann Horn <jannh@google.com>, William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>, kirk@reisers.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
References: <20180707015344.146672-1-jannh@google.com>
 <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
 <CAG48ez3bFxC-MrCKSNtr9di8qWAessD-ZP+51PAMiC2TMZSXOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3bFxC-MrCKSNtr9di8qWAessD-ZP+51PAMiC2TMZSXOw@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jann Horn, le mar. 10 juil. 2018 13:34:33 -0700, a ecrit:
> On Sat, Jul 7, 2018 at 1:29 AM Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> > Could you review, test, and resubmit the patch below instead?
> 
> Er... you mean, you want me to take your patch, add my Signed-off-by
> below yours, and then send that?

Yes, please.

> Some random thing I noticed, but I don't think it has anything to do
> with this issue: In some runs, when the console is repeatedly printing
> "Debian GNU/Linux 9 debian tty1\n\ndebian login: " in response to me
> pressing enter repeatedly, /dev/softsynthu (read in 1-byte steps)
> seems to return things like "Debian GNU slash Linux 9 debian tty1 \n
> debi login: ". I don't understand why it sometimes says "debi login"
> instead of "debian login".

It's odd indeed, but I agree it's unrelated.

Samuel
