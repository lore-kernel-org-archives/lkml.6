Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ujkcycUemBveEC88k4/aZn+gWBmcojjWsW0RCQ0fzhh8MXe9jTPgLKYLAH07OnFHAVnPH
ARC-Seal: i=1; a=rsa-sha256; t=1523981152; cv=none;
        d=google.com; s=arc-20160816;
        b=rDEOPz8lbywgEA0j0EnhzcOJYDXxNX3OiLkfLV5XBYVe/Fd+WPMN1JqnMNREvq3Wik
         mvtmn6jr44k8YB52p0P32VlfZmzxLWItOybb9tCR0UqB4NVi9K8TJsA3IJ3v3yVVEYcK
         EckXkVAh7qRXLTQM5tQwg+6NpcMIsivsK/UzuYqqqGCQIgeuIPkqN/c+mgWuyjTA0Um1
         i4xt6lc5Fm2fJCc8GJltP/73/hXe52sXTlhAaEknM/HGCjyVynD78FwpTy13KvCTuaOp
         CTWlZ7hOwTOHuWkOght7OVkkb9LnN7VwoW87qIb8Gd+SXdkPsFjen1TvOdpTWVUNqskJ
         ecnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pGgZR5OT0pC/9pKNGE/m/2CMLkq2QEV3Db6eXfL59/c=;
        b=AxHN70xlSGj53kJypr3sHspJs1hVOKh4U2+w2R6RJ8/TFaTSXtCjFtXWUeu/0+dVnG
         gvtPyLFzQBwdqmMn5iWKmPjGX/drLw461O100OXuhIoGwqyg3XZrQydM3MmyhyQTL6/E
         y3ej5ND0e64i+Z8az/Osr+GOJ7/uE2NMMRFb/DsndIxzLE9gsargDh5d+jVU7BV8oSwa
         5Hxy96edIZ27+A4mWSnDKGtBLIQ4jYCL84rFlXxmuJw5K3EvfTdx2qyHdU/VAaZdSmmZ
         j+kl9ZO/Y0liIVvQB2IXtQo96Q3VqNUOowepQ93KDXz/3t9NFs2aemF3nHoyQjWoGtFB
         kunw==
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
Subject: [PATCH 4.14 12/49] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Date: Tue, 17 Apr 2018 17:58:51 +0200
Message-Id: <20180417155715.589485025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009716274677787?=
X-GMAIL-MSGID: =?utf-8?q?1598010060854000897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
