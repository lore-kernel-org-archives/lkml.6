Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF219C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE86B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7df3quO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfANCgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:36:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44229 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfANCge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:36:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so14493343lfe.11;
        Sun, 13 Jan 2019 18:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+q+rXMvogXdc6F7IN6IPRNFTF1TLIu1HY7R8susB90=;
        b=W7df3quOPPBJLnK9RguA1iI1FTGEgC0EInyBuuXQHXJg6Dc1vaUUoWsW0/mjR3r4cC
         a69ZFE4BNsoarblmC/9eI1N8KOsE9avHxb16mPLQCVuzvbqv0fjPekt4OW4hfl2RqftJ
         Uxho6Dw1SIiKye/usqecdvIUK2+h0utCaYSk1imun5xnvqQgA9jwyuBq59MKwCCb2P6L
         H7ruRsn/zJWiTNKqkp2tO81ShbIxcyKOOLKQ6PEB4Q2KMJk8o7Wml4rLdlT5GXd79DDj
         Ea5wkCi0OP78ph+vHeAeryTQm+npeDXZNn0Tt7/seRIIiJ+uUekfwfMBUNDCL8FVyz0x
         OZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+q+rXMvogXdc6F7IN6IPRNFTF1TLIu1HY7R8susB90=;
        b=rKmchuQW1lE/vf5EUvcM2mhR1P3ICA+mxEEoUYjGlWH9xfqzYpOvXXckq3MrEnFyLR
         pwKNjiQ7wxLVYAucFmONxi4QCMOgGS+I0TxdwM3fPZudh0amNK3iiR7hJ9RZWYeXcO1o
         4rzPbCc9iQO7XIYdG8y1YSObNseXScSXy/b3vYkQKKLOaADrWJSbirY7lRpuul6Anzrz
         B+WCasBRlruchI890iJdQKcrs/InzSozOD45UI6bWUNOejVk+MG6F8byutOUHQOu8mGd
         5nM+JVXB3hu4XyJCKZ9hTKmglkDGJSVGGuxH6ohHQ19gTF7iWo97j4mqk02vfCeO9ZGq
         s8lw==
X-Gm-Message-State: AJcUukfUzzLH5dN1HAf8X1bFy8I0XKFoFI4/Wiql1FgBVWr+cNSpC+S+
        a2HaGkdcUzyacfEZ2iHinuycpHPq4J0=
X-Google-Smtp-Source: ALg8bN4ZwSd9P+P4cNjsOzbwTaa4uUN2Pcwmlz+Ul1T7nmBXFY3aODni8RapBBlkj4OaL3aisfLOZA==
X-Received: by 2002:a19:f510:: with SMTP id j16mr4205968lfb.35.1547433392026;
        Sun, 13 Jan 2019 18:36:32 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id m4-v6sm16876897ljb.58.2019.01.13.18.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 18:36:31 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-watchdog@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 0/4] watchdog: hpwdt: Fix NMI-related behaviour when CONFIG_HPWDT_NMI_DECODING is enabled
Date:   Mon, 14 Jan 2019 07:36:13 +0500
Message-Id: <20190114023617.10656-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found out that hpwdt alters NMI behaviour unexpectedly if compiled
with enabled CONFIG_HPWDT_NMI_DECODING:

 * System starts to panic on any NMI with misleading message.
 * Watchdog provided by hpwdt is not working after such panic.

Here are the patches that should fix this.

This is an RFC patch series because I am not sure that patches are
correct. Questions:

 * Are "mynmi" flags always set on all supported iLO versions when iLO
   is the source of NMI?
 * Is it safe to reset "mynmi" flags to zero if code decides to not panic?

Ivan Mironov (4):
  watchdog: hpwdt: Don't disable watchdog on NMI
  watchdog: hpwdt: Don't panic on foreign NMI
  watchdog: hpwdt: Add more information into message
  watchdog: hpwdt: Make panic behaviour configurable

 drivers/watchdog/hpwdt.c | 45 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

-- 
2.20.1

