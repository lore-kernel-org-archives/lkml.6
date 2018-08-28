Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C562087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C562087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeH1WJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:09:29 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:54074 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbeH1WJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:09:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BD541182CF66E;
        Tue, 28 Aug 2018 18:16:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kite47_1c72fc8396542
X-Filterd-Recvd-Size: 2632
Received: from XPS-9350 (unknown [172.56.41.215])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Aug 2018 18:16:35 +0000 (UTC)
Message-ID: <b160878ca73bb0dac9592cfd0440b66dc5244b1d.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Move entry for Cirrus Logic Madera codecs
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Aug 2018 11:16:33 -0700
In-Reply-To: <CANiq72m-kvANJsrWHXHoEfRBRbFDt+0nWzma3HxBrBo9tP9Ouw@mail.gmail.com>
References: <20180828133320.1831-1-geert+renesas@glider.be>
         <57cafda5-d7f4-61a3-7169-38cc2d34abf6@opensource.cirrus.com>
         <CANiq72m-kvANJsrWHXHoEfRBRbFDt+0nWzma3HxBrBo9tP9Ouw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 17:28 +0200, Miguel Ojeda wrote:
> Hi,
> 
> On Tue, Aug 28, 2018 at 3:57 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> > Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > 
> > A maintainer for MAINTAINERS would help avoid these problems, which will
> > tend to happen when changes to the file go through many trees.
> > 
> 
> A year ago Linus committed 7683e9e52 ("Properly alphabetize
> MAINTAINERS file") which adds scripts/parse-maintainers.pl.
> 
> I guess it could just be run once in a while (e.g. before a kernel is
> released, for instance).

And a few patches for parse-maintainers.pl were
added after that.

The latest version also reorders and alphabetizes
the subfields of each section to a preferred order.

So running that latest version would produce quite
a large diff.

That large a diff should only occur once though.

$ perl ./scripts/parse-maintainers.pl --output MAINTAINERS
$ git diff --stat MAINTAINERS
 MAINTAINERS | 4014 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 2007 insertions(+), 2007 deletions(-)

vs

$ git checkout 7683e9e52 -- scripts/parse-maintainers.pl
$ perl ./scripts/parse-maintainers.pl < MAINTAINERS > MAINTAINERS.new
$ mv MAINTAINERS.new MAINTAINERS
$ git diff --stat MAINTAINERS
 MAINTAINERS | 574 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 287 insertions(+), 287 deletions(-)

