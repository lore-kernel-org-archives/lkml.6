Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CB92148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Eoa4zcp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CB92148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJQG0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:26:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34384 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:26:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so192915wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Xb7MzV6QAPwTQlaokrO7T3mhcHL3d1TiUpQ5tI/08kM=;
        b=Eoa4zcp3OLTr3a/VVd93RkhoKp8X1y0DyLrmxDENs/cqLdX6vZ+Et8nELvP1VPQmMW
         FHYQtIr+79+im0YVx2gmgN5W8uq7v/rjUd/8anVVHLmj7EHSkXu2Z8wCybJZAqTYxj0g
         yOGRFKvW0kyTa59rCvbzbuFe7qV0iaWs51t0wFfN1vhnOZA08VZhr27GWNNs/jlo11FA
         /zxalmY3305AaU9g0kr5V4RNQi5MWAA+uVoNEPLRUL50l+duUQxOeP3B7Wyh3ASJMtsi
         DCMaUKWw/PAqdnN+2gOgN3VdVrJxJCpN7krMIb46v/zhBLJV+i0SpQ7vPEnGaqoDkF6O
         AuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xb7MzV6QAPwTQlaokrO7T3mhcHL3d1TiUpQ5tI/08kM=;
        b=nlcHDdivZsYbRqrDKURn5G5lHXdMQiHHEbDf/sIUqZdECtnmyb7sxcRe6dbvjfdrvb
         9swS5zLwQFAtGx4jcD4/jUoSr43vmdDATqZCsdMDQAaGSqqePlNyxbIk4XytTuGg2vGA
         h0Da+Ykuq+9eMPXy6WXfIMXEApo29HCIUUjK/mFN3cyteACwsl0DTf+Cic6J+VBVCKVh
         gltzHrlRhl/1wbSxP5docCBO+Mf2oOw135qyLYtcp887lB3BG29SRUaulDTk8MJbry2D
         00zfQSXQxcohRC6/Zu4ANXQgF9mYTKDJ75GGz54sbzdVvms1PJE+qgDXSn/rQi5X+A2v
         dlWw==
X-Gm-Message-State: ABuFfoh2HKVvTMb1uiqLfs2uikOOhoMr4sQVsHoDQoNbLFCNb4Dzvt5T
        FuhHgvv6py6PIYbzKZu+7WAZBg==
X-Google-Smtp-Source: ACcGV61QHCvVUrxkqCUSnoFJ1qW0mVZGx9ZEVORh+FcBVDfHgfScBC8Zaz8elbEH0IgAEnK/Z48CLw==
X-Received: by 2002:a1c:868e:: with SMTP id i136-v6mr116709wmd.50.1539729231777;
        Tue, 16 Oct 2018 15:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id x8-v6sm35084836wrd.54.2018.10.16.15.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:33:50 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 0/2] sysctl: handle overflow for file-max
Date:   Wed, 17 Oct 2018 00:33:20 +0200
Message-Id: <20181016223322.16844-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Here is v3 of this patchset. Changelogs are in the individual commits.

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

 kernel/sysctl.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

-- 
2.17.1

