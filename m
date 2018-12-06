Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1089CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB86A214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyFlBB0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB86A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLFT0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:26:42 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:34712 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:26:42 -0500
Received: by mail-io1-f54.google.com with SMTP id r9so1337972ioa.1;
        Thu, 06 Dec 2018 11:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m8imhs22SmIzY3rNUM8Frbs3fLrqVk9MWhC/MbfN4CI=;
        b=CyFlBB0PTUVfsgPV0wf6YDF+c5Tcjb+WtTXvn8fUmzck6Q8FOSK8ejJGIJ3u/K9ZzH
         RnuhtlUMYE9yT1nSEIPK4wWez2cR2fa5u+HFhpm+n4S95Kf2ljaZFy4kUe0n0j23C3Wb
         CZKXmhTllM7bzwuspSQk5Q4QAUmcSb2Gx7iC8mrbk2c+83xhKMADnbhWoDbhH2Utd0pQ
         DCzGOU6naotvPU9iKX6v2yVZdnOQuo83gP4w2JrWBS2NTE43nnvhJQJy9SS5Dbu2hLIu
         15JDXA/UGGtVKqwdJah51aSKDfxxVyNaPjn8yxs4GsV6zMI55Ku1hrfD4qfUVJTCEUq/
         bd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m8imhs22SmIzY3rNUM8Frbs3fLrqVk9MWhC/MbfN4CI=;
        b=odvspuxTZuhxAQfrjEWSeQV765jikOuILQy64xIhzu7Swo0ojifmO415Qb2mZyWxo/
         YubYuLKFSMj141U4wQfVN2qoymhK6wh0U+k9EqVJ+Pw0A8Zy6bZzIXgtjF32mQ5ytHsJ
         DyNd4F+WL0AB/ZqTh/3Wl+89Wq95OW9vwZcqQypwFxIi1m8g8kZH/w9lTF4CzrUhr6/v
         TKvODg8yD3vWgXvRwyk0OPwmBfUegaD4lDMiDPJXCzQdYLmT5uZi9RuComzXq9p8GGkx
         +SbDmMKiMlG0gKa4XrnLBfMAP3d5493PN1zVbrhW96rSTouQj+jaGE0SHA6IBMf5g3kv
         Ef0w==
X-Gm-Message-State: AA+aEWadZrOWyD3eBNmYQP6ZQoFQaWwW2uBGvinf+y0Wekrphxamf+6l
        44k8rhOCeih/SwmGW5IZ+CM=
X-Google-Smtp-Source: AFSGD/W6JaC6tXLZg6jqi6a+k0YQdEVxqyE010qx8ij0eFcBwBVaxVx9Z6sIDjCH0FKb7EYqarmOPw==
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr26025660iod.267.1544124401333;
        Thu, 06 Dec 2018 11:26:41 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 195sm819524itm.2.2018.12.06.11.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:26:40 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] bus: imx-weim
Date:   Thu,  6 Dec 2018 14:26:30 -0500
Message-Id: <20181206192633.25319-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple address ranges per child node on imx-weim.
While we're at it, insert some code which guards against common config
conflicts.

v3:
	added devicetree binding docs

v2:
	corrected acme@... in commit message example

Sven Van Asbroeck (3):
  bus: imx-weim: support multiple address ranges per child node
  dt-bindings: bus: imx-weim: document multiple address ranges per child
    node
  bus: imx-weim: guard against timing configuration conflicts

 .../devicetree/bindings/bus/imx-weim.txt      | 32 ++++++++-
 drivers/bus/imx-weim.c                        | 69 +++++++++++++++----
 2 files changed, 84 insertions(+), 17 deletions(-)

-- 
2.17.1

