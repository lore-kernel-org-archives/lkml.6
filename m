Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E2C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDB3251B7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6OutaI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDB3251B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbeFXQFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:05:49 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39065 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755670AbeFXPkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:40:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id p11-v6so7335980wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Tlhx+jhNsd0RBsBELMlPULZmT4qGGYJL/EwhoZ8PWw=;
        b=G6OutaI9N0/hUqJ0lhoIHv6fEfuP3eDzqmYkDLVuTqjJUCboFcmIMoFAiUZOgU9YnA
         RWsMQLnHitxYQfKgFSn0MIQK+uu5Qa9tFbtipKRETzG8c4R+rKWnh/Ak23GMvZrvj+YH
         i56NKWCBOTAs4+N0DTbv9S61oEMNlRQs5BK48zUkhAP/E+B1tclrt0jLQ6/huc/m2L8H
         14Z8WanseqXpKmmUpU3p3KvsR0rVgAn54YByDhSjX4e7jocGyfOpjatRlutYXoChc7c3
         g7vC1EbaEi4khwn39prij3JsiG5+5biT8ldOPGuvYAQhut59ANVMEXG0jwIWAbosh1ki
         ncEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Tlhx+jhNsd0RBsBELMlPULZmT4qGGYJL/EwhoZ8PWw=;
        b=IkAvgWnldK+ToCwOHlwaiLjgWbx1ZghkDAABLYPXlEo9Y3HE7VAB0Suw/Vf5Sax0Li
         tUQDjiQFgZOkTkPMPYUq7ouff8knCPsDjOwcHrG507RJkRVjWTkss3MBGW/KC6n5gMbf
         maARXcbtO3MNq5J3+vl/RCFvboR4+YuA0BFR8d4FzputufX4Sc35p28fsm7Y4ncSt9Vc
         6HjVAacq5nftPN//ay1q2xETuhDAP37sSJrco463T00605JqanqOqdKb0D0wC9eZLGAa
         xj3Q6Vo89Dz2ojYRDpXyEoRYyLiO3W+J0a41z87oxx+pN6Eb6TBiyZYTts5NBu3UwPbe
         ueiQ==
X-Gm-Message-State: APt69E3sxXosZjZNe6vptuR2egYlW8Lv55ffOmTfBaD0Ktmaw4gpVGV1
        XzFgodQJSr3Ef0gVKOZ78U8uzg==
X-Google-Smtp-Source: AAOMgpfhv3XMdOxQ6y96FowPEV4P9GdPM04COoBK2hHi71eUnwVw7dCOL57Nymo7Da2qXyfpXCWKIw==
X-Received: by 2002:a1c:c689:: with SMTP id w131-v6mr2065193wmf.8.1529854849766;
        Sun, 24 Jun 2018 08:40:49 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:40:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Subject: staging: rtl8192u: V3 Coding style changes. Plus one change to use memset()
Date:   Sun, 24 Jun 2018 16:40:19 +0100
Message-Id: <20180624154027.27654-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple coding style changes to single file
drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c

Given feedback on some of the comments, I truncated to the 80 character limit,
in code, (as opposed to function block comments). I have left a number of the
contentious comments as they are.

Another piece of feedback suggested using memset() instead of a loop to
initialise memory so I've added that change to the set.


