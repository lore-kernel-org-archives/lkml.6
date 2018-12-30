Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF363C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8FD21873
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2cqFKMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeL3QbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:31:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40495 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeL3QbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:31:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so11885200plq.7;
        Sun, 30 Dec 2018 08:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MbShhGC3U45A+UQ3w2sDqhHcEIuZ88bsR7FXlV3nM/w=;
        b=Z2cqFKMCi8q+fiioO4g1uIgPUZx6PyORezXi2oIbQlnahdJOqq5hBh3jGkdbF9gp0x
         agG2S+5nZTNvzD8KFmJSFaTktnyE6DEPBZ0RxJDer6Ly+Zj9DHGz1wMMQy7dJELECAoI
         clxTlhUF2Ce5RKK6fhG5VKT4E6YvfMoliqtzovBEHBd1YNYggkzK2I/s+2H4e9g0GgPM
         zL1yMNFEjkqbAYcmgTUCJ9N71vKqRIrXnAUEEvAyA48PBl4BhqUMlwf74DjYfHtXNfkf
         kKGZO3GCXMc61Cm6pQteGkLyPfyE3iLHGt9cYk9BAIqI3povHp27jyCXBual3XbahEzi
         pYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MbShhGC3U45A+UQ3w2sDqhHcEIuZ88bsR7FXlV3nM/w=;
        b=Djlj2RXr29fBPnpDA/ppczFT4WMoEWcyYl14/Rb+xfeMSgAqG1qQKjA0gEREK5drpr
         OGuqSNpJESAP3HUhgsFpCzBaxzK8elKn0bPa0biNTeN3862sGTHPoeCWpAA/iPKsQ4TN
         iGRTwbyeGWQdtU6EnGBtxPt5phK6e8zuDx3cjyHflBF5TXA6cIIkoIwKVi3hwA3IR4nj
         xHZhVFlASnqg2xgVV9QK0B6xdejxGf7V3iak70aiWVHfScKgmZhNcgkH7bx5dUgxVg/5
         5MkWZztri6KEWBD+tn4ix+qoydz3KFhk4Y+QhnoRLcDTdouxZq5UL5oc2QbCqOu9ndEB
         2/mQ==
X-Gm-Message-State: AJcUukdczdX21tsr0LiAXFTm66zB8rffd+jjjixPm0XKUWXR+bEPFBEP
        6gL0hwu6DdTpidm7abRIK7M=
X-Google-Smtp-Source: ALg8bN59S1p7/H8AD8n50Y7/g1mpHC6mDi8ZlD4rTHO2ATpNHCGw41Z0VB+UWarTCvhqMIhSYeWMqw==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr35109000plk.291.1546187478220;
        Sun, 30 Dec 2018 08:31:18 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id h64sm70034279pfc.142.2018.12.30.08.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 08:31:17 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net 0/4] net: bpfilter: fix two bugs in bpfilter
Date:   Mon, 31 Dec 2018 01:30:45 +0900
Message-Id: <20181230163045.20813-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fix two bugs in the bpfilter_umh which are related in
iptables command.

The first patch adds an exit code for UMH process.
This provides an opportunity to cleanup members of the umh_info
to modules which use the UMH.

The second patch makes the bpfilter_umh use UMH cleanup callback.

The third patch adds re-start routine for the bpfilter_umh.
The bpfilter_umh does not re-start after error occurred.
because there is no re-start routine in the module.

The fourth patch ensures that the bpfilter.ko module will not removed while
it's being used.
The bpfilter.ko is not protected by locks or module reference counter.
Therefore that can be removed while module is being used.
In order to protect that, mutex is used.

The first and second patch are preparation patches for the third and
fourth patch.

TEST #1
   while :
   do
	modprobe bpfilter
	kill -9 <pid of the bpfilter_umh>
	iptables -vnL
   done

TEST #2
   while :
   do
	iptables -I FORWARD -m string --string ap --algo kmp &
	iptables -F &
	modprobe -rv bpfilter &
   done

The TEST1 makes a failure of iptables command.
This is fixed by the third patch.

The TEST2 makes a panic because of a race condition in the bpfilter_umh
module.
This is fixed by the fourth patch.


Taehee Yoo (4):
  umh: add exit routine for UMH process
  net: bpfilter: use cleanup callback to release umh_info
  net: bpfilter: restart bpfilter_umh when error occurred
  net: bpfilter: disallow to remove bpfilter module while being used

 include/linux/bpfilter.h         | 15 +++++--
 include/linux/umh.h              |  4 ++
 kernel/exit.c                    |  1 +
 kernel/umh.c                     | 27 ++++++++++++
 net/bpfilter/bpfilter_kern.c     | 72 +++++++++++++++++---------------
 net/bpfilter/bpfilter_umh_blob.S |  2 +-
 net/ipv4/bpfilter/sockopt.c      | 59 +++++++++++++++++++++-----
 7 files changed, 132 insertions(+), 48 deletions(-)

-- 
2.17.1

