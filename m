Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA14E218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHkIr3d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392962AbfBMRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:23:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46584 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389972AbfBMRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:23:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so3423748qtm.13;
        Wed, 13 Feb 2019 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ipF3716R90Zy8niFjRo7IwcTvpvdKJtQxiKOEYc3Kio=;
        b=rHkIr3d42WT2xwiYwjozey0dBmMyJP8SEaOUexuq3fGjM+X2jWi4HaSwuasEWZWT58
         olXl6r0uX6D1urkjgVtif5Vlb9RBwRZ7P5k6/XnbgXgk9G0ljO+mHpdgwkfXxNB2CbbE
         awLF8+lrRj+61R7WFvzeTArnk/X1PaVpz76TU48jO2VDUHrrTeSd8qSLQVhZ5hgjQKg1
         0wKWjEIXcpr3bkzSl2sBOVRgWuNQ9J75mOgIOrBxihuPajImgkohri8IebjNC00/23JK
         +X7s0uYFVMfnUGuY5WPUAFT3ENxgbNFo7O+gMd9tUnomP9WoPq6Cw/Ad03fdK/TpoaeM
         vb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ipF3716R90Zy8niFjRo7IwcTvpvdKJtQxiKOEYc3Kio=;
        b=MdR5HIEtgMXVa6bvaJ4X8/rffw2QZ+6inkXVPYryxIWCbFTiGSPDuWGLRxaY9cubWB
         I0fK6L2Ss4Ql9RauKbYPBDl5M0A0ShHtUsTchO9543KuilinFuocqOhgSjgn7bb3fP/O
         +gYpd6I8RzHp64FmG8BTgvF26bRTs81q9ovf0mtSB33VNrsKS5IRj9PG9JlTo332fQjG
         GUF6pxhbENvSMmlWiBMGLHBxOkAmLU8l18LrlIn/bBjNgautkrbg8fybru4y19aJm7Jk
         ekeUtF5BBhNwStjIzMWo9N/hMQz6ztKnZthWTF/i+AOd7M1Xwi28RBbZlzxfVDieJz/g
         V7Ew==
X-Gm-Message-State: AHQUAubyk48ecXO3JxdwU59FXAha/UnAWh81Kd9ACVHPcsnGGAZ/Vtec
        BYy0v6/RUQEckNrSKop30IJSH70tR+Y=
X-Google-Smtp-Source: AHgI3IbmLhUWXKxWW6Gh44+ibW8DqRH/5tnaP2RqZFMxU7K7tJ5lF7amVwXc1DVqfhJKzAGVkm9rEQ==
X-Received: by 2002:ac8:16d0:: with SMTP id y16mr1255958qtk.345.1550078624205;
        Wed, 13 Feb 2019 09:23:44 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f019:3a5b:b662:7c1a:9012:e865])
        by smtp.gmail.com with ESMTPSA id s72sm5370917qka.10.2019.02.13.09.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:23:42 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id DA200180BCF; Wed, 13 Feb 2019 15:23:39 -0200 (-02)
Date:   Wed, 13 Feb 2019 15:23:39 -0200
From:   'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     David Miller <davem@davemloft.net>,
        "julien@arista.com" <julien@arista.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "vyasevich@gmail.com" <vyasevich@gmail.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Message-ID: <20190213172339.GJ13621@localhost.localdomain>
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <20190209.151217.175627323493244750.davem@davemloft.net>
 <20190210124616.GG13621@localhost.localdomain>
 <20190210201559.GE10665@localhost.localdomain>
 <71e3d64ae3d44e499f3fb9f876398ee4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e3d64ae3d44e499f3fb9f876398ee4@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:17:41PM +0000, David Laight wrote:
> From: Marcelo Ricardo Leitner
> > Sent: 10 February 2019 20:16
> ...
> > We have issues on read path too. 52ccb8e90c0a ("[SCTP]: Update
> > SCTP_PEER_ADDR_PARAMS socket option to the latest api draft.")
> > extended struct sctp_paddrparams and its getsockopt goes with:
> 
> The API shouldn't change like this at all.
> Is this from the RFC or elsewhere??

I would think so. That commit is from 2005, pretty close to initial
SCTP RFCs.

> 
> If the structure changes the socket option name and value
> should also change.

That's what is at the core of this thread.

  Marcelo

> 
> IMHO large chunks of the sctp rfc are just horrid.
> In particular all the places where is states that API functions are
> implemented using setsockopt() - that should be an implementation detail.
> Also ISTR that some of the structures are defined to have holes in them...
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
