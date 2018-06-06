Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="JEkPL87O"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63C1060767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeFFMHy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:07:54 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:60257 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFFMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:07:49 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
Subject: Re: [PATCH 4/4] serial: core: Mask mctrl with TIOCM_RTS too if rs485
 on and RTS_AFTER_SEND set.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: matwey.kornilov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
 <20180606094942.71190-3-giulio.benetti@micronovasrl.com>
 <a156ce90ab7e45ecf6936c29cc5d976c56f49a51.camel@linux.intel.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <5bda9e82-369a-ff5f-fef8-f3933c6f1c64@micronovasrl.com>
Date: Wed, 6 Jun 2018 14:07:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a156ce90ab7e45ecf6936c29cc5d976c56f49a51.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/06/2018 14:03, Andy Shevchenko ha scritto:
> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>> If rs485 is enabled and RTS_AFTER_SEND is set on startup need to keep
>> TIOCM_RTS asserted to keep rs485 transceiver in RX when idle.
>>
>> Check if rs485 is on and RTS_AFTER_SEND is set and mask port->mctrl
>> with
>> TIOCM_RTS too and not only TIOCM_DTR.
>>
> 
> This one feels wrong to be in serial_core.c. Perhaps in 8250/8250*.c.

I've tried to avoid modifying serial_core.c but if it masks mctrl only 
with TIOCM_DTR, it forces RTS unasserted.
Another way could be:
If rs485 ON and RTS_AFTER_SEND set, then ignore RTS driving in 
8250_set_mctrl, would it make sense?

Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
