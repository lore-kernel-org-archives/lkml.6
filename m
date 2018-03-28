Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC1DxZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:53:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43227 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751182AbeC1DxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:53:23 -0400
X-UUID: 0753c10f666d4b4ba9ebf99775f9d91e-20180328
Message-ID: <1522209197.18424.26.camel@mtkswgap22>
Subject: Re: [PATCH v1 02/16] dt-bindings: rtc: mediatek: add bindings for
 PMIC RTC
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 28 Mar 2018 11:53:17 +0800
In-Reply-To: <20180327151848.GD22441@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <5846e8be319c4836808c8127d5bb51b7e999e896.1521794177.git.sean.wang@mediatek.com>
         <20180323094118.GC3417@piout.net> <20180323101505.GF3417@piout.net>
         <1521920188.31197.13.camel@mtkswgap22> <20180327151848.GD22441@piout.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23746.000
X-TM-AS-Result: No-9.549000-8.000000-10
X-TMASE-MatchedRID: 1GZI+iG+MtcOwH4pD14DsPHkpkyUphL9+Vb3woyMZbuMbDv6XkOHDZQU
        UitCkYb9CpMzF3CqLHZmVMg6wIiaxpZXoz438mm1R+GtoiXVeDGGxMfu7Gkm957ObNzZouGEZ4x
        mJgkZ4wHzDad3I7agu0QFSTGoVJYfWLb4Zs6Av6+LW79a3Y5EOtF9F+XaXgXe2+mPn502VC8WBI
        rLeuR1Y7gVK28gazGqfznF18wdSL1JPHLrTGXcDeE86+k9uTZHxKAxBgoYewlHZg0gWH5yUXMuL
        KlM8AY7lHQ5WrruXIFTXQtFFWrTiJC7EbZ/O+1jhK8o4aoss8rBErlOTfHjCrrfxlRjqBJ3FOeW
        CVn7UVfi8zVgXoAltkWL4rBlm20vjaPj0W1qn0Q7AFczfjr/7EUhTeFKfH6k++1y6jOkZlymTf/
        Nme8yt1O1POhdBLZo4TfiNteh3NQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.549000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23746.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 17:18 +0200, Alexandre Belloni wrote:
> On 25/03/2018 at 03:36:28 +0800, Sean Wang wrote:
> > just reply both replies in the same mail
> > 
> > 1.) the power-off device is a part of rtc, use the same registers rtc
> > has and thus it is put as child nodes under the node rtc to reflect the
> > reality of characteristics the rtc has.
> > 
> > Or am I wrong for a certain aspect in these opinions?
> > 
> 
> My point is that it is also part of the PMIC so it may as well be
> registers from the mfd driver which already registers a bunch of devices
> instead of doing unusual stuff from the rtc driver.
> 
> mt6397_rtc->regmap is mt6397_chip->regmap anyway. You have the added
> benefit that if the RTC driver probe fails for some reason, you may
> still be able to probe the reset driver.
> 
> I don't tink there is any benefit having it as a child of the rtc
> device.
> 


really thanks! it's an optional solution I thought it 's fine and worth
doing

but so far I cannot fully make sure of whether mfd can accept two
devices holding overlay IORESOURCE_MEM.

Or do you like Rob's suggestion in [1] ? By which, I tend to embed a
sub-device with platform_device_register_data api in the rtc probe()
instead of treating it as a dt node under rtc node, but which seems
something a bit violates your preferences :(

Just confirm to know which way I should step into before I produce next
version.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012576.html

> > 2) the other sub-functions for the same pmic already created its own
> > dt-binding document belonged to its corresponding subsystem. Don't we
> > really want to follow it them all?
> > 
> 
> Ok, that's fine.
> 
