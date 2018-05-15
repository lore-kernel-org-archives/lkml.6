Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeEOI56 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:57:58 -0400
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:32160
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752312AbeEOI5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:57:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
From: Peng Fan <peng.fan@nxp.com>
To: rafael.j.wysocki@intel.com
Cc: ulf.hansson@linaro.org, fabio.estevam@nxp.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC] platform: detach from PM domains on shutdown
Date: Tue, 15 May 2018 17:01:10 +0800
Message-Id: <20180515090110.26820-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [92.121.68.129]
X-ClientProxiedBy: TY1PR01CA0166.jpnprd01.prod.outlook.com (2603:1096:402::18)
 To HE1PR04MB3003.eurprd04.prod.outlook.com (2603:10a6:7:1f::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3003;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3003;3:B++8lvbiw9E8nTO8l8tekQYV1TsIJo0P83c7ywloUDixz7j9Fcj+YAFbMluRIuUViWSBO7Ql/VEZaIKWSrzI78AhL23j0SYq4LPKAUU5QJdB2qHOq0Je190ke9x7wP0lm5ih3eVnW4hsVKbw66F2cFrwl23riiGRebrr6coj1XauUOdA7eVHTcGqW7I1ZKJVl0Ux+cCa0uHz4BCoT6Er5qxfpB1CkWqjmtn4r8dbS2xQu9loBBlQ20tAmRK4WjlN;25:mWSih4YbldXAsnTFVzT9+3FSHInlM1C3BdwVikoDB3nfSxYruC8VxRksZVXxQGUK3FC+mUolXs2ChNdbbjxqP/u7ibZTpOB52nWao7Nd0FBxGf//PpjVq0iUBjsAPekeZrOcIefryG5+AxIS7Ecf+KEJ5uS1MfIw/l6pM01YTm+Rkc6ihtARts8Wrj9luwWqLgCAfEOgov3wu54LEKZEuiTj7ZEnUIEcmJsOMF58EriakKLIEB568rqZdTmj8/F6guoQzcB/RowPNR08tM19KTuce5LKO7Pcsu1vVgXF6+kfJftunkFXzPpk+IPf2vDyBC5DDMUFQj9Hvh6T7eyONQ==;31:Xcme18d3vaLFVSsGFUnj+7rkWFAK3diqDvdy5Wc7UC+E1fy9fRu5RJyvDwLVdfSwhhCOqgCyRGHmSPtvxLXfkDMQiImorXgDA9Fe2o7RwHl1SgyyUAh44v3U5w9loiBLhcP4bb4R4vyj2WRix48FdNXMEgma88EptjHYMBRupQS3AtrBbeQccdR+KDFr4UGJ7Swpn4WLtls0GG57q3tBa5UZ8BDMzqL88gqmIvPVvI8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3003:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3003;20:mRaAubk7q1dd8YmvoMdNrutbPD3IcSLJD5vULrXKbU/7tmbnRHvYKKF/YctWEkIUw/UCExPTpcNEFaRgEPoV+gtuMh3OOJQUMFRiRj4VEhcXahZFeg7VR8WWEJRcNzMEVtS7p4lNnW89zqN+5t2ezYWxPdFKxTNSF6AVsLzBImCTM4ink6pRLssVXyFrFHbHz+sLkTu7qBfCRhSqIPWVQ8Khykll2JiU2oWtQXR385nZpx+ou0iW0jYODfUD9g8GAxuC2auLdqBLgMi41jkL/vLzrzveWzaDlXDfr2Y5VebN3NCilNaiXE8pfRSZfoTwRtp5AnoGY3Pd0zOADrHkrPtEa9O/8tLxVVhTGnp9w8LJ5iQT1LTJjwhyJ0jJrBMnaRpNWcBf4NgKBLyqHqK/G9S8G+K+OQu2lVCJuUbV/i59BztyQtWSPu8Bwi1I+Mun0nIBMUWzvEsBIIRaJLaahWW9jYTBOkzlLcYml/C4YMyKjxliUVQZCdkqEt7/6rlg;4:zXYtOl8fU6NrrluoqfvtLXpy12y82sMWjbd2gkqyX+9RJPcCzCvoA8biYgm3/o4i6Kds2EdcaKa6dKMzq2y3Z9tw7vlFyO0qWEbQ4dLZzUOka3xQ8y3G0NJAenKemtmyxd8Gvkyae/jQtRY3zdZL3nbTNaD/6VpaciibogdpJO+06Ao1oNPJ6/ckUgY+vq9bETVFk761Df0xcjaitmDCQMF6BXG1u+N5geUDwALTGf//oYmmi9/uAiwp2YzAr+clMc+DjsFVYMpRuxwrxpKoQStYQRz2caDkhssAleIsUtsbbYSeQL2zVTjxQvH4TMRr
X-Microsoft-Antispam-PRVS: <HE1PR04MB3003B29150C01E4904A318A288930@HE1PR04MB3003.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB3003;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3003;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(478600001)(956004)(53936002)(316002)(4326008)(6512007)(5660300001)(6916009)(2616005)(8676002)(47776003)(6506007)(386003)(476003)(26005)(6666003)(2906002)(50226002)(68736007)(7736002)(50466002)(81166006)(8936002)(81156014)(305945005)(186003)(48376002)(16526019)(25786009)(66066001)(16586007)(486006)(52116002)(51416003)(97736004)(2361001)(86362001)(575784001)(59450400001)(5890100001)(1076002)(36756003)(105586002)(106356001)(2351001)(6116002)(44832011)(3846002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3003;H:linux-u7w5.ap.freescale.net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3003;23:7iurYPZfwZInqpfYpM03ql2IrPxmf54TyC8GDhpQf?=
 =?us-ascii?Q?aHlBNac39+jr8k64aPTCwsfZQYfNEdPjxCI/De2Z29CEPpsGHQgK5gj5Pe0h?=
 =?us-ascii?Q?ppC5tvfocC1SlkTU6QGbMsBC2DTg/Cq8uc02Cc5M4tgT8laTFc3Hwa5jC+CK?=
 =?us-ascii?Q?+BfH6j4uF2Q4f8julfK/cqdx0NhladWA/dw+etQlUf6YWf4QynWe4+PT4650?=
 =?us-ascii?Q?YbSh9yWS2hW+B4dCu5iybNGST6fk6kR3nV8FqVMRckeSHVwBKKk99fwd29UO?=
 =?us-ascii?Q?yttkYfkdL6dT2VfBtQ0jvL55kprJsufH6akPe+jLHsruGff4RoQokQsoTrFS?=
 =?us-ascii?Q?C0uOzfuGclB/6YhgBOVecvBF+aAXFiYST40vrk1RwKUB/QLeCtlA2CsKXF03?=
 =?us-ascii?Q?Hzh6rySEqN1gu6eLQmkdDh5MvV6AonV5R3Kky9KwGT5KINQFmjZyXPZIwsFC?=
 =?us-ascii?Q?H6uu4TtayEafDaeSk8/FqueZXSwJz2C0PKs14BdF8In/OO0r361EoLf6kbtY?=
 =?us-ascii?Q?MMZvz1oMZOUmmvKIj2aB3Gq1E0p2fFT3JM7iPvo1wtidKXvpAYT2p7fp3wo/?=
 =?us-ascii?Q?gNj4Gt2mColhKK5aWWtVGPMrCkCr8eCtG/LCzY19jY9DhtBUaIExZ0pQL8hL?=
 =?us-ascii?Q?Bz7wwu7cBATEGx/f6jHleturkVCtnUakEf6VPosfd69ar8vT+jbJPzhD2kgl?=
 =?us-ascii?Q?c4T77j/BWQ7q+xo/T/slntSLz14XjsAvKwOmaq25o9fpTpCYAWXtEcQ1nAce?=
 =?us-ascii?Q?PQIX2ZvS3yOqdF151DXPGNflRMmXArbyFhIvAmlV3P+QoTbUg37wACEabsmH?=
 =?us-ascii?Q?x+23D1VKkwmwakqx5TXN+5S3QZ65d7ZJvkgWfn9rm774VfAxssKg8ZCBIYMV?=
 =?us-ascii?Q?9gim5ux/1EATQ/fK1dqXXntWCg4EZ9bniFhkC9eu/EWhVjEyesp59eSqEY+x?=
 =?us-ascii?Q?AKBNRY0EsR0d342sUZCo3Dh+UWOCZLZWITeFfDbdaYsUU9dCvVArKnUJavfP?=
 =?us-ascii?Q?rvnjQPDHvEpF4bHXtWa621ElelJlXBLprCg+GpWyx7qCjzrufUV75JhBCGJd?=
 =?us-ascii?Q?Z1DACcy0qrEtBIHIaR9hoWvw7RjE6CVd1UiCBjlfAwQoAPqclaXZaFGr84Wc?=
 =?us-ascii?Q?Uofrs8KfI6MpRBc8qFa7ZBjMKANso17BMcFLd4wrq439kI98tpkZL1gJsb/2?=
 =?us-ascii?Q?8HRbrp4E3+uk+G/5Go4HJ7+B9RrqVhzA/T5Mjob3sYBsG1+2mVqH3F0b9nRq?=
 =?us-ascii?Q?zSx/J/HZAyj0ZjMxYAk67y3FuUEEADATXUoe7RO?=
X-Microsoft-Antispam-Message-Info: 2UhtQOBHDHxuXHqotoQV1iWhg6OD2pZ+enNswD0Vz/fJqaNEDnJwsSKwH/yUFYAp2f1YtPPaNTcfIN0ujJQrRJUKul1su7xLTfHbfj3bOdShJCU5MnQ/gZaQ1OlVaMT8pqYTyU94y4liWIVZSRLivZ5BIbxZkCH1u9cgwurkxNBLFQf+BMjd/ggbSlpWOOYD
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3003;6:EKNDJkb1FXLlAOC9p6Iw+NX/CNuLNIyVXeIfRUtgQ1UjlbHXkm6el9Tr2Ng441VB3AdYJBfmJTHK/o+ekK66X90ouSwoKLYX25Vhjgg+gcTQ5oRKlhDQ0LKmGVa0T9oyiMXdhDt5khwmmxl7yoRHlkV/lJSPNYwRCN44pCfJh8yzdwheqedZIAEYMmx3rLVJ5PWCvKSTkzRPVbDysswWVB/8TtIRrd+wYJrRcfVoIEa1YMTFOU0et9uv5B9Do3XKDeY/VlEKCqxiInQmsF4gYJCVj06XK6QIvPdVVHqxEGHOFhf6Y5AqzPbY6MP4LhOnZe+nULX1M+rkLY7K6VS2dd0/L0W9v3MkunnC9vq7vNP4GPvGprquzKbSJaVBiSL+W1fveJeD/nJync8c/iVqa7oL+jJEjFagaEwvdI4rqTmL08DA5cMip4HUPlAxqsWTBfbG4xdsAmQuIw7c2PG2vg==;5:kK6ZbounYTO3My10l48XAIGiofaZqnaQ+XZVyfmjLe4c8qnB+xOODW48/98Bq+a0/TLLANIYcWsgXApId3ahj10hl1XFdnBt0M+yAyNQ1O7dI8MS0hQao2B54VKqP61qPOXrExiuf6lI1zTfhU/fikFJv8vOjwEkBUAlPGnq1SI=;24:M5/mIsKrx0WGB4om4ygWyZ67Dc0vRKQJv1awV3DRZTRlMXLX6b4pUlehWrQ/iISedSXBmekzFh0usPGomooDEmUJjq4+EMxMpdr4oYDG2fw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3003;7:We5YSs/WC5IwMisSDePi76k3GjV6WF0mbayAq0CxbJ4GFApMpojaCl6vZjYVR5tSwdOU70pgZ1bdJj8P75cdCWLHtT8wJylmIfdg77NdWDex/fUvbrSDvK7b3nwn8fefCtV5Ul5dw1e48+Eixq82sqEuEJv7mhOOqDYvP/gSz5xVBio02JA56cuJpBKAbTrc8B/+yDflv991lipHQmM4JO76Uomrx26tMxjIbQNd7U5Z6k6sRxSfoXMeyTQXrIdl
X-MS-Office365-Filtering-Correlation-Id: 64b83049-d1aa-47e9-1686-08d5ba41f05b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 08:57:47.0153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b83049-d1aa-47e9-1686-08d5ba41f05b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reboot Linux, the PM domains attached to a device
are not shutdown. To SoCs which relys on reset the whole SoC,
there is no need to shutdown PM domains, but to Linux running
in a virtual machine with devices pass-through, we could not
reset the whole SoC. Currently we need Linux to shutdown its
PM domains when reboot.

commit 2d30bb0b3889 ("platform: Do not detach from PM domains on shutdown"),
removes what this patch tries to add, because of a warning.
commit e79aee49bcf9 ("PM: Avoid false-positive warnings in dev_pm_domain_set()")
already fixes the false alarm warning. So let's detach the power domain
to shutdown PM domains after driver shutdown.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

I do not find a better place to shutdown power domain when reboot Linux,
so add back the line that commit 2d30bb0b3889 removes, because it is
a false alarm warning as commit e79aee49bcf9 describes.

 drivers/base/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc70a17..a5929f24dc3c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct device *_dev)
 
 	if (drv->shutdown)
 		drv->shutdown(dev);
+	dev_pm_domain_detach(_dev, true);
 }
 
 /**
-- 
2.14.1
