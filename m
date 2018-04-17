Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492FsFIZna9seMDAmO5spg+OdsdvezmR++NyWxMzog31eylftHcVe54PRct6MFs1sKnP7NH
ARC-Seal: i=1; a=rsa-sha256; t=1523981014; cv=none;
        d=google.com; s=arc-20160816;
        b=o8LkMakbSoBa15EBVsrI/jkqB5gsWQX68ddL9/UJVBOV41J2SGokNGCGeWercBRhz8
         OdkV1dd4gSCHphxYI0KCV1h2lA3jBoDLtjXR2lWwIC/4a2u/5tYYJb0SbbYaMdITzg42
         eFjOTn4sNIJuho/DCBdCON5yigp4CC6Jnf0QX4ah0D5T4GWI24HHX0qPcgHWkLEoacad
         GB9AICtNUSOzkdznsuk66+sbTmgx80qxCqst7nvZewkSKfN4NY6hDetF3kmB6yQx5wA0
         SiqAWiuKCGqKSYLMPBpHeI2mdqdu/lsDCzUYnTIsjrQDAUaeTjp300lsC15h+QWy0eDs
         8Qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v/WaE5xaMofD8IyKaFYs+il1Rq9YdIm35Nop8Z8alRc=;
        b=oHSRJ7/DHjJjxKH7q9aiARnpFmtn1MzSzCy8+OM8dWPWUCK56r9dOH0dNEEsm06qfp
         HlWgpvUxMAUC9b/krrR2tq4Eo99izXn1C1dtP4mTHCzu3Q36UHD/Z/zyXR72IU8rcBUk
         dSjDsjdYA5A1WfLeNYx5IO0Fqy9exqZEK0zh9ZNI55Ucebva6GUaiRXzapccSFaUIA8V
         cpeqXrK+IO7Hz/Y37BAqdosit/SKwhK+jWdQB66oqFlWLHZuO5Nl6yyDiYKb2jJDxmlA
         AfxfJrxkrC2lnv86pzt04yuKr63XCMcZzGxb5rJFwQFOMqR25ILmnJfEFBoLLcs3Iljr
         PglA==
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
Subject: [PATCH 4.15 17/53] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Date: Tue, 17 Apr 2018 17:58:42 +0200
Message-Id: <20180417155723.949991720@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009716274677787?=
X-GMAIL-MSGID: =?utf-8?q?1598009916233109759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
