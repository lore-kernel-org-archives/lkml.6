Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8139B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFWU85iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfANUoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:44:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40960 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfANUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:44:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so446035wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPuL55fac21Z7N87o3frwIS+ijIr9ZIcQXiNUZWwzZM=;
        b=FFWU85iBbTf3dHAi3Py7VGTsBtbsbTOg+H+S/lp20X9uiBoF6SEIODB8niDpGGDCJF
         CdMS5F800Ysg/LHNKX6kwm6kbRYeklRtJ19Qs93zHELeaD43HH/OZ4W+jqHmsGyjB2iH
         RPDYx9Ieyv14OCYUM6Xl7tTgTdy+6lywRswwLiwbFYT/8+CuXHHrfGgw8sNaUxYgCCY/
         bz4e6L2f8TCVKMPr6QwXv4YL4NaFJ89zOlKDIQZUrHFt9ALMccz2DwuxVXUjPUGGyDRH
         3TiLOvbE0K7OJpq17468PIGGBZpi46sqef3spV9lcbinH6JOCQQqOENAdHaQ5LZSUOU3
         POFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xPuL55fac21Z7N87o3frwIS+ijIr9ZIcQXiNUZWwzZM=;
        b=Xgwqpobi+SXBi7ayrVGm2/Pa/PoUL3QV8UojhWwp5wX1x6Ryx47/2yvB9nPKKIg+e1
         ooq8nrbZqKPj+Z86syDmjw7UDcQpEz1ZHvKs/OdOVGkY8tWpLfoC2uu3rzmOUqdH3Cpe
         d92xCuCadZvqmUOyxfrGvsZxXFkj+iXUBbrw/Vh+enjotYdopn3FAEOlgscQuww7g5rO
         afdRtTJ84AUFGSWrHX1Di2vTxi2paRBRwnKd21FvJT/Uv9pANlfmY/utK3C1OTzdpH1Q
         A+XtBfI9XUiyAMBFbGoUmwGyfTvBzFPda2aH732y2mVJk5xJTZOmOv1jnZzYRyjxJsVh
         /HoA==
X-Gm-Message-State: AJcUukct6cSP4FAu4hT/ctp4ZnUPMxPEP8Aj3x9oL1hRI+lQIdQ3dhcE
        TIqrpVvc6vfEH0rsJFjKlyc=
X-Google-Smtp-Source: ALg8bN4GIGgTWP3yCGjC7BgRU4AwK7nHUTLQTrBOdZtaNKWmyRlai8Et/nh15gappPXm3T9PcvN2rQ==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr221433wrt.37.1547498659411;
        Mon, 14 Jan 2019 12:44:19 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id s1sm106893143wro.9.2019.01.14.12.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:44:18 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id AFECE11422AD; Mon, 14 Jan 2019 21:44:17 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvram: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:44:15 +0100
Message-Id: <20190114204415.22296-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  drivers/char/generic_nvram.c:83:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/char/generic_nvram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index ff5394f47587..53123c110f7b 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -81,6 +81,7 @@ static int nvram_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #ifdef CONFIG_PPC_PMAC
 	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
 		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
+		/* fall through */
 	case IOC_NVRAM_GET_OFFSET: {
 		int part, offset;
 
-- 
2.19.2

