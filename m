Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeBFMZn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:25:43 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:55972 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeBFMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:25:30 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "brgl@bgdev.pl" <brgl@bgdev.pl>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] arc: dts: use 'atmel' as manufacturer for at24 in
 axs10x_mb
Thread-Topic: [PATCH v2] arc: dts: use 'atmel' as manufacturer for at24 in
 axs10x_mb
Thread-Index: AQHTnzrLWIKvJYNdJkiaoqAuzzZm0KOXO+WA
Date: Tue, 6 Feb 2018 12:25:24 +0000
Message-ID: <1517919923.6726.13.camel@synopsys.com>
References: <20180206110810.9093-1-brgl@bgdev.pl>
In-Reply-To: <20180206110810.9093-1-brgl@bgdev.pl>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.21.20]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D75A9A8573C4F439A3A1CD77216747A@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w16CPnO3017092

Hi Bartosz,

On Tue, 2018-02-06 at 12:08 +0100, Bartosz Golaszewski wrote:
> Using compatible strings without the <manufacturer> part for at24 is
> deprecated since commit 6da28acf745f ("dt-bindings: at24: consistently
> document the compatible property"). Use a correct 'atmel,<model>'
> value.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

So my further input might be a bit unexpected :)

I took a look at the real board and understood that we specified in .dts
wrong ICs. Those Atmel parts are not connected to the CPU at all (used by some
external device) and instead I2C EEPROM we really have connected (but not yet
obviously used in the Linux kernel) is NXP's PCF8594C-2.

That said we may accept your change because it doesn't break anything
and then I'll send an update to axs10x_mb.dts with replacement of EEPROM nodes.
Or we may drop your change at all since I'm going to replace corresponding nodes.

-Alexey
