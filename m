Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /ZEsCtVaG1uCDQAAmS7hNA
	; Sat, 09 Jun 2018 04:43:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F230C6089E; Sat,  9 Jun 2018 04:43:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSeOJdtM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 45967606FA;
	Sat,  9 Jun 2018 04:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45967606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeFIEm4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 00:42:56 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:46780 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeFIEmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 00:42:55 -0400
Received: by mail-yw0-f171.google.com with SMTP id v197-v6so4769403ywc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 21:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eASkBmPH5hdZUbriJk3kSiWERBt/cj1J69mZMGdUyPk=;
        b=BSeOJdtMQqis/XdcMIoTB51Zqt41N2iLudpKZnLXQ04CjwbBS/kmwGwd249Bc97F73
         6whZmUCjowGyOWcSfEc1vK/nvOpAD7NfKLEcNxyf7TKsSmUswJykC+XFB2Yt+4PcPueF
         SRAax7Euuq4tukyAZSiTmfdxQjOf6vCSt8KBOBjIxmh04Di7KXCpZskYzn/jukDVjPrb
         pkI6aeRYzhWMZn9yOVQAtMy+5pJQe4MVcPCDDavRVcNUZz6dnljNQGsh4t90ka2u5Y9q
         glI4dxujH7yL6bvRVytOHb++5saSiUpOJqNvlmFzbnrevGIVqxRVyUQsKeafwX4Ue5SJ
         tagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eASkBmPH5hdZUbriJk3kSiWERBt/cj1J69mZMGdUyPk=;
        b=oP2Ld8+ScS7+fhRnuDuTF061DFldjpPH4qd/qMvsR6jkyrP57SdkKk6XVrhS268hM7
         gclkEBRyh+a78xzKhjizYLGIqqoTqcJwnawPHfV2BUwYiakol1e33x6W3JvyZ8IPEq6U
         FsLmMn8D9eyc297GgfsjpPFKGY/Z3EbPe2prh4p/9u3yUk7yUU/2Eqol2ePbFvlI2gBe
         B6L5s2zBlZ9r057yEIwDI0Xoz0AKDcqIBqZjYKTjLcs+2OgV+f4q6AIFy437J5Tl6VHS
         V31fI3vcQk3i+6A1tXfSQ/qW47R3F7pE3fk9tBuY7l4q2QJ83WPZ7NvRdVyHJ9MqM31t
         FSng==
X-Gm-Message-State: APt69E3yrI6hmSs1GiFSTux4xx7dn8Pt9GTqJblmFcHcLktNTy+6GY2M
        dogezc/ZZ+4lWIUDlwAPLPu8cSMITucFNXzd2Kk=
X-Google-Smtp-Source: ADUXVKKy8BwuNTFCcuaNokElQ2rq2THuA9/UPeglCaotP3Vi9dNsbQBofzx7r4MHB+Ev2yykq6tCna46Y7wjJ3AUkxQ=
X-Received: by 2002:a81:412:: with SMTP id 18-v6mr5140694ywe.430.1528519374379;
 Fri, 08 Jun 2018 21:42:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:5714:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 21:42:54 -0700 (PDT)
From: bengvald8080 <bengvald8080@gmail.com>
Date: Fri, 8 Jun 2018 21:42:54 -0700
Message-ID: <CAC9GqQ3CDhxC6Jf6iX7HkYYt92Hbpfd1x-EhuWMBWVBAeOh_gA@mail.gmail.com>
Subject: Self repairing Linux
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, my name is Beng. I'm new to Linux kernel development but
one of the things I've decided to do is research on how Linux can be
self repaired, like the Unbreakable Linux kernel Sun has.

For example, if someone does 'rm -rf /' as root, it should process the
command and fix itself. I know this can be done with ZFS or SWR5, but
the kernel should have something to facilitate the means of making
sure a Linux installation never breaks.

I think this is more of a distribution level suggestion, but I
strongly feel that Linux should be able to repair itself. In a time of
AI, Clouds, cheap storage, robots, and malicious exploits, nothing on
Linux should break

How I want this to be implemented is some sort of sanity check on
operations tied to AI or something. I've known C for ten years and I'm
just getting around to digging through kernels and reading books on
them.
