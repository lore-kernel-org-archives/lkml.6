Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48RYoogOpZrLpHAf7EUXQ8pz2khqgpwNQotFWZoEWyAE82cnWHZ2WAirOqXOC/YQxb6HPFc
ARC-Seal: i=1; a=rsa-sha256; t=1523472738; cv=none;
        d=google.com; s=arc-20160816;
        b=fvU6yJV5dqE+Rawol1Bu/Si21BaCqMqzykRvkA5M/b9hOUtVEpd+U1D9DPKL61fymS
         DyWsGelR0lH8Rbw2GZXlYw+h5y//7ZTTzbwWKc5tyMiO2dGVPQEtlYar4s30Hucz/BFH
         3ITT7o5uZAYOfaUNy2pJObxmq9D1U7tGTksEmoenqtLYaEB5vwBke2Qs2rRTqxnVFUaZ
         EPxGL2VAfUzNKWgobX2fru2VRFlETWI6qxGXAE0w47e0O9/zw95boZvN0PPiutmPAGza
         cARKhvQaWfvWpyoZ9JdM4Ts4ysFKQoWfIhkc4CnwFaDksTfUzeQp1wkVHpx72Frrm5wI
         vPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sKBllQJinU6YbgKoDT+NRfloPOPzF9DYRn96dXf289k=;
        b=G/QcjzSEI0fN66s2AWVdfBxL7SPg+4xKKR31d6VJRh3gPJDQB/KRoXxy8TWnj47aPo
         qzc3KQZ4CtvyfNzOCqjx576p6r7eXI2Qcilksbg9LZOfTGx2mRJCHXRsn0gUd0qxxbAa
         gbhQDvph7LlZ2g/u9F6ncmfNT8kdPgZxguUOTi2nphGsAQ4UI1c4N+NRMsA1bfNgchDy
         Jfzk5a9j7R0Wf/aiUk6ZE6o8HGj3eAGj7YMJULXn/X3wS2lIDx8w7hZz8d8VSeyhY64W
         K+GFq1TpkVe6GMyHgvpQBS0fwOwjAHZ03MislAwKxaJtgPv8t1+/+cLyfdCrwmYUV34s
         daOw==
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
Subject: [PATCH 4.4 174/190] sky2: Increase D3 delay to sky2 stops working after suspend
Date: Wed, 11 Apr 2018 20:37:00 +0200
Message-Id: <20180411183602.948041686@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476343185334735?=
X-GMAIL-MSGID: =?utf-8?q?1597476949648981317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5079,7 +5079,7 @@ static int sky2_probe(struct pci_dev *pd
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 150;
+	pdev->d3_delay = 200;
 
 	return 0;
 
