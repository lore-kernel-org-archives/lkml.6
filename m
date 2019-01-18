Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E08C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7AD20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqGuJd8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfARXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:30:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44074 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfARXan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:30:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so6978113plt.11;
        Fri, 18 Jan 2019 15:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da91/n9DUgE7qrDB5BTP/g0fCKFOWWyecOgir9w/o6A=;
        b=jqGuJd8mIM0DpcLWzq+lfpcEXyMvaC+Up0KKuuc+uS1wiV3SPF+JHl5ioL1vqr2Ee7
         4cgKu33ztLGUyIFjK0Rk5LIbUIipSqqmzX1/xvPHPYTKPD3SSGtHO3siPSO5br6EPdma
         TBnR15PHV4YRmAKPQnXDX50rBNXIaKIdWZdqonPM/5/ctXGUjNPkQsbDp4v37fzfIwHM
         wBzDQa+ibeXH0+DrSb38YMvPa2rZvD0qdB+yIDQKjdvJSssEqJ3ksHxe+odfKdwgo8DB
         AaNPpMUjKrFDNMux2xd9ePRr2I5bU5dpZV2QhssLqPauhvmuqaJhFpEJs/gq26SNHhDc
         x/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da91/n9DUgE7qrDB5BTP/g0fCKFOWWyecOgir9w/o6A=;
        b=Y8A25aSEkhatar3u2hsahqVgcn9h4RKgagI3VoNzxecyeSJnNXuUKm70EE90vFCkCl
         qr6S8Cuq/hLPNxFytKTnZl+9UYVqT2VOPHEKkTK7nS+fPt5WG2aXhJzXxk65NsRDBQLn
         uhiUWyw7XuZp6M00bNfShwOWbeyaSLrRT5DZmYyrpumCgT11o557Ox7j1udiQgrhsJfu
         kbWUEeh9nmBXGCgQfUsKCpQWrv6kKwrloD6PtLWfOGnc6GPIQyQlOQbiUoUtIc/uztwm
         hmZYxiPXEUhirPPoZgVa3xt5IZ4lI4U160jdlDDTcxatw1L+9lymu9Zokvtf0tL1VVjf
         9EfA==
X-Gm-Message-State: AJcUukcFNnDlmiDYUHsV33G+UBBrw+9Kjnb9bKH5OMclran+b6bN2s5k
        NKlKBnUuQ2Lgf0RTRLA17Ow=
X-Google-Smtp-Source: ALg8bN76KKgxeOhx1ElB1M9jzBiAqyQyc1ss/LWRjBYkvaqKSYcrV+cIGEW+5XYcSeQgDkDpxX9lSQ==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr21001011plb.321.1547854242450;
        Fri, 18 Jan 2019 15:30:42 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f6sm11857163pfg.188.2019.01.18.15.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:30:41 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 3/7] HID: input: fix mapping of aspect ratio key
Date:   Fri, 18 Jan 2019 15:30:33 -0800
Message-Id: <20190118233037.87318-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to HUTRR37 usage 0x6d from the consumer usage page corresponds
to action that selects the next available supported aspect ratio option
on a device which outputs or displays video. However KEY_ZOOM means
activate "Full Screen" mode, KEY_ASPECT_RATIO should be used instead.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d6fab5798487..def58c6aa835 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -891,7 +891,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x06a: map_key_clear(KEY_GREEN);		break;
 		case 0x06b: map_key_clear(KEY_BLUE);		break;
 		case 0x06c: map_key_clear(KEY_YELLOW);		break;
-		case 0x06d: map_key_clear(KEY_ZOOM);		break;
+		case 0x06d: map_key_clear(KEY_ASPECT_RATIO);	break;
 
 		case 0x06f: map_key_clear(KEY_BRIGHTNESSUP);		break;
 		case 0x070: map_key_clear(KEY_BRIGHTNESSDOWN);		break;
-- 
2.20.1.321.g9e740568ce-goog

