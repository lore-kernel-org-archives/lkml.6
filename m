Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A779C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA17220857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA17220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeIEWV7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:21:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727201AbeIEWV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0ED7640241CA;
        Wed,  5 Sep 2018 17:50:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9847463A8A;
        Wed,  5 Sep 2018 17:50:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180905165552.GB25206@kroah.com>
References: <20180905165552.GB25206@kroah.com> <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
To:     Greg KH <greg@kroah.com>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        keyrings@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22224.1536169842.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 05 Sep 2018 18:50:42 +0100
Message-ID: <22225.1536169842@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 17:50:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 17:50:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:

> > Here's a set of patches that inserts a step into the build process to make
> > sure that the UAPI headers can all be built together with C++ (if the
> > compiler being used supports C++).  All but the final patch perform fixups,
> > including:
> 
> Wait, why do we care?  What has recently changed to start to directly
> import kernel uapi files into C++ code?

There's at least one outstanding bug due to a C++ identifier in the kernel
UAPI headers.

Are you saying you explicitly don't want people to be able to use the kernel
UAPI headers in C++?

> And if userspace wants to do this, can't they do the C namespace trick
> themselves when they do the import?  That must be how they are doing it
> today, right?

No, because there's no such trick (except with the preprocessor).

David
