Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDD6C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3CF20652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvSjL7V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3CF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeJOFz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 01:55:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeJOFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so19044549wrt.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uuSkmgNpNRy/8ZZzlausapLOLiKwDo2uos0jNxRHy7Q=;
        b=IvSjL7V2pPl3dHJFQOknf/JM+Shin+6WBtEdQgmE7R1Xe/kP7pO8a8PjS2XeHHYu+Y
         FOtvTyvjzAAMTPgqv8juBQjJXvGnl+10SlsJ25uvO1ZbDjuS2JN4kG5e634MIdJY48hE
         80o4Wr3ks21DWx2tEVXrLJcSKM5SB6nAfNSCZUQOqmlwR4V9Xf2NLAl0xTo0J78aCTKm
         JLJl0Hgw57hkl95uJ8WN33uas0vn1dzQzv9etNxadq137lvSwvKzw/nbeGaMg/HEQiGh
         i9dHU4Wv/MSyp375HkSN+9CywYI8xfA/JqgpjtnoUTyOGc29t2O5S3UjunWSWsHxZK9a
         8CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uuSkmgNpNRy/8ZZzlausapLOLiKwDo2uos0jNxRHy7Q=;
        b=Ds0wkSdrcmauE38qe9zGl2RHlUlzB0jWiF9lPw+UpVLsZNAgIJ4HH4LISCeV6j5aBG
         2z7iY2SigVjV73V0mjLSPB1eMM56vbLbBBgKQWMUbSPiBskByn8bFqW8uKonsmz/RT2B
         88AvvgjXKlgDhzQreCSd9MNoWbf4xgckVVxwZ8XkhvXCQNM0BhUvXpSp69UEgbej5WrS
         e5kofirg8XBn78Yx86B7w15atfT0sAM4GJ0ASmQ7VlnUxaFTE5QolsFFSaAPxRPm/THJ
         RxBEEdGTM3dlht2nRRKuPBD9QpXlUGTWwggFEprs0T5kmCvcs1MfsuzEiOhs81BMSpWW
         pFuQ==
X-Gm-Message-State: ABuFfojscIA9U9YHOY1CC1IfVsEISth3+GOPgTxDV8vrGAoDPhB9QGIJ
        bg0O3mFpemAYtug/KOTxLg==
X-Google-Smtp-Source: ACcGV61IKQ5a4V62Y/BuJUZM2oAQfBHqYSOJzF3Z3KA3bQQI4jTgiBKJoFWmdsh5FKuF7FDPLocC9Q==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr12426366wrq.200.1539555207824;
        Sun, 14 Oct 2018 15:13:27 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id e7-v6sm6778411wra.37.2018.10.14.15.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:27 -0700 (PDT)
Date:   Mon, 15 Oct 2018 01:13:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
Message-ID: <20181014221325.GA26685@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yecchh...  First of all, the cast back to unsigned long long is completely
> > pointless.  What's more,
> 
> Sorry, seriously asking: why?

In C everything is casted to the same type before doing an operation,
in this case comparison

> This was meant to handle the case where
> sizeof(unsigned long long) != sizeof(unsigned long) and I just looked at
> _kstrtoul() which does the same:

Second cast is unnecessary. I don't remember why I did 2 casts.
