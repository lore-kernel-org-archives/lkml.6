Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCWIdD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:33:03 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:58892 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCWIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:33:01 -0400
Subject: Re: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
Date: Fri, 23 Mar 2018 09:32:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacob,

Am 22.03.2018 um 14:53 schrieb Jakob Unterwurzacher:
> This is v3 of the Theobroma Systems CAN/USB adapter driver
> upstreaming effort.
> 
> Featured v2 -> v3 changes:
> * count error frames as data packets
> * use canid_t for all can ids
> * use BIT(x) instead of (1 << x)
> * use __le16 / __le32 for little-endian fields
> * add spinlock around context allocation (fixes a possible race)
> * fix comment style
> * use WARN_ON return value
> * fix state logic bug that did not allow return to ERROR_ACTIVE
> * drop echo_index from context_array (not needed)
> * rename "tx_contexts" -> "context_array" to prevent confusion
> * add __func__ to all errors and warnings, and to info where it made sense

The final output messages in the driver should especially be useful for
the end user... and not the developer! This is also true for the
function names. You already use more "__func__" than all other CAN
drivers together. Just my opinion!

> 
> Jakob Unterwurzacher (1):
>   can: ucan: add driver for Theobroma Systems UCAN devices
> 
>  Documentation/networking/can_ucan_protocol.rst |  315 +++++
>  Documentation/networking/index.rst             |    1 +
>  drivers/net/can/usb/Kconfig                    |   10 +
>  drivers/net/can/usb/Makefile                   |    1 +
>  drivers/net/can/usb/ucan.c                     | 1628 ++++++++++++++++++++++++
>  5 files changed, 1955 insertions(+)
>  create mode 100644 Documentation/networking/can_ucan_protocol.rst
>  create mode 100644 drivers/net/can/usb/ucan.c

Wolfgang.
