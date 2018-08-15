Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C2FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB552089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQwKK5Eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB552089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHPCVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:21:00 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42638 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHPCVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:21:00 -0400
Received: by mail-yw1-f68.google.com with SMTP id y203-v6so2138362ywd.9;
        Wed, 15 Aug 2018 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gH2W20YXDTDVgUtzd2ZQQaMh0mVlvIlLxGdI9YRTVh4=;
        b=IQwKK5EqvE+5Av4bfc1jUlI+ERZYu6lkmnvk9uRoNLQefNsZdftcA0JCOZP4syM0+9
         /BbpTYTQjvsU/cgh6sEJ4xakNICwekk0+lvKZ24eL+Cm9yVNEc8UA7W6RO5+LNJKZPw3
         xWAvO0bGpHHFuIf8MVuYBXaqcU7kHIdX4t26ifqYif2k41quCg/Vr0vixYIp7sXtM1vc
         /KqwN1O0xeexQXZNKCnNcDO4XTPGQLernZej5Y7kICa+2QWjEGA5KF46qkpuLlhVU63I
         4nihDMoc49B4UIG5m1yezq7I3y26sAiPGVFTc3dUYzBcu7JnmpeI41xQTLvgNwUN9Lv2
         dp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gH2W20YXDTDVgUtzd2ZQQaMh0mVlvIlLxGdI9YRTVh4=;
        b=sg+h7C/Vu3CRfL3jlausmRDbvAXkxCgw5Tdec8SA2PvunzA3w4vUSgVFXcdLnWDnMX
         0XcsIfEleRg+O49oKu9DcuE01MOjky9IPs+0kuI68XbXX+jsPFVYK8CgiQOFa/w/Xto9
         rqovOF9VCFn+pceSVX7KwVMpguMVigpZfVbLgyHA+egaa2yuauIBCN5VYzy+nu4GGrZd
         9KoSqC6pQFvVb7m483nXZubhRrppq5cPkhVEN+7x1wjJ+hFPZHbaIUlvHQRvckt1mraM
         uDEgnlqls+aZEmiYdDYPQ8Kl39btQuW24FnAe8ddR9J0bEosVzztRxy15B4NL3Jpjv01
         SoLg==
X-Gm-Message-State: AOUpUlFGblGpVEvD4CqNIiAdWoLIwx5xaxtD0D2KE2prUouxqTy+4Z4V
        gnrTH4m0LyT9Wy2MEFLFZJ2Em6o=
X-Google-Smtp-Source: AA+uWPz1OQ7DE7ny0R1SSWApLqYdPGuFZ0QTgmkzon0c5mMkOmS7KspW7mQKhP7K5UIGM3B8OuhblQ==
X-Received: by 2002:a81:7306:: with SMTP id o6-v6mr16137957ywc.193.1534375597432;
        Wed, 15 Aug 2018 16:26:37 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id h10-v6sm6204361ywa.35.2018.08.15.16.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 16:26:36 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 0/2] generic_file_buffered_read improvements
Date:   Wed, 15 Aug 2018 19:26:30 -0400
Message-Id: <20180815232632.32548-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch series to
 - firstly, refactor generic_file_buffered_read enough that it can be modified
   in more interesting ways without going insane, and then

 - secondly, change it to use find_get_pages_contig() to batch up the page
   operations, and then copy data to userspace in a separate loop that touches
   no other shared cachelines.

I've been seeing profiles where the radix tree lookups in the buffered read path
are a shockingly large portion of the profile (around 25%, if memory serves) -
that's what this patch series is addressing. I've benchmarked small block reads
as well, performance there is unaffected or slightly improved (it's within the
margin of error).

And as a bonus, the code that was all in generic_file_buffered_read() is now
_drastically_ easier to follow and modify. I haven't done as much refactoring as
I could have, I kept as much of the structure of the old code as I could just to
make things easier on myself, but I'm still pretty happy with the result.

Kent Overstreet (2):
  fs: Break generic_file_buffered_read up into multiple functions
  fs: generic_file_buffered_read() now uses find_get_pages_contig

 mm/filemap.c | 486 +++++++++++++++++++++++++++++----------------------
 1 file changed, 273 insertions(+), 213 deletions(-)

-- 
2.18.0

