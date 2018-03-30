Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-172903-1522443560-2-1159161865104310316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522443560; b=BdBZQ6CUHotyc2XFgWRIlYnOPpdCNgKSZauXH/ETin2rDmqhKp
    x1oEkdfgKt4wv1s5N0U1Oymcdldn6A2QoAxacQVPxcv7GyciIU/FMyZewMimkdMJ
    mAPBX0/QYP7grdfwnPWbTWjk8GqD70wwVTUTNRsh/YXC7LWJPyvVGEzYr8ycrkcK
    NKazz5TOTMGeXJRrollGWBPRen78urAIr/DUzGN3a6TVd+p3ymclPQwhhpmPfsdB
    eVDBuVBWgOvRz/Rr4FWGcLazPaTDiRyEYol/9s4T26FR9dg22vGtN2UjEP5o3FXw
    1u34aQh3LiC/EOtYF+LdYGDoNXfa5paay+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522443560; bh=nJ9Cc
    7Q1crLQwCsWOeLJNq91qQn7kc5/cvPfAEIZEvs=; b=Jej4uuYM7EUTLvQ0Qp+zv
    EmTTJuwLDcvqu+oYbLo+9Twqlz5B20vqvk7kvxWmwGHmWXU1MSDuh18bYEz29zk1
    /qje0PvZQso/vq2miALeh+C1uGCojFTIQuKV1PjPwXF7kiycMqqoK5ZhI2Km3Vok
    1ZiSkhWDbUFcO2pOqn+3tFL1KIsFd9vZU6hoizi5G4dia739tiYvMxvwcuId/9I7
    XxODFw6SCGDm4eKaD5K/lLXIh9IdXJs0L9ZDQpy/snV+Q7ao4vdWoMHZe6Lioazn
    TMBrPkw9EWdmmyY85e+s9kiYWOmr1ufELOV3DdVPzfBgvK+eXKZT2HNEE/wJAD0Q
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCLU7O5wgK29nFBPJeIy38bu+EOKfmN54j3NttKH1W3Grj5Pk6kxdzLr5wUFOfMrNEUNsoUE7jDrHTFERqb+cskCVObBxq/zw/Lhf31lWtcJ9yaEhned
    KBwmsL2pp6Awbwd3s3ed+LKS9JPF/o0zrpKHpQXGogdmnT4tCuVq5ZLVO9BwENQ/iMu4F0nkelJjYV53U1MGbd4Ez38z3yHwLIwDF86S4Hm62mZKwaHQC2+G
    mpwvmHkDppZx45zr7d0dcw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=cWCBdjABk5Q9A381GF0A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Clean up extra parameter from
 rndis_filter_receive_data()
Date: Fri, 30 Mar 2018 13:57:59 -0700
Message-Id: <20180330205759.31055-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfAJsmj1OIgT7IPLkZhnoL0ZS9yUhsGi9avDS7/c8UOkzWtkb3zWXXjTArgk8DjUPLeGsq5fGgVgl0I5dw5TtgmZBD9ogotZw/6l7MZi/WYk4zHNpp5et
 dyETFwW/xYZwItFZV5wTDKwtcq7pcIJOvhahKYqDdZgP1TBWxUhCe0JSp/Hrmi76Ztl7FL42QQZX4/wfLtLD6DnV7qg7erumB/mIPcOpUOh263KbbS4C9Qpn
 tW6Ub5aAN+IBUDCDoFupopzGs0fnJNDltlhzPPiVVblcLzr3NusdepEgS9nVhlVyXirTHHDAi7vtt2BmQVSW0j2nQ3ZTEUNt1apLtQMgg3Nd6lfEh+VLSTSR
 Jsg2onH+anaC+J6coJensybC43Yry+D5zR45tQ6fHwFA/sTBIoiA/i05wV9zfggX1v7LXbU/crmIPC+KsowXsPhg9a9sM7mQnOaRgeRIwWRcWqaTZZm8Yl88
 fk2YyKvdy9CivZPVNA7mLXEuf7NPdGWb5BHSsg==
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

The variables, msg and data, have the same value. This patch removes
the extra one.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/rndis_filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 4a4952363e8a..e2b68d9328a7 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -365,14 +365,15 @@ static inline void *rndis_get_ppi(struct rndis_packet *rpkt, u32 type)
 
 static int rndis_filter_receive_data(struct net_device *ndev,
 				     struct netvsc_device *nvdev,
-				     struct rndis_message *msg,
 				     struct vmbus_channel *channel,
-				     void *data, u32 data_buflen)
+				     struct rndis_message *msg,
+				     u32 data_buflen)
 {
 	struct rndis_packet *rndis_pkt = &msg->msg.pkt;
 	const struct ndis_tcp_ip_checksum_info *csum_info;
 	const struct ndis_pkt_8021q_info *vlan;
 	u32 data_offset;
+	void *data;
 
 	/* Remove the rndis header and pass it back up the stack */
 	data_offset = RNDIS_HEADER_SIZE + rndis_pkt->data_offset;
@@ -393,14 +394,15 @@ static int rndis_filter_receive_data(struct net_device *ndev,
 
 	vlan = rndis_get_ppi(rndis_pkt, IEEE_8021Q_INFO);
 
+	csum_info = rndis_get_ppi(rndis_pkt, TCPIP_CHKSUM_PKTINFO);
+
+	data = (void *)msg + data_offset;
+
 	/*
 	 * Remove the rndis trailer padding from rndis packet message
 	 * rndis_pkt->data_len tell us the real data length, we only copy
 	 * the data packet to the stack, without the rndis trailer padding
 	 */
-	data = (void *)((unsigned long)data + data_offset);
-	csum_info = rndis_get_ppi(rndis_pkt, TCPIP_CHKSUM_PKTINFO);
-
 	return netvsc_recv_callback(ndev, nvdev, channel,
 				    data, rndis_pkt->data_len,
 				    csum_info, vlan);
@@ -419,8 +421,8 @@ int rndis_filter_receive(struct net_device *ndev,
 
 	switch (rndis_msg->ndis_msg_type) {
 	case RNDIS_MSG_PACKET:
-		return rndis_filter_receive_data(ndev, net_dev, rndis_msg,
-						 channel, data, buflen);
+		return rndis_filter_receive_data(ndev, net_dev, channel,
+						 rndis_msg, buflen);
 	case RNDIS_MSG_INIT_C:
 	case RNDIS_MSG_QUERY_C:
 	case RNDIS_MSG_SET_C:
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
