Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3922544
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="aK76BrRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B3922544
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeFUXVV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:21:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32934 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeFUXVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:21:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so2097658pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzHhBFRNexS9vHEkpQXOL5Nfy7fbIr6pAQnkT/S9/gU=;
        b=aK76BrRTUi8WX6THnrrhwI0rlClRuIpkew1/Ffju1Hj001Y+4t4NOLOPfYbreesJ6Q
         D9WwXqp/elZaVGoQCeSuwADpVkf5SLZypehesDj8jlVNSwVPLhaUbfQndN/a5HDrQKzg
         yW3rHSi/WezckBbhjiAP+jVlEPeQz9G7QdPqPyN4XSV6CFLIKnIaFL3qlDB3VR0XxXie
         L3Sgp5d5SFDPepW3bM8QLwAg/wUIDMEmNRCwkr+mr7QUfs5v1fzoznUGKXYrUtexKrHD
         9StzodvYTgJekg+0yNz5EE6UFAnbaKrHMJ5FEWwyRpB3JMaV0Ydp1DrSUXB9zuK1SIBO
         sFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzHhBFRNexS9vHEkpQXOL5Nfy7fbIr6pAQnkT/S9/gU=;
        b=bs20Lf4zsjH803ZniZfH9gMAaza5y/wmfOUkG/YQkTQ+8BBY9TECxXvvcI8h0k4zdn
         /tM6U1zRJJ8whmw12npWEQK5kYAORBAA5baVSPf+VqWAaKniV322ttR/85j0W2sB2g6p
         Ny945iXUnoLzKwBAabTlT//xA0eU7j8fyQt51ZOYrYs/z6lMaaUHjo9KqAN46rK6hRjJ
         j9cS6bWbFzfZL2oZ4r9rLXRQwQbiLNP3enkbXSsPHynXsjv7YP9J3fw4MdKktc/VzC2N
         Zgl0bRZ7NkAVPRCwZsW9wuATZDbd049FGg3oeFPydbyvR2+JwCvDVqjLIJhybhmbVCr9
         CrEQ==
X-Gm-Message-State: APt69E2PxcRBykHArdM8SdDylgZ4HjT+6b6CDnxKcWoI59eWnSkV7Ydj
        ylfcYlSLiR3AvFHIL0OpGSO6rQ==
X-Google-Smtp-Source: ADUXVKI+JF+S6N5Im6X8dOjKnScPZhCl6ziTlO2CMezrS4/mFHyBekLzxdiK/Dl8oaR2xyL5itCyCw==
X-Received: by 2002:a63:bf0b:: with SMTP id v11-v6mr23392143pgf.29.1529623279614;
        Thu, 21 Jun 2018 16:21:19 -0700 (PDT)
Received: from xeon-e3 (204-195-35-107.wavecable.com. [204.195.35.107])
        by smtp.gmail.com with ESMTPSA id m5-v6sm20632884pfa.93.2018.06.21.16.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 16:21:19 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:21:16 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Miller <davem@davemloft.net>
Cc:     garrmcnu@gmail.com, netdev@vger.kernel.org, jiri@resnulli.us,
        nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: fix potential null pointer dereference on
 return from br_port_get_rtnl()
Message-ID: <20180621162116.7f424648@xeon-e3>
In-Reply-To: <20180622.072056.1223319763674661318.davem@davemloft.net>
References: <20180621201427.4961-1-garrmcnu@gmail.com>
        <20180622.072056.1223319763674661318.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 07:20:56 +0900 (KST)
David Miller <davem@davemloft.net> wrote:

> From: Garry McNulty <garrmcnu@gmail.com>
> Date: Thu, 21 Jun 2018 21:14:27 +0100
> 
> > br_port_get_rtnl() can return NULL if the network device is not a bridge
> > port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
> > br_port_fill_slave_info() callbacks dereference this pointer without
> > checking. Currently this is not a problem because slave devices always
> > set this flag. Add null check in case these conditions ever change.
> > 
> > Detected by CoverityScan, CID 1339613 ("Dereference null return value")
> > 
> > Signed-off-by: Garry McNulty <garrmcnu@gmail.com>  
> 
> I don't think this is reasonable.
> 
> The bridge code will never, ever, install a slave that doesn't have
> that bit set.  It's the most fundamental aspect of how these objects
> are managed.

Agree with dave. Workarounds for static tools are ok if they don't introduce
other paths. But if your fix introduces another error path which can never
be reached, it is hurting not helping.
