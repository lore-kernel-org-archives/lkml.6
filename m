Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49tzvd9rxU1sZ5evrAbseiebxhLCKBoahRqRUvMGHiPKNJuYkwP+cl3yrn6ufWIRKv8hlr4
ARC-Seal: i=1; a=rsa-sha256; t=1522476628; cv=none;
        d=google.com; s=arc-20160816;
        b=zTDf3c0mTs0K8Q9NP9s3KvihFEePCcxRGNTkJtccgTXrLRnVmeDOAa/utnrpfcjxfw
         pwCbx2aep0kqvFu7IlL5GP1X/41WcvE2nPUoS9GwauO7nT/v9ASXCy518gKCaMuk7VLX
         x3zselD5QdJQWd7Uvw1Mu5+jhRl9TdvZF3RoWMitdGpbDhA3EZqspZ3KnyUgYRM54pp/
         jv/gA7o2b+gQSKyNXgQ2G4tC9D0aQjWZztMzMTClTe7kylcG2uoznHuiUaNZS8EA1yuE
         EdswjHTxlhMVY9CStTQ2zTimMsXokQxFN0b3dyIUuszOniwGMtQCV7tlRAaRLxVQZg64
         Rsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=NX8ufI05DuE5RihMYaGLXX5xZenHoMMR76A/5hYMck8=;
        b=iX2Ffp4OiIpfu54TfkI5EP8O3Y0m28+MzFPAIpsiugoz2Rag3O0CJzBrsEzFvGgo3q
         1UOLm0/TvYCmT5mIzaWUBENeyMShgey4MOPjA7bo1Yrx9+DdGpPsdpgpJ7x35wP6I4hv
         UoXG06AXg6Cw6GRWoQe7AWe5adMb8LW0pIOFPIGZHgOZDkfg8z5Tkd0wAbEvoq0SOCUY
         YvXvOB0830/AalYaX+Jp0EDBIJS/0i5Nn2WruSohyTIknKeL+d6KRAV5r2iOeEfE4PPl
         OXikqZDOYtLBV7HAjXkmI9m/MyVu0mnqBtP26V9X/Dpm6ziLFIVOlhDXfy8DvDtjYx98
         lP5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 74/75] staging: ks7010: Replace memcmp() with ether_addr_equal().
Date: Fri, 30 Mar 2018 23:08:54 -0700
Message-Id: <20180331060855.9452-74-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:IsLNhAAveoKq+8/pDzgMF9l5ru1TfsDe+unE/NwBPY6OfnR36NZ
 mKA7SmCYxhG27ul7izfZdTRYGbZ2w7aKwfvRW14Siv0oFZfA2fiwLWb1V8/fn7YrgTyjFBJ
 6M29i5Xpx6ULoDmT3VV+w1yuLa5B6q+MyvM5lUUJQD0Z6x3LyfvKXCsRnAswKE64t61fGfB
 wR88guRlsHvp2ngPwQrUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fe/ZLUXkPnk=:AqDYz1Fy/1/1T4nvMx9inH
 jl1Ujov9Q1O+3dmuYHx1Pf//tyj/Uy/dTkWJb0ey8+HtWHAgxt7SAm+Lp02W1SOahSraIFcI9
 +7KHp26JQKUGt9kmHzRfrbBqvt7TVp4ab5G5NC1iCnJ3rK9rnY9BJAVLCsrRiMrrlpLKoLj9L
 E6yYVtSXR+veX/cT2otF1hwo7MxHzFrIFU2TIhh5fQmjr03eKYSvNqUmfUXLBFBjRgdCjk1kR
 m658XagAICF+cO1+xM2iMQtrLejydjomMYcsDFDPYLydFT1rhP+5nPHn1v+ITuRfw+Jj619Mf
 EY0ZoMWqzxoY5dPBRh9Zs4RK648sL5PqbiXN/dJRn3MGJh+4cNQuUw/DeTFk1lYmhRnp3zIRw
 F9e7P8d5v+rXd7HTcccRkf1BVqq7pv01QFHaKwKVkAOLuiCLIv5BKYg/yYQuWrIgB92PiV9xM
 fI/5ax5ysT1glQkBb+n7P24nxR3ILB/SRfHWwu+wmiY6zis9HNJF5oRi4WFMUjgqoR8ghXB0W
 eswZs1ID5WtP+nRAEyPZbhWPigwck1NXIyO/jcsn0BOHxb2lvF3IPaxh5wG92wfl6ZByNu/pk
 SddS5gG6hWNSylnoT8Lm6H2Vs4JEpL+715unKrquzKWG8bKbWdQkZ+wrF3X5McYtlqREKVOra
 61GN5d3UUUpQ3EohclrIJ9QIA/h/h7FMMRiNJYKqnsNhiHDtcj00RD7v0ffonmwHIdk9CPvFh
 D7pm9dPrWNPx6VcS8NuigQfmRwHKJKQv5dp3iQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432453208862645?=
X-GMAIL-MSGID: =?utf-8?q?1596432453208862645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ether_addr_equal() is the function for comparing HW addresses,
so remove the manual memcmp operation and replace it with
ether_addr_equals().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index d816a06939aa..b5a2ba702dec 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -411,7 +411,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 	eth_proto = ntohs(eth_hdr->h_proto);
 
 	/* source address check */
-	if (memcmp(dev->dev_addr, eth_hdr->h_source, ETH_ALEN) == 0) {
+	if (ether_addr_equal(dev->dev_addr, eth_hdr->h_source)) {
 		netdev_err(dev, "invalid : source is own mac address !!\n");
 		netdev_err(dev,
 			   "eth_hdrernet->h_dest=%02X:%02X:%02X:%02X:%02X:%02X\n",
@@ -1103,7 +1103,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 
 	/* skb check */
 	eth = (struct ethhdr *)skb->data;
-	if (memcmp(priv->net_dev->dev_addr, eth->h_source, ETH_ALEN) != 0) {
+	if (ether_addr_equal(priv->net_dev->dev_addr, eth->h_source)) {
 		netdev_err(priv->net_dev, "invalid mac address !!\n");
 		netdev_err(priv->net_dev, "ethernet->h_source=%pM\n", eth->h_source);
 		ret = -ENXIO;
-- 
2.16.3
