Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvLNd+nSanbmnGctL/3W7uEwoAHWZNpapugA8ItxdFdA+nez9uBWT1W520aB/ttnbeIjkL9
ARC-Seal: i=1; a=rsa-sha256; t=1521214681; cv=none;
        d=google.com; s=arc-20160816;
        b=nxdOqluCsDOzQok+wUE/fiR4rr4gMqjHtvUN2Ffh7YC2DJGIyM2uS3c9i4RSB4RW1x
         V0P8tIZMVBND3DurMqXRP9TB6NOdsWLvsXcT9SQh2mZlOUHUIJMVXjbrZRIUV8M/CKH0
         N4yeYO7BxYUd8bja736Nb+ijRXWx/KrYFTOlMpb3pp387Y17OMwJ02+KJHGYVshkV+uF
         qN8u+ZjOKdoCm06GoNIBGr4FA66lYV2Hrh1arNl91wN1B9qTSX0Q/7Bd3TsRssk3gjaJ
         D0n+xNiCPIrw6uLxMlbVzkuAZnF9JiEHZGMgt0sN5i1sZZx4+VTOPyGJjEuGEFLuzMgA
         w6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sd2xeFsndEGIMFn4UhPENaBfhk5yeaSmIWaTdQbZqmk=;
        b=jERHWrV9sYtW1DzPnd/r1Ec4XL1Q8Cm52JKKmn1Eaf5OvujYYUCpc+5UKL5PZBvFLb
         j/iL6qT3R0iEhngRJ1N/QkTyr/CH/Abq4pvQIXgfAMP/B8r47ZSm1q6gP2X89Xa8N5P4
         V4D/ZGN54isLyPd4dBZtkml+kEKBMpoFP/mkce22ARUtbi3L2mIaYJM9W3ubF2wjkc2e
         nPzRkSk//jmG3CS5oVM+KMOgiRcViczK+yoBWpZFftpw7iKzx3+4Jkkt6vrRwtlaD65a
         MengPjNGtRxWGvGhAFyfm3QEOSCsCdfRN/FNRXfvP0nebziB3cdFtDKdm0i56aDuD+Jm
         urVA==
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
Subject: [PATCH 4.14 084/109] scsi: dh: add new rdac devices
Date: Fri, 16 Mar 2018 16:23:53 +0100
Message-Id: <20180316152334.514320863@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109205834642512?=
X-GMAIL-MSGID: =?utf-8?q?1595109205834642512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
