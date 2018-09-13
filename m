Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53954C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7C721480
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhfNn+3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7C721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeINBzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:55:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43181 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeINBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:55:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id l189-v6so1752149ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vJ+4d2XlhX+nuksOGHbpQLsBxitlOkXzw9aDti48oMc=;
        b=MhfNn+3gPFR+OIH6pZ+Yib0HJcSfSVCYQipa+Hg+vJbNAMoTRY6kHDKAdP3XB4RRci
         483tr8zaJQ3IT9qNPQlwYZXfoP3UO/ZsOqAtHTBTMlV+V5iOE3DaAX/IhDils4gOFFTe
         XNGV8m3l6jkRYt2vRFFRAC79QTmByjAF923JeBUvnS+gsThuL69LINaSz2mQsxIUti+R
         DJisKIcq+XKDOx/cESTNFW8Q1tC0NV6iulvU4Haxjmm3K0ocu/qfszacuccTKQ3cMyw0
         D7n9syc10/3npfp9SNnX/DmA0ouW7e7/lIv5K3eW/wU6rDBopTUzSo0vlxwmbME0kZRS
         /8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vJ+4d2XlhX+nuksOGHbpQLsBxitlOkXzw9aDti48oMc=;
        b=B+Kf4MpXf2uKZAV+mUXCxr/AQRM0PE+rU9Q+erPerHUPQkvdr8A4MwJaYw1ELHvpYd
         HHz6mO/ANXqIxbMqckMFm15KWLecNzIRv1/heSS7igFhBnz+ry08XK9NAt4k1kQTfSbh
         Z66pg4lnyEcibRtzhvy0oPQDkjj6Hmq3YhxW5LD5ZDXhayPvKadO7oF8+do72k9y9Mue
         0xT8LzqQ8EO+lGgw1Z138r/hLd7SE1nOTHjAdDkcQshubZZyVbi4B1WHsVLTRw/ZKGPi
         nL/7nDkOhd2P9w2q3U0NiDhXRtAc1rHaZFMSeeu9zzI0VAnrTFc1QZOF/xZW6NiraAPA
         6vGA==
X-Gm-Message-State: APzg51DtYotutdXgcKjULFdLsRrCKybz5BSHTz3QvKXfBxhOu9AvMKjo
        vD5FxIQocJjlxteNaG8rZso=
X-Google-Smtp-Source: ANB0VdbX4e3CHYmkyiEFBA7Pz2mqI/LmiMsthb63nMlGRYi+TL1YPM7mO/gH5E7qIZu/SyXl02cFAw==
X-Received: by 2002:a81:3d12:: with SMTP id k18-v6mr4254293ywa.452.1536871454562;
        Thu, 13 Sep 2018 13:44:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:3a97])
        by smtp.gmail.com with ESMTPSA id f5-v6sm2377354ywa.39.2018.09.13.13.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 13:44:13 -0700 (PDT)
Date:   Thu, 13 Sep 2018 13:44:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [GIT PULL] percpu MAINTAINERS update
Message-ID: <20180913204411.GG2966370@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

This pull request transfers the percpu tree maintainership to Dennis
Zhou.  Dennis rewrote a good portion of the percpu allocator, knows
most of percpu related code, is already listed as a co-maintainer, has
been reliable, and now sits right behind me.  I'll keep reviewing and
involved with percpu stuff and am sure that Dennis will soon make a
better maintainer than I ever was.

Thanks!

The following changes since commit 54eda9df17f3215b9ed16629ee71ea07413efdaf:

  Merge tag 'pci-v4.19-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2018-09-12 19:39:56 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git for-4.19-fixes

for you to fetch changes up to 1194c4154662ac60312c164e9eaab0f8dd0dd36f:

  MAINTAINERS: Make Dennis the percpu tree maintainer (2018-09-13 12:16:36 -0700)

----------------------------------------------------------------
Tejun Heo (1):
      MAINTAINERS: Make Dennis the percpu tree maintainer

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4130acc2e152..bb65f0c1861c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11360,10 +11360,10 @@ S:	Maintained
 F:	drivers/platform/x86/peaq-wmi.c
 
 PER-CPU MEMORY ALLOCATOR
+M:	Dennis Zhou <dennis@kernel.org>
 M:	Tejun Heo <tj@kernel.org>
 M:	Christoph Lameter <cl@linux.com>
-M:	Dennis Zhou <dennisszhou@gmail.com>
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
 S:	Maintained
 F:	include/linux/percpu*.h
 F:	mm/percpu*.c

-- 
tejun
