Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/czmZEOtMI2NawgsbJR0fhTuFeVMalDqIZwmky7/mj7i8t/i6dv4lACmJAHLe815NZHFaK
ARC-Seal: i=1; a=rsa-sha256; t=1523399335; cv=none;
        d=google.com; s=arc-20160816;
        b=tLISlltpuEC9F/kBAmfqZ/GL8KBWoiy1r39n9+ktndty6s7yKbQ7Kc5ktIFEHYRyrV
         qNo5bIV5rKZ192tw8qBZNEi/eYw69RUui/nQCPzB2HkBw6KY2gLBo0YzNZTi6COw2WOT
         8ttVXaU0Un2Ef2aEdGJQ1ZqouCMuCMEPdjgqqGwAyxu1fkpgf3ErcTEJWUwGAeH/EkCl
         eRwO0d5vZ21xOn+3SQaxjAG+63jD5U3+iwuwGNBvtdrrVTpsHdu35RSf2eNBImUJn8Oo
         VB7W0JGZ+TIh9SH4cNqL1h+050hLEqJXXbia7vOIrPBOzH29eMzsjY2wFiMToKxwbIF0
         /sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G6S/RrLJosPE/ZXuEcTzTHjNS4xWqy2FSGl/CZsiADY=;
        b=v5dcqecaZdEiiNKlb4SCVHAPw+xTiD2aWQmEFImhF+LmldLgZsi73NuL+5Uwn9eVCu
         89MHbIxYeZuIV52d81L4JCS4WK9J+rmB78OoY3YLNuvU4/CxoeK73WSQI8FK6bk7q01y
         VS44J0mKiGxUHyTIYRQkw72iS2CGTw3DDWJzehOn7jizkxkWebnimI8swQNkRmnRT22D
         +YU/PlfSHgu0/bP9zvTsizAwiQocVy+9Svyc2vkwCqbl415O4ARlWytf7Ex4xrFUN/SN
         sQ25Ql7dptN3n8IeGTsdVQd0467/bousPvmT5dddn/fZwIWIpjtD16dAYv4aKzg0pw0U
         k0YA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jian Shen <shenjian15@huawei.com>,
	Peng Li <lipeng321@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 070/168] net: hns3: Fix an error macro definition of HNS3_TQP_STAT
Date: Wed, 11 Apr 2018 00:23:32 +0200
Message-Id: <20180410212803.174883378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399981614911872?=
X-GMAIL-MSGID: =?utf-8?q?1597399981614911872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>


[ Upstream commit 57ffee737b36dbb81e8e60a37e01791553157a5e ]

The member "stats_offset" was designed to indicate the offset
of each member of struct ring_stats in struct hns3_enet_ring,
but forgot to add the offset of the member in struct ring_stats.

Fixes: 496d03e960a ("net: hns3: Add Ethtool support to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
@@ -23,7 +23,8 @@ struct hns3_stats {
 #define HNS3_TQP_STAT(_string, _member)	{			\
 	.stats_string = _string,				\
 	.stats_size = FIELD_SIZEOF(struct ring_stats, _member),	\
-	.stats_offset = offsetof(struct hns3_enet_ring, stats),	\
+	.stats_offset = offsetof(struct hns3_enet_ring, stats) +\
+			offsetof(struct ring_stats, _member),   \
 }								\
 
 static const struct hns3_stats hns3_txq_stats[] = {
