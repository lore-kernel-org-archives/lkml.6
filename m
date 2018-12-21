Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07821C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C428E218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYukp69q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeLUJNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:13:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45617 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbeLUJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:13:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so2308040pfd.12;
        Fri, 21 Dec 2018 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=gKfOu2XBA6+xdPZMm8kui26trvlemSXqQh25hhYUJ5s=;
        b=tYukp69qyrsODFet4cuel2SrXJfDzq7Ls/mEdh8aC3zZHfWI1MSP3xLXplbJz0LAgA
         pruV9Cq54irGEj7PmWP6xmHTxoXKHbK/OV7l2PNuJsvNkAWnIkoFLqQ+ohINsYAC2Vhl
         fAOBmXVmx73VS3eJdtKJljJc1T9CygCOonFE9qO55ObLN+vPjomes/K+hcV9wFfFXPLD
         6eh7kpi963Qazt24sK+G1rZvtkAtJ0VMLZO5IK2gEMkGGL4VTjVIjh8D/WUb1QrWrtdf
         h85WauNt+A/vaAFZmCy9X052ndwwO9B6h+qWPxeidlen3fgSL61G03B1mvpzUoRKGsYq
         caZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=gKfOu2XBA6+xdPZMm8kui26trvlemSXqQh25hhYUJ5s=;
        b=uTHGFnXWzg4xzH5nyPhxGvfXgRFElMytf4wwfhumPELw6Y8s2bqK0ArlxL7R4ogXeG
         I3ms+O2vnVQscwKou79B7sCaKfFepEUpuWiFcvNlPHCEScphf0wu6uwK9kGaWbQeJ4aa
         HTW7zbjqy2kBPu6G7Mu9I0tf0DZ+RtMxoW6RH2MQKPefsHMXfwxJhc2UR/+lZ9vVVnG2
         TPO65R+UVNtppVtRTtSm4tfGT2inuIyR45AecOJi1bfucukAy0fCeSEHXCQt8Xif3lSZ
         9sN14hTbWsiyWApa86c6OvimUDZZmqTOqOXr3ZGHN3mLUzwTMjOa/lRyDGhUhkW/TyMI
         ArmA==
X-Gm-Message-State: AJcUukdovIHLtYXadNWnPYLfZn5RxD2zzF4Kxg8iOy40zPOPhig7IxMN
        w4NWCuj9bbnrFqMx3I376bk=
X-Google-Smtp-Source: ALg8bN5dmIKSaPhle+XOjYmYpx9MV3QWuTTk0lXuEQMLeEjA/einkjKE+VZT83F5xzLZ/tp9u7Y/Vg==
X-Received: by 2002:a63:d005:: with SMTP id z5mr1644496pgf.64.1545383581480;
        Fri, 21 Dec 2018 01:13:01 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f20sm28063348pfn.177.2018.12.21.01.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:13:00 -0800 (PST)
Date:   Fri, 21 Dec 2018 01:12:58 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.20-rc7
Message-ID: <20181221091258.GA63423@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Switching a few devices with
Synaptics over to SMbus and disabling SMbus on a couple devices with
Elan touchpads as they need more plumbing on PS/2 side.

Changelog:
---------

Benjamin Tissoires (1):
      Input: elantech - disable elan-i2c for P52 and P72

Mantas Mikulėnas (1):
      Input: synaptics - enable SMBus for HP EliteBook 840 G4

Tony Lindgren (1):
      Input: omap-keypad - fix idle configuration to not block SoC idle states

Yussuf Khalil (1):
      Input: synaptics - enable RMI on ThinkPad T560

Diffstat:
--------

 drivers/input/keyboard/omap4-keypad.c | 16 ++++------------
 drivers/input/mouse/elantech.c        | 18 ++++++++++++++++--
 drivers/input/mouse/synaptics.c       |  2 ++
 3 files changed, 22 insertions(+), 14 deletions(-)

Thanks.


-- 
Dmitry
