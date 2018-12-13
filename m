Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D510CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307020873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8307020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLMCvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:51:23 -0500
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:40056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbeLMCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:51:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DF88018014B01;
        Thu, 13 Dec 2018 02:51:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dock83_45efa883e5c09
X-Filterd-Recvd-Size: 1539
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Dec 2018 02:51:20 +0000 (UTC)
Message-ID: <642dd9ea144c03041ad74b14777553fe652acd1a.camel@perches.com>
Subject: Re: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary
 mode
From:   Joe Perches <joe@perches.com>
To:     Jeremy Cline <jcline@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Date:   Wed, 12 Dec 2018 18:51:19 -0800
In-Reply-To: <20181212181410.GC2352@laptop.jcline.org>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
         <20181212181410.GC2352@laptop.jcline.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-12 at 13:14 -0500, Jeremy Cline wrote:
> It might be worth noting this fixes commit 6f4d29df66ac
> ("scripts/spdxcheck.py: make python3 compliant")

umm, how does it do that?

> and also Cc this for
> stable since 6f4d29df66ac got backported to v4.19. While that commit
> did indeed make the script work with Python 3 for piping data, it broke
> Python 2 and made its way to stable.

I think attempting to use spdxcheck on binary files
is not useful in the first place.


