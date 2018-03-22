Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3727359-1521755314-2-6833625462723064280
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
    t=1521755312; b=LE8mqqvVh6BvZheNRDWV9JJv9B5VMwWUZrmeNVFmdq+lEfR
    RvG94qyJvBnTpwxgHXybhQQ3tr1aTbA9Z2v0awYHTRBvS40H++tWlp45MlaHxddl
    8svqNkmG4BTiCPppHzZNWAXQDKdI0L7DYjQyp/gC7vtONmQHkrsor85qFZT0T4L7
    0zS85hTgmO3iYYzqFRAbJbSBJxwyXdrJDq6J1ZdK7fDhJxuIXyOU3urTUFqnKxv4
    q/DhSSewDOZA7jarK2Exne3Wq4+5HGoiOa16AXuW+vQ0q1EV7GLm/vtoY2Mzpp+G
    bHcrEbGEV4OruU7du+rUL6IONpSgAiHRZsbBtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521755312; bh=F
    KK+DttAeGqMd+qQu+M3m15z/NU6Nbulm/QwxkLjHHw=; b=o3NmFGlLZNW+ImCYr
    6D9j8mqDPXVHlfPvU9V0rVSMFzqAOfNgs6j3rOrOg+op+fOxtVJj8TNiTKMVrVkO
    Z8dSLOR1lsKLc7kJ0btdY0z2I6KujbDsNGv7CuioOHgtM3xIAsmn5ojCbQjUi6CV
    zLseS1FvrYSlP2nGhAz8T4ILkcG49ImkIB5i0cH4qOjkU/RTwIW0eAOt5fmLDIlS
    1N3tF+/RiCxe76Nzp2rlhJbFY/f0JRdNOf2wtbdg6K3ekwfdgxU5yeWZfFa5Y9qT
    q/5DPltUToJmex01k+eduHJ/6eNFwYapSRNWAY359j0ifqzuWLMnjZAegOk2pVFT
    6yM/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] storvsc: Set up correct queue depth values for IDE devices
Date: Thu, 22 Mar 2018 14:47:18 -0700
Message-Id: <20180322214718.29547-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfO/suPO+RwtKAC+8Y24aPAm2MOOJ4U2Xuuf4/nxkxcwIm5Od5tsK3UQI1tLo96dHdovxJ+T50J7Jb99bUuMm8aY1idm/9cqpBMY6nL4r8Psgvopor+AE
 4Qt8lAFJRRMKh3x/FnXQh0wIbiJNO7YiLhvBL7lLMo3FCXdMtS2+vnubGMSbl6euvmLkSkwohDh55np+3hygF7jjSzIY9FzGWaI9g+VF97DkFHQhNx5/nPJc
 UQPoiKlv7/MKTGRFoNX+QPbZ9VnE6H8PplLJSChKiehgDxtxCKrQKrURIUMl+xhYleg/uVX7KVOCxoM0mo5rNQumEhBTt90GpcxgLJLM2pP8ANSareSN4RZF
 16bX/QLdSM68/wByIxPlW0j3B+mg9twWbgB/0youoTvcHxE9fN5sd2lOBwoF+vBEF8bbbQrKvZcuGf4WHLkfbkPa3xvBgYjO5CPh26Ag4WLMQAFEkHzedYD9
 +tD/MbkT9yra2esiegtphsXtP3yxJaK7c/kwgLZ3gGl9VczNujMOGVCtxSQ=
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

Unlike SCSI and FC, we don't use multiple channels for IDE.
Also fix the calculation for sub-channels.

Change log:
v2: Addressed comment on incorrect number of sub-channels.
(Michael Kelley <Michael.H.Kelley@microsoft.com>)

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8c51d628b52e..a2ec0bc9e9fa 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1722,11 +1722,14 @@ static int storvsc_probe(struct hv_device *device,
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
+				(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
 	}
 
 	scsi_driver.can_queue = (max_outstanding_req_per_channel *
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
