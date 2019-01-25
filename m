Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B07BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C20218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="GzjF7tBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfAYSRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37396 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfAYSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so9367818otq.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z/ofs7NvAQ0crEjWnKyCEL0KkO/9TOta8dgWkolmTGM=;
        b=GzjF7tBaGFcyLaWEqtvm5qlRM0kDiZyxKF7SeD8Dbj3MeH5XWcrxOn41H3N7S2LgY1
         ZoDt5YZ/WXpc+9T80nJeq0/M2PFhH8AI22fpx7BSQ3OQj8SurnttlFnQH5he4+7Va11m
         bh3tXLLyLw2YRGmkp6nH92+elz5OfVaVfDE/wUfNumktL5o6So7soZXW5GTcG3ib2XYa
         ++lcwVKN6RViyviKL+CdIOCg73L6dL3ojMtGkez/q+H7HzPQK+8KI8Wi3WRuQHc6NiV/
         V5xFSa1h0KBhrdosUDd8mPjHxiBA/QqRVbRnPI15+FRarWVwAKIJ97uoL0cfaiDAycYM
         2tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z/ofs7NvAQ0crEjWnKyCEL0KkO/9TOta8dgWkolmTGM=;
        b=giOfJBjECjDLbCHBu4nIIQtuIlFprTVmcv5GnatvhqtAE2zdVe4l/4W0JM64xfwDxl
         jMAHegOqw0aTfQLgCaqpFao/6zXhTYKXPzzIv7ioNp+Igkx2Yd3Iyw+2GCP123xQN/iV
         cdq9DZK3cFhd9d77Ktooe7Y4KYySlC0WQPaWcFxJeR+pyuA7LxfmWrB+iy9Hxj4YOxWS
         wuxftebAcSvnak77661UBxu4WYW6wgaBh6E+1yve1Q8/sUYceiDAbB3iuL+uJZ5AybNQ
         482Nth7drnoc5ZLV9GbK3/YJ/8Adb0O+Et/IhMlQJcL7nWhL3XmYsOZIpM0emxB8D3zV
         HThQ==
X-Gm-Message-State: AJcUukdA2enHxB0gLlkN8C/f+CcaZM/Pm3iFjyCcRDB80lqlsASeLeLt
        v5h59dez81wnujNZlYH8ZwEoVIQs1Ow=
X-Google-Smtp-Source: ALg8bN7rTc4LSr4Sa420fj9/+C8BLmON/RinDPCHcABMUfNMbprliDcXXsq57DvBLHtBqphUvPgxKQ==
X-Received: by 2002:a9d:3b62:: with SMTP id z89mr9242778otb.134.1548440234972;
        Fri, 25 Jan 2019 10:17:14 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l204sm1461179oia.54.2019.01.25.10.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:17:14 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com
Subject: [PATCH/RFC 0/5] HW accel subsystem
Date:   Fri, 25 Jan 2019 10:16:11 -0800
Message-Id: <20190125181616.62609-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per discussion in on the Habana Labs driver submission
(https://lore.kernel.org/lkml/20190123000057.31477-1-oded.gabbay@gmail.com/),
there seems to be time to create a separate subsystem for hw accellerators
instead of letting them proliferate around the tree (and/or in misc).

There's difference in opinion on how stringent the requirements are for
a fully open stack for these kind of drivers. I've documented the middle
road approach in the first patch (requiring some sort of open low-level
userspace for the kernel interaction, and a way to use/test it).

Comments and suggestions for better approaches are definitely welcome.

