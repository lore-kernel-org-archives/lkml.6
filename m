Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqtlnIO4n/YUKK2sOOvtq4XY24gZrsutfczN/u1OKmDOkJKm++msZTOeFfmDxqvAdSZNzue
ARC-Seal: i=1; a=rsa-sha256; t=1526280980; cv=none;
        d=google.com; s=arc-20160816;
        b=vPM2KqcX9WRG7EmEarYZLuHYrjEJjoBHJ6LVrfRVeDph0Y22lr/MNhI3euIYgncz/4
         ZbuwukuwlDiSKGMeSNfwReXpYca6Q2NWzSkggb8nq5m1S9bvdwmvGjg3qRtmNH5qR2U0
         BW4SvXFxq8aIk8J9eNwmrTtzC5Yzkx6zdOLR1KvQeyQdFhymtvt2yD3FCzk6efUJOJll
         eg0oDCoMaiYekR8XXH/wU+/kqXXfgPrFo+nUeigcdyePecxf2VZqtraO6IQpTqUDcD0D
         khiD6hrpcbu5LRN5eZLWgQ9tMQ13DbqmgvW9yaFMXHIZkQ82P8Es0Kf/BzIle+D9tuLY
         hGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+56dm5rdShTFpFdj5pmmVVhICCT761CQR/gS6SalmWQ=;
        b=mdr3s0TjH+Aoa86X9xiHoVbXK8703buk3TJAnJfGQsfZwmHjv9iY43JNLftLE//VrI
         gw6YJoq1/9sHFPDIjyz0wAkMO5ntuqXxeiuzskknsE3WC2PflY1YJyfJozNTHEeYr8Gu
         9t6x7yC/FsVcdstTrUgXa8MtRKpTkgQUfICT3CLd87X1j+iQIhljKD0wOZoqhGMempwd
         Q4xpkJFk3SfaveOu6dItGJ3Rgu6iuOjpYxsLDFvZQOi7KmVKN6NBreL0V107JCwlIVa4
         uUNVZ3tNj853jkGABA8uCTfM443vhwih9fBYg52X5lKPNk+iCshAIu+w6lgBjym2ttLL
         7UHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2Sc3PXFP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2Sc3PXFP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 27/62] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Mon, 14 May 2018 08:48:43 +0200
Message-Id: <20180514064817.880897596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421262061858656?=
X-GMAIL-MSGID: =?utf-8?q?1600421605218768440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4539,6 +4539,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
