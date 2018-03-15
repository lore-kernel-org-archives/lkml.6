Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1534477-1521158020-2-2608042722826842945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521158019; b=LeWds+L19IFwkvsD1Tvt7l5FizAXx1TSDYecFevocW85g4G
    0gjzF8AmSlel6+G5K/b4SaAmvoWIvilanZJHsrAB0GauhVQVk5Y+0KZ86fcAefu8
    CYIxfGmhvJui7s3KTql9fWcz4JqJn6a0svYk0ddlA9wPv9uKKvZDulCg2xyLZn10
    e7UOoKsc8jWfU9MXzCFO7BHZQwXmAolM3CQd04g3p9TL5ZJUdfhiZiO10tTr89u9
    coaVtsAkNUiptUaRpoo08DpfGCldxuUuaMKVRRxiLD+yDtPmy4ymEjgZk5XcuvA7
    KeTQFbH1d3XhHun21osKJXKhVDdBR6mlAOcPWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521158019; bh=1
    kwe/lC0RVVPjlCEtKPVeFXxDr5GDd9lT4vNh0VohNs=; b=bTasVtUszc89bMSqr
    0z9QA0JnuSx78L4ob5MX+hGE+oPOrgZo+dx3Pf1E6KZ9rpM+KBPYB6gFRwuDsWeK
    S887hQKyFJqKLyAp/6bpVoLGJQykuDWzCDCFDopFFW8uW8GZpUDPXKxxNxmIiZt1
    VRE1IhcaHe6m388+M6J5VdZh/8EdSA0jpvQjgJ/BWjmA2FAwv8A4TPMX1QdQeyvQ
    vsBjCDzknlKv7n9dymqlQUgVjJr15y3ibXxhmrt86d1DlDXmHUEbfp/FKd/mxvET
    CAhOGs3hFlSZSCHSFYYBuDwdIlX0Ork3mUSNQr7v1wAtOsSMMcWjB0e3jL6wHNU1
    uuJyA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@exchange.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] storvsc: Set up correct queue depth values for IDE devices
Date: Thu, 15 Mar 2018 16:52:23 -0700
Message-Id: <20180315235223.19844-1-longli@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfBWLHNxjjAM4hXoDdiPqLIEIhz/3vW15fY8dwKq9L95jYSBTFYitIkkhn8EQhu9boYtBe0JiqbmEF14yUCHbRrE3hcdCczQrUY+XgTbF/ImGVfRDJ3w8
 TdVX4LFYNyGedQfPbbnFfeM/Z0Q1iJju9XiaBCwT2huJAVUd64v9yE1kOCiTvZF3cCVcIgTxz0I2dzsP09f8xufmR9kMZoM5hU0cmUCXqCtK/xViqINFIqGU
 yjyLE+o1fhqXGuAWU7GOtm01WCCpjfnBdaAk3Mv2mI0zjyxjQywakqvSGLxAdzoVDPBRMN8Lb1FxtSuAOacIJHXgo4J3/3UrnpTidSPVd6jw0eINIcqHbKgx
 3OPjcC1WkjNCqj4a/QDdHgdjx1kHIkecAHwpCBQ1iXNANJs5nStuqWWMJypqdXCgfyZpbp18F1h8M6p409XZwvVYOd2ya8T2AWvKQRi/9NpszmJVeOEixvaN
 nivkyG45Eg6/9EbtZkCsaZN8YILpw/Y5dyglWE4LdgT3h4hDoTeaMgtLrOo=
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

Unlike SCSI and FC, we don't use multiple channels for IDE. So set queue depth
correctly for IDE.

Also set the correct cmd_per_lun for all devices.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8c51d628b52e..fba170640e9c 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1722,15 +1722,19 @@ static int storvsc_probe(struct hv_device *device,
 		max_targets = STORVSC_MAX_TARGETS;
 		max_channels = STORVSC_MAX_CHANNELS;
 		/*
-		 * On Windows8 and above, we support sub-channels for storage.
+		 * On Windows8 and above, we support sub-channels for storage
+		 * on SCSI and FC controllers.
 		 * The number of sub-channels offerred is based on the number of
 		 * VCPUs in the guest.
 		 */
-		max_sub_channels = (num_cpus / storvsc_vcpus_per_sub_channel);
+		if (!dev_is_ide)
+			max_sub_channels =
+				num_cpus / storvsc_vcpus_per_sub_channel;
 	}
 
 	scsi_driver.can_queue = (max_outstanding_req_per_channel *
 				 (max_sub_channels + 1));
+	scsi_driver.cmd_per_lun = scsi_driver.can_queue;
 
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
