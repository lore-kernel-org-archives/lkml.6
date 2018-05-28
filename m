Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424973AbeE1Lvr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423777AbeE1LJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 123/272] net: hns3: fix for returning wrong value problem in hns3_get_rss_indir_size
Date: Mon, 28 May 2018 12:02:36 +0200
Message-Id: <20180528100251.484369475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuyun Liang <liangfuyun1@huawei.com>

[ Upstream commit da44a00f06df1f823ea449065e79581ee624de4b ]

The return type of hns3_get_rss_indir_size is u32. But a negative value is
returned. This patch fixes it by replacing the negative value with zero.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -709,7 +709,7 @@ static u32 hns3_get_rss_indir_size(struc
 
 	if (!h->ae_algo || !h->ae_algo->ops ||
 	    !h->ae_algo->ops->get_rss_indir_size)
-		return -EOPNOTSUPP;
+		return 0;
 
 	return h->ae_algo->ops->get_rss_indir_size(h);
 }
