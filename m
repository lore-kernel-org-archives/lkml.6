Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115ACC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EE02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OXGPk2sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJQDqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:46:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38205 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:46:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so26982982wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ji5fKAzLq0buVOw4yaeXjM+jOK4dIJ3CBUY5Jb6GnFQ=;
        b=OXGPk2sxb93zqyXMpYuNJ3ftuY0P3sA+CV2Z1M07m1Qp/nBkfrL6nZzshljDRQ23uC
         AaVj+tzCemKEfK9CESwHu0fyqQmqjW3D15zjmZAyypX6un7Kr1Yfs5MVhzT8OsFZvLEJ
         Y4V8Ljrl0kC6ABLPjql34cPYZrKPro5K6aIoMybDLJSI+HFW1wnxT0lguMCfdU0jG7c6
         oxZWiEM7U+B4Sn7+y6Q8+I2K9bMqWzpwNliXCtn6U1l0Fu+szxuh8+tJRGiOLplb1SrS
         MoXSaKtYHVsGB3gu/wuVwnVZ0almJAsMCIqjpoMztAslgWVshm1G3oKIJIdsVBThTq6H
         JMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ji5fKAzLq0buVOw4yaeXjM+jOK4dIJ3CBUY5Jb6GnFQ=;
        b=qjT2YXNPwflxhnmA5W/ebDPZK1MYK6VPbaj0Yni+nnXKrg6weqAhsx8QfGFsQ7ROYg
         s4J2e4J9oRPhvyj8krwsSf6JoCXV5fnHycCr6uv5ts3spgpDqT5ydDybUqdsz8UBeHY4
         haSpApI2jlZcGgamIJIi08vI5+ofPZrttHHeWWip6lCTBk5kOCuTqOvfJEknmKSP4MLv
         gw40izL+U/Nfy4Fpqq0G0f/FamslkK7czV2XG05E/S1mZUUDZPnFTIBhAaO4P3Gh7hVH
         XBWGFHPXIIFJtM82C7ArOhixe66ER4UxRcsjWFSdsAwr9iTsm/GwMYu0UANeFlmwTvtK
         N6hA==
X-Gm-Message-State: ABuFfoh3uwBQLoSkh1mDSmAgMra1KKEdxYSwR/MmtyI+xkc/53L7GqyR
        Cs67flfA4gcqjhuY9mp5a2PF3A==
X-Google-Smtp-Source: ACcGV607/FhjDtItjspVOlFX6m4irKde33ZhAgfCvoIeOEcMHY2FCw21ic9T00D0sLpML1/W/s1dQg==
X-Received: by 2002:a5d:6450:: with SMTP id d16-v6mr18657867wrw.64.1539719643025;
        Tue, 16 Oct 2018 12:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id z2-v6sm10958588wrh.8.2018.10.16.12.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 12:54:02 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 0/2] sysctl: handle overflow for file-max
Date:   Tue, 16 Oct 2018 21:53:35 +0200
Message-Id: <20181016195337.2440-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Here is v2 of this patchset. Changelogs are in the individual commits.
This is a new approach after I have done more reasoning about it.

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system.

The first version of this patch intended to detect the overflow and cap
at ULONG_MAX. However, we should not do this and rather return EINVAL on
overflow. The reasons are:
- this aligns with other sysctl handlers that simply reject overflows
  (cf. [1], [2], and a bunch of others)
- we already do a partial fail on overflow right now
  Namely, when the TMPBUFLEN is exceeded. So we already reject values
  such as 184467440737095516160 (21 chars) but accept values such as
  18446744073709551616 (20 chars) but both are overflows. So we should
  just always reject 64bit overflows and not special-case this based on
  the number of chars.

(This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)

Thanks!
Christian

[1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
[2]: 196851bed522 ("s390/topology: correct topology mode proc handler")

Christian Brauner (2):
  sysctl: handle overflow in proc_get_long
  sysctl: handle overflow for file-max

 kernel/sysctl.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

-- 
2.17.1

