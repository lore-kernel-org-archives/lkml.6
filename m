Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeEBHIE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:08:04 -0400
Received: from mail.sysgo.com ([176.9.12.79]:56354 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeEBHIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:08:01 -0400
Subject: Re: [PATCH] Input: serio - add writing multiple bytes at once
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180430090324.30845-1-david.engraf@sysgo.com>
 <20180430212007.GC54182@dtor-ws>
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <c7ae7509-a29d-85e1-a8da-41e275e98779@sysgo.com>
Date: Wed, 2 May 2018 09:07:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180430212007.GC54182@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 30.04.2018 at 23:20, Dmitry Torokhov wrote:
> Hi David,
> 
> On Mon, Apr 30, 2018 at 11:03:24AM +0200, David Engraf wrote:
>> The current version only supports forwarding a single byte to the tty
>> layer.
>>
>> This patch adds serio_write_length() to allow a serport driver writing
>> multiple bytes at once. The patch also includes a fallback to
>> serio_write_length() when a driver did not register a single byte function.
> 
> Without users I do not see point for this API.

Here is an incomplete list of drivers calling serio_write() in a loop:

- drivers/media/usb/rainshadow-cec/rainshadow-cec.c
- drivers/input/serio/serio_raw.c
- drivers/input/touchscreen/elo.c

I can simplify these drivers by using serio_write_length() if you want 
to have some users for the new API.

Best regards
- David
