Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeCTRKD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:10:03 -0400
Received: from foss.arm.com ([217.140.101.70]:43360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeCTRKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:10:01 -0400
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Harald Geyer <harald@ccbib.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        info@olimex.com
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
 <E1exwhF-0000Qw-4g@stardust.g4.wien.funkfeuer.at>
 <20180320141353.zmzq4e5652rsp4ye@flea>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <0288a32a-bbbf-20ca-2ebf-6fc8e82168df@arm.com>
Date: Tue, 20 Mar 2018 17:09:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320141353.zmzq4e5652rsp4ye@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/03/18 14:13, Maxime Ripard wrote:
> On Mon, Mar 19, 2018 at 04:27:36PM +0100, Harald Geyer wrote:
>>> together with all the patches but the
>>> PWM (so I had to drop the backlight node as well).
>>>
>>> Please coordinate with Andre about who should send the PWM support.
>>
>> Seems the patch got broken because only the backlight node but not the
>> pwm node was removed. Anyway, since Andre has already sent an updated
>> version of his series, maybe just revert the broken patch, merge his
>> series and then apply the original teres-i patch again?
> 
> Unfortunately, there's dependencies on the PWM driver itself, and the
> maintainer hasn't replied yet.

But those dependencies are purely "administrative", not technical,
aren't they? As the existing driver worked already with the DT changes,
it's just the listing of the compatible strings in the binding doc that
is missing? IIRC we added those later on in the past already.

So I think it's safe to merge them independently:
"[PATCH v2 1/4] pwm: sun4i: drop unused .has_rdy member" and
"[PATCH v2 2/4] pwm: sun4i: simplify controller mapping" are
PWM fixes and go via Thierry, I guess.

"[PATCH v2 3/4] dt-bindings: pwm: sunxi: add new compatible strings" is
just Documentation of existing behaviour, and independent from 1/4 and 2/4.

"[PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers" just "softly"
depends on the introduction of the compatible strings in 3/4, but has no
real technical dependency. It can go in any time on its own without
breaking the build or functionality.

Or am I too sloppy here?

Cheers,
Andre.
