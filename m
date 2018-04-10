Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeDJP5p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:57:45 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:38851
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751744AbeDJP5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:57:41 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 3/6] iio:dac:ad5686: Add support for AD5685R
Date: Tue, 10 Apr 2018 18:57:29 +0300
Message-ID: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(39380400002)(346002)(2980300002)(438002)(189003)(199004)(478600001)(186003)(2906002)(356003)(77096007)(4326008)(26005)(8666007)(72206003)(966005)(76176011)(50466002)(305945005)(7636002)(5660300001)(107886003)(6306002)(36756003)(6666003)(2616005)(8936002)(106002)(476003)(50226002)(110136005)(336012)(47776003)(2201001)(106466001)(54906003)(11346002)(7696005)(316002)(446003)(486006)(126002)(48376002)(426003)(246002)(51416003)(16586007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1352;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD026;1:AZ2gNn/merm1CdmMbESCQBSfbmqpvM6mmLh3mU27WnKhkSqkIurFv3kaZ7FDisF005wm64/BBtUJjKYZFMPHQqSY5nuXb/142qmHYP8/2dPkSbyZxQ89Lwd0Aw8Ea7bE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96cc10f2-e7e0-4dd1-398c-08d59efbc8a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN3PR03MB1352;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1352;3:KYBGwn/QSoT9u8KdOsnsVx451pfDRgALz0ak8Ln0afvmi3a89aq5EsodV5tyC/C1dMzRnlcyHJuWi2Z3rG6+usSdISDmzf/AY89YWRA3CywA8qMGGPqF5PodShGKla3EbLqPCbRHYkDjZi4yn+AHIH7av2dwrU4M+wJmYULTUopm+/ACcE3DLr9UEquugEDF1f48dDvAcMNxMg2h+RwQviOMmWyfPFck2bSEg3aGa2zYwm2VS8KFEcV250l7A42vYtq7g6oHCzhOR4IqORl6C5drNshPr7MnMrZke3KL6wPi44HIvvy3ZbMSQR3zDcVjYLqwa5pF2eB73U7MVhbS1SuxtaNZJnBidOsn3Ti3JqE=;25:tsimnGJiFjUHJ5eE+2KAu510AFJVC1X2xR6WpXv2AYIlg+fUDnPE3mIGLYRFKdqAg84+hg+6P3YwJQtXwUs70pbAPddGF+L7zwqYXnpN/vUBnlmJlT1k+BO6KeQzzhZll5dwbd/i5xSqCgP+XV2RfQ4WqpX3SUGmfQSwEqqa7GnCkHyavGEivMV1slyEmq+wraKGIEL5MUUFzSa51UT1r8ZKTKm2yTFOUsC/iNHlqNMdoqK3/zPPvz0lpZwHJCzlne7kx7zEj5TdvWhHmxFRS+Tji7VcOmBqOU8B2dGv4vlFz5Xkaw2lg8i751/TtXmToYriRTyeAiar6QDyiOL20Q==
X-MS-TrafficTypeDiagnostic: BN3PR03MB1352:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1352;31:Q3p6Zu40M7FJEuPA3NJt3pqDt6uQqZtNsFRRkoPnuUIQC9/B32gnRuqmM3knyRLMLD9MrqJFZ44CLmX4f/7i3c7FhU6sB3V9guMNB18OcPL6cmamleYOMBCYAEqghKdfo1focWJZULt0DltKr0M2SG4i7ZWDmKnZf70jmCAs0JObdevi1HHvjJk9ZqqIBWRPpGsEd8lgALh2YNpe/WS+t8Q3+6qMNQCFPRDed6fOFeU=;20:aMhzNygmrerKdYlMywQ5FYJqLioVU6E6unO2nt1gf2flZroY7U+olbLYnNqyKrVt4tDQ9tU5PSnbZgfUh7gBBf2iPgmUMCOg4ZpCoBfV15vFiLDozZOlVB6Af1by/YHv33AbzPRjZLBMChvKPz/VXQdXFNYETJ0ODiwynKrQMeu5mXcQf1jvrJ9TRLG+ABvRPSm9JQg6xYTNIqqYYlLiAdt266IWlMs+l+LF7+SAYTXEYOYMfj1V3eHRAhZRm9c99Q1tuhWCzPUY6b9Olh71W+P8qIba43zYpBRrMnBqVlvktjgEqpmOro78wnwJdLZYskcaTXkm+Bjf1Yg4k8fhbMSedPk/Awt2zEZyn8TS5uS+E5uphv0r0N7hWvO8kad95f+hesYQqNAGOTBlfEi9nbFc/24lWyZxhRlJMO4Zfx0fM5TLW+3UXn4A1hiskrAuxxht5ipcxHvOlRTjy/xcXho2BPILOwR4K6ftA77vgebseVjrF9f7uglblTXOXjwu
X-Microsoft-Antispam-PRVS: <BN3PR03MB135228E6B3A65E7CE556D6889DBE0@BN3PR03MB1352.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN3PR03MB1352;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB1352;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1352;4:/UYfT0z4J8deuoffL47PTfnF4qFbQV89/uQ0IpCTrDBl1Uj1R7+vLRlN7lmG40nCqlrWqvjCq1eGtchpMoTCAJwQo3V4GSAO3EX+9oVHV1H/+w1kw8M8YO+7p10yz8LLqoFMxW/X0zW/PKcYepKdCtO5zb6IOVr84NfM9X2lzsEvKT2ZGwE3yoBd5RlGBez+8Omh1t2zvYfOrgjQaxRxu5plJ9NG+Mf5y6iv52RaUcQeGyap3EkNEc6TaTJ0DfFrRkJUXKtJ8JaNzcR5AOjpeFbQN4GC7fqSWuY6QC4svUYrsTAJejsyBhJ6LgmIZy67LTFLdELFiIbDoq86cGDv7W85h6lEX7SjK4nKWF+kRVA=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1352;23:llrO7fpvjAEQQ7/Rhhrip/0Aymp/MShT0ZhA9HxFV?=
 =?us-ascii?Q?fzBaWbKtxw4yG7PDN8DNsqfdQoymxfxHObjiA+E6EsbD4WNtpYeDnFMhlbS0?=
 =?us-ascii?Q?qMqFSiUfN/Sztxb35j0mucbUTDWL4SyBZE/dDCLlgniDJslg4fcnhqj66k4k?=
 =?us-ascii?Q?pXQFl4ETWQ0wlR1jv1f6Tf8XeDpSHKbQTxO4A2wto7UQR6sUcNEbbsxzSsnp?=
 =?us-ascii?Q?VO7uLVb236BsI2fid8JYlspREBlUeZA8oB0Z0N1QcQrbgQ3G+d02nsZTDAvI?=
 =?us-ascii?Q?MVtB4zMS1pjszKN2vtxmrhaWa/xs3u6O/XmsOVF5JjDwZ/u3tTGILWiGE0c4?=
 =?us-ascii?Q?+5s0DXG47dTWJMk3GqvYlzcsbBBQuWiliI6iQXruOagPY7iWCioaKx/ua5rP?=
 =?us-ascii?Q?S/y3Bsk6zpNmQY9nTpCxMt27CSFNV6CyY+rg5Xtr1uIS+CbcvqhNSAlsYrNY?=
 =?us-ascii?Q?XV224QXcPfb0v8BApvW+Zj2muYgwJx7dGMG5XNz/rEYWePFfi8WcgFtmDr0R?=
 =?us-ascii?Q?csY14WyeDnSAqrIC2lKf8P2+Q2aKskEFjb/7yx3UBbIu37j/wmU+HdRgCarW?=
 =?us-ascii?Q?HxauqIKDHP3ldMicmcRiFz9Na/vUrPkKfsbgtCkl37EYiit7aKdKdGXtyIZ0?=
 =?us-ascii?Q?FMUV0B21YN9iBrAP0VgbQfjhT+/gAennpFGdNDL1l1IIyDRDhNgB/zU/nz2b?=
 =?us-ascii?Q?zMxzJ3ZhExLbgAIvHTPWTSvZOCDpR/UfonbBikmkkvyjm8jFoqKoRD3FRaNe?=
 =?us-ascii?Q?lWtueZJYR7Uav+XrNkViwBojID9E6vRTc0sMZW6VyASoeouS40K1+DdKh9Ny?=
 =?us-ascii?Q?Ezuy5SAtuTecfmE+HnPQBzImu9HNLpBfbqvnnPk/MwBRj44T6uqFVJRRrhHK?=
 =?us-ascii?Q?sCoA+23cbkZ9GqCCJ/sste7kqdZGXQkL25UIIxoL38Z6wWj8KDrfzFjwgA5N?=
 =?us-ascii?Q?O937xcm0JyTZoMuahwcT3doW6exGbXcn6TCdo8c5/k1qoVyCS6OClnuf1yzk?=
 =?us-ascii?Q?FDodWpo7XLLnD3KHMbnagf1ZkOO13ifddtZQJKaPi9cuQktm2p3zvBrnFWdj?=
 =?us-ascii?Q?asYBpkEaKFceqEVtyodkN5Ju5IamJ0e3846QDKYFv7MJqOY+JwEbPbecUcM+?=
 =?us-ascii?Q?y3JvbmFnXM=3D?=
X-Microsoft-Antispam-Message-Info: isyKOmMPwzzY9+x4Z2eZjIhPwcFv347W9N/UXftTKVGNRfySplojJRkGmZylqT0b9BnLrlXMvZqx8T9O2AcxNtD+bKPncKqvkHy2QJJMI5Py6onx3vQEwxlLyDxAGk0IVxeDT+VljvznjgkmlNmZyfiekpUBVOTxPk0n5tynY8/Oc3hZPaKNCHFhKhE+bJnP
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1352;6:ZR2lsL2RKZNsTm25Se0MqaE7tFFnRoHargh+ZKNUQNfMrgUSIx7Nf1LBYxkBkScVFAMlqh6Gj87InzKenanPhqBVmvBab/WFdynOQYOAfQ+cQYNRKzMO1u/ejNDWEbDgEipNHOw9xls+3YgALrMmH5IkCoqAILmGsJ9ha+itJjaZAUWOHt03D/fffcz1XZb/vb17tcLlfVLM5iaCn2LEzxhg3WeE6MCJCnhuFUV+MauGAIb12qNYsp17RW7CRoCroFAmg9avO7B8A2qlHcRmxhjUtt3TiVRNti21hvOvhQC0Mgd5UqS5qoXdYvN2aKCmmkg3CS9JEp0jqiFB3OiQhbRqEiAUwcVg1Guliw7NMccpTwQhlmwCAj2w3DUtswCtTT+EILAPuI/GD+HkZvMSFCgIwgcfshTAJWBwXjHhn9ESncFG4djMrRelwitud/1qo7USTlxrBZ8vMgA929TFGw==;5:WSbQDzdEJXWDc8aaCWhN/6IdnIjOZSMOe3TN/wfmSCY0JmZ7mV+MJuqk5WF18SXzO6xnBW3LT8YQkXtQWG6O85gclF67TfV8AdrbatFISvygVtIxxasmmE6aPAntOOUiwuIyJiYyqdtfWX0K9AW+SRu9avUJ3wY7xHXB8ZA4Ew4=;24:3HXu5+yoZX3E++qj+33FkZoDNOgOvD8npiAvbYP4nS3f4ReMUC7xcqA0TnpGdc1UHT8I+/tQn3Je9rV/kCs+0FLFgCiH1nYy5xbBDJgQ5/M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1352;7:QlQwENbvkIXeKMNFE5Piw8NUlpsg2aezggGvznjOfCPspSMs7HZL8w64QeBZ9F+4DJwOuFvedL6J4l3TUnSQFXgKzt/aYeqRpUZeab9nqnRIXnu8RK/DLswCqNnmbSg+lo2v9b9kEORbKLPdgfxWX8QyNY+OYCPZe+w/w4epYNgeCwhH7HWTOd0ww3koz4RjOAQZbfkgeY4QBZpJBtMYJV0kC76VzAx/4i6/vJckzWOewBgBvJJgrlkWw+VPdd2B
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:57:38.2083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cc10f2-e7e0-4dd1-398c-08d59efbc8a7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1352
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver acctually supports the AD5685R device and NOT the AD5685, which
does not exist.

More information can be found in the datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686_5684.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add support for new parts

 drivers/iio/dac/ad5686.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4d1ae3d..7353c03 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -89,7 +89,7 @@ struct ad5686_state {
 
 enum ad5686_supported_device_ids {
 	ID_AD5684,
-	ID_AD5685,
+	ID_AD5685R,
 	ID_AD5686,
 };
 static int ad5686_spi_write(struct ad5686_state *st,
@@ -304,7 +304,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
-	[ID_AD5685] = {
+	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
@@ -393,7 +393,7 @@ static int ad5686_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad5686_id[] = {
 	{"ad5684", ID_AD5684},
-	{"ad5685", ID_AD5685},
+	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
 	{}
 };
-- 
2.7.4
