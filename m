Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83809C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4549921907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBHABd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:01:33 -0500
Received: from ms.lwn.net ([45.79.88.28]:50604 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBHABd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:01:33 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9CF722AE;
        Fri,  8 Feb 2019 00:01:32 +0000 (UTC)
Date:   Thu, 7 Feb 2019 17:01:31 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Start conversion of PowerPC docs
Message-ID: <20190207170131.1fd2bb03@lwn.net>
In-Reply-To: <20190207060316.3221-1-tobin@kernel.org>
References: <20190207060316.3221-1-tobin@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 17:03:15 +1100
"Tobin C. Harding" <tobin@kernel.org> wrote:

> As discussed at LCA here is the start to the docs conversion for PowerPC
> to RST.
> 
> This applies cleanly on top of the mainline (5.20-rc5) and Jon's tree
> (docs-next branch).
> 
> I'm guessing it should go in through the PowerPC tree because I doubt
> you want to review this Jon, it's one big single patch (all blame for
> that falls on mpe ;)

Well, I went and took a look anyway, being a glutton for punishment.  So
naturally I do have some comments...

- I don't think this should be a top-level directory full of docs; the top
  level is already rather overpopulated.  At worst, we should create an
  arch/ directory for architecture-specific docs.  I kind of think that
  this should be thought through a bit more, though, with an eye toward
  who the audience is.  Some of it is clearly developer documentation, and
  some of it is aimed at admins; ptrace.rst is user-space API stuff.
  Nobody ever welcomes me saying this, but we should really split things
  into the appropriate manuals according to audience.

- It would be good to know how much of this stuff is still relevant.
  bootwrapper.txt hasn't been modified since it was added in 2008.
  cpu_features.txt predates the git era, as does mpc52xx.txt; hvcs.txt is
  nearly as old. And so on.  Can we perhaps stop dragging some of those
  docs around?

- The use of flat-table in isa-versions.rst totally wrecks the readability
  of those tables in the plain-text version.  Said tables are pretty close
  to being RST in their original form; it would be far better to just fix
  anything needing fixing but to keep that form.

- I'm glad you're adding SPDX lines, but do you know that the license is
  correct in each case?  It's best to be careful with such things.

Thanks,

jon
