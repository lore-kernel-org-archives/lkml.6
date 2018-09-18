Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65201ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F53320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="lsu9YH18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOyCOfdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F53320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIRKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:54:01 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33617 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbeIRKx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:53:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC4D519B7;
        Tue, 18 Sep 2018 01:23:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 Sep 2018 01:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :content-type:date:from:message-id:mime-version:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=L65w7kO8n6OIxZymP
        w7/88csyH3+lObLjNG488sACHk=; b=lsu9YH1897uJjMsdeImA5A7dX0ShqzuN6
        VLjIZOmINPA3+srPgiJqLCzqSHUpe/o7bI8JpuiWNleI3MSFcE0IteZYmeMLu4yZ
        gkSE1j1ey7XpNxGw8mUkCk2cUs6J1KhhusnknOkVZ1xrh5zFlYsimSOfvgxqgREr
        cb4No2NZNZOSRaiAg9OGhBTkNTSnsCK+oQpK6CA7SzHojOQJu7JBTcrVLJjncD6i
        AJd6dntG6dcsRSP51+XsbE/9PmId62kQhxw7WMORXyb5Kd1snr4+53Nh1TCgEtyz
        Wumrsfwlkkn5+60kTnNrByEJAdhrKxWLOzE5091/269ILFhqDYLeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=L65w7kO8n6OIxZymPw7/88csyH3+lObLjNG488sACHk=; b=iOyCOfdR
        9oB1iHXL0SDgyr6oUY7pUAIhtc0ApctLUktbW9SAdlEfvQvKCUOowzSjalcsuGd6
        E43N+QAq1S6Hgt/cIJ02zIMQxmW20j1Ulyhs1ZWZKR/iyiS2ma956FVZJCXPAU7F
        TKr9XgRFD0U3SMRGx90O/qQHQbApVbLhpMnbI7lbNduao7m59Edw1ZRh00bgaYFx
        vVDqzwfEjaCLnlNOwbWMdu+NuAtcPCngIK5+59ujPUh0zpM2G4gugNfPR2dDWJMR
        oT/J5XPOe/ZxIPZIJ3gphMeNiczCuWTkHwDf8V0ytLZPYKu0DxrlZMLoF2jAZ4lZ
        AiMKZsyVJyxqbw==
X-ME-Proxy: <xmx:tIugW9cRLmYfhmOviypT1AbPiXT-BkeHzOJvJib46F5cXV85dPbg1g>
    <xmx:tIugW7a4If7UcItvALAqPglGAJPimF0b_zJClyDiLh1hsRG4fX6yPA>
    <xmx:tIugW4Vy8cO5NjFa0Jm2nFVuHcpi0xT6porpZfnjOPGOq0h96Kigrg>
    <xmx:tIugW1i-Ey0ic9GQVnBC3t4z_osIUCOZIc8y_g9I3td44z25D3iTHQ>
    <xmx:tIugW-UGI1X0Pqc8_sfM-EFE70vqlzYE7Lp6AZk1un07wq2oRt6-3Q>
    <xmx:tIugW1w9WkVLQ4-gsft6U_1UD27x7P-dZZvnWh_z4HAc71EvJVdnJg>
X-ME-Sender: <xms:tIugW9JgVVVJVJrr0G95fTSgLxad157OmjSKDYHNDlv94sVF_yHUPg>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id A95D0102D9;
        Tue, 18 Sep 2018 01:22:58 -0400 (EDT)
Date:   Tue, 18 Sep 2018 15:22:56 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH] Input: uinput - allow for max == min during input_absinfo
 validation
Message-ID: <20180918052256.GA23446@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These values are inclusive, so a range of 1 requires min == max.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/misc/uinput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 96a887f33698..eb14ddf69346 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -410,7 +410,7 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 	min = abs->minimum;
 	max = abs->maximum;
 
-	if ((min != 0 || max != 0) && max <= min) {
+	if ((min != 0 || max != 0) && max < min) {
 		printk(KERN_DEBUG
 		       "%s: invalid abs[%02x] min:%d max:%d\n",
 		       UINPUT_NAME, code, min, max);
-- 
2.17.1

