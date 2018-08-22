Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8747D208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU/JgoJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8747D208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeHVUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:46:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44074 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeHVUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:46:19 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so4430467oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=3Tp7vypN8PuZv1fhf6/fVHodnM+37bTpx8LMX/r5oug=;
        b=XU/JgoJxXnFhkmsDpKuVdXC+wqHlyItkQUKY3o4NHGXUXYn0T6lxSgj9qjMco1lG/E
         37hcykOdn5xM7Fawq/aWrj0bxruiX4bCLpAqYHFTvdpxtn3oUKD7UXdzimdRtCQo7Kjr
         ylVV06gQpfFEIFhMiJiY/YTUi9idQyWavSBNRkJ+bck5V64xXaW0K67CT3QhMQX3mEgy
         O9j++SvG0nMTTH40TrvWJ59UNU8otDnUepuAao7s4MIBPoQcF30I1xDaOOhjSJT1h0WS
         EKzf5KZ3Q16wrzzc+tFWIzJWDhrWIlgqFvf5URS1SiSFDH844zxBxan6cDqCli/x3X6b
         E7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=3Tp7vypN8PuZv1fhf6/fVHodnM+37bTpx8LMX/r5oug=;
        b=cQ0no507Bech8pEGaCyFVtxl1u6v8GaL9xN1VYpMICKg+lIZ4SCHAyc8xV5qswNWqm
         hHA4L/jePBFb8Jgwk3xbaZobiUElCJpr54rM04/vIRhaB98E6jAcYITZDYUeezYYZywo
         pAUhTvlF0kcZNzm29nKWI4HqPfuF2myqcandqMhU/kjtGXck3EsCunoMyACdVp42CSZo
         2S9cCrhB4rIEmKYkdnkUSZmnDfYAIDRbAAZEMMOK+XDZ7TAXZpFa0wThbBzfBWo5FtAc
         VV9RbVC0yTeHEzT6+bwAsuCe9xbWpy/uOCMnMTJCdJ5HSBflS6HO5457KlGt7/laburo
         doNA==
X-Gm-Message-State: APzg51C0kQZR0x0QFJ8Kf+OjikaSEVTmz7h8yzuQQ58EJBMAu4Kybk4y
        eqf1WL1aL333lBXHMZ6xEA==
X-Google-Smtp-Source: ANB0Vda7lVqOBfh/GnU41Skd8/nA9LKn/nEr7bKRY8Zvmi+yGOjz9pYrZ5eGNE/B1Kouc5Vp3CCRHQ==
X-Received: by 2002:aca:c484:: with SMTP id u126-v6mr5114054oif.209.1534958433688;
        Wed, 22 Aug 2018 10:20:33 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id s145-v6sm3924581oih.16.2018.08.22.10.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:20:32 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 1218B776;
        Wed, 22 Aug 2018 12:20:32 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 41C503000CA; Wed, 22 Aug 2018 12:20:31 -0500 (CDT)
From:   minyard@acm.org
To:     Justin Ernst <justin.ernst@hpe.com>
Cc:     Corey Minyard <cminyard@mvista.com>,
        Andrew Banman <abanman@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Rework SMI registration failure
Date:   Wed, 22 Aug 2018 12:20:12 -0500
Message-Id: <1534958412-27199-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

There were certain situations where ipmi_register_smi() would
return a failure, but the interface would still be registered
and would need to be unregistered.  This is obviously a bad
design and resulted in an oops in certain failure cases.

If the interface is started up in ipmi_register_smi(), then
an error occurs, shut down the interface there so the
cleanup can be done properly.

Fix the various smi users, too.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reported-by: Justin Ernst <justin.ernst@hpe.com>
Cc: Andrew Banman <abanman@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: openipmi-developer@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/ipmi/ipmi_msghandler.c | 53 +++++++++++++++++++++----------------
 drivers/char/ipmi/ipmi_si_intf.c    | 17 +++---------
 drivers/char/ipmi/ipmi_ssif.c       | 13 +++------
 3 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 46ab1ba..04f64c5 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3378,39 +3378,45 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
 
 	rv = handlers->start_processing(send_info, intf);
 	if (rv)
-		goto out;
+		goto out_err;
 
 	rv = __bmc_get_device_id(intf, NULL, &id, NULL, NULL, i);
 	if (rv) {
 		dev_err(si_dev, "Unable to get the device id: %d\n", rv);
-		goto out;
+		goto out_err_started;
 	}
 
 	mutex_lock(&intf->bmc_reg_mutex);
 	rv = __scan_channels(intf, &id);
 	mutex_unlock(&intf->bmc_reg_mutex);
+	if (rv)
+		goto out_err_bmc_reg;
 
- out:
-	if (rv) {
-		ipmi_bmc_unregister(intf);
-		list_del_rcu(&intf->link);
-		mutex_unlock(&ipmi_interfaces_mutex);
-		synchronize_srcu(&ipmi_interfaces_srcu);
-		cleanup_srcu_struct(&intf->users_srcu);
-		kref_put(&intf->refcount, intf_free);
-	} else {
-		/*
-		 * Keep memory order straight for RCU readers.  Make
-		 * sure everything else is committed to memory before
-		 * setting intf_num to mark the interface valid.
-		 */
-		smp_wmb();
-		intf->intf_num = i;
-		mutex_unlock(&ipmi_interfaces_mutex);
+	/*
+	 * Keep memory order straight for RCU readers.  Make
+	 * sure everything else is committed to memory before
+	 * setting intf_num to mark the interface valid.
+	 */
+	smp_wmb();
+	intf->intf_num = i;
+	mutex_unlock(&ipmi_interfaces_mutex);
 
-		/* After this point the interface is legal to use. */
-		call_smi_watchers(i, intf->si_dev);
-	}
+	/* After this point the interface is legal to use. */
+	call_smi_watchers(i, intf->si_dev);
+
+	return 0;
+
+ out_err_bmc_reg:
+	ipmi_bmc_unregister(intf);
+ out_err_started:
+	if (intf->handlers->shutdown)
+		intf->handlers->shutdown(intf->send_info);
+ out_err:
+	list_del_rcu(&intf->link);
+	mutex_unlock(&ipmi_interfaces_mutex);
+	synchronize_srcu(&ipmi_interfaces_srcu);
+	cleanup_srcu_struct(&intf->users_srcu);
+	kref_put(&intf->refcount, intf_free);
 
 	return rv;
 }
@@ -3501,7 +3507,8 @@ void ipmi_unregister_smi(struct ipmi_smi *intf)
 	}
 	srcu_read_unlock(&intf->users_srcu, index);
 
-	intf->handlers->shutdown(intf->send_info);
+	if (intf->handlers->shutdown)
+		intf->handlers->shutdown(intf->send_info);
 
 	cleanup_smi_msgs(intf);
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 2194b4c..bb7d8af 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2102,18 +2102,9 @@ static int try_smi_init(struct smi_info *new_smi)
 		 si_to_str[new_smi->io.si_type]);
 
 	WARN_ON(new_smi->io.dev->init_name != NULL);
-	kfree(init_name);
-
-	return 0;
-
-out_err:
-	if (new_smi->intf) {
-		ipmi_unregister_smi(new_smi->intf);
-		new_smi->intf = NULL;
-	}
 
+ out_err:
 	kfree(init_name);
-
 	return rv;
 }
 
@@ -2246,6 +2237,8 @@ static void shutdown_smi(void *send_info)
 
 	kfree(smi_info->si_sm);
 	smi_info->si_sm = NULL;
+
+	smi_info->intf = NULL;
 }
 
 /*
@@ -2259,10 +2252,8 @@ static void cleanup_one_si(struct smi_info *smi_info)
 
 	list_del(&smi_info->link);
 
-	if (smi_info->intf) {
+	if (smi_info->intf)
 		ipmi_unregister_smi(smi_info->intf);
-		smi_info->intf = NULL;
-	}
 
 	if (smi_info->pdev) {
 		if (smi_info->pdev_registered)
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index fddf646..3574322 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1218,18 +1218,11 @@ static void shutdown_ssif(void *send_info)
 		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
 	}
-
-	/*
-	 * No message can be outstanding now, we have removed the
-	 * upper layer and it permitted us to do so.
-	 */
-	kfree(ssif_info);
 }
 
 static int ssif_remove(struct i2c_client *client)
 {
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
-	struct ipmi_smi *intf;
 	struct ssif_addr_info *addr_info;
 
 	if (!ssif_info)
@@ -1239,9 +1232,7 @@ static int ssif_remove(struct i2c_client *client)
 	 * After this point, we won't deliver anything asychronously
 	 * to the message handler.  We can unregister ourself.
 	 */
-	intf = ssif_info->intf;
-	ssif_info->intf = NULL;
-	ipmi_unregister_smi(intf);
+	ipmi_unregister_smi(ssif_info->intf);
 
 	list_for_each_entry(addr_info, &ssif_infos, link) {
 		if (addr_info->client == client) {
@@ -1250,6 +1241,8 @@ static int ssif_remove(struct i2c_client *client)
 		}
 	}
 
+	kfree(ssif_info);
+
 	return 0;
 }
 
-- 
2.7.4

