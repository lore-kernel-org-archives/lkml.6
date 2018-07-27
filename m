Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F851C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2A820857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0VUME8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2A820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeG1Awm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53016 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbeG1Awm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so6824928wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Ye11sIJ4IO8P0wpeDq9JopaaQ/pj3KMQizlFziffNI=;
        b=N0VUME8Q55IlMlPPqd09/ocHkZ6aaeaN1JKyRe7fDDcnMwhY4HUrD2JPgg783tV0nX
         2SodwGGnm8BP3nP1bPxj5KZocG/nYZjylfiQC0mFfVKoM+0CNB2TvbTpIYHQiMIe0tQ2
         T/KuUKveSIEcYy+rlRMK365bSCAs7B3W55TN4rE7lyDgeAQ7Rj7CjMtOWcP8ZLwblTke
         0F4IFTRNSGAoM0hPYB/PZQkFciypBB9V7RpUl6vdlFG0bYqE5a5vy2NYxgeC9p635rF1
         6Y9Zd6bVBibWqYD7+fXVaJKOkt4wQiNnCP+vbMor7CzKihvS26I/kuamvz1DLv8+OYfg
         kkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Ye11sIJ4IO8P0wpeDq9JopaaQ/pj3KMQizlFziffNI=;
        b=LF1A1JQWH3JaweUKkMmrejQHqoSo3rrPZN3S7SZBvLwsv8RPKjIQyOz7Qas4Xn4xiT
         s4wwG/P6HrSAqJ1CHZBka86UouO5wCTfyVwlrds8bvizrBkWVI87VCjjSiKfime8me//
         OfsfhueezYa8tfElaci5z/gUvLlh7qqrYcuSAYKuEybcPDWrI6oT8skc3ciNOOTdY7ec
         HEM6qMk6JktJOGSKmDZk+BB5CecAFqhpzua6Komhb5js7ypPH7m/nv7qd/vwHhhEcsKo
         X5FfqlXT3BXHGzFLUy4UADIsVca/5sj97odead569uu7ELfP+E+9TCqYM5fmLprAJDPD
         dwAQ==
X-Gm-Message-State: AOUpUlFVfE9VC7+3X3ShHyyVGaa9Y+qw5mDihM47LU7WOwrZffKdcJGY
        L84/2z7+cAwxL19coDZjyRTWsTCBpbo=
X-Google-Smtp-Source: AAOMgpeODAN8x2JdFCG2Cl9EsehwoBWvB5xN8E6jVgu3fIbOou5eqI2DnP/IE6ZfMUs+TO4k/0j6vw==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr5680903wmi.152.1532734113496;
        Fri, 27 Jul 2018 16:28:33 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/10] staging:rtl8192u: Refactor enums r8192U_dm.h -Style
Date:   Sat, 28 Jul 2018 00:28:16 +0100
Message-Id: <20180727232826.28014-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What was intended as a clean up of the file
drivers/staging/rtl8192u/r8192U_dm.h turned into refactoring of most of
the enumerated types defined in the file. Most of the enumerated types
were simply used to define a collection of constants, rather then
actually using the types as enumerated types.

So the variables which used the enums were all defined as being of
type u8. This removes the ability of the compiler to do type checking
of the types used. To correct this all u8 types have been changed to
enums where appropriate.

Whilst I've called these patches refactoring they are all essentially
coding style changes.

John Whitmore (10):
  staging:rtl8192u: Remove unused DM_check_fsync_time_interval - Style
  staging:rtl8192u: Refactor use of enum dm_dig_sta_e - Style
  staging:rtl8192u: Refactor enum dm_ratr_sta_e usage - Style
  staging:rtl8192u: Remove enum dm_dig_op_e
  staging:rtl8192u: Refactor enum dm_dig_alg_e - Style
  staging:rtl8192u: Remove unused enum dm_dig_dbg_e - Style
  staging:rtl8192u: Refactor dm_dig_connect_e - Style
  staging:rtl8192u: Refactor enum dm_dig_pd_th_e - Style
  staging:rtl8192u: Refactor enum dm_dig_cs_ratio_e - Style
  staging:rtl8192u: Refactor enum DM_CCK_Rx_Path_Method - Style

 drivers/staging/rtl8192u/r8192U.h    |  10 ++-
 drivers/staging/rtl8192u/r8192U_dm.c |  91 -------------------
 drivers/staging/rtl8192u/r8192U_dm.h | 125 +++++++++------------------
 3 files changed, 51 insertions(+), 175 deletions(-)

-- 
2.18.0

