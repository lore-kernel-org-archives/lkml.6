Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD32ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGfqaB8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAD720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbeGXPiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:38:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35833 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGXPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:38:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id f18-v6so3130084lfc.2;
        Tue, 24 Jul 2018 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IX3EIXTOg1YjYxQIJz0paiP6UsBpwT3HCEp8+oVBEEs=;
        b=IGfqaB8nsYvPqE6TNTsj9gwl2/Y9VkIWPkljUTuZXiJ1Wna1dG8A/5KjxQ299wJHiK
         /+WvNlUCpMhGWl7TpOmy0ovJBExU+bCiPLZPGD4RrGXbRlw2vMUzO47/UG5RqEZZyypQ
         LtwjedkGqMScP9GptRPip9zo41eB8fZMoWW7PAdKXtz477unmuL6IMIUuTVd4mqNv9wS
         iBgcB8V86nDCcQG4lqR77GLYd5/phIX71g6Il/vwYHtFDQgfpiekP6qlLeuLvziGsgve
         gGJNjXehdOvSmdWBD7ee5EwphKtYZW6nVj1NOAaPhZe8xpbBQCfgCrTuJjRS7xaJ6e9v
         1jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IX3EIXTOg1YjYxQIJz0paiP6UsBpwT3HCEp8+oVBEEs=;
        b=uU5egLyhreobqSNrzK90AzpGd+UPq9LBIh2gHznHHvBe3nOW0XBdVKxbX1q4hg+hDC
         Mx0aPjNRAgNKoRXRfYiHrgSPumUkYWM8bf3pjb1E+15pUja6yJQX/EUayXWdFhwgMiYp
         XKLYdvN1sNLJ/7Ff7IhBnHM/Et8+gAlyETNpnr82meOdnasqgMgROuaTqzLdTLWukVE0
         z4H1MZ8x7R9uQ8VojcIfaG7n/K2kBH05snYoLc8tBWEDPRdGvzqpsLwGKDmmCAw8qaCM
         zCy/NWRQRgu1YinkFv6UaA5fzNXc2lindqzQSEJKJeCT0cY/aJZNoHsrHOWxGUqiEuW2
         /k4Q==
X-Gm-Message-State: AOUpUlGbo76urSPUUBQkZNIyVBv0czaZBsoKGWTNvBXPGPbI6AyPmmAg
        IINYYIFnniTLLhn2D8kcbM8=
X-Google-Smtp-Source: AAOMgpcdnUn4FY4+TlOwjm8WnkyJag4Zi9vIoBou0vwqPOO1F/L+V4nW1vrVGSlrOMn8neotDqkuSA==
X-Received: by 2002:a19:6511:: with SMTP id z17-v6mr10073133lfb.56.1532442694223;
        Tue, 24 Jul 2018 07:31:34 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m71-v6sm2297117lje.84.2018.07.24.07.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 07:31:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Date:   Tue, 24 Jul 2018 17:31:32 +0300
Message-ID: <2076484.gx54F3eiOq@dimapc>
In-Reply-To: <1532441791.6124.20.camel@toradex.com>
References: <20180724104309.21741-1-marcel@ziswiler.com> <2532956.xKQ6NZiSWF@dimapc> <1532441791.6124.20.camel@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 July 2018 17:16:33 MSK Marcel Ziswiler wrote:
> On Tue, 2018-07-24 at 15:44 +0300, Dmitry Osipenko wrote:
> 
> > On Tuesday, 24 July 2018 15:24:34 MSK Marcel Ziswiler wrote:
> > 
> > > Sorry, I meant to write "minor revamp" in the subject line here as
> > > Apalis TK1 was already in quite good a shape but this are still
> > > some
> > > worthy improvements (;-p).
> > > 
> > > On Tue, 2018-07-24 at 12:42 +0200, Marcel Ziswiler wrote:
> > > 
> > 
> > 
> > Marcel,
> > 
> > All your emails that are sent from "toradex.com" are treated as spam
> > by Gmail 
> > because "This message has a from address in toradex.com but has
> > failed 
> > toradex.com's required tests for authentication.", is there anything
> > you could 
> > do to fix that?
> 
> 
> Hi Dmitry
> 
> Hm, unfortunately, Toradex was an M$ only shop when I joined more then
> 7 years ago and so far I was unable to convince our IT to switch to
> some grown up email system. Therefore, I am stuck with Exchange, Office
> 365 or whatever M$ nowadays seem to call it. Anyway, I really thought
> sending from Android or Evolution via their resp. Exchange connectors
> would properly do SPF, DKIM and even DMARC. I just confirmed this when
> sending something to my gmail address and doing "Show original".
> 
> Since Linus himself pointed out any of my patches ending up in his spam
> folder I do send them via my private email which while not having any
> advanced security configured should still be valid. Moving it to a
> fully secure configuration including DNSSEC and stuff is still pending
> on my side.
> 
> Can you please tell me which exact email it is that you got this
> reported on so I may further investigate what is going on?

This email from you looks okay. Unfortunately all of your previous emails from 
"toradex.com" were getting into the spam folder.



