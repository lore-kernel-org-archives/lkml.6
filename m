Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qqTSYNyf0xj42HlcZjZEzCcykLkgZn86M9sIaXIQT/mhRL+E04l+3qQ3znIT5KJc/LInJ
ARC-Seal: i=1; a=rsa-sha256; t=1523399815; cv=none;
        d=google.com; s=arc-20160816;
        b=p8hCeUQwGSMFz6rxwPsqUGS7CDug8T9LDi4SNAK/jvYCT40qjIyJbm6fpsXMO+uhN+
         fJorO+pyoT6WVc1Z0eEtncUHSyNQxGkiG2mCbPOTLitwJU4EK3vvv2fK85T+ZfZGSaqO
         zOzl2sUo5z5LmIzrfespf6DyY8N8XMb5EEHSyrekr/UJYHdgF913/4EubvYJ40ABNFr1
         Xn44MFYRP2qCw5hJkXe8kKEPwDJFTaZIZ3LTxD9YMToAWnVNhHWrBpaTvIk4rzfSsRWU
         cvf7+nDRLW3fm/GCCVE/0CFhR8Oi8aQH+byiy1Yti99mMyDeqx1BwiFDRrdTjAhMD6ch
         YyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d9bF6dnaFaDp/BFxMoNlw9A1QOqNEbTrKuktXG9ERsk=;
        b=AVBpEMmGrYQsm3Cr5XN4I7E5Mwdf1cKTCKOZr5AGNoTQQsOsGjI/MJUiOJ1C32e83Q
         QIvsyla5BXoww1n4RF4rSXmn4cdyYq09L4hm6zqMLvcvHUJmu1d4RUvdV2olBHMvsUOF
         W/Wx5Uq0c0Sc+NpXYSTDnur+JMLz0eNn5gUZ2E9jtp6bMUl86McTlY4Mbuu2GKKcf1Cy
         syDQlYuRNd5xR4CAQ+PH5icezcPa8T/62lfR7DD4swknkB/tZCG4Y6kNhahcxkolFYP/
         9wBeFq4Xa2GGeiAM3JZ3OIWPUm6ljRwEEY3MSnzb4/cl/JE4wkSmHxK0bq3ZNFesfb5Z
         wJLA==
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
Subject: [PATCH 4.14 055/138] net: hns3: Fix an error macro definition of HNS3_TQP_STAT
Date: Wed, 11 Apr 2018 00:24:05 +0200
Message-Id: <20180410212908.470870877@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399981614911872?=
X-GMAIL-MSGID: =?utf-8?q?1597400485342676389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -22,7 +22,8 @@ struct hns3_stats {
 #define HNS3_TQP_STAT(_string, _member)	{			\
 	.stats_string = _string,				\
 	.stats_size = FIELD_SIZEOF(struct ring_stats, _member),	\
-	.stats_offset = offsetof(struct hns3_enet_ring, stats),	\
+	.stats_offset = offsetof(struct hns3_enet_ring, stats) +\
+			offsetof(struct ring_stats, _member),   \
 }								\
 
 static const struct hns3_stats hns3_txq_stats[] = {
