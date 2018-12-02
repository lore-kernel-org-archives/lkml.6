Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F68C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2867420892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=laptop-org.20150623.gappssmtp.com header.i=@laptop-org.20150623.gappssmtp.com header.b="TBcxg8Wv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=laptop.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbeLBXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:25:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLBXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:25:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so4846928pge.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=laptop-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aElEMZ/2oXcO1UAaewUAxe9TlLURM5XdAWKdXdvBChQ=;
        b=TBcxg8WvJzWZ9PUCBRwSB/vREyo4LL/aQVqsmUSpADVh9bUS47ZSHIAmZjtdwd7V3r
         R7PB5LQCMzXKUcagdT3HVZdKFVPJ/R0cOM+WuHmk9I8COtt+ovKQQZOcTIJLgiBchWcP
         TcR6A1PJ6FlBnwU8fu/7mo3e65R3u7jhvAFzWc6hvDU6xuz6DFgVC3WkRKIpK1RdV0F9
         pCDj76/OKgi3zPDnQ4hZY4414iJIrUpzlqFBz9retvY/O4M0NJYF34msGKZYcwvrg5cc
         TnG5VrVXWjgsZoTw4ZfHwxOME4WYZbVKf0EDwcqTGz4MbLu4ounRckUXeCHCr/uORRjp
         zMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aElEMZ/2oXcO1UAaewUAxe9TlLURM5XdAWKdXdvBChQ=;
        b=rDDtCk+rwTmyziQrBpCpRTUtJuptF2uhJAf2vqNX/HzZ0ROSY9JYHoUpHZ+zd6ovR7
         OU6eZ9E8iCcYBTmK7ZPl/Ia6ymA0W2iAQhuoUcbMVQi25VKf/31P/eJvUEHq1nVH4Gkh
         ULzhOXB8DpJYwFKxC5jQRuDi11XAuME2PJoWS0JzW9LnKkkWPGUJz9tIjI2zJSKzCEvI
         WukKlLgmZSxy7dHCdGjN0qZBBIdkI0w1yo5SagoRsTkr4duz+xw/olBLT9KMF3PVqQa0
         kAeA++gnw/5lf56f4KGdytzjvktXJCQQl+lAdZVShYAWrkiQe+cmn5F7Bj4/5ReiIpW6
         0c/Q==
X-Gm-Message-State: AA+aEWa55EltcYFU1PcIa35X5k0asr/5CytHnqGH+gPn7ekMzk/NK6nI
        MOTxytEXjN4SCVXIGdrAAsPbPg==
X-Google-Smtp-Source: AFSGD/UjAuli8dvY09Ns+79X/Fr0cD1UrZUTUuY8JJ8L00KBeN8Wk3sQfWqweBDT6yQHCQHqu6sDKA==
X-Received: by 2002:a63:d157:: with SMTP id c23mr11392358pgj.170.1543793101653;
        Sun, 02 Dec 2018 15:25:01 -0800 (PST)
Received: from esk.lan ([1.144.139.38])
        by smtp.gmail.com with ESMTPSA id c65sm26657231pfa.90.2018.12.02.15.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 15:25:01 -0800 (PST)
Received: from james by esk.lan with local (Exim 4.86_2)
        (envelope-from <quozl@laptop.org>)
        id 1gTb6e-0004gF-9K; Mon, 03 Dec 2018 10:24:56 +1100
Date:   Mon, 3 Dec 2018 10:24:56 +1100
From:   James Cameron <quozl@laptop.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        lkundrak@v3.sk, arm-soc <arm@kernel.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181202232456.GE12222@laptop.org>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
 <20181130234424.vx5y46wqvziywbk2@localhost>
 <20181202222930.GB29467@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202222930.GB29467@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 11:29:30PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > The patch set has been tested on an OLPC XO-1.75 laptop.
> > > 
> > > Excellent!
> > 
> > OOooh, I have one of those... somewhere.
> 
> Time to find it :-). It is still pretty great machine, can last 8?
> hours on battery, sunlight readable screen, and if you meet a tiger
> you can hit him on the head with it ... and it is still likely to work
> afterwards :-).

Yes.  Best configuration is with laptop closed, ears locked, firmly
held by handle, and use the narrow side edge to hit with.  Users have
tried the large flat surface behind the display, but the display tends
to fail after five to ten hits.  It will depend on the tiger.

-- 
James Cameron
http://quozl.netrek.org/
