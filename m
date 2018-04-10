Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Y9scyouAsfQF738dxZFno6TWSLXg91DpTJeXOJ3zUpkoYUo4OcndR56e7LAnBBjpq1As3
ARC-Seal: i=1; a=rsa-sha256; t=1523399232; cv=none;
        d=google.com; s=arc-20160816;
        b=OWUmkPHGTSo9+BDS2+65JqSxYrtvAfZLkjqCNSx8KizZFNZOad3S+e2yD+1RpmzqLj
         lGMwxKIeNDdsvWLlQm9IczngBgXPJRxOZ74nKl5cNi2Y3y+IwD3j/MN6AoTOZMct5IPO
         EzTZ1oOzObsGV4e0zCwQ5WO005r7iTYIKPyyuHer+s0gclvQYcFUkS7aIN4DPmvD4Ak9
         aUWURumJRcHlTM3PReKv/xvMQSGr4+0I0P1JRfK+hWF45fCFLKaENKFatkDjWyiuxwjC
         bTnPwb8mmO6pheUEQF4KbXI0DxD2AMYel8bSyXAl3aLeqzUmNlCQ6727sBRDREzUzCC+
         +kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1ZPnSbaJJbDrT+QGEPOjzn5RHnwriStwbMeuIMgkXNM=;
        b=h2ieKKbacMHguyMZfN19Ocd3n/j0fa0KLbWn7VzE3VP3LRJkmibbQMrl/6yUUC/1kB
         rzo3mqC4hBmeT/YuMppjw3BJRsidzRm6Bc62q2tgQh0zjadHeHST7q45SLD2ced+V9ib
         1XXP0HQtxW6qs+OLIqz3p5LSoGFIHDGG1ZHr2RboN91xO5b9uN0e5IUBfHghJhRXJ2kX
         GFefoCGKfHEIBbXUCPHH2YlPlDdv9uLAhikMwAbPV297+AHUoZkl3M/r/WKZZJJf6EiQ
         x6dYVxWzSykd337sYCqHsR75lpW6lBRyH8OR0ycL6tCknzBdxDtYjw5pfGxG9jSEXjFd
         gedQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fuyun Liang <liangfuyun1@huawei.com>,
	Peng Li <lipeng321@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 015/168] net: hns3: add Asym Pause support to phy default features
Date: Wed, 11 Apr 2018 00:22:37 +0200
Message-Id: <20180410212800.861008811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399873554101267?=
X-GMAIL-MSGID: =?utf-8?q?1597399873554101267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuyun Liang <liangfuyun1@huawei.com>


[ Upstream commit f16121c80c8ee4dab3c41363cb8b24f8d8eaf45f ]

commit c4fb2cdf575d ("net: hns3: fix a bug for phy supported feature
initialization") adds default supported features for phy, but our hardware
also supports Asym Pause. This patch adds Asym Pause support to phy
default features to prevent Asym Pause can not be advertised when the phy
negotiates flow control.

Fixes: c4fb2cdf575d ("net: hns3: fix a bug for phy supported feature initialization")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -17,6 +17,7 @@
 #define HCLGE_PHY_SUPPORTED_FEATURES	(SUPPORTED_Autoneg | \
 					 SUPPORTED_TP | \
 					 SUPPORTED_Pause | \
+					 SUPPORTED_Asym_Pause | \
 					 PHY_10BT_FEATURES | \
 					 PHY_100BT_FEATURES | \
 					 PHY_1000BT_FEATURES)
