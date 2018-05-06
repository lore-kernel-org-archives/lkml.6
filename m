Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZqBtEe4QN6CLoZAEHrwP5uxZBuFgm0hTQTtP28s471ayCxO6CCxl1H743xxlV4Tm4UMrx7U
ARC-Seal: i=1; a=rsa-sha256; t=1525571842; cv=none;
        d=google.com; s=arc-20160816;
        b=ttxHCdn0+Pgri+RP458fu1V+2DHYtvtwlmqXe0ngqp4yy5c7gIf+cWG2e4pa87KSJr
         2alDCgXamO0s2pS5A0KsKljvAmEX+6TZ2PJZMRf2POj1Wmh3bSXn+GyqtRb/pHntgyt5
         W2o+OU3MxFPiR+ZaUvV9u9ly/dh6z8N/qiXk4tsxAxuCC5DSmUFQOnmioisqrcW5CwpK
         ClGp9qSUsJ/hnglN4LK2wL1POtIrUanECG3BYE09MHC+IHPboxQe6g6sLWqYApJhlBO0
         Dd/kBqWSPcNxgHPzRg4C0D62NExsv2uRuKpVMkkmzP1CHdtY+QeuM97x8P/KOQo0ZFO5
         Wbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NzfRbvw4MxgtX+BkbhNQtY+qtk8tfXWRBpDiAib0iCY=;
        b=bG8VIgwXOA2I85AcFmf5HOtLLHxo0kC3YvJrodc0wQH3ie0AVrZ4dc5ea/JlbDSNcl
         CYknh8fZQvtpc0xpCKvHVv8fKNP2sWCa5rfCeLAfGCYLtca9eI8GQuJvTpo+Vdy4dP4J
         uft9c+dVuSMgfdwyypuxKNpYB0LeOG47bs8pC00MfbSTCFZDeXDtBpXtKi3GLmlpjSyV
         /1LlsA86LYBH9kpdDegygDOGaByUw5RYVzX9jrSvroNW3KSoJ5z0julPSmSgRO1lbRrJ
         FN3WQU7ZKocjkgwZy+vdXapAfOU3nybu5CO4+7gLAM/AfmVC+pmZp7RYOHyilxKx0K2D
         SEvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,367,1520924400";
   d="scan'208";a="221950992"
Date: Sun, 6 May 2018 09:56:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: kbuild-all@01.org, pasha.tatashin@oracle.com, steven.sistare@oracle.com,
	daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
	jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	alexander.duyck@gmail.com, tobin@apporbit.com
Subject: [RFC PATCH] drivers core: device_root_tasks_done can be static
Message-ID: <20180506015633.GA91045@lkp-hsx03>
References: <20180505154040.28614-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505154040.28614-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599678020381199809?=
X-GMAIL-MSGID: =?utf-8?q?1599678020381199809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: 6d54ba128905 ("drivers core: multi-threading device shutdown")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 110d797..666c163 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2874,7 +2874,7 @@ static int device_shutdown_child_task(void *data);
  */
 static atomic_t		device_root_tasks_finished;
 static atomic_t		device_root_tasks_started;
-struct completion	device_root_tasks_done;
+static struct completion	device_root_tasks_done;
 
 /**
  * Shutdown device tree with root started in dev. If dev has no children
