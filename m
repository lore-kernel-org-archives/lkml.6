Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD598C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552D421A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552D421A67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeHFSwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:52:55 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:48239 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728417AbeHFSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:52:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7A7CC18035058;
        Mon,  6 Aug 2018 16:42:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: start28_712ba3e245015
X-Filterd-Recvd-Size: 2047
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Aug 2018 16:42:57 +0000 (UTC)
Message-ID: <fa7980ee38e6cbb31883e1b942fa1e1d6f0e72b0.camel@perches.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: use true and false for boolean
 values
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Aug 2018 09:42:56 -0700
In-Reply-To: <e92131c3b6e04a848f2a7922719f4747@AcuMS.aculab.com>
References: <20180805001839.GA22975@embeddedor.com>
         <CAHp75Vc=HLMVhQ30z9LTM7z+nmYgYPSRJib0PVTVW8H25eYg5g@mail.gmail.com>
         <e92131c3b6e04a848f2a7922719f4747@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 16:41 +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 05 August 2018 11:26
> > 
> > On Sun, Aug 5, 2018 at 3:18 AM, Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> > > Return statements in functions returning bool should use true or false
> > > instead of an integer value.
> > > 
> > > This code was detected with the help of Coccinelle.
> > >  static bool has_cap(u32 cap)
> > >  {
> > >         if ((interface->capability & cap) != 0)
> > > -               return 1;
> > > +               return true;
> > > 
> > > -       return 0;
> > > +       return false;
> > >  }
> > 
> > this entire function can be oneliner:
> > 
> > return !!(...);
> 
> Why the !! ?? Just:
> 	return (interface->capability & cap) != 0;

Because the return is bool you don't need the !! either.
The compiler does that.

