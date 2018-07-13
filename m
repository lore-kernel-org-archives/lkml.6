Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0ECECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0865E2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpYoNiO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0865E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbeGMU3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:33 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44066 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbeGMU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:33 -0400
Received: by mail-wr1-f50.google.com with SMTP id r16-v6so26220596wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=474KL06yGymns7gBGUCCQG+ZM44l5lM6Zi0DVb8rY74=;
        b=KpYoNiO5HE/o4PsFK1r/FvR6hd1P1s08Y87ZTFTTgw6wgGZnzKpONe7ZW7/BzakmXR
         5Kjk4fpBZsA/NwPgC51falNB+5T6WjRVyFPSLCk4YpBXeW1aYw9yYE0dKNTlQg3vXzTa
         wRfgD2hAf7s/AJ+O75HpPFrgdVKd1lRc/HuH6gG4l0bWt7YRzz1/C0FN2aiX9oAmtQUH
         p0L6ztN/5q+E6qANJaQBvBsTgHWwckiNO/KONa80j6OZ4/6s1BSIbfjDmskoJUw0pAEv
         83PjdNixWAQyjvi9CKIVa/ARlz9JfZD3C5dCzfWEfPhxgylw8HDXCxWEnZ0hFt0nx6cS
         Nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=474KL06yGymns7gBGUCCQG+ZM44l5lM6Zi0DVb8rY74=;
        b=OjoJxfHLm414/Oh0e8CBFtoknT9qXVe8O622PGdLeo7d/qCqNFxvXciy83K9u2hrl1
         TXgNECOJG7TjtHMb5c2gXp6RHgT6+cUdzGFJzp3zyBXBtCLzAeReAPWdvgQ8l7yYdpDa
         4acOL7r1Ej9QrbOacijzJiVy/UK935/pN9OrZwil+V9fae3lY4vpMnbVbsC15NnYiBcN
         cGoTDUESpo8TvBMUomz/KyQNz8rB6zqQBhn2V7dvyv2XAJxEOXZlnyNSF4/w+9s32gMR
         BRYwwlMaaMrawcn81Bv2HFCx0oCd5/4AgIUZduhyD/sxeN2Zew675g/viVIAZ5RIIUqh
         4HiA==
X-Gm-Message-State: AOUpUlFB5oVFX331LcZ1IoRTVJw6eLfBhbJhNB4UVHiwX0Jnj36qkBtW
        sDSNWvaE1Ub/W9RXGVpnHxdBH+hp
X-Google-Smtp-Source: AAOMgpfiwuAdpM6c7UsL6zQSwSUO6Zxmt14XL66WmfNsphNFGPZXX6YQtY68x8Ql3IuLV8FgANPQ4w==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr6474549wrb.155.1531512804249;
        Fri, 13 Jul 2018 13:13:24 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Subject: staging:rtl8192u: [0/10] Coding style changes.
Date:   Fri, 13 Jul 2018 21:12:37 +0100
Message-Id: <20180713201247.21428-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All coding style changes, but the second [2/10] is a bit more hairy then
most. The original code combined two typedef declarations into one with both
the structure and a pointer to the structure defined. I've totally removed the
pointer to the structure type since it uses Hungarian notation, which the
coding standard isn't keen on.

As a result of this there are changes in code from the type:
PStructType  *ppname;
to:
struct StructType **ppname;

To keep the diff simple I've kept the current nameing of "ppname", which again
is Hungarian notation. I'll leave that for a future patch.

jwhitmore


