Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+BvfIdVPaGRcdviNU9WJ5c5TlJ3PL9+GSslqmeBNTFrjc9ef3lg82E9tggyIMnOBQPanEA
ARC-Seal: i=1; a=rsa-sha256; t=1523980823; cv=none;
        d=google.com; s=arc-20160816;
        b=EZZ9mL4jKvLMoQ9m6BphEBz9o39uit2ZyYX6F4szJP5V+TRjd2dF7y5c8oJHtToEqP
         5n4ZOECiXsbR7LIQK3Vhva4JBtRuzmgiDWzcILejUJ7DI2HRA49lhv99H5KySR/LcZ+B
         skz0bG1mAm+w3yqqyN5FixUw4cEMVFsg8SkEb5UXLXk92rNixXdIxs6gg8t/XRFY5+MN
         XPNTsFWR9AQMrCZ5jofkOsWK9niVKhoBPqxipfhJGmmAFdvLnSbKts6gliy2A/X7a9RN
         eBCg3LSsLdQF0W76NS2uriyC7ySGFUK5iZrGN+u5M1ZXD1DP6mDuUGVWEEBRtmmJGOco
         h+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VJxymHxhgAqry+YjmVDIjA3MXVXk4IGM0AqMg/xPV5w=;
        b=hdwDuGixrJSJ4Gv6VwWb9N1Z0qEPTUWwnvZGGEXWq1Te7jm0dor+ts2vWs3IOsAgAR
         IMLmhSUOH4ktWTMsVf5bDqztjejI6Ir/GylMmIlsnPDw2fx4UYiGDFy5T6+Oj2XFBZ6t
         CNhVOVwGs6QvtIoRlTxhtDAs6CX/1uURrPFTqB5b0+DPH6gJHBc1H1zWjViqXk47nmMN
         0IK6e6j2lwUfzFhjob+CBAjdGb6s9odBgSNyiSjLNDhh4DyM2yMuSL98bgF7mqbfnTJU
         U09XlI+BrOG1lSqQa2tiCd23bgx5lqUaeIOtXTIu4IK9KjtvA2sPb6J4lpLBlyDmwonQ
         SRlA==
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
Subject: [PATCH 4.16 18/68] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Date: Tue, 17 Apr 2018 17:57:31 +0200
Message-Id: <20180417155750.073253797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009716274677787?=
X-GMAIL-MSGID: =?utf-8?q?1598009716274677787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -71,7 +71,7 @@ static const struct vmbus_device vmbus_d
 	/* PCIE */
 	{ .dev_type = HV_PCIE,
 	  HV_PCIE_GUID,
-	  .perf_device = true,
+	  .perf_device = false,
 	},
 
 	/* Synthetic Frame Buffer */
