Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41352087F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVbLxt/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41352087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeH2EJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:09:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42698 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeH2EJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:09:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so1448344plq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wj5u/G3tJxXnxe2ZR6EfhuWCyX3HJRD4Xvyv9DRyinc=;
        b=KVbLxt/H6ON1I3FAZUypc2ZjpylFgUwat9IZCRxvrakztmRD9s3+Wgzzr5B84tI8mk
         e5BS8PIm7JDX6d1spvaSk/nlPtlxYLroSPv9KjjU73wLqbp5eCNkyeXBxEuwtawwIchg
         fV2xwXbwtVSsr4XekEnNDqw27d8f9fFvW+6bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wj5u/G3tJxXnxe2ZR6EfhuWCyX3HJRD4Xvyv9DRyinc=;
        b=B3IGyynCbi+sz+bVXW8VSPS3A/01+83XKu5GTzz0qSYPb9DUSkNt3qcyOM949ctPYj
         27yvEgyF5KKTs0D0uO6lfq1M2S9BGE3mRrsHYdOQDqmtP8BO0hFHl0wUHaZ7eZvlKTv0
         c1aXWNzS0L/s2y/KGWL67sg/Fp+Oav+pGk3jTD1hProXBmvXQkwQ3ojcRMuVHKZ0Mv/Z
         rkxydOYGLmxT2tzR5auYcW33KaJHYRhCpKKSgvyg3yD6RAcZtVqleYsOjUkc+54QQpu3
         obfcbWg1ftXXFNcjUT7fOePqZy6VGqhWa6nCwPuSZVAy7rA3f7ZP3r4SWp+ZUuXAwyBL
         g/yg==
X-Gm-Message-State: APzg51Cr5qqS3lx1bDqiCVt0uMUoTS4xMBWjUe4JF2xdbeVL5F7TW5NG
        NJCvPbJl0auFK9c/mIblRgd6sQ==
X-Google-Smtp-Source: ANB0Vda+8y87PIUzpsOZ94Nx9OqyPr7XvANgFQjSK4U8psdDgaxl2tUmnHx03aIA0JR5bWRbQGzqfQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5-v6mr3660992plt.140.1535501697926;
        Tue, 28 Aug 2018 17:14:57 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id g11-v6sm2206198pgi.90.2018.08.28.17.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:14:56 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:14:54 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        govinds@codeaurora.org, linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
Message-ID: <20180829001453.GA173345@ban.mtv.corp.google.com>
References: <20180810233948.144792-1-briannorris@chromium.org>
 <5B6F2A47.7070502@broadcom.com>
 <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
 <5B71CDFB.60408@broadcom.com>
 <878t4qftnm.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t4qftnm.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:33:01PM +0300, Kalle Valo wrote:
> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
> 
> > On 8/13/2018 7:14 PM, Brian Norris wrote:
> >> On Sat, Aug 11, 2018 at 11:26 AM Arend van Spriel
> >> <arend.vanspriel@broadcom.com> wrote:
> >>>
> >>> On 8/11/2018 1:39 AM, Brian Norris wrote:
> >>>> Devices may provide their own MAC address via system firmware (e.g.,
> >>>
> >>> You got me confused by using just "firmware" in the subject.
> >>
> >> Yeah...I started by writing this patch with device tree specifically
> >> (of_get_mac_address()), and then later found that there were generic
> >> "device" helpers for this, which can assist with other sorts of
> >> firmware nodes. It was easier to put a name on a device tree patch
> >> than on a "device" patch. I suppose "system firmware" might be a
> >> better description?
> >>
> >>>> device tree), especially in the case where the device doesn't have a
> >>>> useful EEPROM on which to store its MAC address (e.g., for integrated
> >>>> Wifi).
> >>>>
> >>>> Use the generic device helper to retrieve the MAC address, and (if
> >>>> present) honor it above the MAC address advertised by the card.
> >>>
> >>> But this put me back on track ;-)
> >>
> >> Let me know if you have a better way to clarify. I can resend with a
> >> slightly modified subject (s/firmware/system firmware/), or let Kalle
> >> do it, if that's the only thing to change.
> >
> > "system firmware" substitution works for me.
> 
> What about:
> 
> ath10k: retrieve MAC address from Device Tree if provided
> 
> Because from ath10k point of view we use Device Tree functions and don't
> care if it's delivered by pidgeons or by system firmware :)

I don't care too much, but note that Device Tree is a loaded term,
usually referring specifically to a method of describing system hardware
via the Flattened Device Tree format. If I were specifically targeting
Device Tree, I'd use helpers like of_get_mac_address() instead. (The
'of_*' prefix is a relic of OpenFirmware, an early firmware
implementation that used the Device Tree format.)

If you're trying to say "device tree" to refer to "the Linux device
hierarchy", then that's also a fair description.

But that's all starting to mince words. Device Tree (with or without
capitalization) is fine with me.

Thanks,
Brian

> I can change this before I commit.
> 
> -- 
> Kalle Valo
