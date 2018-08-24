Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9EFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC82147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyo25sgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCC82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeHXWTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:19:54 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:41602 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeHXWTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:19:53 -0400
Received: by mail-yb0-f177.google.com with SMTP id z3-v6so3830232ybm.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PrbHQOVKhgPh73rQe6wLZBn7d7Ma0dZw/5maf5X3p+g=;
        b=Pyo25sgbKFbFBAm+zHpdDwsECnGOvtxMiGQeFzEnq2MbEQRloY2SnvnjUwriK0HKlH
         cP1OO/lsdXfk9cagpoxWOi0lXo555Uzq+waILkcR+TcfTiCx2ZgSimVfJPdXI9KNgp5h
         aMv35q+DAhKis+ZOdxDY/OiJ73gUyYsV7hUpc0xN2IcnvtWbGn8dt+lzxVBnvacuq7hb
         YcnrAd4H5D7p7LJXKFPLATn4rBa+FnvIZ/hQjc2I+025ntTtOiwgcItYhWm+B64HR0Iv
         TxyVpiJw0eWsxnOYI/rZgZIHUrb1DJecJGYttuRQa/fywdBWqDEU3dBFBYX52R00LLJT
         MB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=PrbHQOVKhgPh73rQe6wLZBn7d7Ma0dZw/5maf5X3p+g=;
        b=Lm6ox89ftBY+EdTuE+Zape0jPgoEjLub8XNGWZBkl4BwcgqcJE27niy+5MHgLJNDPH
         KaTyqXAKWGmAshMjNCcOgDbdGdecBN6o5t8V77pzC39+wOJ8winEriYgObGFXIk41LSa
         xRlih5rSELDN8sET/jwV7wdLomUtgsAfe/boArYSwmKT8CJ6ZFOZDut1UabpQqVVXAP2
         LMMuFx3t/vm12dB7sSkB8zJ28rkGIrk2GqUYxzFAwypoIaIjdrnWB6GmRDpOet8slDCN
         tlRGtWS7M4aAk7TBae/HHQ+I0dZil1/H3Z3B86jSVCpd96f0BGhHrzJzZvwW6tdG6Lrl
         UJ6g==
X-Gm-Message-State: APzg51CbKVmH2D1UnBLKdOGyOjdMnmsTZNP1Ee4VYi7XTwO3SAqUbeE4
        JpxjiBu7TUA/lcDoFcWxKSM=
X-Google-Smtp-Source: ANB0Vdbx+y7yzneooolcZziM2RxHm5yJODvQ69oJuCPzWXcPHwfrMJ97QynQcUSctzj03KI20qum/w==
X-Received: by 2002:a25:abaf:: with SMTP id v44-v6mr1249704ybi.142.1535136244033;
        Fri, 24 Aug 2018 11:44:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:8925])
        by smtp.gmail.com with ESMTPSA id k184-v6sm3077301ywc.62.2018.08.24.11.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:44:03 -0700 (PDT)
Date:   Fri, 24 Aug 2018 11:44:01 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [GIT PULL] workqueue changes for v4.19-rc1
Message-ID: <20180824184401.GW3978217@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Workqueue changes for v4.19-rc1.  Over the lockdep cross-release
churn, workqueue lost some of the existing annotations.  Johannes Berg
restored it and also improved them.

Thanks.

The following changes since commit 66448bc274cadedb71fda7d914e7c29d8dead217:

  workqueue: move function definitions within CONFIG_SMP block (2018-05-23 11:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-4.19

for you to fetch changes up to 87915adc3f0acdf03c776df42e308e5a155c19af:

  workqueue: re-add lockdep dependencies for flushing (2018-08-22 08:31:38 -0700)

----------------------------------------------------------------
Johannes Berg (2):
      workqueue: skip lockdep wq dependency in cancel_work_sync()
      workqueue: re-add lockdep dependencies for flushing

 kernel/workqueue.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

-- 
tejun
