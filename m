Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA38C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962F62064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962F62064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeKAQWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:22:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37749 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeKAQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:22:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id u12-v6so12883479eds.4;
        Thu, 01 Nov 2018 00:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fdqRzbwke00BonYH2Nxx/t6IlNpiBlqeqFO7hfpKKc=;
        b=obz4jYGuQwiDgGIZfsDGjOVT6Z6zGcmLokv3Q4wQSOHaDWz2p3KFfWjK6zvKTqPiE2
         gQUZzFr0/YerNFur4Eig8kp5MgMjd/SIoIpWm5rLdiAdmrwgNpeQZruzGhgb31fNtkkJ
         aVE407/3rLl0fmVIoJiimfEl05vbDRDO3PhX5kVKQJOH7BFHCV0OopHhRmpcS4s2uZvS
         TKQPdMQaSxCwyO9vDGkonR9MbLch8WixLavk/5DbcLNFjk9XhrhY24jJYKos7R/32JeN
         jeQcPTiL/d9Cll7UkQ9IV0dqJTJ1rTw6bXBTMaIXfYoAfkDtKyTb7Cx/ekVUftU5ScLw
         wC0w==
X-Gm-Message-State: AGRZ1gLw3saBQrnSAkOg0Vv2M43kPyLDB/TQ7Hjb8HVzXFp4/X88ediq
        yFKoHDEpxNG6MBaqfea6KwGbNaiWV4c=
X-Google-Smtp-Source: AJdET5dXbxg7v2BNaGJ28RyJzruozSTCwWLP1EX5O4rsIpu05gu1N2U+VONkcLvNtcWctMqloBiV8Q==
X-Received: by 2002:a50:a125:: with SMTP id 34-v6mr4231935edj.63.1541056847528;
        Thu, 01 Nov 2018 00:20:47 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id d24-v6sm2504686ejd.77.2018.11.01.00.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 00:20:46 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n5-v6so19015964wrw.12;
        Thu, 01 Nov 2018 00:20:46 -0700 (PDT)
X-Received: by 2002:adf:e307:: with SMTP id b7-v6mr5901910wrj.91.1541056846100;
 Thu, 01 Nov 2018 00:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-2-jagan@amarulasolutions.com> <CAGb2v66ALW1EL5+buporX8cPjkfpNdwGJEVUrC9Xpcmt3-NX7g@mail.gmail.com>
 <CAMty3ZCv9z=uALo-PShS-RegNt2cOwOHWE=6vsRVgPm9oOQ_Fw@mail.gmail.com>
In-Reply-To: <CAMty3ZCv9z=uALo-PShS-RegNt2cOwOHWE=6vsRVgPm9oOQ_Fw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 15:20:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v66v8akRfTHMCRYUZePwg9f9DdTVrX6G9-OOu1W_Sw6tOw@mail.gmail.com>
Message-ID: <CAGb2v66v8akRfTHMCRYUZePwg9f9DdTVrX6G9-OOu1W_Sw6tOw@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: allwinner: h6: Add common orangepi nodes into dtsi
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     zhao_steven@263.net, Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:13 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 8:23 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Orangepi H6 boards, One Plus and Lite2 shares common
> > > nodes like axp805, uart, mmc0 etc and the common differences
> > > between them is Ethernet is available in One Plus where
> > > as Wifi, USB3, CSI port is available in Lite2.
> >
> > You can claim this for pretty much all Allwinner boards, because they mostly
> > derive from the reference designs Allwinner's design houses put out. Yet we
> > don't do this for all of them. We do this for boards that are clearly derived
> > or extended from one another. One example would be the Orange Pi PC and PC Plus.
> >
> > Do you have any evidence to suggest so? This is not about common device nodes,
> > but a common hardware design.
>
> I got this information from hardware schematics and from Steven (added
> in to list), he too claimed the same.

Good. Please add that to the commit message. The vendor's intentions are as
important as the actual facts.

ChenYu
