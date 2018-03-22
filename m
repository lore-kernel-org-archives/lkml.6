Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449376-1521745370-2-386778110218177691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521745370; b=w0Z27lNKeN1rO6x6EYm3++u6/f+SuJsicgiHrKOXOc3bUDM
    jzkNP++skpX6pWaMAkqVFLtUy4LgIYihggx9zxNAZ1dsxU71GFIxufg9k/unp78b
    cOc6hGDY/McmRWdqWbDDLGsJtPaZPUfzZfo2QWW+2sSKQQrCcURzocWpBPIL7YYc
    a1k8Q3dAGt3GNCyi3hqQNVwdHy+qI/UaDyA9SgN35Eqrx9MH108iVAAO1jXstKcB
    x9+0j+xH84DBAJbWL/uFKnNrlcH/nSV+dZhXod2s/7UMNbVzLYwOb6ZsYypr2MZb
    /ew22DqU+gTxIqUWnhBL3MVPVhI8yGeoHS1uCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1521745370; bh=MppoiDn1fz3Mwj3VVdInx2Bc4R2W2B1h1EGatRdU6Zo=; b=T
    hebL2vC/FVcysm4AHsWZ2qYlhhFAeVgMONeFDSrujVnqSOgUUq+oiZQqLbQ+yb+W
    QsoJQpNCE8YkxWM6YffcNKt/S8DqJ2q26sJTxw1jSX6OcdrNKlbd4pBPYQ1ItwDd
    lBk6D6V8G/P90X3R/Fv0yKiIY/W8X8eS1UOe98g61c0JjfnNL56P+dpit1m5Odq9
    xLsWGgcJdY69aiAIWYZMMcAfLXtmmQ2k7Bf1BdSOc/lFAmqy0QRZYKnWVT6C1igT
    uAMUePeAqfnng5SAUTU0RFcGP9yFWirEi9hydqfro+NXrmjfbkjjegSw5CaziiAc
    hkLB0kkvu1GbQ6slIZM+Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next,
 2/2] hv_netvsc: Add range checking for rx packet offset and length
Date: Thu, 22 Mar 2018 12:01:14 -0700
Message-Id: <20180322190114.25596-3-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfHbe4/74bfcMPSeVBqtFrtu6hFraVOnLlQDtrO+Lx2eWE6wh3E/+zkHarjj7xWlxgTXw56Y9QQcNmWWhsWIAV18i1F5LNsKi9ckoPCMGCubTAZixOx9v
 CFsOcRK9S9IEJYg45aFCr3JYw54vXd/D9YGlnKWYZnIgo+/eZDh5x+S5Ti3mWSlJXAFLrGMpu97Tptdknjnozn/+3ZwehCFXZ989O73BLk7T3bh5/vpmlhnf
 GWddrkHHW+W82GX43dRTpaC5btrQx9cCgQr54Pb1uABD/KCUK1JkhNCnXSEcCA9c22CNFjJSqjUaGJ8Gwdszth7VAcvLp7O+p0eXVdGUfQMP40LAvnB9vsyP
 nyIv4b7TgcD5GN0QiAAEYdw0L5zmI+3s8x4jNAIE6Hi0uc2EDWAcG4JCNP9gZ8tjdbl8QehfD5UfhShWqQVFwKc4+YOUy/oDKvKwbzJ3LshOTMiUK+wn+ET1
 GMjjU7pR9Kkucw+m9fVlkOacxlRpXU7gSOQIdQ==
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
Reply-To: haiyangz@microsoft.com
Cc: olaf@aepfle.de, sthemmin@microsoft.com, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

This patch adds range checking for rx packet offset and length.
It may only happen if there is a host side bug.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h |  1 +
 drivers/net/hyperv/netvsc.c     | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 0db3bd1ea06f..49c05ac894e5 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -793,6 +793,7 @@ struct netvsc_device {
 
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
+	u32 recv_buf_size; /* allocated bytes */
 	u32 recv_buf_gpadl_handle;
 	u32 recv_section_cnt;
 	u32 recv_section_size;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 1ddb2c39b6e4..a6700d65f206 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -289,6 +289,8 @@ static int netvsc_init_buf(struct hv_device *device,
 		goto cleanup;
 	}
 
+	net_device->recv_buf_size = buf_size;
+
 	/*
 	 * Establish the gpadl handle for this buffer on this
 	 * channel.  Note: This call uses the vmbus connection rather
@@ -1095,11 +1097,22 @@ static int netvsc_receive(struct net_device *ndev,
 
 	/* Each range represents 1 RNDIS pkt that contains 1 ethernet frame */
 	for (i = 0; i < count; i++) {
-		void *data = recv_buf
-			+ vmxferpage_packet->ranges[i].byte_offset;
+		u32 offset = vmxferpage_packet->ranges[i].byte_offset;
 		u32 buflen = vmxferpage_packet->ranges[i].byte_count;
+		void *data;
 		int ret;
 
+		if (unlikely(offset + buflen > net_device->recv_buf_size)) {
+			status = NVSP_STAT_FAIL;
+			netif_err(net_device_ctx, rx_err, ndev,
+				  "Packet offset:%u + len:%u too big\n",
+				  offset, buflen);
+
+			continue;
+		}
+
+		data = recv_buf + offset;
+
 		trace_rndis_recv(ndev, q_idx, data);
 
 		/* Pass it to the upper layer */
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
