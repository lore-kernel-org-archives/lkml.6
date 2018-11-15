Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E81C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B9F2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JiPcsECX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B9F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeKOQDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:03:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Of1YOonu0nmKZ09v+9jRmYSm80+DzCGnvLsx+BmwZxM=; b=JiPcsECXrDjDdE312XCPv7AdD
        MJWQOPuG7TzBVJkgfYp9wDIlojxOATRPCxIXvMtPhLozxI0nvhBIg9ckSS2s0oZmMmQwVVR8Zo0dH
        tQ9n7lPbRDxVIyxoC4RdHO0+FDRW5abcRO2jICh7pEBRXbStDjihY4OZ2j823DP5HRKvfo+C2qbjA
        O1A93tWq29HPggpqsq98p9VxsUuYGEjutYJi5xn8DCs0yWAs7a5IhM08fjn9N/MLanAaAIzmKb9iH
        JliCeH2kCSwZzjxeNoF0+bs1yxCYn0eA1GHZEEmyiOuNywOs6c7uWed2VWxXvJ8PXYePDOrOfrjjG
        lq3d/T9xA==;
Received: from 189.27.28.95.dynamic.adsl.gvt.net.br ([189.27.28.95] helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNAeQ-0002S2-IK; Thu, 15 Nov 2018 05:57:15 +0000
Date:   Wed, 14 Nov 2018 21:56:58 -0800
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Olof Johansson <olof@lixom.net>, linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 0/3] Maintainer Handbook: Subsystem Profile
Message-ID: <20181114215658.78e1908c@silica.lan>
In-Reply-To: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Nov 2018 20:53:13 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> At a recently concluded session at the Linux Plumbers Conference I
> proposed a "Subsystem Profile" as a document that a maintainer can
> provide to set contributor expectations and provide fodder for a
> discussion between maintainers about the merits of different maintainer
> policies.

As discussed at LPC, please don't forget to add a patch teaching
get_maintainers.pl to print the subsystem rules tag (if any) at the
final version of this series.

Cheers,
Mauro
