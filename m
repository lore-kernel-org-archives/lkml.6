Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-317056-1521781732-2-18220035512133368141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781731; b=haw6j0YQvzMl7xHPvO+MdARaDVxKAtsks+U3Ns3E+skhzyr
    QiZpaxRhGZoged5618jCWYYYhfRrXKH8Rm7NX+Qpag1FDedoDw72pPElU1dCUn2+
    rFJaHe0QDuVQE2G6LFtVTUXLC8W7hh15qc8XuGiBotHneX7ZEXB4/JweXepGQzmm
    BqC8FwXYcAXqSd2YZFEWhdKn1EebhnM3gWqtT6KDCqrUH30Q6QGb0C4QoTwmPP60
    A4R2cXdrFTCUaxV/1rfYGwoJomrqg88GtZk4MiJNd0pJvGfwfD/+bSTC/JM/HNy7
    V+dOy6lMFIN0C6NpwnTT4LlakEY8pb0T4YEHvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781731; bh=6
    b+bXoBzZGbYOd08T3ximNdnldh3dG7dpIbWUgnnX04=; b=q1v/u6AtzekeZnQRe
    1xrh/pr0h5s+uyFSAB53yxfqgMFhOQ8qrTQ2s+8qfJRQJP819ZSEHbiw7+f5LgWS
    juTLVyaV85fjjDTAEO51v11ykiHLczC1OgLUHA/RSzFSfenHVGfRwi5t/SZDfbVX
    Ul3w4Wzk9FWSl9z/E9Fu3q0ZAXshg4hJPqWZkzkYh2NPTBh8C4ZPMZOjIxqzG6z3
    F22CsTYRZ1aYAHmJGc/fSdudBGgl8cYV/cze/EAaFsgtAFou+K3KdBE8OVBl1Omw
    Sgw7sL9ybLrdttZrEJv8L6kF6B1toEK6HzowYZCET/VhysyMqbpBI5dWlbGMCPcY
    X1i/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 5/7] staging: ks7010: Replace memcmp() operation with
 ether_addr_equal().
Date: Thu, 22 Mar 2018 22:07:43 -0700
Message-Id: <20180323050745.28903-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323050745.28903-1-quytelda@tamalin.org>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:6ANYi3eoNHnuh93muxGTFO/+dktjM62kwTueg1tyX0qhFU3jcL5
 CKmwKNE4+rtx+cc9SwlxZOvHTYEFZXkBBbOZFoe5fmEkPSiURxOwYJYM6F2qpfP8tCx0rjr
 sCSWpsLY3BYYhpd/s4LmsKSvBJdSuxXmXUhJJukXNV5zBMv8uVKLTcmq7nheBc22j/4XeqM
 jMMdSK6+Lw0YPaPR5no9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9rqRJ53PUPY=:crsBg3LA8CRwAHMgvRccC5
 267Pvnd+bs7eEWCr/Q+Jlct/UYICXzzWiis3y1C9lzm/zVN5mY+sKcY+pup4NPxKfmCyK1Eth
 L89j+uDeL9drZFDfPwZvbRfQQ5oc/V0pZe8KVNFblcWn4lYGqsCk8DcG4+6sXWD1RQhb3/flF
 7oxp6zlYfbzrgdcJru9xAayIfxT1XK0j44Ek/3wrNI3azlNnXLZtI8HAP7PFX2SsTFJRG5jcR
 bKIlxYQS74j7B9zlwtJXihvYn4cdc52zaSIuH4xk6mImZucdXXG9x6+StpJV6O9ElFelb6gVA
 SISSjNTnd/OS7wPJMYRokqyqUTiD3ww0mWhBXZa6HQ9MmWFRIIXBMgSUfPnyG3Br4Z012Caw5
 UsQkdnNxDsWyKBo3O1qp5tx886BzGEsfpb0k49lIbWPu0R2FH9rBo1RnMJ0K7Wg8KkqawasN8
 sWqSnIo/du3f/oBm7S+mSCfAAKp53NG6fRrWqz5wc+8qqWgTRNkSNi6GQmnLst9YL82wffK3e
 Ktq3eiB6t4gwRF1g3Tx0eLQrtfbr83Lu5ofceVcIMiVLQPSD8AbEcbl2bTAc6JZcX0xcs6V+T
 tuflafHSQvqAqDLc0rli+UKOx7NmcN1yzeDsPyGq4vrsLM/QQjLWKXeLLQwzBHPO71vAmfkSH
 p9eBfAzgDuc4jGG9zO0B2py4vHJTxrcRse7M8xsgqG8/wUTF4k4LUkRxqLwzzAjzv6yAuCC+V
 nwBmNPJHelQYg6mlhw7AUk9toWQpt7F4ngII3A==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of using memcmp() to directly compare BSSIDs, use
ether_addr_equal() from 'linux/etherdevice.h'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 32f35d297628..1a0fe15e842e 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -783,8 +783,9 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	if (priv->scan_ind_count) {
 		/* bssid check */
 		for (i = 0; i < priv->aplist.size; i++) {
-			if (memcmp(ap_info->bssid,
-				   priv->aplist.ap[i].bssid, ETH_ALEN) != 0)
+			u8 *bssid = priv->aplist.ap[i].bssid;
+
+			if (ether_addr_equal(ap_info->bssid, bssid))
 				continue;
 
 			if (ap_info->frame_type == IEEE80211_STYPE_PROBE_RESP)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
