Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeDIOus (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:50:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49718 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeDIOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:50:47 -0400
Date: Mon, 09 Apr 2018 10:50:39 -0400 (EDT)
Message-Id: <20180409.105039.310935818370762783.davem@davemloft.net>
To: andrew@lunn.ch
Cc: acelan.kao@canonical.com, jcliburn@gmail.com, chris.snook@gmail.com,
        rakesh@tuxera.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180409123910.GB31060@lunn.ch>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
        <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
        <20180409123910.GB31060@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 9 Apr 2018 14:39:10 +0200

> On Mon, Apr 09, 2018 at 07:35:14PM +0800, AceLan Kao wrote:
>> The WoL feature was reported broken and will lead to
>> the system resume immediately after suspending.
>> This symptom is not happening on every system, so adding
>> disable_wol option and disable WoL by default to prevent the issue from
>> happening again.
> 
>>  const char alx_drv_name[] = "alx";
>>  
>> +/* disable WoL by default */
>> +bool disable_wol = 1;
>> +module_param(disable_wol, bool, 0);
>> +MODULE_PARM_DESC(disable_wol, "Disable Wake on Lan feature");
>> +
> 
> Hi AceLan
> 
> This seems like you are papering over the cracks. And module
> parameters are not liked.
> 
> Please try to find the real problem.

Agreed.
