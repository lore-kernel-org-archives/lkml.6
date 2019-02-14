Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7D52070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD525zH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405838AbfBNLbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:31:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbfBNLbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:31:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so2932423pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=nmwfSFeC4FsqEsRAQeWk8q7Q6CO3g44fKSuw4zQ0SnU=;
        b=RD525zH2ap13pMVTMSqQug5kuY/j9rZnobPuh/auwCflvOvw1nA+62upri7KNjTCZP
         /yGR2o+vf6ba10sdeAqCqvEtx3RbD+HLOVARiCHicyNBa4sIFW4WNWm4SNcDLtDFOtBa
         xxOY9bUaektdwWyRR3IaCkhEyOcu0CpK2V8p6lQZ7v5tO7O3mfR0hgRDbwlNi4WtEvCW
         GPxKfpokd9amxet1Xv2wWdUnMiBQHOrFHZSF5y8riR6x3cOfG7/+DvV8OwkW3m7Y5xgL
         RCWXbR+6eGlR5Z6QCtIhUj2/d1so3ENqe9MHeC+dTSNosJZoQYKnSG5sfF+oMH/1MM2F
         xrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=nmwfSFeC4FsqEsRAQeWk8q7Q6CO3g44fKSuw4zQ0SnU=;
        b=nmBnxl/EW8BdLk0Yk9KeGzbu+xqbTa2LLqVq01GPo3RajeSmuK3bk8qrhn7e9pGYB2
         nh75vN9t1PkM+EG3w+NCETFZg9hX3QaD9/7QQcTOyIiLV5hvLa+MYN+46nPLGalF9vNP
         Kvr3Kf8sCE3A+0e3ezn0s7q+lrG0Oxm/PbpDI+L6iObf8mDSh2BRtdJ/NeUskbvUFRHt
         V+IMUD18+JdNBQE4JHQT5w/+Hzd4wEbL4PmT6g/st9R+bFJEBCcIJ0fRZQOCynp1L27D
         UkbavLANwODfoQ29HlC2i253cvpburgY0s75v05yjK6//rhu8N6Sup1Scq4BOHekGGMp
         3HrA==
X-Gm-Message-State: AHQUAuZjIoXR8VPh7omgU7ByadG901SwlWhSwSZevBjOiNQn0jfhJbef
        YrJV2JuPHHdCbpjxCY+qlS159kNGn5Q=
X-Google-Smtp-Source: AHgI3Ibn85Xpoo3FnzM3UznHIHxVdWZ9bwszotvPVeBUMTxdWKbmRIAbBwM02zamUIPxpKS3aZcxZQ==
X-Received: by 2002:a63:480c:: with SMTP id v12mr3370440pga.115.1550143879410;
        Thu, 14 Feb 2019 03:31:19 -0800 (PST)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id p2sm2795864pfp.125.2019.02.14.03.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 03:31:18 -0800 (PST)
Date:   Thu, 14 Feb 2019 19:31:13 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pstore/ram: Avoid possible failure of dummy device
 unregister
Message-ID: <20190214193113.0000609f.zbestahu@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom 08ac260f36b4c11eb33fa58466462a5e1027bdb3 Mon Sep 17 00:00:00 2001
From: Yue Hu <zbestahu@gmail.com>
Date: Thu, 14 Feb 2019 19:34:16 +0800
Subject: [PATCH] pstore/ram: Avoid possible failure of dummy device unregis=
ter

If create dummy platform device failed, dummy variable should not
been set as NULL. Because the following platform_device_unregister()
will judge if the dummy is NULL or not, if dummy is NULL nothing
happen for unregister flow.

Signed-off-by: Yue Hu <zbestahu@gmail.com>
---
 fs/pstore/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 4a06675..61bc573 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -994,7 +994,6 @@ static void __init ramoops_register_dummy(void)
 	if (IS_ERR(dummy)) {
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
-		dummy =3D NULL;
 		ramoops_unregister_dummy();
 	}
 }
--=20
1.9.1

