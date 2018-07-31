Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5853C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3B208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="T08XAb2S";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="AVVgs424"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF3B208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbeGaTbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:31:04 -0400
Received: from node.akkea.ca ([192.155.83.177]:55556 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbeGaTbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:31:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 0940754204F;
        Tue, 31 Jul 2018 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533059380; bh=LCvAluqkiP+VTCj8ZHjsnt9HHG6OceLaCBwDc+bK2Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T08XAb2Sp4iABWHD5hp0qgI2jaVvg719oO0/Ni9aVaHUOc3p2iBjK+80mBqfkyhA3
         J2nTKPS1Gdx4ru60/yE+eKkDTbdv7EcVbGO0vvkZOzyzNvtMaYYSyBwSoGZztRvVmo
         QAUcaB1UOf1GVnhE0sWDWxiWU/IJVjLDSfOrtqMk=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iay_BgYX3oi1; Tue, 31 Jul 2018 17:49:39 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 3547354204A;
        Tue, 31 Jul 2018 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533059379; bh=LCvAluqkiP+VTCj8ZHjsnt9HHG6OceLaCBwDc+bK2Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AVVgs424hPoaO/50QKmN69pHruFLfxSZbUP4X1YKj6o9y4GuWDZuJf4FxtGtJydaD
         I3A1/OnOUrBDUnwT7KHLaaPZkAhhwRSk5zGDOmN5+p6w/aweXAc0FX6UfiOurfMDba
         i6CRYNMLu7kAlOiL7PBRkx5bSioG8CsNDB/gqGk8=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 0/4] Add the BQ25896 charger IC
Date:   Tue, 31 Jul 2018 11:49:05 -0600
Message-Id: <20180731174909.9392-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:

Corrected reviewed-by tags.
Fix typos.
Clarify desscriptions of patches.

Changes since v2:

Remove additional un-used table entries.
Use the exsisting compitble string for the new part.
Voltage now doesn't depend on state "online".

Angus Ainslie (Purism) (4):
  power: bq25890_charger.c: Add debugging output of failed
    initialization
  power: bq25890_charger.c: Remove unused table entries
  power: bq25890_charger.c: Add the BQ25896 part
  power: bq25890_charger.c: Read back the current battery voltage

 .../bindings/power/supply/bq25890.txt         |  3 +
 drivers/power/supply/bq25890_charger.c        | 62 ++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.17.1

