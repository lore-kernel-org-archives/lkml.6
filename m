Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83843C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3202082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3202082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJXSwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:52:20 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:49590 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbeJXSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:52:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7C6CD182CF669;
        Wed, 24 Oct 2018 10:24:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thumb16_63de3491b5326
X-Filterd-Recvd-Size: 2533
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Oct 2018 10:24:46 +0000 (UTC)
Message-ID: <f9b3b4377768249febf62bb5d5c5f5b6197f627f.camel@perches.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Date:   Wed, 24 Oct 2018 03:24:44 -0700
In-Reply-To: <20181024101340.GR10650@smile.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
         <1539969334-24577-1-git-send-email-dan@emutex.com>
         <1539969334-24577-3-git-send-email-dan@emutex.com>
         <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
         <16591e6735e32baad10f083c688119ce79d12911.camel@perches.com>
         <20181024101340.GR10650@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 13:13 +0300, Andy Shevchenko wrote:
> On Tue, Oct 23, 2018 at 12:23:13PM -0700, Joe Perches wrote:
> > Until such a time when either a local preferred style
> > document or a treewide preferred style exists, please
> > stop asking people to modify #include ordering for
> > various styles like reverse christmas tree by length,
> > alphabetic ordering, or other individual styles.
> 
> Why? It makes a sense to ask for new code (and even for patches against old one in some cases).

It's just a nit and frequently impossible to require as
ordering dependencies between include files do exist.

> > My preferred style would always have kernel.h first
> > as that may help with precompiled headers and overall
> > kernel compilation time one day.
> 
> How ordering would screw this up?

gcc has many limits on the use of precompiled headers.

https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

Precompiled headers are often shared by multiple
compilation units and precompilation can be stopped
after a specific header.


