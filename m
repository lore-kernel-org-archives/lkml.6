Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF03DC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785B82147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="UxuD8gtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785B82147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJFOFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:05:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38379 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeJFOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:05:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so3730083wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2uqQivxUj3OiUwQpqgieWictLuZuTTte+K4s5sF9Oo=;
        b=UxuD8gtl1dEW7uDszjJ9z+cYH2kD0BxMBLfZGGT2k0N/DVFjS1wOP79zzhaC3u/Vz6
         HAdZ8PtxlAB6LpAnOw6ib9jt+FkdutCQ+B3O0gtF7P8KcrqPeP8BqUMY5v8Rnwou+HML
         BL8ND3mAsOiu8vEzQV8hxBAGGDeGZDTUNi9B6JbHo47kjggmJdQ5kAoOU95LHivwiOII
         PeNc9FmdBMxC6qI4QP1CCzh5SolH4aieBOKxUtktbbYvB7raImWqbKPaZkle+kaDreM6
         aStoNm5o3ESohciYD+iICcGk1r2rXh1XJmcJHPq8G+4TpI9uzupJ8mf8fRyx9VQqLVLT
         Nj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2uqQivxUj3OiUwQpqgieWictLuZuTTte+K4s5sF9Oo=;
        b=QDa6AhP3OpkyraChYOdqVSgx1WYZePq6vxH4yOvNAadTNlEDGd4MwhxMb3Es5v+qO/
         vXOt5Uf415x5seQSsJ6Xf9vdV4W9kKBROXIgqHGhZDa3L/frzqQSNQ/J4XeqREKecpJ1
         KCZ1GeMBNq56q/P6XqpyTDGhzk2AYId5xKba8zNm7LWJpt6ywFHR8t305SMbrYnrRlCs
         0gN2yPxDBQvdjeu1b99GNvYb7H57S0/dlmoSnaS/SzBFhZJ7yQANJBCO6OvsX/S8Ofgw
         VtvH2+1H3aFI6wmbm/bcpja4DkOwhoyrXJPuLYayp56RR8QwC5HY+8HpcZBPNKAeozY2
         FPuA==
X-Gm-Message-State: ABuFfoiFwlP6eDKdnyuOs28TqGmo7aztZmw1t8wYMowCUYIJNHd1MhRz
        fG3O8bKIo2N01j0IM5Tl1o4l9Q==
X-Google-Smtp-Source: ACcGV63aYAfifwfztIMyBrr/+aO50aIIqv1D6Eea8RGuUeYgO8axQ1slaW+Vab1PRyvhdT6CBvQi2A==
X-Received: by 2002:a1c:a1c6:: with SMTP id k189-v6mr10427486wme.0.1538809413594;
        Sat, 06 Oct 2018 00:03:33 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id i15-v6sm6118488wro.58.2018.10.06.00.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 00:03:33 -0700 (PDT)
Date:   Sat, 6 Oct 2018 08:58:19 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181006065819.GD3061@nanopsycho.orion>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006025709.4019-29-Jason@zx2c4.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Oct 06, 2018 at 04:57:09AM CEST, Jason@zx2c4.com wrote:

[...]

>+}
>+
>+static const struct net_device_ops netdev_ops = {
>+	.ndo_open		= open,
>+	.ndo_stop		= stop,
>+	.ndo_start_xmit		= xmit,

It would be nice to put the callbacks and other functions in this file
into a namespace by some common prefix.
If one sees "open/stop/xmit/destruct/setup/..." in a trace, that does
not tell much :/



>+	.ndo_get_stats64	= ip_tunnel_get_stats64
>+};
>+
>+static void destruct(struct net_device *dev)
>+{
>+	struct wireguard_device *wg = netdev_priv(dev);
>+
>+	rtnl_lock();
>+	list_del(&wg->device_list);
>+	rtnl_unlock();
>+	mutex_lock(&wg->device_update_lock);
>+	wg->incoming_port = 0;
>+	wg_socket_reinit(wg, NULL, NULL);
>+	wg_allowedips_free(&wg->peer_allowedips, &wg->device_update_lock);
>+	/* The final references are cleared in the below calls to destroy_workqueue. */
>+	wg_peer_remove_all(wg);
>+	destroy_workqueue(wg->handshake_receive_wq);
>+	destroy_workqueue(wg->handshake_send_wq);
>+	destroy_workqueue(wg->packet_crypt_wq);
>+	wg_packet_queue_free(&wg->decrypt_queue, true);
>+	wg_packet_queue_free(&wg->encrypt_queue, true);
>+	rcu_barrier_bh(); /* Wait for all the peers to be actually freed. */
>+	wg_ratelimiter_uninit();
>+	memzero_explicit(&wg->static_identity, sizeof(wg->static_identity));
>+	skb_queue_purge(&wg->incoming_handshakes);
>+	free_percpu(dev->tstats);
>+	free_percpu(wg->incoming_handshakes_worker);
>+	if (wg->have_creating_net_ref)
>+		put_net(wg->creating_net);
>+	mutex_unlock(&wg->device_update_lock);
>+
>+	pr_debug("%s: Interface deleted\n", dev->name);
>+	free_netdev(dev);
>+}
>+
>+static const struct device_type device_type = { .name = KBUILD_MODNAME };
>+
>+static void setup(struct net_device *dev)
>+{
>+	struct wireguard_device *wg = netdev_priv(dev);
>+	enum { WG_NETDEV_FEATURES = NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>+				    NETIF_F_SG | NETIF_F_GSO |
>+				    NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA };
>+
>+	dev->netdev_ops = &netdev_ops;
>+	dev->hard_header_len = 0;
>+	dev->addr_len = 0;
>+	dev->needed_headroom = DATA_PACKET_HEAD_ROOM;
>+	dev->needed_tailroom = noise_encrypted_len(MESSAGE_PADDING_MULTIPLE);
>+	dev->type = ARPHRD_NONE;
>+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
>+	dev->priv_flags |= IFF_NO_QUEUE;
>+	dev->features |= NETIF_F_LLTX;
>+	dev->features |= WG_NETDEV_FEATURES;
>+	dev->hw_features |= WG_NETDEV_FEATURES;
>+	dev->hw_enc_features |= WG_NETDEV_FEATURES;
>+	dev->mtu = ETH_DATA_LEN - MESSAGE_MINIMUM_LENGTH -
>+		   sizeof(struct udphdr) -
>+		   max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
>+
>+	SET_NETDEV_DEVTYPE(dev, &device_type);
>+
>+	/* We need to keep the dst around in case of icmp replies. */
>+	netif_keep_dst(dev);
>+
>+	memset(wg, 0, sizeof(*wg));
>+	wg->dev = dev;
>+}
>+
>+static int newlink(struct net *src_net, struct net_device *dev,
>+		   struct nlattr *tb[], struct nlattr *data[],
>+		   struct netlink_ext_ack *extack)
>+{
>+	int ret = -ENOMEM;
>+	struct wireguard_device *wg = netdev_priv(dev);
>+
>+	wg->creating_net = src_net;
>+	init_rwsem(&wg->static_identity.lock);
>+	mutex_init(&wg->socket_update_lock);
>+	mutex_init(&wg->device_update_lock);
>+	skb_queue_head_init(&wg->incoming_handshakes);
>+	wg_pubkey_hashtable_init(&wg->peer_hashtable);
>+	wg_index_hashtable_init(&wg->index_hashtable);
>+	wg_allowedips_init(&wg->peer_allowedips);
>+	wg_cookie_checker_init(&wg->cookie_checker, wg);
>+	INIT_LIST_HEAD(&wg->peer_list);
>+	wg->device_update_gen = 1;
>+
>+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
>+	if (!dev->tstats)
>+		goto error_1;

Just "return -ENOMEM" here.

>+
>+	wg->incoming_handshakes_worker =
>+		wg_packet_alloc_percpu_multicore_worker(
>+				wg_packet_handshake_receive_worker, wg);
>+	if (!wg->incoming_handshakes_worker)
>+		goto error_2;


Please consider renaming the label to "what went wrong". In this case,
it would be "err_alloc_worker".


>+
>+	wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
>+			WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
>+	if (!wg->handshake_receive_wq)
>+		goto error_3;
>+
>+	wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
>+			WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
>+	if (!wg->handshake_send_wq)
>+		goto error_4;
>+
>+	wg->packet_crypt_wq = alloc_workqueue("wg-crypt-%s",
>+			WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
>+	if (!wg->packet_crypt_wq)
>+		goto error_5;
>+
>+	if (wg_packet_queue_init(&wg->encrypt_queue, wg_packet_encrypt_worker,
>+				 true, MAX_QUEUED_PACKETS) < 0)

You need to have "int err" and always in cases like this to do:
err = wg_packet_queue_init()
if (err)
	goto err_*


>+		goto error_6;
>+
>+	if (wg_packet_queue_init(&wg->decrypt_queue, wg_packet_decrypt_worker,
>+				 true, MAX_QUEUED_PACKETS) < 0)
>+		goto error_7;
>+
>+	ret = wg_ratelimiter_init();
>+	if (ret < 0)
>+		goto error_8;
>+
>+	ret = register_netdevice(dev);
>+	if (ret < 0)
>+		goto error_9;
>+
>+	list_add(&wg->device_list, &device_list);
>+
>+	/* We wait until the end to assign priv_destructor, so that
>+	 * register_netdevice doesn't call it for us if it fails.
>+	 */
>+	dev->priv_destructor = destruct;
>+
>+	pr_debug("%s: Interface created\n", dev->name);
>+	return ret;
>+
>+error_9:
>+	wg_ratelimiter_uninit();
>+error_8:
>+	wg_packet_queue_free(&wg->decrypt_queue, true);
>+error_7:
>+	wg_packet_queue_free(&wg->encrypt_queue, true);
>+error_6:
>+	destroy_workqueue(wg->packet_crypt_wq);
>+error_5:
>+	destroy_workqueue(wg->handshake_send_wq);
>+error_4:
>+	destroy_workqueue(wg->handshake_receive_wq);
>+error_3:
>+	free_percpu(wg->incoming_handshakes_worker);
>+error_2:
>+	free_percpu(dev->tstats);
>+error_1:
>+	return ret;
>+}
>+
>+static struct rtnl_link_ops link_ops __read_mostly = {
>+	.kind			= KBUILD_MODNAME,
>+	.priv_size		= sizeof(struct wireguard_device),
>+	.setup			= setup,
>+	.newlink		= newlink,
>+};
>+
>+static int netdevice_notification(struct notifier_block *nb,
>+				  unsigned long action, void *data)
>+{
>+	struct net_device *dev = ((struct netdev_notifier_info *)data)->dev;
>+	struct wireguard_device *wg = netdev_priv(dev);
>+
>+	ASSERT_RTNL();
>+
>+	if (action != NETDEV_REGISTER || dev->netdev_ops != &netdev_ops)
>+		return 0;
>+
>+	if (dev_net(dev) == wg->creating_net && wg->have_creating_net_ref) {
>+		put_net(wg->creating_net);
>+		wg->have_creating_net_ref = false;
>+	} else if (dev_net(dev) != wg->creating_net &&
>+		   !wg->have_creating_net_ref) {
>+		wg->have_creating_net_ref = true;
>+		get_net(wg->creating_net);
>+	}
>+	return 0;
>+}
>+
>+static struct notifier_block netdevice_notifier = {
>+	.notifier_call = netdevice_notification
>+};
>+
>+int __init wg_device_init(void)
>+{
>+	int ret;
>+
>+#if defined(CONFIG_PM_SLEEP) && !defined(CONFIG_ANDROID)
>+	ret = register_pm_notifier(&pm_notifier);
>+	if (ret)
>+		return ret;
>+#endif
>+
>+	ret = register_netdevice_notifier(&netdevice_notifier);
>+	if (ret)
>+		goto error_pm;
>+
>+	ret = rtnl_link_register(&link_ops);
>+	if (ret)
>+		goto error_netdevice;
>+
>+	return 0;
>+
>+error_netdevice:
>+	unregister_netdevice_notifier(&netdevice_notifier);
>+error_pm:
>+#if defined(CONFIG_PM_SLEEP) && !defined(CONFIG_ANDROID)
>+	unregister_pm_notifier(&pm_notifier);
>+#endif
>+	return ret;
>+}
>+
>+void wg_device_uninit(void)
>+{
>+	rtnl_link_unregister(&link_ops);
>+	unregister_netdevice_notifier(&netdevice_notifier);
>+#if defined(CONFIG_PM_SLEEP) && !defined(CONFIG_ANDROID)
>+	unregister_pm_notifier(&pm_notifier);
>+#endif
>+	rcu_barrier_bh();
>+}
>diff --git a/drivers/net/wireguard/device.h b/drivers/net/wireguard/device.h
>new file mode 100644
>index 000000000000..2bd1429b5831
>--- /dev/null
>+++ b/drivers/net/wireguard/device.h
>@@ -0,0 +1,65 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/*
>+ * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>+ */
>+
>+#ifndef _WG_DEVICE_H
>+#define _WG_DEVICE_H
>+
>+#include "noise.h"
>+#include "allowedips.h"
>+#include "hashtables.h"
>+#include "cookie.h"
>+
>+#include <linux/types.h>
>+#include <linux/netdevice.h>
>+#include <linux/workqueue.h>
>+#include <linux/mutex.h>
>+#include <linux/net.h>
>+#include <linux/ptr_ring.h>
>+
>+struct wireguard_device;
>+
>+struct multicore_worker {
>+	void *ptr;
>+	struct work_struct work;
>+};
>+
>+struct crypt_queue {

Similar to structure names. Please consider having a single prefix for
the struct and func names.


>+	struct ptr_ring ring;
>+	union {
>+		struct {
>+			struct multicore_worker __percpu *worker;
>+			int last_cpu;
>+		};
>+		struct work_struct work;
>+	};
>+};
>+
>+struct wireguard_device {

This is inconsistent. "wireguard_device" vs "wg_*". The name should be
rather something like "wg_device".


>+	struct net_device *dev;
>+	struct crypt_queue encrypt_queue, decrypt_queue;
>+	struct sock __rcu *sock4, *sock6;
>+	struct net *creating_net;
>+	struct noise_static_identity static_identity;
>+	struct workqueue_struct *handshake_receive_wq, *handshake_send_wq;
>+	struct workqueue_struct *packet_crypt_wq;
>+	struct sk_buff_head incoming_handshakes;
>+	int incoming_handshake_cpu;
>+	struct multicore_worker __percpu *incoming_handshakes_worker;
>+	struct cookie_checker cookie_checker;
>+	struct pubkey_hashtable peer_hashtable;
>+	struct index_hashtable index_hashtable;
>+	struct allowedips peer_allowedips;
>+	struct mutex device_update_lock, socket_update_lock;
>+	struct list_head device_list, peer_list;
>+	unsigned int num_peers, device_update_gen;
>+	u32 fwmark;
>+	u16 incoming_port;
>+	bool have_creating_net_ref;
>+};


[...]


>+static int __init mod_init(void)
>+{
>+	int ret;
>+
>+#ifdef DEBUG
>+	if (!wg_allowedips_selftest() || !wg_packet_counter_selftest() ||
>+	    !wg_ratelimiter_selftest())
>+		return -ENOTRECOVERABLE;
>+#endif
>+	wg_noise_init();
>+
>+	ret = wg_device_init();
>+	if (ret < 0)
>+		goto err_device;
>+
>+	ret = wg_genetlink_init();
>+	if (ret < 0)
>+		goto err_netlink;
>+
>+	pr_info("WireGuard " WIREGUARD_VERSION " loaded. See www.wireguard.com for information.\n");
>+	pr_info("Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.\n");

It is not common to have this output for new modules. Please remove,
does not tell anything to the user.


>+
>+	return 0;
>+
>+err_netlink:
>+	wg_device_uninit();
>+err_device:
>+	return ret;
>+}
>+
>+static void __exit mod_exit(void)
>+{
>+	wg_genetlink_uninit();
>+	wg_device_uninit();
>+	pr_debug("WireGuard unloaded\n");

Same here.

>+}
>+
>+module_init(mod_init);
>+module_exit(mod_exit);
>+MODULE_LICENSE("GPL v2");
>+MODULE_DESCRIPTION("Fast, modern, and secure VPN tunnel");

Descrioption should be rather somethin like "WireGuard tunnel".


>+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
>+MODULE_VERSION(WIREGUARD_VERSION);
>+MODULE_ALIAS_RTNL_LINK(KBUILD_MODNAME);
>+MODULE_ALIAS_GENL_FAMILY(WG_GENL_NAME);

[...]

