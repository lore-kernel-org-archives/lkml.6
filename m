Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeCWKEP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:04:15 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:35932 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754642AbeCWKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:04:11 -0400
Subject: Re: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
 <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
 <7e818d10-3410-b144-9cfb-c58a9945a8b1@theobroma-systems.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <e6d4bfc8-d43f-20ef-7b00-43ecf0a87f96@grandegger.com>
Date: Fri, 23 Mar 2018 11:04:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7e818d10-3410-b144-9cfb-c58a9945a8b1@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 23.03.2018 um 10:40 schrieb Jakob Unterwurzacher:
> On 23.03.18 09:32, Wolfgang Grandegger wrote:
>>> * add __func__ to all errors and warnings, and to info where it made
>>> sense
>>
>> The final output messages in the driver should especially be useful for
>> the end user... and not the developer! This is also true for the
>> function names. You already use more "__func__" than all other CAN
>> drivers together. Just my opinion!
> 
> The idea was to make it clear which driver printed the message. In my
> opinion, this is a problem:
> 
>> drivers/net/can/usb$ git grep "No memory left for USB buffer"
>> ems_usb.c:                      netdev_err(netdev, "No memory left for
>> USB buffer\n");
>> ems_usb.c:              netdev_err(netdev, "No memory left for USB
>> buffer\n");
>> esd_usb2.c:                              "No memory left for USB
>> buffer\n");
>> esd_usb2.c:             netdev_err(netdev, "No memory left for USB
>> buffer\n");
>> gs_usb.c:               netdev_err(netdev, "No memory left for USB
>> buffer\n");
>> gs_usb.c:                                          "No memory left for
>> USB buffer\n");
>> kvaser_usb.c:                            "No memory left for USB
>> buffer\n");
>> mcba_usb.c:                     netdev_err(netdev, "No memory left for
>> USB buffer\n");
>> usb_8dev.c:             netdev_err(netdev, "No memory left for USB
>> buffer\n");
>> usb_8dev.c:                     netdev_err(netdev, "No memory left for
>> USB buffer\n");

> But I'm open to other suggestions (use a fixed "ucan: " prefix?) or to
> drop it entirely if you think it is not worth it.

But there is already a device prefix, e.g.:

  peak_usb 1-6:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
  peak_usb 1-6:1.0 can0: attached to PCAN-USB channel 0 (device 255)
  ^^^^^^^^

No need to add another one!

Wolfgang.
