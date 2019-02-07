Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9411E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPKZZF7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfBGTtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:49:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44917 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBGTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:49:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id e24so1858546otp.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32dcltOQ1P4EoeLXctHavIhMS0EvxGLs/iMVzRHCsGU=;
        b=jPKZZF7tN7/34sOt1r8tSTVBcxcos+cBMXyBuXvH6dVtt3C4pIb+IpiZG+HKpC+ot7
         dhEh/OcLGMV03sN9KWVOjb3a+CjR/P/GIghAyJxJta1IvRicRvLuzrfK51fdxKiSiUo3
         3EGtVjonMdx9hOeumg9x/oGgJVgiGFFJm4+a9Elg0RdflhKaMbYJu1crfwPUyxGae9FQ
         UZNRbppQejlKbAVjRtHIEjnH05TXMjeCNM4YyW+LO/CcproE/ug/kmXyr74T+TEG/fcb
         Dz5scdqDJ9tqLGTbSYugLPGPmaatIdhpcAmAlZWAz1kGP/IXJ22cmI1odr3YBd5ObWuR
         ftLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32dcltOQ1P4EoeLXctHavIhMS0EvxGLs/iMVzRHCsGU=;
        b=ertxVYxfzDiGzZ/WAPcYZqHfVp9/yVfvQFPec5qsmBiJUmXmq3lwsIx7eDE8zAEAUU
         RSPOsAKPKyDqNfE4ECXy5jU0DjANVN373398bMS4ya0xaILf5MH0CCjtj1xY8azjfG55
         b+7MiW+cVsK/vbmHOhW56mD9KvNLDy1Vesdw5izaOjc04UbEZIaxV0bVfGjc7AXh81na
         JBStkruGqrMS1UGAKwx5gC+Iq4YM9aGi9WMw4FkO6QiRG46fdAjFsjsYVzafBtzzeTrC
         dFQQzBULQbznZHNpoJm+qcoCcmlNm3Rv0tSR/1AHd5oSP2+K4Ac1EHdW92znkTcXa1a8
         aVMQ==
X-Gm-Message-State: AHQUAuadVZoFiDL7G3bqDV11F4vk8BkwBTz2RRyxUBrBiUFFpOZUKYkJ
        TcLh6G/4wPhFAVls+tTUFwHXb6G8GdsAV2TfRLBdRQ==
X-Google-Smtp-Source: AHgI3Iao5B2FksP2nvHzOyXP8JNL3FyTeoQrKLOUtI6ClvTUCW156Q1UP7kwUSycC27zsurQ1I8shPEE6xHo0kMlXcI=
X-Received: by 2002:aca:eb13:: with SMTP id j19mr1311537oih.100.1549568943164;
 Thu, 07 Feb 2019 11:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Feb 2019 11:48:51 -0800
Message-ID: <CAFd5g46aiJ2srDf9akR+TwPg3ZheVYJE1JQ4AGm2t8hfO6rF1A@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:40 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 118 +++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 26 deletions(-)
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
