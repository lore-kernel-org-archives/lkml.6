Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC9C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE4D218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRbXSN19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBGReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:34:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32920 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfBGReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:34:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id z8so258079plo.0;
        Thu, 07 Feb 2019 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PCYhZyNInpjLjW+q/t1SME/ASaPkda8cIIIuXHBmTU8=;
        b=eRbXSN19cx98TfnL4TmLQemVkDnp2Yu8dCaoXDVqAtlwmnRFAuN5Hdzi4X8Yi3nTr5
         HYqpgZdYvVrnoA/nqG/hCaqGEWbw8oi8l9DYONET8CBZrZeOMyRMJp5rv9KZrNtRJoow
         gc/Y1tP4hv5gb3ywBo4BFbqM8YOjVyssdG1b0eHcSkh4vOkQ86yy/vnN3EqCu8ztYIrZ
         airIzMGppyOjXoeHZxYHWaXrrNQ7ZWzwt3KAV7or8RbPnP03TuohHMVDm1+ILqzuB4My
         tYXgSzvJ4gaWrVH8K0+OBzqMz9aRFMpC7Ehw65Z0zAtFBI7RfIcRdx5tmjuRCtKaZ34e
         hzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PCYhZyNInpjLjW+q/t1SME/ASaPkda8cIIIuXHBmTU8=;
        b=j+zBal/b+jy8bRBXVVsY7XGMRMlh4OpRAc5paX8LM6+gA09oP8vXvrO483tbvWbukV
         5XfcSMPU2cTAne2DuuapJZxsQIQKVwJtHgAk260luiSpDKk2TtE5GcdtQxlcINufCmcZ
         JWIQ1Y5qqn06vK1wkxk4ODJSCpYBsAxrDVawr3mTdPMsTIhFbpbXHztsKg+FvWBkkGB2
         vZfkhbwK8xdUmbkN9s4vqKGOyV1gQ+UfwFUCrHtlIqVVe093mDtdzQVmhO5Kpnemqfzd
         FgCbb/9795BZdetvKzRXV9tyY1z5MbG1lxJMGo6WMN1hcp5p2MT4pQGX+m3KRr9hDiV/
         Qd7Q==
X-Gm-Message-State: AHQUAuZOorY+rgCH+KZSVp2KYLLYamceI8VWRppKptNyYYLX2NB4fif/
        E5AeqyeajARhConsyuJSxts=
X-Google-Smtp-Source: AHgI3IZiY6IHULVNBZi6wIvad/+CLDo+lEcAcQSm9hdlSPf6sNeWeugsHczfcQ1PCXJ5xJV8+73Y4w==
X-Received: by 2002:a17:902:b60e:: with SMTP id b14mr17131793pls.301.1549560852023;
        Thu, 07 Feb 2019 09:34:12 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id e16sm12034426pfn.46.2019.02.07.09.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 09:34:11 -0800 (PST)
Date:   Thu, 7 Feb 2019 09:34:07 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190207173406.GA32315@myunghoj-Precision-5530>
References: <cover.1549346039.git.mhjungk@gmail.com>
 <0D421861-FCD6-4AFF-8A0F-DBEE520DB64B@holtmann.org>
 <20190206063533.GA7402@myunghoj-Precision-5530>
 <AD78221A-2ABE-4BC2-A63A-F706FD5BC2FE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD78221A-2ABE-4BC2-A63A-F706FD5BC2FE@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 08:06:54AM +0100, Marcel Holtmann wrote:
> Hi Myungho,
> 
> >>> tiocmget() and tiocmset() operations are optional and some tty drivers
> >>> like pty miss the operations. Add NULL checks to prevent from
> >>> dereference.
> >>> 
> >>> Myungho Jung (2):
> >>> Bluetooth: hci_ath: Add NULL check for tiocmget() and tiocmset() in
> >>>   ath_setup()
> >>> Bluetooth: hci_ldisc: Add NULL check for tiocmget() and tiocmset() in
> >>>   hci_uart_set_flow_control()
> >>> 
> >>> drivers/bluetooth/hci_ath.c   | 6 ++++++
> >>> drivers/bluetooth/hci_ldisc.c | 4 ++++
> >>> 2 files changed, 10 insertions(+)
> >> 
> >> why are we not enforcing the availability of these in the hci_uart_tty_open?
> > 
> > Are the operations required on any HCI UART drivers? For now, I found only 5
> > drivers (ath, bcm, intel, mrvl, and qca) are explicitly calling them. So, I'm
> > not sure whether it breaks any existing code with other drivers if returning
> > error in open().
> 
> the H:4 spec requires setting flow control. In some cases this is done by the hciattach or btattach utility, but it still means that it is required. So failing on TTYs that don’t support it is just fine.
> 
> Regards
> 
> Marcel
> 
Ok, let me make a change on hci_uart_tty_open().

Thanks,
Myungho
