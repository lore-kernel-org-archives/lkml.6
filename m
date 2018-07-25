Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC3220844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC3220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeGYNd3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:33:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:59223 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeGYNd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:33:29 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C3E589F6A7;
        Wed, 25 Jul 2018 12:21:48 +0000 (UTC)
Date:   Wed, 25 Jul 2018 20:20:36 +0800
In-Reply-To: <20180725121947.ox4zykod6jjadvfw@flea>
References: <20180724011551.49603-1-icenowy@aosc.io> <20180724011551.49603-4-icenowy@aosc.io> <CAGb2v67zR-Q9n7L6CaFKDUJFHFEC_h8-RYxkdyeyJb_GbNmkJw@mail.gmail.com> <CEA43CB7-1DA6-4983-BF18-82C4A48FB92B@aosc.io> <CAGb2v64Qae4O430kP30DQNhp0Dt774OHt0nMe35ckp8X=CTFLg@mail.gmail.com> <AC678B03-19B7-4110-B333-72188CE71296@aosc.io> <CAGb2v656oPmAX=_y88b05xqrona3HFtU-VmNQhHxK_n-4gD+aw@mail.gmail.com> <20180724144151.myyg7slocsfjjsfi@flea> <198DB486-4789-4777-9596-2BD6FAFFB741@aosc.io> <20180725121947.ox4zykod6jjadvfw@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: h6: add Wi-Fi support for Pine H64 model A/B
To:     maxime.ripard@bootlin.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <5562781F-ADDF-4289-9B74-1E445FDE04F0@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月25日 GMT+08:00 下午8:19:47, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Tue, Jul 24, 2018 at 10:42:32PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> 于 2018年7月24日 GMT+08:00 下午10:41:51, Maxime Ripard
><maxime.ripard@bootlin.com> 写到:
>> >On Tue, Jul 24, 2018 at 10:37:51AM +0800, Chen-Yu Tsai wrote:
>> >> On Tue, Jul 24, 2018 at 10:28 AM, Icenowy Zheng <icenowy@aosc.io>
>> >wrote:
>> >> >
>> >> >
>> >> > 于 2018年7月24日 GMT+08:00 上午10:26:02, Chen-Yu Tsai <wens@csie.org>
>写到:
>> >> >>On Tue, Jul 24, 2018 at 10:23 AM, Icenowy Zheng
><icenowy@aosc.io>
>> >> >>wrote:
>> >> >>>
>> >> >>>
>> >> >>> 于 2018年7月24日 GMT+08:00 上午10:21:59, Chen-Yu Tsai
><wens@csie.org>
>> >写到:
>> >> >>>>On Tue, Jul 24, 2018 at 9:15 AM, Icenowy Zheng
><icenowy@aosc.io>
>> >> >>wrote:
>> >> >>>>> The Pine H64 model A has a Wi-Fi module connector and the
>model
>> >B
>> >> >>has
>> >> >>>>an
>> >> >>>>> on-board RTL8723BS Wi-Fi module.
>> >> >>>>>
>> >> >>>>> Add support for them. For model A, as it's not defaultly
>> >present,
>> >> >>>>keep
>> >> >>>>> it disabled now.
>> >> >>>>
>> >> >>>>Nope. Pine64 actually has two WiFi/BT modules. And they
>require
>> >> >>>>different
>> >> >>>>device tree snippets for both the WiFi and BT side. This is
>> >better
>> >> >>>>resolved
>> >> >>>>with device tree overlays.
>> >> >>>>
>> >> >>>>I have both, though I've yet found time to work on them.
>> >> >>>
>> >> >>> I have also both.
>> >> >>>
>> >> >>> The skeleton here can get the Wi-Fi of both to work.
>> >> >>
>> >> >>Cool. Then I can put away my RTL module for now. :)
>> >> >
>> >> > P.S. SDIO is auto detectable, and for BCM chips, the OOB
>interrupt
>> >> > is only a bonus function and it can fall back to standard
>in-band
>> >> > interrupt (which doesn't need special binding, and is currently
>> >> > used by mainline r8723bs driver.)
>> >> 
>> >> Correct. With BT you'll have serdev device nodes with different
>> >> compatibles. Then you'll have to resort to overlays, and you'd
>> >probably
>> >> end up adding WiFi OOB interrupt bits as well.
>> >> 
>> >> So the question remaining is: should we enable the MMC part, along
>> >> with power sequencing and regulator supplies, by default? Thinking
>> >> more about it, I'm actually OK with it. The board connectors are
>> >> clearly marked as being for a WiFi+BT module. The whole space on
>> >> the board is surrounded by a box in silkscreen. Sorry for the
>> >> initial nack.
>> >> 
>> >> Maxime, any thoughts?
>> >
>> >If there's a need for an overlay anyway, there's no real reason to
>> >enable it by default, especially if not everything is there.
>> 
>> Everything is there, for model B support.
>
>Except BT?

Yes, not checked BT yet.

>
>Maxime
