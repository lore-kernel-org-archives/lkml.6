Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591456-2-17799248257571836840
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
    t=1517591455; b=PstmrHyuQOm3peZd/RghBcEcGDt6f0zbADFTDjj5UROstfa
    a4BCjWjkQMscMRvHFEXoC+1D6toCx9tWgdhUmaGC/xU/BNT3z2QNMhFK+lSQCwNa
    2VV/n0iq+MBHJccN+goJYttBfqK/euzGFi3F5hfS4gOM2SgXwscJrinAwRt4eoMM
    ysDM+psKC8+wy5G7xKEHTrUPu6YBPbveaD5Q/7OyYZHAMSfsAPDQxX1iU3MhlOgs
    VTjbd5Wy7EUJXzNJoGKRwkMciM7H+YTfOqIkfozEGkwwabx+p+T19WPcAJokGeww
    Cevke47InZDTOYSELI8z7wvsTafENNHNy2VfDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591455; bh=G7t6Xf0dUWkCjNHWIH7z1/fyL4
    2h54PWFQOgh+tqAkw=; b=ZiXnqKR+rjJr6dGheAh4p/wMCCZk1d1QH3WnP6OjUx
    /M29kLIwT9qArtOgssz3mbevd2gp693s95Wkp7lljd8v9UWKaufRh/erVwzDgvqf
    vUy7h+7ejoSRj+V0a0oTen0iLX7pvQBvTFV5THJbzuJUHdWPH2F2jVmKMmyNvw7Y
    PbH0Vz+oDgWI+mbsRJqGsVbwOxy04dre8abngAEu1yOjtbWcES7WJfnKNQBgk5h3
    jaBgzWgkvP34CP6dr/MgFA3boLKSh+KTN1rJN0dXoT7xVPpKX+Y2ciWWWBFyn5A4
    ho68dVb3qUN0F1B7ta7JUXZuFVwX1C4fPwiz6hXkyrEw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeBBRKq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:10:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeBBRKo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:10:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Otubo <otubo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 083/156] xen-netfront: remove warning when unloading module
Date: Fri,  2 Feb 2018 17:57:44 +0100
Message-Id: <20180202140844.020505090@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -87,6 +87,8 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
+static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
+
 struct netfront_stats {
 	u64			packets;
 	u64			bytes;
@@ -2021,10 +2023,12 @@ static void netback_changed(struct xenbu
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
@@ -2130,6 +2134,20 @@ static int xennet_remove(struct xenbus_d
 
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
