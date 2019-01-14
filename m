Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8109E2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547478834;
	bh=P+WNT6zs0nOjgtQyDRGhCG1tkenPst6LJ7ljABmfsoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VT60VZAQ4kXi0FEgH+7uAS4DMnSq2ymMbB5oS1FtkzDxexS9MfTOZg/6GXg725Jz4
	 +ApPrAH01pMfKfN5pYJOOAraLyDYTs6f4GP6+wJoC5qCRMWQTtOLppgplCAiPBjqeJ
	 zRGnV5Golz6gG1loy5RjQYVLT9vHjJyR9wCy3vuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfANPNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:13:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39280 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfANPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:13:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so15866182lfh.6;
        Mon, 14 Jan 2019 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dCRKAOgAfDElEEGVTP+Nkt9jCMq96uDfAqY2f6xcaWw=;
        b=rQqDGiBsBj51tqAMz+dD6/hxvH4WB1krEXV2F7dUcJa3kU9XQKvCZu0pQI79owq+Wn
         0MFBWV05uhX2K5zfZCwGGe+kmqz6AFYwDy5/PCeCtJ8nklR771wFAW/S4CYxnWGDoXFX
         DJTbf1V48wv3HV5cS8U2ljupuIc/xVYdGs6vytyZgnHK860+dN+9iF2W9JwhHa7KWY4f
         sSRSZdkG48prpIXSXygorfN1p2MZoRiR7N1V4gpiIgFFqXtHcHibYSD0ShcbgQFUgyFC
         eXCtDY0QtOZbUHEbwMPG+Mdwhh3Q7Wm8bgKTh9qo3lJQoxu8bUFKeOtERdpyIyHZm1NL
         jRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCRKAOgAfDElEEGVTP+Nkt9jCMq96uDfAqY2f6xcaWw=;
        b=R/ehtCuw49GfJX6x9NNucyHb2putX/WjMAXPvm1fvSXBy8n8Ic+iKBw2zDnU3Dfqpb
         HejbpBG16SttT47EBt3Iv+tu6GP8jBr3uGs1hIB/5/fgJsJxdkbn5faaemilmVhlF0qm
         He9Duf+y2I6gaodQcB6PVSJd0u0TOeFxvMIPw6Ief/11RluTSVXB+AJ63n0tm2kE/igZ
         4xdYKDl0z0OFKW345/duFOsPqIKQ4eTfw8L5H09dDQXwBuH7Ly3IaD276azrcg4J3bmS
         6ObE5b85CrLHT7vQLe8XXK/8ehJJMPLS3JN/Di40Zii/0mdulFQov1jQUZbdPMUWYOY/
         S0Yw==
X-Gm-Message-State: AJcUukeQGDFLkEkeRT6OazHZ91ii/opmC5geXQkqM4xAcce5qDd2whWz
        QdIjPQXoppUuOe2+xx9XmNc=
X-Google-Smtp-Source: ALg8bN4NlqDRKZvjepBuu1DIHuKNgj0KChlH3F9Uq1dfT8rOWzYzs9ajwuDWdOhI/uTuBiBzSm/DIQ==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr13509463lfd.90.1547478829894;
        Mon, 14 Jan 2019 07:13:49 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o88sm125946lfk.38.2019.01.14.07.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:13:49 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gj3vw-0002FB-1i; Mon, 14 Jan 2019 16:13:48 +0100
Date:   Mon, 14 Jan 2019 16:13:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH] USB: serial: ftdi_sio: Fix GPIO not working in
 autosuspend
Message-ID: <20190114151348.GJ3691@localhost>
References: <20190114123003.8228-1-pados@pados.hu>
 <20190114134821.GH3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114134821.GH3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 02:48:21PM +0100, Johan Hovold wrote:
> On Mon, Jan 14, 2019 at 01:30:03PM +0100, Karoly Pados wrote:
> > There is a bug in the current GPIO code for ftdi_sio: it failed to take USB
> > autosuspend into account. If the device is in autosuspend, calls to
> > usb_control_msg() fail with -EHOSTUNREACH. Because the standard value for
> > autosuspend timeout is usually 2-5 seconds, this made it almost impossible
> > to use the GPIOs on machines that have USB autosuspend enabled. This patch
> > fixes the issue by acquiring a PM lock on the device for the duration of
> > the USB transfers. Tested on an FT231X device.
> > 
> > Signed-off-by: Karoly Pados <pados@pados.hu>

Do you intend to send a corresponding fix for cp210x as well?

Thanks,
Johan
