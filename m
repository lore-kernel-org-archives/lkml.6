Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9ADC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3EB2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3EB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeKHJFe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:05:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeKHJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 04:05:34 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1475BA48;
        Wed,  7 Nov 2018 23:32:52 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:32:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joe Perches <joe@perches.com>, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/spdxcheck: make python3 compliant
Message-Id: <20181107153251.bac94150f8ebc8dbf53abe23@linux-foundation.org>
In-Reply-To: <20181023070802.22558-1-u.kleine-koenig@pengutronix.de>
References: <20181023070802.22558-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 09:08:02 +0200 Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Without this change the following happens when using Python3 (3.6.6):
> 
> 	$ echo "GPL-2.0" | python3 scripts/spdxcheck.py -
> 	FAIL: 'str' object has no attribute 'decode'
> 	Traceback (most recent call last):
> 	  File "scripts/spdxcheck.py", line 253, in <module>
> 	    parser.parse_lines(sys.stdin, args.maxlines, '-')
> 	  File "scripts/spdxcheck.py", line 171, in parse_lines
> 	    line = line.decode(locale.getpreferredencoding(False), errors='ignore')
> 	AttributeError: 'str' object has no attribute 'decode'
> 
> So as the line is already a string, there is no need to decode it and
> the line can be dropped.

I suppose people might want to run spdxcheck.py against (say) 4.19.x
using python3.  So I'll add a cc:stable here, OK?

