Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AIpwx4/BXVphUK9O8N9+injJQ8lGuXfvtAPruygAeKjtv2SbhHguJqpTQ3orFaNpi5cQWyEJVGQt
ARC-Seal: i=1; a=rsa-sha256; t=1522541539; cv=none;
        d=google.com; s=arc-20160816;
        b=FgO65BmGI7WqdkAiTeqnY5cNz7yOrMm5nZJIOKUjf1EvBpkybm8WmT2tF9IGcJjBoJ
         +cdaR1BkNk84X/5+rpHWJo0OV/TtoAVhkf/v8Glv8LdWHzu/PvHJVtC39YHV1mqlyF85
         7fubVKZiEEg+sExq3jve68swSwfKZ/J35M9yHjIdZM/sCi9OBiEjPgJttPpym/DZSMIa
         9wvy8/Muh2wlJk+Sd2bPySEdVcODoN0l0kv9iI1Cyuh1QWTuVMAfhxfWTQoTG0f76urk
         ecacPZzOrtsHABTMQagruNwJJ+YFbx1i/hcRlv0nSg7l9DKMLARAHoVTXJRZvJCIlFe8
         sipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=RwLQ9FHWo5JhY66CzyFPdtnOg27tXGEABj6J+zgbBZg=;
        b=fBQgTnbgtFRis6HxZlpOi0zGmM547gAGxQhPV04C0v6UZ85udbv4fnDXIt8P2a/To7
         JwLSK53836tTBh1z5ZNlO9AVPaMBvko7D7PvZaV0p31CHsDLrUXCA5yVw6aLR/n/ruqu
         kwN+MJxJVP3d/d43M+Lz5nSuFL+Ou8+p/kSD7zrKvIOcJvDLWWRrC9BaMkjxaPOwL3QV
         6bkTu4ZXpgwnMVSlHKZzVqcz6yG7zCD00hkw+n6aCTXnaGo2k6xd/AgBKEmJ+JsdFiwV
         mXw2UNlFOLENJHrNyzTqWffPRzLnhujV6g9YQXrY2/qpt4ug1LNs0Mzup5D1iwWtaOqb
         5KUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,389,1517904000";
   d="scan'208";a="216445919"
Date: Sun, 1 Apr 2018 08:12:05 +0800
From: kbuild test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild-all@01.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	x86@kernel.org, linux-efi@vger.kernel.org
Subject: [RFC PATCH] efi: debugfs_blob[] can be static
Message-ID: <20180401001205.GA24604@lkp-wsm-ep2>
References: <20180331121944.8618-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331121944.8618-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596500517007832501?=
X-GMAIL-MSGID: =?utf-8?q?1596500517007832501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: ac46fdb7891f ("efi: Export boot-services code and data as debugfs-blobs")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 efi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fddc5f7..9f1b8e6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -321,7 +321,7 @@ static inline int efivar_ssdt_load(void) { return 0; }
 
 #define EFI_DEBUGFS_MAX_BLOBS 32
 
-struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
+static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
 
 static void __init efi_debugfs_init(void)
 {
