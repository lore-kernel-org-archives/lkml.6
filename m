Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E058DC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0CD2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfASTGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:06:24 -0500
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:46276 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728911AbfASTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:06:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 301B9182CED34;
        Sat, 19 Jan 2019 19:06:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: idea25_71b6f5d7f982c
X-Filterd-Recvd-Size: 1643
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Jan 2019 19:06:21 +0000 (UTC)
Message-ID: <a5eab6ca68ee1eb837c8c86b69b4696846af719b.camel@perches.com>
Subject: Re: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Jan 2019 11:06:20 -0800
In-Reply-To: <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
References: <20190118225658.GA28312@ziepe.ca>
         <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-01-19 at 19:30 +0100, Miguel Ojeda wrote:
> Hi Jason,
> 
> On Fri, Jan 18, 2019 at 11:57 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > Re-run the shell fragment that generated the original list. In particular
> > this adds the missing xarray related functions.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Thank for the patch! Picking it up.

This misses all the directory/file specific #defines
outside of include/ with for_each

$ git grep "#define.*for_each" | grep -v '^include' | wc -l
619

Is it possible to make this generic somehow instead?
Perhaps extend .clang_format with regexes?

(?:[a-z0-9_]+_)?for_each(?:_[a-z_]+)
[a-z0-9_]+_for_each

