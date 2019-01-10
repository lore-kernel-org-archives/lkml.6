Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE61C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19417214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547131177;
	bh=5BNyugRz8d1gPadvL8INWxqbZ5iNPe7pWOFusNzLEFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gjubhLrghRqxYGkiGa+ZKZd8gv2QYmTXljao2BlEmxfMUsrXwUpg3jz7qJIUNY9Nu
	 bfN37SVPYzsSKWTbgwkuRKvK9Xs0rcjWsVyYM9+/e6AQqqPF1noauAOaXnWF5sxxxS
	 yOpOUdTvOVHF2Lcjb1tb7zD0+nojQsgbPLTjHMAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfAJOjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:39:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36221 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbfAJOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:39:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so9925645ljk.3;
        Thu, 10 Jan 2019 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbwFhDKs8so7z3+IhjwLcg0f0wkFKnbHQOkf+Ze6x/s=;
        b=WmV+nrdiM6R8RORywIf8In7pH3niQUdoVLVKl++S7yFhIEzznUQrBueQa3Pou5BnHD
         JOnuc/iVvNg/O/cMIGkg5eGLww5ZmeqBir4kd6LtuZWXtnmqSr8Cl63z9W/Uii0d69/B
         MjOziQTQQ+1doBTyPgCOULs0FXsk1nZYdjSDQ+vVRFg/ofEZcgAIl9Zj1RLbW0Spn/O9
         EuSzBmOZy/uMVGIBGYnfQ7wPsFHbj0XzRjKYxSMNMG0P6/0cea4YXqpYa/DFFh/VFWM4
         49QHhvpcOWPHoo0/efUq3RZfZn+bSJvq665P0HnjIjrxHYGgPtket+sHs++5RpWVmjPO
         G9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbwFhDKs8so7z3+IhjwLcg0f0wkFKnbHQOkf+Ze6x/s=;
        b=JVZRRUtrQNpL6529dNoUTSxlvrFj/9t324yKlByidcPbDeT6yYqiDVwLGcq9pXUwND
         T329ZnvoFdWkD7DCqo3GW0CkZwLXJ3yAHWj3or6e0vuFS5VjUIcZPTdS+HJGVC9OWQFD
         i9W+fbjdEOim9/Q2rAnNEGEjodGxUHXHTG4bRU3omhCCPDVRWBhlQ0eBlXMOpS21z7cE
         QHMVMZVDDH7OMZxeTv4EFrdbCsugx15tH6KIRk4j7T1dVR98VcF9RQqBgH/iMCbMxcos
         9pRaPegCK9yAUku04qPneNVrMzPjYFFH2kDMSawALHfqTexzAuHBD8wR2kkaE5qyvv31
         UU0w==
X-Gm-Message-State: AJcUukf5Lh5TddhdteLiYEEHb1f5za4YrWpqnZk6vd48BUFptW7TFzBl
        b97Znu8hCpDu4Bn+qtLA6Sw=
X-Google-Smtp-Source: ALg8bN636rCDfB8gv8cTY90AGF9FcEimIVdkMPaTRVYJ+nIaGxvR7rBui+OEx8u6KK7miFvRbai5kA==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr4034704ljo.10.1547131169178;
        Thu, 10 Jan 2019 06:39:29 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b81-v6sm15283790ljb.7.2019.01.10.06.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 06:39:28 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghbUW-0001yd-9F; Thu, 10 Jan 2019 15:39:28 +0100
Date:   Thu, 10 Jan 2019 15:39:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190110143928.GE3430@localhost>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5160d8862b49f0369fa58610516d354@codeaurora.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:04:12PM +0530, Balakrishna Godavarthi wrote:
> Hi Johan,
> 
> On 2019-01-09 20:22, Johan Hovold wrote:
> > On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
> >> This patch will help to stop frame reassembly errors while changing
> >> the baudrate. This is because host send a change baudrate request
> >> command to the chip with 115200 bps, Whereas chip will change their
> >> UART clocks to the enable for new baudrate and sends the response
> >> for the change request command with newer baudrate, On host side
> >> we are still operating in 115200 bps which results of reading garbage
> >> data. Here we are pulling RTS line, so that chip we will wait to send 
> >> data
> >> to host until host change its baudrate.

> >> +		/* Deassert RTS while changing the baudrate of chip and host.
> >> +		 * This will prevent chip from transmitting its response with
> >> +		 * the new baudrate while the host port is still operating at
> >> +		 * the old speed.
> >> +		 */
> >> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> >> +		if (qcadev->btsoc_type == QCA_WCN3990)
> >> +			serdev_device_set_rts(hu->serdev, false);
> >> +
> > 
> > This may not do what you want unless you also disable hardware flow
> > control.

> Here my requirement here is to block the chip to send its data before
> HOST changes it is baudrate. So if i disable flow control lines of
> HOST which will be in low state.  so that the chip will send it data
> before HOST change the baudrate of HOST. which results in frame
> reassembly error.

Not sure I understand what you're trying to say above. My point is that
you cannot reliable control RTS when you have automatic flow control
enabled (i.e. it is managed by hardware and it's state reflects whether
there's room in the UART receive FIFO).

Johan
