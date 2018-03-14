Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeCNJO3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:14:29 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:53789 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbeCNJO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:14:28 -0400
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
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
Date: Wed, 14 Mar 2018 10:14:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.18 10:11, Wolfgang Grandegger wrote:
>> +    /* handle error frames */
>> +    canid = le32_to_cpu(m->msg.can_msg.id);
>> +    if (canid & CAN_ERR_FLAG) {
>> +        ucan_handle_error_frame(up, m, canid);
>> +        /* drop frame if berr-reporting is off */
>> +        if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>> +            return;
>> +    }
> 
> You still do not generate error messages for state changes, IIUC.

The hardware generates error frames on state changes - is that what you 
mean?

In our testing, the state shows up (and updates) correctly in

	ip -details -statistics link show can0

Best regards,
Jakob
