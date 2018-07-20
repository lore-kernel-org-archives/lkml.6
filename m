Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9689BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302F2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302F2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbeGTQ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:27:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:50131 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731314AbeGTQ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:27:12 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6KFMDo5027535;
        Fri, 20 Jul 2018 10:22:20 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w6KFLta2027442;
        Fri, 20 Jul 2018 10:21:55 -0500
Date:   Fri, 20 Jul 2018 10:21:50 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Andy Whitcroft <apw@canonical.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: kbuild: if_changed: check for multiple calls in targets
Message-ID: <20180720152150.GB16221@gate.crashing.org>
References: <ghy3eafbrf.fsf@lena.gouders.net> <20180720074804.4160-1-dirk@gouders.net> <01cfa83d2e29667d311d679c904b1648cd35c614.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cfa83d2e29667d311d679c904b1648cd35c614.camel@perches.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:06:37AM -0700, Joe Perches wrote:
> On Fri, 2018-07-20 at 09:48 +0200, Dirk Gouders wrote:
> > +		# Check for multiple calls of if_changed within a target in Makefiles
> > +		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
> 
> The uses of .* here are superfluous.

And it looks like you wanted to match this only at the beginning of the
string, which would be /^Makefile/ etc.


Segher
