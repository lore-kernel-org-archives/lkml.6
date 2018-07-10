Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEFFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A4820846
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A4820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeGJISN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:18:13 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:57680 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbeGJISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:18:10 -0400
Received: from [IPv6:2001:983:e9a7:1:e904:375f:eccf:b43d] ([IPv6:2001:983:e9a7:1:e904:375f:eccf:b43d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id cnqNfpYMzoj71cnqOfckrU; Tue, 10 Jul 2018 10:18:09 +0200
Subject: Re: [PATCH v5 02/22] fixup! v4l2-ctrls: add
 v4l2_ctrl_request_hdl_find/put/ctrl_find functions
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, marco.franchi@nxp.com,
        icenowy@aosc.io, keiichiw@chromium.org,
        Jonathan Corbet <corbet@lwn.net>, smitha.t@samsung.com,
        tom.saeger@oracle.com, Andrzej Hajda <a.hajda@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        jacob-chen@iotwrt.com, Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>, acourbot@chromium.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        posciak@chromium.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, samitolvanen@google.com,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        hugues.fruchet@st.com, ayaka@soulik.info
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-3-paul.kocialkowski@bootlin.com>
 <CAMuHMdVgJuK5G0+szV0BAWDBybxWV0iDWE5kZKuTdgNiGjpnEg@mail.gmail.com>
 <5adf8a6aa70fd6f7f4326ccb068b66d6221d8d8b.camel@bootlin.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <eb5fb671-4589-e0cf-5385-84a5cc912905@xs4all.nl>
Date:   Tue, 10 Jul 2018 10:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5adf8a6aa70fd6f7f4326ccb068b66d6221d8d8b.camel@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: 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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 10:13, Paul Kocialkowski wrote:
> Hi,
> 
> On Tue, 2018-07-10 at 10:07 +0200, Geert Uytterhoeven wrote:
>> On Tue, Jul 10, 2018 at 10:02 AM Paul Kocialkowski
>> <paul.kocialkowski@bootlin.com> wrote:
>>> [PATCH v5 02/22] fixup! v4l2-ctrls: add v4l2_ctrl_request_hdl_find/put/ctrl_find functions
>>
>> git rebase -i ;-)
> 
> Although I should have mentionned it (and did not), this is totally
> intentional! The first patch (from Hans Verkuil) requires said fixup to
> work properly. I didn't want to squash that change into the commit to
> make the diff obvious.

Just squash the two for the next version you post.

> Ultimately, this framework patch is not really part of the series but is
> one of its underlying requirements, that should be merged separately (as
> part of the requests API series).

There is a good chance that this patch will go in via your series anyway
since it is not needed by vivid or vim2m.

Regards,

	Hans

> 
> I hope this clears up some of the confusion about this patch :)
> 
> Cheers!
> 
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>

