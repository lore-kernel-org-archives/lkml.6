Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BB420673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBNfQK8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BB420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeG0E1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45039 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbeG0E1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so1230478pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CfZ00t9u1vOIZqmMouqMdFDmZ8z0MMaKVOmeI3srS8=;
        b=VBNfQK8lLU6s+jNXuNYvnntsYTsDgsT2CxyoRBUMOjZ7QrKJrJDPY7csm86j5XDkCj
         QToNtr8jsmbvPybFmniuIa4ygU3kewYZ0bk96ann/GkYyg5rZ4a3WPWZ2kOcF0ioEW/b
         gpY2iHhV8rPPqurE1JIb8gd2zVsIFadflTXX47aCDRRct0I2QUrPdlNQG/F7EU3sCw96
         uT14ESrfSXvq0CoyCidcBuvL17df6IIrefT56Rca0GQikuUe2BuhUGdkfv0/QH9JeadS
         xPggSIUUnzJlZ8VZ51g+Bf6jVWhTgeYvGRkpyvztGyRSQGCFG+xBW2GclYSaIlCTeLM3
         vvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CfZ00t9u1vOIZqmMouqMdFDmZ8z0MMaKVOmeI3srS8=;
        b=mxlzHT9R7KbXL8LlrcZArKWkX58uC7jNRlvAegJVHXlNeBjiT09SVYXhwM23UP0Fl4
         Id/PRAg6MZdZiGVlmNCpx1NllSZTwpdPf2fvqLm0VHImWrarzrzylVrA/xi6H4BsFtNS
         nF8RwaYJirfV/gEc/quI1PJ2+SDcN7cFfzFnyupplzGS5rgp2wl3Ul8Ncfs6rGp5+etP
         Vu+xOg0G6TUkrzljbSkcfu2kVdPPIPqRUp/nQtgoWL6ufY9yLz2RQRhIcJ5yGvrVDZns
         1RrLtq1qtD1Dxs026jKzi+XuyfHj4KPY/k2phbwnYZta/RmcyL3vB4EjKMnuFMPKj3DT
         ojBw==
X-Gm-Message-State: AOUpUlFMhNYDgTmOLL9LGSHzyUrQL/6PlrAho7UIZfh/cSRK9LxkRi0f
        My5wQ1Lbf79Od2foIiXWVoM=
X-Google-Smtp-Source: AAOMgpcc0QM2f/CBFmt07ohxXDrfu5fO6/0zgqed6kYAW0CqpRxZWe4s1D0XenTC9bO9fkmozATuPA==
X-Received: by 2002:a63:647:: with SMTP id 68-v6mr4322487pgg.205.1532660891609;
        Thu, 26 Jul 2018 20:08:11 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:11 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/10] staging: gasket: TODO: remove entry for convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:36 -0700
Message-Id: <20180727030737.231268-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Gasket/apex drivers now use standard logging, remove TODO entry for
this.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/TODO b/drivers/staging/gasket/TODO
index d3c44ca4fda25..fb71997fb5612 100644
--- a/drivers/staging/gasket/TODO
+++ b/drivers/staging/gasket/TODO
@@ -4,7 +4,6 @@ staging directory.
 - Document sysfs files with Documentation/ABI/ entries.
 - Use misc interface instead of major number for driver version description.
 - Add descriptions of module_param's
-- Remove gasket-specific logging functions.
 - apex_get_status() should actually check status.
 - Static functions don't need kernel doc formatting, can be simplified.
 - Fix multi-line alignment formatting to look like:
-- 
2.18.0.345.g5c9ce644c3-goog

