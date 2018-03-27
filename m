Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49F2V0m7v9ubZI6ojs7OtZVaR5lFIjvFjfQevTZG45Jy4gi/TY1kz63RQ5fiabaxME3nb2L
ARC-Seal: i=1; a=rsa-sha256; t=1522168517; cv=none;
        d=google.com; s=arc-20160816;
        b=C9d/7iMdONudbPSw15ZacN4Vol7qYbnYcvKHJLyajoPz1ubcWQUNeacH3E9flqE930
         REgkFD/w8K78E92sXJteRL764e3SL+Q/WtnlaguMYI6m5tdG++M8OVMUbnWtlbdTm649
         UbpcusEJh69eB6YpmTRDyRPgUHub6ubgqY6a3vU+W+ic4kHtTEzkn+IPcDInCm/WUTHZ
         KYZZD/wapZPe7ovUayDTmmThQzxbzX2tSJEuOTPJrn6T8ZnJCcGPz796jv3Mj4NMiNmJ
         b3g0jTiKHzIIvtEKnxlWx6uqwAIIOJ/PteicqWDnUKmrMJ1KGN97qbaMfEphGSER/xBl
         zAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=71+IO32UZaK18iDQ7DJhcrd1QoCHWkXU316KsepQJng=;
        b=XP2Z6X1Mhy1ngjxYlBpr8DAWZdVoxNa0ZgAtNhlBUOvR+Rb/5ULDbBmHswnVYb1CbF
         kbSDko1Fxxx4ZRQEMhfDsDwXUlBEBXtzF2eyCihgAqj/i3jbVNGxLAHeqDEa9Rjla6Fx
         4jrHcQXI0NJsXAZvH3WPAMxdWHy5NeQg0XqIiUBA0XWuC44OT/vP9Q5u/ng6vkJ8wpFR
         55Ya8S7S77PvsdAthnyEd6xrX6AhcHSE21+KQXQSIZx2olRm/7ZPV92Fnk4HiOeCRkiY
         aXnxBtDeqJyAqDZ6My7TLvEuM6gLqlkWOnx6f/ofymVnx4u73Wt/vxnYHia0wH3rd8Ad
         OQjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Park Ju Hyung <qkrwngud825@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 039/101] libata: Enable queued TRIM for Samsung SSD 860
Date: Tue, 27 Mar 2018 18:27:11 +0200
Message-Id: <20180327162752.410671057@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108977196194202?=
X-GMAIL-MSGID: =?utf-8?q?1596109375492434310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ju Hyung Park <qkrwngud825@gmail.com>

commit ca6bfcb2f6d9deab3924bf901e73622a94900473 upstream.

Samsung explicitly states that queued TRIM is supported for Linux with
860 PRO and 860 EVO.

Make the previous blacklist to cover only 840 and 850 series.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4539,7 +4539,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
