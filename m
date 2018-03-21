Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeCUVO4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:14:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57663 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753306AbeCUVOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:14:52 -0400
Date: Wed, 21 Mar 2018 22:14:48 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Yan Markman <ymarkman@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "Stefan Chulski" <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [PATCH net-next v2] net: mvpp2: Don't use dynamic allocs for
 local variables
Message-ID: <20180321221448.7b3ecae8@bootlin.com>
In-Reply-To: <b97e76e64d494912ae09efcc64d612ff@IL-EXCH01.marvell.com>
References: <20180321151400.6658-1-maxime.chevallier@bootlin.com>
        <b97e76e64d494912ae09efcc64d612ff@IL-EXCH01.marvell.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yan,

On Wed, 21 Mar 2018 19:57:47 +0000,
Yan Markman <ymarkman@marvell.com> wrote :

> Hi Maxime

Please avoid top-posting on this list.

> Please check the TWO points:
> 
> 1). The mvpp2_prs_flow_find() returns TID if found
>     The TID=0 is valid FOUND value
>     For Not-found use -ENOENT (just like your mvpp2_prs_vlan_find)

This is actually what is used in this patch. You might be refering to
a previous draft version of this patch.

> 2). The original code always uses "mvpp2_prs_entry *pe" storage
> Zero-Allocated Please check the correctnes of new "mvpp2_prs_entry
> pe" without memset(pe, 0, sizeof(pe));
>    in all procedures where pe=kzalloc() has been replaced

I think we're good on that regard. On places where I didn't memset the
prs_entry, the pe.index field is set, and this is followed by a read
from TCAM that will initialize the prs_entry to the correct value :

		pe.index = tid;
		mvpp2_prs_hw_read(priv, &pe);

> Thanks
> Yan Markman

[...]

Thanks,

Maxime
