Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BFD2152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGJGxMD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BFD2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeHXPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:30:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39251 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:30:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so6669831lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6EFBjIvyxcvEDtwCniygFOB4sr/UwhemARyGz9r3LW4=;
        b=eGJGxMD3h5ihlqAkMzUAxk3w6l+Kp4QmmR+2IxW5/Ackph7j/9g8+li/MgVO0za50e
         YcW142i28xtP111aGQ+OKLybjPnhsbOIuiGkB8e+rAXqiB0aO3yv66gToQlJmzmOK1EX
         gPxriVM2kOi3vONu8/DHTLhDYZ9D5nFKbWDH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6EFBjIvyxcvEDtwCniygFOB4sr/UwhemARyGz9r3LW4=;
        b=ScQ73sTuMjLWqsTFrNNJJtuJUy2B8QmTIiWU7ab6eDuPsJtAGFsdrRCUzgTAziiltX
         71hC47PWk68JVPw8mw41iFIjKZojSE35FAN8RtqN9cvE92moFEOMG2225yCdb1AbHinF
         ZkfVK6G4soWs2OUh64Ym0i3XMtTXJ4bPUoogwmdZbifX7SJswQqwVXURhA/B15LCxtwM
         GMVuUeSCuy4m5vaKEplO3hY5p8ozncJ6Vw1GUQBJUg5XtbZ7LnpshdaRm6e2ufdB2108
         ERGQTq5gPsae4NPXoV8PmCbvhAEU1SCs7LiO3o3wTHTtcUAElAs/FWKRDtSRdA5v9UYN
         FvQg==
X-Gm-Message-State: APzg51CRotAfwfcyuk5ISr24VgwHSvhuNA+0o1iUvhdc6IfR4kAvC9nC
        hkkDTLehDbnfM2/7Rr+AijWvYQ==
X-Google-Smtp-Source: ANB0VdbDUYOr1V86+f6FDzvIIp+wSxZk9FB7aYnOJeXYB2PIed/ucEvvnVt0ki7zQ8J8h8dMre3gDA==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr1164878ljh.49.1535111747989;
        Fri, 24 Aug 2018 04:55:47 -0700 (PDT)
Received: from jax.lan (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id w15-v6sm1301374lfc.62.2018.08.24.04.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 04:55:47 -0700 (PDT)
Date:   Fri, 24 Aug 2018 13:55:45 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsystem for v4.20
Message-ID: <20180824115545.GA4989@jax.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these tee driver enhancements. There's one small fix for the
OP-TEE driver to take DT status into account. There's also a patch
providing a kernel only tee client interface that can be used by other
drivers etc. Currently there's no users of this interface in the kernel
but there seems to be some work in the pipe as some has tested it with
out of tree patches.

Thanks,
Jens

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.20

for you to fetch changes up to 25559c22cef879c5cf7119540bfe21fb379d29f3:

  tee: add kernel internal client interface (2018-08-24 11:57:37 +0200)

----------------------------------------------------------------
Misc enhancement for tee driver subsystem

* Adds a kernel internal tee client interface allowing other drivers
  etc to access a TEE
* OP-TEE driver takes DT status property into account

----------------------------------------------------------------
Ard Biesheuvel (1):
      tee: optee: take DT status property into account

Jens Wiklander (1):
      tee: add kernel internal client interface

 drivers/tee/optee/core.c |   2 +-
 drivers/tee/tee_core.c   | 113 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/tee_drv.h  |  73 ++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 8 deletions(-)
