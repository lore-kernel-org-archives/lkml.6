Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3186700-1522942607-2-17515373842308234197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522942607; b=Z81RiIbIA8L2z7bbZfRbHjo8FX+Dk2JwvhpPVmHR/qZDnghLmz
    rvSRETDf9Yz/Uau/8gl03gBQWjnRB374SF1y8P2gBDPyg3fSUsASoponLuP3Q1+O
    8oQ7YKZsvy4brD7+JA7J2QjjVUtDLcqv49GKqBfbV2V9UZXVBeAY0sCWu0eC5Ajt
    0dL+/TEoISr3kvrUF9zGf8SCaREOrU+fqPc3hKzaZy90KZPh8sN+Rlzapx+MA+ZB
    kUcL3W7tN/+EswdVy8/zrQfLGgny8yrTpfO0X650Z7ylcoRAZ5rVUKp9XJbzVDRM
    JfQx4VcuJJpXyYqY1p3BW+cSbKksZYexsGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522942607;
    bh=VBVKA3bu9GZg9OV13EcEDgCIGEpcYOK5dxPxS80MxIs=; b=Fmk9istcBcIA
    2/iZ0ek8P1K1/QmjQ/7YrAx2dhxWwb8yeQdgCdp8gb3ZNmOGogVXyyuO6ULuai0L
    khHHo1AXiZtqvoCkAefOmMMjMzHSPyAUpq9rq931vSOqqutJcltQ5kI9eiWdniP6
    2QNJHoK1YDRLTPdkYLTEH0bME9OOU8l0DMaopPefT09ux67Ekc1qqDnvf5OeUP36
    d3osgmUwPZrZEMgPBoLurzb7xP4y8N5pjdXDBWiyiIfOP3wlQymeix9MHh4/MAfV
    WQtJvg176roMefMchHsTFbhf/20MhACk3++ha9ifFDbL72kl74sxfjkfabGRC1Ls
    PlIFKydv0Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKsZZ9y/NwQJywf8eNjvEaaaokkWh6BbsgLiEVAPy/YS95mDpCDIm1dLCL+pbh97eryqdTPYIXzVJirnqoXmr2hzJobsM0BbrWnRpSSYz82w82dUZY9B
    umLiG/J2h/b0Z2I9MMZX9EdOmeBkXZ0AB9CA0r00gM2lGloeHCWaivIIajCEJVtW9oxK2cOgHW5IxIFU/hG3NFNpm0RlC3l6NnovmF29jfA1nxsLFZcIQIfX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1EsaE_6oAAAA:8 a=yPCof4ZbAAAA:8 a=bjfTeUKfO2Tf0FBKf6gA:9 a=QEXdDO2ut3YA:10
    a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDEPgo convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 5 Apr 2018 11:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750835AbeDEPgn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 11:36:43 -0400
Date: Thu, 5 Apr 2018 17:36:36 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 4.4 92/97] ip6_vti: adjust vti mtu according to mtu of
 lower device
Message-ID: <20180405173636.5765efcf@epycfail>
In-Reply-To: <1522800556.2654.158.camel@codethink.co.uk>
References: <20180323094157.535925724@linuxfoundation.org>
        <20180323094202.622913188@linuxfoundation.org>
        <1522800556.2654.158.camel@codethink.co.uk>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 04 Apr 2018 01:09:16 +0100
Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:

> On Fri, 2018-03-23 at 10:55 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Alexey Kodanev <alexey.kodanev@oracle.com>
> > 
> > 
> > [ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]  
> [...]
> 
> There are a couple of follow-ups to this:
> 
> c6741fbed6dc vti6: Properly adjust vti6 MTU from MTU of lower device
> 7a67e69a339a vti6: Keep set MTU on link creation or change, validate it
> 
> The second of those will fail to build on branches older than 4.10
> though.  It might be better to revert this one instead.

Thanks Ben for spotting this.

Actually,
  53c81e95df17 ("ip6_vti: adjust vti mtu according to mtu of lower device")
alone improves things already, despite being "fixed" by
  c6741fbed6dc ("vti6: Properly adjust vti6 MTU from MTU of lower device")

With just 53c81e95df17 the MTU of a vti6 interface will be somewhat
linked to the MTU of the lower layer, but will be underestimated.

With c6741fbed6dc the calculation of MTU from lower layer will be
accurate instead.

However, without
  7a67e69a339a ("vti6: Keep set MTU on link creation or change, validate it")
but with
  53c81e95df17 ("ip6_vti: adjust vti mtu according to mtu of lower device")
assignment of MTU on link change is discarded, so this would actually
introduce a bug.

Fixing
  7a67e69a339a ("vti6: Keep set MTU on link creation or change, validate it")
for 4.4 up to 4.9 is trivial, we simply need to adjust for the lack of
  b96f9afee4eb ("ipv4/6: use core net MTU range checking")
and reflect the change introduced by
  f8a554b4aa96 ("vti6: Fix dev->max_mtu setting").

So, Greg, here comes the backport of
  7a67e69a339a ("vti6: Keep set MTU on link creation or change, validate it")
based on latest linux-4.4.y branch, in case you want to keep the existing
change and add the follow-ups on top. Please let me know if I should submit
it formally.

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 176e79076fb1..f388f54b4162 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -610,7 +610,7 @@ static int vti6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
-static void vti6_link_config(struct ip6_tnl *t)
+static void vti6_link_config(struct ip6_tnl *t, bool keep_mtu)
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
@@ -629,6 +629,13 @@ static void vti6_link_config(struct ip6_tnl *t)
 	else
 		dev->flags &= ~IFF_POINTOPOINT;
 
+	if (keep_mtu && dev->mtu) {
+		dev->mtu = clamp(dev->mtu, (unsigned)IPV6_MIN_MTU,
+				 (unsigned)(IP_MAX_MTU -
+					    sizeof(struct ipv6hdr)));
+		return;
+	}
+
 	if (p->flags & IP6_TNL_F_CAP_XMIT) {
 		int strict = (ipv6_addr_type(&p->raddr) &
 			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
@@ -656,12 +663,14 @@ static void vti6_link_config(struct ip6_tnl *t)
  * vti6_tnl_change - update the tunnel parameters
  *   @t: tunnel to be changed
  *   @p: tunnel configuration parameters
+ *   @keep_mtu: MTU was set from userspace, don't re-compute it
  *
  * Description:
  *   vti6_tnl_change() updates the tunnel parameters
  **/
 static int
-vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p)
+vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
+		bool keep_mtu)
 {
 	t->parms.laddr = p->laddr;
 	t->parms.raddr = p->raddr;
@@ -670,11 +679,12 @@ vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p)
 	t->parms.o_key = p->o_key;
 	t->parms.proto = p->proto;
 	dst_cache_reset(&t->dst_cache);
-	vti6_link_config(t);
+	vti6_link_config(t, keep_mtu);
 	return 0;
 }
 
-static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
+static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
+		       bool keep_mtu)
 {
 	struct net *net = dev_net(t->dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
@@ -682,7 +692,7 @@ static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
 
 	vti6_tnl_unlink(ip6n, t);
 	synchronize_net();
-	err = vti6_tnl_change(t, p);
+	err = vti6_tnl_change(t, p, keep_mtu);
 	vti6_tnl_link(ip6n, t);
 	netdev_state_change(t->dev);
 	return err;
@@ -795,7 +805,7 @@ vti6_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 			} else
 				t = netdev_priv(dev);
 
-			err = vti6_update(t, &p1);
+			err = vti6_update(t, &p1, false);
 		}
 		if (t) {
 			err = 0;
@@ -907,7 +917,7 @@ static int vti6_dev_init(struct net_device *dev)
 
 	if (err)
 		return err;
-	vti6_link_config(t);
+	vti6_link_config(t, true);
 	return 0;
 }
 
@@ -1006,7 +1016,7 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	} else
 		t = netdev_priv(dev);
 
-	return vti6_update(t, &p);
+	return vti6_update(t, &p, tb && tb[IFLA_MTU]);
 }
 
 static size_t vti6_get_size(const struct net_device *dev)


-- 
Stefano
