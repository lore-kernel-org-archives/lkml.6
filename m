Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD4CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6392087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpjpKSIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAaFIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:08:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36198 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfAaFIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:08:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so949450plo.3;
        Wed, 30 Jan 2019 21:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KG2AV5CuLWGdXnt2HvHXI2jXxW3jh+qPOjX2cdS/c/0=;
        b=UpjpKSIRhm9rpjDcXsjRNcUSd9mLdNkyFNHZVnFbsy+DwqC/DIc7LTf2dpNLQ9cR3B
         Jkda6deq+zuBDgvLWG4ZluwdkILBQZKYcKdy3r9b8WrFejtTTlzLQHqdnCUPQ4daUx+P
         T0kKeg4/ggLLo3eBVaU1BcDGS1WPBKtzZ+GvNpwwx4YF366tue8mDFeD1sgWapSvJyab
         M39flzBK7mSraQ+ORYfBe8Z2Z6ZHzZgva1VE1hXVB+18MdLU7DmKPBirMvoJMiqOunV8
         8dR8gZ2xdbX8fLdYna94DMN8vE8K9lkMD7mX3a3U4E0Ti0+mgyPOohz17iI1uwn6v5lQ
         fAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KG2AV5CuLWGdXnt2HvHXI2jXxW3jh+qPOjX2cdS/c/0=;
        b=W5iFbasDe1kPKhRYnR2y5S4rHwPDuVwRQUGwnUOXnyvXaIDZjscb4oBoS3nebFlUdU
         YZxIoNhPJj75VYLUUISE57zeUUfRiHqN9AqbVKouzGXJNYk5IrvGMNW+HiNWx1RXFlig
         1DOVmCT6LBAeqslLRPfE40jqyUasf6um0e9MrHtNc3g5GJwiJN/pM+2ylaDM5quxFrND
         E4ogmQMRNMxFoHGUdG0C90qH07ptRJPsuA1cZE2ex/zIoL2IhWiNKMcPAfQAAlkO+1wq
         IoUk4vp1uBTxlLW1hQKj0XmXOTSMz3KbZZGacriraE+Of5m3BzGvLuI6sv/lt+yEoAd6
         Ivtw==
X-Gm-Message-State: AJcUukdCTY2ZcaxseH2a8rfA6f6r49aoA3zZQPJyaS8vF+CSV/5E2JtE
        T13pPp3DxX2besrMnPzeoPo=
X-Google-Smtp-Source: ALg8bN6+hhNDwtvGM7scN1cJoM2eY7V97sPcqJmM0jBSk63y7Wlab8fLJLZUHFS4MTyMPuwWUBc/8A==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr33601376plo.257.1548911326615;
        Wed, 30 Jan 2019 21:08:46 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id c67sm5000525pfg.170.2019.01.30.21.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 21:08:46 -0800 (PST)
Date:   Wed, 30 Jan 2019 21:08:43 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add NULL check for tiocmget() and tiocmset()
Message-ID: <20190131050842.GA31677@myunghoj-Precision-5530>
References: <20190128065910.GA14959@myunghoj-Precision-5530>
 <20190130095938.GP3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130095938.GP3691@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:59:38AM +0100, Johan Hovold wrote:
> On Sun, Jan 27, 2019 at 10:59:13PM -0800, Myungho Jung wrote:
> > tiocmget() and tiocmset() operations are optional and some tty drivers
> > like pty miss the operations. We need NULL check before referencing
> > them.
> 
> Good catch. I suggest splitting these fixes in two separate patches
> (after addressing Marcel's comments).
> 
> Don't forget to CC stable and add a Fixes-tag for each, as we we want to
> have this backported to stable.
> 
> > Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> 
> Actually, these two bugs were never reported by sysbot AFAIKT so no need
> to give credit to anyone else here.
> 
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> >  drivers/bluetooth/hci_ath.c   | 13 ++++++++-----
> >  drivers/bluetooth/hci_ldisc.c |  5 +++++
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> Johan

Hi Johan,

Thanks for reviewing my patch. This change is not directly related to the issue
that syzbot reported but the test will keep crashing without this fix because it
will finally reach ath_hci_uart_work(). I updated and resubmitted patch.

Thanks,
Myungho
