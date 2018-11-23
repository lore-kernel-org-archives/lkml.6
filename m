Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5B20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KNZfEbA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B5B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502683AbeKWUfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:35:40 -0500
Received: from casper.infradead.org ([85.118.1.10]:52568 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbeKWUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bz8HKIsmSGGY2wghk0GuvhMw6DAhLvyMCRlRjEzkj4k=; b=KNZfEbA0ymPTlEqfHkZa5UiU8D
        omn82WQkzZacrDUsrniZxRMMPdbytwqefjK0vbYbrK/K02fo7SbpxlWcdpfk4FTvjkclNDZKO4bco
        zq+Xyp5M/KX8OXL80KJPkH1+kZNfYLqEvZ010KCsZoeKIpaIeYu2slAY0FZHXStUjR0k/dgkDVPsn
        cjIL6JkEvtvu8eEYtY6TSbPP/0uoceK6eNsMVh0Uw/KG+DmxONw2gRCyy/SmJTOQtl6OZ70gLaoMy
        rGi0X1NDa55A5xl9KbLtjQwlDbQ7HHmAzaCU7WSf0V23ihQgnSWFeoEa24NakopxcnyUDcQMNuOqQ
        /r2MlUyQ==;
Received: from 201.47.163.210.dynamic.adsl.gvt.net.br ([201.47.163.210] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQ884-0008Nw-8U; Fri, 23 Nov 2018 09:52:04 +0000
Date:   Fri, 23 Nov 2018 07:51:57 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCHv18 01/35] Documentation: v4l: document request API
Message-ID: <20181123075157.077758c0@coco.lan>
In-Reply-To: <20181118115215.5ebc681c@coco.lan>
References: <20180814142047.93856-1-hverkuil@xs4all.nl>
        <20180814142047.93856-2-hverkuil@xs4all.nl>
        <alpine.DEB.2.21.1811121048400.14703@nanos.tec.linutronix.de>
        <20181118115215.5ebc681c@coco.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Ping. Would the patch below work for you?

Regards,
Mauro

Em Sun, 18 Nov 2018 11:52:15 -0200
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Hi Thomas,
> 
> Em Mon, 12 Nov 2018 11:06:43 -0800 (PST)
> Thomas Gleixner <tglx@linutronix.de> escreveu:
> 
> > Folks,
> > 
> > On Tue, 14 Aug 2018, Hans Verkuil wrote:  
> > > From: Alexandre Courbot <acourbot@chromium.org>
> > > 
> > > Document the request API for V4L2 devices, and amend the documentation
> > > of system calls influenced by it.
> > > 
> > > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > > Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> > > Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>    
> >   
> > > @@ -0,0 +1,65 @@
> > > +.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections    
> > 
> > It's nice that you try to use SPDX identifiers, but this is absolutely not
> > how it works.
> > 
> > We went great length to document how SPDX identifiers are to be used and
> > checkpatch emits a warning on this patch as well.
> > 
> >    WARNING: 'SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections' is not supported in LICENSES/...
> > 
> > It's well documented that the license text including metadata needs to be
> > available in LICENSES.
> > 
> > What you are doing here is just counterproductive. The SPDX work is done to
> > help automated license compliance. But the SPDX id above is broken and will
> > let tools fail.
> > 
> > Even if we add the GFDL1.1 to LICENSES, it's still broken because there is
> > no such exception 'no-invariant-section' and no, we are not going to create
> > it just in the kernel without having sorted that with the SPDX folks first.  
> 
> I know, and, after talking with Kate about that, I actually opened a SPDX
> issue in Aug, 30:
> 
> 	https://github.com/spdx/license-list-XML/issues/686
> 
> Btw, this is just the tip of the iceberg: I have another patchset pending
> adding the GFDL license to LICENSES and doing some changes that are
> required for Debian to be able to package the Kernel documentation:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=doc_license
> 
> It starts with Ben's patch:
> 	"Documentation/media: uapi: Explicitly say there are no Invariant Sections"
> 
> And tag media docs with SPDX headers.
> 
> > Mauro, you wrote yourself in a reply to this patch:
> >   
> >   > Mental note: we'll need to push the no-invariant-sections upstream
> >   > before merging this there.    
> > 
> > and then you went and applied it nevertheless without talking to anyone who
> > is involved with that SPDX effort of cleaning up the kernels licensing mess.  
> 
> Sorry, I ended by sleeping on this. This specific patch was on a separate
> topic branch. I completely forgot that this was waiting for SPDX committee
> feedback about how to use GFDL.
> 
> > I'm grumpy about that particularly because you are the first person who
> > complains about legal implications which might affect you.
> > 
> > But then you go and just ignore process and legal implications and push the
> > crap into mainline.
> > 
> > Please get this sorted ASAP.  
> 
> It would be great to have an ETA from SPDX about how long they'll
> take to solve this issue. It has been about 2,5 months without
> any concrete way about how we should address it.
> 
> I really don't want to add new documents at the media uAPI stuff
> (with is GFDL due to historical reasons) without make them also
> GPL. On the other hand, freezing API submissions to the media
> subsystem just due to the lack of proper SPDX support for GFDL
> seems plain wrong.
> 
> Perhaps one workaround would be to explicitly not using the
> SPDX-License-Identifier, adding a longer licensing text that could
> later be replaced by a SPDX license (if they ever figure out how
> GFDL without invariants sections should be used). Something like:
> 
> 
> 	.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> 	..
> 	.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> 	..
> 	.. For GFDL-1.1-or-later, see:
> 	..
> 	.. Permission is granted to copy, distribute and/or modify this document
> 	.. under the terms of the GNU Free Documentation License, Version 1.1 or
> 	.. any later version published by the Free Software Foundation, with no
> 	.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> 	.. A copy of the license is included at
> 	.. Documentation/media/uapi/fdl-appendix.rst.
> 
> Will that work for you?
> 
> If so, the patch solving the current issue is enclosed.
> 
> I'll rebase my other SPDX patchset to use the same solution after
> we have an agreement on this.
> 
> Thanks,
> Mauro
> 
> media: mediactl docs: don't use SPDX for GFDL
> 
> There is an open issue for using GFDL without invariant sections:
> 
> 	https://github.com/spdx/license-list-XML/issues/686
> 
> So far, no progress.
> 
> While we don't have it, we can't really use SPDX identifiers on media.
> So, replace them by a license text.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> diff --git a/Documentation/media/uapi/mediactl/media-ioc-request-alloc.rst b/Documentation/media/uapi/mediactl/media-ioc-request-alloc.rst
> index 0f8b31874002..60874a1f3d89 100644
> --- a/Documentation/media/uapi/mediactl/media-ioc-request-alloc.rst
> +++ b/Documentation/media/uapi/mediactl/media-ioc-request-alloc.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _media_ioc_request_alloc:
>  
> diff --git a/Documentation/media/uapi/mediactl/media-request-ioc-queue.rst b/Documentation/media/uapi/mediactl/media-request-ioc-queue.rst
> index 6dd2d7fea714..3f481256f75a 100644
> --- a/Documentation/media/uapi/mediactl/media-request-ioc-queue.rst
> +++ b/Documentation/media/uapi/mediactl/media-request-ioc-queue.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _media_request_ioc_queue:
>  
> diff --git a/Documentation/media/uapi/mediactl/media-request-ioc-reinit.rst b/Documentation/media/uapi/mediactl/media-request-ioc-reinit.rst
> index febe888494c8..d9c4d308b477 100644
> --- a/Documentation/media/uapi/mediactl/media-request-ioc-reinit.rst
> +++ b/Documentation/media/uapi/mediactl/media-request-ioc-reinit.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _media_request_ioc_reinit:
>  
> diff --git a/Documentation/media/uapi/mediactl/request-api.rst b/Documentation/media/uapi/mediactl/request-api.rst
> index 5f4a23029c48..7a85b346db91 100644
> --- a/Documentation/media/uapi/mediactl/request-api.rst
> +++ b/Documentation/media/uapi/mediactl/request-api.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _media-request-api:
>  
> diff --git a/Documentation/media/uapi/mediactl/request-func-close.rst b/Documentation/media/uapi/mediactl/request-func-close.rst
> index 098d7f2b9548..c85275a8870c 100644
> --- a/Documentation/media/uapi/mediactl/request-func-close.rst
> +++ b/Documentation/media/uapi/mediactl/request-func-close.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _request-func-close:
>  
> diff --git a/Documentation/media/uapi/mediactl/request-func-ioctl.rst b/Documentation/media/uapi/mediactl/request-func-ioctl.rst
> index ff7b072a6999..8b69465bd2dd 100644
> --- a/Documentation/media/uapi/mediactl/request-func-ioctl.rst
> +++ b/Documentation/media/uapi/mediactl/request-func-ioctl.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _request-func-ioctl:
>  
> diff --git a/Documentation/media/uapi/mediactl/request-func-poll.rst b/Documentation/media/uapi/mediactl/request-func-poll.rst
> index 85191254f381..8f58f9948cb6 100644
> --- a/Documentation/media/uapi/mediactl/request-func-poll.rst
> +++ b/Documentation/media/uapi/mediactl/request-func-poll.rst
> @@ -1,4 +1,15 @@
> -.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
> +.. SPDX License for this file: GPL-2.0 OR GFDL-1.1-or-later
> +..
> +.. For GPL-2.0, see LICENSES/preferred/GPL-2.0
> +..
> +.. For GFDL-1.1-or-later, see:
> +..
> +.. Permission is granted to copy, distribute and/or modify this document
> +.. under the terms of the GNU Free Documentation License, Version 1.1 or
> +.. any later version published by the Free Software Foundation, with no
> +.. Invariant Sections, no Front-Cover Texts and no Back-Cover Texts.
> +.. A copy of the license is included at
> +.. Documentation/media/uapi/fdl-appendix.rst.
>  
>  .. _request-func-poll:
>  
> 



Thanks,
Mauro
