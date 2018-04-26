Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756647AbeDZWcW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:22 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753621AbeDZWcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 01/24] drm/bridge: allow optionally specifying an .owner device
Date: Fri, 27 Apr 2018 00:31:16 +0200
Message-Id: <20180426223139.16740-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:7Rin7S4ZTniMVNH/9lQ8Wb728S7mRwP2UAjTSl8eVVHXKj9vi6MxdervBp64L6VGdMSFNH8EzEU6BJnbW8sEDFhty2lisfrOBTyvXb+RoALn/mZUlcMkdaKMPF9+Z/KhXYnbyl2mP9Vu1Zp25Ac88Spx8SOcKbmOwrkq/y90ZwLPT8VYC3gGfnREZckc3cGoNRgd7OOr1+Yh2KDHE/b/Rt7yvXaU76lYwV/UbhZsqzT8iKrW8yna9eJMxJD/qGQi;25:d0R6hIfLgKKpJaqWWjxVS57pfh6PfQ/rWl0n/hn33o37FEkoLi4B6WJ8q0zFrmyrCwLsvMGedq5/zDhfU/U0dWpNVetRUNRFI9JwzN4uSnL/9YyOM7yrKqiPVRNLUIGUEFrsfEKp+KZTvNd8VauiNHQgxrwHMkQrlx7GInPrkGhz1Jpccx3UYl6yYdEiHdMAYxnE72Kph6EaZV+qcxbKYlcR3Bw5KhZTr8dAf6aIeU78DuhwAu8G71z25lkj6Z4P+Frli1W4z0riXIcTMeudQpUz5FODJQh8L+u4U56GiueAeGrwDb4iDvnWyzvWg6mLUzJjWWXwlwzZtWEYFGM5rg==;31:zXWVCKuVU/x/1QOvMAYUSD8kVA0pDVEkCosGQGGzt3D+vilDCBVG8OwQBVvz3Y+RkEXg9miCK2z1DmKDIB6Ptj3meMXv6S3OWamT4uesjWyLepUvH4TC60EdFhlYoBI3nqiyxUb87/USzn+IaNzwWekchkmyH1m6dbaibvLXWBNNtTPCHP7LNENwaE26KAmk7zTtcguHifhbrXEZmIRkF9DQ1adGXXiH0+qCj+ZY828=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782085A1A24CE133F2FBE92BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:xBd5t1Sp7/yD60iG3aXjOVYBpgafyxUihPAN/CmG8XrPQusHp9iOfz03gSIk/LC45Wtc1+CT/tCI6jPBPUShq619Xh0ECaNLtHSLkPaVC2cyZz5S3n5DKhKU6nXiKRSm3TNGYZwL8p0RdQT2WQndbW5LdRE1Bw5Y2xlHSdK+wHHLk+n+Rn3mvsp8/BczbkJ7TMuRv7PPviiQOjQ6hg411OEtYPP7UafVdnRLiVjZimaTMg4F8AmUzV5sXrOi2AwLyw8j+R2/1qpdBaKEqAAPiQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39830400003)(199004)(189003)(50466002)(186003)(446003)(39060400002)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(575784001)(7406005)(76176011)(26005)(7416002)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:EDDuCM/MBNx7DOeMmTXOASqxL/NLZJw0X72p6SK?=
 =?us-ascii?Q?Bj5axjjX7UPzIVjo6atdkUrrQbnv3cD0R+XfnB7talOvfmV2xg+R1MZwkTPV?=
 =?us-ascii?Q?K4bfbj/5KVVZcjW8WGa0/IitMn6OteDAK0V/tYPWS2AAExFT1ZpqbWtKg0hR?=
 =?us-ascii?Q?mORmZZART4D0pbOG1ZZoVzhxzpNbY47cEM2eKsGCZAUw6OfK86BiIj/0i71S?=
 =?us-ascii?Q?XpgZjBO+0fakfZ27Qz24xMZyZOxZ7lkQ95s30aKmTNRwpxPdr+XbPm1BDCmC?=
 =?us-ascii?Q?v77aHzKKK/zC6dzbY99n2F3UbD3oouz7hK3I4jqcnFadurcMBmQhP+0dJsVU?=
 =?us-ascii?Q?q2Tjr63Kzxi/oY33wLemM9agL0czJonRPtrJTbDsm+5FNh6+ZWVVXXjGtdAw?=
 =?us-ascii?Q?Y5kopmgPoEKmxklVrhVTVaOMqCDJHS7f2ELxYnZPFW9b0dHJNp8OlCNIkptm?=
 =?us-ascii?Q?P9CBm2E6TxiqluP9GRkIGTP9evlEXRePa2Y8qVgyeiLS7TdEElc1kuK79Iwx?=
 =?us-ascii?Q?1JqPZEwG3x/FxPzys0YZ9nhusVCZqfIwLnKC+l7ESL+gASIFCnG1n3MVSEq1?=
 =?us-ascii?Q?7ZA/dEwP1GROmZtFj0Dtaa9Nt1HMGh8jpsSmu2wz3xjUJHSa5Qslgu2eDkyF?=
 =?us-ascii?Q?VZoRUyBdCJOCul/bZLeJ1NJ+tkD5A/3M+aUGDQ9J3v3ZfsGVN3i5TIzXu5IN?=
 =?us-ascii?Q?riAnIxZ684l6CS0SM+N/t4NqqwvSHbkwztkDqIvPhKIReI9qZ0LvCMWIvU92?=
 =?us-ascii?Q?jbreBvKHOeSU5FW+VyuDer7Ux7mk+u9jxO+gvpeu/E2EwAGJpAFNbOTNSOdw?=
 =?us-ascii?Q?Xg8oVmANfEMhqCPcJ6wE84aZ6yjBFdV1ckuBHpriy82Kip1phoY3lMOX/YRW?=
 =?us-ascii?Q?zQ1zKOhv7tlw5MkW9iE7n4aUuwlCHdjXPbsS+YCUDcvyiFpBP54Sc3k2t4gL?=
 =?us-ascii?Q?yhfkrq7S3VtYLidg8dW2swg7oNPABA8UFZ5CS9gYqeZRdjR4vJd8QgCNd9M5?=
 =?us-ascii?Q?Li6pqyyi5aDMAMf+iq4uqNy5db9hmTohDLRlSj99p88ehwg8GtqqRN+2j44B?=
 =?us-ascii?Q?UdicRRGxgxO3dSpqUNuQbAb+AxN+fFEfLfnfnH86Fg0HsoblxWfvtHKDRGP2?=
 =?us-ascii?Q?qxXZ2B8Qw1FQKSKdKR5RuxG7W5XzAqYTVbY8NA7u/CZW04HRG+f+X3uTGQZu?=
 =?us-ascii?Q?pQomu64U3hv5Lqwz0RqyLq4jsr+J1zSecUhjOj0NGNGSt7iUUDjoa6S9k6nc?=
 =?us-ascii?Q?sXluRyyygE7kCDkqIJ8kQi3kKeRsX26ZgCkRtLd+eeD9mlmsiDPfkllHVen5?=
 =?us-ascii?Q?BD8F3RlqrVsl5vZiJrqHN3IDqcrq8MYyc+BZEfoPq/ncBrTrQ+WgZTBTreHb?=
 =?us-ascii?Q?lelzkJ3JEB4Z9FsYDpy711hNCjDGWRmPR4ZY8ee2l/Z11G+TEeOl8xCiE4LS?=
 =?us-ascii?Q?aItjspdqs1+NXV/2ImtVLVfvuG1gA+0U=3D?=
X-Microsoft-Antispam-Message-Info: B3nLIJF924tmFhqKOZ2UheE7WyrNC7FKqwGurVzNXzqAJHRO+hD9JBDLqWz7apeUJechYmaHyiqii9D/+sHHWV+IBu586rfmPqcBQ7sHcVBgHK80/zsFd14HFt8Bt+MCs8LdD4NRVSGqxNDA5CNQnj4srJwvsn8F3LHICF5Z0FNC2fSA/KExo1qF3Vn12sCt
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:YwNRwaiYwoSSeLf8jK4rMv38ryyMzWrf3InCtotkifCY8Zdli4u5ECMF1mVDj4tIAlhjUtZCernk8+O2CO3mpDxfLJHjutKWTljyqasZkfEIQE/25q7bTQkz5HZ+NXdBxhHf+QALtEsykN0WnNHS+dImAW6g8yEqcbTXSI+iijnsG5P56y2FswbaGjXDIzNuj+ON2Mg2h5qkGe1KQRhtGXFgnXeJmvDRyWFjJ9NTac+nHoQ2j/LKAaVGl1dfp/4dyUiJHktJgy4Thh6+1ZZ3uHF70q8jIEzrPkViNNzvAON/Y5FKIh+b7VxT2SsaDX9Fn9xQi7SqEs8zZElO2WDNPVd1iJ5+ACqbp/YXk27FQT7VEtTbt6NmuSvzQIVA7YPc5QcrpoilMe//LUSBS8ecwNRnrAqQsNMymt2P1O8FNvRV1E8AjdmvK79w4xM/iEaVnAWBh00gj8UAtxljkCfmsA==;5:jEHwOlZczqkNrVJr5sU1BWPP5SPRbuJHB5GGjtPGCPpN81i3/lDyTovEv8NZ0YsaSX4GZWRa8CN1wMdLw6H5qKB16sRLtJEztm7o7lm+3XCvNFTnpeQWaPW9KNz2PNT/RNAzJvgp0rzw7KpuwH2613ZJDVDN2aNi0zkjvgPldiY=;24:Ldjv0tPn9O7WVQzppgBo61RE4hAqO4qHjdRc91SI+LLevcw6suNkbzSc/D7RFN7Lk4ofXKpfwDp4d3vqqBGrHFzxjdgA4ljLOjfXn90x10g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:CyUQm7aKVk109xoZAsaWjRpiszD0FXiYjVtTwtzr5H98odHbPaMoKirK6d+bo0KBYf/kxcly7O+cZu3XrrP0K8s9/lqo/LfhahrfjdOXKqJIb8VLmxU8uYOk5Lo20vur8MAukUnFvGdfjMSELHAdYna+iA08sJ/1SVfUdvTDlOElzyZu+NoUT65l+w7aKyWcMUHfv0Q+CsdmLU/pbxhh9XEFsxzIm4Lgiz2W3IBVtzWaKF09O0a4HxpLq6NTUqFk
X-MS-Office365-Filtering-Correlation-Id: d98f6099-9c2c-40e7-046f-08d5abc58d53
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:08.7134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f6099-9c2c-40e7-046f-08d5abc58d53
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bridge drivers can now (temporarily, in a transition phase) select if
they want to provide a full owner or keep just providing an of_node.

By providing a full owner device, the bridge drivers no longer need
to provide an of_node since that node is available via the owner
device.

When all bridge drivers provide an owner device, that will become
mandatory and the .of_node member will be removed.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 3 ++-
 include/drm/drm_bridge.h     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..67147673fdeb 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,7 +365,8 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if (bridge->of_node == np) {
+		if ((bridge->owner && bridge->owner->of_node == np) ||
+		    bridge->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3270fec46979..c28a75ad0ae2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -254,6 +254,7 @@ struct drm_bridge_timings {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
+ * @owner: device that owns the bridge
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
@@ -265,6 +266,7 @@ struct drm_bridge_timings {
  * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	struct device *owner;
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-- 
2.11.0
