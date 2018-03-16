Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoTBcqFIrdDzbExdeWd7AwaZF1pwngyF1zCdQOk1a+/2JAmYf3RekROxUNkwE0AqYf/ybs
ARC-Seal: i=1; a=rsa-sha256; t=1521214680; cv=none;
        d=google.com; s=arc-20160816;
        b=OsoWkFhlDCMQlbhE6kgw/C0rL3Vr01XsohQ7j6Q5Xp4nmwY42I8xJdNSs+QqQtpf0Y
         7xu//gFdIfBPLAJ4dOL9ULdqGPl3RHyghp3H0zX2ZSduNY/umtyVzuUT8DbUkQGDY1lm
         QRIgd1JVboUj1v8sCeJ5cuAU4TbX9ZKl31xqVmXEtChY1JTaKzPqQ35h4D4Klnk+MF4P
         KAfRpzFrxycwfBCcOCDg+x52DCC+C94tMfmWK8AA/LnHU479Dj9yC3G3yAUaDwJ3TLLA
         2CYEyFJL28NS1ZXYhINw1uz/BHGfdTopiPBS5rkqL8OaAqSaJhsB0L+w/OgM/AkmQOqO
         qIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RL9b4wQ3bdODx9HNwcRTyWydaYDK7nV9jk8kQHbQ0/0=;
        b=NCgpq4jyy8awlYkDUfeY/l6bC5FfGd0r4a5zd9FxLyOy0GZL+guFhEOf1yp5E4sQqG
         5x/FUg0uLt+8svHgpZcHUA4eC5nH5RE+JV2RsxoEa8Dckss/W8BVvxWE25Iibxi4dF77
         AIXng+3u64VjVmmRPF9jthdUKvhjSpVEYGUg+wnGcjIML4zC332iNcFFQ+OHQ6F1UYBv
         OwK3dWi3LgEkOTvvE3OFc60ODCe+Zn+z+RVWkJhqxMWguFfwfrUNgP9L0nqvOQgY+FE+
         WjXjVFXwao4O5oqQ2paaCVUH5QEN2nf+th40YalT0FbLjWulXB50OA6jSuCDwcSeiNU1
         Qugg==
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
Subject: [PATCH 4.14 083/109] scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
Date: Fri, 16 Mar 2018 16:23:52 +0100
Message-Id: <20180316152334.456044960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109204487036069?=
X-GMAIL-MSGID: =?utf-8?q?1595109204487036069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
