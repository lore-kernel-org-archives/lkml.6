Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A2C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169242075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8YeIBGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169242075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeI3Ssy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 14:48:54 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42271 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeI3Ssy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 14:48:54 -0400
Received: by mail-wr1-f46.google.com with SMTP id b11-v6so10789125wru.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=atcS0JAH7NEuXx5UELM9uZFDih5p+tw6pwMGzc/kcDk=;
        b=D8YeIBGfjHKTp4MvIa5uo4/GbYz7WQqKSZvkPCuHQ0qUTd0N3EQVDREBHP+zK46W9v
         3eihVyl6i2jcLm2BFZk2BCNOUlTXVXlyUEkH0Qs0kp4oFiiIZ/37m1nTLJavwiGGXB28
         ZSt0U24uyxaYZLatAWDY6h0LXI9Zygq32SL+qlcVjHc08aUo6RLkJSxMZuL5K+ZhHryQ
         S/GrR2qnS+hdX5eVmJTLzKPKn3lYdPKr/SULHRh8XYrCPxeS/dZvEZ+fAFSfw5BbSW+D
         4dtxoQxac9M6JDb2RXaLbU185znhPxKBEuta8kNM1bcUuw8mvvH+Cgy3cqiRoBQSMuYZ
         Pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=atcS0JAH7NEuXx5UELM9uZFDih5p+tw6pwMGzc/kcDk=;
        b=uL7Yr9Aphy9E1nnD8KpIpV5PzBOuApAb5x6y10ntiDvwbszRuB/VLDgItRLNZyrP9o
         CQWinRZJcJ7syhHinbbzSGkAGgJg+1aec2DSb5lzc2Qe8VHhGsf+Q+PiY2H5B95qhg8c
         vj0Gc2hcxm4CIofMyWzLPFFfRFU0JlYbw4qWLhlyRH3Sbpwe4NWNONP977Ank45vRsgz
         IQXS+Dm3aLj0FPL6/iUTDBQ+7JQ9EBSgdzxj5J8LS/xYx9WHRXNIxqD6FXH8DgNITJt6
         WZgHCZJwv5r86Cii2q1v97PAs7Vg2XY3YswcgRz8hJXx+SncTU2p92QT8BWDn7yMAqdM
         o45Q==
X-Gm-Message-State: ABuFfohgE6B3asQWVubtm2yTMBkVbgkuE2Jw8iiY6rBfRLj9nPvmEHsC
        DUyDpWkiVtWAjeqfAHalnScdKeksep4=
X-Google-Smtp-Source: ACcGV61av467V7eZBJJi1J1fdelJMv/+I6/IRHi4wQDuth+IpqfxS0diI2R01SqqbdhIyYDdm4oxAw==
X-Received: by 2002:a5d:6848:: with SMTP id o8-v6mr4407509wrw.159.1538309765942;
        Sun, 30 Sep 2018 05:16:05 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id v6-v6sm5359402wmc.43.2018.09.30.05.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 05:16:05 -0700 (PDT)
Date:   Sun, 30 Sep 2018 14:15:55 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v4.19-rc6
Message-ID: <20180930121555.GA15969@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull this trivial fix in MAINTAINERS for auxdisplay.

Cheers,
Miguel

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-greg-v4.19-rc6

for you to fetch changes up to 03d179a840ce9e694db9d69bb643fdee04cfd28f:

  MAINTAINERS: fix reference to moved drivers/{misc => auxdisplay}/panel.c (2018-09-30 13:50:05 +0200)

----------------------------------------------------------------
A trivial fix for auxdisplay

  - MAINTAINERS reference fix for moved file
    Reported by Joe Perches

----------------------------------------------------------------
Miguel Ojeda (1):
      MAINTAINERS: fix reference to moved drivers/{misc => auxdisplay}/panel.c

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
