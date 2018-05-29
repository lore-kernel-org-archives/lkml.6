Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967231AbeE2V3H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:29:07 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:41405 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967011AbeE2V3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:29:06 -0400
Subject: Re: [PATCH v4] usbip: dynamically allocate idev by nports found in
 sysfs
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Shuah Khan <shuah@kernel.org>
References: <20180525142346.6591-1-m.grzeschik@pengutronix.de>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d7649803-073a-98a3-d65d-5f9e896776d5@kernel.org>
Date: Tue, 29 May 2018 15:28:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525142346.6591-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 08:23 AM, Michael Grzeschik wrote:
> As the amount of available ports varies by the kernels build
> configuration. To remove the limitation of the fixed 128 ports
> we allocate the amount of idevs by using the number we get
> from the kernel.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> v1 -> v2: - reworked memory allocation into one calloc call
>           - added error path on allocation failure
> v2 -> v3: - moved check for available nports to beginning of function
> v3 -> v4: - changed get_nports to get hc_device via parameter
>           - moved calloc after valid get_nports call
> 

Thanks. Looks good to me. It works now and doesn't segfault :)

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

thanks,
-- Shuah
