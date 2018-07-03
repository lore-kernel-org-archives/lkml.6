Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979FFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4964B23ECE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5pVes8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4964B23ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeGCQUG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:20:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50537 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeGCQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:20:04 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so3938410itg.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bTGYgHsfAMfrLxkiCz8Z/5ru5MDag3LSI1vx3ToKAdM=;
        b=m5pVes8bH9R/Cc0weRST3oII8olmVdQ7fiswGDx0d9batX1cL78XmaAPM6nE1maetR
         iGif/GBxa/Hd5RqY22CG795+VUIjHy3xsF8gueMLRRhtUAlSIfg1CKK0Xy6S8SCzdR5+
         FFo1guQ5NI/rNC7fMQ9C9KG/uRwAEfXONfGYpblKc1x36MKwCVOuGXuFFh4i5PIpGqvH
         Gv+NM1bgzo4w4JsqTeMZFURQ9DD6XyYiYsL0zA1GWnqQF90uM48Vhn9NYRdBeO4t2pNR
         ZEgdNWIg2YqwniKx9HcWSorLurXRTBNylLyLUTD/IUs9Hl7ffSh3wgv5xFWA9qLWmxpR
         cymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bTGYgHsfAMfrLxkiCz8Z/5ru5MDag3LSI1vx3ToKAdM=;
        b=jCwljUNRZBmlP51c0/nY1hVRCIuVEfDmGBQeG4bRmPW5a16ohK7BCpFdKDPEaq/6KF
         zZrbvATrM3m5dzqWi0PQm7EVZqPJwOXVhvovocB+0NfHeGFfNFXRbZbIevIuxo+83Hw9
         3MGsJwP7g8g0iXlrbWSjtj4Xz4nilmziDMs0nARBzrp5od4OZcUjsmsyROvzlQcR9TmL
         t91aLG1cK5hrTXmVo5xpXoKaqd+q5WbfKiqECSt2twumMeHoPoCTif4SxnbNXEiYgCdj
         BcCdvpz+gfDSv6ULfYFwFvEbxTzffBc/bbyI4tUAUKltNrUfut0zViR78HhI9FK3Ra30
         Kp3w==
X-Gm-Message-State: APt69E1eyqiuOymvj6HYN3bpLF2u2McR7snz/fmo3AxcjnYMqe2b2Anf
        rUe/FC16dzods1dJ5cOVV/GWAVQOL4rMhOUYBNpfoA==
X-Google-Smtp-Source: AAOMgpedusWtI7F4Xav0RfBDSUHniFvyC7pBfUrJpUiSg1TQqC1i54dRzGLqyAfNpvl/TrLs5PEIhcAUXrGAkHktSHg=
X-Received: by 2002:a02:4442:: with SMTP id o63-v6mr25471489jaa.75.1530634803436;
 Tue, 03 Jul 2018 09:20:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 09:20:02 -0700 (PDT)
In-Reply-To: <ebf6c7fb-fec3-6a26-544f-710ed193c154@suse.cz>
References: <69eb77f7-c8cc-fdee-b44f-ad7e522b8467@gmail.com> <ebf6c7fb-fec3-6a26-544f-710ed193c154@suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 3 Jul 2018 09:20:02 -0700
Message-ID: <CAKOZuev9K0EMpqBoie4H7XduB63KayORxO=JEZvS9rv_4PVsqQ@mail.gmail.com>
Subject: Re: [REGRESSION] "Locked" and "Pss" in /proc/*/smaps are the same
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Lindroth <thomas.lindroth@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:36 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> +CC
>
> On 07/01/2018 08:31 PM, Thomas Lindroth wrote:
>> While looking around in /proc on my v4.14.52 system I noticed that
>> all processes got a lot of "Locked" memory in /proc/*/smaps. A lot
>> more memory than a regular user can usually lock with mlock().
>>
>> commit 493b0e9d945fa9dfe96be93ae41b4ca4b6fdb317 (v4.14-rc1) seems
>> to have changed the behavior of "Locked".

Thanks for fixing that. I submitted a patch [1] for this bug and some
others a while ago, but the patch didn't make it into the tree because
or wasn't split up correctly or something, and I had to do other work.

[1] https://marc.info/?l=linux-mm&m=151927723128134&w=2
