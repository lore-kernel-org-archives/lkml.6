Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeCaOde (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:33:34 -0400
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:59783 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752153AbeCaOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:33:32 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:981:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3870:4321:4605:5007:10004:10400:10848:11026:11232:11658:11914:12043:12048:12050:12438:12555:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14659:14721:21080:21433:21627:30003:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: rake49_75d6cc608c806
X-Filterd-Recvd-Size: 2196
Message-ID: <1522506808.11653.7.camel@perches.com>
Subject: Re: [PATCH 06/12] wireless: Convert simple uses of a static const
 Ethernet broadcast address
From: Joe Perches <joe@perches.com>
To: Pkshih <pkshih@realtek.com>, "huxm@marvell.com" <huxm@marvell.com>,
        "gbhat@marvell.com" <gbhat@marvell.com>,
        "jussi.kivilinna@iki.fi" <jussi.kivilinna@iki.fi>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "chunkeey@googlemail.com" <chunkeey@googlemail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>
Date: Sat, 31 Mar 2018 07:33:28 -0700
In-Reply-To: <1522504872.1910.17.camel@realtek.com>
References: <cover.1522479607.git.joe@perches.com>
         <79196f134a513d50968e8e208a0e56b3c0236ee3.1522479607.git.joe@perches.com>
         <1522504872.1910.17.camel@realtek.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-31 at 14:01 +0000, Pkshih wrote:
> On Sat, 2018-03-31 at 00:05 -0700, Joe Perches wrote:
> > Use the new ether_broadcast_addr global instead to save some object code.
[]
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c
[]
> > @@ -1649,7 +1648,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> >  			memcpy(rtlpriv->sec.key_buf[key_idx],
> >  			       key->key, key->keylen);
> >  			rtlpriv->sec.key_len[key_idx] = key->keylen;
> > -			memcpy(mac_addr, bcast_addr, ETH_ALEN);
> > +			memcpy(mac_addr, ether_broadcast_addr, ETH_ALEN);
> 
> Use ether_addr_copy(mac_addr, ether_broadcast_addr) ?

This should use eth_broadcast_addr(mac_addr) instead.

There are similar conversion still possible in the tree.
One day.
