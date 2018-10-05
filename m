Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3FF21470
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWiwGQEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3FF21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJEWDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:03:01 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:43937 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:03:01 -0400
Received: by mail-qk1-f174.google.com with SMTP id 12-v6so1234576qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d/1jJCRhrSnYN5wFdGimdEbefd0E/+8c2ClagRjpx94=;
        b=dWiwGQEYYKZq6bTxiYRj1iY/o+hI044Bd34LtJwcYY3ZZ+GwDriXtEBic8Sn8C7q7k
         vghI89wA4sywTtAjhFS9edziTwonFLQSEle04vBMeRf8VFvHloZs3JuBHzl5byVH/63t
         WIp8qF5UEBp4AmZ3laiexdhS10cE8mZ4Jys431Gt+urWPdn9CK10cmC8lCn2eRHu7+wq
         0W5KqizxmbW/jz5ZPY5YSBNvUI70ABkHCogBjtwWry2saQ/+qwnrCXiz1o4PoRC4DJus
         a+bNzi7vFRwbFOl+diO83LqZjriktwryoKBZ/1CCmAGIMtVRuw2S15+XRjxkgTiaEx3P
         Ka3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d/1jJCRhrSnYN5wFdGimdEbefd0E/+8c2ClagRjpx94=;
        b=fXbggJtenPDAIiZ6BYRxmd+UBwtJKBvmfJC40rm+ezmqaz2X+6bpUYTSMaTA3qFKsp
         7hsXgvAKjQ4vmXB7mdNnbOFjtjAK3mPaUXR4NhwpID4ZI+Wba1DeHQ7m1OEUwbzZsqaZ
         tenSDiWJP8TkMb2Oag9uJ8OxTdmHIcVH7hN0XP0aA9RhxEvpZH4kP2tXj3RX+6N0Jwcj
         QVUL2tlV3VatgoIcvD+3eop462gljxDjBcw+LNgYhWqmFNR3JpekqObaRBEpGBvlZ0Zv
         vDubKIdPeVZwM/Jw1vTBGSEGF5SdUL3B9Nmzyai1guJqvK0yUeVebttRgr0no2/KqeY0
         Yrng==
X-Gm-Message-State: ABuFfogJJK5tRy4cKYXfj9OY7XdsVfUQ745SnayRMpqQrIgcoWvxAPEL
        9okGugIG2J7ZKCGW8WeRcLYqC/oI6aO3APrLKxwrbkBZ
X-Google-Smtp-Source: ACcGV61DSsqaH/nzvCkVBb1/SkCfULyWfDFR65UwnjKmRvZuPjLfrpkul1juAxpC3iBkp9fJGq/S5f1x8Dht4MSNFRY=
X-Received: by 2002:ae9:eb05:: with SMTP id b5-v6mr9533575qkg.127.1538751835340;
 Fri, 05 Oct 2018 08:03:55 -0700 (PDT)
MIME-Version: 1.0
From:   salil GK <gksalil@gmail.com>
Date:   Fri, 5 Oct 2018 20:33:44 +0530
Message-ID: <CAPACB-zt0up1fut3LDF8K4oZJ=8V3HgRVRxZueW0zzwo9wfaHg@mail.gmail.com>
Subject: Query regarding CVE-2018-5391
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

   I was looking for the fix for CVE-2018-5391. I can see the commit
c30f1fc041b74ecdb072dd44f858750414b8b19f.
   Wondering when will it be available in stable kernel ? will it be
available in 4.18.x ?

Thank
~S
