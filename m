Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9405C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814662089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2h8BBDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814662089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbeKPX7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:59:03 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:47102 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeKPX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:59:03 -0500
Received: by mail-wr1-f42.google.com with SMTP id l9so12070221wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 05:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bj0mBK85Ztxp5r+CDjzHFjizt5ScRo/9fcvI595U7/8=;
        b=L2h8BBDM/gA4cPiYEhsE3va/MSDj8LIxdhyIAsvuYtadH1CnR5NTUMVo6ZGQ1dUr7D
         DFgcXruyEv7eZqrY4VXJe1zS/IyD8loGu9rFVuNkCvaEzpz+tDIjqtBvG7XP7GszqsAh
         tmsxH1XqP0eG4O/zdcJ2ao5ZgThRkHiQ/Ww2ONzEBb8P0ogI4XNgImzubBrO+DfOj7LV
         k12zwj+xNFLYl2ERxu8RBvN2TE8idfNKNvywPwiR98paTo+5Pc1uTJkmoGZlCrMUnSyx
         GmJPF3o4H9sqk4jigkdpuPbqtMCqHw/H8OZwOFkAiwRd1LHAltf0SfAhQ3frxGg4K+Qi
         fCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bj0mBK85Ztxp5r+CDjzHFjizt5ScRo/9fcvI595U7/8=;
        b=ZRklpeGWBA48H8u4pxgjVhXfL+qVBWO17eUs/F5LAPqqxNMS/ei4Rk6+8eFwjO1v9S
         px63a0mh6Tkl449LN2xtMZVbbyYc0h6u0aEImDka4cOwlfbKKIV5BKQQVylcm2bxbq5M
         3yldnEu5GQqMd8t7YSVDyMYnvKV17Z5qS9qt3A3mhTYZ7Hd3bsULn6cplAG0JrHqJj+/
         UTsNYz6lAE1h6RlMe+HDlrV578fulO5G1mPpH/IX9JSvB807QErbY6kQ3DNmF/G3djrH
         ZLasMMzGcVWE26y3AGoQQIJdZFzTFUNdlebDKDxKwarpdlf2sNjj62nDzh5/E7tMhY6x
         QUZw==
X-Gm-Message-State: AGRZ1gLauv5JLt4b/lDWAikq3LXcx7aS/QTY8U5Cc1WOsQkW2ceDBXnT
        CxUJjxYdalfBYCmLLEhYDQBUxiY=
X-Google-Smtp-Source: AJdET5dnVqUfB6J/0LKqKHGL9RiUbpPXngZcC+Dsk8rwzkGrg/jF1+FPV5euK+PfP2Ntg15c9fbBBA==
X-Received: by 2002:a5d:4012:: with SMTP id n18-v6mr10169303wrp.185.1542375993190;
        Fri, 16 Nov 2018 05:46:33 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id 132-v6sm8228317wmt.0.2018.11.16.05.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 05:46:32 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:46:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: update MAINTAINERS with proc.txt
Message-ID: <20181116134630.GA8004@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that /proc has official documentation and people even trying
to keep it uptodate.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11995,6 +11995,7 @@ S:	Maintained
 F:	fs/proc/
 F:	include/linux/proc_fs.h
 F:	tools/testing/selftests/proc/
+F:	Documentation/filesystems/proc.txt
 
 PROC SYSCTL
 M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
