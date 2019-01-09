Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8382220821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYhxc1TY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfAIJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:16:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40808 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfAIJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:16:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so6666121edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bc6a4HpXtr7mjsAnMzmFEfuxMmkNQBQjanGntRB7A8M=;
        b=ZYhxc1TYS2eokPErR7IGcN8OAmP0Bg2z+i3SKcjxbXmuXoRnf9gtBmLdbxO4qkuAuh
         BUrWihThhROhZYqS6YpmTO/FoWIawtP1SRmMmus/VpihSRkZ6kdK+H1N4cuCoU0yuSIu
         si44hMZp09HNtaT5KAR2uE7AxKqn1D+3Yshy84Ls9Orc/XJCxMLTosevnxAt4/EWOBfc
         Z5lYwMtHPndR9LioNBEtGOHra9lVqo0/H4+BfCkHKTcTl822ql+38TyRTqz9Cdiewxv7
         jhyh2IilW8vbArKowE5hgnK1sIBH80Slj78l77EgoXR8pDkQ2i2sbLYISGJkjmS+ZVOm
         IsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bc6a4HpXtr7mjsAnMzmFEfuxMmkNQBQjanGntRB7A8M=;
        b=mbpuaZPntr3vwl4JmYpYIf14pOKGwKGcEyBDAvCBpKoCSxhjfvxmLu4g6mzEx4t+nH
         biR5IHcF7/YuMO+PfhbUuqaPm9f/R5EpfurHTP7du6RWwPDADJZfaJuq94stInOvipcM
         FxWDtYCRxjWKatBJfoKk0kquA72QmEhpJi+5ypHtUE6xkA11FlUjjwWagzPXZCpXZFv2
         z4Y3pRXHnOJ2O240wtbw+iDB1kEXr9BuApxbSdPorvQRFHziO/TkBo/3J1BFS8gdYhVc
         ZU5vdLpSz5pnlFjT40L8n9qDFYIawawP9PSQht5Yj+ACHsZs4kYyhEsUv0VoITzvYT62
         FJTQ==
X-Gm-Message-State: AJcUukdW4s07z3QMH/rM77SDB4ggCPZGk5O7JhgNRanlyPeSTaHrOxaU
        fLgI0FTdY4tX7HYPwBNctLs=
X-Google-Smtp-Source: ALg8bN5UKXXrgfnKmftoFQIV9OtSTzHG+pe/NNQ4K7vAyIZdPPP5IdfOtP8+e931q2LBkuIhzyL8LQ==
X-Received: by 2002:a17:906:25d7:: with SMTP id n23-v6mr4718716ejb.242.1547025407351;
        Wed, 09 Jan 2019 01:16:47 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id g37sm973012edb.85.2019.01.09.01.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:16:46 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH V5 0/2] kobject: fix code style and drop newline
Date:   Wed,  9 Jan 2019 04:16:38 -0500
Message-Id: <cover.1547024167.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some mirror changes in kobject_uevent.c.

Btw, this is v5 for the patchset.2/2 was fixed by v1-v4,but 1/2 was marked
V2 :(.

Bo YU (2):
  kobject: to repalce printk with pr_* style
  kobject: drop newline from msg string

 lib/kobject_uevent.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--
2.11.0

