Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3549775-1522955385-2-8183489151755427157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522955384; b=KCVqCDSNF9TESMNWMCrQHhDwHYSda4tfrejiOZD+VaqTK6oahb
    WC0X6GGhjHn00DSELmNOSjZ+Ae0y8Du8mTmW3xuMuFBfvicL8oYcgABEEjzVwWgZ
    nRLNxUyxYtcQ1jINZaAxJg8Pl9XOyb2mBTzDOHf8jPrUb28cf8mHtxAt2RtM3J7c
    WKhgeqbW/jC26Ei0G31o9WzUyzpZYQXjfgt+yy0nLjkq5NcXysF+b2SQ66OBDvW8
    h71paA/GLtW2M1EuCzsvFafYlrkRSyxa1jSfO4JGv8xp3SZaoPyRfLy08NjYA0sx
    UWTb2dcfPOUlEqaXBsmEQ7KdomFW8HlMAIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522955384; bh=+tnOt
    cQvKKO8A7cKwyOaUgqv85UIrVbKmVwQ2kun3EU=; b=Y6ImYszATt62hyT+uQ6vQ
    aJPxZWSJuWlTl9N0UYWTHewL1GE7+IIibEYm99kQKh+Wd+Z8I0jGJ4Ev59NbryRM
    HxgzfsYYZsLFNqcJTdGzcUcPL+2smQU6iH3xMM53xDhaZBzPp5IAJHwPm2IK9pt+
    HvQRgITRO/j1nzHLmQz1E3snwSdWMY7lx30Zbp7lPfRVk8ibvbrniNFW/ko4iDpc
    LKxT/gEXmC14oBseU0zXkbg0S5KaPkO3tfuE/3cHI/CwdmSgKXTqsNEmNU9Bq5Z2
    NX7sfk1Q9JaIGkUeiEx0mCyBL9nqZpG8unkHuaczStQ1Yf/iCJkckkPu7NjfBWYq
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCVzqxjWrmspXWLdaj+GaJNtPw0l5IpqXOUT9StXP14ni8+TwCyjA8Oz+HQV5tv+0Kn4ne9BVAi8Qi+cV/cSrE7D8tuxwwnU83mzQ8Psl20DZ8/TgVJ/
    GmzwdtyEnmZtXYTpygc/Mg0of7I6zcaXat6jFtSmSZTdo4a/PoAglD7QHraXTKqy/NK0xNcUvE5oPPpPNTf/VIWpl8eHFDUUmeK0b5hSRg/7JaCsTdrIgf7O
    2wTtAb9uTk5tqWNHbYp2Ew==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=l5hsKEwYleRh9GI1Hl0A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org,
	sthemmin@microsoft.com
Subject: [PATCH 2/4] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
Date: Thu,  5 Apr 2018 21:09:19 +0200
Message-Id: <1522955361-14704-3-git-send-email-mgamal@redhat.com>
In-Reply-To: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
References: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: otubo@redhat.com, Mohammed Gamal <mgamal@redhat.com>,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Split each of the functions into two for each of send/recv buffers.
This will be needed in order to implement a fine-grained messaging
sequence to the host so tht we accommodate the requirements of
different Windows versions

Fixes: 0ef58b0a05c12 ("hv_netvsc: change GPAD teardown order on older versions")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/netvsc.c | 46 +++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index d65b7fc..f4df5de 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -109,11 +109,11 @@ static void free_netvsc_device_rcu(struct netvsc_device *nvdev)
 	call_rcu(&nvdev->rcu, free_netvsc_device);
 }
 
-static void netvsc_revoke_buf(struct hv_device *device,
-			      struct netvsc_device *net_device)
+static void netvsc_revoke_recv_buf(struct hv_device *device,
+				   struct netvsc_device *net_device)
 {
-	struct nvsp_message *revoke_packet;
 	struct net_device *ndev = hv_get_drvdata(device);
+	struct nvsp_message *revoke_packet;
 	int ret;
 
 	/*
@@ -157,6 +157,14 @@ static void netvsc_revoke_buf(struct hv_device *device,
 		}
 		net_device->recv_section_cnt = 0;
 	}
+}
+
+static void netvsc_revoke_send_buf(struct hv_device *device,
+				   struct netvsc_device *net_device)
+{
+	struct net_device *ndev = hv_get_drvdata(device);
+	struct nvsp_message *revoke_packet;
+	int ret;
 
 	/* Deal with the send buffer we may have setup.
 	 * If we got a  send section size, it means we received a
@@ -202,8 +210,8 @@ static void netvsc_revoke_buf(struct hv_device *device,
 	}
 }
 
-static void netvsc_teardown_gpadl(struct hv_device *device,
-				  struct netvsc_device *net_device)
+static void netvsc_teardown_recv_gpadl(struct hv_device *device,
+				       struct netvsc_device *net_device)
 {
 	struct net_device *ndev = hv_get_drvdata(device);
 	int ret;
@@ -222,6 +230,13 @@ static void netvsc_teardown_gpadl(struct hv_device *device,
 		}
 		net_device->recv_buf_gpadl_handle = 0;
 	}
+}
+
+static void netvsc_teardown_send_gpadl(struct hv_device *device,
+				       struct netvsc_device *net_device)
+{
+	struct net_device *ndev = hv_get_drvdata(device);
+	int ret;
 
 	if (net_device->send_buf_gpadl_handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
@@ -437,8 +452,10 @@ static int netvsc_init_buf(struct hv_device *device,
 	goto exit;
 
 cleanup:
-	netvsc_revoke_buf(device, net_device);
-	netvsc_teardown_gpadl(device, net_device);
+	netvsc_revoke_recv_buf(device, net_device);
+	netvsc_revoke_send_buf(device, net_device);
+	netvsc_teardown_recv_gpadl(device, net_device);
+	netvsc_teardown_send_gpadl(device, net_device);
 
 exit:
 	return ret;
@@ -575,7 +592,8 @@ void netvsc_device_remove(struct hv_device *device)
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
-	netvsc_revoke_buf(device, net_device);
+	netvsc_revoke_recv_buf(device, net_device);
+	netvsc_revoke_send_buf(device, net_device);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -590,14 +608,18 @@ void netvsc_device_remove(struct hv_device *device)
 	netdev_dbg(ndev, "net device safe to remove\n");
 
 	/* older versions require that buffer be revoked before close */
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_gpadl(device, net_device);
+	if (vmbus_proto_version < VERSION_WIN10) {
+		netvsc_teardown_recv_gpadl(device, net_device);
+		netvsc_teardown_send_gpadl(device, net_device);
+	}
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	if (vmbus_proto_version >= VERSION_WIN10)
-		netvsc_teardown_gpadl(device, net_device);
+	if (vmbus_proto_version >= VERSION_WIN10) {
+		netvsc_teardown_recv_gpadl(device, net_device);
+		netvsc_teardown_send_gpadl(device, net_device);
+	}
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
