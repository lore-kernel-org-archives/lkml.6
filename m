Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C7520836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoY3JuTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfAKP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:29:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42410 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfAKP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:29:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so6896470plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=ld8EPvbzVMT+SldYJEwcIcbStFIJ9Fh5lF2txc8ZdMY=;
        b=DoY3JuTPzHH0OvfILaAV0yghpcNzwboEIaEI5GTQaPlAwfStTwDvYQrC/fLEx3jwvk
         iiMcuYXqdalP6YRFgkRUgDCIqA3a4wzU5HnhP9pAO0i42K6Z85h+WiermRiTRkd55pxb
         tnJhzU210ORSN8HxLo/gmN+hJ2xWhgky5aqJm3iTa6X98YqsDaFDwdvNFUw8vuvu/4kl
         FKlXhTBX2f/loQfky/GukB+p8TEhVTZQehg5QQCCovRrjlTEu9xDUtk8YXdeogzJgGWe
         HE2aYmk3ZFM5rs7d+zJYyEqLlx4TrxEyeRmxbZ1azBS5Eb2hs8fk890zQCmYcpPJ+P+W
         a00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=ld8EPvbzVMT+SldYJEwcIcbStFIJ9Fh5lF2txc8ZdMY=;
        b=ZwgwS3oP5nWBuVjHg5DObAyHDKmTjReX73pWjwA5e+UhXnm/uCb2i9kUe7OMrzclnJ
         vp4LqhNdeMD2hiUligVXpwEG7g0Acvmpizcdp2Y7QEOBgW6yYMllASjCLw/2I0m7W/jY
         f7zNUuX/Mpwlx+xGC0sJp83pL+8b+lWupxf7NhwT0/z27XNNzHi8Nx2EAnPFI4XhaqFO
         KCdOlX8gC68jyJTBdEpriWhX2AN7wb5UJG72lvYnDVoflwu3ozqpQ2UW91OfvcxQBACy
         BCqySYAvE6wZVD2lrMQgqTl641tBLxnGprvoTH1QU6z7ua3zOoZEUM4TXNYVUvFJQfNm
         7L4w==
X-Gm-Message-State: AJcUukfa9kOk+T1GpKeC9CEv+Ab4yLsr44xZHY3wvfoR0+pT1EvGDQN7
        TTSjYAF2JuiLWuDfRv0tIi0=
X-Google-Smtp-Source: ALg8bN6u49tmDvkohYQ2MWfzcPbok13GDrzbIBeEm7MOcEubSI4pmnDoLSLOa8ernlbn8NHNaok2mw==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr15399304plb.235.1547220555698;
        Fri, 11 Jan 2019 07:29:15 -0800 (PST)
Received: from sabyasachi ([45.116.191.203])
        by smtp.gmail.com with ESMTPSA id v184sm109352554pfb.182.2019.01.11.07.29.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:29:14 -0800 (PST)
Message-ID: <5c38b64a.1c69fb81.a0651.e342@mx.google.com>
X-Google-Original-Message-ID: <20190111152909.GA31299@sabyasachi.linux@gmail.com>
Date:   Fri, 11 Jan 2019 20:59:09 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     jaharkes@cs.cmu.edu
Cc:     jrdr.linux@gmail.com, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] fs/coda/psdev.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/poll.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 fs/coda/psdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c2..f2bb798 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -39,7 +39,6 @@
 #include <linux/device.h>
 #include <linux/pid_namespace.h>
 #include <asm/io.h>
-#include <linux/poll.h>
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-- 
2.7.4

