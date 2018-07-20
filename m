Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1B7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024C6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024C6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbeGTQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:22:50 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:41011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728362AbeGTQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:22:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 14F1A100E86C8;
        Fri, 20 Jul 2018 15:34:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mint10_7a083c6b89134
X-Filterd-Recvd-Size: 1705
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Jul 2018 15:33:58 +0000 (UTC)
Message-ID: <4977e9adba5e826d5e7e9f503e3ce8fbaa872af5.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: kbuild: if_changed: check for multiple
 calls in targets
From:   Joe Perches <joe@perches.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Andy Whitcroft <apw@canonical.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Jul 2018 08:33:56 -0700
In-Reply-To: <20180720152150.GB16221@gate.crashing.org>
References: <ghy3eafbrf.fsf@lena.gouders.net>
         <20180720074804.4160-1-dirk@gouders.net>
         <01cfa83d2e29667d311d679c904b1648cd35c614.camel@perches.com>
         <20180720152150.GB16221@gate.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 10:21 -0500, Segher Boessenkool wrote:
> On Fri, Jul 20, 2018 at 03:06:37AM -0700, Joe Perches wrote:
> > On Fri, 2018-07-20 at 09:48 +0200, Dirk Gouders wrote:
> > > +		# Check for multiple calls of if_changed within a target in Makefiles
> > > +		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
> > 
> > The uses of .* here are superfluous.
> 
> And it looks like you wanted to match this only at the beginning of the
> string, which would be /^Makefile/ etc.

Nope.

$realfile includes path and /^Makefile/ matches only the
top level Makefile and none of the ones in subdirectories.


