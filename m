Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA6DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D102064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/jidccN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D102064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJJPOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:14:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34408 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:14:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so2124317pgs.1;
        Wed, 10 Oct 2018 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WxApTJYchzt1wXbM1o6DjQhoFEC8+juFEY2qnYm40KM=;
        b=u/jidccNZ6vZziRUrZMwQlfW7f5xBikqQxfdDE3oweBwXTT/mCD+ziyHl/0NdBzEdV
         DO6N53Af0H2M02eZxz4UP9urdVVopK1TqX99qqjH60w56LlXPgdp1e9tknrQsMpSdAeN
         MFZTpbdmtS+h8vkoK4V/uS3E8PXl3dmlDT3LylWXWweTJFoYWdzEvg8ExTVvf8BT9YlC
         fFwA1t2V3SyjLGnrudwcPMFqLLus5fNPr9CJ1LTpKUEdOWGuP1rDnjUyyz5YVbFasQQV
         kNW65tihrsMqVekEY08m6OMM9uU2/e/1+xBcqvi7MLQPidwDSFhiIJYLrqUtAOxPnAx9
         vKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxApTJYchzt1wXbM1o6DjQhoFEC8+juFEY2qnYm40KM=;
        b=uBwO7mMZ9V7fUV3qyGLoRw1DuaesJ0hbSVF79UzKPGtRSYnf5v9b0R8esDs6VXwlsc
         C58YkBVfSQyN7kqRx/VOwt2mCJObuz+D1/eW6jmEr5N40W0Sh5kK8w5b3bEa4i+L/NcS
         m1kuQL5FrAKQaopIJ2pYR0AvgtEBPYmyGBgYPaNyKGnaEXLy2GUryog/Et6lzmtM9NBf
         bF1iuAwBfTLsOVXtEwZDM+lfWmMmCj5EIQ56w6FwVEYB8sZaUtSM5a0pXYUpNOSFS4xG
         Jonm0d2pAW1CpBVi8P+SjtDh7O5glQUj/CUGCFX57WtqxP/Z00pzTP+hkzDRifDXipMo
         PWog==
X-Gm-Message-State: ABuFfog6RncehAl5/0qCCHiuJTWB/6HYyBGpIOlHkNw69RME7YaycMnF
        uGielTA2Z//QsNKH54Od80Q=
X-Google-Smtp-Source: ACcGV63FZG4vNO9e7ePws3+cnqEJmx3vgT5lvyTWWVCYxVlFGe5ls393wi7bIKneG+hRGMB+vqw8kw==
X-Received: by 2002:a63:2587:: with SMTP id l129-v6mr19733323pgl.382.1539158021377;
        Wed, 10 Oct 2018 00:53:41 -0700 (PDT)
Received: from localhost ([82.102.30.219])
        by smtp.gmail.com with ESMTPSA id u69-v6sm43340746pfk.68.2018.10.10.00.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:53:40 -0700 (PDT)
Date:   Wed, 10 Oct 2018 00:53:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts
 to prevent latching
Message-ID: <20181010075337.GA13524@localhost>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox>
 <CACRpkdZVWMAQxrX7CS-JtA9sRYqeNE+8X39yqfCNtYLmN=XDHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZVWMAQxrX7CS-JtA9sRYqeNE+8X39yqfCNtYLmN=XDHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:12:58AM +0200, Linus Walleij wrote:
> On Tue, Oct 9, 2018 at 8:33 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> 
> > Sigh, sorry, I caught this after I sent my initial all good email but
> > this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> > apps that want to use it ask to enable it). I can't say why, I'm more
> > than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> > done out of tree. I'll leave it up to you how to proceed given that I
> > can't run mainline :(
> 
> Which NFC driver is this?
> Just want to make sure it looks sane.
> 
> Yours,
> Linus Walleij

Hi Linus and Bjorn,

These two files should be it I believe:
https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/nq-nci.c
https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/ese/pn81a.c

Sorry I didn't get around to digging into this further today, I will try
to get to it in the morning.

Cheers,
Nathan
