Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30093C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68FD206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68FD206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIZDMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:12:23 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:59910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbeIZDMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:12:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 641951822451E;
        Tue, 25 Sep 2018 21:02:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: van58_366f74ee5895b
X-Filterd-Recvd-Size: 2331
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 21:02:53 +0000 (UTC)
Message-ID: <102e1673681b4efb2079befa8d3fb532ed4e5285.camel@perches.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography
 library
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Date:   Tue, 25 Sep 2018 14:02:52 -0700
In-Reply-To: <CAHmME9qp0_jQn5PeDHJc+Vs003vyqqMTdPmnchjBxxNMvHcJWA@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
         <20180925145622.29959-3-Jason@zx2c4.com>
         <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
         <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
         <748429eee2fc77afd01630c24bd2cf66a545aec5.camel@perches.com>
         <CAHmME9peVqXDq7hmFZ+4cus+Y97NHS-TyBKF9GkdLvixdmq6hw@mail.gmail.com>
         <abedae13e59e01200531931e530b46e937501c4a.camel@perches.com>
         <CAHmME9qp0_jQn5PeDHJc+Vs003vyqqMTdPmnchjBxxNMvHcJWA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 22:54 +0200, Jason A. Donenfeld wrote:
> Hi Joe,
> 
> On Tue, Sep 25, 2018 at 10:21 PM Joe Perches <joe@perches.com> wrote:
> > I'd still prefer as all these are effectively
> > debugging output that you convert the pr_info
> > uses pr_debug and so avoid using pr_fmt altogether.
> 
> I started to write back, "sure no problem, this will be in v7," but
> then I gave it a closer look, and I think actually I'll be changing
> these into pr_err/pr_info and not naming this "DEBUG" but rather
> "SELFTEST", since I think these are actually very good to have beyond
> mere debugging.

Then you should change the CONFIG_ZINC_DEBUG option too.

Dunno what you should do with the

#ifdef DEBUG
	BUG_ON(...);
#endif

uses though.


