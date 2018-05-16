Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbeEPKUa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:20:30 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:43541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751786AbeEPKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 11/26] drm/bridge: ps8622: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:55 +0200
Message-Id: <20180516101510.13215-12-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:H8uqRELU+AJ2IEFxdUWQHCZZbizujLXmRNqdfljxsN/xTFY/hJJL5rO/I6UyBjxcqLaS8RcWwGAQEo49L/JcoM78/K7GTRjtdAo6jVEV07+SZYUsxRJT/5K2OXtM4bitKq2Z7O6cWVdSPstYOQZPr4on87pG29+ADF6c6GpBeQ4vFEPUHmn+XlAQV38GgrsKQh5dv9LhHkCmQXZSOGEVZkAsQypT4exql8zAJDjzu/fpUeBSi3OqXM/PgMlMp47x;25:m1LvrDVzdDqPuAtocb7UjU2gTfuWlqgHA/uV3DQwSWF9LqvLdunX6T+YEMxhIoGg8eFSU6Z2i6e7aq4O8oz+MXT/qkpZ8DIZtxjMJX/gnj5++xNqlfyQMvFf5FUyAr7HN4wDugvbRlLxVZikcV+f++Bgc9TwqpGwm9V4Rr3VhlbFfUrmj5xU5zLJTX9ilMqxJexMJM48UyAGK3z4igDCdazUUZmrF/T8Q6DORLumbs4ACkiQd1cyz/jBYUb3ywEn/glts1a3Y3GYQz5XtqC+LczMwM/K/qRrNjV5I2nhkUbdT07vkNBmQBVK6LCadb72MzI8ZAKm4LDTTNaQqkk6Og==;31:Dxa1UHlCt5XsJarMQPfNlK5yZBY/bAaUuLXJe7oHAfGdfPyHw0qdrl+oawgYNFc5bH9LyHBL8hATXwI8gHQJHmO5vLirHkucXXjFjw1fbNsKQfOY6Uv4RLY7/Uhc8Aa9yj5Nfn8Y/h9/8v6nu0zGm/BfZ1+3z3s2PpE1XVgOr5XJ2dO80COXLtZNUjuhS+yND7ul341EpblpFg1qTFzwKJ3p/ZvXush638XWSuo9I2A=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27721C17EE8D9770647C70DBBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:oWIg1vwcARdkwSyevl/dFJwemIxdAmvMGpzL+w+yDJESGTaTujblBoT/d7vhy6G1sDM18dIItShyfdrEClIMF/lTFfI3O7LkUlzI1BMIwrxf6GTmtEiW2eRCG90RlcHcyU6t2q4YBYCc9tOTN60ZUVpAhPMwXnVGiP0e9hYRzbqM2HPkd64aPTCuJgY9yIOri7kq0Kx5n7ijlmxRGXErVxrCITNFcEE+OgqitrhPQ9vd8cBmaIav3K0j6/9AUNC5T/kz6UyNUzYC4dsLsxuD7Q==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:jbqzO/RaC6D8lC7RYrUm69ToEGD8nwo7c2Iqylz?=
 =?us-ascii?Q?BjtOU51iOKrctRG3YURtnT0kR2gwD/7ye/TQvZLocUxja3BeO6AU0dYqplTw?=
 =?us-ascii?Q?IvMoS/wZsJjFb6EBgsFQS2LiwqPuVUPttxfxwHCNQ2Ssb/xW31zkomuQFviu?=
 =?us-ascii?Q?xOp8CK5PToyIvo5d9bw9jc/Zz1QiPdMsvQVYkNd/3ETzF3zCvx0RjSpjTI2q?=
 =?us-ascii?Q?nt+qyOzq3ymoSrDaNz1xsgcL2ZkW5nr1fRa6OTXymf126DRCKaQfbRcc+3QZ?=
 =?us-ascii?Q?MhzraN+3cr7O6NOE6bFxQIxEWKUtjC4mja7x3qJj9Qx/A/M7L3IOX9N3Kj6j?=
 =?us-ascii?Q?QtyJ0wcSSlDDqC0Gklhe1hEfBUHGYbmKCIUrLFYhNXyyqVNrv64UdXu0E3Yf?=
 =?us-ascii?Q?GBvxgCt826zbThiMbbO72K9mHtpmqmhUSxIhM09wpnEQ1287dp7HHM0F2u9/?=
 =?us-ascii?Q?OpBzr9jp1c5x2O7ZyA/yXVZ+ZoyAgHtus0CDRQwXMjw9oIBECCmum9LXkd5G?=
 =?us-ascii?Q?VhzuKmY15mc3y5FuB7Z1htYCOm68NMiZ8fq7vuuP5ukJ3syYvubfYN/J+GRW?=
 =?us-ascii?Q?cd7HTOr7hdMsoj6rfPP4EM2CV9H1rDK+OxN+H4LbM2V/IiUAoHVcAsgUXVYZ?=
 =?us-ascii?Q?xKT24T0zFYWf+p+JBjfffhQPxVeUvLjgKGy5J+mzoi/2Ob+KDnV+QnSHxWyF?=
 =?us-ascii?Q?hEvsxaA2m2o/IEkyGO2xQbz+1Zh46xKjzMb+U+aSFhY4y9dfFB9N0irgkc23?=
 =?us-ascii?Q?OFiBt7qPz/eJ18uQ6L6QRy8rn2+u7PCmnsOQXKQBxT++/KfAY7nMJ8iYj6sv?=
 =?us-ascii?Q?/PqZqkFL68pElEhOXqKemhWtlnqMmkF10Xq/DLwum2tm8cE9UagZ5hcPGDK6?=
 =?us-ascii?Q?rgzWbcZcqTa9rIsZVjl5oTwGI+Q1I6zMY0Dx8L2x+IOguqDFjRSxhsLUa8uv?=
 =?us-ascii?Q?+e7ZfIBNofoupT72VAdBaBSEMK8IwdZxUZaQ+1tSajZNxvx3ukCEFPtNJRMh?=
 =?us-ascii?Q?cPlQKN25mRuVrTJ0KeOFsuUOAbznYrQoZuXCtcThC+CWINPbNbG4o9f8i48M?=
 =?us-ascii?Q?pJ3rJJQQpkVXt2+a+k2PyLtTuYRtCYDwOtKv67WxD6A8vUurk/R/FblXsAzd?=
 =?us-ascii?Q?l1YbbuEJqWyfj3q2Le5kqbidTQqAyTt61pjlbAic6Vs35ayglqvKs/y/tzJZ?=
 =?us-ascii?Q?bzWhBq3N7fQPvwHkFqSPvBlBwu2vJRxS8fjKzMXX3TDrKg1FVK9SWuHjQ7Kl?=
 =?us-ascii?Q?GiqYd1ouzM6RSuEhAOgUlJ1jW+yOnSpBCfyoaKiXn+pCk3Y4kzpZ53gDCxnz?=
 =?us-ascii?Q?lufG7Agi26owrhhVqe6Lrh07cmHCc+BCpgiIn4TTCKMctpVmslLrYkkw7iXd?=
 =?us-ascii?Q?jcdOEKw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6NST1GCfM7wXGaAiklGNBhQalRj6L+fn24PTOApYv4hQTldhoaRkN1xVXwSOS/hzMv8nHA5UMuRfyBjo5oQZkwvwvIhRUwqD1KpyFWvoTi0Cn622SvMejlEWWp/iCGwTAwGbQYf8TwcQtSUMXaueX+GM0w+1p95Ju6ZN0nSOAiYaMJS+hRhymL/F+gLg4dgX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:DmBt5zs99qDNI60wAI3mbi/jzXu7TizyCPoH8xUPOf7ILFPqLk8XTNI+dSOVHxs0XTbNOnRj7ZoACzl7aMh+wwOIjwH6KdfKnIh4R7QVpI2xr5MK8dz4VB0aXI4HaB4hSB8SdeUkPslHspSebLU+ssROauY3/Ms8IrOf7RC0ouwwqIorPcKB3rg4ZFt9dw8OsigSMFnjnDiS+N/Ha6FiVfPG39UvR6kllrdxAnserKkPRduOIDCafajhfa3WyJ5ucJsOpBaSUKcinwIG83/e9wcnOldB4hNFBDHi1sOQCZWtPz0cH0xo6yO9QzrZJD9q5hEMUP4d6LAD8Ttmr+fuzslxi+mvIIih/wl8/BrdQSOgDAZRagsObd/GqmxRDzjOPNHPSIZQ/yxkTxmV6/ZozRNfAiPTS3kJrxayQWGHgu2oS+KzcR5BanxMWUTAkdFs6JDSF1RHma27iLKqKH3F1g==;5:AMNZOJi+rtMsKDh/akeXH5Ww7ASAs8URjFt873uWPdFOrNa/jmkI4rpE6HCJm8LUMrcb+qDdWiU/tx2oJQfbYqMUg8kRg/5mQvlIrlTz36ICYh01avbSF3FoksvPtVS/9x9TuuAAc1ZyACNwqWEPpHJHkluZUh9TTsIHNTzs4U4=;24:nDOM62jEHaADQkJHdiWMzS0sb9CBbBH5zKbeCqHRPfM5ANeLNtv1RuF0aHNnXB1/FfhJlO1vfyX0DeZZ5Ndg+eZH1EyUNz6gqenqPkaBJZA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:CnKgxakQn854rPooexMev+sYVhB5QCJ7DdN9ebtl0QsgwV3ILJW0jgnFhAaTV0Rka6Pns7z1WuEKln7oeCU6E8noWIU0hPbOYtnoyNpFT+y9OJ5u9eXj/Q9hPLSyC+ydhhjgea4KfHo5ByVQWiLTwFhIC9yvlCSrIMLcxFo0YEVtufAdMsot4ku8nNsgDsaToOCth8es4ePITftwUaZaYYIak4A4QEA+z5C5eyQEDUbUoh+s0mqOlSVgvzxWaWi7
X-MS-Office365-Filtering-Correlation-Id: b2aab6bc-d481-44c9-07e3-08d5bb160755
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:02.3325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aab6bc-d481-44c9-07e3-08d5bb160755
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 81198f5e9afa..957420a1c924 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -595,8 +595,8 @@ static int ps8622_probe(struct i2c_client *client,
 		ps8622->bl->props.brightness = PS8622_MAX_BRIGHTNESS;
 	}
 
+	ps8622->bridge.odev = dev;
 	ps8622->bridge.funcs = &ps8622_bridge_funcs;
-	ps8622->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ps8622->bridge);
 
 	i2c_set_clientdata(client, ps8622);
-- 
2.11.0
