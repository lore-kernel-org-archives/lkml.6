Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6215DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AE72150F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YABYxVoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AE72150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeI1HxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:53:15 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:38268 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1HxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:53:15 -0400
Received: by mail-qk1-f182.google.com with SMTP id 204-v6so2226950qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 18:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oJr5DWtLiVafdfUCbmNJXu4KOoHAWBrDblqNsTLuAHg=;
        b=YABYxVoaX/AdJ89zgsKrIzShtbMXlI53cZLYxOrSsQGthdem2SXNykeOMMccrC0//D
         E8IxJW37BB0yvlkPcalZoHwHjqZIdrIlN7it8RGEWSdqsE+mo4CZYe6mrRGd+2ffHfDn
         EnrgDemWILXQkbgowWS/vx17Z5qcGDedFWZaDk64hwwObjST55g/agu8TygRIpxHI+Tn
         NqKsiRiRJLIep4qrEQyH2fDcZtW4fIMCqKUkd/DUx5MSL4HQ84EnpOYjfeZK8FK9rK+1
         J4Dd8fS9WcI4JbL5mNVuje56y44VwQKHRrD9sbEZN4+7vqBIHjrqBawi48gMwEwRu8iq
         DCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oJr5DWtLiVafdfUCbmNJXu4KOoHAWBrDblqNsTLuAHg=;
        b=E7qfxTtW3MDE/+cGWzRGhKWg68NjrMFw2276rG3dpktThPf7lHhdYf4EhJo9a29k2y
         SEu+IG0Igsxt2fWhQJcTrIYETUo0tBl6avs9UXkxwUNhgPXnL4y9LhCRG1XS5Vg4Ptwy
         t/I9xep6rNjqau3bc5RYaN+VZVPDLOEVlB4J5yIw4P6925V7WdyXWjNgcOkS9gm1io+W
         U41kheu31LsnP8/8FzgVnazN6HT3PK7neBHr+MkeCKyusGdgabY1nF7Acn5ngVVOFd4P
         r5a2bI9f9qriN0rcs5RlFCK2oE9Y/fAQhwc5DwbGg0bizs/E5BuD5t876e4ebI6SeHPV
         dsMw==
X-Gm-Message-State: ABuFfogPb2Yl1fQwHa5d+n6igNi+YdnnEPNl3p2MpERFidwvTQbsTPSs
        aZcTYu1uSw95zK81cJxPSUP1N2Be
X-Google-Smtp-Source: ACcGV60ZHGm0gSomMl8YThk/PgXLc04kYvVtwSxQqL8uJh/icDt7QM86dea0k4NxebZnB32C5TSfhA==
X-Received: by 2002:a37:8984:: with SMTP id l126-v6mr9987480qkd.195.1538098326013;
        Thu, 27 Sep 2018 18:32:06 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id r82-v6sm3124378qkh.28.2018.09.27.18.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:32:05 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:32:00 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] drivers: oprofile: Avoids building driver from
 direct make command
Message-ID: <20180928013200.GA8272@WindFlash>
References: <20180927014138.GA8988@WindFlash>
 <5236278.7dVKUIXYaR@daneel.sf-tec.de>
 <CADvQ+rFPiaGKLyzfSx4DmTnmgG15=Jk0RVy8xuYYyvLPJfDdkA@mail.gmail.com>
 <136913b41707c8556fb5d41969d2080e@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <136913b41707c8556fb5d41969d2080e@sf-tec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eike,

> No, that's fine. But it means it has to have one LF after "tree.". It had
> none, now it hat 2.
> 
> Eike

Oh, i haven't noticed. Sorry for the trouble.

Thanks for the feedback!

Leonardo Brás
