Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C956C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476E3208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bGpKN6k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476E3208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeH0Wq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:28 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33735 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Wq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:27 -0400
Received: by mail-pl1-f169.google.com with SMTP id 60-v6so17679ple.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=m2mhWq78/Nbgru2rh8hFvRfKGdjSYfl9dvhnyuEdFf4=;
        b=bGpKN6k4jQImTxLpBGbkgC3hYzLtn3g9zRq4eTO5+QDx/WraXGqCRaCbuykYERzbUr
         mQHrqDYodX0M08jafz2CWCv1qxYf1y8RwYSz0IEPkyoxJn7/8GizNwfMdmR/TDTxd+rw
         U3Qc6/rr80ZVZEs63cJfib6PSQtySHme2Xlu8QXes9ud0pV5CjA3DE5i2HIR41hdvmlH
         T9rNSPozRfBhPtpuzuD0M1gWUaVehVb9hhaLlNEx0PCMeIRc6Qzhq5Qp8RpcM5f9eX+l
         IEtQNGuCJF/yIwS4q1DhRjmfsX7yR5zMhep0GQSvpZys7wKJp4f1EWu3co3Bp7b6VMRF
         5JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=m2mhWq78/Nbgru2rh8hFvRfKGdjSYfl9dvhnyuEdFf4=;
        b=fIviaL7Gd3AgRcgY1iGAR82becroGLjCBSfqRwm695tXbUVLgPcotIqDy8VSPi9jXW
         HEKzxaEneI3tEDN3Xe9KNBZqrI9RX/zNiSFAeeeBJf7t9OD46nNosgXHUkes7qwMbjuN
         J/gtUqOS4HFU4Oe/GY99eQREz8Hy1PS/Y94f/DJsF+Hd+UfP8GGwfVlMYMTWJZ0TBYbd
         hwlcwnuMh1USFK3r+wk4YtHVwGtB3A1GJL5a2BR2xzMdCsJh3Qd/I/Dj5mfK5aHNh8fd
         wmHhAOAlbybRxmx7pcYa7fjka2Uc4t3hXzq1km+yxK3+prnwx9qL63RvdEKk95NKXjK8
         i3xw==
X-Gm-Message-State: APzg51A94Uz8mg6nAa+2oCuJjt6uCjxwkvcnos+L6cLHotlLi5FcQoZM
        SAqrMALJAZa+hCLw+qpGbPVUJg==
X-Google-Smtp-Source: ANB0VdYeWThdInCH2j99dJXzw41SoPhrX44HlFwgI5OET7z8IW+73hfMQ3EnxBchX2q1ACzrft7YVw==
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11-v6mr14189765plk.214.1535396318000;
        Mon, 27 Aug 2018 11:58:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l123-v6sm19010504pgl.82.2018.08.27.11.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:36 -0700 (PDT)
Subject: [PATCH 0/8] RISC-V: Assorted Cleanups
Date:   Mon, 27 Aug 2018 11:42:35 -0700
Message-Id: <20180827184243.25344-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, atish.patra@wdc.com,
        dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got around to answering a very old email in my inbox that was
a response to our original patch set.  These are meant to cause little
to no functional changes to the port, but I've given them very little
testing so I wouldn't be surprised if I've managed to screw something
up here.

I'll be sure to give these some testing before putting them on for-next,
but I figured it'd be better to send them out now rather than later.

