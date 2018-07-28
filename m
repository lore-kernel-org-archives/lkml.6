Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE6C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 17:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2C220894
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 17:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C220894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeG1Sr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 14:47:59 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:52498 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729206AbeG1Sr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 14:47:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D6D44180A68A0;
        Sat, 28 Jul 2018 17:20:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sign88_40df5778e5f13
X-Filterd-Recvd-Size: 2298
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Jul 2018 17:20:45 +0000 (UTC)
Message-ID: <b8d9aa953d1e760b35bd4ef6c689dfb777c8a6a0.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 28 Jul 2018 10:20:44 -0700
In-Reply-To: <alpine.DEB.2.20.1807280823200.2466@hadrien>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
         <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
         <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
         <9d7441a14897426f8ed5befe8da0cad3@AcuMS.aculab.com>
         <0a6d2ecfacf3786228de664c8e01f6de10314c1b.camel@perches.com>
         <9f0377fa74bd4964912ba5a4fc76526d@AcuMS.aculab.com>
         <1a75fda0861a0b2bce208fbf9b53785bf0e76fa2.camel@perches.com>
         <alpine.DEB.2.20.1807280823200.2466@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(unintentionally sent partial reply, better now)

On Sat, 2018-07-28 at 08:25 +0200, Julia Lawall wrote:
> On Fri, 27 Jul 2018, Joe Perches wrote:
[]
> > It might make sense for this sort of check to be
> > added to coccinelle or maybe as a compiler warning
> > when the struct is larger than some size.
> > 
> > Original thread for Julia:
> > https://lore.kernel.org/patchwork/patch/967890/
> 
> Coccinelle doesn't directly know the size of the structure, but it can
> count the number of fields.  Maybe a case with an update in the function
> body

Perhaps this might be the most useful to check.

>  or at least 3 fields is worth reporting on?

Maybe, maybe not.  For instance:

lib/vsprintf.c uses struct printf_spec which is
5 fields totaling 8 bytes and that fits nicely in
a single register on x86-64 so there are good
reasons why structs could be passed by value.

Maybe structs with arrays or other structs would
make more sense.


