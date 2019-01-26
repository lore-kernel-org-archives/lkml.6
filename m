Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92811C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38621855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="madlEAkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfAZBLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:11:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37830 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:11:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so4893927pgb.4;
        Fri, 25 Jan 2019 17:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VCXjBMT6Rj94A9eM6Y+enJqibylV1neUCEXpsXR/fqg=;
        b=madlEAkHyCD1Ju83EqOFmsTjfXeWWJSMp9g3pvEbUIfPe8BnrF/GE94gbdXIXQxQwU
         daWyQKlYbK6AYXIqL7TrmmsXnByLWZJNAYHeVRyMgmt6p5kJkIbGYdvTnsvMu9oJRg6o
         kmlHtkuouLNi9UFOy75F4nEtl53NjwwYSFjvKHh7JdHRJ2PGIQh/ZV1e+b6lvrcOU0tw
         xpXCnRyXMLG3CFqAqLR9hIj5sVHoyBo/+y80BrJsolo0Zynh348WBrvniL94DUhbizmx
         OAYuxj+lslr4eKzHebZ2Ag/7B5Ok7v3j6CF0ck9sWxFjJxy9N2q2v8EyEQGRyZsd6cLY
         3jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VCXjBMT6Rj94A9eM6Y+enJqibylV1neUCEXpsXR/fqg=;
        b=FpUsh7wqceG8PzQ6Afr4HfMuCX1juhzi4Bo/TamY9GmToKuopJ/yaxWp8oj6noyUvv
         aAny7Ez6TL/YsBfzo/Uf1x31vxSN/EHq1UJ7el9P3az7JC51xI6XOtHksiwC3C5bKrA+
         3QQoCewJxid/gcM5oYKDPWO2gslA/CD7IZ6W4UgKoJcVSQQc4pKYYP1KmOmSJyA9/cgG
         wJ1xDBZkkBXN29S6BHlKJITMiYyV9mJvrZjVf4d8vlmAuOD0isG0K1fGe2Tm3oKuip3p
         tq87BqP7ndQLxFq/3omVO96UMne+ZYe92dFugb89r27HiPReG30eAl+tEhGx2V/R/VOM
         T8Fg==
X-Gm-Message-State: AJcUukdHcQMzF4oSVCznzjwa6+6ShFlYaI4VKVMTwiH6BQom+ZgcsYAB
        o7FRdK4cPDTMPyEh1g8UE1KD1Fvc
X-Google-Smtp-Source: ALg8bN7lFBdJGrBdtAB/LF19mfUv9EaSru+k/Cm/56QFG/uB6j6iAhoI5INfecI3OTGSUpX3m1dPUw==
X-Received: by 2002:a63:1b58:: with SMTP id b24mr11781457pgm.247.1548465076132;
        Fri, 25 Jan 2019 17:11:16 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p24sm40133791pfk.155.2019.01.25.17.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:11:15 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:11:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.0-rc3
Message-ID: <20190126011113.GA23858@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a fixup for
the input_event fix for y2038 Sparc64, and couple other minor fixes.

Changelog:
---------

Anders Roxell (1):
      Input: raspberrypi-ts - fix link error

Deepa Dinamani (2):
      Input: input_event - provide override for sparc64
      Input: input_event - fix the CONFIG_SPARC64 mixup

Dmitry Torokhov (1):
      Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Lubomir Rintel (1):
      Input: olpc_apsp - assign priv->dev earlier

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Diffstat:
--------

 drivers/input/joystick/xpad.c     | 3 +++
 drivers/input/misc/uinput.c       | 5 +++--
 drivers/input/serio/olpc_apsp.c   | 3 ++-
 drivers/input/touchscreen/Kconfig | 2 +-
 include/uapi/linux/input.h        | 6 +++++-
 5 files changed, 14 insertions(+), 5 deletions(-)

Thanks.


-- 
Dmitry
