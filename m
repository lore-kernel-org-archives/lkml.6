Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DB42183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wt3/0n+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfAKJSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:18:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46521 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfAKJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:18:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so6508844ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CatBFT4UD3UyYIzL57sVRGcnSjILPik9Oqm2Ih2xguA=;
        b=Wt3/0n+EhKiKAvBx6BJt93aNhktO+0l+BxYn97S5zoIiuRDAIGrYV8xFZY4dlPD/xm
         066GdBmLTwmF92bdvKxnUWFvn3lpqVoPRaL1N/Hm3hQsV6kpLdLr9iIW2onXIBVKiUXX
         wnKidE/7JKiOclW5/lu1sFCEVj26cAtweLzzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CatBFT4UD3UyYIzL57sVRGcnSjILPik9Oqm2Ih2xguA=;
        b=PoWGr07h0L3fuIQUChPBNbLo6S6qlW5jAFideW2wMDKnFJE51KcuUckuvrnaF3dIQB
         TQwLgGt01nWhJhODmzZklChFLJeBMZGd37lgwKSrtlwF2LUTOSTiMDqLXHDjqcae1E4P
         +wqtJ25NWSu/6x+cN/mN1+sBSVvaJvbFmRz3fqG2J44UgeiTC9xFoqb6KRgGfknseNEO
         l70ylARxbTzBE3QJ1GhLN0h5MFHdZ0OFBBdrF7ulkTdiHKraIbRrQzKWb/VMe5x6PNrP
         piJcLYDmXBuWNY2WpJgkPfoBHv6jlPxmsMQtadT5NxXbkHXsfecVONbNyHLr7YMaEgcy
         dLgA==
X-Gm-Message-State: AJcUukcyUdJCO5tkVFgVbkPinPpEQjjiOAIfHtMXYcfIGmLI6O5ZvWei
        853EuTQlKi6zOdJ4gWc9g+6CwQ==
X-Google-Smtp-Source: ALg8bN67b7yeMg2EHiVjrf0NydERBLt0fs+CayPgx8MuP42CI0NREY7F/wLqK7FrTEhE/07m2hWsLg==
X-Received: by 2002:a17:902:14e:: with SMTP id 72mr13986222plb.287.1547198323885;
        Fri, 11 Jan 2019 01:18:43 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id h82sm137490651pfa.105.2019.01.11.01.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 01:18:43 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drivers: Frequency constraint infrastructure
Date:   Fri, 11 Jan 2019 14:48:33 +0530
Message-Id: <cover.1547197612.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This commit introduces the frequency constraint infrastructure, which
provides a generic interface for parts of the kernel to constraint the
working frequency range of a device.

The primary users of this are the cpufreq and devfreq frameworks. The
cpufreq framework already implements such constraints with help of
notifier chains (for thermal and other constraints) and some local code
(for user-space constraints). The devfreq framework developers have also
shown interest [1] in such a framework, which may use it at a later
point of time.

The idea here is to provide a generic interface and get rid of the
notifier based mechanism.

Only one constraint is added for now for the cpufreq framework and the
rest will follow after this stuff is merged.

Matthias Kaehlcke was involved in the preparation of the first draft of
this work and so I have added him as Co-author to the first patch.
Thanks Matthias.

FWIW, This doesn't have anything to do with the boot-constraints
framework [2] I was trying to upstream earlier :)

--
viresh

[1] lore.kernel.org/lkml/20181002220625.GJ22824@google.com
[2] lore.kernel.org/lkml/cover.1519380923.git.viresh.kumar@linaro.org

Viresh Kumar (3):
  drivers: base: Add frequency constraint infrastructure
  cpufreq: Implement freq-constraint callback
  cpufreq: Implement USER constraint

 MAINTAINERS                     |   8 +
 drivers/base/Kconfig            |   5 +
 drivers/base/Makefile           |   1 +
 drivers/base/freq_constraint.c  | 633 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig         |   1 +
 drivers/cpufreq/cpufreq.c       |  92 ++++--
 include/linux/cpufreq.h         |   8 +-
 include/linux/freq_constraint.h |  45 +++
 8 files changed, 756 insertions(+), 37 deletions(-)
 create mode 100644 drivers/base/freq_constraint.c
 create mode 100644 include/linux/freq_constraint.h

-- 
2.7.4

