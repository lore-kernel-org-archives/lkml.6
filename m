Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1481ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED5C20836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="GqWq1TUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED5C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korte.land
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJSTK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:10:56 -0400
Received: from o4.31pqt.s2shared.sendgrid.net ([167.89.55.65]:19038 "EHLO
        o4.31pqt.s2shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbeJSTK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:10:56 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 15:10:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
        h=mime-version:content-type:content-transfer-encoding:from:to:cc:
        subject:in-reply-to:references;
        s=smtpapi; bh=c1EdKy6t0O+c9jc/0yiwOZsUgE3ZS6KVLftcc+CEhgY=;
        b=GqWq1TUq/SLZ14/Gd1ClDRjoHhZKRZWkWkiVs8KNDQFLlZ5DHhZN7AyYSBS9XNKxQ1e/
        skfZScnMRnS/KVBO9OQJsHwGlxp2copQ0UZ9JugP5X18xcagqnaN+Y3VKpr/yRX/iu5JtU
        wQavkJB/zoUZbJORAD2MGomBFuemGaj8A=
Received: by filter0008p2mdw1.sendgrid.net with SMTP id filter0008p2mdw1-24857-5BC9B83E-11
        2018-10-19 10:55:58.37389743 +0000 UTC m=+57241.186838637
Received: from korte.land (unknown [146.185.150.169])
        by ismtpd0004p1lon1.sendgrid.net (SG) with ESMTP id N71mXe5HQ9i7HXzCtfsQkQ
        Fri, 19 Oct 2018 10:55:58.125 +0000 (UTC)
Received: from mail.korte.land (localhost [127.0.0.1])
        by korte.land (Postfix) with ESMTP id EE2726034E;
        Fri, 19 Oct 2018 10:55:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Oct 2018 10:55:58 +0000 (UTC)
From:   Will Korteland <will@korte.land>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/uio: fix a grammar nitpick
In-Reply-To: <20181018123126.3e59c3fd@lwn.net>
References: <7e426c03c0e342ade7ce86a977ef13b2@korte.land>
 <20181018123126.3e59c3fd@lwn.net>
Message-ID: <fa74b1f965d5a33d708f74d9fe8d7517@korte.land>
X-Sender: will@korte.land
X-SG-EID: =?us-ascii?Q?cUnx5NqAuhUbAHG4iZ9Vx1BO6oMeAW3Kqk+xSEzhkR48c1futjyLp2=2Fwp8OUBt?=
 =?us-ascii?Q?=2F5X+h1tdyY33lVKbOQVGXUFdB3RLJ=2F7GJumKslr?=
 =?us-ascii?Q?FsVA7C85uAjana18rIdmo50W+R1+Qn3Vm+Rhgvs?=
 =?us-ascii?Q?ZR46dK87lM3Mm5MMMyD9ZQlQBt+tQdZrvrDn8gm?=
 =?us-ascii?Q?+vCwZHN6qwGC5+GvbBRkHUgYmjBep8lJNOv0K8T?=
 =?us-ascii?Q?CDn=2FJlvhFp96FUqhtUwUmnaCzAO3+MoxdqfQbg?=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-18 18:31, Jonathan Corbet wrote:
> Unfortunately, this patch is badly white-space mangled.  I tried fixing
> it up but eventually had to give up and move on.
> 
> Please fix up your email client so that this doesn't happen; see
> Documentation/process/email-clients.rst for some helpful suggestions
> to that end.  Once you can email the patch to yourself and apply the
> result successfully, please resubmit it.

Thanks for taking the time to look at this. I might let it be, since it's
made it into linux-next-20181019 fine - I got an email from Greg KH to that
effect as well.

That said, I'll be a bit more careful next time round, just in case
someone's manually fixed up the whitespace without telling me. Thanks for
the pointer to the email docs, but unfortunately my client isn't covered
there. Still, I've used it as a guide for the kind of settings I need,
hopefully my patches won't get mangled from now on.

- Will
