Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54099206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUQaAg9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfAHRXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:23:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43524 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:23:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so2190657plb.10;
        Tue, 08 Jan 2019 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I3DdqyBbCDt6zyGPe+xhXsw0Y/WXjQ8N5sQ3ku9MkE4=;
        b=hUQaAg9q/VbXk8Q2KxQiw33ZW1D+drwFszAPYMwtGZklxvdXrNhsj9xes780LzJtBq
         kLviZR/GlbCeRATqRtpBJpNDFsFWtJ6Iwn4o3q77sbRzPG1p/N9CUJmf4U/F4t1GGJMy
         jBT97/a/8xu/VqivzPjgprIWynvMGjPw8CnMkSA/mGUwQdz5zEBW+2DtbvD5+ep9hsKt
         mF3dpyq9vPYJzOLbq/RIsyzIUQ8ly/H3VphEPMIyNV2JJKvcdMFvc8hxNdGDVbOsU3zK
         Qsm8hTIU+twkhaamQbIjbIHQJh7+Ay1EfuRhUHPFLnx5SSe2IGeGrKin417enw2ZDxr9
         BtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I3DdqyBbCDt6zyGPe+xhXsw0Y/WXjQ8N5sQ3ku9MkE4=;
        b=VbkUwPOKg8xdrxO83+AXrxFI9zZ/YL+XDSC1J/Cm43LW+dJRQEeGhvIyFgmjXCkqTH
         LYvglS+KyeTOumVPZIfu1du4UsgR3mTKlLrBQQJy3cekkd5q4ZFJUMzOMAdCdmEe/Fxd
         HYR5WZMYQp2GHI8MJmgsfNUN1slmb8M34RA7OpcJidB27+/jcEvrprM87a8yJp19Toa7
         botV9CvJA1QLW+ZNIsqGF8T5nfhuuwukOnNsUL8B/Me3WR+uTD277zeRcE1u9GWM+Ohn
         STclP214ZVenYn0SOpK2KAS77nQnVp0kk1N4b1F/CRoOZ8Y2+wlAOCevLZcnIwsWbjmW
         o35g==
X-Gm-Message-State: AJcUukfObnn7g+cha48L+x6XQ+jY5ek+iDJr8bcWSyZq+45fwuIjeae5
        6XSUTpXZpACVkx79CKAi5tc=
X-Google-Smtp-Source: ALg8bN4l4opzpXpXyJp6dJQwl4ugptcghcPwszYuyyawky2HT9USxc6NP1y49gHdFh6PmgMkPuC3UQ==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr2593548pla.136.1546968229102;
        Tue, 08 Jan 2019 09:23:49 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id k15sm115474126pfb.147.2019.01.08.09.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:23:48 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net v4 0/4] net: bpfilter: fix two bugs in bpfilter
Date:   Wed,  9 Jan 2019 02:23:42 +0900
Message-Id: <20190108172342.11917-1-ap420073@gmail.com>
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
In order to identify UMH processes, a new flag PF_UMH is added.

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

TEST #3
   while :
   do
	modprobe bpfilter &
	modprobe -rv bpfilter &
   done

The TEST1 makes a failure of iptables command.
This is fixed by the third patch.

The TEST2 makes a panic because of a race condition in the bpfilter_umh
module.
This is fixed by the fourth patch.

The TEST3 makes a double-create UMH process.
This is fixed by the third and fourth patch.

v4 :
 - declare the exit_umh() as static inline
 - check stop flag in the load_umh() to avoid a double-create UMH
v3 :
 - Avoid unnecessary list lookup for non-UMH processes
 - Add a new PF_UMH flag
v2 : add the first and second patch
v1 : Initial patch

Taehee Yoo (4):
  umh: add exit routine for UMH process
  net: bpfilter: use cleanup callback to release umh_info
  net: bpfilter: restart bpfilter_umh when error occurred
  net: bpfilter: disallow to remove bpfilter module while being used

 include/linux/bpfilter.h         | 15 +++++--
 include/linux/sched.h            |  9 ++++
 include/linux/umh.h              |  2 +
 kernel/exit.c                    |  1 +
 kernel/umh.c                     | 33 +++++++++++++-
 net/bpfilter/bpfilter_kern.c     | 76 ++++++++++++++++++--------------
 net/bpfilter/bpfilter_umh_blob.S |  2 +-
 net/ipv4/bpfilter/sockopt.c      | 58 +++++++++++++++++++-----
 8 files changed, 146 insertions(+), 50 deletions(-)

-- 
2.17.1

