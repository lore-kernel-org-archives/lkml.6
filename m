Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679ABC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B8E20656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="siH+Mn07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbeLVRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:50:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32857 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeLVRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:50:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so16420948wmh.0;
        Sat, 22 Dec 2018 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmpRq08A/D1jycQaeI7J0jXVDz9jIH+fANo27pxn1S4=;
        b=siH+Mn072RvdhaVWDdm52jgB9bUO4C8Q9KuorLJ6GQIFqKK0i6cFzltkjbxtH+DIgP
         /D9ehEElFKb2LHi7C6q9CHhGjF7z3+eO1VPY92ye83q7f9qzdKt4mNHvX9QZ0HhyIz0F
         jWU7rR6IYBPKn2IeC2xJt8DBNewfOXzLGRPxrZUPJK5etmMNvNwd46fVhSB37DGRH5ng
         eP11a7HFXyHIQ6VGt+aVCKblCpscH5SsI0hgl+q1/MmeuYdFLUAxaQHumLI4ZppaL3RL
         DXrxGNHFJ9uqoACNMpQwtnZlSjiLcbSt8Gk6znMuKDke2oalxWSnaaaE7nWcir68w5X2
         rRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmpRq08A/D1jycQaeI7J0jXVDz9jIH+fANo27pxn1S4=;
        b=f7jObOu+/2g8Fpbx9ThPvRgTZGnMaQCjWf3gtBdsh93//htY08f5WfqVhRpkBiTsqX
         xfGQFQm90CJ0ByNDfIQWHW8OV/m2DyyW3oM3hLILUatRha1TBqNSVwQue2nRSHFhEnKZ
         gz/CC2pOFmKILZSGTteyDTdYvnlHY+/kV4bA8Ywm3Rm8or1Ns7JlX5/FbNEUeRoJoXJK
         pTgRO0x1GF6VKV6KY0yTzGXHHqkL97FPUlYY+2ty2IMU0zUpMsHcZNr9Rs5PPyWVrluC
         6IM/X/w1NFa+V9qrer02nE5uuhIf0sQfYyMEJm/AfkHKHTziaEsE4ho//kWvLYuU99Dy
         azzQ==
X-Gm-Message-State: AA+aEWYezap1/W/jmzmAO0l151qdyXZYdQISPEEQMKq9vFe0dycAsQnc
        iJeEp+uEvQId8pAuoY74WpgZu2MQ
X-Google-Smtp-Source: AFSGD/W5OxyxHW8GFiqYXATIHHzNCU93L+D4O0hn16SA8bdsNVkr/eH07ftgbeI36oP/0UNdAfxnHw==
X-Received: by 2002:a1c:a70a:: with SMTP id q10mr5694315wme.58.1545474151481;
        Sat, 22 Dec 2018 02:22:31 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD739590074910E90C26DA08A.dip0.t-ipconnect.de. [2003:dc:d739:5900:7491:e90:c26d:a08a])
        by smtp.googlemail.com with ESMTPSA id v6sm11883735wro.57.2018.12.22.02.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:22:30 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com,
        jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/1] f2fs: fix sanity_check_raw_super on big endian machines
Date:   Sat, 22 Dec 2018 11:22:25 +0100
Message-Id: <20181222102226.10050-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Big endian machines (at least the one I have access to) cannot mount
f2fs filesystems anymore.
This is with Linux 4.14.89 but I suspect that 4.9.144 (and later) is
affected as well.

commit 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid
potential overflows") treats the "block_count" from struct
f2fs_super_block as 32-bit little endian value instead of a 64-bit
little endian value.

I tested this fix on top of Linux 4.14.49 but it seems that all stable
and mainline kernel versions are affected:
- 4.9.144 and later because 0cfe75c5b01199 was backported there
- 4.14.86 and later because 0cfe75c5b01199 was backported there
- 4.19
- 4.20-rcX


changes since v1 at [0]:
- change the printk format for block_count from "%u" to "%llu" (thanks
  to "kbuild test robot" for spotting this)
- added Chao Yu's reviewed by


[0] https://lore.kernel.org/patchwork/cover/1027285/


Martin Blumenstingl (1):
  f2fs: fix validation of the block count in sanity_check_raw_super

 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1

