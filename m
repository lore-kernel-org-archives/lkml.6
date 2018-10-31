Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDC120657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDC120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeJaTzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbeJaTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCD87308A968;
        Wed, 31 Oct 2018 10:57:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A8035D9C5;
        Wed, 31 Oct 2018 10:57:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181031084327.25bd5654ij37o3b5@gofer.mess.org>
References: <20181031084327.25bd5654ij37o3b5@gofer.mess.org> <153778383104.14867.1567557014782141706.stgit@warthog.procyon.org.uk> <20181030110319.764f33f0@coco.lan> <20181030223249.dhwhxdjipzmjxzsy@gofer.mess.org> <20181030213513.51922545@coco.lan>
To:     Sean Young <sean@mess.org>
Cc:     dhowells@redhat.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Brad Love <brad@nextdimension.cc>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb: Allow MAC addresses to be mapped to stable device names with udev
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10474.1540983466.1@warthog.procyon.org.uk>
Date:   Wed, 31 Oct 2018 10:57:46 +0000
Message-ID: <10475.1540983466@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 31 Oct 2018 10:57:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Young <sean@mess.org> wrote:

> With this patch, with a usb Hauppauge Nova-T Stick I get:
> 
> $ tail /sys/class/dvb/*/dvb_*
> ...
> ==> /sys/class/dvb/dvb0.demux0/dvb_mac <==
> 00:00:00:00:00:00

I presume you're complaining, then, that the file exists in this instance
rather than it doesn't have the real MAC address in it?

> Having said that dvb_type does look a little nicer:
> 
> 	ATTR{dvb_type}=="demux"

So I should keep that or drop that?

David
