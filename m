Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80261C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C32F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550654588;
	bh=WzvN77styY+QDxWRPE6fM5E9A3Wu/gPUT2Fl8XWptZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NsiVz6f07g6iSXu5ihket5sCytsnO7+d/3FdI+QcFTYKFisMMbboA1yXk/ulKK1rE
	 8D0FiDQ4lV/PS3pXsE8RKm5bOpKo4yhmQtagrPHwMz0dGsIXpABe4AhiSay52qiIfG
	 Iz3CqKSF9Myiew4PIyUW9YfgS/ZCXLeMHSR/NWRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBTJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:23:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42610 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfBTJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:23:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id d14so8988553ljl.9;
        Wed, 20 Feb 2019 01:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3f9RbvU+MyiOonrYpIf5VWXPQgi423S3M5basbahIyw=;
        b=YsILp6tn1iFmsE2cLyJe1kaZIGlef9YJ7oohNzs60ieJb7F0+SbJV0ZLNT+LQX8c02
         P4TSkeidW+MwUPpSuvVc+7cjrMbg9kiOxoyy7gMCHpe4/pt8574uIIvHg6ufUtMuS4hi
         SAm6A5JbS3I6rXHLvPF7zu7Pm0PT6yhHiiMeLOqJo3PCYIcqni6x1wgAtsKh9CazeoHg
         +Zhe9wlNxtwrUtd/73pmQFG0XO1jddQSCqfB22ySwRAbWGTlFaEHZJbLXYmK/j/h5gZd
         4zIySg1jzBowdJ+8slCpKP4KVb3BlwTWM9PClZ/kwm7t8TmIUyU+sgJpn1vMkSS3q/eC
         zmgQ==
X-Gm-Message-State: AHQUAubNFrnfdfdUdbDc+xgZn2EpzFflhkmjHT346Ng+1k4ijTLoz7FJ
        5/Fo6EnAP3Ex39Pdh0XrTes=
X-Google-Smtp-Source: AHgI3IYAvSLnJrWlbBvHumfRBWKMZUPsQnnn8aRFxpw1V2BxaW9W/RbpopJj6Sqa+QOyw2btlOV1HA==
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr19999563ljt.159.1550654583634;
        Wed, 20 Feb 2019 01:23:03 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l72sm5282904lfg.75.2019.02.20.01.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 01:23:02 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gwO5p-0003jE-0K; Wed, 20 Feb 2019 10:23:05 +0100
Date:   Wed, 20 Feb 2019 10:23:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190220092304.GG4072@localhost>
References: <20190217175901.3986-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217175901.3986-1-pados@pados.hu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 06:59:01PM +0100, Karoly Pados wrote:
> Current GPIO code in cp210x fails to take USB autosuspend into account,
> making it practically impossible to use GPIOs with autosuspend enabled
> without user configuration. Fix this like for ftdi_sio in a previous patch.
> Tested on a CP2102N.
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> Changelog:
> - v2: Restrict new autopm calls to GPIO paths.
>       Always check result of usb_autopm_get.
>       Rebased to current usb_serial upstream.

Thanks for the v2. Now applied after removing the unmotivated white
space change.

I also added a Fixes and CC-stable tag as this seems annoying enough to
warrant a backport even if autosuspend was never actually supported.

Johan
