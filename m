Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD8C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD1020870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBF3+ei7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfAUQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:45:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51973 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbfAUQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:45:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so11480158wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 08:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDxYTJCkwu03jawkGmBZbXp9CVtVHfvE9s554xM7p7g=;
        b=CBF3+ei7UWIUvx6PjTyJw84qTrDvAy/S5EksECR61xzeCxbA/eTd3penvfNwkbEDv/
         Yzptzkh7YGIPCIbSkXEQcvftFY4Sg3tLb21RAuhFsdLVLbt2oDgdqOKlcd0XB1QaTQz3
         rv8M/OUGhh22tKenEofjBVdQ4h7z+UGyf5Ns+4+dGB0I3lw/d/10ryrUo+Mt+ziyv65t
         eD506HlwA7SH/Oumtmggea2EmdAdzXwjwNrp1BiesdhvCvXMNJAEMpQWC3RWdF9OvF++
         NjoTwE7SUQ02yPRHpMqCSZpsz7Uqh6o668AuIzOadzGtcnYv+WT8VYJPoFw9m5WVsWa9
         9m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDxYTJCkwu03jawkGmBZbXp9CVtVHfvE9s554xM7p7g=;
        b=li+w6yhKrWDlOP/uzHZBW4EHsYokvYSCM7dAFUScBzLt4mrCl3klVElMOds+9HDS7F
         x2IytcK6sVOJ4jlyyHs2jqpBvnLbtuhanppWtr5VVUCBaLjHdv57qcKhWNpWqpG9X9n3
         DlDY3AJxs1EG8lWtXhByrjljhNbENGyaReNRKOS9kNRQHFG6Icta3dFcyx5q4ftcrhN9
         PEGw8uiembr1cTHckiPkeOKvO/2ZPwd0NUDMF1vc4XEARww6qwRC+SGWcgO9dcHu00L4
         ACQg4l9QMwsU2xFatj/Atv1uZzE4e4b8EEmKJ8Nqu+IhESNSCEcl3zpR4w/DrNnHy4G0
         yBDw==
X-Gm-Message-State: AJcUukdm23otIkj8U4EPk/7zrLD5eO8Sq/9kxeFqRikXisooAbMY7guW
        CH/PjVhbpRYwjR+bvJPRtlk=
X-Google-Smtp-Source: ALg8bN7xs4fwSTLa8RtVF8k9XKkbvuN2A8SofdeTvBo4PiGU3+lOJwghpKcxuim8S34dtqDUGAmIdg==
X-Received: by 2002:a1c:2944:: with SMTP id p65mr200096wmp.20.1548089116924;
        Mon, 21 Jan 2019 08:45:16 -0800 (PST)
Received: from localhost.localdomain (148.45.16.95.dynamic.jazztel.es. [95.16.45.148])
        by smtp.gmail.com with ESMTPSA id o3sm73806473wrs.30.2019.01.21.08.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 08:45:15 -0800 (PST)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     jack@suse.cz, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        nsaenzjulienne@suse.de
Cc:     Albert Vaca Cintora <albertvaka@gmail.com>
Subject: [PATCH 0/1] kernel/ucounts: expose current inotify watch count
Date:   Mon, 21 Jan 2019 17:45:10 +0100
Message-Id: <20190121164511.10822-1-albertvaka@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables reading the amount of inotify watches in use.

Inotify watches are a finite resource, in a similar way to available file
descriptors. However, there is no way to check how many watches we have
available or in use, we can only read the max.

This patch adds a 'current_inotify_watches' entry to the per-user sysctl table
that gets mounted under /proc/sys/user/. This is the same table that contains
'max_inotify_watches'.

The motivation for this patch is to be able to set up monitoring and alerting
before an application starts failing because it runs out of inotify watches.

Albert Vaca Cintora (1):
  kernel/ucounts: expose current inotify watch count

 kernel/ucount.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--
2.20.1

