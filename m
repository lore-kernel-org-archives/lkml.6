Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeBZQbo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:31:44 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBZQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:31:42 -0500
Date: Mon, 26 Feb 2018 11:31:36 -0500 (EST)
Message-Id: <20180226.113136.1568195044048732904.davem@davemloft.net>
To: sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: Add generic netlink family
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223041518.20195-1-sam@mendozajonas.com>
References: <20180223041518.20195-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Fri, 23 Feb 2018 15:15:18 +1100

> + * @NCSI_CMD_SET_INTERFACE: set preferred package and channel combination.
> + *	Requires NCSI_ATTR_IFINDEX and the preferred NCSI_ATTR_PACKAGE_ID and
> + *	optionally the preferred NCSI_ATTR_CHANNEL_ID. If neither IDs are
> + *	specified the setting is cleared.

I think clearing the setting when the required attributes are missing
is dangerous behavior.

It is ambiguous whether the user intended the setting to be cleared,
or was in error and forgot to supply the attribute due to a bug.
