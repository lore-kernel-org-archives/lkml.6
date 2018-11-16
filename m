Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8F820854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2kBOSMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8F820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeKQFTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:19:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40448 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:19:52 -0500
Received: by mail-it1-f195.google.com with SMTP id e11so35732372itl.5;
        Fri, 16 Nov 2018 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=PahfTs1OtIehJg0aqdaJCkLu/htuPG488vkEo8qTMxM=;
        b=R2kBOSMGKSoOYRjAYt6x4koRAozI6oOkM27QfuBS1azA7mEFB0hZWqv/6CofruDppG
         ggUAFYEAVB0UpaE+liUA5A72j+ebBEURIh8v+CoI8WcrrxH6qW94AoW6aSVkCbzL9pCf
         pQdH/lD8VPRbEZsilWXB1k93oj14XaCTHdQwJufFE3VZswCROHXljVgRAMzWkL/fRdkp
         2DfCSvDKRVFCLZ6tMYYMA9iXfw95bCKR73b9LMyeLUtZv2/a/2MRNWE4ZpOSb40+rvr/
         iWa9NJ3/nEmmIG3PCuFcln29wabGl9ZrcyrVwPypmEwcGmXvUaIy+Beq21ZjBelk8bTl
         0qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=PahfTs1OtIehJg0aqdaJCkLu/htuPG488vkEo8qTMxM=;
        b=EIwPC7YgT4wXxMIy54cs9gCuFLwzz7TjGoHAGleiIiQ/Rq7FdXIQPDLP/eiKkGSK1A
         lbU9cGXRrRKuhhvi1nYtTxFY97qPDCzFkbPJUTlBoem0sgOrDo2PGL5J5Q4NR+Khab1U
         lBmCprHDHtDdsX5bhSeRWUmvtk6ho/bIPx/zKyywIKjJdfSbTeRRZGtc2jJbtRHa/RCJ
         wMrtoGyv6QjFEFzApTeFIUnQCR1IlXM7D0oCtYTtp7BVFdeASiHnShvjk/uTpnfF8lbt
         nNWHP0kjS0G3c+N7T5poHjy/wdV0PEOGqyhzY4oXLj1FxCwb/8RnYPLyYt/jKk/wco+G
         vqEg==
X-Gm-Message-State: AGRZ1gJI4QfUHelIEVDSU9+3czzAnqD7XVNFX34CC6BpeDqfYhwyxi+I
        hbmVq8YlYqg8ECq9DlurOE/X6zjVeyU=
X-Google-Smtp-Source: AJdET5ekdkmzqedLVig/PpfbUGgDZ+wv0I/WEGX7wruvQ3I5l69D/nJkT41/v5OzyAyLhjj0Ijcm2A==
X-Received: by 2002:a24:5f90:: with SMTP id r138-v6mr10100374itb.18.1542395175233;
        Fri, 16 Nov 2018 11:06:15 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:0:7004:d809:1aaa:87dd:87a5])
        by smtp.googlemail.com with ESMTPSA id u22sm1843603ioc.28.2018.11.16.11.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 11:06:14 -0800 (PST)
Message-ID: <1542395172.7838.15.camel@gmail.com>
Subject: [ANNOUNCE] 3.18.125-rt108
From:   Tom Zanussi <tzanussi@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Fri, 16 Nov 2018 13:06:12 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.125-rt108 stable release.

This release is just an update to the new stable 3.18.125 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: a3456b7dddca102a7ca8e36d0f87cfc71e1b068f

Or to build 3.18.125-rt108 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.125.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.125-rt108.patch.xz

Enjoy!
   
   Tom
