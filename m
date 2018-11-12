Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16264C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ED22245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ED22245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeKMFB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:01:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52955 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:01:29 -0500
Received: from node-1w7jr9qsvbxfi9ota9omrl6fe.ipv6.telus.net ([2001:569:7bc5:1000:8103:8419:bf24:e6ca])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gMHXx-00054w-5r; Mon, 12 Nov 2018 20:06:53 +0100
Date:   Mon, 12 Nov 2018 11:06:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
cc:     linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv18 01/35] Documentation: v4l: document request API
In-Reply-To: <20180814142047.93856-2-hverkuil@xs4all.nl>
Message-ID: <alpine.DEB.2.21.1811121048400.14703@nanos.tec.linutronix.de>
References: <20180814142047.93856-1-hverkuil@xs4all.nl> <20180814142047.93856-2-hverkuil@xs4all.nl>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

On Tue, 14 Aug 2018, Hans Verkuil wrote:
> From: Alexandre Courbot <acourbot@chromium.org>
> 
> Document the request API for V4L2 devices, and amend the documentation
> of system calls influenced by it.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> @@ -0,0 +1,65 @@
> +.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections

It's nice that you try to use SPDX identifiers, but this is absolutely not
how it works.

We went great length to document how SPDX identifiers are to be used and
checkpatch emits a warning on this patch as well.

   WARNING: 'SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections' is not supported in LICENSES/...

It's well documented that the license text including metadata needs to be
available in LICENSES.

What you are doing here is just counterproductive. The SPDX work is done to
help automated license compliance. But the SPDX id above is broken and will
let tools fail.

Even if we add the GFDL1.1 to LICENSES, it's still broken because there is
no such exception 'no-invariant-section' and no, we are not going to create
it just in the kernel without having sorted that with the SPDX folks first.

Mauro, you wrote yourself in a reply to this patch:

  > Mental note: we'll need to push the no-invariant-sections upstream
  > before merging this there.

and then you went and applied it nevertheless without talking to anyone who
is involved with that SPDX effort of cleaning up the kernels licensing mess.

I'm grumpy about that particularly because you are the first person who
complains about legal implications which might affect you.

But then you go and just ignore process and legal implications and push the
crap into mainline.

Please get this sorted ASAP.

Thanks,

	tglx
