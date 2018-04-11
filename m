Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+rUTzD/z11Vutv5gXbhlk52pHH3xq8EJAkXJVQqDRAZ65eMT1uBxXlUd9Ci+46VJ4cQZ+
ARC-Seal: i=1; a=rsa-sha256; t=1523473313; cv=none;
        d=google.com; s=arc-20160816;
        b=NhnrlbfiwTQe8V+vUPftP6aCyv+AQXgzp289sswfF7FFycDaCBAUMm/3JSn8BcUHz2
         QqfSLYn+H69mQN7TcarrISZTQx7cI/F1perOu82u0BtXJuEluxvbYS6rO+znszP9ZS2t
         wrpXHaM/ywG7EXEJHgSpqh314++cc1ebCg2jjeG080v6jUSudoQk8Q52fEcPU259sNRW
         17/hfu5Fr47p9AWWDKG6IUgFRiigYtDsmfQYCVx2elYuYtalvhF/USjg8hpbKBmNXaFv
         1y8EaC6JTfyL42wuQe/JH2YSXxfaMa+hcD42UISnj8/vHYUA3QfDNi7FaU6mPDiC2HIH
         VeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/kOZtC4W8CJV8hwVv+rCuFyVOhG4A6TAoPsQkiNodtY=;
        b=IWZ+aD/bicAkrmk+DFsDHROwkBuZAdrQnsxJhepjpKZBGDMmBNVyukYQaLVfErtOPm
         rVfKRBtSi3DTK8VK5CTtuIVkzAjVeLd0scjwZFgP5XnBTnDGj2mlMBIkMXhuJf4PcPqV
         dpdfqOY8Jypz9p1N0Nrcyva6tTm+G/Ja+93CDuD//Q5HrZP6E+63+WywTB9/ovaKN+K5
         OC0u9vnqmkBf8BR+yYPG7kjzFTNVAQQx7uU+WHmXJ/pF+OMXBHjkKYjVkbwX421TMPNI
         5oHOh8577BjRcaRUx6jZJO7wKB80zFGZSMduMGY+/2y1bExpNAkqY/tg2ErccyVLkSk8
         uywQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 202/310] iwlwifi: fix min API version for 7265D, 3168, 8000 and 8265
Date: Wed, 11 Apr 2018 20:35:41 +0200
Message-Id: <20180411183631.266673968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477553242083173?=
X-GMAIL-MSGID: =?utf-8?q?1597477553242083173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>


[ Upstream commit 15098803d38778070b8edfa5a3d5fc4fef10d0a1 ]

In a previous commit, we removed support for API versions earlier than
22 for these NICs.  By mistake, the *_UCODE_API_MIN definitions were
set to 17.  Fix that.

Fixes: 4b87e5af638b ("iwlwifi: remove support for fw older than -17 and -22")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-7000.c |    4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-8000.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-7000.c
@@ -79,8 +79,8 @@
 /* Lowest firmware API version supported */
 #define IWL7260_UCODE_API_MIN	17
 #define IWL7265_UCODE_API_MIN	17
-#define IWL7265D_UCODE_API_MIN	17
-#define IWL3168_UCODE_API_MIN	20
+#define IWL7265D_UCODE_API_MIN	22
+#define IWL3168_UCODE_API_MIN	22
 
 /* NVM versions */
 #define IWL7260_NVM_VERSION		0x0a1d
--- a/drivers/net/wireless/intel/iwlwifi/iwl-8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-8000.c
@@ -74,8 +74,8 @@
 #define IWL8265_UCODE_API_MAX	26
 
 /* Lowest firmware API version supported */
-#define IWL8000_UCODE_API_MIN	17
-#define IWL8265_UCODE_API_MIN	20
+#define IWL8000_UCODE_API_MIN	22
+#define IWL8265_UCODE_API_MIN	22
 
 /* NVM versions */
 #define IWL8000_NVM_VERSION		0x0a1d
