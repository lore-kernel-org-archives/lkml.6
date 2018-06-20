Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76372C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D88220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D88220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeFTMSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:18:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeFTMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C60297A7E8;
        Wed, 20 Jun 2018 12:18:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-94.rdu2.redhat.com [10.10.120.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84CBB111E40F;
        Wed, 20 Jun 2018 12:18:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAK8P3a06uP18jei=b3Hwdoe21f3gM6K5j2129Ra5CdVx5aKh6g@mail.gmail.com>
References: <CAK8P3a06uP18jei=b3Hwdoe21f3gM6K5j2129Ra5CdVx5aKh6g@mail.gmail.com> <20180620083339.766780-1-arnd@arndb.de> <5489.1529492311@warthog.procyon.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     dhowells@redhat.com, y2038 Mailman List <y2038@lists.linaro.org>,
        linux-cachefs@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cachefiles: avoid deprecated get_seconds()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24226.1529497088.1@warthog.procyon.org.uk>
Date:   Wed, 20 Jun 2018 13:18:08 +0100
Message-ID: <24227.1529497088@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 20 Jun 2018 12:18:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 20 Jun 2018 12:18:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> > But I've no objection to using ktime_get_real_seconds() and truncating the
> > value.
> 
> Ok, fair enough. I was mainly worried about what might happen when the
> file names stop being strictly sorted in numerical order by their creation
> time. If that is not a problem, I'll send the simpler patch to use
> lower_32_bits(ktime_get_real_seconds()) for clarity.

That's not a problem.  Everything copied into that directory is to be deleted
asap.

David
