Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32922C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2D420820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr0Jnkwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2D420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeKAWo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:44:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34739 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeKAWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:44:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so5946497wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PjAe/SDyD9Gvb5FvZsuBgorI5jx9L+QPU0jYOhnQLSo=;
        b=pr0JnkwbFNhuBnMQU5rcpBkvbcNhLJLx++TOSentAfo0Iq6wHPP/rmXjjjQWpE1+Jc
         xz6xxuIkcqtBmWCVqQjpKqU7fZV+cA6N04Hf/+gny6F5gsWn6Nnitk2ujDt54wH12JBj
         heja0EEo4MAxAqQo49EvtmZBDmV8LYg492FHhEISXyFqaP/0w4lA28JvpToOybOLPnIZ
         NJb3ctz+jwjBEeWpct9+CmiMg6k9c/aczA7FwfxHuJNZG9Loj+I5p9PnR1NQItbSoBXR
         PlR6Gscwwzt9E07iS0x4Vz2+BsJ7FQtKe0je7U8dJUbGaI1ZgnjxEK72CjgzMQ7UlGEj
         jopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PjAe/SDyD9Gvb5FvZsuBgorI5jx9L+QPU0jYOhnQLSo=;
        b=ill2+gtOOIjkK9iWVX7knVmBd6/Nb8rOe6dG9M7eFnp2cTjvEaTRVN+nc3r3kJBg82
         Z9IHW7cWRZJRp/wHHDSmO+cEliz6gOgmfrgT5UXUYRVEjxOLUco1mdVP4A0CCa8jNtyU
         Zp6bIdH2gF4e9sqaAuUyOWeHX/N7qpRZO7VRaiwCmaXkV5wAmSToym47LmwQNbxj38/0
         vPqYG6IKNJ5vrzJlcgGkWlDobVSEcat75zQJTcOSf5gxc9P80L2ne/cLMqaI4LmiRS0C
         /TtjPOpRyWDvjQ6B1VbLftGLeaGR5fTmEoVjhwPZdwLSkUsGs+DskU8ZCWanagrrcAGo
         78gg==
X-Gm-Message-State: AGRZ1gLdNIEcjw7ozTOZXg0IZ+sWpysnxR4zyCN/dtXCsxduUw9Hu3az
        AW9DQRLJRzC+rObkLgYckBGYQwo=
X-Google-Smtp-Source: AJdET5fxD78xr8CjKXkOuZBL5t59XZszumsuQMhBUqtk9uxvWJ0/+SS7qWm6fJURfXm+MrS7kCP2zg==
X-Received: by 2002:adf:8547:: with SMTP id 65-v6mr6650932wrh.69.1541079716492;
        Thu, 01 Nov 2018 06:41:56 -0700 (PDT)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id h64-v6sm15470631wmh.27.2018.11.01.06.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:41:55 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:41:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] coding style: don't use "extern" with function prototypes
Message-ID: <20181101134153.GA29267@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the patch says "extern" with function prototypes makes lines longer
and creates more characters on the screen.

Do not bug people with checkpatch.pl warnings for now as fallout can be
devastating.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/process/coding-style.rst |    3 +++
 1 file changed, 3 insertions(+)

--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -443,6 +443,9 @@ In function prototypes, include parameter names with their data types.
 Although this is not required by the C language, it is preferred in Linux
 because it is a simple way to add valuable information for the reader.
 
+Do not use ``extern`` keyword with function prototypes as it makes lines
+longer and isn't strictly necessary.
+
 
 7) Centralized exiting of functions
 -----------------------------------
