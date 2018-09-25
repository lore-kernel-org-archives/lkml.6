Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078E1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B7421480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhXvmSb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B7421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeIYOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:40:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52636 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIYOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:40:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id l7-v6so7600342wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eeliq4KMWeAJl+kxPR9XD/o5gZyt72pWxg8IcQlJEZc=;
        b=vhXvmSb1vlCLEl5Dxs6uwPkYLR3sZ6npPqcS/eWyIieFujxfBvW7oZR9p0HBXyQjs8
         V1b/4U5UvnZZGFDUSZrBkCsM6uPyHTlLZVlSi683srfsQMK13VGKxOfvjjpecalPrRY4
         X7SaPt7T4C4tHAT41tRI4icOxAWuWC+CFaNNKETAolukrFfFV34WFlOxzo0ZUvDZQuhQ
         DpDOaipbVJILLUzbhDFYVEHvovMWQfa7dWvrv7W3TA718mufIKKnH98WYRn7xmlwfsQM
         gQfiJBB7gnsu8+wxCC1xmecjBVTPKn0He9t8pqSX6HQozHsp4HJIFso1eYnzps5oaUXA
         8WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eeliq4KMWeAJl+kxPR9XD/o5gZyt72pWxg8IcQlJEZc=;
        b=oJwrHSAZlC1xz7ESBagyp0Z4hwRq23WzEX53+TKl/vc2rbWK5nciqFdfIPYRXXFNbh
         i+Q8NNu7r4Q2VAbDSvcMm0VdvvhxlNHcnv4YMnFL8W3rNdbvhfmo13AmbhnLWA1soAmP
         s4K92aseBHOGqaKxBq3mj4+rtN8xz+Wms5JWmeFeMNdsfNPVj5fTORvKrRAsc5Pj1EsY
         C4gUA8qbmipwIPItq9OTErGrTZAPVOppIUx8Tk5Y3TRGTUqJOmDFpU44zTEJvlBz+Yf9
         EQoGazBtUemHJka3zKYBXF+NTrqfZkCcmCmqvwEkN9uyvOt4t4AajsbulVpIUnBsfIyz
         fIzg==
X-Gm-Message-State: ABuFfohHFfwdV+7VJSMdSlVznODsxG2TxJ+uJM0GhQqkGAkNY/y4uyU+
        WsKIHyajoh6PsLK588lvMKc=
X-Google-Smtp-Source: ACcGV61ubpvgMoyUpqL1p38g2AFtfBzfw4a3jMv0bOIFUPMUvtZ1gtrnuZQd25UMjmjcb+VQZ7OQzQ==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr933694wma.85.1537864455949;
        Tue, 25 Sep 2018 01:34:15 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 94-v6sm2115538wrc.10.2018.09.25.01.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:34:15 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] staging: bcm2835-camera: Update TODO
Date:   Tue, 25 Sep 2018 09:33:56 +0100
Message-Id: <20180925083401.22533-2-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the TODO item to remove manual cache flushing from bulk_receive.
This was previously done in this commit:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/TODO | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index cefce72d814f..6c2b4ffe4996 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
 hardware can do.  If we exposed the native padding requirements
 through the V4L2 "multiplanar" formats, the firmware would have one
 less copy it needed to do.
-
-3) Port to ARM64
-
-The bulk_receive() does some manual cache flushing that are 32-bit ARM
-only, which we should convert to proper cross-platform APIs.
-
-- 
2.17.1

