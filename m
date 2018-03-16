Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELspeZJVFNhCVPGwWDUn/f0cTaeypHWV/Jk46MhqOrLXoC4H4jId3J7lw9UfRIqTbjn1FpCk
ARC-Seal: i=1; a=rsa-sha256; t=1521215025; cv=none;
        d=google.com; s=arc-20160816;
        b=z7+FThuNv85BDGvE9AUsHIKCUaPbfWNWAvFljH3Pv2Vyns4vHpNMXGJRWJ2Jw/2zhl
         XidPmYiMlbNt7fhhZa+qEvNnFzPHebDeZMA9qAxW84x5wVIiFdUq2zeHHGuYe5edFLVQ
         dPJ1LFdXN1WOfls51bx692Kjztxm3d8vI6U+AynpW3FbAF4Whmcj0slMGsuwaWmiRDzT
         qB2T7ggYBwOzcpx9TPNuYrdnXgaam2CJ7N0Vgu2f8bQRuUAR7ssJUgBODbuQgIWD99qv
         VDcI+WpBDkHUehrfMiS6IcgnzbcZYw6CF2ImwvLDJ1Fu2AR9uxDIn3dWEDwHlO1XwmiV
         42Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3M2nqLZNk1z5yRrn3ELGBwE2J7pcFzruFSxi0H3M2w4=;
        b=V8tMA7Myb8BAk1jvtgJjsZ5GyjF8QHGFDy64wWL6hrU70pX+WF34/kboRafEAqVJqb
         6xf2CSdYZGbQBuztkQalYoYvcJOsPuRjqZ7iej/FVKyQYPHQkbjCSorNYP69YKabcIQC
         fyuB9BKabueJ8i8haZLhhNbBm6XYKfnEmz5SBP84g27ikM3GHvRh9buzdVsdI7+r7+5f
         m6QgG/O4d8MH41Z+P3FsDmtoH2ece3svg8EsCEKCh4AeRKf6/xrK2ceX9oeEIr1RfNnF
         ssIaGYUC2aKpq6S+ATL1T0LmDDl4ozXE7xlq3QvVJ9mZJ+TfkWDtMPlNR1NEl+BuYEU8
         JxAA==
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
Subject: [PATCH 4.15 101/128] scsi: dh: add new rdac devices
Date: Fri, 16 Mar 2018 16:24:02 +0100
Message-Id: <20180316152341.584575440@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109205834642512?=
X-GMAIL-MSGID: =?utf-8?q?1595109566668528176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
