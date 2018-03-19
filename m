Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELusnqrdXj7cLTpmzqFS9MYtAx/5VWbOzggEjqGJIL1nsX1LBsOvZNQr+DVz0rMw51Qt0gwa
ARC-Seal: i=1; a=rsa-sha256; t=1521484004; cv=none;
        d=google.com; s=arc-20160816;
        b=WDUHVrxiPoCCSyTQaCPqnE0g4kGVZLU5WOSj8gMSV+lrL99MkchAa1l8jTjUuX8i1f
         rgS3D6m4f09IBP46RsEYci2ztaZPBrBq9PEhji47+R3RNQV91QVbAhAlz6eqD6cBpKtl
         P9EogpDyeyYOVl21DKveXDstxuWGi75/nzve+POOfkpCuTAvgzh6kvZaGjmOOuPbJUkt
         hPJxPvjv0gRn1Xz1uD4rO+qf6OeG4YaEhaXI8FKu9YOIS7bXaIN5UpVZVQZ5WSvMj0at
         thzNZ/LAvcZQtpmK3c9TU5cHjXLRmPjIrWiL0/aTyT2JUwwvBFf56N8EdfEUU/lAcBx4
         4dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6ZbTLjYnGr/UMuMrtvlEdPqizw7VkYBklbZKVyKW9K4=;
        b=VzCBH5cK/PNLgNhQTw2YjFl5ubPaIURI05lMV1rbOANb4tfhH5j/PFoQbfEV/wuHPo
         3fBw3g7JNOcNBL90+b2rDrFcMSrqfKJ5pRlts2wyf+SX1zIzuVXLBVdXA1TwTXK1PPFY
         Qmm7eIIY9MgxNhLGFK9csfE1US0iBUBzjNJ3tXvqgvZ2k23JMUePWtHMNrsQo62wsUCu
         UqjzBrQ+OQZHecsApHVU79zeszXJhJ6PsgkVh+PeB0XakkZVl6mn3gYfq8gKB9q316ai
         79SG5r6mGtjmz9B3LZcOUKG/cm8UQRnJGkHIByUXyn4gGdf9MUdpGgmeuTOWQPOBPB3S
         eM5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
	Hannes Reinecke <hare@suse.de>,
	Christophe Varoqui <christophe.varoqui@opensvc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	SCSI ML <linux-scsi@vger.kernel.org>,
	device-mapper development <dm-devel@redhat.com>,
	Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 196/241] scsi: dh: add new rdac devices
Date: Mon, 19 Mar 2018 19:07:41 +0100
Message-Id: <20180319180759.278873126@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390947989892367?=
X-GMAIL-MSGID: =?utf-8?q?1595391611155146493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xose Vazquez Perez <xose.vazquez@gmail.com>


[ Upstream commit 4b3aec2bbbce1c35f50e7475a9fd78d24b9ea4ea ]

Add IBM 3542 and 3552, arrays: FAStT200 and FAStT500.

Add full STK OPENstorage family, arrays: 9176, D173, D178, D210, D220,
D240 and D280.

Add STK BladeCtlr family, arrays: B210, B220, B240 and B280.

These changes were done in multipath-tools time ago.

Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Cc: device-mapper development <dm-devel@redhat.com>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_dh.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -56,10 +56,13 @@ static const struct scsi_dh_blist scsi_d
 	{"IBM", "1815",			"rdac", },
 	{"IBM", "1818",			"rdac", },
 	{"IBM", "3526",			"rdac", },
+	{"IBM", "3542",			"rdac", },
+	{"IBM", "3552",			"rdac", },
 	{"SGI", "TP9",			"rdac", },
 	{"SGI", "IS",			"rdac", },
-	{"STK", "OPENstorage D280",	"rdac", },
+	{"STK", "OPENstorage",		"rdac", },
 	{"STK", "FLEXLINE 380",		"rdac", },
+	{"STK", "BladeCtlr",		"rdac", },
 	{"SUN", "CSM",			"rdac", },
 	{"SUN", "LCSM100",		"rdac", },
 	{"SUN", "STK6580_6780",		"rdac", },
