Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39989ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90EB208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgIwsKt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90EB208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPLJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:09:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34899 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeGPLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:09:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so24088423ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=L/3l6WWHhx/J9hiPVU7OfIJlErkpLEy/ECZngf8LZVg=;
        b=SgIwsKt/es+UyxycbwqRS+bd8ctYP+XmepZ3m4d2uHBtWEJO5F3x2cjyHe5FnIzcU0
         NEbI5KsrfczcCguiAEc33rdRm7ILvcxDA+ZHmencp+t5Otdd4vCaV8jCBtH0ICZhxT4o
         cfTLzdGxwdBxvNqh2qDnQWdPwZRzRXy1ww/iFJ6QrAmHnyFJCmKyuANz9zVC0abZEfkg
         +JLqBGNL03ZtFTvNZTjbWcHbVFktQ0f+T0VMpMzxhI3d4g7k6jzji2e0Df6JnAUpHFgM
         MjNjVDqpNTZ8jBdZsRxgBShQdj1m7Qo4Pw1F2/tFigIvMj5aDVLAb+qcdjE28Y6tWLNh
         9SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=L/3l6WWHhx/J9hiPVU7OfIJlErkpLEy/ECZngf8LZVg=;
        b=SqpilWsVANIrD5hjiOBx4lTlkvRGP2pAFZxccDqk4NLOv85qSZc6I7hWVg7dAsnxcV
         XyEDTnCZhReWaJ6pbJT1ssoQKKQ/4m52lkaNxZMOtAanTJ9JAJBhYyZl5p7AL/PKjhGk
         F4i43iaOVYRaALy1YejGiZyWTa3UOMj8iIbYi8iCAJnTg6WQV7yFSPiLjD6fIfWadD4C
         Kt5/QWxcwVzr5UvkTa11VU255nIMSiwRtmhleBCKhio0ZdPaLn4qgnt21kd7S4f0naAl
         7SD/I3QaMSopH1YQBw62+t9geyKxIB02rL9q0WB2PJJsMNaCAXH/2TL/QqIkAMEp25IP
         8HXw==
X-Gm-Message-State: AOUpUlERsmDirEctjr1r+q53ejUg9jJ9dYlomK8QxomHWBI9PoLgK+tY
        e/l7LYVw3NvnC6lcoB1SKmY=
X-Google-Smtp-Source: AAOMgpd6z3LIEMYLRvZ7rWYU4UV/TYGr6oRREqHsPb7EMRDm2O9mjxbvRmS0Xny0jxiF1Q6WBlYlww==
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr9565269ljd.104.1531737745073;
        Mon, 16 Jul 2018 03:42:25 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id z5-v6sm7786590lff.96.2018.07.16.03.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:42:24 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1ff0xM-0007PU-6a; Mon, 16 Jul 2018 12:42:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] gnss: fixes for char-misc-next
Date:   Mon, 16 Jul 2018 12:42:01 +0200
Message-Id: <20180716104203.28440-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a resend of two gnss fixes for char-misc-next which I noted you
haven't picked up directly (I'll continue picking these up an forwarding
to you in batches if that's alright).

Thanks,
Johan


Colin Ian King (1):
  gnss: ubx: make struct ubx_gserial_ops static

Dan Carpenter (1):
  gnss: fix potential error pointer dereference

 drivers/gnss/core.c | 4 ++--
 drivers/gnss/ubx.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.18.0

