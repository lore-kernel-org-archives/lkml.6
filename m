Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757286AbeDZWej (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:34:39 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757202AbeDZWdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Lloyd Atkinson <latkinso@codeaurora.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jyri Sarha <jsarha@ti.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 19/24] drm/msm: specify the .owner of the bridges
Date: Fri, 27 Apr 2018 00:31:34 +0200
Message-Id: <20180426223139.16740-20-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:pqMMANTwPKYFG2NB2Kj77By3kqhdYke5tHYMXSkE4Em4T2n9utyOD8T1s/2DaOCri4vWB7q/X352kc3EjbNzsCefl/4bG2ik52JgD2SNMf9S74/M3mXUvu8CJS2PG5pvk8lVH45kXulUsnMLI6xhwHXHr4ST25zE8TksEP/oLiYrqqzViLNATm9LJCWJm+OkQtdF1hBG45ANMSqmazIapY3gPfHKxdC3r7cmbuq5GYBe8p7dSiZLDNNZcd6r4L/x;25:i9SERFxB/WuWJlX9lPFeWA/uiqk0XdMiEmz3/7ItInlo3kOg9HaVEtI+aSO7TRJhASpGQHT5ojie3UO+l6ddrdePlgp2rcb/bKojrGOyjctEmnEA/PkrSdrBe0as9VXR5S/Ommn5OelpWb19K4ocA2ooNMyyqAuF1Csq3KmhEEp6Nf9BSKT0rRWN2nnzEZaeq8dT9CH7jL4VuaYS2zhXr/b4WdlYWrjImRcCsTFDkKT3R9bMTBVixYnX1Er+O9C5hRwH6hFJOj1IGUzi80J+yuJz4obUXihCC2RCed+1I1rlKtMBTm/T+dFfUgETgq7GGaEeICfNeUuryYrgE3tCyw==;31:kWEgIXoaItek8GpTfU+uYkZD03cV/Nh507CYSYsFxlCGFkNexRPIP62MBeE56i0lDGNWYiUFYZX9CZldPrBoxw+HNlYtj5oIo/6uXdP8bQIO0kWbUr2T9kN1c5ddB8cztuEQ6IjiAL6T6W+Eof48te+HBJLr4zvltPTILm61ohx9dJ4O6rBYRnCYXmiwqB39l7bkxLtbbbQjgVWXmQZxntBoTGQ8muHTQ9OpNclD8U4=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27824879D3F49F4CFF041EABBC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:A2T8RVtudd1Dmdn5wfNpLP7azaX0z93Kv0MdZ5ceCvy0D3EjgCcLxPN+qIGIDFYCMZwMECyo6iAl4LrJV5igfWt5aDxOH9aosCF5GO3EBux65PaxCqkff/gCF0L3l/aFnwJsEwlr87Cbye16+aZQ7G0hE9XAhGLHMxuZ/WT+C+fM9dh8/HArNvImUcO00+udAHsdJuT3KFdg7QsIuUcxGFWO1oii8mv/EegpZn/cpK9bXZebasCxnCVpCAMe0W6H5HaYGc6aWZzUddeAqpEgBw==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(5890100001)(50466002)(4326008)(476003)(2616005)(86362001)(39060400002)(956004)(8676002)(76176011)(26005)(6512007)(575784001)(486006)(6506007)(7416002)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:FcjcHWEdErlNtPau0Eq4KRLNH4m3mNMXIgTU7RB?=
 =?us-ascii?Q?NcBTNFuwB1cQhRKUfTx6x6iUj8qCGBMm3vdqpnJXEEtx3RW3XHlIuB7Xr8uu?=
 =?us-ascii?Q?qLzavGIB/WqFawJQe2YM4mPo/+Sk9vxTyluqjRiMKlFAxxylVClBs/Ahg/1n?=
 =?us-ascii?Q?jfHsxgvU0qO/tveidNz2GmEFZ0vy5CnLREu7sVJW3AJbs2eXdqGNfteQ+/tl?=
 =?us-ascii?Q?lSFuO6hCiGHGddgrFvsSuEN5l4bj0refDQOCUsDLXju2EOI+e48XcDED7edw?=
 =?us-ascii?Q?NrjnXQcmyJpzRKna4WDSrvv+ySZlEHrevzRDdyAID2ATsnXK9oLB48z9p3UC?=
 =?us-ascii?Q?FXiG+/1MM2TqUzIAgt/oOsxF4QI5m2O4qCw9lPy7zDPPK/YGhG/8/W5ANSHi?=
 =?us-ascii?Q?PYNwZAS2efWXSiq6eidfQ0SqsK4WrqKGuj8D8OF2CPyKOvXr5aukzpQ8MKII?=
 =?us-ascii?Q?83QB48ukp1CDC3OMktL35OBIhGZE9mPvMozIvWmPNqzLr9v4MMH4H2VkiHv7?=
 =?us-ascii?Q?OvTGgYUq2vwiCI1iDUN9OKMDirdblLhdH/8yS2lACAT/RfYJQP4VdcO/Povh?=
 =?us-ascii?Q?IT7kQWKpGOCnvgoI+ispq8IdvAzT+8B4JcFNc1A0AYitbgpJJp2eZLPv83C0?=
 =?us-ascii?Q?V7UUCJ1SPDaL9tkuJ93XZgfhR6+mVDSX87dmbzjfz+HI+txCqpsdzQMecrV8?=
 =?us-ascii?Q?4BO7V16VzFuUvdhkGO5PUlI9Io22jh0J47WrgpluLEFjhuJaOpOf1gEl6slQ?=
 =?us-ascii?Q?Zq01/OVTmAKUv9hAJWxR0goqSiQ6M/tq2c1NhO6kZleRggt+vmJ+DARGgiLm?=
 =?us-ascii?Q?LrhGVCoHtxPfrn2fR4gAP0QB72d0cpCCfX4x+IUfkWprLbgzYkmXfxn56koM?=
 =?us-ascii?Q?Eueqk1PQLvKU81v0ajlHZk2uNGudxaiyUHVZk/vOowAhZYzLxkeRGUEJ0Cun?=
 =?us-ascii?Q?oj5fR+18yO7xJ9k+YKvwPYN/QEzV7dGklDkbj0fOJISG3BHwhO9W0rANHwsB?=
 =?us-ascii?Q?Unz5EltHjBpvxnYn5FiFBX7SJpeCuxRd4FUVGQJTKYbDz2ETa86/fiszbCkT?=
 =?us-ascii?Q?0hXQf83K8dx46cW0lfqKsR2JQIE/2RPGydyVklk38pbmSxYK4P0OxaFuVAH2?=
 =?us-ascii?Q?WrlweJirkFgab8twuHXsCbXOF78C0dQPD9eESIftBk4fX3LscSvgFp4vIv0X?=
 =?us-ascii?Q?zzyFwVN926365x4Puw4EF053JJUzZWVsX7kmw3Q8NkysU9N8FLcBw1ser7JK?=
 =?us-ascii?Q?vi/TRSqfSW/Sy2g0/JV41WYfyfySDB3wBwpRRZ6Exd9hJdUwsw49X2MK/0wX?=
 =?us-ascii?Q?CGOK6zsP3oHn+xIZUh1FVOMMfRHr8uDtSPQOWUIFYEDYjHbwdrOAwu/OYmuC?=
 =?us-ascii?Q?ggNi5O5Z86r3AV7u1GAblvb193jIXbfrJ+9IW8a9L7tFXo5MOM5mmqwS9jkJ?=
 =?us-ascii?Q?3Wr02GCVkXw=3D=3D?=
X-Microsoft-Antispam-Message-Info: KqrkGmmihNlLcOFZfNFBBCXx5FEBXVvWKpYOsB1ayW4AgKJjpDhuNTq4i1MS3eRbDPf6z1sqrKjw5uz9lDmxaqdPeCDwKETwAcFYVlVaLBNwQJizwll1XqW6xd3mntGKwoWvIVqVMwA4Au7bokLzbB9fC2//s276FgqtAak2NgCBRJ9LRuU/BsozRY6oEKcU
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:YrGgMIqM2AoNdr91GkbDw/zcnXvc+ViFh0g50QXioeVuDWMJmc58AhFJfVJmyVvI+OTMT/7vJf0ayhelJPN5h35dt3F0MIHVDMhwPNK2rdinTU074DLKX+Y+Uf9NSEzNqPqdLWGEu6QJpHe27WakvIiM5Xtd7eqiZ6xrfTJFWNm7nPwMVMl94YHeXV8ZK1wO9snuEzuSwOicOEmWxWh315k/pYeYLQK8WeE+/xTKUvD7cynmI5mzEaX6HruzUMyeezxwOzDB3HIg+56LITQx9/KzEN2vpvEMYCWHFPWsvEg14exI9A/0OIlRV9NUKFs8kPdsoAIz84CZ42gO33SQwFejz/51+ay2Z7O873P+qWw63nGfTg9czQpYbw+qTw053NVujMLW94ekV+lyOJ2ulz51UUIFTJsE05jFuV5orKKeiqQXOiGltm4Zw3FHCaWszSmxD4ER54aXW+p3oCHfCg==;5:c2JBXpSbWoNNrAeWZW1JtCjLkCx/gBdlBrtqckHbF7Imx+LnQwxH0ZXW2EftPS7HQqqf7XfUBavfhbJ8qsoWDhawu/7jg/M2XyUNs7Ep2b3yf0QRK0NoH1S0cJpXl62xByoO6gpq0vYM+DEYqzBX9QexKdBqmkdMuagEGovzGZg=;24:1gq+spUT2AOnzlOJ+ZzjOnoCBz+8rxseag+hCFIZQH+VwiBtpm8EZViqByT9Xqo20djNTit3XJ0dumFPMJ19giTttEWhYNB3qHs+8d60Sg8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:5ynyZAQYEfwYod7FP4CAumdL9siaHiMdtEt2dDrfi+7YxaE1Bnzqb3sWhnybtnM9ZcHSY8+WIWGRXBK/du37tpZAPxlxEFVxEZFPOMDpGfQKdURO6rGLdnS2kA/O5TMgRMtb6Y90weOuKJrjVPGt+ARq49AnFR21TeVVspnr6m5r74IoWMqPlxC4s4VZCfWRtKKwFgPM6ZLUdRXq6uIygTBcNCwUrB/ChCyMfnY0HP9tqg1fUNOQ0xdX7Jg4dFmM
X-MS-Office365-Filtering-Correlation-Id: 5514cd61-4d54-4854-d462-08d5abc5a67a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:52.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5514cd61-4d54-4854-d462-08d5abc5a67a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will become mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c  | 1 +
 drivers/gpu/drm/msm/edp/edp_bridge.c   | 1 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 4cb1cb68878b..b6c344bce75d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -710,6 +710,7 @@ struct drm_bridge *msm_dsi_manager_bridge_init(u8 id)
 	encoder = msm_dsi->encoder;
 
 	bridge = &dsi_bridge->base;
+	bridge->owner = msm_dsi->dev->dev;
 	bridge->funcs = &dsi_mgr_bridge_funcs;
 
 	ret = drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp/edp_bridge.c
index 931a5c97cccf..30d9e0add9fe 100644
--- a/drivers/gpu/drm/msm/edp/edp_bridge.c
+++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
@@ -104,6 +104,7 @@ struct drm_bridge *msm_edp_bridge_init(struct msm_edp *edp)
 	edp_bridge->edp = edp;
 
 	bridge = &edp_bridge->base;
+	bridge->owner = edp->dev->dev;
 	bridge->funcs = &edp_bridge_funcs;
 
 	ret = drm_bridge_attach(edp->encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 7e357077ed26..6fb103d91956 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -293,6 +293,7 @@ struct drm_bridge *msm_hdmi_bridge_init(struct hdmi *hdmi)
 	hdmi_bridge->hdmi = hdmi;
 
 	bridge = &hdmi_bridge->base;
+	bridge->owner = hdmi->dev->dev;
 	bridge->funcs = &msm_hdmi_bridge_funcs;
 
 	ret = drm_bridge_attach(hdmi->encoder, bridge, NULL);
-- 
2.11.0
