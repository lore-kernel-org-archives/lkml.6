Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE16D2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMabDYpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE16D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbeKPBw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:52:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388571AbeKPBw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1kuzehewwH6fX7xB7/QpDUccRseuTywo3Yztn3l7QZw=; b=QMabDYpR4+TgoVA87TUeldRTD
        qVV2QErUcDb1EX9+dkd1p7ZkN7lD09CxA1SRuKBOVgC6nutEOWEw3faFmTt2ReKiMAWK0Oy4pQ05P
        NZfTZ9RsaSWHroQtg0FSFNcRADwyGLz4/9RuzhMGJeRlkjsS3P3PYcH71egDtSmZZdD/fOKjfvgSG
        wCWnMFTAEVSBcAqDSa9rJhoLjpLtWTWCdVveU14WTNrDh/qkDdAHJrOISvHS0PDaEta2UM0t0VH50
        GnRSkvH264InFBtkszEVXnt5tpNlmywVU71Sbkw5JGA7t6UZoh7NWoKYfJWC5hEBbylr22NF6QvhP
        uEfq7NgwA==;
Received: from [64.114.255.114] (helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNJoM-00065o-JK; Thu, 15 Nov 2018 15:44:06 +0000
Date:   Thu, 15 Nov 2018 07:44:03 -0800
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>, linux-media@vger.kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
Message-ID: <20181115074403.45d9a16a@silica.lan>
In-Reply-To: <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Nov 2018 20:53:25 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> Profile is proposed as a way to reduce friction between committers and
> maintainers and perhaps encourage conversations amongst maintainers
> about best practice policies.
> 
> The profile contains short answers to some of the common policy
> questions a contributor might have, or that a maintainer might consider
> formalizing. The current list of maintenance policies is:
> 
> Overview: General introduction to maintaining the subsystem
> Core: List of source files considered core
> Leaf: List of source files that consume core functionality
> Patches or Pull requests: Simple statement of expected submission format
> Last -rc for new feature submissions: Expected lead time for submissions
> Last -rc to merge features: Deadline for merge decisions
> Non-author Ack / Review Tags Required: Patch review economics
> Test Suite: Pass this suite before requesting inclusion
> Resubmit Cadence: When to ping the maintainer
> Trusted Reviewers: Help for triaging patches
> Time Zone / Office Hours: When might a maintainer be available
> Checkpatch / Style Cleanups: Policy on pure cleanup patches
> Off-list review: Request for review gates
> TODO: Potential development tasks up for grabs, or active focus areas
> 
> The goal of the Subsystem Profile is to set expectations for
> contributors and interim or replacement maintainers for a subsystem.
> 
> See Documentation/maintainer/subsystem-profile.rst for more details, and
> a follow-on example profile for the libnvdimm subsystem.
> 
> [1]: https://linuxplumbersconf.org/event/2/contributions/59/
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Steve French <stfrench@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Ok, I sort of followed the proposed model, adding a documentation for
the media subsystem using the template.

I'm pretty sure this is incomplete and more work would be needed.
So, for now, this is just an example.

Also, I didn't test building it on Sphinx (nor added any reference for it
at MAINTAINERS), as my main goal here was to see how the model would fit
for us.

I noticed a few issues there:

1) Describing the "core" files. The media subsystem is complex: depending on
the device type, we have different APIs and different cores. So, our core
is actually a set of different cores. I ended by adding sub-sections.

Also, several things were not described there. For example, we store
DVB frontend drivers on an specific directory. We have drivers there organized
by bus type. So, one directory for I2C, one for USB, one for PCI, ...

It should probably make sense to be able to tell about that.

So, I would actually prefer to have, at the profile, a "files" section,
instead of "core".

2) As I said before, on media, we have sub-maintainers. Not sure how to
describe them on this template.

3) I noticed one big missing thing there: in the case of media, we are
responsible also to maintaining media staging drivers, that goes at
drivers/staging/media. IMO, it would be important to be able to describe
who maintains staging stuff - e. g. if the subsystem maintainers prefer
to let staging up to staging maintainers or if they'll maintain themselves.

In the latter, it probably makes sense to describe any specific thing
related to it (where staging will be at the tree, are there any special
rules for them?)

Anyway, RFC patch follows.

-

[PATCH] [RFC] Add a system profile description for media subsystem

This RFC aligns with current Dan's proposal for having subsystem
specific ruleset stored at the Kernel tree.

On this initial RFC, I opted to not add the reviewers e-mail
(adding just a "<>") as a boilerplate. If we decide keeping emails
there, I'll add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/Documentation/media/subsystem-profile.rst b/Documentation/media/subsystem-profile.rst
new file mode 100644
index 000000000000..7a5d6f691d05
--- /dev/null
+++ b/Documentation/media/subsystem-profile.rst
@@ -0,0 +1,186 @@
+Media Subsystem Profile
+=======================
+
+Overview
+--------
+
+The media subsystem cover support for a variety of devices: stream
+capture, analog and digital TV, cameras, remote controllers, HDMI CEC
+and media pipeline control.
+
+Both our userspace and Kernel APIs are documented and should be kept in
+sync with the API changes. It means that all patches that add new
+features to the subsystem should also bring changes to the corresponding
+API files.
+
+Also, patches for device drivers that changes the Open Firmware/Device
+Tree bindings should be reviewed by the Device Tree maintainers.
+
+Due to the size and wide scope of the media subsystem, our
+maintainership model is to have sub-maintainers that have a broad
+knowledge of an specific aspect of the subsystem. It is a
+sub-maintainers task to review the patches, providing feedback to users
+if the patches are following the subsystem rules and are properly using
+the media internal and external APIs.
+
+We have a set of compliance tools at https://git.linuxtv.org/v4l-utils.git/
+that should be used in order to check if the drivers are properly
+implementing the media APIs.
+
+Patches for the media subsystem should be sent to the media mailing list
+at linux-media@vger.kernel.org as plain text only e-mail. emails with
+HTML will be automacially rejected by the mail server.
+
+Our workflow is heavily based on Patchwork, meaning that, once a patch
+is submitted, it should appear at:
+
+   - https://patchwork.linuxtv.org/project/linux-media/list/
+
+If it doesn't automatically appear there after a few minutes, then
+probably something got wrong on your submission. Please check if the
+email is in plain text only and if your emailer is not mangling with
+whitespaces before complaining or submit it again.
+
+Core
+----
+
+Documentation
++++++++++++++
+
+F: Documentation/media
+
+Kernelspace API headers
++++++++++++++++++++++++
+
+F: include/media/*.h
+
+Digital TV Core
++++++++++++++++
+
+F: drivers/media/dvb-core
+
+HDMI CEC Core
++++++++++++++
+
+F: drivers/media/cec
+
+Media Controller Core
++++++++++++++++++++++
+
+F: drivers/media/media-\*.[ch]
+
+Remote Controller Core
+++++++++++++++++++++++
+
+F: drivers/media/rc/rc-core-priv.h
+F: drivers/media/rc/rc-ir-raw.c
+F: drivers/media/rc/rc-main.c
+F: drivers/media/rc/ir\*-decoder.c
+F: drivers/media/rc/lirc_dev.c
+
+Video4linux Core
+++++++++++++++++
+
+F: drivers/media/v4l2-core
+
+Patches or Pull requests
+------------------------
+
+All patches should be submitted via e-mail for review. We use
+pull requests on our workflow between sub-maintainers and the
+maintainer.
+
+
+Last day for new feature submissions
+------------------------------------
+
+Before -rc5
+
+
+Last day to merge features
+--------------------------
+
+Before -rc7
+
+
+Non-author Ack / Review Tags Required
+-------------------------------------
+
+Not required, but desirable
+
+
+Test Suite
+----------
+
+Use the several *-compliance tools that are part of the v4l-utils
+package.
+
+
+Trusted Reviewers
+-----------------
+
+Sub-maintainers
++++++++++++++++
+
+At the media subsystem, we have a group of senior developers that are
+responsible for doing the code reviews at the drivers (called
+sub-maintainers), and another senior developer responsible for the
+subsystem as a hole. For core changes, whenever possible, multiple
+media (sub-)maintainers do the review.
+
+The sub-maintainers work on specific areas of the subsystem, as
+described below:
+
+- Sensor drivers
+
+  R: Sakari Ailus <>
+
+- V4L2 drivers
+
+  R: Hans Verkuil <>
+
+- Media controller drivers
+
+  R: Laurent Pinchart <>
+
+- HDMI CEC
+
+- Remote Controllers
+
+  R: Sean Young <>
+
+- Digital TV
+
+  R: Michael Krufky <>
+  R: Sean Young <>
+
+
+Resubmit Cadence
+----------------
+
+Provided that your patch is at https://patchwork.linuxtv.org, it should
+be sooner or later handled, so you don't need to re-submit a patch.
+
+Please notice that the media subsystem is a high traffic one, so it
+could take a while for us to be able to review your patches. Feel free
+to ping if you don't get a feedback on a couple of weeks.
+
+Time Zone / Office Hours
+------------------------
+
+Media developers are distributed all around the globe. So, don't assume
+that we're on your time zone. We usually don't work on local holidays or
+at weekends. Please also notice that, during the Kernel merge window,
+we're usually busy ensuring that everything goes smoothly, meaning that
+we usually have a lot of patches waiting for review just after that. So
+you should expect a higher delay during the merge window and one week
+before/after it.
+
+
+Checkpatch / Style cleanups
+---------------------------
+
+Standalone style-cleanups are welcome, but they should be grouped per
+directory. So, for example, if you're doing a cleanup at drivers
+under drivers/media, please send a single patch for all drivers under
+drivers/media/pci, another one for drivers/media/usb and so on.





Cheers,
Mauro
