Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeDIMjV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:39:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53949 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeDIMjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:39:19 -0400
Date: Mon, 9 Apr 2018 14:39:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rakesh Pandit <rakesh@tuxera.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
Message-ID: <20180409123910.GB31060@lunn.ch>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
 <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 07:35:14PM +0800, AceLan Kao wrote:
> The WoL feature was reported broken and will lead to
> the system resume immediately after suspending.
> This symptom is not happening on every system, so adding
> disable_wol option and disable WoL by default to prevent the issue from
> happening again.

>  const char alx_drv_name[] = "alx";
>  
> +/* disable WoL by default */
> +bool disable_wol = 1;
> +module_param(disable_wol, bool, 0);
> +MODULE_PARM_DESC(disable_wol, "Disable Wake on Lan feature");
> +

Hi AceLan

This seems like you are papering over the cracks. And module
parameters are not liked.

Please try to find the real problem.

       Andrew
