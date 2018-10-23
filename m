Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17BCC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C4620652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYYo5xcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C4620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJWJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:34:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40551 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:34:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id z9-v6so8480321qto.7;
        Mon, 22 Oct 2018 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=nwrxgX3lNu2TKShW1CrJs6kp/ovq+BHPlDc2ztaN5AI=;
        b=MYYo5xcXVL7cABSJ2WHv+pInsUOnmwT6tgk7V6m6gP4dHrxGIpzdnm16s0BrJyuz32
         ekX5OZ4tw9wd44ttK0nR7xit2SIL3gwbKfkoXntE4ErGP0yO4pNH8NFbiYJY4hFSUzWK
         KbTf5RN+o9kyOQuFJksjM8SA9Rc4jLD29d20w0RMUpqwTNYpk06ToJRny7XMEInzdNrA
         G4XpAMqKc9dFX1h/xk3IGHvi0rW47/hBQ3w9ts90kuhqa16IDm/9YAxefuJrza4w2lTW
         4cGMMSdPEcwKv0WIctQIBAXE/SUoKEq+V63VV0dCBajEdMqBWSxU/BOTwHSIQ4Ju/ePa
         CluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=nwrxgX3lNu2TKShW1CrJs6kp/ovq+BHPlDc2ztaN5AI=;
        b=hKMDhypLiRHOWlglUKrawx8Ojbe3nc9GgTCFNZ8x81MvQIu4EyWNZYPYFr4eJJK+J1
         qBb6TWahZpNZBaRX0u5JHIPEw+Y9DvYgyBLszVB6UjhJRBR+/CoIPoHpO4kuvygfZcG5
         HbCc6TTROIjOi+750ahWgs3aofYYmKQ2TIDAvIMSHAyzBqJJSg3UtoJjlf+/QOb0jdfY
         eA4GY/fQ4VP23N0ZWz6OaDKGVsppP/2XyuJ7Ic9Dktj3gWL/qBL6y9zLIb8k9/6rUH3e
         2ODoSveIWms5L2G2RbU2FOJNsHl31nibdeS4xCA/gWg4a1oKMkJsYeYW3vfXU9FndB3H
         BwBA==
X-Gm-Message-State: ABuFfohINQdzmV41z7TcnJOpOCls4TFPhaxfZDQVIwEksPr7mOe4JxUt
        v2W6q5wQf8mQ2kDGrr82hsw=
X-Google-Smtp-Source: ACcGV63QKt4tgWiflb5QJI/xZRuRy+RivK25ULiLKl5AcZNALY5iCV6s63OIb9mS5fLRgPOh6blYmA==
X-Received: by 2002:aed:2f01:: with SMTP id l1-v6mr45397580qtd.71.1540257230860;
        Mon, 22 Oct 2018 18:13:50 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id j6-v6sm22856111qtb.25.2018.10.22.18.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:13:50 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:13:44 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Adds -Wshadow on KBUILD_HOSTCFLAGS
Message-ID: <20181023011344.GA6836@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
1- Makefile change is the last, so there is no extra warnings on building 
   intermediate commits. 
2- Replaced -Wshadow=local with -Wshadow 
3- Created macro to accept variable name instead of changing logic in 
   file2alias.c
4- Drops if/else logic change in asn1_compiler.c
5- Renames variables to meaningful names in vdso2c.h

- The previous logic in file2alias.c will be available on a separated patch

Leonardo Brás (5):
  x86/vdso: Renames variable to fix shadow warning.
  kbuild: Removes unnecessary shadowed local variable.
  Creates macro to avoid variable shadowing
  modpost: Changes parameter name to avoid shadowing.
  Adds -Wshadow on KBUILD_HOSTCFLAGS

 Makefile                     |  2 +-
 arch/x86/entry/vdso/vdso2c.h | 13 +++++++------
 scripts/asn1_compiler.c      |  2 +-
 scripts/mod/file2alias.c     | 24 +++++++++++++++++-------
 scripts/mod/modpost.c        |  4 ++--
 5 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.19.1

