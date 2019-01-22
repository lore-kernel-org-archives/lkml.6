Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB2C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D0220866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y5YGS+Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAVVxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:53:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41013 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfAVVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:53:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so32408pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xmELSHataISH5vThijiY1zNydt2sRYeLj/tC2a6MpI=;
        b=Y5YGS+XfApbE/H9ALND+YmmlNPp7JXcRo9oaKgN0aXlulYRCcSFLaq3UQdJNJtpFcq
         jj72LBn9McVB7BwKl6eTUTAcZpSbVS4ZFJDGtfxvZGXF4DKe5UDtKxzkCSqVetkMFbrP
         MDCvUT7LX3k+7l3HmTbRbH3zFjx7ds7rfXXrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xmELSHataISH5vThijiY1zNydt2sRYeLj/tC2a6MpI=;
        b=JZGEmMurol7/zMiwRMxVgLtjIGV/eAOhQuwaj9OihWFQGhzLIs+6k9Vrs9JoBhwBar
         cx+G+BS0bIKj4a9WEEqNUTBrjpoY8FIuiVG4PivMCwwN2n5/PORCqcmoSnU+rN6Ov7zz
         bdKjmRNlUcqDWe0ySiou2QUMwG3O2Vi3/N9flwdbIDms/l0OASx1Eh390QxIGFTgrKya
         HsZresXFHHUWOsPwzbERvGmkLUg+5YwDKW1wmUeMPtfoTbnAvzNY9H0GSBp0mGxX1QJC
         k2H9aojKFHxt9j22qGTeWG/pUvzEumLqGckjt9L59dllafbpkOizZyZo6N1dGFPEmNaZ
         ayrA==
X-Gm-Message-State: AJcUukent0CPKP04xdRb4JDTUjLwfp2uu+U3hpnJ0rk64k6KBL23V70e
        SCrbkD1zcfkhzJZy9YRi9Tx0rKZ5k2k=
X-Google-Smtp-Source: ALg8bN43Fv6i7dp4x6fZQrpJTgaAAkSBgEvBMEKO5bp+aaHrZYNntySuODgk1VLu7hQn7HThysoN1w==
X-Received: by 2002:a62:f907:: with SMTP id o7mr34695979pfh.244.1548194011474;
        Tue, 22 Jan 2019 13:53:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s9sm23467463pgl.88.2019.01.22.13.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:53:31 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:53:30 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190122215330.GI261387@google.com>
References: <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
 <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com>
 <20190118094416.GB3691@localhost>
 <20190119003109.GD261387@google.com>
 <24831204bab89250099ca56e7562bd16@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24831204bab89250099ca56e7562bd16@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:11:39PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-01-19 06:01, Matthias Kaehlcke wrote:
> > On Fri, Jan 18, 2019 at 10:44:16AM +0100, Johan Hovold wrote:
> > > On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:
> > > 
> > > > I observed that the qcom_geni_serial driver doesn't raise RTS with
> > > > flow control disabled. It seems we have to investigate why that's the
> > > > case. I agree that the driver should be platform agnostic.
> > > 
> > > Sounds like a driver bug, unless the hardware is just "odd". The
> > > driver implementation of this looks very non-standard judging from a
> > > quick peek.
> > > 
> > > In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
> > > flow control is not enabled:
> > > 
> > > 	if (uart_console(uport) || !uart_cts_enabled(uport))
> > > 		return;
> > > 
> > > Perhaps dropping the !uart_cts_enabled() test is sufficient.
> > 
> > Thanks for taking a look Johan, that was indeed the problem (also
> > in set_mctrl()). I posted a fix:
> > https://lore.kernel.org/patchwork/patch/1033611/
> > 
> > Balakrishna, the following (applied on top of your patch) works for me
> > with the UART patch above:
> > 
> 
> [Bala]: will test and update BT patch accordingly.

Note that Johan pointed out that hci_uart_set_flow_control() deasserts
RTS when flow control is disabled, so the _set_rts() calls can be
removed. With that only a single action needs to be undone in case of
an error, you can consider to keep the return instead of using the
goto introduced by my patch.

Please keep/adapt the "Deassert RTS while changing the baudrate ..."
comment to leave it clear to posterity why flow control is disabled
during baudrate changes. It's fairly obvious once you understand the
problem and that disabling flow control deasserts RTS, but it took us
a while to get there, initially we only had a comment saying
"disabling flow control is mandatory" (I recall I inquired about this
multiple times during the initial review of the wcn3990 patches ;-)

Thanks

Matthias
