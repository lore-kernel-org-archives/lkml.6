Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE71C67875
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38EB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548068266;
	bh=rBNyKy3If8+TKInA3qeFmlR5Cdpn9IMT9QGtDt1Krrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FN5eQVghM+vpZtfhxop1mnAA5FGcO8IV6DcWT6+J3umq7ZCQ7RbNuljYQgMTBd7hC
	 vFFfVlW/UReURj9v7/dI52lkGFWSV6BNmwRiZRnr7njFVNqSQPxIz3bas46TdiW9Rn
	 Kda2gocAH8Ul5s6wKf/zm4qR95k9PWbtrQYN+21c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfAUK5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:57:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfAUK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:57:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so17109018lja.9;
        Mon, 21 Jan 2019 02:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQbcQ7Oz67LcEZsVrpY14O+1if33joyOeTLxdHyWAbw=;
        b=Rh3E45OI6RPq9wg8JDmlP/n2v/7thmRrosrrEcwJbxEf74SN6vWRYBQ9ItGaugNjyd
         2f9tlgkLlTlqwE/bA9gddv8WGiQr6GAh7EoxrF9wb8P58N8GQJ5kwBjPdKxWEJsx+b8D
         gfnpkRXxwVebz+nQ3vuIQqwySVwNsTcjH034vLNV6NLIL/LSZefs7mBDRpjn7jRj7BIm
         69r/1L/l0y2uKgmgxBPc3vG8r6rVJVFEU/tR7j/ntrL0avMi8BadzrPVfU2gCKBg0hio
         tXbdVFa7bIIZ4t/ApaEoTgP5oscWfoEAlbfIkJgydm7iaB0DDjn3LH2MwpTZ+4MVKxib
         Ll3g==
X-Gm-Message-State: AJcUukc6/HSsvogLvKkmJZabhB7+z4L395+1srSBpPwm9yLCA96qOcxM
        3kkG4z2LBvn89WOI5suXAmc=
X-Google-Smtp-Source: ALg8bN5m0XB+jXujpBiihRoYITauh3jpeX+2hQ4z69fPYJmr+qvyDKR2zwlFEe4Mn+fPiFRqTB65Aw==
X-Received: by 2002:a2e:2246:: with SMTP id i67-v6mr15626620lji.154.1548068261212;
        Mon, 21 Jan 2019 02:57:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2248078lje.78.2019.01.21.02.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 02:57:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glXGp-0000zZ-SW; Mon, 21 Jan 2019 11:57:35 +0100
Date:   Mon, 21 Jan 2019 11:57:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190121105735.GI3691@localhost>
References: <20190114012528.2367-1-tony@atomide.com>
 <20190118115958.GA5532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118115958.GA5532@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Marcel on CC.

On Fri, Jan 18, 2019 at 12:59:58PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Jan 13, 2019 at 05:25:25PM -0800, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's a series of patches to add initial serdev support to n_gsm
> > TS 27.010 line discipline.
> > 
> > This allows handling vendor specific protocols on top of TS 27.010 and
> > allows creating simple serdev drivers where it makes sense. So far I've
> > tested it with droid 4 for it's modem to provide char devices for AT
> > ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
> > 
> > I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> > For reference, the MFD driver is at [0], the GNSS driver at [1], and
> > the Alsa ASoC driver at [2] below.
> 
> I have applied the first two patches to my tree, as those are nice
> cleanups.
> 
> The last one I want some feedback from the serdev developers to verify
> all is set up properly, and Johan, to see if this ends up conflicting
> with the gnss code, as that would not be good.

I think we need to have a discussion about how to model modems generally
before getting into implementation details.

Modems are currently managed by user space (e.g. through ofono) and
I'm not sure that moving only parts of its responsibilities into the
kernel is necessarily the right thing to do. You still need coordination
between the various components for things like power management.

TS 27.010 may make it seem like we can move everything into the kernel,
but Tony's to-be-posted Motorola MFD driver is still exposing character
devices for most of the muxed ports. If I understand things correctly,
there also still needs to be some coordination with USB over which some
channels are handled (e.g. IP over USB, gnss over muxed UART).

Instead of adding these extra layers, only to export most ports to user
space again, it may be better to hook into the various kernel subsystems
through dedicated user-space-implementation interfaces such as the
suggested ugnss interface, which means that user space feeds gnss data
into the kernel which in turn makes it available through a standard
interface.

This would also allow things to work for other transports such as USB
CDC for which the mux protocol isn't used.

Johan
