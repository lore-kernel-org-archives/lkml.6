Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+czvSRDy/vDgxTKXOS7jyOCdvPrE0z8BcFnGFLq/6HmbvaN8HPgMRVm2ylgISUSvpYJmbN
ARC-Seal: i=1; a=rsa-sha256; t=1523399079; cv=none;
        d=google.com; s=arc-20160816;
        b=uDnaKc00kG92jsdifJN5Tj/bDvmfQncahH9x9R0bqK38zjOdoorNBu6WPhwd6uI86+
         nzopLaWETIxkqGzH5kuegCw3doO8f+AVqdhns93YB6k7iPXg1wpLiyU+tINcpOW3PZF+
         JstNF2qLGobFqz5P/00KZ8n6SlOG17X9lEbY9m4lVZapIrBZy+bpF5chVQbuq9SjXtuO
         lwG9QFcto5BzTVN+CmyYVEKZikvjuuQTwj50rTi/B53Bnk8CMaeSQdArxrl12BubtfTL
         MIKg/2mrwwZiuYKIO3CuPVO131iug98UK1dShQD5wOyAX2yj444+X/+eoAkHqxrpLq43
         q9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3hNnjbd4nYPV1/07rDvCYFrv+HsxzO5gjnKpDUHTHJU=;
        b=GylJmrKkHMvkCxmYC7dBuryc7srZl6ohxg7hlxKpZT8muj2pjxp6FPdhKsMJtnc0jh
         e4elRoD1r0FNTI/OFXHp60WP4rjO9RhhUZcOVOvYa0PwYk/RcwrE4sp/hzYPQirDm33b
         3xvue6cGbGr9wfUDuqf5sjPsukcICBL9Ceb/6KVf+f040RZC3cNJr2eL3g1hMTe07ABx
         0hb/WwIISm3GzldQE8qgpwM+8Ij6i4k0rTj9DSlBTZSxzh8WW+Nu2zJ4MBzVvfY9mMq7
         xFxO0SgxG91bUKgTRv+ld6crmWW9T355P3OIihKdR/whLNt7zQR9N0B4hZvwzuxGzut1
         O/5A==
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
Subject: [PATCH 4.16 09/18] sky2: Increase D3 delay to sky2 stops working after suspend
Date: Wed, 11 Apr 2018 00:23:44 +0200
Message-Id: <20180410212759.066336857@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399712936546104?=
X-GMAIL-MSGID: =?utf-8?q?1597399712936546104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
