Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4949A20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4949A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeIDCu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:50:26 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:54191 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbeIDCuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:50:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 90E5A182CED2A;
        Mon,  3 Sep 2018 22:28:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: box39_64a0f61463c18
X-Filterd-Recvd-Size: 1803
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Sep 2018 22:28:11 +0000 (UTC)
Message-ID: <6cfb25aff666e58a376303ce02de8caa481a6599.camel@perches.com>
Subject: Re: [PATCH 1/1] docs: kernel-doc: fix parsing of function pointers
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Sep 2018 15:28:10 -0700
In-Reply-To: <20180903153804.2b091448@lwn.net>
References: <20180903184153.9368-1-xypron.glpk@gmx.de>
         <20180903130043.059b2e82@lwn.net>
         <b0bff870-c3c1-20e8-6609-f93f59da8624@gmx.de>
         <20180903153804.2b091448@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-03 at 15:38 -0600, Jonathan Corbet wrote:
> On Mon, 3 Sep 2018 22:29:00 +0200
> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> 
> > > >  	    # pointer-to-function
> > > >  	    $arg =~ tr/#/,/;
> > > > -	    $arg =~ m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;  
> > 
> > m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;
> >            ^
> > Here we allow for 0..1 asterixes.
> > 
> > If there is no asterix it is not a function pointer. Why should we care
> > for this case?
> 
> GCC seems to allow that asterisk (asterix is an indomitable Gaul :) to be
> missing; not sure if that's officially allowed by the language or not.  I
> also don't know if any code in the kernel elides it,

Many typedefs for function pointers do not use the *
Dunno if there are many others, I didn't look hard.

$ git grep -P '\w+\s*\*?\s*\(\s*\w+\w*\)\s*\(\w+' | \
  grep -w typedef


