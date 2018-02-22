Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AH8x226QV6nbK/201Y581vNsPcUIp45O9mco9Xuk3tXCOxsWR2CBzROv1OfPfVC4fVzxmWgHPjsv
ARC-Seal: i=1; a=rsa-sha256; t=1519282928; cv=none;
        d=google.com; s=arc-20160816;
        b=uNGUOvBN9qKpyVJqZ2JPc5oS34j10SOp8eG1iSUSUdLQIbQ3qDLLLRTMA5NPQqZP+U
         XttwEkW51wZMNpoqavezT1AkyCJqe1l6NgLu3+o21EBagQ14+ubtDJ9ou9gc9PVpQXBg
         UfQHgfBoLtw4Z3LLvBJb+OjC3hPr3O3hYaTfkJguRlOmc/yqELaHWWhSkMS+bCeJAuXY
         tGkEDdHthaJpiF1PSi0kjvmF2u5b3X/Tz+Ia3EpKodEYeWHA2cd8fcqzpKWg0Rn2Jgw5
         am8ikVA8y076xH8VU9y/auUjzIFbT5o97NZiBoO3VUgOdOkVxQSbkr1kRTYthr5O8iTq
         l/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ljLfTVYNCMSU3x5DQZkRCHOxalp1pGhRCZ2vlnXeNds=;
        b=ryP7BnJgNVkQRFLVPf0ESy2XIIqndrByQaHbxytJiYmUD/KxBTrKlsGh/naMtioV21
         7UZA8Bw2rwWv7mKQouH7dChQsbhSW8XOM/+t1ot+nCRTiZ3W8J86Un0NMnwsvOqji/lL
         w7fFnJlqWxA8dEkOFgDN+QKCc9J4gHhK0G4Fa3bEkvNmsBomQ6xp1vHSNzfqzDtmkU5L
         V36FOMAszcRUgmqhgezXbR4qeCWztAZ1hF4M134rNzfaVqCjYHhwIWkNiqdwQ6/LMwl/
         JQ7FjECB9N9VW2JAut7Cz/zALvRNxbTAsLcQLFo5EaUJmx92zvux/mqMNhK6YWKVC3WM
         RXmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="28939083"
Date: Thu, 22 Feb 2018 15:01:11 +0800
From: kbuild test robot <lkp@intel.com>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: kbuild-all@01.org, joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [RFC PATCH] drivers/peci: peci_match_id() can be static
Message-ID: <20180222070111.GA22310@lkp-ne02>
References: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593083616553853283?=
X-GMAIL-MSGID: =?utf-8?q?1593083616553853283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: 99f5d2b99ecd ("drivers/peci: Add support for PECI bus driver core")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 peci-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/peci/peci-core.c b/drivers/peci/peci-core.c
index d976c73..4709b8c 100644
--- a/drivers/peci/peci-core.c
+++ b/drivers/peci/peci-core.c
@@ -770,8 +770,8 @@ peci_of_match_device(const struct of_device_id *matches,
 }
 #endif
 
-const struct peci_device_id *peci_match_id(const struct peci_device_id *id,
-					   struct peci_client *client)
+static const struct peci_device_id *peci_match_id(const struct peci_device_id *id,
+						  struct peci_client *client)
 {
 	if (!(id && client))
 		return NULL;
