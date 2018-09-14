Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F59DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1410820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1410820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeINQ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:56:07 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:45252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbeINQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:56:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 425CC180A8147;
        Fri, 14 Sep 2018 11:42:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tub67_2cec44f70ab1c
X-Filterd-Recvd-Size: 2575
Received: from XPS-9350 (unknown [172.56.6.71])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Sep 2018 11:41:48 +0000 (UTC)
Message-ID: <a838a627dd3308908c54f8d84d7fa9c56953b954.camel@perches.com>
Subject: Re: [PATCH v2] staging: Convert to using %pOFn instead of
 device_node.name
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org
Date:   Fri, 14 Sep 2018 04:41:47 -0700
In-Reply-To: <CAL_JsqL=+O=G-0uVdKGcq4T8pSzkdGV1sd_p682-6SFXuNt2mA@mail.gmail.com>
References: <20180828154433.5693-1-robh@kernel.org>
         <20180828154433.5693-7-robh@kernel.org> <20180912121705.010a999d@coco.lan>
         <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
         <c7a3263ac94a6c31bd58c06683d55015be2e8be4.camel@perches.com>
         <CAL_JsqL=+O=G-0uVdKGcq4T8pSzkdGV1sd_p682-6SFXuNt2mA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-13 at 16:26 -0500, Rob Herring wrote:
> On Thu, Sep 13, 2018 at 3:45 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Wed, 2018-09-12 at 15:26 -0500, Rob Herring wrote:
> > > A problem with MAINTAINERS is there is no way to tell who applies
> > > patches for a given path vs. anyone else listed.
> > 
> > try the --scm option
> 
> That kind of helps if the maintainer has listed a tree, but gives
> wrong results if not.

If there isn't a tree listed, it's not really maintained.

> And you still have to figure out who owns which
> tree. That's not hard, but it's not scriptable.

a get_maintainer scripted loop using
  --maxdepth=<incrementing_from_1> --scm --m --nor --nol
until a result could work.

> IMO, we should reserve 'M:' for maintainers with trees and use 'R:'
> driver maintainers. That's redefining M as "maintainer" rather than
> "mail patches to". You could still have both for a entry so you can
> know who to go bug when your patch hasn't been applied.

IMO, most M: entries in MAINTAINERS are either reviewers or
used-once when created and longer active or just vanity.
