Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbeCGM5O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:57:14 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:50718 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCGM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:57:11 -0500
Date: Wed, 7 Mar 2018 13:57:08 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <yossiku@mellanox.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Artem Savkov <artem.savkov@gmail.com>
Subject: Re: [PATCH net] xfrm: Verify MAC header exists before overwriting
 eth_hdr(skb)->h_proto
Message-ID: <20180307125708.rb55ny6rhxqgstpy@gauss3.secunet.de>
References: <1520190232-7208-1-git-send-email-yossiku@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1520190232-7208-1-git-send-email-yossiku@mellanox.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 594905A7-8D47-4050-A687-B7CD44B7BABC
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 09:03:52PM +0200, yossiku@mellanox.com wrote:
> From: Yossi Kuperman <yossiku@mellanox.com>
> 
> Artem Savkov reported that commit 5efec5c655dd leads to a packet loss under
> IPSec configuration. It appears that his setup consists of a TUN device,
> which does not have a MAC header.
> 
> Make sure MAC header exists.
> 
> Note: TUN device sets a MAC header pointer, although it does not have one.
> 
> Fixes: 5efec5c655dd ("xfrm: Fix eth_hdr(skb)->h_proto to reflect inner IP version")
> Reported-by: Artem Savkov <artem.savkov@gmail.com>
> Tested-by: Artem Savkov <artem.savkov@gmail.com>
> Signed-off-by: Yossi Kuperman <yossiku@mellanox.com>

Applied, thanks Yossi!
