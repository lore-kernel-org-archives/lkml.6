Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsx8JBtbZ9BDt9AbEgnhDuh9qSzgiBM8nTqq2raLheQ7dSoHZm7E++LLZ97khKBI8A92kJj
ARC-Seal: i=1; a=rsa-sha256; t=1521483059; cv=none;
        d=google.com; s=arc-20160816;
        b=DNqbOScMZ3Uy0fYlaxz+0C9cKdptTwZNUNODvPAssBpKCle0j6FI7QhXQjKNhRS3+A
         ks5aQB3E+bSAuqBwlkK8NYWPwJNLfQmnBHOBDauqX96k42hgFs3NINyfRp2dIEENBm0m
         YE8Anm97FZuIMmpdcq1zzJNMGy6zKXKyDbmdm6g/DdMl0O/g8NiaX1U6+XZ4DiRqJLlo
         uFrcg7D7nGjDNgA9t4QlUbLtc56HG9azSju/ZmFVVDNfGHO5+woMDNuq/VVSqzP9h+e+
         uUwFV/d1fz0cGRmQ001sZj88n2tKouy5xfe356Jddg8M59fQmjTeV7e13TnSdZXGIfkV
         m2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q0YSAiRd5TRMjGhMZ0pfXvbJLSb/IXcLlInqLicToTk=;
        b=KMaLtO/17QzhITXrrw2Q/8jgNUy/VHCz+S4sPLVFWoGuoOR8KuY/CS6B11g0zo8yPl
         PGoXNdW8w/mEvcit2tzIJZ4agbh20GjzNKPHQ6qTTaxi+xHM3Y+RlDksWELI6IncRgrP
         KicaLjsRDhOw41Hb42Z/yLNK4kJbqPDmQYPpd16587o116iyi+1QgPz0Am0uOuXRdXYq
         CHWUuJIR/5FPmkMHJH7Tk9ibFUd8mpb8zg3UMPT2dAUAYA23l6Wnb2/FRIjtoKpeZzcu
         RMRqBnaZxU5wpkbY9wddn2l6VRA7zGOLy1TIq80AluJjr57FbDZkytxZSiS4oIWtyMlT
         ykeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Takahiro Yasui <takahiro.yasui@hds.com>,
	Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	SCSI ML <linux-scsi@vger.kernel.org>,
	Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 53/68] scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
Date: Mon, 19 Mar 2018 19:06:31 +0100
Message-Id: <20180319171835.301256869@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390620005177642?=
X-GMAIL-MSGID: =?utf-8?q?1595390620005177642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xose Vazquez Perez <xose.vazquez@gmail.com>


[ Upstream commit b369a0471503130cfc74f9f62071db97f48948c3 ]

Commit 56f3d383f37b ("scsi: scsi_devinfo: Add TRY_VPD_PAGES to HITACHI
OPEN-V blacklist entry") modified some Hitachi entries:

    HITACHI is always supporting VPD pages, even though it's claiming to
    support SCSI Revision 3 only.

The same should have been done also for HP-rebranded.

[mkp: checkpatch and tweaked commit message]

Cc: Hannes Reinecke <hare@suse.de>
Cc: Takahiro Yasui <takahiro.yasui@hds.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_devinfo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -180,7 +180,7 @@ static struct {
 	{"HITACHI", "6586-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HITACHI", "6588-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HP", "A6189A", NULL, BLIST_SPARSELUN | BLIST_LARGELUN},	/* HP VA7400 */
-	{"HP", "OPEN-", "*", BLIST_REPORTLUN2}, /* HP XP Arrays */
+	{"HP", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES}, /* HP XP Arrays */
 	{"HP", "NetRAID-4M", NULL, BLIST_FORCELUN},
 	{"HP", "HSV100", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
 	{"HP", "C1557A", NULL, BLIST_FORCELUN},
