Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeDIKcv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:32:51 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:52828 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeDIKcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:32:50 -0400
Date: Mon, 9 Apr 2018 12:32:47 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kevin Easton <kevin@guarana.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] af_key: Fix for sadb_key memcpy read overrun
Message-ID: <20180409103247.tfcvthfjsszz3z6y@gauss3.secunet.de>
References: <cover.1523115061.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1523115061.git.kevin@guarana.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: B6A0CA9A-6863-43A8-80BB-49D564AF5BAF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 11:40:18AM -0400, Kevin Easton wrote:
> As found by syzbot, af_key does not properly validate the key length in
> sadb_key messages from userspace.  This can result in copying from beyond
> the end of the sadb_key part of the message, or indeed beyond the end of
> the entire packet.
> 
> Both these patches apply cleanly to ipsec-next.  Based on Steffen's
> feedback I have re-ordered them so that the fix only is in patch 1, which
> I would suggest is also a stable tree candidate, whereas patch 2 is a
> cleanup only.

I think here is some explanation needed. Usually bugfixes and cleanups
don't go to the same tree. On IPsec bugfixes go to the'ipsec' tree
while cleanups and new features go to the 'ipsec-next' tree. So
you need to split up your patchsets into patches that are targeted
to 'ipsec' and 'ipsec-next'. Aside from that, we are in 'merge window'
currently. This means that most maintainers don't accept patches to
their -next trees. If you have patches for a -next tree, wait until
the merge window is over (when v4.17-rc1 is released) and send them
then.
