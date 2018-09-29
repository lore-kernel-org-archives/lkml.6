Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C55C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86532073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZildRrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86532073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeI2IGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:06:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41737 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeI2IGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:06:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so5412439pfi.8;
        Fri, 28 Sep 2018 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VZXslVk+cvqMR1PrqjIW6LO9SlczLJeNwxQXbQeY7xA=;
        b=gZildRrI4XE8d5tQMJhXwoIK2LspbieqBJxLYBHkmDd3WgEm9LyC3Q3JWZj1MXJce0
         8vORKeos4vqvsePbpG+wTKJz9yga6SE+h6MjNUADLe7c1Wvrk5J7peDD4q/I7wS4ccCY
         t7emm6N46gOGYfr9OYzggK76+6GewrVvyJCQun5rdDrxTM1lZ9os2CeQWTEdkqofMX7J
         Tf36vU2327smAgczCs1UwE6kn0NBKoHOMA8hxLkNiEnM1TINzRB37JPmhu5R48l/1B4D
         y7FXhdIjUKf5uwFOJzgGhdyjasYLii0T69MR8QfCJiP0WJ1noQKc4y/1U1jY2GAabqKa
         r/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VZXslVk+cvqMR1PrqjIW6LO9SlczLJeNwxQXbQeY7xA=;
        b=EvggJu+SfhSnaH7b74DnJz430cMv3z3RaDst5LBjp+ld4oXkdnqsFxcqj2cQayWHLg
         3p1OqTrs5yMGSREXlVOFAatQvycp7VeeFXjIUY8XYblsjY7PX4VdaBxAC5AXMEJ7Nvkb
         PGlJbBRJEEqrDEHLNqjTe0t2iMt00W6DHtI0pEUwVrEzqWELed0TaR6Z6BSBBezL3XTO
         3T/rvgQEVixsK0pwdRpz9RhnCY9TGMQC5LzdGengvinBr9yItxYwzBmY85kWP93QjZgu
         If27rGkk6fivfwi+mIYpEr0hubtYQnnAYOWBNG6Z9zL8yVTkxcvj0C/Of3XdwqBPnxyL
         2ZSQ==
X-Gm-Message-State: ABuFfojEoCKHFBI959DGiycABKfYNZhJZUWs1oN3GChTGcjas10YyFrE
        w6Y/+DsE9e/QZFAAT8yt3L0=
X-Google-Smtp-Source: ACcGV625N8fqEvN3hF9YiRLUeVedKn6mWRO6aU3Vj1MiF4WagAKz/0P2f58XYF5qrq5pXRoJVjn9zQ==
X-Received: by 2002:a65:664e:: with SMTP id z14-v6mr1023699pgv.347.1538185187902;
        Fri, 28 Sep 2018 18:39:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8732813pfm.137.2018.09.28.18.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:39:47 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v8 0/2] Add an initial DT binding doc for ina3221
Date:   Fri, 28 Sep 2018 18:39:35 -0700
Message-Id: <20180929013937.29289-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
v7->v8:
 * Refined two places in ina3221 driver (PATCH-2)
v6->v7:
 * Refined the example in the binding doc (PATCH-1)
v5->v6:
 * Removed status property and merged examples (PATCH-1)
 * Added in[123]_enable sysfs nodes (PATCH-2)
v4->v5:
 * Changed two property names of child node (PATCH-1)
 * Changed the driver accordingly and simplified is_visible (PATCH-2)
v3->v4:
 * Fixed one place in child DT node bindings (PATCH-1)
 * Changed the driver accordingly and added is_visible (PATCH-2)
v2->v3:
 * Fixed two places in DT bindings (PATCH-1)
v1->v2:
 * Redefined DT bindings (detail in PATCH-1)
 * Changed the driver code accordingly (detail in PATCH-2)

Nicolin Chen (2):
  dt-bindings: hwmon: Add ina3221 documentation
  hwmon: ina3221: Read channel input source info from DT

 .../devicetree/bindings/hwmon/ina3221.txt     |  44 ++++
 Documentation/hwmon/ina3221                   |   2 +
 drivers/hwmon/ina3221.c                       | 234 ++++++++++++++++--
 3 files changed, 266 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

