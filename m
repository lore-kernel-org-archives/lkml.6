Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259C121479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WDNh+E88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259C121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeK3C5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:57:34 -0500
Received: from alln-iport-2.cisco.com ([173.37.142.89]:22104 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeK3C5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4356; q=dns/txt; s=iport;
  t=1543506706; x=1544716306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vAMrVSwzcUrmPJs9DuYxs7QfzGe7ZFRZWgDYHy9K1dg=;
  b=WDNh+E884CAR0Q6sgEuk2gts/vA4gBf8wjSsZZq/eE1H6QKRNhLUvcx2
   iEEfDwbrPGQ2yRuryqJ1bd6n+oIEFdUeDSVfSktZnieSCyCSwvLDxxZzE
   2YZeWOgy6UaSs84f9jp0nFSu/vOOeNdsSSmHhOOP404Z6Tq9+tfuT16no
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AFAABcCgBc/5FdJa1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggOBNTMnjBGMCIINjgiJPBSBZgsBAYR?=
 =?us-ascii?q?sAoMyIjQJDQEDAQECAQECbSiFPQEFOj8QCw4EBgklDy0NDgYThSOnYooqFA6?=
 =?us-ascii?q?LdBeBQD+BEYMShEYnhW8CkB6QBQmCIY8GIwqREpgnAgQGBQIUgUY4gVUzGgg?=
 =?us-ascii?q?bFYMngicXjj4eAzCLdAElBIIjAQE?=
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="206155271"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 15:51:45 +0000
Received: from zorba ([10.24.38.189])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id wATFpgRu029154
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Nov 2018 15:51:44 GMT
Date:   Thu, 29 Nov 2018 07:51:42 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Walker <dwalker@fifo99.com>, xe-linux-external@cisco.com,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] add generic builtin command line
Message-ID: <20181129155142.deu7oatpxfxizrw6@zorba>
References: <20181109173433.1271-1-danielwa@cisco.com>
 <20181128211212.060295fb9055e403d0060e7a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128211212.060295fb9055e403d0060e7a@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.38.189, [10.24.38.189]
X-Outbound-Node: rcdn-core-9.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 09:12:12PM -0800, Andrew Morton wrote:
> On Fri,  9 Nov 2018 09:34:31 -0800 Daniel Walker <danielwa@cisco.com> wrote:
> 
> > This code allows architectures to use a generic builtin command line.
> > The state of the builtin command line options across architecture is
> > diverse. On x86 and mips they have pretty much the same code and the
> > code prepends the builtin command line onto the boot loader provided
> > one. On powerpc there is only a builtin override and nothing else.
> > 
> > The code in this commit unifies the mips and x86 code into a generic
> > header file under the CONFIG_GENERIC_CMDLINE option. When this
> > option is enabled the architecture can call the cmdline_add_builtin()
> > to add the builtin command line.
> 
> I'm not sure what's happened to this and I haven't seen the other two
> patches but...

It's been sitting in -next since the last merge window. 

> 
> > [maksym.kokhan@globallogic.com: fix cmdline_add_builtin() macro]
> > Cc: Daniel Walker <dwalker@fifo99.com>
> > Cc: Daniel Walker <danielwa@cisco.com>
> > Cc: xe-linux-external@cisco.com
> > Signed-off-by: Daniel Walker <danielwa@cisco.com>
> > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> 
> Two SOB's is nice, but some reviews and acks would be nicer.
 
Would love to add some, but no one is reviewing it.. 

> > --- /dev/null
> > +++ b/include/linux/cmdline.h
> > @@ -0,0 +1,79 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_CMDLINE_H
> > +#define _LINUX_CMDLINE_H
> > +
> > +/*
> > + *
> > + * Copyright (C) 2015. Cisco Systems, Inc.
> > + *
> > + * Generic Append/Prepend cmdline support.
> > + */
> > +
> > +#if defined(CONFIG_GENERIC_CMDLINE) && defined(CONFIG_CMDLINE_BOOL)
> > +
> > +#ifndef CONFIG_CMDLINE_OVERRIDE
> > +/*
> > + * This function will append or prepend a builtin command line to the command
> > + * line provided by the bootloader. Kconfig options can be used to alter
> > + * the behavior of this builtin command line.
> > + * @dest: The destination of the final appended/prepended string
> > + * @src: The starting string or NULL if there isn't one.
> > + * @tmp: temporary space used for prepending
> > + * @length: the maximum length of the strings above.
> > + */
> > +static inline void
> > +_cmdline_add_builtin(char *dest, char *src, char *tmp, unsigned long length)
> > +{
> > +	if (src != dest && src != NULL) {
> > +		strlcpy(dest, " ", length);
> > +		strlcat(dest, src, length);
> > +	}
> > +
> > +	strlcat(dest, " ", length);
> > +
> > +	if (sizeof(CONFIG_CMDLINE_APPEND) > 1)
> > +		strlcat(dest, CONFIG_CMDLINE_APPEND, length);
> > +
> > +	/*
> > +	 * You need to convert you old style CONFIG_CMDLINE to use
> 
> "your"
> 
> > +	 * the prepend, or append defines. Some architectures use one
> 
> "one and"
> 
> > +	 * some use the other. You need to figure out which ones is
> 
> "one"

Can fix these..


> 
> > +	 * right for your situation. I would recommend prepending
> > +	 * because it's the safest (i.e. CONFIG_CMDLINE_PREPEND).
> > +	 */
> > +	BUILD_BUG_ON(sizeof(CONFIG_CMDLINE) != 1);
> > +
> > +	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {
> > +		strlcpy(tmp, CONFIG_CMDLINE_PREPEND, length);
> > +		strlcat(tmp, " ", length);
> > +		strlcat(tmp, dest, length);
> > +		strlcpy(dest, tmp, length);
> > +	}
> > +}
> 
> And... holy cow.  Does this monster really need to be inlined?
> 
> > +#define cmdline_add_builtin(dest, src, length)				    \
> > +{									    \
> > +	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {			    \
> > +		static char cmdline_tmp_space[length] __initdata;	    \
> > +		_cmdline_add_builtin(dest, src, cmdline_tmp_space, length); \
> > +	} else {							    \
> > +		_cmdline_add_builtin(dest, src, NULL, length);		    \
> > +	}								    \
> > +}
> 
> And this will generate __initdata storage at each invocation site.  Can
> it be redone in real, non-inlined C?


It's intended to be used once, maybe twice, per architecture. Powerpc uses it
twice I think. There's no reason for it to be used more than twice, and it replaces
code which is similar to the code above. I can' imagine a situation where people
go nuts and start calling this everywhere.

So it seemed easier to just inline it.

Daniel
