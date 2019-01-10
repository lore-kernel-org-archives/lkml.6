Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5935214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC6EWoBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfAJHdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:33:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45022 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfAJHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:33:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so4468608pgr.11;
        Wed, 09 Jan 2019 23:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=dxC7oPEi8822PDBX/0gQB47wpsKqF90X8WsfsfoEbvE=;
        b=HC6EWoBrnUvmWBiMrXIaqUI10bIkphdsJYThJ6FR1vIiqVF+jZvYWYBrgt3cnsHZ7w
         WwIQGTkAYvIvkvIoHwcFNgDsEL4g2QtPKStnooK52wKdYLry6EiADPuPqkkWsXwJSeoK
         qqpRk2Hy7JsKWEboyEwcvnYyGF7/J5c8zKmQWehcFPSSKLHFgNAT0ThoNF50oI4dLiXQ
         UnffgNah0quzaUF9UEMBz/nFeYXMlSDEIcV3b6KO9wIFjGeLzYwMNGCXuNKpDu+t3/uu
         HYgcINmEEab91963DyXHPfQ8D1eE0g0dCVF9X2A1BMNj9rD9DY/ECd/xJGYJb0LHoFmo
         ID/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=dxC7oPEi8822PDBX/0gQB47wpsKqF90X8WsfsfoEbvE=;
        b=Ze9fQOQPujlV2zo6lMLHVaO9VYJaSqfoo+DO2Q0u6w61mIdh9nH8Bkom7xEUIZ9azL
         Q0r3Qw/wWP+AJa+PAVFXihjEIQONoZZOhHlT2nAiwpL0ElT/9KiBUyapOpKe5quN1JoB
         6CCbMWnofS/ZI2xi/dVfU8tkk5CU+evHF9FD8VlSDWB0FYn9XA7RrYdmC/v5bVvdCOO4
         ugTuD3/R6lGwt7ryxCyjeyg6+iUYGniK56wN/uET4C6jhc3Vbf8MQEsPjTKftHCwixTL
         F3cBzjSjf1gTyQwl7hjzRdGLTxAlXy16zZBfvZg3FpXmBU8ChnlG8lxFFNtgG+oqaxHP
         Iwcw==
X-Gm-Message-State: AJcUuke8VCk8y5zBiGmobJZscEm5rtrgbEYRyb+0Q0jEO8NzRLDcroyq
        nF1YsHcEZtL7+yXjwOUvAV3bA8dT
X-Google-Smtp-Source: ALg8bN60lvY2FC9cUBDRJem7elY4DsVFVtnMoGo11c1voj+CsW8EWIurG20PYhJc1OKSEHBxHyhaVA==
X-Received: by 2002:a63:3d1:: with SMTP id 200mr8491131pgd.68.1547105588618;
        Wed, 09 Jan 2019 23:33:08 -0800 (PST)
Received: from sabyasachi ([2409:4061:2019:ef6:e468:6878:1f4b:258a])
        by smtp.gmail.com with ESMTPSA id d25sm121936092pfe.40.2019.01.09.23.33.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 23:33:07 -0800 (PST)
Message-ID: <5c36f533.1c69fb81.253c8.2646@mx.google.com>
X-Google-Original-Message-ID: <20190110073302.GA26039@sabyasachi.linux@gmail.com>
Date:   Thu, 10 Jan 2019 13:03:02 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     jrdr.linux@gmail.com, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: [PATCH] drivers/usb/storage/jumpshot.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unusual_jumpshot.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/usb/storage/jumpshot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/storage/jumpshot.c b/drivers/usb/storage/jumpshot.c
index 917f170..06e46c6 100644
--- a/drivers/usb/storage/jumpshot.c
+++ b/drivers/usb/storage/jumpshot.c
@@ -84,7 +84,6 @@ MODULE_DEVICE_TABLE(usb, jumpshot_usb_ids);
 }
 
 static struct us_unusual_dev jumpshot_unusual_dev_list[] = {
-#	include "unusual_jumpshot.h"
 	{ }		/* Terminating entry */
 };
 
-- 
2.7.4

