Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C37C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4234D2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="jvQPIite";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFJJX/At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4234D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeK2Pb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:31:27 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43523 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbeK2Pb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:31:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 806E021DC1;
        Wed, 28 Nov 2018 23:27:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 28 Nov 2018 23:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XV5JpaL2jPItNOMznNTOzEyGffK
        mwCsnsa74Gk+KUMo=; b=jvQPIitetgm8Cu05cUbXO5h1Ztm6s96/02z9EqNjCH/
        Nj7wIJ+f5idoAi1CDehCl0XS5YycgwlgsEz24sV3sr9pVZVlteVEZvHpeIgCelOB
        m1a1n5W59KqkHSEFvfjmL98tpqD5racj3IT1Zfh5Ot8RYlpVS4S7IryvzZxLMgk6
        UO80yORctZ67/b7M5u1L53bFaNagOScnmTJv95aI91NHz/XOtVBXzVvQFdHJN8bz
        f1kMcI5ugpWU7AoRoqBeOSyCrBzW7L+0/lqrcn54Pbanvx1XRM34jlr5yj7zzzcS
        LmMkpcSBs9VNpChuau3gviRTOur7oQefv4TBjAeITcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XV5Jpa
        L2jPItNOMznNTOzEyGffKmwCsnsa74Gk+KUMo=; b=rFJJX/AtPO7WV0HdiDssk6
        8ve7KG4hI9wS/fyv/b67xgAhCw6JV9Bmpjaq0qk3TVqAglnjsWiLH0N+eYnjlL/l
        X1rHUQZxidbRBVph3yTsIURFV2493R4cCUaHGxkN60of8yhNIjcrR/7FKYC8/Ea7
        cvqW/wfYzqLyjxz/fkUDg99tvV+UBo/YrFwQQbpmiIr6w0TZRgCvPytFd1V8mmkz
        dM5AWUNLl2ceIjq865ghMMgVtxdde5wH8ODUesQhlIfv7sthLvaOSm7/9yfLAA7a
        C/EvZ0nzYIvDm+MGwXtK7lbHcg9zNxPsvtnY3GFFMDZP5Dn62TbHfZedOoZJSLVg
        ==
X-ME-Sender: <xms:rmr_W1UhI_PN8eFQDdcenKUhAAFjzTtHdkQ3XrLmA6KCW4hdPsP3BQ>
X-ME-Proxy: <xmx:rmr_W6oADQynOYS95Eke-hw3Agg_Z75Q3uLsbl9VguhYQbZB2L32Sg>
    <xmx:rmr_W1CEuhnsqifp5KqEDghvKnZfVNnpn4xgXkGxh66lyefrvNtk-Q>
    <xmx:rmr_WzrHxSMaO8JYgERClhJe_27SUKW2Q78czdzGnzgYo224UD1YKA>
    <xmx:rmr_W4AE4WgfNJ5aLk6zAMPuBNbzmZ9b5JzrJ-UVQfNShjvh4XsEiQ>
    <xmx:rmr_W2WKoKQf4tCQEHpAGJXb2jsnQEbAkl3k0dYn9hlyM8m6Thnotg>
    <xmx:r2r_W2H-B2sZASDHSizuZkYUhdkBN1ctmiw6SMfbwoGpeEJJfih_bw>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF34910409;
        Wed, 28 Nov 2018 23:27:23 -0500 (EST)
Date:   Thu, 29 Nov 2018 14:27:22 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Harry Cutts <hcutts@chromium.org>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Subject: Re: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel
 support
Message-ID: <20181129042722.GA5872@jelly>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:22:14PM -0800, Harry Cutts wrote:
> On Wed, 21 Nov 2018 at 22:34, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> > [snip]
> > Devices tested:
> > - Microsoft Comfort Optical Mouse 3000
> > - Microsoft Sculpt Ergonomic Mouse
> > - Microsoft Surface mouse
> > - Logitech MX Anywhere 2S
> >
> > The following devices were tested for the HID feature and didn't have it:
> > - Logitech G500s, G303
> > - Roccat Kone XTD
> > - all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
> >   workstation that I could find in the local office
> > - Etekcity something something
> > - Razer Imperator
> > - Microsoft Classic IntelliMouse
> > - Microsoft Surface Mobile Mouse
> 
> I just tested the patches with the Microsoft Comfort Optical Mouse
> 3000. I also tested with the Microsoft Surface Precision mouse [0],
> and like the Surface Mobile mouse it didn't seem to report the HID
> feature (at least, it was only reporting REL_WHEEL_HI_RES changes of
> 120 in evtest).

IIRC that's the same mouse benjamin has and it does have the HID feature, it
just ends up reporting the same number of clicks anyway so there's no
visible effect. Which in itself is a good sign for the patch series, I
guess ;)

> For the series:
> Acked-by: Harry Cutts <hcutts@chromium.org>
> Verified-by: Harry Cutts <hcutts@chromium.org>

thanks, much appreciated.

Cheers,
   Peter

> Harry Cutts
> Chrome OS Touch/Input team
> 
> [0]: https://microsoft.com/en-us/p/surface-precision-mouse/8qc5p0d8ddjt
