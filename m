Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90250C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E820838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3E820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJaT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaT6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33B8985550;
        Wed, 31 Oct 2018 11:01:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C17E611AB;
        Wed, 31 Oct 2018 11:01:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181031104912.s3tqjl3u43ou3kwo@gofer.mess.org>
References: <20181031104912.s3tqjl3u43ou3kwo@gofer.mess.org> <20181030223249.dhwhxdjipzmjxzsy@gofer.mess.org> <153778383104.14867.1567557014782141706.stgit@warthog.procyon.org.uk> <20181030110319.764f33f0@coco.lan> <8474.1540982182@warthog.procyon.org.uk>
To:     Sean Young <sean@mess.org>
Cc:     dhowells@redhat.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Brad Love <brad@nextdimension.cc>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb: Allow MAC addresses to be mapped to stable device names with udev
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10734.1540983675.1@warthog.procyon.org.uk>
Date:   Wed, 31 Oct 2018 11:01:15 +0000
Message-ID: <10735.1540983675@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 31 Oct 2018 11:01:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Young <sean@mess.org> wrote:

> > How do I tell?  If it's all zeros it's not there?
> 
> The mac gets populated through read_mac_address member of
> dvb_usb_device_properties.

That doesn't seem to be true for all drivers. The cx23885 driver does things
differently, for instance.

David
