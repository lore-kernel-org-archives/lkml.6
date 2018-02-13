Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934872AbeBMLsv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:48:51 -0500
Received: from mail7.pr.hu ([87.242.0.7]:56173 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934577AbeBMLss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:48:48 -0500
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <20180212111041.027edd85@endymion> <20180212185152.GA20877@roeck-us.net>
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Message-ID: <ca8f74c0-c249-7698-21f7-e3ee49cd5516@pr.hu>
Date: Tue, 13 Feb 2018 12:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212185152.GA20877@roeck-us.net>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.5 (/)
X-Scan-Signature: 590f427944e86919b339bef1bc8dcd47
X-Spam-Tracer: backend.mail.pr.hu -0.5 20180213114842Z
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-12 19:51 keltezéssel, Guenter Roeck írta:
> On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
>> Hi Guneter,
>>
>> Sorry for the delay :(
>>
>> On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote:
>>> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
>>> Use request_muxed_region() to ensure synchronization.
>>
>> Which ones? Documenting it, at least in the commit message, would seem
>> useful. Out of curiosity, have these other drivers been converted to
>> use request_muxed_region already?
>>
> Primarily watchdog, but there is also unprotected initialization code
> in several locations.

There are three locations touching the same I/O ports:
the PCI-USB quirks code (still doesn't use locking AFAIK), i2c-piix4 and
the sp5100_tco watchdog drivers.

Best regards,
Zoltán Böszörményi
