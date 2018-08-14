Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A12C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537E121725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cml3jO42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537E121725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeHNXEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:04:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:04:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so9753051pfi.1;
        Tue, 14 Aug 2018 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+GXHSzprWuz6Yv7XZ6xoEa1vEMnXZW7V89V1vT1Qpo=;
        b=Cml3jO42+Pg+BVB+cjKX3d3SgqcoqxUE1SbR7VFdZYNcroetjqI7UjDub1WN2FVLRB
         RLM+1mIKLBtJZ9kdPirHr5B3zw6NhGdnDWw1qIwDVrk9o5Q5mEI7/TObXhF5X8paYVv2
         4xqF6UmkPzUmrE2nHAkhmJnDB7ZjoBnKAggsODH3XTgFRILh4W/yuAtyujMTP/A5G+06
         mJeLLY5qNTuiuhS1ONZ/6nYxmoKb9zxbijHplZKOCq21lMMpGq1dU/pIuzg2oYH7e+2n
         RfXvGNpI4t1GmBy/BZQeVOFd+lnAyBqf7VQgRfOqPwWI5pI1Xbr7yn4/zPIJ84NG09s9
         oVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+GXHSzprWuz6Yv7XZ6xoEa1vEMnXZW7V89V1vT1Qpo=;
        b=AfrVkssIYJd2DOXLufjMMSHlfDC77fv8GNdA5jbHlSl0Pr4q1Do6RVPLiEeQMDrW4B
         EKgP2boInZgGvTco1PBfLfVu55bSRiReGnWo7J3RJzNEhq2IsCKUoe+S7Xrxkuu3J3sP
         pPoAzfa8RyeqJiPmHqrjv9pO2Kat+r/x96/ITS6kKi7em++wanbOKWuaiM3sX2gFiKgZ
         fqJ6AfIVLmqgbtAP+yMEIS06uLpMTw7AMEm9cioVUhYQ1sT9CG3EVVVxYvdvUR6TTQWc
         NWNtcaeB+teJE0od2N0BcD1BLPSsgWzFuergaCxc1W7itj9BNBEm9UMRe2CdPEYxY3GN
         yQeA==
X-Gm-Message-State: AOUpUlFZNWBVIS3gyEJbhHOSkXT26UFu29hsQrjSTAG3rDXmEPrD4A+c
        Q1Ao5hbOWR/Cg9sWKceUKZs=
X-Google-Smtp-Source: AA+uWPwEgVMXXdqzB1amv6YFfa0quKnX2JxdgeOf/aSEBRX1+jcuw01xSNB8yBX904EqdM+soZ3rLQ==
X-Received: by 2002:a62:cd82:: with SMTP id o124-v6mr24684293pfg.206.1534277765564;
        Tue, 14 Aug 2018 13:16:05 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id n22-v6sm45323373pfj.68.2018.08.14.13.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:16:04 -0700 (PDT)
Date:   Tue, 14 Aug 2018 13:16:02 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [PATCH] bluetooth/{bnep,cmtp,hidp}: Remove unnecessary
 smp_mb__{before,after}_atomic
Message-ID: <20180814201602.GA159642@ban.mtv.corp.google.com>
References: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 08:41:06PM +0200, Andrea Parri wrote:
> The barriers are unneeded; wait_woken() and woken_wake_function()
> already provide us with the required synchronization: remove them
> and document that we're relying on the (implicit) synchronization
> provided by wait_woken() and woken_wake_function().
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>  net/bluetooth/bnep/core.c |  7 ++++---
>  net/bluetooth/cmtp/core.c | 14 ++++++++------
>  net/bluetooth/hidp/core.c | 13 ++++++++-----
>  3 files changed, 20 insertions(+), 14 deletions(-)

Seems good to me:

Reviewed-by: Brian Norris <computersforpeace@gmail.com>
