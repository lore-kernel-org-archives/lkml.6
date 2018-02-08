Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3914895-1518134597-2-3793122229078676222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518134596; b=tTrHMCdG5EPLQor4Iv82/ShSQFHZ12dT2rAAjLs0SyvXwz5
    fnZovqv40P7Cx9R632obpQIOPV8blV1bYD+715v41nSG42rQuq36owl2nrcSDaUY
    K2/mP4EI8/awdj1RDm2Ul3d7Li5NcZnmvuQWYC0JfoV6BwlcqqDl7l8iga7Qkeyb
    SGYQjCjc7aBmD5+Bb+sbKqgJ98wKNjC2ZQxKHUFvgCYI/c82b3nly4ZE6axCc/Nl
    Jngv629pTRQGznNTdtbwHYIiDMAqzVkVh/H93wcM1Kv5NkkkUoNX5od88omZ/+df
    GDDnG5nFZRqVJgWxF/mInucdYDsSwdYLjb0uldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518134596; bh=B
    rY+TLl8JTgpV/AE+6oJt8cQQz/YyV2Q2vs9WvBpYmM=; b=mrR/ymD6EXEOeqEM5
    PqrsqO+N3F/0uWnnRMLCDsZ5CgmQhqnrqUFlen9+6SJzTSq64m2iDkIAAIqwMDXz
    RMnS4O4ivmyJ0m/0TC1ueoY1ENKgRvdv1+GvCHWK76BzNCHpMRVWCgChsJ5V3y7O
    NcZXZcRaqPkVacx8VsDl7GmmnW4r2lxBUFJSEdZ89DI6FVu9847HNLe2COmW3oPq
    H0AL15STu0ng3t57TMUaZSgSrcjsqSE8C3GPwXyVDkqWR/LIXPMGjxo+3PhAF0hi
    bRThIkZFqviA/6ER8f1OS2JeEEkDJQoBJb2U5D8Gvz/hBg8Fp8oonvtcLkrWAuQc
    hsmwA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@exchange.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] scsi: storvsc: missing error code in storvsc_probe()
Date: Thu,  8 Feb 2018 16:50:40 -0700
Message-Id: <20180208235040.5803-1-longli@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfGk9Q9jzFMhD4wdqDuGDLPZgMG5EJexbwlcHJ70kK70ar3pbpcxZt8gViAIGapAqVfSJoTPo9AiwungjcoeiifauEgC6GbOztvArC3t34HMgyJMnPloP
 2l7dogB0xNmpQkuEgm20MBsku4MjjPl79cDvkeT/eFXL+1MqdXslByKf5IFShDwVGTeigte21T13bPcLEMq3f9Un/UNxT+d8i9BSV4YZbR/Wi6HFZqSd1zO3
 5wQOhJQOb7yD5lljJf5PKtMii8NSxWjLIkZYHWISvFAVvw2pBdauMxxSKzXDOS4W0eH5A0QwrThaWBMe2jDXs4InLgxwwlGmeR6iXqIPfx/sLjsmqnALUnnU
 WuwWdIBPHDNkRT1ibkBAMRhMUcXjmfuwTvn5p8gH1qXa91KlN4ZEM2mx++fQgogoX27yLATrQ8TgYvxE1u7GwC8pcbuYlVDemyNHJofWOSDGiousvHYXkU6b
 70BAHwG0Mc2vFCOMblftLI+NN1LlZM8pLBAs4pi74HCCTWeSLYh7C14mej72qSlU1lqmbg+Pa8rpMZpX
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
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

This patch backports upstream commit ca8dc694045e9aa248e9916e0f614deb0494cb3d
for 4.14-stable.

commit ca8dc694045e9aa248e9916e0f614deb0494cb3d:

We should set the error code if fc_remote_port_add() fails.

Cc: <stable@vger.kernel.org> #v4.12+
Fixes: daf0cd445a21 ("scsi: storvsc: Add support for FC rport.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Cathy Avery <cavery@redhat.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5e7200f..c17ccb9 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1826,8 +1826,10 @@ static int storvsc_probe(struct hv_device *device,
 		fc_host_node_name(host) = stor_device->node_name;
 		fc_host_port_name(host) = stor_device->port_name;
 		stor_device->rport = fc_remote_port_add(host, 0, &ids);
-		if (!stor_device->rport)
+		if (!stor_device->rport) {
+			ret = -ENOMEM;
 			goto err_out3;
+		}
 	}
 #endif
 	return 0;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
