Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45004C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1127520844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="elREi04Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfBEKAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:00:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39659 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfBEKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:00:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so2346340ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kNxViFaZjqXl6dwlVUKHrkGlkaxyamxNLy9SH5a7C7M=;
        b=elREi04YNDy+lLicFNZBRkEr0+6rKyu/t57aKBaC6ORFnVYIuI+dvmj6gLJaIKxJ/A
         oWszjCttTyGbOPa6MXY4Bew2Pe1wc+ytgGILv0ZtQXup/2W+1cu8CzOaj7qFICdPSx/u
         BnXgALh8HTOBzVlSdxZVTqnt9G2ydQnjoDTjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kNxViFaZjqXl6dwlVUKHrkGlkaxyamxNLy9SH5a7C7M=;
        b=ZPiMPgKzYraN3btK7cDIDubEalA2gXcVyezNXqORzONc/l/08vl5DKhhsJ4WpxfqQT
         Nc7zJ0nayTANaaYrF/wTOq678cJg1XFBbKC6A/yK2tnFFbdFykRZAkWOVhSafc8AcHmB
         OY7ORl5RA5UhZaBQ5q4l/buMwcv93M0tIUrYZq8+If5mgCysidaQ+tRpV/fJzNMOh8wW
         F7kHGqaNFT2JQhbp0iyvfcjQy9NXIIMNe75oVRUgrbOYTH9gE9bk5IcWnEEknHeSMn7m
         aO4p+ztTaSTWN9Tuh2fvNY+eXCB9ZXJvnTABv2CeNzFkflH5aUyy7KD4A0vBQKzHmg2R
         ZLdg==
X-Gm-Message-State: AHQUAuY9CDV7O3r5UNvRnK8OhcQQKareigmmbF1EhMFL3OjhHtKF4A7z
        bME3WQVrKtYh8ogNXpQXDiNFkBwNCESqImmN
X-Google-Smtp-Source: AHgI3IbckGQgx0upS0P8G0urI3cMZNR/5fV4n6/U+O92E2xUNstzAipm8NX+XMV+LlWqvZEUdTD6gg==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr2417518ljb.153.1549360821616;
        Tue, 05 Feb 2019 02:00:21 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a18-v6sm3149309ljk.86.2019.02.05.02.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:00:21 -0800 (PST)
Subject: Re: [PATCH] xfs: allow disabling xfs tracepoints via Kconfig
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
 <20190204215332.GB14116@dastard>
 <4d66f2c2-bf5c-be47-9ef1-e581c5901823@rasmusvillemoes.dk>
 <20190204231346.GC14116@dastard>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8d36092f-adea-a025-380f-a97de6bc93e0@rasmusvillemoes.dk>
Date:   Tue, 5 Feb 2019 11:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204231346.GC14116@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 00.13, Dave Chinner wrote:
> On Mon, Feb 04, 2019 at 11:12:57PM +0100, Rasmus Villemoes wrote:
>> On 04/02/2019 22.53, Dave Chinner wrote:
>>> On Mon, Feb 04, 2019 at 10:20:35PM +0100, Rasmus Villemoes wrote:
>>>> linux/tracepoints.h allows individual subsystems to disable their
>>>> tracepoints. Add such a knob for xfs. Disabling XFS_TRACEPOINTS
>>>> reduces the resident size of xfs.ko by about a third, or ~350 KiB.
> 
> Do you have a specific need for this, or is it just "I noticed this,
> here's a patch"? 

A little of both, actually. I noticed it, did the patch for the kernel I
use on my laptop, and thought others might find it useful. But no, I
don't currently deal with any customer boards where it'd be relevant.

> If you need it and will use it, great, let's add
> it. But config options that don't ever get used tend to rot....

Fair enough, I'll just keep it privately and resend if I encounter a use
case in the wild.

Rasmus
