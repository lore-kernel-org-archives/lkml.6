Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2844860-1517590871-2-8861766658535015439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590870; b=u0wo8VkWI+v9injhu977Lq+8e6Gfrgmy/mK9KnZ/vwOlJBH
    sEakcErLocibFmG79wClw5t0sMQea1SVvS27cFrPXdVw4EGg83pm+VEgcw29xOix
    k+KbgKXQkfm4d8ZdezCrw6GSYG5y5G+WyDYaCK7vhFTzmOS7IYr9zPrV/uLiwi/X
    awoubhAHRjz3CHvhW0xC6CjWDUwwtCHvJyNGeXcTLGK66LjcP0K967VR9Vnx4CUj
    5yoZOKPDsEvbavWTcF94ZVFmYwodAShOS8QeK2qfEhuViNaPFPtCXoF41NC4cUjc
    SrhDGpMMhrCHGoFnzYY3jqMqhaIqe0Nl8o38gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590870; bh=U/Wcbuhnv8UoAVWlSKmr/tiQN8
    QPSljW/pkWlG8FGHc=; b=m/B90gB9Icl5XoxAYWWXD3dhpeP8B5rZL/ksIkh12S
    ykswLJovE7WAk9Pu+Y2nRTba93273UoUEhPzV5Jk+gdWcQVmk1AvyDoGZc9M5zxM
    DWqnAFLVbyLWsVYwQdtb8vrYeLTahYeQliFY19D8C3IhVCtEEk5TYSctL94bezBE
    4xxGvke0GGtrk3Dz7Fa32nqK/aYKNwzxoiCws0Y3sEczeUK2jRFL641LwAcKsIdJ
    /DYrOULzdCLWWz7am19NCUVpsE+jRzUDncQim46IRNmS8X3hggdE+LGJs2q89TGx
    zs7UlpnnayFahzfyKEv+NUbYuQBL6wNDeaA28nOFWwHA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeBBRBI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:01:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbeBBRAy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:00:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Otubo <otubo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 37/67] xen-netfront: remove warning when unloading module
Date: Fri,  2 Feb 2018 17:58:06 +0100
Message-Id: <20180202140819.696530973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduardo Otubo <otubo@redhat.com>


[ Upstream commit 5b5971df3bc2775107ddad164018a8a8db633b81 ]

v2:
 * Replace busy wait with wait_event()/wake_up_all()
 * Cannot garantee that at the time xennet_remove is called, the
   xen_netback state will not be XenbusStateClosed, so added a
   condition for that
 * There's a small chance for the xen_netback state is
   XenbusStateUnknown by the time the xen_netfront switches to Closed,
   so added a condition for that.

When unloading module xen_netfront from guest, dmesg would output
warning messages like below:

  [  105.236836] xen:grant_table: WARNING: g.e. 0x903 still in use!
  [  105.236839] deferring g.e. 0x903 (pfn 0x35805)

This problem relies on netfront and netback being out of sync. By the time
netfront revokes the g.e.'s netback didn't have enough time to free all of
them, hence displaying the warnings on dmesg.

The trick here is to make netfront to wait until netback frees all the g.e.'s
and only then continue to cleanup for the module removal, and this is done by
manipulating both device states.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -86,6 +86,8 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
+static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
+
 struct netfront_stats {
 	u64			packets;
 	u64			bytes;
@@ -2037,10 +2039,12 @@ static void netback_changed(struct xenbu
 		break;
 
 	case XenbusStateClosed:
+		wake_up_all(&module_unload_q);
 		if (dev->state == XenbusStateClosed)
 			break;
 		/* Missed the backend's CLOSING state -- fallthrough */
 	case XenbusStateClosing:
+		wake_up_all(&module_unload_q);
 		xenbus_frontend_closed(dev);
 		break;
 	}
@@ -2146,6 +2150,20 @@ static int xennet_remove(struct xenbus_d
 
 	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
+	if (xenbus_read_driver_state(dev->otherend) != XenbusStateClosed) {
+		xenbus_switch_state(dev, XenbusStateClosing);
+		wait_event(module_unload_q,
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateClosing);
+
+		xenbus_switch_state(dev, XenbusStateClosed);
+		wait_event(module_unload_q,
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateClosed ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
+	}
+
 	xennet_disconnect_backend(info);
 
 	unregister_netdev(info->netdev);
