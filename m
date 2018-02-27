Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeB0C3t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:29:49 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45179 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751779AbeB0C3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:29:47 -0500
X-ME-Sender: <xms:msKUWsH9YCsgpDfkW4myhC2jfVUdnPsXw9DW4jlZDammt4xOlHWZGw>
Message-ID: <1519698581.7888.2.camel@mendozajonas.com>
Subject: Re: [PATCH net-next] net/ncsi: Add generic netlink family
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date: Tue, 27 Feb 2018 13:29:41 +1100
In-Reply-To: <20180226.113136.1568195044048732904.davem@davemloft.net>
References: <20180223041518.20195-1-sam@mendozajonas.com>
         <20180226.113136.1568195044048732904.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 11:31 -0500, David Miller wrote:
> From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Date: Fri, 23 Feb 2018 15:15:18 +1100
> 
> > + * @NCSI_CMD_SET_INTERFACE: set preferred package and channel combination.
> > + *   Requires NCSI_ATTR_IFINDEX and the preferred NCSI_ATTR_PACKAGE_ID and
> > + *   optionally the preferred NCSI_ATTR_CHANNEL_ID. If neither IDs are
> > + *   specified the setting is cleared.
> 
> I think clearing the setting when the required attributes are missing
> is dangerous behavior.
> 
> It is ambiguous whether the user intended the setting to be cleared,
> or was in error and forgot to supply the attribute due to a bug.

Fair point - I'll change this to be an error and add a separate command
to clear the setting explicitly.
In that vein is having NCSI_ATTR_CHANNEL_ID as an optional parameter
ambiguous enough to justify a separate command as well?

Regards,
Sam
