Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A031C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4528C208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4528C208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeGJQWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:22:18 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:50763 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933359AbeGJQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:22:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1154D181D341A;
        Tue, 10 Jul 2018 16:22:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hand58_6b0ab221c8e06
X-Filterd-Recvd-Size: 1504
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Jul 2018 16:22:15 +0000 (UTC)
Message-ID: <73d8d34313d62344e5538c17d4863e8db3a138ef.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 09:22:14 -0700
In-Reply-To: <CAMuHMdV29UV6qrN8RhSJqh+yYevsOD0UERvYqHBhh8rRn8CXsA@mail.gmail.com>
References: <20180710121014.31119-1-geert+renesas@glider.be>
         <e4e25250dbea658f25dcf10504f3147731b5d2e9.camel@perches.com>
         <CAMuHMdV34P+2=-Myfzdv1-+4m2_cTHQcQO80fZ5Ai+G9J6X0kA@mail.gmail.com>
         <9c95ae2b06524a6638f26d61d7efe4afc86f877b.camel@perches.com>
         <CAMuHMdV29UV6qrN8RhSJqh+yYevsOD0UERvYqHBhh8rRn8CXsA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 17:50 +0200, Geert Uytterhoeven wrote:
> So I can use MIME::QuotedPrint?

How about 

use Encode;
[]
	if (decode("MIME-Header", $line) =~ /^from:\s*(.*)/i) {
etc...

