Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9AAC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333B92080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="VvoyQrlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333B92080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeJWSa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:30:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbeJWSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:30:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so1011707wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eo1h3lme0L1UKWqk4LKImM0LJVO7McBJCnEoDOyArfM=;
        b=VvoyQrljODXQ3by3KE7NdQSwwegruIgVU6a0O4BUH4WYt4j97b5S5C/+T6ozYxzF60
         9QC+oDHMUNzTjauH9RBwOvmP2KQKIV0i1LdzXB/lLOxwlhOhcNgqgPQz6aRfwFEB22d+
         zmxfhy8CwrI7HY0EhcjOq3jjHcvfh3DI7rVDElXwE8g2abzO8LK1TW5YZ+O7Z6GIz3M2
         zeP0ZMqKFlm5XYAeNs6ibz5HaRfWj54fSgp9e5L5uaIbX/ASJCzMiZWYDqGcT5X0FWZN
         F/+lYWBV8bRJ/VQ+jUk9zi6afYXfn60EbEdTiP4hp4eyMYuwnaJGSASw2j4C1E77o8JM
         Pkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eo1h3lme0L1UKWqk4LKImM0LJVO7McBJCnEoDOyArfM=;
        b=tmX3zkLgw13UgI7Jr7pAJsS53hMw97dSS8LQlv12vd5lmopO/dufxUI8gjrpnmMLtb
         5soD14VXRyjzpeu9yHyVeb9LCsJZbUmZgiuYOt884zm1FG1dfuYBcRHaVUL3F67i6ncu
         VxlZc4EVxnZe0IXYdESwMn4Up8uC7ESlyz1lQzHYu4CVmfUSg4kGsXWljJcvt1oJJycs
         /Jbn3l2n+qQvcinvKN5bR3yYo7WfzjErO3A9B/j6kDigSinEkjV8/nHDpmcwWI0Mi6jk
         bPQ3wzcYEhEN0pLmFWCtMqT1c7/33d1jYJi6H8FmwaZcIaGV7Qq/ZEIODF6Yq3Z6vZo9
         6RoQ==
X-Gm-Message-State: ABuFfohmpJEvPPLr4buIfn16SWFqA24lSjf9J4PzXkJj+10RwFQoaiM7
        5cEudCqZ7Qmp3/QM5HHCMUWTDpTJe60=
X-Google-Smtp-Source: ACcGV60ycONnIf+XIrgGxHUb0ftkdxbjilclXX0UcX1CYlwK/TXIz47vW1VvDRHRwYUPJ8il3oe3Cg==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr48058932wrm.106.1540289262089;
        Tue, 23 Oct 2018 03:07:42 -0700 (PDT)
Received: from jaya.substantiel.local ([92.103.140.194])
        by smtp.gmail.com with ESMTPSA id i13-v6sm910930wrn.62.2018.10.23.03.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:07:41 -0700 (PDT)
From:   Anisse Astier <anisse@astier.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 0/3] sdhci-pci voltage switch fixes
Date:   Tue, 23 Oct 2018 12:07:26 +0200
Message-Id: <20181023100729.28864-1-anisse@astier.eu>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya> <20181018102112.31054-1-anisse@astier.eu> <88d3fffb-df8d-f29e-f7c1-3bef815435d2@intel.com> <20181019092513.GA2150@jaya> <89d02cd8-c910-76fe-3b08-5dd056ba8a11@intel.com> <20181019134237.GA2762@jaya> <e329ed2e-75b5-e9f0-04e8-097594003e66@intel.com> <20181022091436.GA18413@jaya> <656f1d2e-e27a-cee4-78e1-774e45f067a6@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This new patch series changes the approach to enabling the no-1.8V
quirk. We determined that not having the DSM method might not be a good
enough signal for the board/eMMC not supporting 1.8V.

It now uses a DMI quirk; I've also added another machine which benefited
from the previous patch, but for which the issue is harder to reproduce.

I've kept the previous cleanup of the voltage_switch callback in an
optional third patch, but it does not enable any quirk.

Anisse Astier (3):
  mmc: sdhci-pci: disable 1.8V with dmi quirk
  mmc: sdhci-pci: add new machine with 1.8V dmi quirk
  mmc: sdhci-pci: only install voltage switch method when useful

 drivers/mmc/host/sdhci-pci-core.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.17.2

