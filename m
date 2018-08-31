Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD2220837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=logitech-com.20150623.gappssmtp.com header.i=@logitech-com.20150623.gappssmtp.com header.b="pLg1Dq7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD2220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=logitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeHaNVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:21:24 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:42829 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeHaNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:21:24 -0400
Received: by mail-yb1-f172.google.com with SMTP id z12-v6so622639ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=logitech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJrgb3xk1VRcA5niIOkHAQ/4GLGlxEQ409cvwYh98l8=;
        b=pLg1Dq7BAVfNzoWvqTfsszxu7tQR4ExBytraVdWlV8VkNXqJKuqKWCEXGUEBAaw3sK
         5CeTgqoS64kM/ca2MoRyNgTDjRBIU3eBWFeaHohFPtJAtTgVODzbvGPjTv9ywtmvr/BG
         q/ZxyBcfF/PB/JHp5mXsdOsDkYAS96pwO/3A1YLRZ/QwWnXX/FLEy/BzbWso0os46KDr
         rRjpn5uu6I7O7DaRl2oLOgawTOwlpvTT3gYTtuH7YzpZSb6y1AAlmGS9tFdcpUG5e9c/
         Oq/0FzOS0cHqv/VJANJHmEs27gw5lHxCbi0dGaN+nl9ZX1BoReLQEcyjwPSStXB3YlBi
         B6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJrgb3xk1VRcA5niIOkHAQ/4GLGlxEQ409cvwYh98l8=;
        b=uYmO8Q17qHcVpZ7O0K224bUhtjYzJIyawygq1B62gzR1WZG/UjCobqHm66inhuYO9H
         eEOMjkcRS+H8aMTBNvY5uv+EwB2Njr51hGYExY0tLUZhIlZ0I2I7qMrOw04FjVkyh+WO
         ry4d9JKGRBrl11kG7Y53Sz81Oqutcu7S9jcjVdOYbyMA2RI4qFiyiTCCVdv3ZQHtc7wU
         Ae+g55gdmufx+t1KzfnTGo8u5M5hbQQy326TcqkLtUBXvXYZVxiLmbHfPlm0jZSfmQ0V
         lD9GL2kb8nI1V6wyXWwuNTbFppYeU0+ykymaWYTj7UvvhlvZeTePIEzy+v/7zKZtP+i1
         eAkw==
X-Gm-Message-State: APzg51Can9Xef7UtMPu9QdOXwYFpG7wQZ5h7lVL9kSpZdY+KTD+u/PmA
        U4Wr49+N29ev14fl4sz+CzLSlkkSg1R49Y4WbSRgiw==
X-Google-Smtp-Source: ANB0VdZYdiQm/rng1p9NDuSr9Hn6ARXWvFmo4sobc6qLc5yk25Ok6jitFMauXc/CwNxqQB7kfAIE8PTZWA7BYxtzimo=
X-Received: by 2002:a25:3354:: with SMTP id z81-v6mr7960257ybz.212.1535706891069;
 Fri, 31 Aug 2018 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-4-hcutts@chromium.org>
 <CAO-hwJ+rR8ft96AGjoEApr1ZkythKfcxjVzdULzgpRy-aRv_vg@mail.gmail.com>
 <CA+jURcvguwXAVnpQ9+84QQOaJG74oeV8U4zzM1X0UabaY5DJBQ@mail.gmail.com>
 <CAO-hwJ+tb6XdEM76r0jxBfCx2r_PqQp9T5=A2ALociyHOKUeMg@mail.gmail.com>
 <CA+jURcsDJbL_3aF7wE0MQ_6ZSVV3Aba-tUDX-f=1+y+LBhqmng@mail.gmail.com> <CAE7qMrrBdZSg1P+JTr9SA5a1ui-zdAmsg6pE-B1N5La_1WwvHw@mail.gmail.com>
In-Reply-To: <CAE7qMrrBdZSg1P+JTr9SA5a1ui-zdAmsg6pE-B1N5La_1WwvHw@mail.gmail.com>
From:   Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Fri, 31 Aug 2018 11:14:26 +0200
Message-ID: <CAE7qMrqoioqPSMem3rLs1OEZPFNLzen7TcCWeANC6svvHwbxeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Enable high-resolution scrolling on Logitech mice
To:     hcutts@chromium.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:11 AM Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
>
>
>
> On Thu, Aug 30, 2018 at 10:38 PM Harry Cutts <hcutts@chromium.org> wrote:
>>
>> Hi Benjamin,
>>
>> On Thu, 30 Aug 2018 at 00:18, Benjamin Tissoires
>> <benjamin.tissoires@redhat.com> wrote:
>> >> On Thu, Aug 30, 2018 at 1:06 AM Harry Cutts <hcutts@chromium.org> wrote:
>> > > > The conversion input_report_rel(... REL_WHEEL,...) to
>> > > > hid_scroll_counter_handle_scroll() should be dealt in a separate
>> > > > patch.
>> > >
>> > > OK, I'll do that in v2, but might I ask why? I don't see how this
>> > > particular hunk is special.
>> >
>> > I tend to consider that existing code rewrite need to be in their
>> > special commit, especially if the change isn't supposed to change the
>> > behaviour. This is my personal taste in case something goes wrong and
>> > (in this case) a m560 suddenly starts complaining about an issue with
>> > this mouse.
>> > I wouldn't mind too much if you rather keep the
>> > hid_scroll_counter_handle_scroll() introduction to this commit though.
>>
>> Yes, I see the reasoning for that, but this hunk is pretty tied to the
>> main change in that scrolling on the M560 would be 8x too fast without
>> it. I'll keep it in the same one, if you don't mind.
>>
>> > > [snip]
>> > > Yes, it seems to work fine without it (at least for the MX Master 2S).
>> > > Unfortunately, while testing this I encountered a bug with high-res
>> > > scrolling over Bluetooth. (It seems that if you turn off the MX Master
>> > > 2S while it's connected over Bluetooth, we don't detect that and
>> > > remove the input device, meaning that when it reconnects the driver
>> > > thinks it's in high-res mode but the mouse is in low-res.) I'm
>> > > investigating, but in the meantime I'll remove the Bluetooth support
>> > > from v2 and add it back in later.
>> >
>> > As far as I can see, the MX Master 2S is connected over BLE. Bluez
>> > keeps the uhid node opened (and thus the existing bluetooth HID
>> > device) to be able to reconnect faster.
>> > I would suppose you should get notified in the connect event of a
>> > reconnection, but it doesn't seem to be the case.
>> >
>> > Nestor, is there any event emitted by the mouse when it gets
>> > reconnected over BLE or is that a bluez issue?
>>
>> Ah, interesting. The MX Master 2S is indeed using BLE, and testing
>> with another Logitech BLE mouse (the M585) also leaves the input
>> device around. I think this is something Logitech-specific, though, as
>> the Microsoft Surface Precision mouse (also BLE) does have its input
>> device removed when it turns off. I notice that btmon does show
>> "device disconnected" and "device connected" events when I turn the
>> M585 on and off; maybe we need to plumb those through to the driver.
>> We've decided to delay Bluetooth support for high-res scrolling until
>> the Chrome OS Bluetooth stack is more stable.

-----Ooops, no html now...
This might be related to how the device disconnects from the host.
Sometimes a disconnection comes from the device not responding anymore
and it is the BT supervision timeout that kicks in (host side). In
some cases (hw support required on the device side) a device will send
a disconnect request when switched off. Maybe these different
disconnect flavors are the root cause behind the input device being
removed or not.
--nestor
>>
>> Harry Cutts
>> Chrome OS Touch/Input team
