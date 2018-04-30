Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqMLA0oe/LvKAUSNlnL9uMY90xWRXNrZ/T982F0zmTwI0+CTlXK7C6PAupuSy+GZaaonBCK
ARC-Seal: i=1; a=rsa-sha256; t=1525116467; cv=none;
        d=google.com; s=arc-20160816;
        b=yMvL8xHzX/SFsH57wvFch2ehRLojq2e6igdxoVSRsopZnsxjpIQxfE32nR4/CRpAgK
         4dQE7bPf0jyGW6Nl4emobDyVqhvTdqo9uF8Wk+Ft6j/nkfEQimvOm5+lWg4akK8yvBcL
         vCmqY4pkmH9FBe355bI+kk4V20EKk4bmlna20GsmXLuwAI3ab4hRLTW+doo8DbP63pT6
         wUxnowGqetgCYhDDeebQzJcQsUjyZG9m38+Q+VAVRN4mncHFw5tHzcObKKZ+n10h6HHC
         iDY/EvZPuxlt+Eug62FjlHo1aYXajFhDVnYsLOWt4HCLwTIcCGTOCYuSpLq/KsJZAaHd
         yX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=D1X59lKzcegB9s5paA7RrPLOw52THZqf1ioN02t+m+0=;
        b=kn/tCueWxzPn7Q6I46S5rXp/vkTyJtlonKdbAFkknA9YdFcQjbDUC4xKiad62yZxZV
         A+JRxBqD3Cfcbbhk2+QrqAbkTx/xqubE7bT+NdFN4QePg6jd1/6Xdh7jDLLraU5swLXM
         mF+BOotGJ0Tm7OKCQUPud4kxfOEyEzStZDjRFhWtV4+z5/8lR8dWraxzdIi99gvx4HCK
         IB8lsjMwfJqUEgg7/7tuItOXH1ApSLnFX8KjFjMgRAAevZBHQJq6oMtVJNdS1pv0N1w5
         XTmcGTULScViNE1QEHpvbCZNdK55QGAAWAiEgbpm3MrC7/Kk6hs1vB7E0lbp8lIyEDOh
         rzlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8822DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thor Thayer <thor.thayer@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.14 67/91] ARM: socfpga_defconfig: Remove QSPI Sector 4K size force
Date: Mon, 30 Apr 2018 12:24:49 -0700
Message-Id: <20180430184007.711867514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200598043427153?=
X-GMAIL-MSGID: =?utf-8?q?1599200525599725191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 6e8fe39989720b87439fee7817a5ca362b16d931 upstream.

Remove QSPI Sector 4K size force which is causing QSPI boot
problems with the JFFS2 root filesystem.

Fixes the following error:
     "Magic bitmask 0x1985 not found at ..."

Cc: stable@vger.kernel.org
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/configs/socfpga_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -57,6 +57,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
 CONFIG_OF_CONFIGFS=y
