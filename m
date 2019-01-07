Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E342087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUbXKb3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfAGQnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:43:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36024 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfAGQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:43:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so430441pfc.3;
        Mon, 07 Jan 2019 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XA/YEBAaRCRy54J6ny+C26wLRosYeRAs37d+onQTZGQ=;
        b=rUbXKb3bIAE6BPdXlndxjVqG04/G7MmG/drJU0OVxVH/v5PX+Ufl8g9lkaq2x9CtXi
         BqYCn5a77ojrOAPpbb4S+DcGGpmOzF5xGIwPTRFJ1S/ixF3g/HTEWccIAtigMYZQyaQp
         l1n2HsdPg7zdccGnXY8zRPTZ8gq8bmX9LUOvB2J6DrBMhX4mv87WIjXFjkOsLznbh/xj
         2CHvzBd5r17snTsIVK43KExgpvvu7hsgylHcq2vuAXe1ycMcD7l8B2qhYhxfq/afjcjd
         d8VD3EV1dzwsW3MCGcLSuy8QYvX19gDl4z4fHfU1WpYiXWgSeVZA9Ei2Hj8K6eyrFTx0
         pX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XA/YEBAaRCRy54J6ny+C26wLRosYeRAs37d+onQTZGQ=;
        b=FWShySQVei2mWemOGHY6JFnRLqZZ2sP871LFmVrQfBvnxpXsPxZdRwCfaCPRM4H+XS
         hJbqMKGKuzcpxLDmPpWAIcqlD1xGDLdCo1q5oKItO3SJDF9IQNsNtsh3DPbsE66gqT6d
         Q9lK9QdQHt1ZK/GWiOW/X1oipmuDKjxqzHTF64waWxDiV2DqsRU9B3tpV4Ydu7F5EBMN
         yl3+w4bxKGk3GHCaH+dzjzTESykIpZYbGulV9ObDeTtWvRf+J6ZEpQnf0PNrmNJoiSY8
         4eeIj0KpaC7O+IWdLwc6JTF9QxTkz9nN426L8pLGPBzbB99exAXRMZAHzXY1QxwRwqGk
         MVYA==
X-Gm-Message-State: AA+aEWb3oGd5Z+radMf9Fmbd87RYFX+tn+QAEBFbfC2+gCeNL8fljMaV
        Du6P/ckw7/QN91LJq6e/X39XkfqU
X-Google-Smtp-Source: AFSGD/WcMetHhyf1W80+2+SwjsmkC7dfBnYZ2sOjznoJDw40RWXZhCi0/3XZ3Ufbu1GUthCqUiztkQ==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr64448277pfe.130.1546879402402;
        Mon, 07 Jan 2019 08:43:22 -0800 (PST)
Received: from localhost.localdomain ([121.161.238.230])
        by smtp.gmail.com with ESMTPSA id c72sm118865326pfb.107.2019.01.07.08.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:43:21 -0800 (PST)
From:   Donghoon Han <nazgul33@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] input: rotary-encoder: Support key events
Date:   Tue,  8 Jan 2019 01:42:47 +0900
Message-Id: <20190107164249.2342-1-nazgul33@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports generating EV_KEY, instead of EV_REL.

An example could be a volume knob, with key events:
 - KEY_VOLUMEDOWN / KEY_VOLUMEUP

[tested on imx6q platform,  full period, half period]

Donghoon Han (2):
    Input: rotary_encoder - Support key events
    Input: rotaty-encoder - Add DT binding document

 Documentation/devicetree/bindings/input/rotary-encoder.txt | 12 ++++++++++++
 drivers/input/misc/rotary_encoder.c                        | 24 ++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)


