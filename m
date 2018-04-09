Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeDIKdp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:33:45 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:52880 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeDIKdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:33:44 -0400
Date: Mon, 9 Apr 2018 12:33:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kevin Easton <kevin@guarana.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] af_key: Always verify length of provided sadb_key
Message-ID: <20180409103339.jtkfg7xhjmjy772o@gauss3.secunet.de>
References: <cover.1523115061.git.kevin@guarana.org>
 <de803d3d01f8b70d306c0d52569cc5265ed20bc9.1523115061.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de803d3d01f8b70d306c0d52569cc5265ed20bc9.1523115061.git.kevin@guarana.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: CEFCC8D5-2E9A-400B-8BE5-124B09842E70
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 11:40:33AM -0400, Kevin Easton wrote:
> Key extensions (struct sadb_key) include a user-specified number of key
> bits.  The kernel uses that number to determine how much key data to copy
> out of the message in pfkey_msg2xfrm_state().
> 
> The length of the sadb_key message must be verified to be long enough,
> even in the case of SADB_X_AALG_NULL.  Furthermore, the sadb_key_len value
> must be long enough to include both the key data and the struct sadb_key
> itself.
> 
> Introduce a helper function verify_key_len(), and call it from
> parse_exthdrs() where other exthdr types are similarly checked for
> correctness.
> 
> Signed-off-by: Kevin Easton <kevin@guarana.org>
> Reported-by: syzbot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com

Applied to the ipsec tree, thanks Kevin!
