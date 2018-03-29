Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302736-2-12134401602818585148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302735; b=PYFLuhgMDrgOHyXwv4bNy0Fe8eLn0qzb3hGUekaz1PTVYoo
    41sZvbzDS9SOXkXRZA4COsztvCczZqxctfgRh1w+Gg6+h3GqivIhHlEsT/RUb7ot
    0kZzldyB1mln8Dhw+VCUZAq8RUCViXFCmCm20mOmKOy83k4uzeMncV9GkrURFaju
    kGKUlT2gjYAAuYWHXoG0dKtRITYI05szHyLM3+nAXfqydoi6Kxl48+puAOUVUavQ
    KZ24saL+97dFhSsNR5ssuPyFJfLSqVT33NtlGbGGIhyQqZN64ANFXBuYAa3Q40cR
    gjX5+htftyh5c2JJHV7Yc0AE7O8seU5XAoIg6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302735; bh=R
    XfoswCZe1+xsCcId9y74FTrT6DZo45FcDn8IAXXOeg=; b=qx5zUkrO2AEgKx01l
    XAf6nRw1b8dr3vz5DR/MLvfQe9w7k5w16CoAybk1TI2M9nnPSglcVNBfGQCMEY4d
    RM0+pK8E8X/FHvt9qladYc1hA4smM7l23OaoWJaabFO4VOCaZbwocoTJKrhsOQFD
    btMsCtYNNFPsQRxn5UhU/hddMQmYTdh2AwArvWqs6GVJ4n2olG/1DgrecBM8ahn1
    UOw3HGZzo4Ausz3vq7lTlYynPMJ/7Jxn+ztszJzNl0wM2wBsZr6yWXTEPpqA7Lhe
    REqkHz3sZU+TKZgCKWZVZ1D895ev1LFrPPyOU5IsKsBenycoCiooQP8OsC79Cf2X
    LCLTg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbQP1lBiKOiGAVOQunP81s3Lk1OGvq+ro7NpUTJAP11NJoeFX/CtWrov4pKoNr27FveWO+0vBhQC0JKxyDDhq8+OSlCkmVaX9HHJPM1/Uzp9ZkKU+C5
    m+JodP72f6r6+92gECRFGpkCC609uBWBaIuA1/QP6YhfJitDuF1SA5Per8ByMGcLoWRSkex1TME/feIJYolsM3yXkkZlhWtT0E38oZg6wGqZsh56Wp4X2UO+
    Mb8mSUvSFwoEi9za3WscKQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=86c-8aGkN_Si5_EGlHIA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 2/9] staging: ks7010: Remove unecessary cast.
Date: Wed, 28 Mar 2018 22:51:45 -0700
Message-Id: <20180329055152.13059-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:c3Srrb3jQfDOlfulVSRsEKry4n7sk5FW1JCSh9zwDFa8p55YnE5
 Vgf2k93Z1r7Zb69GsjCIkQ6BfwiRFeGJgiq1JFXwBn0rVWfLCviS84W7AKDNGMeH6fBHHO4
 nOkls+8n3qqO8Ge7audx86b35J+1/Irip6JqxVsWWn1VPDk+1ews2y+lGqPnMEG8NHPYXb7
 WSY9Z1B1bQk3gHcAIL3Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OclOSXdRGf0=:3Q9WbANDo3Uwzxgwe+D+uD
 majuJQ3vw47F6hVnP+qlxCjXiQ47VaIY3foaxLWeIJ5qXtLK5qFv7nClEOVL6H0KPd3kJOZd3
 RamgufhxJ4l6vjdUuzJoDvAnKtYah/fbmpx+TWb0baW8QHZG0ARbe1rTbvSR8IqZW5SwvkGh9
 lg0Wlkoi80pTShH0YibZ4vhQ06Pf0ePzk29zpMwQiZQE6GhrP+ENxEsWLYCxEIkbwiz/tV+LX
 quOWkIe/COO/J/3+aRjNV3HleDE6x4TlYa2C0dhIxeFIHmS7iSvzmMhaRXg/qyQQp461RiqIa
 gz5NkjwVE+jD9mLMAmQfZToF7peaxBIYM7BVP+lTIz/wmmmYtJW6oXxPVgzxo8DXfgnNr1esQ
 L29kctQMuW+zSSyHCFqD3ueyMi+ys4Jyk4CxzZxxPboWO5qTsY0c86uERCp4vwdnEK2PLJulO
 /qulHyrWvAmAyuV5m8K2Bd61sdYcZ1bgwg8VujCZsqi1FpCHAv/bDQtEEGEo6IP+M8cgWPaTo
 CSSNQE5bmsZwNp4+uAq+48aO17l9FxSSrZ2I3SELOpPCNDtS/MVfKvKNpTV6wtpt8Pyvk1Ksq
 U7TOAYlbjB9c/nrUBxvZCwpQKWtfGOeYl80HTUDWFANjQtYTHvz7IeY9k0DImrDYVCbCl+/YB
 e0odX150Ne2lOEqi5Bo51SGh2jXjukbmKkp/X5fHEogAwilk58wzaWvgEq04TUpI24EGFwtL8
 chd1STr3IZrkcoxIIL83r0kGIJPO1Z66czgi8A==
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

The driver casts '&ks_wlan_handler_def' to 'struct iw_handler_def *',
but it is already of that type.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index f6e496aa68de..544bfa403d9f 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2904,7 +2904,7 @@ int ks_wlan_net_start(struct net_device *dev)
 
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
-	dev->wireless_handlers = (struct iw_handler_def *)&ks_wlan_handler_def;
+	dev->wireless_handlers = &ks_wlan_handler_def;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
 	netif_carrier_off(dev);
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
