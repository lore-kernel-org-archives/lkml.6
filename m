Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrXcAyeiUeLGOHeIV3Qj86Tc/cQ1tfEjQLlVYO1dt2ZrizrN7T84/Opv813ZZGpU0RvxBow
ARC-Seal: i=1; a=rsa-sha256; t=1526280652; cv=none;
        d=google.com; s=arc-20160816;
        b=EO8Z7cP2/XZwBBNU//IN3+3Wyqf0v13NI0Cupce3WAXTDEcIKqC+WMZXe0DPSgFZa8
         AEm1o9rwg+wXUTrOAfqOxjN3HM3toHWoV83yRkJhLd7qukAqGx1cxDDHyGJwgcDatymy
         T458909dNSL7nJx7qDSCDssnDemAYvAsz2Nyrrmuzd7MgY/mPKDZnjbeqL7CUYNoi4m6
         4LcQ1IMyze468UVnIkirmIsW26viQ8Kf80tRjQ6fKJJV3n4xj7JQK7DVkqBXO1Zj3T0W
         NjuKNiX09U6pvLujMwPGmZ8krcL8zTe/v9SWK3Rn5n41OAivyUCM0reJx8nb8HxHUQwJ
         6Kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0n49mFgtOGcg7cSLLzEyOwOlo9KHhjD+deMaOUvI0LI=;
        b=0h3BNa1UOzjuDJIaGWpIkC/3r5LO/eKj+2oRms7R1uG7x9vyTLjZXFMyGTnSiWk4c3
         HDH1YLj5JR6TPoLDlf18V6nyIXKzEM7AyW0PxhCO8ZSwmAravKzpwL28stTZajDLuhhK
         X720gxxogM/57MUfdTlbg2eqfnxGNfF5KWsvyqosoFZets5x85yM6zY/zct5TOo+6eM2
         4VLfluaVK13Bp2FFpuBk/216/IF9F7+lLANC2QIGQoFzcPvdPP1OwI2lopzb1D2AHMCx
         3Rnr1ZUrmpUkoZ6wJt3hp3+nyu7Wi0EZ5O2PfJkc9A1LqmpCnXeXiByiL87QOK6STThG
         nCSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fuYIh1ma;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fuYIh1ma;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3.18 20/23] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Mon, 14 May 2018 08:48:49 +0200
Message-Id: <20180514064704.897114401@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421262061858656?=
X-GMAIL-MSGID: =?utf-8?q?1600421262061858656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 184add2ca23ce5edcac0ab9c3b9be13f91e7b567 upstream.

Richard Jones has reported that using med_power_with_dipm on a T450s
with a Sandisk SD7UB3Q256G1001 SSD (firmware version X2180501) is
causing the machine to hang.

Switching the LPM to max_performance fixes this, so it seems that
this Sandisk SSD does not handle LPM well.

Note in the past there have been bug-reports about the following
Sandisk models not working with min_power, so we may need to extend
the quirk list in the future: name - firmware
Sandisk SD6SB2M512G1022I   - X210400
Sandisk SD6PP4M-256G-1006  - A200906

Cc: stable@vger.kernel.org
Cc: Richard W.M. Jones <rjones@redhat.com>
Reported-and-tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4244,6 +4244,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
