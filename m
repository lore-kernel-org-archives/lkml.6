Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4088C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDF6208A1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ0tOH58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDF6208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeGEVLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:11:06 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:38426 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbeGEVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:11:05 -0400
Received: by mail-qt0-f179.google.com with SMTP id c5-v6so8342987qth.5;
        Thu, 05 Jul 2018 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbqjEQm2x3ROL/K9n06rasvaQx/Htz4QrmxAT04D5vc=;
        b=cJ0tOH58w3/JKDnSYZcjeMOhBQdvRkVRj1wJAVWj+hd3Hn4EFfUmFum8jn4EoSKTWZ
         sARMifSrS3JJmSrlcSUnGI/ayj/eBc4Y7JB0Mx0DnyuvtkdqdKavZFLg22d1e/ZD0Fki
         cozFOnmm06pRrckf4x4oH+djfPDtpLu/IehrIjPgyRp95279QoI1mUecj2oGTyrhFBHG
         UVDus5QuajYXNy6lIuWVPus5gXajbK62EkDMmcNL60bLzudr5crPR3TpG984LQpX8mNn
         XhJR9qEN8H2SUg9cVT0sUb92LzSEij3sqIIYBehp87WcdgeA+Z1OwG1GF2LCn9nErbO9
         SVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbqjEQm2x3ROL/K9n06rasvaQx/Htz4QrmxAT04D5vc=;
        b=VtcZBHysgwh1bYSHkMShVW7QP6torKf4MAqXIKuwyuCnNlUbN9GZJ4fXYNYBn+2oFY
         HIdCCsnLh/yXmijNeVcxjRCQO9s8sf18cq5IzJG1DWhajcJXE4W+1Puo54PQ22UaWlfk
         m1EGajEmo2Z+Tvpb6U4sWpFgQcZ9/MnGDRvx46M5rkuTz/lkQBGTaS0Q2mCwtYiG0Kq1
         EU3x4M9ZblRl0cJG0YuKgVsrO1wUzOQupuvMODeIPZiNpTFDbxrary1P2zAgKVtV1/+f
         u6FWfHY1am2si1CKHYSwx1JWXGH6uVh6/bIuM5f0W8bXo+NVd7j/GhogprXOqxdFPJII
         LtfQ==
X-Gm-Message-State: APt69E2nc7Dj7euhVNPeY1sSlJrt1yXkEysEl2BBdORoSiELwbaTWdtv
        NeVv+KBhP1wTLSOH0UwFLqRcE3nrLIZJy0/87XY=
X-Google-Smtp-Source: AAOMgpc1G0DeGGlUcK7xE/ZEaGQRIfrdPTa6kQYf/cijVsqBXHot6HRglDNgnpH9Hn3OhtvyCNALPAikpJnogc2hcJs=
X-Received: by 2002:a0c:ad29:: with SMTP id u38-v6mr6673633qvc.12.1530825064352;
 Thu, 05 Jul 2018 14:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180628054205.17737-1-luaraneda@gmail.com> <20180628054205.17737-3-luaraneda@gmail.com>
 <20180703230410.GA31330@rob-hp-laptop>
In-Reply-To: <20180703230410.GA31330@rob-hp-laptop>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Thu, 5 Jul 2018 17:10:48 -0400
Message-ID: <CAHbBuxrTSL0B-dC=gh_EOYAvk41mYJq6XsHEnWJi453Fq9Lu3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
To:     robh@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for reviewing.

On Tue, Jul 3, 2018 at 7:04 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 28, 2018 at 01:42:02AM -0400, Luis Araneda wrote:
> > +- Adapteva Parallella board
> > +  "adapteva,parallella"
>
> This is documented in adapteva.txt, but I'd prefer if you put it
> here and remove adapteva.txt.

Ouch, I should have used git grep to find that.
I'll remove the adapteva.txt file on v2, which I'll be sending later today.

Thanks,

Luis Araneda.
