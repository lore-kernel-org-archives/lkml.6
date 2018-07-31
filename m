Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBEF20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNZXGln2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBEF20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeGaWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34181 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGaWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so5864103eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7MS+JxOFpsV5JMoRE+e2AmDBIzBuyz5q5/HypOLE7Mg=;
        b=qNZXGln2+JYXY93gjj7ngVMcxm1QA5l6OSZOG0YVbK26BsLJs+Q17lAZH2v+Ycgfbp
         NOE8ZbetXorDpxI9yrNEF2WuTk/PI1pmunB7mnoYX8EbC4d2gaXMKFn6Q098cC8vr7/P
         JqkwU9y8Q/xKOiZ9mcXVHhrzqNjpiw/zG0AO9GC3osPXqG4up2BvikUKRL7t0aMsKkGp
         epq9nmOvS9k6P2vseROrOuRDhRLPgaJKdZ9XuUVokBdDkdzX7vYtzgdoXI/LUF4oieJP
         6ImkzkP3nhDsfj6qjl0q1cBHx2tJ540HGxbh8mWicnQiFGDkTSn2iEcwUvijXnJ7ENv5
         X6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7MS+JxOFpsV5JMoRE+e2AmDBIzBuyz5q5/HypOLE7Mg=;
        b=eMq/FVLjD0GjiECX8z6JZkgo9ODJLR9Y/a2/UgiXRcJvxSA5smekhVPGbE3/wkb2Mu
         hB6LQZ3E6fhGO1vmgAr2CFQTyCJxczx1p/FDjtZRBq2chzPrL4soq2CKmd/Euba00PZu
         ASFaY9g2q60hdPwv0zMMAYOqVGM0SR+qnZBWtL3AGWnarXYb39uzwv54FCN2DdNp/8lF
         j+OyrqRmlYwgp2nN0ZfnH4sWATuCH85OBqSXh1wUBzyOCsK4mhHaliAjYJdcxkFDPTx8
         A06/Ian5i8/mmQschtBd42GBkf0uFf83s3Dvq5ZzA+9VY2DxRpDOBlLHhcajgE/SS5QW
         Ec9g==
X-Gm-Message-State: AOUpUlEEkhNTDf2NNkVRWpw/yEq737UinQLA5myOW4DY6TFnJBD5j0LZ
        Slg8j9/QBp76/EDSUmNHTFHkE5Fl
X-Google-Smtp-Source: AAOMgpfyqTwkcxhYMhfTqGeP5ugxrk+puUR5p21k7RdsjLs+pvV7lYFYVJpS4+VV25fVI2GqSoJYGQ==
X-Received: by 2002:aa7:c40a:: with SMTP id j10-v6mr1145739edq.134.1533070828733;
        Tue, 31 Jul 2018 14:00:28 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:27 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/14] staging:rtl8192u: rtl819x_Qos.h style changes
Date:   Tue, 31 Jul 2018 21:59:51 +0100
Message-Id: <20180731210005.17452-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a change to the block comment on the function
cmpk_counttxstatistic(). The function is a static to the file so the
block comment could be trimmed. Unfortunately I could find no useful
information in the block comment, apart from function name and list
of parameter types, which is included in the declaration. As a result
I totally cut the block comment.

All the remaining 13 patches fix coding style and checkpatch issues
with the file rtl819x_Qos.h. Possibly the major change is the
truncation of a number of unions to the structure which is actually
being used.

John Whitmore (14):
  staging:rtl8192u: Clean cmpk_counttxstatistic() comments - Style
  staging:rtl8192u: Remove union from aci_aifsn - Style
  staging:rtl8192u: Remove union from qos_tsinfo - Style
  staging:rtl8192u: Rename members of struct qos_tsinfo - Style
  staging:rtl8192u: Refactor union TSPEC_BODY - Style
  staging:rtl8192u: Rename TSInfo - Style
  staging:rtl8192u: Rename tspec_body members - Style
  staging:rtl8192u: Remove commented out code - Style
  staging:rtl8192u: Move QOS_TCLAS to rtl819x_TS.h - Style
  staging:rtl8192u: rename OCTET_STRING - Style
  staging:rtl8192u: Rename octet_string members - Style
  staging:rtl8192u: Remove unused UP2AC - Style
  staging:rtl8192u: Rename IsACValid and add parenthesis - Style
  staging:rtl8192u: Change clock comment - Style

 .../staging/rtl8192u/ieee80211/ieee80211.h    |   4 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  40 ++--
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |   2 +-
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       |   4 +-
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 207 ++++++------------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  53 ++++-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  36 +--
 drivers/staging/rtl8192u/r8192U_dm.c          |   4 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c      |  18 --
 9 files changed, 160 insertions(+), 208 deletions(-)

-- 
2.18.0

