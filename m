Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kiRBHZhSU4oOwTp58YHhl0Ow8VNkpQyK+p+QVzm+d1a2907hzDE8JoiKz8FsZNqyj9IDD
ARC-Seal: i=1; a=rsa-sha256; t=1523472159; cv=none;
        d=google.com; s=arc-20160816;
        b=IW39IhDgNVmWMmWcXbbFOxrLGiUblKlELU5tTYgsAUcurosDMT67fjYZgVqeUWmCxK
         048h0dg/U89bFiKWSWuk5wxdmZR7THqYl4pC+UfSwhst/bJ2T0P5RL964F+yHnhIdvit
         XG3TtK/CNM6ksKtHphFt3Psy1KJ+9t+zH9ChO2w48neQRJApBgy3FzJIU4FHaUidFeLA
         EhhlpvngdSrLQog5NqWTYk2cYHy5KNBkl+HnBvUc17MbaBHh+HjxO5GaJvcTU3L35Ufn
         dMyjM90Z3LO8PEt0in9XajjwL2oLMRpFzhVcapjNQvI3Cer8dJjKatKRiKg+7tQNkgtz
         e+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BhkVb6Xwgx5TyrHmNKuq7+j1C9UXb+j8DG8UhKkg/tk=;
        b=0039Ih97bsvJdPDo3iVxfBPaIX8ef43oH/TxqdM+Z1RmFs+WiAoch6ISQu2cb5O2hR
         rGDOld1t4CmQl8t0ryJTh8SxbIpWBn2RZxYDJx8EMU7xxSGJYveeuBqCf4hCt4mYhmCb
         udCP1+9Ciyz8nS/yoDqBpLF5IZXAVgVQqzTv81vu/O38DO8YjX7YfV1548FCTlpZR+yP
         El4/f6KPP8jAuj5G1n6L7cf0qKPbOC+jCiVeMDdC66LQyr6XwFazyrNS1/CsN33foDMk
         GvE4Q3ZqrGs/XSyBQRnVv+RqJW6Bi3GiN/+yRoBTXvfSiq7SbgGF/7jbNurtZd+EPImU
         vt3A==
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
Subject: [PATCH 3.18 108/121] sky2: Increase D3 delay to sky2 stops working after suspend
Date: Wed, 11 Apr 2018 20:36:51 +0200
Message-Id: <20180411183503.469552313@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476343185334735?=
X-GMAIL-MSGID: =?utf-8?q?1597476343185334735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5069,7 +5069,7 @@ static int sky2_probe(struct pci_dev *pd
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 150;
+	pdev->d3_delay = 200;
 
 	return 0;
 
