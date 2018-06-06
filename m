Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kax5N8pAGFvYQgAAmS7hNA
	; Wed, 06 Jun 2018 20:16:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E701A60861; Wed,  6 Jun 2018 20:16:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KamvvymX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 44FC360290;
	Wed,  6 Jun 2018 20:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44FC360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeFFUQJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:16:09 -0400
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:3522
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752093AbeFFUQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+NcCEbFisAmYCh3sijQCIXlLyJSXmrwjkfvapCnPG4=;
 b=KamvvymX9F44tZKf6TyXOXNIe0i+zTkC/kxdZOaNq7XOd91WVtitFgW5B7YKLeZlsYoJwzl0rhHbemgwFkpPaEsk4KPy5lOUtzRlEO6UnZmGJbxhNGS3poqq7+Co2hctPfjnm3vCxW2jEG0aplIuw/fBkknCKVablLmiN3Vi7Ts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (2603:10a6:803:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Wed, 6 Jun 2018 20:16:04 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fQeqa-0002yt-Rz; Wed, 06 Jun 2018 14:15:56 -0600
Date: Wed, 6 Jun 2018 14:15:56 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] clang-format: Set IndentWrappedFunctionNames false
Message-ID: <20180606201556.GA10832@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:51::25) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:V3f9y3ndqixgH8cvSFVZ0jCMLRP3LW8Mgf46+ORg8HkCqAd3kroeK2MeYQI0rpK97446JpwXA+xs0J95NSMLzRp4ZixzxU0t6R7bpFgzvpDc4f3bDoa3BjPQValYk9EvaLFNJAgpkov8DHLj0miSTQgfNH1msR3T/IsGukjhJOMbjpH7VzYYDkElhdyRKEdLGvOh0MD8OgoOdXbHRr9+OUls0H39+phKYFpDGhWsCD4NdfmGVnd30ZdwyE26eB8i;25:2WWQ989nlNR+5Z+aRf5uQrVUDte0luCowhQY8lwKMa7RDEn5caU8Rg7NnMtSGIsjt6Z2vhWj3i8cqOVtsGW0Cit1pnJuR1cKoRG8Al3iImYhNIzIsJb/ABTdEcK0kM7yLVo9WBsMgVGRvyMpxBQl1A2MkwkmoK87RubLVWQ/z/oKYmFzYM633Q7+TPkN4NnsJ3rk8QOAodyEK04I2punJKkZr4pEm/n14zAxBIzuaTJobQ33FhwYTozxxLC30hHleMS3l7+4fZpFQMkI9CQMSTs0uz9s7aBDZq0NbDuZCdbTjOUX5HDmDrXA8F114rVxtCxWmLeaL7fy1wBOeS9kLQ==;31:79yNtFRCEjQRYqeCSlXb04FpwFA5Zdtqg75hy5E++qAsxtZAbaiMy/hCixH++lNE2liBluUvZiw5XOsFeTlHe9EGtQg429AS8IbClvWnMjjqE+O2ku3zKd+BTlAdFRd3yoimkRoOiPSRhKeeL3FfppBTcyBHlXmUnoJJMZ7pxJ5SQXudr7S6JMAln8HdnbqkfhC6eIm7HgvRFevXubO0I2HvyDi/Gl/lqHafPDaXke8=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:jQ8Gl/31pHc3GY3N4FQeW1gxyAIujAnCg8xYUJt4TiiZnwa8aE3kTqH0Owp/IoLT3heSbWF3j+TWZi2vSmB0Yy91gqZlfu0HvwcZsdIPB42GJ9IC7bIFUKE9Wg1bbPYs2mmznWcSmorf1ftP+tUJzl7kTtGMaKXGBDeuOOIIhl6ryqkGPEyMHQOm0mHLIi2MrFZLmNsorV5jD9BsFrPUiIFgVd2ZYJEZsEzGPVl7rVaRr/YuiAJHSXPv3vPdKDDruc2xWuAcTX7hCeS8ZBIGlE9V6a7TbvOkwsahQ84cSL0xbB57skXSLg6y/mAuRDownsPsrAsc2ne/dh9YtKVuOLmRoSV9bHoI11966oJ6BO95A9RqkwGJp4uh3k5LZjyiiCnJRtY1CqMJMNKIrIehyocEvX21gbwdxmip3oIRQ4sa7Ppm3AWSbIKvYI2BQ4kclbvvZmXtFgoHVA/3wb6K7NManG9FMaSzQ/apS9wihm4MjEfDfnKvfhhzuXMMa5cP;4:dYHhBAhN/MOS5Nam1Juv113gxyF5xCU/e5uB84Bi0dL9VjZO5m+LylwE8oE/vwHJ6HZGwwYzRqFLxjwt6nkWgCv23GLw3XFRDKhkNrOMLZHsAS4wOjP6/KhBw4D2gs0x3qStqDaq7lecO3eZ2NvKaFUltdeK9XhRl2Q6WQIBrb4rjp9JLG6ax2y+7XOMIY7zQu4axNjdnm4PT6A7qcaFu4h6qY24+eJhiULcCt2CvKr2c+gpAMyRa0GjiWevKYaNhKJwlL9uZJeB8//HHnyAiA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB44623662164F139EC179254ECF650@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(39380400002)(199004)(189003)(23726003)(4326008)(86362001)(7736002)(305945005)(1857600001)(386003)(8676002)(33896004)(81156014)(9686003)(5660300001)(2906002)(53936002)(97736004)(39060400002)(6916009)(59450400001)(81166006)(122856001)(52116002)(46656002)(26005)(36756003)(8936002)(575784001)(66066001)(106356001)(105586002)(476003)(9786002)(47776003)(486006)(1076002)(83796002)(69596002)(57986006)(3846002)(316002)(16586007)(186003)(478600001)(50466002)(9746002)(68736007)(54906003)(6116002)(33656002)(58126008)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:SxG6wgqj4uW9B5ALQlPuyQhlwbzIUNOhBxUN41HDG?=
 =?us-ascii?Q?rk+1i+YuI6LKkET5Lecst5nI+hDgBZk3BVgUtospfpKR8ISDJYn2sOQum4Th?=
 =?us-ascii?Q?I3TLyJ51mDFCbKZ9Y77zZrZQcGBXouAoDgzn35d9ecG38JAwuQINtsGw5+ZR?=
 =?us-ascii?Q?bJKIC9r3+FJzfPUO6zEaBKpHqF3VkVU6KO91kZYoIApQF1DX/tHkOs7RQVhE?=
 =?us-ascii?Q?oh2gZtdOAGqqmpvYIZIP8YGK8SxFW2Dng9LG0HybX3QGdkazuovX2n48+X9c?=
 =?us-ascii?Q?9qj4hQDt3eKLv4ZUIRYAfWOiNSd3C76dJi9IQFpke30gkEi6mKc/FQCj4JzK?=
 =?us-ascii?Q?kVzI16qXaqGp5CJeuiE6/QjM8oH5VNxjU6th7zyt463empppHb15X+jL2Z5q?=
 =?us-ascii?Q?ZQnVAh18kvF3GDyy7SoFqZzmquwcPQidERRUGlxhfV3AFf/8SDguBcvCexFE?=
 =?us-ascii?Q?99K6OY0BpqPvDJuCPQnPSBquk6RwRwHRv26yQiI/S5p8546ZR/Llvn/FmLXO?=
 =?us-ascii?Q?6S8QrJRxiVezmDXltWic5E3rXb107f36+jl/TRXprZUyKLN4mbHvD7Xb2TvW?=
 =?us-ascii?Q?8rfkd3JhDJWqXMKHkcpqMVfoSQSK/ClUJSWUOVeNvps9de6/VZfuUEWRV56T?=
 =?us-ascii?Q?jfm/JCkkZF7xn6tcLgfWzu1Ei7dnSS6erjnqabyIJ52XjJ0DiLJgx/ShYEdr?=
 =?us-ascii?Q?Xha2cPoleoyTvhCBhIz0lBKXQAYDBb7IF/W6cDWnQOJt8kRDr3bh8hioAdNV?=
 =?us-ascii?Q?8WR90Q2hgVNfxdu/wCEQT2d2Jhd5XD4G0N8T6MSaPHPNznvOAllORUbmz3BX?=
 =?us-ascii?Q?rMixv2prY9AW9pT3x8EDDoXjfAunIGMQpbxZ5l2LiQlRuoECMR5WO9kzNBhQ?=
 =?us-ascii?Q?dDppEG4QlAzwmt9jQnBPG8V9p8whxT5ENDyt5Sr1ME4fSn5w5npwMMemfM3F?=
 =?us-ascii?Q?Urx12Kki+u5uhiyH+larKe7cRKWfknpYfBnHh17fxAvaJtfKMkH3yauz1tR3?=
 =?us-ascii?Q?9T0zxWPI3NnYccx1dlU3ZmztFsJ+GVsBJMv5SIXq/O61TFq8zbFQAm/Myh4a?=
 =?us-ascii?Q?PIvAVM5SaZ41rqXqRNE+/K16iN2qjCFBu9G4zmWHy6egHDjZ2cufwcj2DWId?=
 =?us-ascii?Q?XAk/ywc3k4HzoHmmKf0C1+8h2KaDTOuOQ+cw1qHa+49ax/Z/AQwZ7AtXq2Ug?=
 =?us-ascii?Q?KYLQ27QrB7RRB0cIrbYuJ1TDWYwsHyS7DY46zNLPh0FtVsBFH69v/sujqGha?=
 =?us-ascii?Q?nZL6sy774x4QOwA8qPbB1Ay9+jC8tWh3xKmLH2v21AZe8BHtlgm9A9aMHves?=
 =?us-ascii?Q?jRV7oXD6D9j6UWYYm51LqDVkTMdMRcctWOPkMG8SqgfDUkPggIEUbl5p8Y/0?=
 =?us-ascii?Q?1NJfzNpMF4ct1oHZaICIe/GHyA=3D?=
X-Microsoft-Antispam-Message-Info: 9DSHCpa7TQOxyl428/hSrTpKEGnYWP6c1tYPBBEcEsoOBRa9OJy653ossZHbdsuZYuLVGOaoRWtUpkeUaqhzlAMHER9D0myJR0NdKDKLQhi0nZD7NcsaDQoXGpYwkicpGGgbotl6RAWgUADo2yd0bz9KGUKph1ox0Fjdt9iP8/QpJq1j8qlGcWJHlf8Xc8i4
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:tJ2DPoaZYgL2bmyBv8IqqnjfbsXajyyHiWoet+QGjKonpvZe9wC0gcA6BrztlU6vzaKsek8acluv69MVLeVPL4oCzBE5DNDoBKKMtFwdyLHGfNHYIGQAd2aWUWV70u1vADr/AOPPHSNRcY3ItSAesDBSyg4KdGYEdCAjA5G9cTjlzvIfYYUCh063Rm3e103RYv2ac0HxjQe+wFEZjxcy7wUrKLwj49a5eqSmvUp/RrDb+H0jiajVntJ9JiMO1z64M4b1P/tFy23XlGbgdmnk3G+1JOvZJOCAibcXurtlCiltA2iq+xHtILVC8s+jOtZtUiVgfIfRmN6fH8lFg8f5AEN5P9Ghno8lv6p3RODUxBOfd9QRBeuCMzuG0OuTeTQtprqNQRx8Xo9gqArk9omBlcZKKx1rwcPfZFUPjImAYCCbPerNuKFOjUTp6xl+AT8f6Qk31gKqKiGYANCoLXOBEg==;5:v9A2F412GG+WG8I5cD3CgMIlBqmhEZEQKvA29CWaMTAlzOM0D5na9xFPm9F+/uT2BGy8YClvOSsKaZCCxU5Rdy0gzWb6a36VxfZZSMT8HGVjoNPv3xIHQSucNtmhlGXm9jgvvREp8PhVH05IEj0wWp5elQgwVViKu/vZGH7scFE=;24:CKzavtZNoQQAQZeny2WBpUaJcvTtRQJTQOiOY4o+yP9ym4rw0/2dP9PtvE11NXbPO6gD05uWoQFgVMSw0/jpVREqifZ98ZLslGyI+u+Qxpo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;7:AI2PUhlFRpN3r+NqamT29TXxyw9M4rE14Ig8UCkIhEuAX733dSTGdQX0zIO7/zHW/acdEyR/yHWu8CYZ4tQgQsC3n1EhzGgliToE/Gmh2DmkwGlf1osw5DEgAA/+gi5PXHZg909/gU0K1m4aUdeP9S1PFovppj8eqzpppmtC7j0b5KS7UZqnLvM2bCVBYL0M/N4LXVovlKkqyLXWBckMnMuh0mxs3Sec4g7lct0WIMgGz6W8G9gd0loNucLZgSY0
X-MS-Office365-Filtering-Correlation-Id: e6846a58-81b0-4b59-7d11-08d5cbea5471
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 20:16:04.0431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6846a58-81b0-4b59-7d11-08d5cbea5471
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The true option causes this indenting for functions:

static struct something_very_very_long *
    function(void *arg)
{

While a quick survey suggests that the usual Linux fallback is the GNU
style:

static struct something_very_very_long *
function(void *arg)
{

Eg as seen in:

 kernel/cpu.c
 kernel/fork.c

and other places.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for making this Miguel!

I've been using clang-format for years with the kernel and noticed it
was performing just a little different than I would have expected.

AFAIK the above describes the more common choice in the code base?

Not sure who's tree this is supposed to go through.. Andrew I guess?

diff --git a/.clang-format b/.clang-format
index faffc0d5af4eeb..1d5da22e0ba50c 100644
--- a/.clang-format
+++ b/.clang-format
@@ -382,7 +382,7 @@ IncludeIsMainRegex: '(Test)?$'
 IndentCaseLabels: false
 #IndentPPDirectives: None # Unknown to clang-format-5.0
 IndentWidth: 8
-IndentWrappedFunctionNames: true
+IndentWrappedFunctionNames: false
 JavaScriptQuotes: Leave
 JavaScriptWrapImports: true
 KeepEmptyLinesAtTheStartOfBlocks: false
-- 
2.17.0
