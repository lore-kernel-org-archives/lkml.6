Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D2C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D9E215EB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehAl7gfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D9E215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHHCqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:50 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42955 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:50 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so551278qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VHoTV73Kzpcp/phg71sv8KmN4pw7Nfdq7y1bQUzrJvs=;
        b=ehAl7gfAyVxWJKCXQKvPC3BS1TAomkFqcCQDW/fQd3lTkv/Gl0CJAb/dF0pqFSPqen
         otDE0P37jqvEZzFT0KUVHXx1Pk4HlpUG3DQsIyunNGCZz0W5D12WX7KHgBkaS0P84jlF
         Ga+tvmb0OSKRcUX4rkNqIfi89PoBQFXqVB3zVUbdPLsoYPc7yCMEiKiFfB3WVJ9Oootl
         s0B/uyM5+yKU7D6A+/qIWgja9/3ey6SFd0+RBze+8QPoPpSTLgV+9YACzMe9hd9PRmLA
         tSOgUVXEZGop+NMiiuT7NU6swxUjma7RPkNCFNZ69nTcS/kKvf2YTtqueyiQsRffTc5r
         FAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VHoTV73Kzpcp/phg71sv8KmN4pw7Nfdq7y1bQUzrJvs=;
        b=MTOTtEjQUWPvp/k7lDpDwR0FDC+7Gjub5FAKPlaQEIjwtoSwrDYRdMTtqv9lWOLGFO
         YTJOsbyXJRwVRfNcxFqBpMvfG4iII8EJoaWVjO0DI17VyUv1On1wzsoDZ0Nxfd8lTr43
         7cFGtPNFhLaTr8JzU7mMqNVLjSHlLwh6ZEDM2FzWHxwT5XnMMtGv1pKG7aweqls2vqhs
         G+EC5pXx2tmlM1z2KsAgx8vrzhkwbuxDwy9Q9vgNXi61xsYMnIm+ErCgarLwKjxuAiru
         zMJy8jr4bzAMFSlyT8JrSR/cVzWKXGOuLnYVZ8bcO3VDz4ScilHVjyt4+7PrNjx6Bk6W
         P4Dw==
X-Gm-Message-State: AOUpUlFOZw2lz7yCGpGQNLee48U/TCMTQZKztmJ7gE77nruaBeVPcefH
        +/ijfo0V4NwlHvubUzRejsQ=
X-Google-Smtp-Source: AA+uWPzZeX+cPhQcdrrxTavkwbXnAk58DejNx7XLz2u1Q4zO62gclCxPJFM7P7nvqyUg/JNL7OUtxw==
X-Received: by 2002:a0c:9281:: with SMTP id b1-v6mr581326qvb.115.1533688193299;
        Tue, 07 Aug 2018 17:29:53 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id s64-v6sm1727411qkc.70.2018.08.07.17.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:52 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:49 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/15] staging: fbtft: Add spaces around /  - Style
Message-ID: <ca456f11ee982a5750544e73264b59645e7ce182.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Puts spaces around the /.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8b79353c722a..83076eca9760 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -769,7 +769,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbops->fb_setcolreg =      fbtft_fb_setcolreg;
 	fbops->fb_blank     =      fbtft_fb_blank;
 
-	fbdefio->delay =           HZ/fps;
+	fbdefio->delay =           HZ / fps;
 	fbdefio->deferred_io =     fbtft_deferred_io;
 	fb_deferred_io_init(info);
 
-- 
2.18.0

