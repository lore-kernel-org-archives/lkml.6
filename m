Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D133C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598824AAA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D598824AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934584AbeFWB7K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:59:10 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:58608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933977AbeFWB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:59:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0EEA9180289B9;
        Sat, 23 Jun 2018 01:59:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shock08_157f2b7975656
X-Filterd-Recvd-Size: 1696
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Jun 2018 01:59:07 +0000 (UTC)
Message-ID: <07e414cea905277f1909d92dab47d3461ea91991.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if
 condition
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <michael.straube@posteo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 18:59:06 -0700
In-Reply-To: <2c2a0f79-7970-8c55-6119-189114b279e3@posteo.de>
References: <20180621182230.27823-1-michael.straube@posteo.de>
         <20180622104007.ob5nt2rip2fu436h@mwanda>
         <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
         <20180622105719.pt3lh6fqi2nziqsz@mwanda>
         <28dd699b-3013-c42c-07d5-1117d7ab3622@posteo.de>
         <36a7227189b8c7602dd9ffd21a5369b7029e61f1.camel@perches.com>
         <2c2a0f79-7970-8c55-6119-189114b279e3@posteo.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 21:11 +0200, Michael Straube wrote:
> On 06/22/18 19:28, Joe Perches wrote:
> > Although the last memcpy of a fixed mac address could
> > probably use eth_random_addr to reduce the likelihood
> > of mac address collision so maybe
> > 		eth_random_addr(mac_addr);
> Using a random address would be preffered?

mac address duplication is bad, so if there
were 2 instances of this device on the same
ethernet network, yes.

> 
> Thanks for your help and patience.
> Michael
