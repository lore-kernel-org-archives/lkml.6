Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3551175-1522955384-2-7052977927753889413
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522955383; b=oayoqtP5wbQde994SPgMXpRlpdTvjh72+OYDIHauulsEhHj8bK
    7NuaSbknyNxmrf/9wgu9gwQbgNnRWm/SHPjz5LEkV1k0NosI9koRhA++d+riRq7W
    qxNnQIsDPA0t8GJ+yK5KuKGLZT+LPB7ESPBpD7V2JQXH0WwUsnmpRZVJLNVSnJNh
    i3Lyi8l4ypZmdkg4R5n10C6HEa5NvCWHH3LvXv4NTspO7ePozbNSpa3FWOmQc5Gg
    l3xYhI2vwhyOjqTi9vKuRbaubnwa+lyfeezAdYf+z36lgJarLexUUB3lk6grcLru
    1pgtgH8+p45dDPjEEzp3ZjaN2N+ksADzwo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522955383; bh=753Ru
    Ku9n1UU+uWGPPiqxyyaHf0CIF9ToX2CjGCC8zU=; b=RDjQPVe9mCm8VU7XOTa2V
    xfE4EvmRDqFksaDinxqam1xlGSNShWwbgz5AbNRitpFFekMe97c0W2PQ8hitQCKf
    NnC5IIYkGT09Lau+GcWiJL9tZ/bPLCCXiJmlbYaNUIP0FpnoLNQ9nLFWIPJ+lCAo
    /orfphmeX2BQHO4vVVX7wdxrIl5kZv914okJ2a+KwGPbNqTMHfipEnq85ZlJ/W1p
    4T8sBzaoyyP9Jhm6p6voqJbmlqd0t/XMxkZGpWLxxGalD7VgLIqXINabkFOjMIHd
    Bd1FEo15T3mv9DNe/XdqvTk1RouIjnMYtZ0lZpebj4UJ4dpTiXo/NYxVuFrh4913
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEoO2xB4nRemlbnLnA7tJb7dDB94PumIe5wB000VDp3/gxueepGMzzeESABnusR5DBFt3SqdcW1vZJjKYdzrytn43PDjFaw4U0sZ9oiQPGPH7j5meRpg
    HdOGmYiXDGyh6PrFL86WMGJIqw6dccJi/xWdrJljlk84jW0gbqUY9LdvoXPmAefR8OfkUo0w4XQ3h6TpvjNBxCd6X6qC2mJYgBO6yn6Y6f8f5dcOcZiS9LqV
    0zf++E/6qRz5JBwSC4sqWg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=v3FFNli1-A-kmIJrd-kA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org,
	sthemmin@microsoft.com
Subject: [PATCH 3/4] hv_netvsc: Ensure correct teardown message sequence order
Date: Thu,  5 Apr 2018 21:09:20 +0200
Message-Id: <1522955361-14704-4-git-send-email-mgamal@redhat.com>
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

Prior to commit 0cf737808ae7 ("hv_netvsc: netvsc_teardown_gpadl() split")
the call sequence in netvsc_device_remove() was as follows (as
implemented in netvsc_destroy_buf()):
1- Send NVSP_MSG1_TYPE_REVOKE_RECV_BUF message
2- Teardown receive buffer GPADL
3- Send NVSP_MSG1_TYPE_REVOKE_SEND_BUF message
4- Teardown send buffer GPADL
5- Close vmbus

This didn't work for WS2016 hosts. Commit 0cf737808ae7
("hv_netvsc: netvsc_teardown_gpadl() split") rearranged the
teardown sequence as follows:
1- Send NVSP_MSG1_TYPE_REVOKE_RECV_BUF message
2- Send NVSP_MSG1_TYPE_REVOKE_SEND_BUF message
3- Close vmbus
4- Teardown receive buffer GPADL
5- Teardown send buffer GPADL

That worked well for WS2016 hosts, but it prevented guests on older hosts from
shutting down after changing network settings. Commit 0ef58b0a05c1
("hv_netvsc: change GPAD teardown order on older versions") ensured the
following message sequence for older hosts
1- Send NVSP_MSG1_TYPE_REVOKE_RECV_BUF message
2- Send NVSP_MSG1_TYPE_REVOKE_SEND_BUF message
3- Teardown receive buffer GPADL
4- Teardown send buffer GPADL
5- Close vmbus

However, with this sequence calling `ip link set eth0 mtu 1000` hangs and the
process becomes uninterruptible. On futher analysis it turns out that on tearing
down the receive buffer GPADL the kernel is waiting indefinitely
in vmbus_teardown_gpadl() for a completion to be signaled.

Here is a snippet of where this occurs:
int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
{
        struct vmbus_channel_gpadl_teardown *msg;
        struct vmbus_channel_msginfo *info;
        unsigned long flags;
        int ret;

        info = kmalloc(sizeof(*info) +
                       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
        if (!info)
                return -ENOMEM;

        init_completion(&info->waitevent);
        info->waiting_channel = channel;
[....]
        ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_gpadl_teardown),
                             true);

        if (ret)
                goto post_msg_err;

        wait_for_completion(&info->waitevent);
[....]
}

The completion is signaled from vmbus_ongpadl_torndown(), which gets called when
the corresponding message is received from the host, which apparently never happens
in that case.
This patch works around the issue by restoring the first mentioned message sequence
for older hosts

Fixes: 0ef58b0a05c1 ("hv_netvsc: change GPAD teardown order on older versions")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/netvsc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index f4df5de..df92c2f 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -592,8 +592,17 @@ void netvsc_device_remove(struct hv_device *device)
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
+	/*
+	 * Revoke receive buffer. If host is pre-Win2016 then tear down
+	 * receive buffer GPADL. Do the same for send buffer.
+	 */
 	netvsc_revoke_recv_buf(device, net_device);
+	if (vmbus_proto_version < VERSION_WIN10)
+		netvsc_teardown_recv_gpadl(device, net_device);
+
 	netvsc_revoke_send_buf(device, net_device);
+	if (vmbus_proto_version < VERSION_WIN10)
+		netvsc_teardown_send_gpadl(device, net_device);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -607,15 +616,13 @@ void netvsc_device_remove(struct hv_device *device)
 	 */
 	netdev_dbg(ndev, "net device safe to remove\n");
 
-	/* older versions require that buffer be revoked before close */
-	if (vmbus_proto_version < VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device);
-		netvsc_teardown_send_gpadl(device, net_device);
-	}
-
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
+	/*
+	 * If host is Win2016 or higher then we do the GPADL tear down
+	 * here after VMBus is closed.
+	*/
 	if (vmbus_proto_version >= VERSION_WIN10) {
 		netvsc_teardown_recv_gpadl(device, net_device);
 		netvsc_teardown_send_gpadl(device, net_device);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
