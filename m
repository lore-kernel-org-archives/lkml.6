Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3551175-1522955380-2-16143762021658085493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522955379; b=J29X0lEc87DBy9mQ7fFqyRzo0MLdrpJ4UBPJRSGYEZSvTfGurP
    zwTnYO+qni2sk2sgwn7wc2Tm4/vGS4+Vo8I30R1J68Nf3oUCgjwsG7tin6gCNFlc
    x/DW7yOUnMK1GfI+jW+oDB1tNAKFvwaRq24adhnLZLHvnws680lkKcNOjHzXNMIk
    Hrk3ZGJqPX4Yu00djvmCC4WATNxIFZNT4VBCZk9wjLrFP8XAt2Oq/x5kpPZjX9H2
    Vz9VxVglumh87ojMSzNh34qhS5RDsgEXm2lHG6u3NdYzW+KtIvu+u/Mg3PZoNAqf
    MLn/kXQoKk+a/ml2nGBR7348+GnE70Jzzv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522955379; bh=WUn0o
    UjkJ4UOk3JgX5ASM4xXmnPfuxkNO5K8MdW9DvE=; b=HIVprakby9BM2lDtx9Fz5
    Sc7XaE6vn3mraKkbSCTVQwQjNl8pjZ4Pve7Qq8QDdffyQsTvC/z90aT9XMK9fVg7
    HO6fk9KyfCiMaM8f1Xy1AkR6p8lXSJYP9ZYCqlDI07mSRi1QIEhmCYtclhBv9c7/
    6ozLtkQjeiDxJfcOAR1Qi/r2CQg1ri1lCZleTs6SFOpPUogVEiY7AV+yX2nYCw6v
    y9PUnCi287Ohe+L6ZKkTcGFecKBxbGJhm3bWqoyRvoMqRCIAE2LvI9gtZ37aZthW
    1FFz+L/f1C0SjizGX9OhylOVSeTLAQPM+XTLvzkDtGirAWsNDoMCK0vFA/7yb+t3
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPWeWAa9CzafwnBTnti+zE9o7AF/wtxwjLQftz1Z7aoS9MetYojP9wYO+OYZ6L3EadnhdB5jV8HXjY2CaL4aiOUtUifDtsAB5M9yNHwhgSoubSTuiYuX
    UXBSuJBdVzTRgKDXnUJDsQion+7nvvFk1nH3S3UPsza+QMFLFeTk1WVVZlU4710YFBnEl4bVxNpGyZYTC2ucZ4FpZe2MrEStLTfppdtgnHXPT479D+lbZt6X
    YlR9wO6Bl15X0P8SwHmZ8w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=01HtZvG7vtdAJImpHwMA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org,
	sthemmin@microsoft.com
Subject: [PATCH 1/4] hv_netvsc: Use Windows version instead of NVSP version on
 GPAD teardown
Date: Thu,  5 Apr 2018 21:09:18 +0200
Message-Id: <1522955361-14704-2-git-send-email-mgamal@redhat.com>
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

When changing network interface settings, Windows guests
older than WS2016 can no longer shutdown. This was addressed
by commit 0ef58b0a05c12 ("hv_netvsc: change GPAD teardown order
on older versions"), however the issue also occurs on WS2012
guests that share NVSP protocol versions with WS2016 guests.
Hence we use Windows version directly to differentiate them.

Fixes: 0ef58b0a05c12 ("hv_netvsc: change GPAD teardown order on older versions")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/netvsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index c9910c3..d65b7fc 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -590,13 +590,13 @@ void netvsc_device_remove(struct hv_device *device)
 	netdev_dbg(ndev, "net device safe to remove\n");
 
 	/* older versions require that buffer be revoked before close */
-	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_4)
+	if (vmbus_proto_version < VERSION_WIN10)
 		netvsc_teardown_gpadl(device, net_device);
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	if (net_device->nvsp_version >= NVSP_PROTOCOL_VERSION_4)
+	if (vmbus_proto_version >= VERSION_WIN10)
 		netvsc_teardown_gpadl(device, net_device);
 
 	/* Release all resources */
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
