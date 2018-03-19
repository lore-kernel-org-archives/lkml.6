Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuz2tkQwW8DWIIN14LHZF5aNw1RJzm5nwRxKWNIQH1C/yPm3HJDqgmgs6ttDtuy/5x6TIPx
ARC-Seal: i=1; a=rsa-sha256; t=1521483369; cv=none;
        d=google.com; s=arc-20160816;
        b=nzC40X4Uy9paTQ531J9geKJw6zy7+QB2NIXITZ0BgMxt/ipIQijBHgYbHgNzxqSw2j
         MsLUbbGInqLz5Wpo7cssHBGJKKADhQvS0q9MMY+DX78KdudD/XnJoYdS0wL4VpS0B19L
         UVartwlcvWZ5YlPirWxXKIp1gPQI+ftgQXNv0o6/MlW4nwTqBuLaRYgiHDJuTL06ItrL
         ItjJduODbl6r0I5UByDlcu6FH52dq3D1NEsrcid+5b+s+NWTd/QChh8KDFlEydf610NW
         FZjsFSW0qScV3deGmgt8vfsXyod5W6lfJRpCHp76NzuwnFlgt3MXagg9zPyrt318j8z0
         8t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CUrsjB9h0tCeI/oEQxtp3spDfOF3AlHWWjPWZVPA/PI=;
        b=ZECIyykLk+6yDYkbfWQDtQRiBOYL9F2VtjhkhV2c2LES1bxOs8dXMuRpTzfZzKFFcE
         m+PEoyTTH7QbiWIzIab9tH5BdNsMNljGF1XvDKDKrqflfkGFa1FNjuOMyAS+Bgdwv4aR
         cT77KbQ7bYqXYmxTmAAqM5pw1UWNoV/vqJq2MWqUCllRG80bzMrTVYX2tBA+D9ML2p8m
         bW1TUV+c7VBml+nJ/fLbH/y3HSm4aV87k6YPIprmZmlOYWLHRLhp4TVkaXBk2ZT7JhhY
         EtLP+8D1goZaK1kLaSiG4Pin7Bw8vy/o1RSjn4doanzxF7g+AoDhMYeM6ouTPI4CrkV+
         yOCA==
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
Subject: [PATCH 4.4 098/134] scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
Date: Mon, 19 Mar 2018 19:06:21 +0100
Message-Id: <20180319171903.401420472@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390620005177642?=
X-GMAIL-MSGID: =?utf-8?q?1595390945302124468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
