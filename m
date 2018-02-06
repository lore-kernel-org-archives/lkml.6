Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeBFSLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:11:40 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:55926 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeBFSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:11:33 -0500
X-Google-Smtp-Source: AH8x225EUP4w8oaxsWJi2s5kWTQyMN1AvIs4+L7yx+1ELEUfzBc6+PtlOKWtARAZ32klG7UQYYlWxN6dMENLIruD9V4=
MIME-Version: 1.0
In-Reply-To: <2f18b10f-1c84-f386-2b13-12163c0fd8a5@gmail.com>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
 <20180206161447.GF12679@lunn.ch> <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
 <20180206165009.GJ12679@lunn.ch> <CAGngYiWR-ayfg4KiH4yzoey+7P-jjV9MjEv8STmS65aC9JTX5Q@mail.gmail.com>
 <20180206170526.GK12679@lunn.ch> <2f18b10f-1c84-f386-2b13-12163c0fd8a5@gmail.com>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Tue, 6 Feb 2018 13:11:31 -0500
Message-ID: <CAGngYiW1ktwnRDORY=h9wZyHU-cGGE-QtNcECGB5gb=wyp+hKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung.Huh@microchip.com,
        Tristram.Ha@microchip.com, Sven Van Asbroeck <svendev@arcx.com>,
        helmut.buchsbaum@gmail.com, Maarten.Blomme@flir.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Florian, thanks for your input.

On Tue, Feb 6, 2018 at 12:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> I would NACK sysfs bin file. Do it right, or don't do it at all.

On Tue, Feb 6, 2018 at 12:47 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Sven, there is a standard ethtool register dump interface that can be
> used to provide register dumps, if necessary, that might fit your use case.

I'm not keen on the sysfs bin file either, the existing driver has this,
and we use it because it's there.

Our use case is as follows: all we need is a reset on boot, followed by
a few static register bitfiddles which reflect the way we've integrated
the IC into our product. There is no further Linux interaction.
I guess the devicetree would be a natural place to store the required
register changes. No need for sysfs.

As I said before, not sure how others use this chip.

Would the above be attainable by a (trivial) DSA driver?
