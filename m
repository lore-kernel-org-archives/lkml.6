Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD102C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87264222F2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl6tCS/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAEU1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:27:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41539 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAEU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:27:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so18964721plm.8;
        Sat, 05 Jan 2019 12:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jb9WVFtXhoGWIpssXZSAVbSr/gwqjhyYI4tJdnUrhIg=;
        b=Yl6tCS/8qJlCeUqR9cXBlcggxy65b3N0mbnNnL998bKYJHxwrJ+rBMdcuMqen1gZNm
         OzQEPRlgxS29e5oK7jAxwtochz2olLC8YWlZD7u82aJN4DugVcpvW6Jrs+mK1n0Z369p
         4SRgj6E7Z4uEdAe37nplgkGG5wTY3fUZ9EsO4JUOcHo5gIg1qCk8wn3KmKFNVMJbZg3i
         kHH3ZbwsfdVRMgckWB4GhL6CWbGC3e6WzSqJTvs1GTfiYUGQzVjC7dOmnemkDSmtkGw0
         JWpoKfidc1M+gNIDHqeFfd2tfhIPelLN6LlfBL0o/Gou9sgWaOE6aqJNAqutk4n4fMkz
         MmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jb9WVFtXhoGWIpssXZSAVbSr/gwqjhyYI4tJdnUrhIg=;
        b=ZB1QTfaIrY10KBxpghAzHbQI/kuy3jyE2BhGiFRlstLpq82GzCIqxHv3dFZJCbM8BJ
         hfUGuof6Lo94+NijOePdWb/4oE2dGd/TajfkNEeVzLby4d4KqDodFUTT3DRaelO25TDp
         hROCMlsT6XVazAZQYYgrrOVvJFV1k8W4wSTEd+b+w2VgJE2hURJGEErGS+2ZHXxM4sq4
         kjDU1mnlYRWjxaj/buRdkbi6XJ1MYQdzKYmR/O8KPB4DSwQd8Qkn5tP+YaiIEOo/14so
         k0HenZ/PTLf1r/K9nxeVclKuDr8Fmrt2aGXTIUZrKdXotPjOb6XylKQL2NtHvgCS4YNE
         9Egw==
X-Gm-Message-State: AJcUukdIyi5fSwt3mpGLKpH4JTy4Wx1huupx5yzm5aPk1GJjdl2O5pcV
        CdrY8F2ZHNNXeXBgZ+17mGA19hgC
X-Google-Smtp-Source: ALg8bN7ktb0znCO23efzrOhZcMXuG2+9Mx74LM5zhnnZlYgaA5czMt4RA6aeoEDw3oiCzJ6InuHuWg==
X-Received: by 2002:a17:902:227:: with SMTP id 36mr55817068plc.140.1546720025465;
        Sat, 05 Jan 2019 12:27:05 -0800 (PST)
Received: from localhost.localdomain ([121.161.238.230])
        by smtp.gmail.com with ESMTPSA id d129sm94559165pfc.31.2019.01.05.12.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 12:27:05 -0800 (PST)
From:   Donghoon Han <nazgul33@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] input: rotary-encoder: Support key events
Date:   Sun,  6 Jan 2019 05:26:57 +0900
Message-Id: <20190105202659.20198-1-nazgul33@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports generating EV_KEY, instead of EV_REL.

An example could be a volume knob, with key events:
 - KEY_VOLUMEDOWN / KEY_VOLUMEUP

[tested on imx6q platform,  full period, half period]

Donghoon Han (2):
    Input: rotary_encoder - Support key events
    Input: rotaty-encoder - Add DT binding document

 Documentation/devicetree/bindings/input/rotary-encoder.txt | 12 ++++++++++++
 drivers/input/misc/rotary_encoder.c                        | 23 +++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

