Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B6FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6631F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB0GM/iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6631F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLAIHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:07:02 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:37966 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:07:02 -0500
Received: by mail-io1-f47.google.com with SMTP id l14so5649235ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7PNOAxzGuPUteNtvJ+Slp/LJu+iTTDGfXHQZU2b4svE=;
        b=fB0GM/iLu5pYooMByQEftP+btVQ+io696y62oKGQRZwrpqMkUS7Bq/zxx6iGHdVW+8
         wTW+idXHNWE0hCVLvs7hHQWbrgHSysXkaxtwj0BhQ4W8NhFtx6Q34nC+6u+GHiKS8Lc9
         g1Wfnbg2eYYYMYn7CRvZ4Se/k2jSN6msAiGSVgmz3CTFVkGY64dCguJPNfdUKDB+Ajz/
         OhT5Cbubnvul4sqOK4pTbwJHGZIj2E0S6Kgc99OOp7yAXwgKIDWJtLuIfDpX3GoyVM/c
         w0KW30aWf6hJS0KP5ziasdMu8KRCHx16QJl3dPpYVxxoga1nRwimsY3zVYlAK+G0k9zw
         qq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7PNOAxzGuPUteNtvJ+Slp/LJu+iTTDGfXHQZU2b4svE=;
        b=VxJIGN7FL1xdZ3cuGVOZfxKiDddOkMK256b42sT/tHC/go7eZgFOxbYNDO3O/H2oqs
         C4dpt4kTezo7ZIs3v5y1dcZFK/RzPy23P4bI/epXXzVlZZzicvQMk+24nKBJdZBRLhyU
         imoqzr8z3oIuzE0m4uG0B5DJ2ygqXRo1WkVO0aqzr1ZTgp1383jnNPGjEoIC8aF0PVdo
         4IM20afGbuNi48A8s1OUXqsDoAUCLMuJOtEYixzonbE7l9WUWEReh5J1mYcuihue2h6a
         2mRq0Tb4ZGBWjQfgKy+bX6rpRhFT4NfFsKQmg0XHPX9XyCBeGx+HcVJp5ZPX/UkwqERz
         +FEA==
X-Gm-Message-State: AA+aEWaeFkVRM0JK5ZUpkZnib0MEILEtlJmBTkWpUd9Gnl2tsmcUCnup
        2ja21olfX0/9Yjb4q/YMtOU=
X-Google-Smtp-Source: AFSGD/X2/8hW6/UGQnYSqYu9CJ1EVJjsZZGhXA6Slbe8ZmeQfHFUxwgv/1nBZ9juVjUyViJ3L31O9A==
X-Received: by 2002:a6b:770c:: with SMTP id n12mr6003298iom.88.1543611389118;
        Fri, 30 Nov 2018 12:56:29 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id p198sm126967itb.30.2018.11.30.12.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:56:28 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] bus: imx-weim
Date:   Fri, 30 Nov 2018 15:56:22 -0500
Message-Id: <20181130205624.16227-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@googlemail.com>

Support multiple address ranges per child node on imx-weim.
While we're at it, insert some code which guards against common config
conflicts.

v2:
	corrected acme@... in commit message example

Sven Van Asbroeck (2):
  bus: imx-weim: support multiple address ranges per child node
  bus: imx-weim: guard against timing configuration conflicts

 drivers/bus/imx-weim.c | 69 +++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

-- 
2.17.1

