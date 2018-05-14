Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrenbR5CXDKFY7Fl0+fYhN28z9naXboFdEEuSOgCWjNHX8Dn4/11789twcaM6cWzaiWT9Ok
ARC-Seal: i=1; a=rsa-sha256; t=1526280755; cv=none;
        d=google.com; s=arc-20160816;
        b=kQjUUiOtS0s0oWNmoEakEhWAImijI2tEsUA3K/+YLDe2zFO6RoHZpm8rKOaF74uo2a
         6qaqgda/SWJrjwguCy8IcFg8ugBPoTxHw7ORmwiaenxkUntMEegdKzC/aIJJp2xf4qlU
         UKr3VbfBkGQBGQCFMhiZkVSZdv0aZUxU0RS3zw5HqI72mVbXYwAYQxLKVgqWJhrCxc4/
         QNIy96RXNteiL9a8IgN1ivgy9EivUkgg2DWuwNMNp7iP1GpEehrIqdKBSyTIRf2swyf6
         9bbsxT+DIwvEfhYpgy7NLPnA35Gq7nZYAmi0daw/7qC7zszrvcC+sBHAXrztOnx8qbs4
         MX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AJVCl6hL0lmp9DD/PtmhUX8dmGDr8l0PN+LFO34Qdx0=;
        b=EtDfsny5MdMM8rSFN5kbmdnNI++2kMR0xD/lh4w79B1f9v7FvkDTrrBaw58nja1EiJ
         aV9c/sKbTW3b82JfWMXIOHom35Va6JBAPLaObjQRlFHBHMz+9dEG4gECrNQn7FxB6pkC
         1P/CuzP3zgIiQLWCCctpmNgJQkML08n6zj8WtcnevJ+/pFCacWFH7OWzcaKUNNOx9nnL
         NpAjPkI8ZURwaPgBfYVTCqoXHrOKHCNXXUNsARiPJAPXEIdpNPdYIOXf52iyhzYCFRTt
         ioZRbpa/RjIh4+gIv4f240QrIHPzCagUXtM9bL2W3uBFir/EVpxJAXHr2YsvbzSbuKV4
         UiIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TvTSxQLg;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TvTSxQLg;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 45/56] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Mon, 14 May 2018 08:48:50 +0200
Message-Id: <20180514064758.941240441@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421262061858656?=
X-GMAIL-MSGID: =?utf-8?q?1600421369355703218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4243,6 +4243,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
