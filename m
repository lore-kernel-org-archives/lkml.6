Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A23F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6tANrXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A23F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeLJJw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:52:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33702 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeLJJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:52:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so9796074wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8AOnPuWWmmizDsU9BWbAl2B9A23WLqKDjIYQ/Nvubk=;
        b=m6tANrXen0HG2/XJs/NhIPL8Vl/U/QypBEBCJcMgxhruW616A32b78kn6eSnWRq00W
         TwvYzs7SlqEexg5IUcfMs5Uzm5YjWCyZ4HpZWtg+thByDrfTKfGNPp4Q/TQdhOyzVqeT
         N+/ynjHVZ3/oZZBa2Pknnmk5YsQzOkMS4WsnPGyvv1PPLZK5QggM8x6d7JIyF3dR+vhu
         Fb7jBEYCdw69+VN3k6nMQTqu/kUsOiLkHWR5kFV3pMY0w06/xTVz6WVs/e1Q0NKcvQUf
         NmVKIuIgjv88pJSKzVLikK1cjWkjUvhsf3uwWAS73MBQaR0dJqYvfuencrIeVkC7efCB
         KQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8AOnPuWWmmizDsU9BWbAl2B9A23WLqKDjIYQ/Nvubk=;
        b=r5U+I4Lpx81ln/WeESOx6cRO+udwZLZeNDZEAWYNUu9HGFcQZ5ea1KLsJnGVPUuIt2
         xiXprGQsrp7ScsRRR91FF5A7cR1a6WJsB01bIh31CP1SfYA92xXeGO630NmpnS92YjHO
         QHVvCbjl4wNBPqBySOTyxK6nAWkK19SB91zWutUM5IKBb8w16otL2RVIOCjmNoc0cT8+
         OXgDpSEX6uMdkK8YZSUL/cLSaofZlWhBNh8JDscjBqHrbNjKENyUH4Kzyg++w1jj5/Aw
         BD9PagljNYrdP/0FueIrQVDdrdzkSAjl9RB5EK4Aq22saGzRFQ2nr6v0TIwr3akC5smf
         Z0JQ==
X-Gm-Message-State: AA+aEWZ/O9V7iuvfGr6uDvkneOCOjBr+NWoSndmL0TCdCJ8HO+J/0HKB
        NgiHmF1RijyeDfUVJBxqb00=
X-Google-Smtp-Source: AFSGD/V3Bn5c+29Ima9DIlD5RcLjbqchvRcG2EN4ZPk5YcGTE/v31FRPC4P3idKlOgCbvI3GdMo98A==
X-Received: by 2002:adf:f401:: with SMTP id g1mr9520682wro.103.1544435546328;
        Mon, 10 Dec 2018 01:52:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id q12sm10346003wrx.31.2018.12.10.01.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:52:25 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: fix typo in the TODO file
Date:   Mon, 10 Dec 2018 10:52:02 +0100
Message-Id: <20181210095202.17599-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210095202.17599-1-straube.linux@gmail.com>
References: <20181210095202.17599-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HGz -> GHz

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TODO
index 80dbdaca3a8f..58e02f944b6d 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -1,6 +1,6 @@
 TODO:
 - find and remove code blocks guarded by never set CONFIG_FOO defines
-- find and remove remaining code valid only for 5 HGz. Most of the obvious
+- find and remove remaining code valid only for 5 GHz. Most of the obvious
   ones have been removed, but things like channel > 14 still exist.
 - find and remove any code for other chips that is left over
 - convert any remaining unusual variable types
-- 
2.19.2

