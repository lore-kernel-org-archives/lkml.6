Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923FBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D23C2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546886757;
	bh=DbltD7EDUyakk1DIa1MPBPvZNTLjAPFmb6PUh9hCKYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QbtKZ9V9MgBPJ/fIhPdXBdixv2GiGuzdjt02cY3Fkr9cI85551PfdBci3tOuYjfMn
	 pLFmyDO9NJx+AYl2Vi5vJdU05KL7dAbHZZcjpHAx9wK/db5sZDXiGlNhp//zVZo4if
	 90IBupkKG0T91HCgK5zeiNhhAqV1fWARfsurJABQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfAGSp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGSp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:45:56 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668142054F;
        Mon,  7 Jan 2019 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546886755;
        bh=DbltD7EDUyakk1DIa1MPBPvZNTLjAPFmb6PUh9hCKYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oI/kzU+C932Rq/LKXO666PZn5auTO/xAJ7uJpvDx9ccLTq8GbbAED2qKJa6zAXJOn
         3Iy/P5nqP8jzZC+zc18eL4tTh6TFJEqYuGODFYhX+3UrgL/hx40jXDX8tIVg5pBLmq
         tf2GAiSGdbTZKfPNu7sz1tGSCzKSPEIgevtprOSA=
Received: by mail-qk1-f172.google.com with SMTP id y16so868338qki.7;
        Mon, 07 Jan 2019 10:45:55 -0800 (PST)
X-Gm-Message-State: AJcUukdxU2+2LGsFLQT5J4lVM1lv/3pky58QsIRFH31NFf9TtaaKgWjS
        HxL+h8hlJSIpo63edCb1oUvJgIVvOlGo8ui2Mg==
X-Google-Smtp-Source: ALg8bN6I5MBWYTe4l4aJEBzx+UlwgwayiE291wXEJ7uS+UhSsUpjUuQIref5VQUsDhQ+jV7c4ptfNdZlEIEqPwTYPQs=
X-Received: by 2002:a37:a483:: with SMTP id n125mr56229474qke.184.1546886754644;
 Mon, 07 Jan 2019 10:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20190107183711.GA5671@amd>
In-Reply-To: <20190107183711.GA5671@amd>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Jan 2019 12:45:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzs4WoJoe_uCzhS3NBGfHiTQ96GkfSRhtxeah0THoVyw@mail.gmail.com>
Message-ID: <CAL_JsqKzs4WoJoe_uCzhS3NBGfHiTQ96GkfSRhtxeah0THoVyw@mail.gmail.com>
Subject: Re: Consistent capitalization of "device tree"?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     devicetree@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 12:37 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Is it "Device Tree" or "device tree"?
>
>  pavel@duo:/data/l/k/Documentation$ grep -r "Device Tree"  | wc -l
>  235
>  pavel@duo:/data/l/k/Documentation$ grep -r "device tree"  | wc -l
>  595
>
> I guess it would be nice to make it consistent. I guess "device tree"
> is preffered?

Well, the spec uses "devicetree" with capital 'D' as needed (titles
and start of sentences). I didn't check if we're 100% consistent
there.

> Should we do something like this?

I'll take patches, but it wouldn't be at the top of my list.

Rob
