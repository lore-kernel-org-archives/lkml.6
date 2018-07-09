Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE0AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BDD208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kent-edu.20150623.gappssmtp.com header.i=@kent-edu.20150623.gappssmtp.com header.b="EO65qttr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BDD208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeGIXEu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:04:50 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36990 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932824AbeGIXEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:04:47 -0400
Received: by mail-oi0-f43.google.com with SMTP id k81-v6so39062209oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kent-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=94U35/x1+jS5/4kBhWySM4XkspkdJ/5KvHp4+qxVdQo=;
        b=EO65qttrncyuT+uhGgCcAsjcjKbYpur8IB+FxQXhE2kRARZYKf+wP0TBkjuPWT3VRM
         PhCtvYD+8YrRwlawLf0KvcUpZKCjCRF8qXfshsg4CbIfMWfXF1gb6NK6Bf099URmqHZn
         bXX/yn7UwxpE4n4Nh1h4EZ+o3DOsjmB/oNi4UwYlnNCR5m2hfv1OuyIk0c5vFR7Iht3J
         cJONwx8Av/QzTeeAcTSNMf58T32iccuFeU9K43+zk3eyCVAby9RqbJdZ37/DdTgn1txD
         oLYUU5QxZgd2mivfiSit9QfvVJG6dmqQ1Q3ERLf4htT4HzSSKl2UJOopGd6xHKlS+Haz
         YpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=94U35/x1+jS5/4kBhWySM4XkspkdJ/5KvHp4+qxVdQo=;
        b=dSWd4DpmRKDclPtaPG0epnMvcIJh3/VN+WhTzZ+sHc+oRSNyIeaSyg8HqT4sBbnNHM
         IlBvPRH5ENy+0wWSJQ3C/bI8OZchbNxGLlfOCkaXPVD5h1nOgHmBIj2Hlk5crDdb5L2I
         K0JTnBwpJgxegpsO8Z9+gjI664h2eV7dSI9BK/5rPS3l3SrbRQpYLYIRHD/wTN2V4mtU
         DJA2O1UU/XLBm5mhxbj+DK1aiXYmGKupQVbhEyXajHNySJMS8kDHhAeUt6yzf38ITB+j
         0iPGx922J6OpnfOeu37BfGXQx5hpHR6UoCK8BCxu9HxxQfYEDRnibBFHdU38gFRgLJqc
         Afcg==
X-Gm-Message-State: APt69E13FXp91fhtwfS7aWw3HN/9XRyn/Q/IjF5HIbsu0JQQWE9Jn0jF
        4StZpb/jVn1qkp7LVgbqCCCvU3ubIsVeRsSWlH6Y1IFE
X-Google-Smtp-Source: AAOMgpc79VxOJK3VxFrphRvW1X9yQNYmHQBGJnETBSof9XM5R6juAJDF/lswJ3cUfr4b+aLQoTy2szZmXD0vftOS53Y=
X-Received: by 2002:aca:6a86:: with SMTP id f128-v6mr23714072oic.330.1531177486602;
 Mon, 09 Jul 2018 16:04:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ce2:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 16:04:46 -0700 (PDT)
From:   "Md. Islam" <mislam4@kent.edu>
Date:   Mon, 9 Jul 2018 19:04:46 -0400
Message-ID: <CAFgPn1Dfen9u6ebs0ke3eZ3D0jREzRa3OY0tKRasyRMQbhjTqw@mail.gmail.com>
Subject: [patch] printk format for u16
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 361789d..955866c 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -14,6 +14,7 @@ Integer types
     If variable is of Type,        use printk format specifier:
     ------------------------------------------------------------
         int            %d or %x
+        unsigned short        %hu or %hx
         unsigned int        %u or %x
         long            %ld or %lx
         unsigned long        %lu or %lx
@@ -22,6 +23,7 @@ Integer types
         size_t            %zu or %zx
         ssize_t            %zd or %zx
         s32            %d or %x
+        u16            %hu or %hx
         u32            %u or %x
         s64            %lld or %llx
         u64            %llu or %llx


Thanks
Tamim
