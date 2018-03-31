Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49CRXC3vIcG/CviO76L+9osIHOOyjOUWq/hdwl6rZFJXI98Q4lp4Vuj9c4E7spynK03xSXl
ARC-Seal: i=1; a=rsa-sha256; t=1522476629; cv=none;
        d=google.com; s=arc-20160816;
        b=V4HXjAEoXBEQYznm1FA7SoXB/ANYTO4AdgRdQ7FHPU+cw+lY0iUHHu6zj0VA6Z9gAy
         r5E5s82yV6+8vjSM4lbuBVluTbTF2WDWtVyAC2Uw7OHd9wEYnIsIk64fT5gcJPCaCgam
         XJvBIjNitJD8XMaGiUGtMY8NiRHt+UBlNlMR7tTUP/RdPMFAPIbLWLBc244IJIzShr42
         SKOHg07NQ1hsqZoeXrRZNNnElrlPGUHXoGdQIkr0cnBk6GxLCblRqAL0p6N/DHGpw58Z
         IeNi1ej2heXTY7/cRCJO2MctLM9T+ZNDUnnHzE1xO8vwWcTSoTC9+vyAh2vtRWybT2Xf
         HpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Z3BsHRUFKVtnq56Ie1INDnwwFVQIyCpqwTE3TX9v0PQ=;
        b=ymuMHi4ioWgAzWavLY2mLxYFCB09ts4bW4BLKH+q3DIgMAZTxRdoalELjRRVuPPCBh
         uNV2ILh6rR1S+PmJrhN48+y1WdujNMCnQ2WCxUK+nQ1Lup+8MvOcZvWaS0utQ0dC+zg6
         QqfdBwV0iWijL8+ikkg4gFpT3Rwa09F2tI9CJPSRY5xcn4OBfLi7Q8CsMdQy10xY3bgT
         Qh6RYt0OhaMonhG0MrPgLAXM1lPWoTff4gxt34UMiR050DdgrXKwtnj9E7JZFLxkfjvx
         RJ6JH5m1ldIV7WH4onxbcRNdJ6MaBt+zcxpWoo2ujxg1RWvlg5wzc46HpIABMdDg/r59
         eu8Q==
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
Subject: [PATCH v2 75/75] staging: ks7010: Replace memcpy() with ether_addr_copy().
Date: Fri, 30 Mar 2018 23:08:55 -0700
Message-Id: <20180331060855.9452-75-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:r8HO7ADHTEqWJdCnsuAyYe3fFdtqY6patmmHFpcswUMe0JguRKQ
 nayWna4G43GHbQk7fczNJ1MRD0O/s4BX8dLEQZIgZPrAGK6iiOzS7uMyqsbh4Rpn771vfn0
 4ojfyBvfX+8XhWkjoxlpb5P5DnkA9JS+lfrz7X0F5y0PxiWi5pKtjUoUz1QcqZNhDjE69aN
 SOj4OxJ6t8j5pIeb8BHew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QhhPuepgMRw=:gPNxI+i9bUddSZEMEdToPO
 LoLtLa+EJWP1zCZeiDmCpmrrMP1jTFQfMoDgy44hKlzM0mR6+Ht+UT9BdvqJqLh9SY6gV9zuN
 qiUjkWWYvV8l4jdO3Kt1OxxrrCZVafvsFgMB1dtc+0hPGmDalxDo5XIJdzvsn2lTMJQdXXHj5
 pqISGgKe7QkUOVbK8xVTutnSJxnsqrsw8R4CdTvvfhSBHzh6/c2P/mNhwwQ4/LUdBBmgvwJRj
 TzfFUWAG4PbH66jEfPDD2XNC3qELaN2Izaq7FKRhCQpvXqBA8bOAxIPapku8+oPkPpZ0ppjMh
 6F+r5E6UVpIGlafgu6ltCBq6aAGEmi3Fnzx2964DXbCCHXNqlATPpAEa7UA55QGFPgPFRDScH
 ikA5+yGIFqqf2chIj5IKV6S7RrKjY8WgHyX6x1nDN8ClpNbd2EOMfH6FWZ/lO96zfUNA2Vj9p
 E2IddzDneVVO4oPcnjAMI//71NK7194glP5BcouFPq2MdmKMPnQoQweVfwDu3J3h7/y4wlMbn
 04UuepnXFMIMbWsPFdbRGRamE6cYa+3zJx34MF2J/31k6WIYtHYi6CKILr51M+llrw084chDV
 Z59NLJFkUwWeH4qHWHlL59griZ60BWOa3yC/6hBKJiGEXGodu+jfh0wLtA5CA2HjOu2Rt3Lzy
 hqdWb49AF+z5GV8WgS0gfn6KRiKf8NrzLznKKgnQmwGc9a0NswdO0M0J2NYjms31/CSemOq7g
 e0RPe08N66KcyFGzuJXjgz3OntKs0uamGIVJqQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432454348059608?=
X-GMAIL-MSGID: =?utf-8?q?1596432454348059608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ether_addr_copy() is the function for copying a hardware address,
so replace the manual memcpy() operation with ether_addr_copy().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index b5a2ba702dec..a461dd568d28 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -522,7 +522,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	case DOT11_MAC_ADDRESS:
 		/* MAC address */
 		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
-		memcpy(dev->dev_addr, priv->rxp, ETH_ALEN);
+		ether_addr_copy(dev->dev_addr, priv->rxp);
 		priv->mac_address_valid = true;
 		netdev_info(dev, "MAC ADDRESS = %pM\n", dev->dev_addr);
 		break;
-- 
2.16.3
