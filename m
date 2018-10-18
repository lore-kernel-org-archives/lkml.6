Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD4C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B829E2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B829E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJSDes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:34:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34388 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:34:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so23805735otk.1;
        Thu, 18 Oct 2018 12:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+P0owlAt5wuc3k+Kq2xX/sxEPK6+Ysb7TLMPxVZRchg=;
        b=e2Ms75kHB8MGRZo0EEX8wvYWr8w1KD5tLIxtkAcA2RSxG2yzbhW/AsNNPWN+y/3mBf
         kB/34GYRrkswQjaFJRx1xJkboZvJDSK8TxeaHq+QkE/SPFW/Qajrc0kuFX+ZUCG4B8SE
         /kXJV3HtXQeUtwiYRye0p+HYlOZBTSTLBvNLOXZM+nOkYu8H2a1wlQwEDylu8Fv0TsCW
         q6XXILmSIPfo0uRd5p2KwQVtUIS27P7/wCqSM3oZHny+CRAuDVuxtk8CZ7kv+hbm2alJ
         vuJg6uXqoFJR9PJebAKdDOKxAEH4Lf5FlAfv86itsz7RAx7jhN1pNdTvct81SzuD+eww
         q/xA==
X-Gm-Message-State: ABuFfog3z23EveJ7XnhF+3vXsNhq8I53LmfK3DcYzj/dv0ZeywRXoz+P
        IkVgbqkAs96jAvp8hDfwXQ==
X-Google-Smtp-Source: ACcGV600JgAA0Rdz6YZQuPH7TozCzx+sOGSJYFXPfQqvelIqhJKwj/8tZXBpzjnHpqlJytodjbqpfg==
X-Received: by 2002:a9d:409a:: with SMTP id n26mr21605470ote.6.1539891137805;
        Thu, 18 Oct 2018 12:32:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d137-v6sm6486456oib.3.2018.10.18.12.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 12:32:17 -0700 (PDT)
Date:   Thu, 18 Oct 2018 14:32:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH v3] of: overlay: user space synchronization
Message-ID: <20181018193216.GA9971@bogus>
References: <1539736466-28638-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539736466-28638-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:34:26PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> When an overlay is applied or removed, the live devicetree visible in
> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
> changes.  There is no method for user space to determine whether the
> live devicetree was modified by overlay actions.

Because userspace has no way to modify the DT and the ways the kernel 
can do modifications is limited.

Do you have an actually need for this outside of testing/development?

> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
> user space to determine if the live devicetree has remained unchanged
> while a series of one or more accesses of /proc/device-tree/ occur.
> 
> The use of both (1) dynamic devicetree modifications and (2) overlay
> apply and removal are not supported during the same boot cycle.  Thus
> non-overlay dynamic modifications are not reflected in the value of
> tree_version.

I'd prefer to see some sort of information on overlays exported and user 
space can check if that changed. IIRC, Pantelis had a series to do that 
along with a kill switch to prevent further modifications. At least some 
of that series only had minor issues to fix.

Also, shouldn't we get uevents if the tree changes? Maybe that's not 
guaranteed, but I'd bet we can't handle cases where we don't get events. 
A property added to an existing node comes to mind.

Rob
