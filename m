Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38357C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D352520989
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Ji9uP1Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D352520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937035AbeF2Qnh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:43:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37431 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934630AbeF2Qne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:43:34 -0400
Received: by mail-qk0-f195.google.com with SMTP id t79-v6so5258693qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hW1Zkz2qu4KPlp1/IbQ+jjB4wOqLnYg4iC6qrKZnYE4=;
        b=Ji9uP1Lx6xEyPovDlWXqLqX6q/nuwiC5dgo2XbcONxTXD9xWvAkQGKcIj4wDqXy874
         USr/QV1Jt35aJ0iPQdB5vBCVEdTM4Xt3eXOzUSVhSoMO4bs8NSCrDH0T9VAUDhUuufOW
         ByAAy7XuZkI1kvjUl7zW8EWqh6serKu+dhtPCYETsHANZdLXobGDnEqQU+O/XHvWGK8D
         p0g6BM/Or08uB9r6BGymEbpkst9u8lZAxMg+5jWLJP1zNB2MZdRBkmvSMMSO1KigRo8D
         /zU/b93C0EIN/L0UHVc3u7KNMDF4Fz6G0KKJuBREoyhJI4L9D9xenXoK5wiYNF8aaIS0
         fN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hW1Zkz2qu4KPlp1/IbQ+jjB4wOqLnYg4iC6qrKZnYE4=;
        b=dDdtitdSyx6J7hnT4O1jhxpMb1KBfsbajVzu5d5D8WeEUMZ94Mll85s3whrmkAay94
         8AOJFeKFoCerDMALG++9xHIPiJZBMqmlYPDktPStIZ7ePtieCLt5EZ3N7FcY7XGBTBUK
         cYcdggUgLALmhZuZBmTJipk2Mqpau6Ka7dM7V0sVIpePXQ9uVP9Cj7DTQLMb25rotAr5
         BQkbLmLk21DFrN+A46uKjEJXkBaa2Ujvnr6o4SBjoizEGyD8ASRlQyBGSj9+7eSovMLt
         CwSrjV83irJo9w+o6mNZnkMlSd2hX+ZP5u7lfO0TWrELdZ6G3u4SE7AdAXk6HkPY/2vR
         hoTg==
X-Gm-Message-State: APt69E1nW91LOTCKEPs8s66Wveq3KUl380agXtQl3vMDjVS2RViP3a2Y
        vU8gu8OfI1svehPa/Ip4v/81Kg==
X-Google-Smtp-Source: AAOMgpdelQisX52xxpc526rOHvWWe3cbwpc176PLATcokcx07qq4jNnkEEGlNy5PPHObvAzlDfYSuQ==
X-Received: by 2002:a37:a0c8:: with SMTP id j191-v6mr13066175qke.375.1530290613900;
        Fri, 29 Jun 2018 09:43:33 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.73])
        by smtp.gmail.com with ESMTPSA id p189-v6sm6496022qkf.70.2018.06.29.09.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 09:43:32 -0700 (PDT)
Date:   Fri, 29 Jun 2018 10:43:30 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180629164330.GL27027@cisco.cisco.com>
References: <20180628120542.GA4065@kroah.com>
 <20180629102446.11189-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629102446.11189-1-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 04:24:46AM -0600, Tycho Andersen wrote:
> v2: switch to locking uport->lock on allocation/deallocation instead of
>     locking the per-port mutex in uart_put_char. Note that since
>     uport->lock is a spin lock, we have to switch the allocation to
>     GFP_ATOMIC.

Serge pointed out off-list that we may want to do the allocation
before the lock so that it's more likely to be successful. I'm happy
to send that change to this if it's what we want to do, I don't have a
strong preference.

Tycho
