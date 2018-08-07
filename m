Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C8FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175F82170D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtTZfBDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175F82170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeHGX3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37302 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGX3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so74211wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j1ruvQbVhdJFi9lV+SVmsPf1G9L+ASQaS/p3Ir0CgpA=;
        b=ZtTZfBDt3doTo+B47sQV9A7X8kIUrbKoOoMizl/IdNryXmw02p3Jur1gwZZqeEx9gj
         a0xFBWCjdJWTlTpwAbL3SuRqMuYdsYxYf0tqOekRqI9xsfZxdnHUBVrfSvnjeeAJMTWw
         0OgCEeJEoF3bzEWU7PdTP969nuyzTuxoMWLyp8+T4S8kkgd+KZZFDe/lg36EemzjVqii
         fHl4iK7/aIa42IZdKj6TeHoThjUsvtllxGLi9RCUMzxAP29D49CUfdvvTvSWygn6jurV
         uARlPSrrrsHfPe47NyXtlg9vUS4sIzF6itHsKyRsUTiYA54n0jc39kJL3BjNhhtQPJ0E
         EqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j1ruvQbVhdJFi9lV+SVmsPf1G9L+ASQaS/p3Ir0CgpA=;
        b=BPToaO89kNWURk3s7a9Px64OI3xgMTLuUZyj8XVB78VmuifxoARP9y274aFyRBku5Z
         pIr1W7peoppMEiBhVB7zTGI46stNLOTFHHv9HkTBwPIphk1lrGXnV2HFKj7c1PxbuA31
         l1YihViEEW0KhVdb8tfJVA0EvmABPGfAt+x9alQyZdflkYy2wdYKva6J78525uzZHCqO
         Y7GZ3r0jnJiKAdJPwB7Bo32Kh/bnn2gaFtjwcEmbyy64KO5RRoflt/zLy+6fLryLut4H
         tWuBJcls/WFt/Z/EPFdy86i1cnAexiOMgWiQfZlgPAn5HxYYLDbDcK6vQrs7VnU+uI8a
         ZyAg==
X-Gm-Message-State: AOUpUlGAUktXaVXowHtgoDu8kp91NTnNVqojrPUtbh5t/vf8muptdxg4
        oNl2CMhbXWUUcNSdO+bn7rGVMF9b
X-Google-Smtp-Source: AA+uWPxxWx0GPEgHeYgwDYm1lOq9vs+WyNXKmhu3vD45qplUeSKMkpSuCl+3Hurf6YJPf2X0RwW5Xw==
X-Received: by 2002:adf:b642:: with SMTP id i2-v6mr63496wre.54.1533676380055;
        Tue, 07 Aug 2018 14:13:00 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:12:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/17] staging:rtl8192u: Coding style changes
Date:   Tue,  7 Aug 2018 22:12:38 +0100
Message-Id: <20180807211255.29343-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a number of simple coding style changes.

There are a number of patches which rename symbols which are
exported with EXPORT_SYMBOL. This may be a problem, as code
using those symbols will have to be changed accordingly.

John Whitmore (17):
  staging:rtl8192u: Remove stale comment - Style
  staging:rtl8192u: Add spaces around '+' operator - Style
  staging:rtl8192u: Remove unused macro definitions - Style
  staging:rtl8192u: Rename eqMacAddr macro - Style
  staging:rtl8192u: Rename cpMacAddr Macro - Style
  staging:rtl8192u: Rename macro parameter __pIeeeDev - Style
  staging:rtl8192u: Rename __pTa - Style
  staging:rtl8192u: Lines should not end with a '(' - Style
  staging:rtl8192u: Rename Dot11d_Init - Style
  staging:rtl8192u: Rename Dot11d_Reset - Style
  staging:rtl8192u: Rename Dot11d_UpdateCountryIe - Style
  staging:rtl8192u: Rename dot11d_update_country_ie() parameters - Style
  staging:rtl8192u: Rename DOT11D_GetMaxTxPwrInDbm -  Style
  staging:rtl8192u: Rename Channel - Style
  staging:rtl8192u: Rename DOT11D_ScanComplete - Style
  staging:rtl8192u: Rename IsLegalChannel - Style
  staging:rtl8192u: Rename ToLegalChannel - Style

 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 42 +++++-----
 drivers/staging/rtl8192u/ieee80211/dot11d.h   | 81 +++++--------------
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 10 +--
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  6 +-
 drivers/staging/rtl8192u/r8192U_core.c        | 10 +--
 drivers/staging/rtl8192u/r819xU_phy.c         |  2 +-
 6 files changed, 57 insertions(+), 94 deletions(-)

-- 
2.18.0

