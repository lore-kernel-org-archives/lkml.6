Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D522133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="edYPBro5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbeLQN65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:58:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37492 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbeLQN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:58:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so12692265wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EFwU6j1ZKPA6YrvWcaC1xiIPl5gf0Ek5GTKWMai6D60=;
        b=edYPBro5ALtSxtXjLp8IE8ecA+k5QKCj7P+NO2GKYOAHnEbFxMVDOEmIKz1o+ecoCZ
         db4Xi256QAD8JpwBQWmNZe9MKzMXUOw/Ma6eVkkQPnV4+EYwH1qbNxBJKqmQ8C6BKB8O
         lUE/rVgCu8BL+6fkcs2ThVG9zj+/7OEXpU+5+A4dh1SzcclzBtaFrxrbsN4ehuY6t2/v
         vcUSDNO7c3QiTC9/BNJQyY5qUBNf5EmrjoWZFWs/OfiUVnAa1jr6K4vtdj/u9dvqqh9q
         P1RBJtaQ89fC4LxrUjbobPAEsqDvSJiIAuPiJW8i0UfjFvpdVpuZ+/G6ZXXgokYD53fb
         y0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFwU6j1ZKPA6YrvWcaC1xiIPl5gf0Ek5GTKWMai6D60=;
        b=gTt+cW4nKOym++aEIgf/nEkEx9Nrj4GsTFiaC0uJwalo5Pgq21U5NxB/qCfvkcITrS
         5+IDBNAlZnzbSh3i/+abjJCKfzwR9vl9AIQ3U2xdI0FHnWRhLRrJ8RxgbClD/jWKeizF
         uWMy3TPXIG6sxIOHQmWAcLLjPPVcvpN7eMZTaOc6CXaIVLHhuVD2MxJmoTNDlyFjS2c+
         P1ypCZ1QUKS+1kslF//vzAOqS9iw9I38El0IkNigylwsd16g6w54mZJpSiFFqX5k/8Gb
         BILf5nSQLBZNOpWNJq2HtMZmPpGkIpa+QGeJNkV/Z9jnc3aEz8chGKrJiRicQfpfzH3w
         RkAg==
X-Gm-Message-State: AA+aEWaF3SbYGsr7agLUf1wjsnLkjYBMEQYNweBWx4oypao4LUzpLuBS
        N2p3GIv/aC02JRGHisc5KlFLqw==
X-Google-Smtp-Source: AFSGD/XEnNzVk61rVpA3Fs7dvNin5vo6fFLvu+2JO/G6GFUZ1r8V9ePZwD6CEPOtSFnHcPRMZerGfQ==
X-Received: by 2002:a1c:8cd0:: with SMTP id o199mr11023930wmd.56.1545055135358;
        Mon, 17 Dec 2018 05:58:55 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id z206sm10726374wmc.18.2018.12.17.05.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 05:58:54 -0800 (PST)
Date:   Mon, 17 Dec 2018 14:51:19 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org
Subject: Re: [PATCH v5 0/6] net: lorawan: Add LoRaWAN soft MAC module
Message-ID: <20181217135119.GF2096@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216101858.9585-1-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Dec 16, 2018 at 11:18:53AM CET, starnight@g.ncu.edu.tw wrote:
>LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
>devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.
>
>LoRaWAN networks typically are laid out in a star-of-stars topology in
>which gateways relay messages between end-devices and a central network
>server at the backend.  Gateways are connected to the network server via
>standard IP connections while end-devices use single hop LoRa(TM) or FSK
>communication to one or many gateways.
>
>A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
>optional features (Class B, Class C ...):
>* Bi-directional end-devices (Class A)
>* Bi-directional end-devices with scheduled receive slots (Class B)
>* Bi-directional end-devices with maximal receive slots (Class C)
>
>This patch set add LoRaWAN class module implementing the stack,
>especially the soft MAC, between socket APIs and LoRa device drivers.
>
>socket APIs:
>send and receive the data
>------------------------------------------------------------------------
>LoRaWAN class module implements soft MAC:
>append the header/footer, encryption/decryption, timing slot and MAC
>commands
>------------------------------------------------------------------------
>LoRa device drivers:
>send and receive the messages for MAC layer
>------------------------------------------------------------------------
>LoRa devices
>
>This module starts from simple and implements partial Class A
>end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
>More features and complexity, for example regional parameters, confirmed
>data messages, join request/accept messages for Over-The-Air Activation,
>MAC commands ... will be added in the future.

Could you please send new patchset versions as separate patchsets? It is
messy to have all versions in one thread. Also, please send it so the
patches are in-reply-to the cover letter (git-send-email default).

Thanks!
