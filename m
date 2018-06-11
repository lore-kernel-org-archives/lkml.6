Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GSq2JZ2XHluhQAAAmS7hNA
	; Mon, 11 Jun 2018 15:40:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E787E607BB; Mon, 11 Jun 2018 15:40:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HWYx2rR0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5CF4360791;
	Mon, 11 Jun 2018 15:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CF4360791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeFKPkK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:40:10 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33378 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932553AbeFKPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:40:09 -0400
Received: by mail-it0-f66.google.com with SMTP id k17-v6so11622245ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKrPd9VP8Q2uvEC9dB0TY9pRDjS04HSPd4ldV3lCsfo=;
        b=HWYx2rR0QoNhMrRlmwRqGgOu5YFbNuHtj2dJ423lmp7aSCKgyT6F00KfXjEZ47lv66
         jqMF8EzxmfVE3dzZl/xv0pw2LHyYrf4DWNj/c050vb0pn8PgKtA7jebp45PkiXvp9Dl3
         oBA4xuoicHcv56925PwOrESwez97Dnvwju7CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKrPd9VP8Q2uvEC9dB0TY9pRDjS04HSPd4ldV3lCsfo=;
        b=VHbVyb2LQotF2BNBf8AGSYdT9VH1gynIJWP/+ye1G+4Po/rn+fQWa8dcz7Z+bCfaJA
         NB8RdpcXEKZ9kzR5vhkXyvuYRiYlEFNl4nqiXjR+5+iGAZUe3rWpyp7YkxKhpptJvyJJ
         pCQ4Qzkr4VE+GO45QNRQr01MZA2txaPAgmrZYzyb9V5fWcqBwY5E1e4nS7QpAei4w1Oo
         62bXMZS6boVO1vK2kQydlYyBqJM2HH7jRcHfcpnKDqiK3R2H/ksX4Qn9DoMQjS22UT6x
         vpdFOhhC06nKBqCaYvODeSSsLPzgQIqmmybEOhH72xP1oFjG+1uX+lYUAdSVM3LrwiAF
         pYmg==
X-Gm-Message-State: APt69E3UZyf7OMVAxl6n567XfojLdX2t3HjrF35RhPhEBykkAp6nobBU
        iDbJicy/PV4qrSdnr51Y3XVHyEC2ZWrFcvcWh+c=
X-Google-Smtp-Source: ADUXVKJoVY5BQ+lyDyGih4yJiLR/gSa+xVGcKAZIkebM7GE1MqM3tUSUAF7ANiKa+O1aPxDh9FP8ptplxFv9oYn5cTQ=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr10611784itd.16.1528731608537;
 Mon, 11 Jun 2018 08:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <5b1a9cac.E0zqScbTCJ5WgP6x%lkp@intel.com> <CA+55aFwHCJ-ra6GOz3bFXx21D1bOjN4L11Dybr5t2OHCAYCL5Q@mail.gmail.com>
 <20180609002917.GA22101@intel.com> <20180611072648.GA8748@intel.com>
In-Reply-To: <20180611072648.GA8748@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Jun 2018 08:39:57 -0700
Message-ID: <CA+55aFxWVJjrNTK3vFh=_Yztqb1uwRr4POypacgoqqZEWLUOuA@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION 68abbe729567cef128b2c2141f2ed2567f3b8372
To: Philip Li <philip.li@intel.com>
Cc: kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:16 AM Philip Li <philip.li@intel.com> wrote:
>
> The bisect considers the errors belong to mainline tree, meanwhile, there's a
> corner case, the bot sends out this mail externally which is supposed to send
> only internally for double check.
>
> Kindly ignore this. We will continue the improvement of the bot.

Thanks for confirming. And it was no problem - I already ignored the
report as a "that must be some odd infrastructure issue" ;)

              Linus
