Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA28C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B46D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaLFmTtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B46D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeJKX1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:27:09 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34682 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeJKX1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:27:08 -0400
Received: by mail-yb1-f195.google.com with SMTP id 184-v6so3804963ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OrRnQFDgKCLFTHA5GU9C2kNKNmBUtlsNLkeq060mOvc=;
        b=gaLFmTtSQbTQ1LOlLGFGJz40ezIeqgLofPfZfoubcsBM6tNwmkml32zpbSAye+koAq
         L66AXeYQ2bbVVYO7GwyebdgXLDh4w45ad1JqQyqmKtSdcBqwDS9fYgHlpASwjedixpqw
         QEqa1qsMdGT0WQc2l4iH3aHD+Q1BDT+VUGXQCtIZYrNc8cDhf7Y9C6pPgRHT8aZJ9mm4
         KOXqZjwi1i9FxkNhF/7EGr31tGu6WMvOTbJr0ffHSrWVpAorVkbOPik0KAbq9d8pEXoc
         TsGEUfwyoHZcoyUP8o1Nsk/ESvPTYUreMTcjMeupatdOUuVCrhLNes8uod+1RVFsXyR+
         LLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OrRnQFDgKCLFTHA5GU9C2kNKNmBUtlsNLkeq060mOvc=;
        b=rliW7wY//WaHzG8S8qPLJTQbCByetvv1+Q6Ena6Q6LtaC6+tDdaceF2V7WSyOvEzyF
         xLlPiHzg5T1vDYgUyNE1u2wr0GQnajkGzdlmu/oEOMVBy7HOc/vwI7lrsc4ZT3Tp4PP9
         doHF5e6BjH3I61tn0lbf6di8DS84GIQZCaYC+7yqXaeMmhgETGLD6KN/V3IO3nWfHQ1B
         LBcUN3TYscFre45JJFZwvvyddGl0SbHN8ZOIXo58mD5swC4J0qXrannhUJHv4NNMts7Z
         xhFG3uG9bbpq9jGNOxDjnVFhWRupnMy6D9yLfC9oq8du0J35cmvk4DtGRulNfxoaRgc+
         PPmg==
X-Gm-Message-State: ABuFfojrQpJ7Cp/AYDiPc5udFmKCQRTN7hOaJV8JmxtZsinWhg+DJok2
        jS70TDHTDKSH+8mAeCh+Ux0=
X-Google-Smtp-Source: ACcGV63vIyXAicOgvBCxilVd+5lABFF2u6dl1a+86E4gUqtsvGJkeev+Tn35R22YehHz7NYLXb63zg==
X-Received: by 2002:a25:aca0:: with SMTP id x32-v6mr1166837ybi.261.1539273558639;
        Thu, 11 Oct 2018 08:59:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::5:bc01])
        by smtp.gmail.com with ESMTPSA id f194-v6sm21305535ywb.53.2018.10.11.08.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:59:17 -0700 (PDT)
Date:   Thu, 11 Oct 2018 08:59:15 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v4.19-rc7
Message-ID: <20181011155915.GP270328@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg.

One cgroup2 threaded mode fix for v4.19-rc7.  While threaded mode
isn't used widely (yet) and the bug requires somewhat convoluted
sequence of operations, it causes a userland visible malfunction -
EINVAL on a valid attempt to enable threaded mode.  This pull request
contains the fix.

Thanks.

The following changes since commit ac0657edb13ac7971569aa88cc6f27ea26deb883:

  Merge branch 'fixes' of git://git.armlinux.org.uk/~rmk/linux-arm (2018-10-04 09:48:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.19-fixes

for you to fetch changes up to 479adb89a97b0a33e5a9d702119872cc82ca21aa:

  cgroup: Fix dom_cgrp propagation when enabling threaded mode (2018-10-04 13:28:08 -0700)

----------------------------------------------------------------
Tejun Heo (1):
      cgroup: Fix dom_cgrp propagation when enabling threaded mode

 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/cgroup.c      | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
tejun
