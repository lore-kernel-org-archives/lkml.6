Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21529C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA7720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFUgChk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA7720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeKHTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:02:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47101 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeKHTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:02:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so8597894pgp.13;
        Thu, 08 Nov 2018 01:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwAknXHU3CvvyG4AcdYDqFLDKfBIGw3GGTZAmDcZgzI=;
        b=tFUgChk6YB3gfdUv3MLrniwePUWJzVHgPasOPmdEOeRwDOXRTRfxVNTri2Bu4xlL4l
         UaUfdbLD8TKsll/ccsivwkmTvAyKlCAgu8af9BdiYs+2BtgnGnJ85B0KK8fwmFcP5k1K
         SvZEYVfo/v8DFRGl3NfIAh1NxN4k3J9cBC8cHXm1E8b2CAn/6g2z2WJpk3LWFWLb5XJY
         twq8jGvSW7HyzLpf7VsTISKAwVT8iBoKODQogiulNhnbkDexUW+4SFmTyDaBfkihwIl9
         YKZ3YzZkn+kf6pTRWTkCUBBydTQN70V4ZAgy2dgVY4awXK0LJoi01KTtppQQaPAuSaaG
         YLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwAknXHU3CvvyG4AcdYDqFLDKfBIGw3GGTZAmDcZgzI=;
        b=qOurXhvIedXpssu2W5xgpIBdtf2XZtWKX/RJEoqzBHeWMVs+aLjacxvZOdhlvTQrkG
         hGuLCBIxb09urg7r7Hsbc/1f15FpbmowmT7MuiCKlVheLmtwVC08ek1sRgt2kxV/NnM5
         Pn6cB3TW6ZN2uvIntFfIzjrfpqzwMiM48pPP1Um7ZewcbPYS3ZHxKRDxhnILEmBmwCJ7
         w0HLdfeq1yOlmeO8Oys1qYr8w3EC7yLvd/reqngLvotz6rHQgeK/iOsvRanlVRnY8gSo
         Rqrn0A3iyQa3rjAIicHuaIk4OCh2FRrSBhyOzfK8n2xoAl2fTIeSafqCvaGwQIjqkHJV
         7ttA==
X-Gm-Message-State: AGRZ1gLImS18mOFatNbVMZMPVFbPhavHf9jXsWoiOfORJYx73/4IRaCE
        NgScdBGowECEtWq8bUQyutY=
X-Google-Smtp-Source: AJdET5dJJAsPTdmxqajal5ay0l0oDnchw2PlIMgmMLs4PVKjlB/8n4SeZhGg00fMN+GjNU1/G3njQw==
X-Received: by 2002:a62:1e83:: with SMTP id e125-v6mr3755802pfe.231.1541669288750;
        Thu, 08 Nov 2018 01:28:08 -0800 (PST)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id u6sm3004140pgr.79.2018.11.08.01.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:28:07 -0800 (PST)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v6 1/3] dt-bindings: Add PNI to the vendor prefixes
Date:   Thu,  8 Nov 2018 17:27:47 +0800
Message-Id: <20181108092749.12167-2-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108092749.12167-1-songqiang1304521@gmail.com>
References: <20181108092749.12167-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..adcdf60124dd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -303,6 +303,7 @@ pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
+pni     PNI Sensor Corporation
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1

