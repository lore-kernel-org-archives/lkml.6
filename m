Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5856C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EEC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VkYLUTnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EEC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeLKFzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:55:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLKFy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:54:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so12753667wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 21:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nDwWbL9ECDS/hWmZfeH+S96T3x++2sjO36pBh4l9MPU=;
        b=VkYLUTnkmhCmvMHz8v5j/cXkFMS7eT+fTKtolUVX2wgPU8WW7557diycrs9cUrADUK
         V1FMV0o2jrDkZUavBpCop9u3x39AlEGMRwoV2D+NCIYrZ0+ACZG+UwRRvIFOpgP5ECvN
         b+HTK1GgOq+Bb497gWaaVC4MN0+VK457baZdtf8NtE18J9WV6PHqw42T7dxOZFZzEQ9Y
         MhSRLxG/i75MwqvdvvSv4RI8hHjG1tJZiE0XPr14NJ6LzjiSCCeftZ+GY6cyACB4eHoi
         3rKIGTwJ9Jq+MWz7hHcZAYhdke7QmcpnFUqXu+r5mn1sBRY71JFN6MUhWdeXJ0ivuphX
         fAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nDwWbL9ECDS/hWmZfeH+S96T3x++2sjO36pBh4l9MPU=;
        b=OMVj45owG+vSShIQBcCLtdNQQHa6RyA7bAuPbc0b4KoWbD1onYC9jeC+W2AEAqr4Yd
         PjtFZ7QY59Amu1ZNbqbE+PFF7c3nlcLLmPxM3OpF88OasB1ZlfmRQDD72I0f4n9AFvr7
         b//b2p5XL5d5VyfC2ufcvE3oYhDCin+ejCJ79WCTt8blYRE8i2Pe6u0vMjPk3cxNWLNL
         3Bbe+NN23NuXUFxNpbgxNKdGwFs3FvMO0xnht1kf1dfc242mMWkDERZWLWSu77KvGxoh
         n6CoeK7uoRzW/wp3N5e++ZDZwRyCgRens/uB3W+pgjC0wBnoow0LeHDMML4Q6G79/Z6b
         ljAQ==
X-Gm-Message-State: AA+aEWaFJKpZiBiQeWedAXbGYG9bhg9gHyrrwZfpBSK0QSmzE55558gW
        DA93wFY002bz7vJ5gDOt9QNwpw==
X-Google-Smtp-Source: AFSGD/X0DFbh51qKaP8Hgx/CmUgeu+0vF180BRC6s1Sp98HwS+A5KikpLWTCXJI4SSLoEv047r5JFQ==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr12012411wrp.111.1544507698047;
        Mon, 10 Dec 2018 21:54:58 -0800 (PST)
Received: from brauner.io ([2a02:8070:88c2:4000:69e7:45c9:1529:166d])
        by smtp.gmail.com with ESMTPSA id n20sm732358wmi.11.2018.12.10.21.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 21:54:57 -0800 (PST)
Date:   Tue, 11 Dec 2018 06:54:56 +0100
From:   Christian Brauner <christian@brauner.io>
To:     =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "kilobyte@angband.pl" <kilobyte@angband.pl>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v1] binder: implement binderfs(Internet mail)
Message-ID: <20181211055455.lb55hto554klzdvf@brauner.io>
References: <20181207232509.31771-1-christian@brauner.io>
 <CAHRSSEzxR2wRw9UxaKkXTZ7cu989+70-V07PxMm6o+BfLTQ=6w@mail.gmail.com>
 <5FBCBE569E134E4CA167B91C0A77FD610198FD6A14@EXMBX-SZMAIL022.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198FD6A14@EXMBX-SZMAIL022.tencent.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:44:48AM +0000, chouryzhou(周威) wrote:
> > chouryzhou@, can you confirm that this implementation works for your
> > android-in-container use-case?
> > 
> > -Todd
> > 
> We are running Android Pie in container now. If it works for later Android 
> release, it will works for us.

The patchset is absolutely agnostic as to what Android version is
running. :) It has no userspace consequences.
If at all it makes it possible for Android to upgrade its userspace to
use additional devices in the future without having to recompile the
kernel. There's a whole lot of interesting things one could potentially
do with this. :)
