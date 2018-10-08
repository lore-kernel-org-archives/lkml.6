Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207CDC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AAF2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA2aissO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AAF2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJICz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:55:28 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40088 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJICz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:55:27 -0400
Received: by mail-qt1-f170.google.com with SMTP id b4-v6so14180891qtc.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VqWKYRDiJ+wDs8ZDgOXr0wxPSb4FlJ5du6PK5/1ru4U=;
        b=jA2aissOC65LFYvlY/h4ZCxfN2yGpZIkPL4PMKNQv+iE4LkacIZysAM2jLTfGO6lIr
         qCLf503wHjKvIjcq8ZuKvDQfw61GyV2ixBDRwMARmRVSib9HGMLBq2xh6PNa4T2Avs5g
         i3TqGUkXw3M60jpeNYsJBO8pl0ZDHxEh/tiCxuaKieXYeBMm1f+IJlMj+k6RFy75hEQi
         Fzj79felqhfMtzkwqb91nukTHtJXRy4ILP4AHFOZR0sLNfDzRMEdMS/RDndqmWZQitSr
         hPKPaiIx6Vb7qoLZIS2We8qdCucFS9tSauS6Z1dsvEx6uKk4x4KWD1c+1QipGV6icXoB
         og3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VqWKYRDiJ+wDs8ZDgOXr0wxPSb4FlJ5du6PK5/1ru4U=;
        b=gfJri7sPxhcSaDSfhKRLyuF5ZypJL5NpL79j9PFhHQ3eMyIluHV9y2Y6xvWHxdDUop
         KNROn+eVS9oZkwERmJO2cnj5Eh9GFHkqIBNltQAkwhMB1iDziQVbj3CZ4ZXAM8fQ2pO7
         2+QrKFT77VfcFT/jQ44QyeGpvXROXqMxfs8nhXasQTkgFLNh1Hnje9MU/qfd4McDUZwf
         SYdFPC1o+Zl/UYTkr5G7yWNN8HJK9TptWddaLmOpssAXZGExN27DS2ZUgFUxHipuz5Pb
         EV5WmjnLFnOXzfeLpjI2bkahzrvm9tbOgpOqV4dhB6HRCO8io/AqMu9RFwIweIEY3Dbx
         FsMw==
X-Gm-Message-State: ABuFfog/7rMXZ0ytQju3ULJZeon4rAxMKQZ/6dVjpo2Jt6pYILJ7Nhli
        gCsl+Y/rgjGAWrLqc1GR4Oo=
X-Google-Smtp-Source: ACcGV60XZty9zK4oIxjwDoIRPNZxY3BUBVfl1RIVmVI1caW3E9MQ4J7etOm72/fCfL5tvIwJFFtW0g==
X-Received: by 2002:a0c:fb03:: with SMTP id c3-v6mr20148520qvp.146.1539027726114;
        Mon, 08 Oct 2018 12:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:f812:c27a:7560:4d6a])
        by smtp.googlemail.com with ESMTPSA id 76-v6sm13220644qkc.41.2018.10.08.12.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 12:42:05 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Various cleanup + Mic Fix
Date:   Mon,  8 Oct 2018 15:39:56 -0400
Message-Id: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the microphone inconsistency issue, which means
the microphone now works all the time on all of the cards I've tested
(ZxR, Z, AE-5), along with the input effects.

It also includes changes suggested by Takashi Sakamoto, I believe I did
what he asked properly, but if I messed it up I'm sure you guys will
let me know.

This should finish up most of the ca0132 work, with all inputs and
outputs working on the desktop cards.

Connor McAdams (4):
  ALSA: hda/ca0132 - Fix microphone inconsistency issues
  ALSA: hda/ca0132 - Clean up patch_ca0132()
  ALSA: hda/ca0132 - Add error checking in ca0132_build_controls()
  ALSA: hda/ca0132 - Fix input effect controls for desktop cards

 sound/pci/hda/patch_ca0132.c | 75 +++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 21 deletions(-)

-- 
2.7.4

