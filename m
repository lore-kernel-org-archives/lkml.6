Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7CC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1C620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIABhlg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1C620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLLAzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50643 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLLAzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:46 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so6616229iti.0;
        Tue, 11 Dec 2018 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WutpXEqDWOEGA5iAvwKj2DUy8q71VLFNSfE3FWc9wZU=;
        b=dIABhlg2XMLiVd1VF+HfKfYAO4bnlFUHi260Y11mf4RIRr+wegR7J23F3h2dhqPSBH
         7Dsa898p4RqLoYIPWtMuI5QMo6otxyeYC2Qw8vzVoDT2qEnoTCMSf8v+9DgNIx5O+Kg2
         rjo7J3Y3nxffYJrVAVdPgHqiFHk/hI6pp7MluO8iLWW/jRtovQ6SmnXdLGxISRmPUJaH
         9S2YyO6SGtrGJiGKSLFVOitHgl/FSrqhTjiNwJzZoiLS9vEd21NiypcMtDFAozAnllbk
         3qpvzlf0akjr4f22NT13WLX880lmxrsLG7aRjLnhTav6QXUKc7r29x08BJwDywDJ79qp
         RCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WutpXEqDWOEGA5iAvwKj2DUy8q71VLFNSfE3FWc9wZU=;
        b=idS1W26HtBZEsU/cY6wnpwlrYim5QWJY1tv/EdcoHCWw//cpX1Tnm5WkZ+T+VuXEnO
         n1+rJJnzp9SfvOjHBMYETRKjolK75mOgTqlewtlTzjHlGp20FbUPZqnIdDNWszRv/x8R
         kZ46czMFs3wJFrWwLv2hhkEuWbSTC4TKAk2KUPBCEQPDQG0gNEe2WISXxfs5fUyGUGr5
         Ym4Dj4IuYyppLDJ6RDZ3yylX7SiLhGtT72aGKtMr3wBAMSeRigr17g2KNvkhKiwtKYfu
         3PI2mDIVh65KcJvMWYgUOQcNRvX2TrFzLAikRo0w1W0vZa8kv9st1mLqDnLTbUJLgJ3N
         SYQQ==
X-Gm-Message-State: AA+aEWZribKfdQH2K7UclPigosgmkAvYIsNPESMY/+R61kys5Ql4Npib
        yf4LYkLj8+IGEa7lcAmoocM=
X-Google-Smtp-Source: AFSGD/WHf90gOW9ZEg2Es87ClvbpOEcJc3p/q7CUQwNPDxSbALRSaxo38G5pq1I5oegyVWyqX18qXg==
X-Received: by 2002:a24:6983:: with SMTP id e125mr4049738itc.26.1544576145387;
        Tue, 11 Dec 2018 16:55:45 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:44 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 02/11] staging: iio: adt7316: invert the logic of the check for an ldac pin
Date:   Tue, 11 Dec 2018 17:54:54 -0700
Message-Id: <20181212005503.28054-3-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7316_DA_EN_VIA_DAC_LDCA is set when the dac and ldac registers are being
used to update the dacs instead of the ldac pin. ADT7516_SEL_AIN3 is an adc
input that shares the ldac pin. Only set these bits if an ldac pin is not
being used.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 1fa4a4c2b4f3..e5e1f9d6357f 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2130,7 +2130,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		return ret;
 	}
 
-	if (chip->ldac_pin) {
+	if (!chip->ldac_pin) {
 		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 			chip->config1 |= ADT7516_SEL_AIN3;
-- 
2.19.1

