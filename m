Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCNJVx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:21:53 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:39812 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751696AbeCNJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:21:50 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
 <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
 <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <a8e8b20c-341d-9cf0-0379-fd73ee9f9c81@theobroma-systems.com>
Date: Wed, 14 Mar 2018 10:21:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.18 10:17, Wolfgang Grandegger wrote:
> Counting the state changes is one thing but you should also generate 
> error messages for them.

We do for BUS-OFF already (see below), but not for other states - will 
do in v3.

> +	/* we switched into a worse state */
> +	up->can.state = new_state;
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		can_stats->bus_off++;
> +		can_bus_off(up->netdev);
> +		netdev_info(up->netdev,
> +			    "link has gone into BUS-OFF state\n");
> +		break;
