Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBHQLO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:11:14 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41347 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeBHQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:11:13 -0500
From: "Lynch, Nathan" <Nathan_Lynch@mentor.com>
To: Pintu Kumar <pintu.ping@gmail.com>
CC: Russell King - ARM Linux <linux@armlinux.org.uk>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [VDSO]: vdso_test failing on arm 32 bit
Thread-Topic: [VDSO]: vdso_test failing on arm 32 bit
Thread-Index: AQHTc2Ulwwlrt9R7NkmN9TBCT++FJaNAayyA//+BYbiAAI3OAIABKq0AgAACKQCAAF+BgIAABJMA//9/QkSAAIeSAIAAw9QAgABUFwCAV80XAIAADW/1
Date: Thu, 8 Feb 2018 16:11:07 +0000
Message-ID: <1518106267799.61329@mentor.com>
References: <20171212162612.GB10595@n2100.armlinux.org.uk>
 <1513098352501.51185@mentor.com>
 <20171212172034.GC10595@n2100.armlinux.org.uk>
 <CAOuPNLiTf040ZOyEroq4oy=5Bz1LScmE-vpR3xdjXBGuCKcxMA@mail.gmail.com>
 <20171213111718.GJ10595@n2100.armlinux.org.uk>
 <CAOuPNLgM8OxP8cV9goAUDtXgxjhcfoe27M0Q=Ty1BVAPD5aipQ@mail.gmail.com>
 <20171213171530.GM10595@n2100.armlinux.org.uk>
 <1513186632784.96495@mentor.com>
 <20171213173956.GN10595@n2100.armlinux.org.uk>
 <CAOuPNLgZL0N0OuTUEVR6vFjykBtLeR+t0pvn3FSKsA4UqG-UGQ@mail.gmail.com>
 <20171214102148.GO10595@n2100.armlinux.org.uk>,<CAOuPNLgj8c0a1gDESQDatoa4GU_PYu8TK1NJ0KKkVfjW7zvsdA@mail.gmail.com>
In-Reply-To: <CAOuPNLgj8c0a1gDESQDatoa4GU_PYu8TK1NJ0KKkVfjW7zvsdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [147.34.91.1]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I commented the device tree reading property:
> arm,cpu-registers-not-fw-configured , from the arch/arm/kernel/vdso.c

Don't do that, please. The presence of that property indicates that the counter is not suitable for use by the OS. There is nothing we can do in Linux to make the VDSO useful on this system; that is why it gets disabled at runtime.

The timing measurements you get are likely tainted by garbage results from the VDSO itself.
