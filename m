Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49L+WfDDt3lqDl0vH88I1vdL/GtSkFbgRp5DEv+q6P/+T2OD3pw8JdG4D9rnqOid3N8GScB
ARC-Seal: i=1; a=rsa-sha256; t=1523981343; cv=none;
        d=google.com; s=arc-20160816;
        b=F8RqvbGDnd6s5FKpfoZBZ4vMLaw2jQIESCcYH+cuKxbtWdcavfO0kPq2Tz900d6C8F
         CANLyyhAyaGde37wWkn7v7lHcf0MYxKPSeIuhDDzQ3gjHcKLtUxqRqjYYc7R0u7m7MGT
         ZH2C9Q/fvsOSlq6olXa1jbkmLXypjZ178d6z/GK5MqBxwqgGtsOHFLTAPosVf7f4traz
         BlmzY5mXtHP/X6p/fWKlRibz/VKnoTo67PdWr+dACtkBxUKVXd6xBRGRLdrSDBFoIRFL
         CgsyiQvduXMBf3QMaoStkdQmcjUuugb8oYA4EPHCzrgY7YMC7grQTg7JiD8piGRPYGBz
         qsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZQrQIrYTWshqL5/DeDO/AFOiEP9tzE9oB6/yiUBxCTU=;
        b=pVGoJVFho5iXFQWmqpSM7CBEFOAFm4kFvMeCMCbiwm6ezwBPtsp+NPV31U3Jpb3R1R
         mZmnO4k1Np6h/OJSxMOlxk39PxW1XHxvu+yciCH8ejUG9jnHjC+aJtMyYZl7SlLq+Wmx
         HkHoaWkSJWuRCxHEumxR7vuQIfL65+EwHCL3gQ8sXsRVQt70f+faiqSkca+h5CASY0ys
         d7spB9fgVjM9YcNyOcqJ6JRAIdx2/4XcHYRyeqilCrhznDkQPRl3FhfmjDdN3rMo6NRT
         dyAen3NLau50+QbCcmW8N6jrm4ta2ritffOIS9RSR31TpT7DqrH8qcTviWvO5PA5wQPJ
         Hs/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.9 03/66] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Date: Tue, 17 Apr 2018 17:58:36 +0200
Message-Id: <20180417155646.007046735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009716274677787?=
X-GMAIL-MSGID: =?utf-8?q?1598010261658335666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 238064f13d057390a8c5e1a6a80f4f0a0ec46499 upstream.

The pci-hyperv driver's channel callback hv_pci_onchannelcallback() is not
really a hot path, so we don't need to mark it as a perf_device, meaning
with this patch all HV_PCIE channels' target_cpu will be CPU0.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/channel_mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -70,7 +70,7 @@ static const struct vmbus_device vmbus_d
 	/* PCIE */
 	{ .dev_type = HV_PCIE,
 	  HV_PCIE_GUID,
-	  .perf_device = true,
+	  .perf_device = false,
 	},
 
 	/* Synthetic Frame Buffer */
