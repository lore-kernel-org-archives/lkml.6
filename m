Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C6ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6102146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4lyzRwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6102146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeIRO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:27:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43589 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:27:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so1154962wre.10;
        Tue, 18 Sep 2018 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYI301E1J8Ik+W49WXr5lyMAzbkEfvvkhvxtiPliCgA=;
        b=g4lyzRwQFPMInR2LU/nuC7EdHzIYhZuD1IKI1qaduzAyZm+60tlqotU9sMaJlzeEBl
         os9aJhdLO7jIxIiaPvaPANfB86w8QLTmIeXQqGOvi4IHYAroddjUheTVgGLbWAVRPRrd
         PBIGcoSuTQo1HKEwiXElEtC7G6qCfswvc8MaXumv7QuP24a9BBMA2GbqYBcubhcM5ZMk
         2LjVzKb2BoF07b7CTVACoZKTkj3fv1eNnH3Dys1/nwWeZjUPMPoBcsMh8Axowzky/WMg
         4llrrhDYJ+j6AGkwa7hSDp1A7vuFgxb/mLN19Oee2U1O6rXknkrHqpeAGYupzz/l6t6C
         IlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYI301E1J8Ik+W49WXr5lyMAzbkEfvvkhvxtiPliCgA=;
        b=EgwVljqlHkQ0cAvNDNKqf2N+TL1I/Ntq/mPgfpNO5hswwVcYiTUHldDchyHhcOdUyB
         C/mjRgd/+AsdBT+SxCHLc6miZotvhzkqK/5NzfTHhr4K0WZriG9CTo2MXhz3gwaJe+D0
         y+XGGHS72FhT8TniSu3zeRgbvxis50gGscsjlvM2RKxNcEgHwrjDKHCcaq9y+Jg3988F
         mIUEin1U99Dx2yv4bV8w+KbYCAl2nQdhR5iWvjsOu1IpG0abFZ/1nalaIHMma9gdDj7o
         UhGESebJ6vs0Pq56ughbK7mN7HuMfFrLBDurqSNo5qEiBlOaPKcd4bFgNVrw0EB+GJOA
         rrpA==
X-Gm-Message-State: APzg51DOcuBifoDzaJVcg7nlG1/QaqoxM0DpEg7nCD+iSA66aX4/V3sG
        oVSrGaV7fREJvS8Japhf+jI=
X-Google-Smtp-Source: ANB0VdYXi55A44gJKa9otS3drIj04BqAFwK2DfV4TSJLB/yorqxcNuCb1pC/jO0rPG218crrW5STQQ==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr22996960wrc.119.1537260920333;
        Tue, 18 Sep 2018 01:55:20 -0700 (PDT)
Received: from pi ([185.208.64.4])
        by smtp.gmail.com with ESMTPSA id a37-v6sm38735319wrc.21.2018.09.18.01.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:55:19 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.90_1)
        (envelope-from <johan@pi>)
        id 1g2Blv-0002tS-FG; Tue, 18 Sep 2018 10:54:15 +0200
Date:   Tue, 18 Sep 2018 10:54:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v3] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180918085415.GB3943@localhost>
References: <20180914161155.GB3443@localhost>
 <20180910174322.1042-1-pados@pados.hu>
 <538e77cf9622664f3e9d79a90269cf7d@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538e77cf9622664f3e9d79a90269cf7d@pados.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:54:34PM +0000, Karoly Pados wrote:

> >> +
> >> + /* Chip-type guessing logic based on libftdi. */
> >> + priv->gc.ngpio = 4; /* FT230X, FT231X */
> >> + if (le16_to_cpu(serial->dev->descriptor.bcdDevice) != 0x1000)
> >> + priv->gc.ngpio = 1; /* FT234XD */
> > 
> > No known way to identify FT234XD here?
> > 
> > After taking a quick peek at libftdi, it seems we really have no clue
> > how to detect these device types and 0x1000 could be for all FTX
> > devices. Heck, the current kernel driver just assumes anything we don't
> > recognise to be an FTX, something which would now hit this code path...
> > 
> > What devices did you and Loic have? Could you post the lsusb -v output
> > for these? Perhaps someone with an FT234XD can chime in as well.
> > 
> 
> No clue about this one. I only own FT230X and FT231X devices, but it looks
> like they cannot be told apart, except for eeprom strings which are reconfigurable
> by the user. I wouldn't rely on such things. Anyway, lsusb -v outputs attached.

Ok, thanks. I've dropped a mail to FTDI support to see if there's way to
tell FT234XD apart from the other two. Otherwise we probably need to
register all four pins for all FTX devices.

It seems reasonable to assume that the FT234XD CBUS0 pin is indeed
managed as CBUS0 of the other two types (rather than say CBUS2), but I
asked for confirmation on that too.

Johan
