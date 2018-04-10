Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kjJyhs3qh97FlPDh/6kFCrSwqT0ZXVpadtUfjcECp9Nqr5iRdrRTCPPcyv7VVT38QaOFT
ARC-Seal: i=1; a=rsa-sha256; t=1523399566; cv=none;
        d=google.com; s=arc-20160816;
        b=FhmbrBx+GSWD+MkcWerxD7xNIYmiQ8Jp11+wD7zn23XkvjlOESwsJcunTpSnhskqDi
         Zg/xcUrHDx8Debwxj7G13we9bY7jFJ5KOWC8Ajn4/YduY1uRf8AEjrsHW+KNcY8gNPJ2
         1bKLyN9AzIhBtVi3hvgIgbgfVW2CwrmMvHWQF/wa+UCuFItz42bNRuHz0BLz2F80mfic
         l2uljDGj6X2uScC7+5VioD9zBnzRuK6aFTGi0b8teBunTtlwYtvP+crWdZY4svPxEFL7
         7TwdqGkUUiACmRfEkFHfHD6SI5m+P64/YflbyG3O05HzY/WfND6zXIH1k9v3Z5Xdybvn
         crgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t6blN8JmqumQm60G8XGZ6lWUZRL9dXUCs12aJC74CKI=;
        b=QPFsEnvDF5zQqFubB1J8ZKNnlxo3CoyDzfhivaUAULdEZhgPEz/moiCBUWEZWX2+W0
         2CgLnnFkZ/E50RWZ7ERK9kA+maWFiOmc3fEPAfDgP4LoL/tzlTBtkfCSWV8kVQDJyvAG
         vY4NYf24SjmtGc1+ETg71q590N6VbCcLehHM2QhtD99qbHZQMbgnCOffV2C3UADRh8is
         gmY1sUONO7S+OE6X+GQftvl9G9Z5xSdyB5U2/4AbJU5hIX79N1QSVSjG4IxxaNh9/yyz
         m/Ou+aEctk2OMSCKlAuZQWWDqzL8tTEqDBrHpFgijDAMWq0aQ3h+pmPAnQ/ld7S+o4pA
         VnMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 136/168] sky2: Increase D3 delay to sky2 stops working after suspend
Date: Wed, 11 Apr 2018 00:24:38 +0200
Message-Id: <20180410212806.840677404@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399712936546104?=
X-GMAIL-MSGID: =?utf-8?q?1597400224410886535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>


[ Upstream commit afb133637071be6deeb8b3d0e55593ffbf63c527 ]

The sky2 ethernet stops working after system resume from suspend:
[ 582.852065] sky2 0000:04:00.0: Refused to change power state, currently in D3

The current 150ms delay is not enough, change it to 200ms can solve the
issue.

BugLink: https://bugs.launchpad.net/bugs/1758507
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/sky2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5087,7 +5087,7 @@ static int sky2_probe(struct pci_dev *pd
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 150;
+	pdev->d3_delay = 200;
 
 	return 0;
 
