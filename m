Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA8E20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="B9FmnNkK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkA7AS8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGZQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:49:25 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42829 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731273AbeGZQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:49:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 1C126351;
        Thu, 26 Jul 2018 11:32:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Jul 2018 11:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=QIkgflTuTUkKvsVAiJ73uA+8iDChhCvCIMGi0/0iS1c=; b=B9FmnNkK
        ojSAFkd+vmdb9r/WpT9m4ygDnvE+DGUfCojrWm0dkiiY6H/LvrFKLYoecO0a5FHq
        iwmHBCp3cPnVFjNeawo2jIaK18W9Z2mnu/zoLli4h20QsRJPozpe8QmhLE4jGA0u
        NZzPdsw1yrhFPFOCSBNAkeYD6sNSRIkbvMGMerktshLMEzMMeL4+UVU0BNAqiP8g
        KfSzwYFDExfEO8fwsw6TUpGm4ZUNQqhJLboZkyVmcK1j/Z7BRQahoWAoYVR6tago
        gepyYdm/HRVBaOQ82kCLEwP3brlV+nur/bklMvtUC+BuqkTww8Y9wAYQY4EDsBgc
        oUSLpEQgcduhng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=QIkgflTuTUkKvsVAiJ73uA+8iDChh
        CvCIMGi0/0iS1c=; b=fkA7AS8RNu0copRBt5Z6yxlO7uMPZgxiFmkUk/TW06c58
        tU8fJEXkXmt+UT5iaOlOxErJZOLXDIXlxxeE4LNSYmAqb/bNQalJZw8rW0X35EDe
        v1xk8LKrx7l+eH0kkQtLltwmHyKa9nSvgxRKYvoG5ut474LNxE0HXJCq5qsPJnT6
        yF2eYNb/KWjw37UdFYCHOSP8fmyyHgl/q6BMaKDHOWANP92AwmeufEp7Cd3kNdRf
        TOgspUljMRcn2UdNQQN5nSt/4ZanvYhv/S2EkbDtXnO9ushvnmgVVjU8r70pgnJa
        VN+Nfe2PqXrSkrhd0/4+MgBgyMRiJOlvQjcSK9T5w==
X-ME-Proxy: <xmx:culZW5doZvAqq6utZ5uqi2bMBpTaDiFyTxSFExcFkoa66A-Scaq0xg>
    <xmx:culZW4vOp32uF0KLSNqfy8k6UMb6BgZOLw-XvMdtt0NpaI0m0_SwIA>
    <xmx:culZWwKszVj-9elaJ4-GQkxv3FDPlfVlAU8tGMNjvy2trOCP9lmW1Q>
    <xmx:culZW6a7s_Kh3krpI0PwnaVS3xNb8qTGs8yteDzaA82RMmLulGdn7g>
    <xmx:culZW2KlTl_BV29vdAJHhN8axfOvBrkIGSPAMsIDMYauwx0nQkxgWg>
    <xmx:culZW4Vd6kBMgL8chfsPXxsfVRlY7d5lcfA_HUIw9MMqpgfqLNk4-Hop1qE>
X-ME-Sender: <xms:culZW4q5IpJ4fIcB8HN7Un5IH2mTuHIgqrNmEjl86UOuWvwg8KBAWQ>
Received: from localhost (unknown [62.119.166.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8EC810276;
        Thu, 26 Jul 2018 11:32:01 -0400 (EDT)
Date:   Thu, 26 Jul 2018 17:31:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180726153153.GA8327@kroah.com>
References: <20180725202238.165314-1-salyzyn@android.com>
 <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:14:08AM -0700, Mark Salyzyn wrote:
> On 07/25/2018 06:07 PM, Steven Rostedt wrote:
> > On Wed, 25 Jul 2018 13:22:36 -0700
> > Mark Salyzyn <salyzyn@android.com> wrote:
> > 
> > > From: Nick Desaulniers <ndesaulniers@google.com>
> > > 
> > > Switch from 0x%lx to 0x%pK to print the kernel addresses.
> > > 
> > > Fixes: CVE-2017-0630
> > Wait!!!! This breaks perf and trace-cmd! They require this to be able
> > to print various strings in trace events. This file is root read only,
> > as the CVE says.
> > 
> > NAK for this fix. Come up with something that doesn't break perf and
> > trace-cmd. That will not be trivial, as the format is stored in the
> > ring buffer with an address, then referenced directly. It also handles
> > trace_printk() functions that simply point to the string format itself.
> > 
> > A fix would require having a pointer be the same that is referenced
> > inside the kernel as well as in this file. Maybe make the format string
> > placed in a location that doesn't leak where the rest of the kernel
> > exists?
> > 
> > -- Steve
> Thank you Steve, much appreciated feedback, I have asked the security
> developers to keep this in mind and come up with a correct fix.
> 
> The correct fix that meets your guidelines would _not_ be suitable for
> stable due to the invasiveness it sounds, only for the latest will such a
> rework make sense. As such, the fix proposed in this patch is the only one
> that meets the bar for stable patch simplicity, and merely(!) needs to state
> that if the fix is taken, perf and trace are broken.

Why would I take something for the stable trees that does not match what
is upstream?  It feels to me that this CVE is just invalid.  Yes, root
can read the kernel address, does that mean it is a problem?  Only if
you allow unprotected users to run with root privileges :)

What exactly is the problem here in the current kernel that you are
trying to solve?

thanks,

greg k-h
