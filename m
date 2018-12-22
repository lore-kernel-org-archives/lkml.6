Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E358C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D81221934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeLVSsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:48:12 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:39187 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbeLVSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:48:11 -0500
Received: from oxbsltgw67.schlund.de ([212.227.220.205]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M730b-1gSiQg2QiV-008XDz; Sat, 22 Dec 2018 13:19:37 +0100
Date:   Sat, 22 Dec 2018 13:19:36 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>, linux-i2c@vger.kernel.org
Message-ID: <1941132339.131316.1545481176339@email.ionos.de>
In-Reply-To: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:/SDxGrIlfO2kzF/9ruzF2NeN+DYef9XUmTuHb/adAT3+o5h5d7Z
 LYkX+PSUTYFMn/2HBo9hm0PGaCIcTzvAP/OdSIwXVUxYGTg5avFljhwGKGsOwGnIgx9R69z
 tINcSlGsg0gTbkzRHyi2M+/hJ9wjW3lIbw64llk8xvm/LXDJkQWXFgmgI8X+lNDoye8of4Q
 wkACQP3QgYJzjNFNd3Rzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXXYDhyADDQ=:/h07U+MJxMIT1lxug94kXS
 iFI3lKLIlaUE49AUDT7/tnTVAJ5O88CL0qYP8hEdRpdB7t87nPV8e1ZybtsbxLIm/vtpVCfQy
 tsrfao0FM8xp+yhhyASJyOJkWYocqBdJ6+MprCygNgLgwodVBRrwhOEWtOU1CMueUvD5h2/AH
 wknHXtZoAWlRKiO6GvasCQLfooscnhczgpJFBf/H6ld/yUREXc4dwcOxvrpgixXGHkWsrv44H
 xOwPyXtN1ri29NZzDw7iEy1fL44bf86ysSZmXdK0rgG1RllnlJCsbP8UnohoQTr8VYX8UkqVv
 N4bSr8OgFdU3bZh9qp8SHBCe2nbU5H/NV5SGMRRh7UOZMdJ3ZhVTt0g9SYiEzA8LH39I/p8rm
 JkFnasYEx4UCz2XTYYvOy6O3mutQIOqNuwzG2x+AUYmNcaB/tO2fdBeGaD9qj68oV6xumJIkd
 VogCqKsg66rNPpdhR656029Wy+SJt99GvJwTfloVKUkJzRj8hySMDDdPJypIkhqTxC4qjpWhL
 WuYaFNmgiiRV7i4Se9siDObVwNTz+9CVZeTgRgM98CtYBdnspklVyrWNzgqvsu7lshDj6OM2m
 uIJPKhzcxJUB0G7sdzNsh14p4aSkFh2BEUZZzn2EMAXucEVy/CKG3UT/fvRPhYBkd1GFKd7re
 hXLk+U2HRFTgv7munb9KqYwyCdyoUOA+yUeRwgWNzp2DKzmUj5KNf5R0qJ0L0YhFs5gTHyPVj
 CJjptMtK0A5KkhxpiT6RSXH2umRsPcBZey8CZeNYahYGMrVFRz+arDLBsCM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> 
> 
> The driver's interrupt handler checks whether a message is currently
> being handled with the curr_msg pointer. When it is NULL, the interrupt
> is considered to be unexpected. Similarly, the i2c_start_transfer
> routine checks for the remaining number of messages to handle in
> num_msgs.
> 
> However, these values are never cleared and always keep the message and
> number relevant to the latest transfer (which might be done already and
> the underlying message memory might have been freed).
> 
> When an unexpected interrupt hits with the DONE bit set, the isr will
> then try to access the flags field of the curr_msg structure, leading
> to a fatal page fault.
> 
> Fix the issue by systematically clearing curr_msg and num_msgs in the
> driver-wide device structure when a transfer is considered complete.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 44deae78913e..5486252f5f2f 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>  		return -ETIMEDOUT;
>  	}
>  
> +	i2c_dev->curr_msg = NULL;
> +	i2c_dev->num_msgs = 0;

AFAIU this would reduce the chance of a use-after-free dramatically but not completely.

Btw: Why did you leave of the i2c transfer timeout case?

Thanks
Stefan

> +
>  	if (!i2c_dev->msg_err)
>  		return num;
>  
> -- 
> 2.20.1
>
