Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4fF3DtdhHluDSAAAmS7hNA
	; Mon, 11 Jun 2018 11:49:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3D33460791; Mon, 11 Jun 2018 11:49:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dy9DhUMZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B9A79601C3;
	Mon, 11 Jun 2018 11:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9A79601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbeFKLtv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:49:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55230 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeFKLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:49:49 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so9947901itx.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Evugzbf/39Mp+0nAJkQydOBUYb1fU6syGu+lM3R963U=;
        b=Dy9DhUMZrHvpXNxtOC/UdAuIzNIUQrJfwHQlCbFlnG//UFNqRf3fcNClVe0u+8HFqZ
         xvMDGHLC/My/SCtmXskHvdg784j32HmkC/F9lGT30xdQ3DX01C2A4KVnqUumqo1mRdYh
         tG2+tpTOXOoy51Hpypqswc35NEPiDE3+uKYlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Evugzbf/39Mp+0nAJkQydOBUYb1fU6syGu+lM3R963U=;
        b=d0t9FpJkY/R24APGrUngrSik9mWQZELQ6cvXk1deylkXW3OilJ68YIj+M6jCWKi6M3
         ycM5abChXqYNoO6DcI2JbVddhBYTOsLeqE6RV+XQDAKsKLTS7MZgj8ZNXqAvLU9auC1A
         6wvmKmj/jah7Syywb1e1MT/M51N2JBGAZ9CBvWccE7ZWadwM0S+5cMm6hH4mF6l+5qSp
         whHQ8PQ45LPf2EOZYiFOgGD3b+hQk3u7LeQTKuLULh/sXnP25+9hEya+dnpn4Poo85HH
         BXc9VBrQabcmhMr/iIERzjjTu30qy0jjNDJ3dQiAJP7yPldbbxyUa96ug95vupsK6KBQ
         GE5Q==
X-Gm-Message-State: APt69E3fj7jdQuPEcVm3hA5fgo+FCcIDKXWeRX2mRgX1lTEQGa6hXi3s
        uWvB4pgw4AjRYSbytCuVyu9CQ7BrIx7Xg6c8GKwtKg==
X-Google-Smtp-Source: ADUXVKIFSoBFFPP0Ex929oLGTTKg4pP2Lh0ecqfJpaPtXgJnQNN3Uqp3r1TDpvi8Yw+iC8REqTrbq0AXBTsjps5LbwU=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr10270782itb.135.1528717789074;
 Mon, 11 Jun 2018 04:49:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 04:49:47
 -0700 (PDT)
In-Reply-To: <20180604104642.GC7536@sirena.org.uk>
References: <20180530150711.2c7c1fe9@canb.auug.org.au> <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
 <2564792.sYBGPVz9u3@z50> <20180604104642.GC7536@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Jun 2018 13:49:47 +0200
Message-ID: <CACRpkdaUQkjM3nFWn2aO-Jxy=tWEKWkEUmCA11Xuji2p2x82gg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the regulator tree with the arm-soc tree
To: Mark Brown <broonie@kernel.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 12:46 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jun 01, 2018 at 12:49:53AM +0200, Janusz Krzysztofik wrote:
>
>> I confirm the fix by Stephen works for me, however, the conflicting patch by
>> Linus breaks things a bit.
>
>> Lookup tables added to board files use function name "enable" while the
>> regulator uses NULL. As a result, GPIO descriptor is not matched and not
>> assigned to the regulator which ends up running with no control over GPIO pin.
>
>> Either the regulator driver should use the function name "enable" or that name
>> should be removed from lookup tables.
>
> I'll revert this one as well :(

I see this is a generic problem, no idea why I didn't pass these
unnamed as NULL in the first place, probably my ignorance as usual.

I fixed it up in my patch making them all anonymous and rebasing
the rest as well. Let's see how it looks after the merge window.

I will also need to rebase on top of Janusz changes and then it
will look even better.

Janusz: would be super if you could test my patches after that!

Yours,
Linus Walleij
