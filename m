Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908F3206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpkvW+IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908F3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeK2OMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:12:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45967 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2OMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:12:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so266161pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lMygJcHrzCNl4q8CsoRPaEEAZ7y2UvLdyTEjBhaeM4=;
        b=OpkvW+INGup/BeS7BqEn1jvP+ScT4H1LWIeXXCCY7CaX5DqKyhgE1KbRAcB1MjjrSB
         moW2rtvWDoON+cF62x1lSM/SscJ05w7Cxam1IgCCB/3wfR4p0BzEws/3KJ/By/3nZ4Zl
         aD4jmxIz93Rke/i4/4raPxo9z4DeD88knQtKrqCQCoxarmLlLvlbWahLokx1POLyPeWD
         yOJOqeUXnamQLNfROfDS5LGSbpSQXcQXURwLMDi0ZFmSxhUjYg2VzcB/VZDLrO3g1Hi9
         uXBecye3+s7GRQ3LA5lgmdQLVu0lp8/wsXijDLz2yE+Kk9RkrYzs+gLHON8EV5iQxlO0
         uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lMygJcHrzCNl4q8CsoRPaEEAZ7y2UvLdyTEjBhaeM4=;
        b=VvkQpFC/UA+qgfJXT7dM4sg29rVT+Q2AaP1eyWL81iKmt9LjcDOkfgpdvacw7u0XG4
         iVdzSzLmppVzNp5FZwTzEM9X+es5pbOj9n14HUWO3KeZeKezKItPHTsA7XDyfbgMVnYS
         /1lLxqJkU84Br00MHjP7nKRrIdMq1Fojw2c9WbnA7+TwKBkfboZEqGqhThqemVJ2DsJL
         b5OrkYEHONbNgp+WtXFAsAr6MPBYsyjj3sXgELyVvm/24Ev7R8wOysIBmhnS622w7qmZ
         YVeFSZ6HEWP3JVk8flBcUdm0Tc9nZOUODlHRihxOBDggy1CfifLQgplVeFy2nDmvnV5v
         MXSA==
X-Gm-Message-State: AA+aEWa74Ee5OtrtQAgMrHwJM7nEDavlHp7KUoh5i2qCBt7fctFXP0TO
        Ly+xKGwCxyBx4pM1tNZU8No=
X-Google-Smtp-Source: AFSGD/VqVxZNgPMspDJ7YbFASFyLFh8rQolq7ER6IuHQmM1foPdtG4kXdxxDABL42ohKQ9Hcur63qw==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr17910817pfk.191.1543460924404;
        Wed, 28 Nov 2018 19:08:44 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id e9sm489999pff.5.2018.11.28.19.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 19:08:43 -0800 (PST)
Date:   Thu, 29 Nov 2018 12:08:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] lib/lzo: implement run-length encoding
Message-ID: <20181129030840.GF6379@jagdpanzerIV>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-7-dave.rodgman@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127161913.23863-7-dave.rodgman@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 16:19), Dave Rodgman wrote:
>
> This modifies the bitstream in a way which is backwards compatible
> (i.e., we can decompress old bitstreams, but old versions of lzo
> cannot decompress new bitstreams).
>

Hmmm... Whoa. Help me understand this:

So a btrfs filesystem, compressed with the new lzo, say I run 4.21,
won't be readable at all once I reboot under 4.19?

What about compressed net traffic between servers running different
kernel version (one with new lzo, the other one with old lzo)?
XFRM can be compressed with lzo, can't it?

	-ss
