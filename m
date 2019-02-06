Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CE12175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trd6DY+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfBFGfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:35:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44210 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:35:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so2656405plq.11;
        Tue, 05 Feb 2019 22:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qu0XbiKv4CghM/9Kor6hUhvTCrbLkpnmY23QKJgYX6c=;
        b=Trd6DY+25rI9LIo82JhBvb34aAxQeBqu2jBD8Xn4NDyHJvTfx4lOsPrbuE+sY6al6K
         QsTe0swBNDVDVDFc2HPglZXbyZuWbZJBigNnVRcnJb7FdiOUkoWYAGCjAYfk0z+ch6nq
         nH0MqYTGplIRBdruoSGOMVzktBJQnXxZXxunY9BpVBRSzBciYMuuaBUrsp8KS4JnwpAi
         czq8DARsU4CokDkMjmHLFINvYhAUjqSzHoQnzcKb9wHf5YZQCR+HEniydHJ1c7rRSA47
         90Pqfa6VijwctOcUHtvAuZd7zwD2C+fmw+ANbZXhEkavoNogr+1MTK10HoiKrJgfsvFx
         oDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qu0XbiKv4CghM/9Kor6hUhvTCrbLkpnmY23QKJgYX6c=;
        b=eSaWzxVNJuVQQSsAwFnc6g5EcM0oaLH9YHrJyED7IhNTKDl1wBExRQQkPSDjU/bTnH
         wtw0fdfT9QVj+Syw8JNqWtrp0p3g3N4p1mdQ3jAaUB7mLRCA2Q9Up5gakJuOjhZZFeNb
         FnVad7Mcn13FBMqpGvA+9gs9PvuZLV+r8xtQCAXDLpiCIxrBaQFhmCsiWEwwOFmahPEj
         BWs0TjV1mkXqao0GZjrnXj4IBhi0Q/LwT62NHYsTXRvjhYpYVvlAGfoCPEF6+e2i/hjk
         GOf/W4/HMeDKm+/WBtFjvGn2H03RlfMeWUfwiiwC6zroQ9bxiM+aj48kuvfN9ia0VbSs
         7Mrw==
X-Gm-Message-State: AHQUAuas6lwRUw5alIbPwM7pCBc/q89pgccFIz5msS4GWPZIZ8bHAb9u
        kWBtZ+0aIVjS4Wj0S2t5gr0=
X-Google-Smtp-Source: AHgI3IbG7xAnx/70ZAPhJOSNCQTVYnJR3FLNngZQo0PsFVNDnavBZz/XFLs8yK/8h+lUxiOIxe+Cdg==
X-Received: by 2002:a17:902:e98f:: with SMTP id ct15mr9013133plb.273.1549434938281;
        Tue, 05 Feb 2019 22:35:38 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id t67sm12377320pfd.90.2019.02.05.22.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 22:35:37 -0800 (PST)
Date:   Tue, 5 Feb 2019 22:35:35 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190206063533.GA7402@myunghoj-Precision-5530>
References: <cover.1549346039.git.mhjungk@gmail.com>
 <0D421861-FCD6-4AFF-8A0F-DBEE520DB64B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0D421861-FCD6-4AFF-8A0F-DBEE520DB64B@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:55:50PM +0100, Marcel Holtmann wrote:
> Hi Myungho,
> 
> > tiocmget() and tiocmset() operations are optional and some tty drivers
> > like pty miss the operations. Add NULL checks to prevent from
> > dereference.
> > 
> > Myungho Jung (2):
> >  Bluetooth: hci_ath: Add NULL check for tiocmget() and tiocmset() in
> >    ath_setup()
> >  Bluetooth: hci_ldisc: Add NULL check for tiocmget() and tiocmset() in
> >    hci_uart_set_flow_control()
> > 
> > drivers/bluetooth/hci_ath.c   | 6 ++++++
> > drivers/bluetooth/hci_ldisc.c | 4 ++++
> > 2 files changed, 10 insertions(+)
> 
> why are we not enforcing the availability of these in the hci_uart_tty_open?
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

Are the operations required on any HCI UART drivers? For now, I found only 5
drivers (ath, bcm, intel, mrvl, and qca) are explicitly calling them. So, I'm
not sure whether it breaks any existing code with other drivers if returning
error in open().

Thanks,
Myungho
