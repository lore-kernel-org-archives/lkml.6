Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29813C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44DA222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Isqp5m+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfBPHWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:22:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43127 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfBPHWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:22:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so5897893pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGwf1K1ul1SssrzyY0oltDyHnTAGA6RBtABDfmX5rW8=;
        b=Isqp5m+qJU1qQBQpX5sAebfqNBlu1//s2U064HV2svlpCswe/FuUlhz1vI+d8qLH/E
         nb5KZ/JdTqC7CNnWZWgPzXKGRADRoP8RgdarF2Ws3UhqI2l8MUIbArTdkKjEvq3t8f0O
         6LEteJzxyVcVbHUUGapMgHu43yRzm7W637nkIC9u7DvHDfUP7QHtGDlKw/nxRf8vzqQf
         gHZlFQpPf26JiNneB5l4C56dVNB6uiJB/CWVEVbHlOij38nzgNTYa1CALkH06XMDuQu/
         9qMBnjBixXrkVMijJzCD/P2N7csdbhMlMTlRhB1p10uP5mCrqTeswKf4qkQm0SdkW2UU
         +8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGwf1K1ul1SssrzyY0oltDyHnTAGA6RBtABDfmX5rW8=;
        b=mN4VYKbYBmFJ7dHHBOG4MsAAm9iEm0FkR48L3Tx55V2suSoMDXo9TQg3hLiS0lKMaw
         lp2pTRBEdflchacllLeWwEWsPHMoLHGos+sV5zb6xkMx9EBTXimtV8v0tahWCah2uzkO
         wN5Crz2/qdMDyhxWsgNKVuR9tT2AdfpdT0hIbI3lZdYna9M/597Hlr9qokqvrw7+sTJT
         gjAleNOjZjwBcuUjbf4tXpnmJS1H2mRDQ/lPFPrNI9CjynBRlcB2YnyimAGkgOQEM168
         0RPxVLnaEAzf2lnegMMvyH8q+azYXO5bm9kwQJBrsvWr4P455emA0N4Ng2pimu26+xJj
         vu/g==
X-Gm-Message-State: AHQUAuacTvCAgyBkFup5soYRpxJCEGgTV6aRriwOdKWBmjU482FqJNjZ
        oCPq59HjuZdSEKZaHYMQXmw=
X-Google-Smtp-Source: AHgI3IaqZ7oGf2JR6gz2iqbmBDojdAKYnr/hLn304utSKAaApKFH4Wl+/lImC5Eoh7QgxaeQbVvDPw==
X-Received: by 2002:a62:e086:: with SMTP id d6mr13702294pfm.247.1550301764285;
        Fri, 15 Feb 2019 23:22:44 -0800 (PST)
Received: from localhost ([221.162.103.114])
        by smtp.gmail.com with ESMTPSA id d129sm13781684pgc.59.2019.02.15.23.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 23:22:43 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Feb 2019 16:21:27 +0900
To:     Yao HongBo <yaohongbo@huawei.com>
Cc:     sergey.senozhatsky@gmail.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in console_unlock
Message-ID: <20190216072127.GA1945@tigerII.localdomain>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/16/19 14:36), Yao HongBo wrote:
> hi, sergey:
> 
> As shown in that link, https://lkml.org/lkml/2018/6/6/397
> 
> On the linux kernel 5.0-rc6, Syzkaller also hit 'possible deadlock in console_unlock'
> bug for several times in my environment.
> 
> This solution fixes things for me. Do you have a plan to submit patches to
> solve this problem.
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> 	__printk_safe_enter();
> 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> 	__printk_safe_exit();

I would probably try the following:

---

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ec145a59f199..058d004dcbaa 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -172,7 +172,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	   have queued and recycle that ? */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
-	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
+	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
+		    GFP_ATOMIC | __GFP_NOWARN);
 	if (p == NULL)
 		return NULL;
 
