Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6B4C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF332089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HVNnWXGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF332089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJPGPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:15:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38049 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:15:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id g89-v6so15318068lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VrV0GeV2TaA/kxbu/mgUaZ56z2z2D490bBGeoh3/1Uw=;
        b=HVNnWXGdspC1awzT1127q8YpjR6OtFc2+oy72X9ZLOctVkk1mSxyXt2rUfK5XKME1T
         IDRVUFAnWQH+xbhbdPXsCPjWxWkd+UlBT5hOjzMBcrFwRUbDBLsCEjIX7mAr9rLoA5q9
         Hh2wVaIKrChYKO8SPUlr8TNe6djYc1NdNrkiWYY65MarnI6cRk5gtN1VJKF6yjRSiXub
         29vRyxA6LcSs4qOX/zufkVqEOw+RnVHoFEGFAX8H11A8s8cnaUliaaQXIgSjzGM76p0N
         NcEmG0Ax+INU6JgnkVxDNPe7C9o9OEwyIdRst3xSFSEHSdbZhsyoVOROC6yufpYa2qwe
         4LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VrV0GeV2TaA/kxbu/mgUaZ56z2z2D490bBGeoh3/1Uw=;
        b=L4alCKem4+67yziSl5W4Qg7AIYnFMJ/P8g6kgcuPNR09wenWJIepBdKTrjkQ51cBLe
         cLIV03hamTvGrOEccdS8cKuLsC2/gm0NzxrrakpfVUVEx0DlBbRiOZ65WGiQJHWsSaij
         6I3QNS6DqmvvofAlkJYOBHRXMe0J58zCMfgJjbuqDIj+cjzKtggzPMTYg8Gl1qeuHEx7
         dC9QrsWnZz3IZyX346LSitrRINAnovXsUdXxn3TfbvGDcoHXsVwAkxSo7kysQn74wxYO
         hXRrJwMVQR/9dOMgtLUPFgPbLjy9ypJRaDCAQA5MKipmW8HrFkgvWeUVLCSrjdzhnk4u
         IH5g==
X-Gm-Message-State: ABuFfoivtav9ox0W1anuH1tli+mpZ0sBCAAcAfS/kQvuv9f7bkZqRqzI
        FNXvRmbuNBsAb++68ZNuWxUY9uP6Kgmvtfn1I/cb
X-Google-Smtp-Source: ACcGV61GpQ0OXTBs7rNqO9Eci+KiYSGmTrhnJoKU+A5Lm05lG5YV3IX1LnMe0hOA2y184K1zhFi2yxPy4jv6+RzE1Go=
X-Received: by 2002:a19:169d:: with SMTP id 29-v6mr10703360lfw.151.1539642495550;
 Mon, 15 Oct 2018 15:28:15 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Oct 2018 18:28:04 -0400
Message-ID: <CAHC9VhRDmorDGkUkXv5f4YT-PxBdspbqmo+fYpu7-P-xzC2FxA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.19 (#1)
To:     gregkh@linuxfoundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

We've got one SELinux "fix" that I'd like to get into v4.19 if
possible.  I'm using double quotes on "fix" as this is just an update
to the MAINTAINERS file and not a code change.  From my perspective,
MAINTAINERS updates generally don't warrant inclusion during the -rcX
phase, but this is a change to the mailing list location so it seemed
prudent to get this in before v4.19 is released.

If you don't want this for v4.19 let me know and I'll queue it up for
the upcoming merge window.

Thanks,
-Paul

--
The following changes since commit 7e4237faa7213c1cc1d0aa65a44c67ba4729ce9f:

 selinux: cleanup dentry and inodes on error in selinuxfs
   (2018-08-07 17:26:25 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20181015

for you to fetch changes up to 073c1a781e4a1217d572506621434cd6d750969b:

 MAINTAINERS: update the SELinux mailing list location
   (2018-10-10 01:50:15 -0400)

----------------------------------------------------------------
selinux/stable-4.19 PR 20181015

----------------------------------------------------------------
Paul Moore (1):
     MAINTAINERS: update the SELinux mailing list location

MAINTAINERS | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
