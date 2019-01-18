Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D220823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfARMlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:41:45 -0500
Received: from ozlabs.org ([203.11.71.1]:57757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfARMlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:41:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43h0ts4jXcz9sDX;
        Fri, 18 Jan 2019 23:41:41 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Boyd <sboyd@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
In-Reply-To: <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com>
References: <20190116083440.11b6839c@canb.auug.org.au> <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com> <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com> <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com>
Date:   Fri, 18 Jan 2019 23:41:41 +1100
Message-ID: <878szi3zp6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Fabio Estevam (2019-01-16 17:25:21)
>> On Wed, Jan 16, 2019 at 10:44 PM Stephen Boyd <sboyd@kernel.org> wrote:
>> 
>> > Ok sure. Does this matter to scripts? Is it documented in
>> > Documentation/process/submitting-patches.rst? I've seen both types, one
>> 
>> From Documentation/process/submitting-patches.rst"
>> 
>> "If your patch fixes a bug in a specific commit, e.g. you found an issue using
>> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>> the SHA-1 ID, and the one line summary.  For example::
>> 
>> Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")"
>
> Yes but 'one line summary' is not clear to me. Does it mean the summary
> line? Or the one line summary on one line regardless of commit message
> column wrapping? Sorry to be pedantic but I can see how this can be
> misunderstood.

Yeah "one line summary" is referring to the subject of the commit.

So it doesn't explicitly say not to split it across lines, it probably
should.

eg: ?

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 30dc00a364e8..12a283ba3929 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -186,6 +186,8 @@ If your patch fixes a bug in a specific commit, e.g. you found an issue using
 
 	Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
 
+To ease parsing of the 'Fixes:' tag please don't split it across multiple lines.
+
 The following ``git config`` settings can be used to add a pretty format for
 outputting the above style in the ``git log`` or ``git show`` commands::
 


cheers
