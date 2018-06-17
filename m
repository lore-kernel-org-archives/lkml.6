Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9200C208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBNFrI9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9200C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFQO75 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:59:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40927 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933393AbeFQO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so20986801lfc.7;
        Sun, 17 Jun 2018 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XI+Ekp6oLebrxyHk+0NQNcIuB5n9V+rr7T7zUg12Wew=;
        b=KBNFrI9lAhC+jy0D+QBoU0/4n+4I8u+V58jlUcAsx+3sgagb5Y/xf610edmxj64yrh
         Ca2EKX8Y1HqFWdtowZ3qD5zfRhI7n7cnAk0u0sf0EHiogZhbRq9YLpcG4SMc+zkfFlg+
         nO/+yL4fydP8TOUOolKQsau1YkZ71GGm+Wlfk/aPwuHFWr9fcFn5nfIHPBkHp9aIM5kZ
         xapI5T6MFsMJqPkfHSQ/MpZixgnNJGK4+rEmUqCrQpYIjQkD+AJ8altKtSRrkpAXm7Qe
         trePO1gH5JuMXSIXBdc61ap4toE5mHg4vZXCyBZb88Q9PSlveI0tOIWzPuO+7hk5pOub
         QwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XI+Ekp6oLebrxyHk+0NQNcIuB5n9V+rr7T7zUg12Wew=;
        b=sauWD4Zwt8BubpQfhQURz1KMnZoNYYP9eO/UqeWsaCBCpZuG5fn+EgFMLoXsbd0snC
         E6D9xE5JIuLxG6zEVonm+KpB7ZW/vExNANyOIgZ+6Y+54eF/O6z7ORri9kquwwyhRD1J
         qehkqHQUPwXmEZfCXCIOzXoy+txRq0lNaCX0zh9SBl+1v4V0LKpVKEtWStqkxSXhsRkj
         EGYFw5YuybuN7VWOuQmSIvPuzHYgTqbPjTH91VXAF4Hadz6ajbG7AtSiKA2h2QEygUgy
         FAHJFPd9PRXzbVmc7PZSthWP1uvjeNvuu9LNj96bxp9lV331UHdz6vO5GmQ6Qj5UXi0d
         7iFw==
X-Gm-Message-State: APt69E0qekxGIEp0nn0crRuVmWbu9NMyy2khyvRByit+ggYwPjYYH1ZH
        dTK65eCrILtAskWllwuavp8=
X-Google-Smtp-Source: ADUXVKK4YePG7X/YUWgpJ7a23y+k2Q0satDSpzJ1ok3JEBpIdNMXd2CWJaA1dsrdrYeX8/ezca8fWQ==
X-Received: by 2002:a19:d245:: with SMTP id j66-v6mr5646215lfg.139.1529247581350;
        Sun, 17 Jun 2018 07:59:41 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] dt: bindings: Move tegra20-emc binding to memory-controllers directory
Date:   Sun, 17 Jun 2018 17:55:34 +0300
Message-Id: <20180617145539.4758-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tegra20-emc binding to the memory-controllers directory for
consistency with the other Tegra memory bindings.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt      | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
rename to Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
-- 
2.17.1

