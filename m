Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeCWJkH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:40:07 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:38820 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752186AbeCWJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:40:04 -0400
Subject: Re: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
 <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <7e818d10-3410-b144-9cfb-c58a9945a8b1@theobroma-systems.com>
Date: Fri, 23 Mar 2018 10:40:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.18 09:32, Wolfgang Grandegger wrote:
>> * add __func__ to all errors and warnings, and to info where it made sense
> 
> The final output messages in the driver should especially be useful for
> the end user... and not the developer! This is also true for the
> function names. You already use more "__func__" than all other CAN
> drivers together. Just my opinion!

The idea was to make it clear which driver printed the message. In my 
opinion, this is a problem:

> drivers/net/can/usb$ git grep "No memory left for USB buffer"
> ems_usb.c:                      netdev_err(netdev, "No memory left for USB buffer\n");
> ems_usb.c:              netdev_err(netdev, "No memory left for USB buffer\n");
> esd_usb2.c:                              "No memory left for USB buffer\n");
> esd_usb2.c:             netdev_err(netdev, "No memory left for USB buffer\n");
> gs_usb.c:               netdev_err(netdev, "No memory left for USB buffer\n");
> gs_usb.c:                                          "No memory left for USB buffer\n");
> kvaser_usb.c:                            "No memory left for USB buffer\n");
> mcba_usb.c:                     netdev_err(netdev, "No memory left for USB buffer\n");
> usb_8dev.c:             netdev_err(netdev, "No memory left for USB buffer\n");
> usb_8dev.c:                     netdev_err(netdev, "No memory left for USB buffer\n");

But I'm open to other suggestions (use a fixed "ucan: " prefix?) or to 
drop it entirely if you think it is not worth it.

Thanks for the feedback,
Jakob
