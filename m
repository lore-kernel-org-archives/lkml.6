Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA993C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526D32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgim0BdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526D32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeIKTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:34:05 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39885 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:34:04 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so3723223iok.6;
        Tue, 11 Sep 2018 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kRI0bGnXFrJnydiZGXfMepAyhXINLy2lIXbQ2mJCcU=;
        b=Vgim0BdM0yaWxWtcEAZqLdyiH8JYuY+2MsqwM6bFBnyL94PDoxkRZd+uXDXaEFwcFC
         M+QLFsmeJYc8C9Q3XAQCohZeT+q+x//Di6rOKPa+rF+KidXe4MQp8fNy+tI6UL0YEKYg
         hQQH/XDGHL917orkIt5YnfMW7hpOaUMWVuqwbeWtMN3xg4vjMP1Y+bwMn1mTDH2I0+qA
         XCcyDhpCbpA68L1Yb0CKol1pnqpbS//I3HqjkGDUbqHk9yNIFiCWybpx6LYdIb/Jutnk
         zyVSz4JczM7F42Y6jh/yaMi6Iztlq4qlUCW/G2t7ycuF6oGbred/U2DpF0KzVsiNnWvG
         +rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kRI0bGnXFrJnydiZGXfMepAyhXINLy2lIXbQ2mJCcU=;
        b=OykGiRyCBTvB7cVA4Co706Z4JpiL+37+Pk0q0aJG//rOaavD4sLnQxmo+x7JBzMj5r
         7Gt47pefVzzm2ByWnmnQRIK19OCO4igh45+LrVjE7QqokSXcNocq+hxoO/FICr39sXdZ
         kmpjOBo7XnewfLVwGAW6UAfxVRMJwG4zu/Yi0ayCC5irAac4iON7Z98WT52dCulaceiF
         j+ZxwhmcdMS7S7kZ7cgSYK2s3kFTerxcZ4ELhCV9wgFckOFYaf+Mk6XzWNGfL4+rhxdH
         Sa6rULadTIji39memHkOPdEPQRtC5LrYbFxUWRBqMhBltz59tbSIh2PR0gOjaI658hag
         QyAw==
X-Gm-Message-State: APzg51DJXrFz9KgQGTeH9c7Ajwq2TdacgtXt+ZMPDfDuPrDCmovqUrSd
        VFp6jd794LXt1s5ZkIErzTdrH6yCjlEzHvdc4Ts=
X-Google-Smtp-Source: ANB0VdYzmFfxYVun5IHZ2jFkhHP/1WKRLGdQdrSF44XcH8JStMixzAj16lr0NJOhRQtu9gEBQDa38oDtQEHkFmlhVU8=
X-Received: by 2002:a6b:d819:: with SMTP id y25-v6mr22553982iob.247.1536676469513;
 Tue, 11 Sep 2018 07:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost> <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
In-Reply-To: <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Tue, 11 Sep 2018 16:34:18 +0200
Message-ID: <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Lars Melin <larsm17@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:00 PM Lars Melin <larsm17@gmail.com> wrote:
> This also becomes a mess for the qmi-wwan driver which has the rmnet/qmi
> interface hardcoded to 4 so that driver will also need a workaround.
> Quectel seems to have completely missed the reason why usb id's should
> be unique and not reused  for a different product or a different
> interface layout, there is already a workaround in qmi-wwan for their
> previous EC-20 card...

A patch has already been submitted to work around the issue in qmi driver.

> My opinion is that the option and qmi-wwan drivers should support EP06
> in the factory delivery configuration and not in a configuration the
> user has selected with a Quectel proprietary AT cmd.
> Can you give some good reason for disabling an interface instead of
> letting it stay but not use it if you don't need it?

Yes. I am working with two boards, one based on MT7621 and the other
on MT7623, and I would like to connect two EP06-modems to these
boards. However, the USB-controller used on these SoCs has a (very)
limited number of USB endpoints. With the default configuration, there
are only enough endpoints for one EP06-modem to work properly. By
disabling diag, there are enough endpoints for both modems to work
correctly.

BR,
Kristian
