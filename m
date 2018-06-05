Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeFELj3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:39:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeFELj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:39:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Peng Li <lipeng321@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>, Xi Wang <wangxi11@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: hns3: remove unused hclgevf_cfg_func_mta_filter
Date: Tue,  5 Jun 2018 13:38:21 +0200
Message-Id: <20180605113904.1193671-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Iez9VtF5xpSUk0xVaNPN3uwcHsRcB+ASrfN5hZ9WSxgGw5Sg9nm
 u7+ReGD43u72apA0yhua6H103J0L7Ig7TDyQI5PzjY9xg/PRNByAKJDz36d3TeRF/1fzDc5
 mVsK936l/3TYs7vW3qYzJFHVaekiR0UhBFBQCQZl41Kwxg8LR4vmvbpQZ+aZG94TO7fr2/1
 k01nIeqWdiMuKNsffTKyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d3XsoAC7Jw4=:JwCYlinR7duiEHy/lfhUvk
 D7/3FQrg3YNX48JV8hOFV8nTtinHGEV9X6K4yQuA/k5LWwey2rfj7gSdhztSux514aOXpEuXB
 6xvZjzwadvEPPt/k8jLicQaOQFMgfWXGzRPIsV7Usdbh5TKa/T4VSX7p0qk1ej1gng2t/dRKc
 YhTGOTHfruzVEIUaiy28mkty6DTIlWBFMlHzBx8op1Ua9jNttsUyHT4MFGYe3dHr8XaaIosXk
 XLZA+FoH3vOeTt9ZJ+qOPhUxgaf1NXaMfRqspv08iVY9DKkNee1UCT+LWHXIjbtuX5TrVYlAj
 vS8S0V68UNdXy3OKwkVBuy1DVVZhRGk4bN8snhRX+dyz5AHoWK22ZqkHupttX4tag33sWe0X9
 8ILmRNg5wY7EW564DhmrhQahPzkMopxf+EpVMsMx4QLaJywn1iQ/Wurrts3VzThdZlvpJ9kG3
 KTuGzESArtDN5GASluvypgb8ZWyrIUetQ3lk/9MMlNAJlNADgUWWqqGX5SCVXHMd3RHMdXhf3
 UaLhAHCOJaL5AAD+aaIidP9/uJpabkZhgs7je/FskGLt/SSYa2qMYQM4qrMhP0lgxZggV3n6V
 R4vX8Wj9OB0lh0qEDHy4KVRxQHfwwXgv40Y0rEZmZSUin98RaQ5uPcQ1DvsSF/8gVJiQ+Zcd1
 rJCKWv78NtPOAZcigfS3ySICu2sx1Ox62oCMIIJ80WwFTRSoXS2CXkFz/L5NrXMdN2oc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch apparently added a complete replacement for this
function, but left the old one in place, which now causes a
harmless warning:

drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:731:12: 'hclgevf_cfg_func_mta_filter' defined but not used

I assume it can be removed.

Fixes: 3a678b5806e6 ("net: hns3: Optimize the VF's process of updating multicast MAC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index dd8e8e6718dc..bc8a5760d959 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -728,17 +728,6 @@ static void hclgevf_reset_tqp_stats(struct hnae3_handle *handle)
 	}
 }
 
-static int hclgevf_cfg_func_mta_filter(struct hnae3_handle *handle, bool en)
-{
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	u8 msg[2] = {0};
-
-	msg[0] = en;
-	return hclgevf_send_mbx_msg(hdev, HCLGE_MBX_SET_MULTICAST,
-				    HCLGE_MBX_MAC_VLAN_MC_FUNC_MTA_ENABLE,
-				    msg, 1, false, NULL, 0);
-}
-
 static int hclgevf_cfg_func_mta_type(struct hclgevf_dev *hdev)
 {
 	u8 resp_msg = HCLGEVF_MTA_TYPE_SEL_MAX;
-- 
2.9.0
