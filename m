Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeBFRrm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:47:42 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34251 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeBFRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:47:37 -0500
X-Google-Smtp-Source: AH8x224ZFh3ErHOSfzs5fTUPyran7zpPm3q8nZslpFBucHCLcpRrVIynap1EAu57pQdfXUoadG1TAQ==
Subject: Re: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
To: Andrew Lunn <andrew@lunn.ch>, Sven Van Asbroeck <thesven73@gmail.com>,
        Woojung.Huh@microchip.com, Tristram.Ha@microchip.com
Cc: Sven Van Asbroeck <svendev@arcx.com>, helmut.buchsbaum@gmail.com,
        Maarten.Blomme@flir.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
 <20180206161447.GF12679@lunn.ch>
 <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
 <20180206165009.GJ12679@lunn.ch>
 <CAGngYiWR-ayfg4KiH4yzoey+7P-jjV9MjEv8STmS65aC9JTX5Q@mail.gmail.com>
 <20180206170526.GK12679@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2f18b10f-1c84-f386-2b13-12163c0fd8a5@gmail.com>
Date: Tue, 6 Feb 2018 09:47:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206170526.GK12679@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 09:05 AM, Andrew Lunn wrote:
> On Tue, Feb 06, 2018 at 11:58:17AM -0500, Sven Van Asbroeck wrote:
>> On Tue, Feb 6, 2018 at 11:50 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>>> And a DSA driver does not need to be complex. You can start simple,
>>> and add more features later.
>>
>> I see. Would it be possible/practical to start with just phy_read/write,
>> port_enable/disable in dsa_switch_ops ? And just add a sysfs bin file
>> for userspace register access ?
> 
> I would NACK sysfs bin file. Do it right, or don't do it at all.

Sven, there is a standard ethtool register dump interface that can be
used to provide register dumps, if necessary, that might fit your use case.

Aside from the phy_read/write, port_enable/disable, you will likely need
to have a get_tag_protocol() implementation returning
DSA_TAG_PROTO_NONE, and a setup() operation, other should be entirely
optional for now.

Out of curiosity, are there any break out boards with a KS8995 switch
available that we could e.g: plug to a Raspberry Pi or any similar board?

> 
> I think i would first want to know what Tristam/Microchip plans
> are. Does he intend to keep on working on the patches from last year?

Yes, this would be good to keep alive, the patches look good, they just
need to get in now.
-- 
Florian
