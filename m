Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1197340-1522073755-2-5638170756944955042
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522073754; b=S4+Lkm4ocNtv3aclmrS5KCiAprN4spTnv84KfYA/Clnc/J/
    doP/2CfTxVPJz0VW066ybmuRWkdUTJ+pw4rBaecbNRP6mgaExOTtszBbfxLe/3xD
    6lI9jRnc9rAFTeN76Gu/huri2swQHbuZm+Z6L6ljdEfunhr7kp/WWpFwQeT67Ljb
    2RWAqCkAIX5dl+pGZhejntvmLdzqUDsba924LwJKXQlXpfrH6yHfHW08XpISal+c
    CSXolKq1OnPwfQsWpulFxuLDUwcLUts/x78MMj43R/Odxh5XLRElKDoTNW9Q0Ee7
    lWcV1m2WfT6B+w5jpkFoOsUDojIAWpHAhi9eT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522073754; bh=xsqeoSgtXa4T7F+vcGZ0QGxbG8
    Yp8JEv6J1Y9yHRNeg=; b=MHNHERpZrWdHMhePeySJXVeEo8lq3THSrneaCbivt/
    7hrSzNUf8cXk9Cu+YFT8JVEGVOF77soydwAJTy5BzZQo+eW61XwzDnkLgNyRK62Q
    5+Mqats3X+WRuJheQj2GyqvzfxSGddZgLTVCNvw1q8Jp08F7miWCOZmLDO6+VW/j
    xeKWtsA2/PVdiakma7iMX63co9TXkCh2aPnBQ8vGeeJHyiYQfOBz7XQaGvL75ZdR
    q1iCPFItj5NsFaHcvbTCHXdbPJ1m2t+Qv9oiF2a9P5Npa23MfmnHx8wp72wJ+nmO
    5JFLUJoIT9mi5eYi3wO4rv2QjOyKUXNU7mggN+39PCzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKmxedNnv/zVqdPFWH+wdpgO/k5WjaGneI60t8Z5goBHe0AapY6+GoYIPD4birqdBWGIUg1IwBZA3EtVoMhgdRMRi5+i0q5MqiKIXonIJJNxPx03ao+3
    U9WjZmYgeup4HAgGbIAL/Uw7aTsUTtT6pYiRqk9SUeIOdoO67FDalvFdcEgnNzmgsdkZRTd18RMa8E8khL0WPvc+xXno9KRbPkoX/On2kJmtLplw1NLfZEQV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=IJv9LcIfAAAA:8 a=tHz9FfFoAAAA:8 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=cmr4hm9N53k6aw-X_--Q:22
    a=Z52K5TbU17EcDgFyT5Ki:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeCZOPu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 10:15:50 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:61302 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752655AbeCZOPs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Mar 2018 10:15:48 -0400
X-IronPort-AV: E=Sophos;i="5.48,365,1517875200";
   d="scan'208";a="467289493"
Date: Mon, 26 Mar 2018 15:07:27 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Joe Perches <joe@perches.com>
CC: Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean-Paul Roubelat <jpr@f6fbb.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Michal Ostrowski <mostrows@earthlink.net>,
        Oliver Neukum <oliver@neukum.org>,
        Wei Liu <wei.liu2@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hams@vger.kernel.org>, <devel@linuxdriverproject.org>,
        <linux-wpan@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 4/4] drivers/net: Use octal not symbolic permissions
Message-ID: <20180326140727.4aripztdc2ar6g45@citrix.com>
References: <cover.1521845235.git.joe@perches.com>
 <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 03:54:39PM -0700, Joe Perches wrote:
> Prefer the direct use of octal for permissions.
> 
> Done with checkpatch -f --types=SYMBOLIC_PERMS --fix-inplace
> and some typing.
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/xen-netback/xenbus.c       |  4 +-
>  drivers/net/xen-netfront.c             |  6 +--

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
