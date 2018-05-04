Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeEDOGb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:06:31 -0400
Received: from mail-eopbgr20127.outbound.protection.outlook.com ([40.107.2.127]:53376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751311AbeEDNwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 03/26] drm/bridge/analogix: core: specify the owner .odev of the bridge
Date: Fri,  4 May 2018 15:51:49 +0200
Message-Id: <20180504135212.26977-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:C4S9h99Cxsoax5AxO+Vj5C0iVFxkCvvz53gsNnqWcxMbqPrcqbJXUJbp72Ob6kvN8iEonywsVZ4b7BFqN1EJgInQHfFBHt/0oAXbR0/jyHCqoD9KP8aDji4N52nH2Sh0fGDtPqMvegQr9d8J9JClIdgD0ZNmnEVtXJD1xox5EqJ8SVNjJr4H/0woO2gn9SXXm5rLQ2Bb34uuFA+fOy+cj+3mQWcDzUhW7IJ8qC/6LQBYeB/ib/7R/qV4CQsh5v+2;25:vO5yJZBYJA32uD6fiH+nEzwO9KNpttgZhGTxdr17ZgD2SWwPnGjO9JxnX7Df8VXI+XwhNSSX+auTi62Qdfbar41tBW5sbDERGWHfLFa+kz/MMblEnomyMew8SVJsLYKdtVda1NClglOKD11kyC6vsy16hd4Xb9BuqwdKlQJOaJXjRg84IlID/ifrg+0dmUv4ACUVoWOe27zHOeBZvc69RjlHkqbIh46Q7ZfRmbSJTZms/Pd14KhlvfB+bTX/IUBZ1kN7g0893uWXgzWp8Zl6VlvrMrUpwhVdzck1/wNiiZRBsUSfwiM4dD5kIcTGNKu2D6XW4RIljcOE2ODQxekPIQ==;31:hPfpYGpUvKhhSm7u/NXx3BRxitsVWp6xJmYwhypD5HQqVkMKguLn/ZO7Z3P4NGFAsIwrTw42/56HmB+LjW8dquXJnEVfC8nP/H5H5fmbf4UMqNCp3vtMDSglwoRxKXEssMXEqle4whIS0OiXS5SbvzkrtqAlkBDru8V4d08cFV2m8Twt4J43Jy4Ksn0CQGH/RZhVu1UzuQWNwHDo8ObEiFs+SG4VbRsCQAe7iCzN7FQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769F773E520249C1664D3DDBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:9e2osLNjhfU6HMnb03GWqJ3vSeBqcBjeiS+hL215jWnJjaBhejZDYAxldVEppRj9mG7vGDBKfdbmddYn67FcMX4rb9DLmiVQo7CM3upKFrTYGZRsh93yPBPKDJYlhvqRKIMprm8cMetQUegONMOGE29Af3SJvFJSC3nYVLADuDSCOhDk/su+UzQg/MWcHBCm3tkVN33EJ2/Ba2ZbhQjXSj+VTu2CqQYqoKRkql9cA8MJJWgaAVDc2BearO1SKasAdpetYtifry8AXJ9Tfh4xWw==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:qmO3kSmmBvSDHr0rmVnScvjit0yD4tA8cPxyQTu?=
 =?us-ascii?Q?z/gCz6rS5mB8SPsfBwzWe2yI6nBkrzW/SKVzfE+uAvLhh5AYZvZFX0R/TXtK?=
 =?us-ascii?Q?ai+U5XiYcwCTE4jIJ8PlPQ3Q0sVUilDxTuAsQOdBzqo64wLSarX3haCGi5yb?=
 =?us-ascii?Q?ZjsGYpnkVo76wKBkCdQGjqyCObTdtOMJ1nQW8EPXXuX7P2Pe2xVJSubYxyDO?=
 =?us-ascii?Q?MMogQIHIACLzyFXk5KcNue9NtLKCWXMJrLbsC1xJJ1uwUOGUMMdcILua4VZ1?=
 =?us-ascii?Q?onjcuX35qIVjPER+vuc/sEwker1qpcIbt8jGF230cmY0J7czSqXTs36FkXKM?=
 =?us-ascii?Q?b1fGIdlhCB5hkHJyRqrWw0NxPKcofIy7pGKy49ULrAvfgrYWjynMrtBgYEw9?=
 =?us-ascii?Q?4VNSh/eDqGxGWAp8tv20oU8uqUPBxYdIIhzPyt025vaM8tVeTr7F4rz5YGvr?=
 =?us-ascii?Q?/zaZs0p9UmzMvb5CAr9mleqmTdbwco+A7oUuu0U31JaVQPK5SFn/XPKtmWWC?=
 =?us-ascii?Q?gd2izB7FT4FPsiN/Dbo8tvFylKn8bu3oYNjFh7lN44HbNlfN3TWxNJCJktNR?=
 =?us-ascii?Q?DKzCTbK2z0IuWrJjwooFvEaUW5lOtqK36RHn+AHhp0HErk2caMjQdNdgkAIr?=
 =?us-ascii?Q?KnyNGRjIpSaDvI/50IELcYzCMCWiw8a7hSvySNQ6YbOBZ+XLhLBMe5GVZb2b?=
 =?us-ascii?Q?F92tlGG5a4MuSojuSoY/hSY7Njh4J4paVkRqgeZxiFN9TSmp/3Tmbt08GNTX?=
 =?us-ascii?Q?GEZSeX0TsO9jDOEfcuXGhjgqHlKdwOJR5EznNnvNE5Ua6wcKMth4Tq5p8YuF?=
 =?us-ascii?Q?8ivnZ3tAQRHJ8HeXJaJojKlfHoYsLE45pBpdoEhdy2Sn/9Z5gpUjISkqnsMP?=
 =?us-ascii?Q?rPAILr2h5U3ADYKbrrebolBy4ABrxGo//UMEH7O/b/Ox6YdkTQb/Zjagj96H?=
 =?us-ascii?Q?4xdaGhuMfUiMi93+qQC6/zZSEVqF7Lw0PI5zIvUDrrZpswY359f71EuMBN71?=
 =?us-ascii?Q?0lXq0emm6I1vqsdC3sSQ4wsG/9G/T0kVKI9dvNLnDK77fQj8GlsT3H3ttUZL?=
 =?us-ascii?Q?N2cdqZdBIEquP9ZH4ctRdY6LsF3loXGjRckHGvJbQjmHrsGDykBZI5YwtLr1?=
 =?us-ascii?Q?abKxnkuDzzbGtwGX2Fji/G+LhFeLl42RUS9CMfyfNXQQkv6FmLLiUKuyGRuF?=
 =?us-ascii?Q?pCCBfruxn5t0dfP5Gh07wKxs1J/tXm4x6KqSuAg+QK7VWuEvGXJZk0/AJ0Zt?=
 =?us-ascii?Q?A/k3rknyPAjNzQ4Xp4qNnqs+MtNINk0cOfsSn7blOsLOsl7XG6xWSf14rpan?=
 =?us-ascii?Q?dWw=3D=3D?=
X-Microsoft-Antispam-Message-Info: H6oLyap1sl29rELu9gouVrSXxeiywBZgbbRQkFvdCmJVO921Svuf/1d8yrrAP4EoFjGxgj87QeqeGJRs9QAauIcJoLkY3kaUHP2rm6+CP9sbFiUsbfi+LiJ4ez51TLCS4nsU47+Pq/oFfMbxyF+VSSYUQ6TYmevyN/EOr5XV+QdCqTa6uq5eTGeNwwv1unLI
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:6gv7+odTBT94MKM2eQeWFx3Qg+bGFRy+fcT23dpeRLW15y4oh/L9Cd8hrWKhyGIY+hL8CoF3HC/OnWeKW9aF4h6am2QWkFDS6Yj6zFHXOc9/iOgyKamSai0Sc9f5WkVFuiHKdrGT4ZqI+vDdYotXwWB7OiCXO1QwDy72XvIIw/sbGf1NBP1FwfSfjBILbyxIxFvYnaz/jlseN/Mw/jX6iIZaZIn7rBiMs9rw7cj8X+W9PDslXfSQXa5nudP+/YKLpa6eh5g4MmHsw8tmQX1zqO3bpoDz9JLpu1OSuY6TVbVlRhk0cfXtAp9Kg5Kq6RZ8vmOhUu8/cSlQa9aOHsqFE+Eqo/tBDOdOWj7chrSdcvBpKzxmfHvwPiNf8Vl1eFjBskAWvPNuX1pGKBzJfTdgRDFgE6nXxhF/tmDKOC6DnNlPvlOp8i0Ks3Ji5XMHXcxMs4qLfebI28YvTQSl3RkIZw==;5:6hI2mlCKFUjMt0GWhgySDo9La0LlnY4rfF9ocFbMQCVdWdwpqdwG3pWbHDgju7kyF5g2ppOFytcgHjGDDDfkSiUJkDGHjVkcNOGVgodeq3QVpsD7DoeChG98xw3JaZxYkBl5vbnMVk6T9yd1YreSpQ1sEGjfawFVJkknr7PZJ3Q=;24:WSgGzqqWeDzREAu+kUiWIcp9FxhbrGlZdF2vmkU2MBCky1qx4pTAJyWk5gnSdBoeva4c6Yu/Z/dCSOtHRYZ7XwP20spn8kM68Qvfvi04Ek0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:DyK6Yft8wpJCnIaM6FkDY8QrX601DZLEz+KYf2z7Ev39NmILV+N2EYkBmQpLLexEl3WR8GRjALq2fDeQbYY3H9RJnWh82ps4wXv7gnx5LMfhIP1dOld1QHOIfXmk/RqRpbz/4URo5jQxCQgxTmPdt329nEDHSYMbRaZqWZRrT9BRAY+TDNTIhfRFBE35OwKTZT0Q12xKCFrox4EhGRTgeAhoYnWI6d4vzZ66l+4DU/Azye7O1ikpQ/CdEHit3Vgq
X-MS-Office365-Filtering-Correlation-Id: 03c60989-8392-422c-92f9-08d5b1c64f6f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:43.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c60989-8392-422c-92f9-08d5b1c64f6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will become mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 2bcbfadb6ac5..c60f29216213 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1467,6 +1467,7 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
 
 	dp->bridge = bridge;
 
+	bridge->odev = dp->dev;
 	bridge->driver_private = dp;
 	bridge->funcs = &analogix_dp_bridge_funcs;
 
-- 
2.11.0
