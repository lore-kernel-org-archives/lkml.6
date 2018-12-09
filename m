Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36987C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6772081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6772081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLIRaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:30:06 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:35997 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbeLIRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:30:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4633E837F243;
        Sun,  9 Dec 2018 17:30:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: peace32_57e9dffde8d3f
X-Filterd-Recvd-Size: 1340
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Dec 2018 17:30:03 +0000 (UTC)
Message-ID: <f461cdac6f3fd4502f9c061dcacd07cfee6503d9.camel@perches.com>
Subject: Re: [PATCH] staging: erofs: Add braces to do-while statements
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Jespersen <laumann.thomas@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Dec 2018 09:30:02 -0800
In-Reply-To: <20181209162007.GA22432@kroah.com>
References: <20181209155900.10164-1-laumann.thomas@gmail.com>
         <20181209162007.GA22432@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(mrph.  premature send)

On Sun, 2018-12-09 at 17:20 +0100, Greg KH wrote:
> On Sun, Dec 09, 2018 at 04:59:00PM +0100, Thomas Jespersen wrote:
> > This fixes warning reported by sparse (with -Wsparse-all).
> 
> Why is sparse warning about this?

Probably because it's the kernel preferred style
to use single statement

	do {
		<foo>;
	} while (<bar>);

over

	do
		<foo>;
	while (<bar>);

by about a 20:1 ratio.


