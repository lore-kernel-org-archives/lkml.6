Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A5D2417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="OnIpMRpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A5D2417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeGEF7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:59:31 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34908 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeGEF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:29 -0400
Received: by mail-wr1-f50.google.com with SMTP id h40-v6so526215wrh.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vUJD4SCvihnjfphFKwNmNmLRqX8o58P/Iv6Re/5Kcqc=;
        b=OnIpMRpxjSaWQ5IKbx4azpB6n1odzBolX1b9L55DXlYGBs1EOBWSOFkCWJvg2NdFqy
         8wvtnPn2wIGUGedluwIzyvLRJB57ZgibdMly+nwx3B1ZuEWXTKb6Dp/yQoyHpTqfJUwQ
         LDdeof9WGXKhw3ELHo9BEqsuof6NG60pgwJRHNU8G7oUYu7ta+4NGG6hbsYEeEj+m9HT
         QrIDhxGEg/qesf/cn96trFn4aEJsGoQ2S1Q0GG5CmolDjd92cCrDw4muE6plcQbPVJQ5
         9V/YRcUrbhIlopPEeQ1LZaA69v+J0dZYbsBg5d9otytM5eW1MsNbG1OEURSuRc2YWrun
         M70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vUJD4SCvihnjfphFKwNmNmLRqX8o58P/Iv6Re/5Kcqc=;
        b=kILKfrmWcVRHwDw2YyAvgOWIAb+qrKb7AQoaMPUnJ7mih31o9ITGuFE+ALvHvkcEyK
         PKiC6dy18yVR2eW8QxqyRuCL5KLHCRTQ4kXqvTqeFCM7XjWMnc6RAqOFRphusLIs4jsR
         YFy8gTFRxgVxJBHj06/ubwN3omNN4idI7vAw8ldWCtXl5x3/C5MHeSaKBEch82LkuRQq
         3QCNCTZZfWnt6XbVGgmDnO9EGVHNCg4RY+GiohqQX7j3eh3NoW4YFL40HbgiOXRxuhQF
         tg6hlDkQ0B6+3R8ugc4yZ6xEN/Q4iQ81CJrIZ+aasSmTmM8311wZCoxCDcaMDnp/JnwF
         LV8g==
X-Gm-Message-State: APt69E0p0LMOMKEjOXA52oE9/Tj+vIAUejR9EQcutwgDzTvxvLkCpb4t
        PU6BBs4VGx+Z6FSmuFldqsbFZ6nMZ63Ylg==
X-Google-Smtp-Source: AAOMgpeTmotXdZtcbhNIs13JfTWJ/BOLhz5bFsxCQfxsijhlZGKcIfD1Xpx5wd8U/1gv0CqdoaC8TA==
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr3682930wra.101.1530770367745;
        Wed, 04 Jul 2018 22:59:27 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:27 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/5] ipc: cleanups & bugfixes
Date:   Thu,  5 Jul 2018 07:59:14 +0200
Message-Id: <20180705055920.19611-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dmitry convinced me that I should properly review the initialization
of new ipc objects, and I found another issue.

The series corrects 3 issues with ipc_addid(), and also renames
two functions and corrects a wrong comment.

0001-ipc-reorganize-initialization-of-kern_ipc_perm.id:
	Access kern_ipc_perm.id under the IPC spinlock.
	My original idea of removing kern_ipc_perm entirely
	is not possible, e.g. the proc interface needs the id.

0002-ipc-reorganize-initialization-of-kern_ipc_perm.seq:
	Bugfix for the syzbot finding

0003-ipc-util.c-Use-ipc_rcu_putref-for-failues-in-ipc_add:
	Bugfix from code review

0004-ipc-Rename-ipcctl_pre_down_nolock.patch:
	Comment update & function rename from code review

0005-ipc-rename-ipc_lock-to-ipc_lock_idr:
	Function rename from code review

0006-ipc-util.c-correct-comment-in-ipc_obtain_object_che
	Comment correction from code review

The patches are lightly tested, especially I have not tested
the checkpoint/restore code or tested the failure cases.

--
	Manfred
