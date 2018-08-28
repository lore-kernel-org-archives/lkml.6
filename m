Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56375C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8212087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSUP0Xen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8212087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH2ABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:01:38 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46528 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2ABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:01:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so5088627oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XySq3KwAmm8VeDGS6yQH0DQcTZI8E+bFGFfrCBgDnwk=;
        b=NSUP0XenYTWf5G9ECO1+J0UxFI1QoV3b2t3SxA/6ttUkSWdIrWBolcYRsT8AaXkB0A
         +U3Hc0S+v3PlW6zE2b7uzSQzZhreAJnup9IDb4kp3lreGI+O+oJFwisDpxpFvM1Q+qtM
         hOHbKkZZSPm4+nZY3ak/LTxlCmCQyGTo808styM7oA/vfgFTVdsNrv8IuBO55hJWp0R0
         A8U7TeEByUVbn1gxDGKR1dfnoTjCpK5rV+a3dn4pJyvG6kv54WfmMEgBzCRgqzcbyXsC
         raIImkpDS3iP200t1ZC/AKHNIW2JOOMPQ6Bin+6Lk0g7dauLUptdu01CtUpYSX4LfvXz
         6v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XySq3KwAmm8VeDGS6yQH0DQcTZI8E+bFGFfrCBgDnwk=;
        b=PD3+zd/VYJtAY1pLo7xP15mNQSlRQG3V1+zZsY6qU5pdkehuqgyF1zkxVMcvusFq5i
         qOiQs3+2z3XNxuWF9CBQKzKEZytV/URHSWygblP8wJvZZkZG94oXCebu6lyCix+ZWRfl
         hsXaeXFidCD0x8MDL62Zdv3IADkqPMDx3k9bQoe0romyplZJGpPlM8VSQ7NRa6IFYRA1
         MYw0/UIWG+7r+MHuQDBha9PG/TTAMqhYo3U4p/iF9HRdVgYGSekmNlsGkpffQlusWn+E
         LYQ5DKJnLWGdb/6rgsE1yrAVFKc6tQtqejE2uYYNACz0kBw9S/aDppcG+9ZT47J9m/yZ
         JydA==
X-Gm-Message-State: APzg51BBPfCGkiHNkeN0C7jcFwpI70xx01cMsYvSiKywa7j9j76pKlXk
        XsPu5IBvhHQfqJUt93git+iSM5EjTkVAhvCORBw=
X-Google-Smtp-Source: ANB0VdZz8wW8PRCrVg3/IZJHorvVJwb85DFlQFP7CTggsqOrrBbxZrq+8F80SNcifkESXqMkFESdPIljj9M9Oh510R8=
X-Received: by 2002:aca:4f44:: with SMTP id d65-v6mr2692313oib.224.1535486904239;
 Tue, 28 Aug 2018 13:08:24 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Tue, 28 Aug 2018 16:08:18 -0400
Message-ID: <CAPMnawu33A5L5a6a00tZ+_9cQxyN97OwXK0sO9Q60+YvR=Yg_A@mail.gmail.com>
Subject: [PATCH] Trivial numbering change in comments.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Alistair Strachan <astrachan@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get my feet wet in kernel dev and while working on a patch
I noticed in a lengthy comment block that the number "2" was skipped
in a description of the steps of a protocol. This patch is simply correcting
this. This is for 4.18.0.

It is a very trivial patch, but this is my first actual try at one and
thought I
might start out small (and I don't think you can get smaller than a single
 character change). Any and all advice (about this patch, email, or
anything else) is very welcome.

Thanks so much!
Ray

Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
---
 drivers/staging/android/uapi/vsoc_shm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/uapi/vsoc_shm.h
b/drivers/staging/android/uapi/vsoc_shm.h
index 6291fb2..0301172 100644
--- a/drivers/staging/android/uapi/vsoc_shm.h
+++ b/drivers/staging/android/uapi/vsoc_shm.h
@@ -92,7 +92,7 @@ struct fd_scoped_permission_arg {
  *    The transmitter can choose any appropriate hashing algorithm, including
  *    hash = futex_offset & ((1 << num_nodes_lg2) - 1)
  *
- * 3. The transmitter should atomically compare and swap futex_offset with 0
+ * 2. The transmitter should atomically compare and swap futex_offset with 0
  *    at hash. There are 3 possible outcomes
  *      a. The swap fails because the futex_offset is already in the table.
  *         The transmitter should stop.
-- 
2.7.4
