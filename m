Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDPShI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:37:08 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:56392 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbeDPShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:37:07 -0400
Date: Mon, 16 Apr 2018 11:37:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: ahsan_hussain@mentor.com
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, noor_ahsan@mentor.com,
        cedric_hombourger@mentor.com
Subject: Re: [PATCH 1/1] hwmon: (ina2xx) initialize mutex before locking
Message-ID: <20180416183705.GA12401@roeck-us.net>
References: <1523901203-2981-1-git-send-email-ahsan_hussain@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523901203-2981-1-git-send-email-ahsan_hussain@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:53:23PM +0500, ahsan_hussain@mentor.com wrote:
> From: Ahsan Hussain <ahsan_hussain@mentor.com>
> 
> Upstream commit 8d008c0c ("hwmon: (ina2xx) Make calibration register
> value fixed"), makes ina2xx_set_shunt() call mutex_lock on an
> un-initialized mutex. Initialize it prior so we don't get a NULL pointer
> dereference error.
> 
> Fixes: 8d008c0c ("hwmon: (ina2xx) Make calibration register value fixed")
> 
> Signed-off-by: Ahsan Hussain <ahsan_hussain@mentor.com>

Hmm ... the patch still does not apply ... having closer look ....

It appears that you don't use the mainline kernel. Commit 8d008c0c
is not upstream. It is in a stable release. Only which one ... ok,
I see it in linux-4.9.y. The offending commit is also in 4.4.y,
4.14.y, and 4.15.y. The fix needs to be pulled from upstream into
those stable releases. I'll send a request to Greg.

Thanks,
Guenter
