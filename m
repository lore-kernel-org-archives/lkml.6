Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032387AbeBNQSd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:18:33 -0500
Received: from muru.com ([72.249.23.125]:56930 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032153AbeBNQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:18:32 -0500
Date: Wed, 14 Feb 2018 08:18:28 -0800
From: Tony Lindgren <tony@atomide.com>
To: Qi Hou <qi.hou@windriver.com>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, v3] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
Message-ID: <20180214161828.GF6364@atomide.com>
References: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Qi Hou <qi.hou@windriver.com> [180110 20:54]:
> When more than one GP timers are used as kernel system timers and the
> corresponding nodes in device-tree are marked with the same "disabled"
> property, then the "attr" field of the property will be initialized
> more than once as the property being added to sys file system via
> __of_add_property_sysfs().
> 
> In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
> directly to the return value of safe_name(), without taking care of
> whether it's already a valid pointer to a memory block. If it is, its
> old value will always be overwritten by the new one and the memory block
> allocated before will a "ghost", then a kmemleak happened.
> 
> That the same "disabled" property being added to different nodes of device
> tree would cause that kind of kmemleak overhead, at leat once.
> 
> To fix it, allocate the property dynamically, and delete static one.

Thanks applying into omap-for-v4.16/fixes.

Tony
