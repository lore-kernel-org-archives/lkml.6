Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630212084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Sq03BzHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630212084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeLLJpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:45:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeLLJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:45:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so17008167wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NBHX8cmZSnI3ENZ0NWLnqfBmqmKIO7ou+ecQD94nJWQ=;
        b=Sq03BzHMX0aQ4IR3WJbtAiAqAiT7o/w1T0iGq/VMSNL1jfxiaznlpfPD7zU7O9gEy6
         8O6TAp3keAMJBRtPcp3vRXgV2m2Fea0o7TnJTTMYM5FU8yktIgh9LcPGKDnqrxmvxfJp
         cS7QlSpR5MTrubf/WJOc2O7D+hl4rTgIiKKGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NBHX8cmZSnI3ENZ0NWLnqfBmqmKIO7ou+ecQD94nJWQ=;
        b=HgeLw7R4G2+FJOtI5b/kFsG3/zGFLj0mfazuAuzaCNGjNmh6HbCQn3re0MJkPYngq2
         iV9GaR9jzZdPBNVRxJjk2JAIpeqA6btr9l7/dLArSGHaFx5soLRp7A/8hGQ37JvCmK7R
         YctLZ0dPiAdvZ4Ly+/lE0JYPRiyrfw9SHMaV4Xx9nK5z8G1wST+7DdK0ZON5XXbG9w54
         T7DW9CaaT3LLkMFxJw7j0w9HEY68up9HTKk6Y+ddeR6C8FIdN113N6if041/MdfQDRAy
         VQeon5TCu8ISVqXH5IfFTDAU1td8FtmWUtQH4nZGg79oxSRVjZLzMyKTTt6a1m2ynHXQ
         pr5A==
X-Gm-Message-State: AA+aEWbgpdR7StOU2KBFkoZoHrl/VbtYlcdnoCa3sNOjVnjVWd33QW2e
        5D8fjyLIrB+ngrEIw6rwj3Q9HA==
X-Google-Smtp-Source: AFSGD/VAOOfeY4YwNQC9eE6E/+14+/Kp0SF11wr4qwX8Z5wEpuDVEY6VfRFMzVWokGCIgJcvNbqp4g==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr15724356wrd.20.1544607920985;
        Wed, 12 Dec 2018 01:45:20 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id c10sm19472261wrw.49.2018.12.12.01.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 01:45:20 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:45:18 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 4.20-rc7
Message-ID: <20181212094518.GB15517@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-4.20-rc7

Needed to revert a patch, because it possibly introduces a security hole.
Since the patch is basically a conceptual cleanup, not a bug fix, it's safe
to revert.  I'm not giving up on this, and discussions seemed to have
reached an agreement over how to move forward, but that can wait 'till the
next release.

The other two patches are fixes for bugs introduced in recent releases.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix missing override creds in link of a metacopy upper
      ovl: fix decode of dir file handle with multi lower layers

Miklos Szeredi (1):
      Revert "ovl: relax permission checking on underlying layers"

---
 fs/overlayfs/dir.c    | 14 +++++++++++++-
 fs/overlayfs/export.c |  6 +++---
 fs/overlayfs/inode.c  | 17 ++++-------------
 3 files changed, 20 insertions(+), 17 deletions(-)
