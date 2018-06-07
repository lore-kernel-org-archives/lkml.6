Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fsxqBwN2GVsiEwAAmS7hNA
	; Thu, 07 Jun 2018 18:15:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF8746074D; Thu,  7 Jun 2018 18:15:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7A91C605A2;
	Thu,  7 Jun 2018 18:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A91C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936192AbeFGSPJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:15:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40094 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936085AbeFGSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so6618937plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l87pru/hJq7KIqhgAMsjgim7+sLmP1e4GWRknoRnGys=;
        b=c1yl98Z+xOLB+fiTFQnqxizffN9i3+ZpF43NjydX8yctuTR6zRqPqUIkmZk4B6nfSd
         Q+4GbgjmA0xmS6sQuYW4LunE4Yc1gQiH67fvqWdyVSlHRaiRZFfo3TlCnhyw0U6Keqh0
         mGBNDm1T6YkryXMRDmFFtKTQQIIpfRrtrZt+WgvgHISctaIA6m59kZVE5V3WR0CldFN5
         xT4oGXdE2Dk72SawHrUM4rCIKM/ERYH/thc2zT+WE2JAE46jN88i5icT/tnB13IkF2CF
         LSXlxlJmqQ8ggKHXrk4e5QCxBTBbR9in+e3vekjRw5C1JIMKdTMqsyYS3ZyhFoy2MzRj
         JLyA==
X-Gm-Message-State: APt69E3B8/dEvUl86JlQpaxC0Jfi5WN3JUzYTLb7AoSxuamvAw/MVrVj
        s51GGkbYnVjQn60Z1VlynNfZUw==
X-Google-Smtp-Source: ADUXVKLQkUlumqXlZKeEJcYipFyQf5lnMTj6FZW8IDYeUK659ZY+e80ik9LsmyNyb3Sow2aT4VM9CA==
X-Received: by 2002:a17:902:2702:: with SMTP id c2-v6mr3009239plb.297.1528395184186;
        Thu, 07 Jun 2018 11:13:04 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:03 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 08/11] dt-bindings: PM / OPP: add opp-throttlers property
Date: Thu,  7 Jun 2018 11:12:11 -0700
Message-Id: <20180607181214.30338-9-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optional opp-throttlers property is used to configure the throttlers
(see drivers/misc/throttler/*) that use a given OPP to throttle the
corresponding device(s).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to series

 Documentation/devicetree/bindings/opp/opp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 4e4f30288c8b..b10240f07d30 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -167,6 +167,9 @@ Optional properties:
   functioning of the current device at the current OPP (where this property is
   present).
 
+- opp-throttlers: Array with phandles of throttlers that use this OPP to
+  throttle the corresponding device(s).
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
-- 
2.18.0.rc1.242.g61856ae69a-goog
