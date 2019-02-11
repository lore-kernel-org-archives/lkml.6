Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2505C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AF120818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwdKO/pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBKI7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:59:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38959 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:59:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so15527187wmh.4;
        Mon, 11 Feb 2019 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=njYTby10V1glcjx/H8Lc+HK02O9cOTDYdh8SDVLdIBI=;
        b=cwdKO/pfLuQLEM29x9rF9pjTC/K1Xytw8q/McNQpnP3RCbx09fqSfTla7b9VEvHuFk
         TR8vPY5d3s/tMjeGRBm9wWChhqNfQAQhHrtodpiLO1DslWysxKLyZw+znQKzbhQJCvr5
         HLt2ckYpqeZHw/+Yoji2cWiYwpDW18+IcNxSagf5XruoYqCF1zTnObGK1hbfO6LYHihi
         2T2YVNkqpH9Ozv6ZYHL3xDcFT04nXt5MMN5R+qDtM3qrcsjC6rCrbmfgXkRcedsstaeo
         bliip6tYTeW4MPuHrDKUVI5yL6YZIE1T1Ka2Tk8z6feOVtlQVTVfB/de5jgX8OT3XrqZ
         7hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=njYTby10V1glcjx/H8Lc+HK02O9cOTDYdh8SDVLdIBI=;
        b=YkdjO9aQP7Ihb0d8LVcC9Sz9oblrR2dx3Mv0m1vj67T5Q+w3b/wDPlsJDDXIl2Lcxo
         tcoh+F25XIu//BLGlGrdwtVO07tKM88OKl5zYwQFc3LDlLXJWrMP5qm6F2oXKs5NDii1
         Jvlvn5lKLEGbvFbEkLOZZ5ArPnjzp40RWf7M+1K/dMA40TVARKbpf20/nPtjoWkbgojm
         L8xD2l8HvsMQDZN2SuvUmbo4rsvboSR1dcGI9Rd5XI2tYLCCEeiXFPELEPsvMItVRtv/
         zhYYhrZHnnAzXA0QkRrIhltlLH6yzJOj8ZxxwY7pUvkWACBxh/M2Ii+Ztkyk9qPDSKZJ
         fXKQ==
X-Gm-Message-State: AHQUAub/VMxONjdv8gSzaYGva4NVZ6CJiKk7l1gHQR6SXog24apnTeeE
        UXmLcaqLnKjmUG/JyQROlSzkse0s/bUu2xrE2WQ=
X-Google-Smtp-Source: AHgI3IY1VVSdplAhO4WKFOVONKLmk9hHOqJUstJJMMDWHiVAtRgTWDNQIayJRrfeWUtp50jkTssBPskHau4PP2AJ2LI=
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr619015wma.40.1549875589703;
 Mon, 11 Feb 2019 00:59:49 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 11 Feb 2019 09:59:38 +0100
Message-ID: <CA+icZUWPw3tzKAKAt=rLv09nPCwXVbc2h=Thb-5EOxc7Jx60fQ@mail.gmail.com>
Subject: Re: [PATCH] fcoe: make use of fip_mode enum complete
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Cc: Hannes Reinecke" <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        QLogic-Storage-Upstream@cavium.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

I have tested your patch with LLVM/Clang from Git (will get version 9)
with (RFC) asm-goto support.

I was able to build with CONFIG_FCOE=m and CONFIG_LIBFCOE=m and boot
on bare metal.

Feel free to add my...

     Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

If you want to send out a v2 please feel free to add the following Link.

     Link: https://github.com/ClangBuiltLinux/linux/issues/151
("-Wenum-conversion in drivers/scsi/fcoe/fcoe{_ctlr,_transport}.c")

Thanks.

Regards,
- Sedat -
