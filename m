Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9829FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FECC20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqSvdmMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FECC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeGWUmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:42:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34765 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbeGWUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:42:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so1857438qth.1;
        Mon, 23 Jul 2018 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EetDdkfzQq1DCrWVvEBAKcSNoUFGaPcd5cLpziQaoLs=;
        b=QqSvdmMmzh8p2+Yuw60LGDs/3idk4XO3991sNeTz6VkKrts2iueM+q9IgWl/WGMKOE
         iuVe1tg2wyBWHtBukdbapWh4a7yF2q5hregtmuxCD2OfvtJun6/r5DEcpTUKbD6nO+UU
         Y2toi7EleL6zD6GieS/7eeq2pwDmDJWY1ubL/v5Da5JFahNLnJGGzGDmf9S8Qz11dv+e
         088tvkkLAhDgvKblpS58Dr+b5EVEnbtIPUFrUTJivzYEelWxi3AsRqXIIz6tKyvjK3yQ
         7u4p+DOc95xp5Xj6I+ndKrHpqa8yExhlJiEbZn8ShgcOYrdf2ooiy3SK6fHLnaR8qdUC
         eJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EetDdkfzQq1DCrWVvEBAKcSNoUFGaPcd5cLpziQaoLs=;
        b=dIbQGEcITFGrL4O3C7Ma6QIXSTUbfpZN2GDnKm1ggWBaxvdnswhQowHRcKumjsbQye
         7F5YnFrXRDqrQwbzy1u+V7BCAWadVRqsT3y5rT2uNSmfu17OmICYbXbC5XlNKjvoU8Lu
         traLLhe62UnhEnm4I3+GSwFtVnGpzXsI+lMh3cVv5BI1wX/gQiPW41GcNkdFafyK8Bs0
         tm0/rncKg/wvEYXX3zE0ajcoMMme25+QR4FC75LtbPc/OElRYpmwEQy+Ga/muR/Hr3hQ
         JOX9a61vNqaAeb9CPE4vJP7pKbUW2t8TfexXeH6AqSARLHlvA27bOT8zArc+Q5Gf4inQ
         XuSw==
X-Gm-Message-State: AOUpUlH0ukmCKhRNqQUsTMW2mH2x5n9lex+7l+TqwSptp6SxttZFSvJW
        0YdL2R8ekejXQxFMPgDT424=
X-Google-Smtp-Source: AAOMgpcQZlYa8+9PhB/fAfM0DQmrICHXC9I/7TJqhK1BGHp++waXFoAp6OIuvsm/S6HbRisodV2P8g==
X-Received: by 2002:a0c:81c8:: with SMTP id 8-v6mr12048502qve.53.1532374789757;
        Mon, 23 Jul 2018 12:39:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-134-220-116.hsd1.md.comcast.net. [73.134.220.116])
        by smtp.gmail.com with ESMTPSA id 16-v6sm6863042qkd.93.2018.07.23.12.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 12:39:49 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 0/2 v2] Add support for cpcap regulators on Tegra devices.
Date:   Mon, 23 Jul 2018 15:38:46 -0400
Message-Id: <20180723193848.32491-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

I am re-sending the whole patch set again.
I have sent this to myself, and confirmed it still patches cleanly.

I apologize once again.

The CPCAP regulator driver can support various devices, but currently only supports Omap4 devices.
Adds the sw2 and sw4 voltage tables, which power the Tegra core, and a DT match for the Tegra device.
Tested on the Motorola Xoom MZ602.

v2:
Stopped reinventing the wheel, using git email now.
Rebased against regulator for-next branch.

v1:
Fix conversion of tabulation to spaces.

Peter Geis (2):
  Add sw2_sw4 voltage table to cpcap regulator.
  Add support for CPCAP regulators on Tegra devices.

 .../bindings/regulator/cpcap-regulator.txt    |   1 +
 drivers/regulator/cpcap-regulator.c           | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)

-- 
2.17.1

