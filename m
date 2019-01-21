Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C7BC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821612085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKP0cstr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfAULFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:05:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35413 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfAULFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:05:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so9690644plo.2;
        Mon, 21 Jan 2019 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WCHOqXUPBxcc/njV9Zup/96kkXc/malf/rb5mlqrS08=;
        b=KKP0cstrsJIy4gQxNjAJV0UWLPfi253tyz1NvHMG8gxPh2sG92uFiTlcfQaHwvrs3e
         eJKPZSweDN/mamQbDlz+6y+2yLXlGIWWtoIrTMmqA7vYWFho1sctx7cVDvEl9XpEk1eO
         2lRgf9VT3zY15vdBi5ail4IjS2Hb0KJ/UiNFLtv0kL1dDGXMay5Wyp5yI5q1vObzZuCw
         moY04ox4C7LxWr3++sY0Q+WV3Da8xxQMw5CFi1suDXhz/sFIoA9PoXwqE0qc0GXTFo3m
         ELuoFeVNBFnxXrBJZ2ar9XhF9jeGVHlGtmbmS1Dls85s5AOhwDOT55abnuQW4KuVywFB
         HT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WCHOqXUPBxcc/njV9Zup/96kkXc/malf/rb5mlqrS08=;
        b=OsSjXcSWtvy9FqZQ5FzMup6dvSS/CbXPVJBma70UORlwrHyTYDPYkEJ1++/U/zsqsG
         TrQr9J9pYwThIztAM0wbBUA9VRvklg0Recv1LKk40eduQmFt3dUSEWxjam0yCB8vo5vk
         NimMw08Qq93DDapkFITsOnSU5lO8+WjJAeJB11+C3JulEfJtIj+NAcQcTk0+RySK1vkY
         77RQpoVAO3+nTJ39WJk+rOLlY29pgCEWTLLQO+BK910vhvmUmYzLJOxtKl+wKqQBkK5D
         zcl4GXeeIQZulGwxYnvmur3U1Za5SFw0NdvXg3ibM8nPjGB6gAnLi/U87Mrt2mebC+hd
         Xm3Q==
X-Gm-Message-State: AJcUukd0y+keCueyHd7qsizuz/xp1RCue3bu8Fgnmee2PYOKhJDQzHXB
        Ztqus5f3OiS4je2FO/74TJr43HIaWc0=
X-Google-Smtp-Source: ALg8bN6ro1jSb1ZU35OeJJd1Ufpx6lJRLrXWd7fTJliBmbHEjheB3KeOXopsttWb32WbULcY+85gIw==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr30342276pld.152.1548068701883;
        Mon, 21 Jan 2019 03:05:01 -0800 (PST)
Received: from bhar12345-VirtualBox ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id c9sm24543958pfc.92.2019.01.21.03.05.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 03:05:01 -0800 (PST)
Date:   Mon, 21 Jan 2019 16:34:55 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: storage: karma: add whitespace after declarations
Message-ID: <20190121110455.GA22710@bhar.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the checkpatch.pl warning:

WARNING: Missing a blank line after declarations

Added space after declarations to conform to coding style.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/usb/storage/karma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/karma.c b/drivers/usb/storage/karma.c
index edcf2be..395cf8f 100644
--- a/drivers/usb/storage/karma.c
+++ b/drivers/usb/storage/karma.c
@@ -167,6 +167,7 @@ static int rio_karma_transport(struct scsi_cmnd *srb, struct us_data *us)
 static void rio_karma_destructor(void *extra)
 {
 	struct karma_data *data = (struct karma_data *) extra;
+
 	kfree(data->recv);
 }
 
@@ -174,6 +175,7 @@ static int rio_karma_init(struct us_data *us)
 {
 	int ret = 0;
 	struct karma_data *data = kzalloc(sizeof(struct karma_data), GFP_NOIO);
+
 	if (!data)
 		goto out;
 
-- 
2.7.4

