Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuSpdNicTkhN1NHKx9dZb+r/vVOHIWx/ekuJDbg7/Wr0LiApCEnXoJ4IYGc0uTJOnffz0xk
ARC-Seal: i=1; a=rsa-sha256; t=1521483998; cv=none;
        d=google.com; s=arc-20160816;
        b=Zmhd1Ggg/hjbfjPZ5KmpT8WDuycEqV0E0qgknz7Cz/nZ4yPs53V/vNNPj7R2naGatd
         MS78oIyYlUoIVWMijP81Fng0bKXlliLRx849A7+42XFGTjoQvCmKruVy4d7nAOaMvYjv
         GCQ15pinJccWj3N8o+49PpgL4GGLMPr/ptRY27HOC9G9mdEBE7RNVXjp0FNrFld54mZl
         gU5vjZ2ZNRhZFftbyah5zqCzQvj4d4+pa1kpJpYiewkh34MVEsSRzM2l3kQ/x8A6GbKS
         UsEdkCliRVUpNqKanQazccu6j9tnZiy/11aDAqnCDZcEmH5ti/Y/cc+KXRYKMKbzXWOH
         rJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gT8MKp3EWMzw0ynoS/eMq/JOxE1Ik8gYGCsMnbkxua0=;
        b=dcnBsYdJcF+9ddhh4jnZB5f1UDc6z31wdm35ONbsoz3Px4ywV8U1qyCYJpGLHVQuS5
         3wA5O8/SeIiaKq9F+NIkQNpUjNu48QTInPa0wKd/62q5coblgOw4JzXS/sHJi6COSJzn
         Iqeux7dQlNypAat+A5AaOkrPRJuMDGvEOoGV8/f2NwxHm9KSXMX4om5Nkr4Rm0FX30G3
         KItbU7nd6/OSX+STjul+wdI2N+Qvp+n6iencI5oefAHe9BwofItctakz67ojTTrYF06g
         3u4opPwuSw9FI7qeVrg/pZrdp+lLdRbrgE3X5iiSlou8wzlcQVWYdFs5gM/HCFpJ9auX
         /K8g==
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
Subject: [PATCH 4.9 195/241] scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
Date: Mon, 19 Mar 2018 19:07:40 +0100
Message-Id: <20180319180759.232959497@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390620005177642?=
X-GMAIL-MSGID: =?utf-8?q?1595391605845927254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
