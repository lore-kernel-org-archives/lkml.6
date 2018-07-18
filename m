Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD670ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777992084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV06ag6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777992084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeGREVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:21:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46216 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeGREVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:21:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so1502532pfl.13;
        Tue, 17 Jul 2018 20:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iS9/mPSMa3kOchmaMnG1XHbQyJaYp4OMwh8wMWIYrgQ=;
        b=OV06ag6iFPdSr/jidO+rgGKiRVdeuDwI/ao3JW3AWclrv5qLY28eSukoqFC1MZscSF
         T+XRif5X1YTMzcBQqzBYO1jgL5miRVFtm+vbpp4ox4pooCUMG8401wBcP2Sav6FO0DC9
         NV3jwVN4h+VIYeop4BfJHd67O1a5G4SazBu1OfqYU+ySTbWYuImYciKe/L60T9NAhasl
         63OzAb6xlrh92FDYnsd0sg4ur6V3RZPosGCNZmXBzeoCozcVtsDekc9cicxCoCaDjGR3
         2GEW/wfG8LIdMrVj2pWELQlKnlYPzIXKwpoU/yPydAicwjEH+qtm9hvI1PEo1bmUfoll
         pV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iS9/mPSMa3kOchmaMnG1XHbQyJaYp4OMwh8wMWIYrgQ=;
        b=Il/Gbqox7ZFOmAdWtqbGF8mt4nd2cyqZoG9PSs64R8gR7jC24iumETolK2KZQX5W7y
         g97SpO6aAExlgjOXGa92md5Sfj0PYIDhre6XHijCTBhyWnwOLIFexy7gug2YGCmsW4WF
         j7pyubMRQPhvkOnRq2vkxdzVI3ReDhLnQshSz0Wa83QNiGTve/KswLJWMOwjIwHvOOo7
         gFVJQ9bitt1QDRQByfI05nmbypYmJEB7IpvfYg0R30in3ZBGRepuhd4fu06b1TWfE3/0
         sw9ef7vOfTcr0bjrIY7pOWGBmi4JRdS5OTqwWzegJuaNacf7VPFAlURRmZXNM0/MPnuC
         nI9w==
X-Gm-Message-State: AOUpUlFq7P4dOb84l8J2OhHhVoCEznIShWSXboXvRQsy9UjSFMalDqjS
        O6l0vAl4TdyuLZTZxNc0scuqhg==
X-Google-Smtp-Source: AAOMgpd126W2CX88Ayn84jypW7gmqYAr2wd1UszbYpX2NDL0W0knIdi/82JTYohl93gNOhWMYOrn9Q==
X-Received: by 2002:a63:fc44:: with SMTP id r4-v6mr4135370pgk.169.1531885562876;
        Tue, 17 Jul 2018 20:46:02 -0700 (PDT)
Received: from localhost (c-24-4-233-174.hsd1.ca.comcast.net. [24.4.233.174])
        by smtp.gmail.com with ESMTPSA id y85-v6sm5158698pfa.170.2018.07.17.20.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 20:46:02 -0700 (PDT)
Date:   Tue, 17 Jul 2018 20:46:00 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Stefan =?iso-8859-1?Q?S=F8rensen?= 
        <stefan.sorensen@spectralink.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: fix missing break in switch
Message-ID: <20180718034600.lw6qet25kkpqquam@localhost>
References: <20180718011733.GA27872@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718011733.GA27872@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:17:33PM -0500, Gustavo A. R. Silva wrote:
> It seems that a *break* is missing in order to avoid falling through
> to the default case. Otherwise, checking *chan* makes no sense.

Good catch.

Acked-by: Richard Cochran <richardcochran@gmail.com>
