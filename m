Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeCMI7F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:59:05 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52534 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCMI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:59:04 -0400
X-Google-Smtp-Source: AG47ELtlu8fy8c1kPIGw7iIBgMqWramKrB/A7RItgmScZFqjTVCEUSSa528m8JZVKjrOLfmUksOXcsDKHkdkh2OPMag=
MIME-Version: 1.0
In-Reply-To: <20180313082337.zekrzyx5utx5lkj6@flea>
References: <20180312155753.9478-1-codekipper@gmail.com> <20180312155753.9478-5-codekipper@gmail.com>
 <20180313080026.jtag4w46koxzeqe2@flea> <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
 <20180313082337.zekrzyx5utx5lkj6@flea>
From: Code Kipper <codekipper@gmail.com>
Date: Tue, 13 Mar 2018 09:59:03 +0100
Message-ID: <CAEKpxBn6Zxy5nuMPYkPU_UweCqBm+P4M2fd2UqepdojBiOErbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 09:23, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Mar 13, 2018 at 09:15:49AM +0100, Code Kipper wrote:
>> On 13 March 2018 at 09:00, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> > On Mon, Mar 12, 2018 at 04:57:51PM +0100, codekipper@gmail.com wrote:
>> >> From: Marcus Cooper <codekipper@gmail.com>
>> >>
>> >> The i2s block supports multi-lane i2s output however this functionality
>> >> is only possible in earlier SoCs where the pins are exposed and for
>> >> the i2s block used for HDMI audio on the later SoCs.
>> >>
>> >> To enable this functionality, an optional property has been added to
>> >> the bindings.
>> >>
>> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> >> ---
>> >>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
>> >>  sound/soc/sunxi/sun4i-i2s.c                        | 48 +++++++++++++++++-----
>> >>  2 files changed, 41 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> >> index 48addef65b8f..3f966ac61b9e 100644
>> >> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> >> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> >> @@ -33,6 +33,9 @@ Optional properties:
>> >>                               configured to extend the slot width to the
>> >>                               value specified. Min 8, Max 32.
>> >>
>> >> +- allwinner,playback-channels:  if this property is present then the number
>> >> +                             of available channels is extended and the
>> >> +                             outputs enabled.
>> >
>> > Isn't it something that is fixed for each generation of SoCs? Can't we
>> > attach it to the compatible?
>>
>> I'm not sure as the documentation is pretty poor. It looks like it is
>> supported by all of the variations that we've seen but only exposed as
>> pins on A10 and A20. I'm also not sure who would ever use it with
>> external devices.
>
> Well, you were saying that it was the case on the older SoCs in your
> commit log, so this needs to be figured out.
>
>> The reason why I've added it is that it is required by HDMI for
>> supporting surround sound on the newer SoCs.
>
> Why isn't that mentionned in your commit log?
>
> Can you post the whole set of changes needed for HDMI audio? this
> would make things much easier to see where you're going.

Maybe we should drop this change for now as basic HDMI audio for two
channels doesn't require it. I've also not tested multi-channel audio
yet.

To get HDMI audio working the following patches are required for the dts
https://github.com/codekipper/linux-sunxi/commit/997c622ae10ef136bae0a35a0e9bf9c6dd27910a
and
https://github.com/codekipper/linux-sunxi/commit/4a81676d30a0262c57ffc0827e46c7934fb3b358

they don't need this patch but do need the slot-width-override patch.

CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
