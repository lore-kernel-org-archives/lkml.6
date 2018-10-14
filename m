Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74415C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1920659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="grnKZHYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeJNVGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:06:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53745 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:06:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id y11-v6so16246602wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JjMOnNbkHTz1P9rN4XSj7SibReObVypZDErDMByt9Dk=;
        b=grnKZHYXYlQJKsg9Ur6kZ3BtwkNtsmeCQHUsYCPV+R4UpKBvHyi3anxt17zVWamIYO
         8ZlWw+VPYGbXOMkNY35ICr1KJuev3DqYBz45xLX6mhnbuCwVcO/ULvsABZob2jwIHxNG
         uEfZwZ0jPH+pd2i7Hk/rYjv4MaR+qTT/x9vAI2RysiWBp0rHzHye1Hj3gtw4UzyBauC4
         qvRj8D0KSMTbQkQlxdAXyO0ZjxRNVinwmgn5UpvjmTBVLRH3Zb38RJ06sPCTNXQZOpES
         +3a4Sv4GuHBZ7B7xJYvSCQ5MAOVs7umx2ASBZD9y1vl1Q3iD0YB6kQPbKxX+L54MtrGl
         yBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JjMOnNbkHTz1P9rN4XSj7SibReObVypZDErDMByt9Dk=;
        b=o0U2z4RDeG40abImOvgqpWcA6Yr/NwVp2JJStCy6O91nSXLu1nBHhr8E4MH+Pa0p/s
         sQ4x2FpieD0JY3J++Wg3uOtAfr7PkE4dXKfRR++jUOmnWlEHQ84gu4UBbhEdnO0Qg+gk
         Y2h2+Q85KMzNrZIFTuXwe7O3OXDbrAQqqbJngS4lyu2FjPOMEswU2WfUPoissyNbRSFI
         C6oYuOcK9L5kEbVC0zU99PgGML2EfCtgsCyfquVzPbxQcUARi9N60iyzQoTrHhpIigO2
         wUFl5wMzd3uWsVP6M1yG2oHM6VIRMzTPxp37x+yZ0SCsEleCC9aDNlmBkQIckyJqK2kt
         iP8Q==
X-Gm-Message-State: ABuFfoh1jWSlVbORMBm9FFvxmYAbXcdNVfEpc50HkO+DSK/vGc1tVJ5N
        qM5+lPdcmENlxLx9lRbDhto4dg==
X-Google-Smtp-Source: ACcGV60liU0+F7f11nOX1ffjd0GN/XM7L2lMtkulH1vgwjYBDZ4A2N+2ykAfPBkW+crndL50arTGcg==
X-Received: by 2002:a1c:1694:: with SMTP id 142-v6mr10695427wmw.113.1539523541194;
        Sun, 14 Oct 2018 06:25:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id a11-v6sm10550050wrp.3.2018.10.14.06.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 06:25:40 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/2] sysctl: cap file-max value at ULONG_MAX
Date:   Sun, 14 Oct 2018 15:25:08 +0200
Message-Id: <20181014132510.25943-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system. Let's detect the overflow and set to ULONG_MAX in
this case effectively capping the value.

The patch tries to ensure that there is no other user visible change in
behavior for other values. Only when a maximum value is set for a
specific sysctl will it be capped on overflow. The details are outlined
in the commit message of the first commit.

(This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)

Thanks!
Christian

Christian Brauner (2):
  sysctl: add overflow detection to proc_get_long()
  sysctl: handle overflow for file-max

 kernel/sysctl.c | 54 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 12 deletions(-)

-- 
2.17.1

