Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu0JM5JTPxfmNesfvF8JF3T301ZtwHkCbehY9vJnHqXoO945dU1bjmvpXkNdrtgbn2o7qN5
ARC-Seal: i=1; a=rsa-sha256; t=1521215022; cv=none;
        d=google.com; s=arc-20160816;
        b=oA8dGdvcC+Lp7DUoeO/jNCokVU+T4rha/NiA1w61jjW9qWXBgzlUxn31QWyxUOcZlv
         u17g90VdugAHOyz0gaRU7DUsGjGizKsC5l3S78HPMNVL5XX+v4Splcyf4QFBa7kzzfei
         toDpxJqFqMsp8Td3EuIWYU1ZFmmHmau3A8Njg1HA/OH7CKL1Kfq1uuwJ0aLjHcMuao7/
         UncVyD3QcN++Bd/0IiwIneTEt9cy6DjclEOVvIdN5AHGw/nGCFNbcoBaFR7vypgzJd98
         sAHAuNGJBnv+YlyCVix/+UfvYlQcqoUAohMhM28YTecUeJeN8IpPygFGPiVlFSBkna+i
         WktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lW8pAK/U+wF4HCWrhzwam7kSJQcY3m+RjwKZr3WKHvQ=;
        b=LxuzNcsPIAY6rP2rGzIttpNsDO3F47lL8OSeVUs6twsE0LABSppAJtCmrcOXIGC4Wu
         yv+95bC6hLbCg52IKWj4wfVMmwCpU0i0V8Z+En9tNuzHU6aoySYw65BYC6ak3b6CUNTS
         9F6i3k9a4yAJL+F4snvVQ71G6wRzgaoGVdwmq+0gsj5HBGoKHkkg5hkL+eeq5fFi3gFF
         7vldgQg+7Ej49MDN9B2r3MUsZV/4umTsWCm8ea+/i960TYfQK8Suh39+NobCOuvLF9sT
         4eta9OnJC5QRdWgIs0Wu7eXLFjQp3D+nwls/EZlwJ0kWqiTZBW0/cJtZYOUNlsECz+Cl
         orIw==
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
Subject: [PATCH 4.15 100/128] scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
Date: Fri, 16 Mar 2018 16:24:01 +0100
Message-Id: <20180316152341.533590815@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109204487036069?=
X-GMAIL-MSGID: =?utf-8?q?1595109564056581117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -181,7 +181,7 @@ static struct {
 	{"HITACHI", "6586-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HITACHI", "6588-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HP", "A6189A", NULL, BLIST_SPARSELUN | BLIST_LARGELUN},	/* HP VA7400 */
-	{"HP", "OPEN-", "*", BLIST_REPORTLUN2}, /* HP XP Arrays */
+	{"HP", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES}, /* HP XP Arrays */
 	{"HP", "NetRAID-4M", NULL, BLIST_FORCELUN},
 	{"HP", "HSV100", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
 	{"HP", "C1557A", NULL, BLIST_FORCELUN},
