Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7413C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96581208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96581208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHJIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 04:31:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725746AbeHJIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 04:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 507577A7E9;
        Fri, 10 Aug 2018 06:03:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-23.ams2.redhat.com [10.36.116.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAF1B111AF2A;
        Fri, 10 Aug 2018 06:03:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CC59211A9A; Fri, 10 Aug 2018 08:03:29 +0200 (CEST)
Date:   Fri, 10 Aug 2018 08:03:29 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drm: qxl: Fix error handling at qxl_device_init
Message-ID: <20180810060329.gipwvnw56v4gaela@sirius.home.kraxel.org>
References: <20180727115440.11112-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727115440.11112-1-vasilyev@ispras.ru>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 10 Aug 2018 06:03:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 10 Aug 2018 06:03:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:54:40PM +0300, Anton Vasilyev wrote:
> If qxl_device_init fails on creating resources and does not report it,
> then qxl module will catch null pointer exception on remove, or on
> probe's error path.
> 
> The patch adds error path with resources release into qxl_device_init.
> 
> Found by Linux Driver Verification project (linuxtesting.org).

Pushed to drm-misc-next.

thanks,
  Gerd

