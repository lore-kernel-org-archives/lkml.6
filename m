Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267EDC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B9D218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=voegeli.com header.i=@voegeli.com header.b="pUkXFgaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfAZQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:00:01 -0500
Received: from mail.tobiasvoegeli.ch ([94.130.103.102]:44762 "EHLO
        mail.tobiasvoegeli.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:00:01 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2019 11:00:00 EST
From:   =?UTF-8?q?Tobias=20V=C3=B6geli?= <tobias@voegeli.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voegeli.com; s=2017;
        t=1548517806; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=rTPsCrHuYp+USleLjf3giRB8e0noLRFiOizMfXy1Pi8=;
        b=pUkXFgaMTZFMSIOQHIl0fOE5O0UTGYRaFeoLQghLn6xt40e6tMQ4dqAHqy78LabrScRfNS
        z+fbHZCeWEguKRuVRF1fN4/PYxORdCwxOKMThRB6dM/L481y0d2uWp62wwN00IMcZqvgSv
        BIv1R6fnOiGhVUJ/jgJtPenacBWd0ljcK6fgiwBy7ZuDpBWk75TeumDPCbAn1YtY47c+Ow
        S2TlP0jItl7pHWx+Bf7jRe3Ac08ly41ikLyoQy/remehhB9/n45XB6vNaWMkRYYUDVxn3G
        soOCg7/eHVfmlAE5L/ItK+R2yDMhwzLRbjOiIH4C/cg4lkDC7h3atG4Co/KtXw==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?q?Tobias=20V=C3=B6geli?= <tobias@voegeli.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: elan_i2c: Add ACPI ID for touchpad in Lenovo V130-15IGM
Date:   Sat, 26 Jan 2019 16:48:56 +0100
Message-Id: <20190126154856.14060-1-tobias@voegeli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=voegeli.com;
        s=2017; t=1548517807; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=rTPsCrHuYp+USleLjf3giRB8e0noLRFiOizMfXy1Pi8=;
        b=WFmkEN6lETqFHCU2K+EmxmZNnNU6Enqt4BhJnVsuRXPd1YV98XUzBS7DX3D+DAvkHPUIOi
        qvmGkQeISihLtWlOwWJs5pSVEFziZcsErtYAkKyGlAjc8JK2Jbxm7V3BebBTVHKZFQtTBO
        Cu4PksDGk+FB4kf9GR7/WfTrSl/8kjYqdWgWmbVUJ+pTYQTme6KVMdm6Yk7QDZKjf/fXFs
        2maWKVLXTxEYVNKwNzpL5B36jJb1+ZHFJbeF6SMGhS21uEZW4V9NFrhof4KrQpgXqhqquR
        b0Npb8GMPKlXoALnkUQou1UW/z5G5U4ajLQqVrYQU494HLOZvufqv123Vakpsg==
ARC-Seal: i=1; s=2017; d=voegeli.com; t=1548517807; a=rsa-sha256; cv=none;
        b=kxg5zzgPMBlVqhpBqWLf2KBAhJyOa1pMR4DYMOCSi7OUzWtKpFxDQjs1E+tyXU2GiBS6RG
        9TSMR4VIzFxyqhDojDUWGkBUI0ZeR0lKSqEL3t74NL6GbDSSvXk+4ZUXVdN23yS+o20TBR
        8N9bM1lWd+DL9s1eHuXGEincGYGC8m/Kx3Xp32Vj2DiMZqNSVrIc0Pd4Ez8w9lV7DvB9Q0
        gvfHg6pQkEL4ZPQm2B6BQdyflbaIYBG2N3GnewWfDUovCzntHX/rX+tPkGruUP1kIDczzx
        BN2gIw1sacKWfnUtLp5V+dpQzqsSREM/zkd5ujE6HXLwtJ6bUCQdt4Vsz9h9aA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=mail@tobiasvoegeli.ch smtp.mailfrom=tobias@voegeli.com
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=mail@tobiasvoegeli.ch smtp.mailfrom=tobias@voegeli.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Vögeli <tobias@voegeli.com>

Add ELAN061A to the ACPI table to support the touchpad of the Lenovo V130-15IGM.

Signed-off-by: Tobias Vögeli <tobias@voegeli.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f322a1768fbb..4998b7007201 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1347,6 +1347,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN061A", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
-- 
2.20.1

