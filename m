Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8549DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2596620666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz2rV9JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2596620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH3FrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:47:02 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:47021 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3FrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:47:02 -0400
Received: by mail-pg1-f175.google.com with SMTP id b129-v6so3124033pga.13;
        Wed, 29 Aug 2018 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0fyxd2DJpX0EsYfx8nVNhosdQo1QyE2I72iuKCj+sqw=;
        b=hz2rV9JXIMBk65JEoeG7rHcZwvXXG/vukVo6yjzqwZ8ZuwXMHFBSZdcxsok+D8T27c
         zJ23oJtV6FU+kn0H+gOwmloF/N1onGuGGiWZfhK/aC+gRAEybmxMQGvezudwt3lrmOFh
         wbSOAHOpKrZkz9S+qYfSpaOUTKHMZdk5BPXuyvuLWHJ1twq9k0Zyc8uSg8kVsx/U3EVW
         mJFI11a2nuklfuhEXN7ePaQAhwOmi6F3O8ERB/DHHDRztN9Y9Y10TnWQn7GzasX/cuQd
         Cdvj4hFHjiwUlGzbGQJMTDvvGDyN8KRRpU3Rb7E5hfVpIevkQ0utJZ338h9xpm/Dk3Qz
         MNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0fyxd2DJpX0EsYfx8nVNhosdQo1QyE2I72iuKCj+sqw=;
        b=fWn78A1up3UPfNrxT2Msr4HueJp2rm3kNM2JaWdGilfaUHkEU+2i57oNF7b7i3KhtY
         ZG6y6zkimDT13CU5xCkJVSXPdtQWB+xVyMgf1R6kixs1ZbHuX35aaozRjSyQ/nhhvP8v
         GYvQmmtq+1PjSvrwyOzh9yCr8KQ9fw8CdVsGNhmwNI8C3Vt5NRioo641OWuaGfFOQ0yh
         H2vteZYqNArgsv6yWqkPam04OD/9MZfeUFkuclYF3ZMOIE1CUFAtI1QcMna6ifBqlgtj
         4gQcnNH6mlsduAidtGcOeSb27/cz+hxBWfCDlkgGbMc0MMkB5Vnk5vjhz4iY9F+aBCoo
         axsA==
X-Gm-Message-State: APzg51D7lMg2gYlJFhlPl/BOzfYODXPJaWAitl5TegiDjNgM9Y0ugs9N
        WzkzXqp6VZbC2fKaWiKfWB4=
X-Google-Smtp-Source: ANB0VdaXVXlpVSflNHAaI01KJV3ff00eMUJMoxyUo8+IbpA90/S+JenRYXL0zRG1PUehO5dbpS05tA==
X-Received: by 2002:a63:4f64:: with SMTP id p36-v6mr7635780pgl.210.1535593641516;
        Wed, 29 Aug 2018 18:47:21 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id m26-v6sm18178816pfi.102.2018.08.29.18.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:47:21 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com
Subject: [PATCH V2 0/4] Fintek F81232 driver improve and fix
Date:   Thu, 30 Aug 2018 09:47:09 +0800
Message-Id: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 patches changed from v1:
	USB: serial: f81232: clear overrun flag
		1: flush the lsr_worker when port closed
		   (noticed by Oliver Neukum).

	USB: serial: f81232: implement break control
		1: Add private is_break to record break status and re-apply
		   when LCR changed in f81232_set_termios().
		2: Fix wrong usage for f81232_set_mask_register() in
		   f81232_break_ctl().
	
Ji-Ze Hong (Peter Hong) (4):
  USB: serial: f81232: clear overrun flag
  USB: serial: f81232: add high baud rate support
  USB: serial: f81232: implement break control
  USB: serial: f81232: fix bulk_in/out size

 drivers/usb/serial/f81232.c | 163 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 144 insertions(+), 19 deletions(-)

-- 
2.7.4

