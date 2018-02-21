Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeBUW3m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:29:42 -0500
Received: from mail-sy3aus01on0124.outbound.protection.outlook.com ([104.47.117.124]:17248
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751425AbeBUW3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:29:37 -0500
Authentication-Results: spf=pass (sender IP is 111.69.51.18)
 smtp.mailfrom=enatel.net; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=enatel.net;
Date: Thu, 22 Feb 2018 11:29:24 +1300
From: Michael McCormick <michael.mccormick@enatel.net>
To: <a.zummo@towertech.it>
CC: <alexandre.belloni@free-electrons.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michael.mccormick@enatel.net>
Subject: [PATCH] pcf85063 was not clearing bits correctly in
 pcf85063_start_clock
Message-ID: <20180221222924.GA11756@michael-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [172.26.6.110]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:111.69.51.18;IPV:CAL;SCL:-1;CTRY:NZ;EFV:NLI;SFV:NSPM;SFS:(10019020)(39380400002)(39830400003)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(16526019)(69596002)(77096007)(46406003)(186003)(1076002)(50466002)(336011)(59450400001)(6116002)(2906002)(23726003)(33896004)(4326008)(33656002)(106002)(26005)(9686003)(81166006)(81156014)(3846002)(15760500003)(8936002)(5660300001)(6666003)(72206003)(316002)(33716001)(58126008)(107886003)(1857600001)(26826003)(55016002)(8676002)(16586007)(6916009)(7736002)(356003)(305945005)(86362001)(478600001)(47776003)(106466001)(2351001)(104016004)(97756001)(54906003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:SYXPR01MB0591;H:mail.enatel.co.nz;FPR:;SPF:Pass;PTR:18.51.69.111.static.snap.net.nz;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SY3AUS01FT007;1:YnmlB0RWyZ9cAt7C92AeA3qhfX8akDMZwvYwXRamo1z86wy3YeJ5tr7tiyJk6JhPhtVQY3LQn3ibDr20uY0uglLdeJjJozXRqZCsWG015feAUmp2oPykjiCr62cAKBrc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bb3814a-bc0d-48ca-49d6-08d5797a954b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:SYXPR01MB0591;
X-Microsoft-Exchange-Diagnostics: 1;SYXPR01MB0591;3:V7nHS7RXJBTGIqFiFNHW0PvnnDjd+IGeTaLGwDEgzXDhid/Lq4W4ocWELSdMeNFFmeH4s4BWf/pN6J7tn/I0encp/laLfO1gni0eVE/ph8WoVNOYFb3JEAMMU9SmbdJ2OBACmuXuDOt3o29R1/shNNsVJbvqSgZ/4wejmVAmV44+2TZElV2B7QuTRxj+hszJ1bE65ImkuxaAG2JdVV0MGiuLk2bnk091pck4Gdw5p4WHl5hqsOnY5CepJR44OB9C2wU4SguaD1w5GoxVohPb2WQFQIZsmlN1tnWBQQrNdCi/Mal2gYMJkaPNNahcEnXjDZ6aVH1LojFOujxP+jB6MCBp86DNY0M2cRbMrvXg7/I=;25:BtHBP4oJ+cvof+RPX5dZ3VZR23G+mMnpVmCjKGhMW3LaPOPxXFrEwWAW2fjB8M4QgvNBa0ftO+XMhjYk2mXZMZ1W+Cc06bUGPR/JualvADGI/VWRZKBH1gQBSVXRilvox5cj34k5iCqlQfFaggK3ZcYwuYtNN0IwQ6OgKNhVWk75HlUn8ujy9szc1iarRfUTX2V/S5YuzTjWzTeHM5/fwD5+7RB6qdRB9mZalSfJ1fZPblufEU5gjTKnSzNX4k5UggsJkGNUq4n9vAbFRXbooZ+8ibdz/asmrYUjFg7zOXQLEhn8wrPW6Pz4CYjXF7lwDPCCWKPRlpcb7+q+PIaS2g==
X-MS-TrafficTypeDiagnostic: SYXPR01MB0591:
X-Microsoft-Exchange-Diagnostics: 1;SYXPR01MB0591;31:yPq8Jrisa65vkg6oM9PLDCAAj9PF9C5AnYocxvmHMMdZKGqHoVS0RqKcTBsbXzMj1+rETrgbNA4Q0hbc4jANQV4VPtlNCUO1nlaeuvNnqv0N69hwqGVFId7EbPlLKBOHL9ziOk3p9oEpXAEFpowdWmgHvE1RYjJQIkHUleVXKuZPR1dNXVWWGAs1aVEDqX9K5zesUvg49sAEARoiyhXQneA6w6mqERIe6btOrcKgslI=;20:9+SWnVfmHZn2gRg2uvYpsb5lO+kNf/pR8Ey1x9ePtNxHJwBHvIwDyRzLtI+FxVtvaTP7L4hcU3kRt5no28nK0EzPWqFcTBWmD9rW2xsyawdEnQmaaKUqchaF3pKFqeVFpNRUk9dOmNsOVoDZ260RuOBKQst7CtpGRH4YD5OH21zjSWVApIAKsFzouH48EbuhivRkDhCMYsfRvwFp/X73n49PdwZJ0hGWjVgLprcCBbqdHhDU/zJKWwADw5ekw0tTWNodxd4vzD3yeRaQVsnqycAyZpxkt97T5o+k17htveqSJuX8+UgWC8Y5srqSxYkawx8dx4wtiq1R9fZQkdLU66gNyfK5faWQfIBwfRKtZbJjwnFhybiTdPNx+wa+S84TEOxAZZV6q1p2quy61d9jCwXrZvelSsZbJ6JRTXSs4Lk=
X-Microsoft-Antispam-PRVS: <SYXPR01MB05911DF6031124353FEC07B489CE0@SYXPR01MB0591.ausprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001072)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231101)(944501161)(6041288)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:SYXPR01MB0591;BCL:0;PCL:0;RULEID:;SRVR:SYXPR01MB0591;
X-Microsoft-Exchange-Diagnostics: 1;SYXPR01MB0591;4:jNHiWOGOR6d3bZzdqwHl13XIetAcHaoNEc07RdwkWzNlhlx9Xly/HA76R4hBZjch8oCiLnCwZS/SVbTCUN5TVMbv1ZtoPgH1Nr7ipVDcSR6UL+riCdP7nHRAs1wlze6yPNCiwa9+TMZ0loqa1ZYf+HEkDhyeaVkUsFOl0ptwm7baPRh9xGYV5RrNfDMMIqYAJqjaVNoPlEBTzMK+0Y9T3EbwNy3czam1Eizu1GwbwVKq0KVPstS9VoiH3HCsbC35gR4GE1WgTkMy7yBTkU8WpQ==
X-Forefront-PRVS: 0590BBCCBC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SYXPR01MB0591;23:kgTPhVZ4EZ+W6/gpk6Qk14lB8n7rKvkPFu3EIp2I7?=
 =?us-ascii?Q?sfgCuB42sWfVlOADJJnWQEMemrnoiLER8j1BaURxvSQLPmp1pP+eRHJV9NXU?=
 =?us-ascii?Q?3QrYhghCU8NcVHG7Q2dGuhTtAhp850JLLArISpb6wE0f1vOGgow/sCzoW5uf?=
 =?us-ascii?Q?ZjCWd3n4rK3uWHZU7unGyG0KVJwe+3MOCnd0vTjV3VbNOSJlK5zrhSAzbgF1?=
 =?us-ascii?Q?MFps+hyZsue3lSvXt6gTLj6yCH0Sl03cTjkIqwJSDuh6iDYjW6eAaTsDu4to?=
 =?us-ascii?Q?fa3+lAHu2RbgkcMTsXlcTxTnDcnfIPiECCwVDYrNRzbTGPLagA2qx/cuqvWC?=
 =?us-ascii?Q?DCwZsDyGw0zD0GWcq1sjkom0xlZj47v1HQBk8Z/J5KlWauglKvGWKNHxOEFo?=
 =?us-ascii?Q?o04wQSmtw2fBn+/A8RcGcFCHygYlF9Sx7jop8VtfdEj3EEYtmAwGB6SgPLtc?=
 =?us-ascii?Q?6P4BYbO3Hund6ZngloLsBrLJTGLxZU4ba+H4EUwFRNLQ7zv0u6O/upHqbdaK?=
 =?us-ascii?Q?KM8kK60VdPpGYZXE+SyInnbthlC3UVDhv+V2PD5hzM4/MOUP6Wj8F425OBM7?=
 =?us-ascii?Q?pFhx3d3amSbnzFiCq01CtrprG6Xk6TkzlXXghQSzNsX+lA0bDf0ojAK4Lm/M?=
 =?us-ascii?Q?5W+ezAOKcR52pmt9pHK5vP0SrvYyXi/doa55pBjrvjVVs9nb8a7lvzXD39B9?=
 =?us-ascii?Q?epUmcx7nJC2aodcTaMrNcovVuQIBLXURpjphCsIbBPlKfxC3UC4WkfL72FU+?=
 =?us-ascii?Q?nLqXpeVMNH8PLLbuLa5qvrPeO0X1JLmp9oRvqws6Gxti4jWG+b5gud1cpmGo?=
 =?us-ascii?Q?HfdSf449BjYqAK3xPrpRffhHJjN3BhDu6Qx45yDSgMLxBno1b7b60K3jFMR8?=
 =?us-ascii?Q?y5kVWfGFQeA9Niooq76g3G+ZRRD2ksuXiXGTbavonnV784/GcJcRtdRy/cJf?=
 =?us-ascii?Q?3eFWWifVMCODlnW48KN6gWYd+ewt+GH25f+jFl6U3n2mqz9jA8Z0ytrMOZ+B?=
 =?us-ascii?Q?npgv0jQcmkqG+QdzLicDtynI4zFjFB5dPe1Zs630UC9OGaR0BrAzTYpeNIbX?=
 =?us-ascii?Q?t1emZ1tVOXey/+AxZVrhcQw6Xg6xZoKpYO0tDeqzv3uobDR+KPjgdJgZQIp5?=
 =?us-ascii?Q?YuDN/EVJhZWlm+Weuoq/BGbF5sNGxpAtxR7/Djiodwto+TsV17rNHEyjEXZX?=
 =?us-ascii?Q?gdoEElcvu7jfD+HO3/bE/5LU7QQqLACxicJbbV2P4oPMzjkkitr3U030yzLP?=
 =?us-ascii?Q?I7vSa5FsXbluIKQA8Chtck5ph8IkQf0tfCVNGoyITxIELWrc2iSaDnD87lmG?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: WI60ApCIMvi1nbTCF/FO9LGbro/Govo18+qw97er4FOug72RIrn16H7cyJm610srxEe6XDCngSCymRI1MQyq416i7hbOuEY6IWxT6uWughb4QCxm/o4obSwRx9UNR7+qcZfi3tP+UYDwtvwTLgSy+KEVxqrFUrMUlwsA9T2ADJ7cZ7hCFFsaHvvHGeNhAn57
X-Microsoft-Exchange-Diagnostics: 1;SYXPR01MB0591;6:gp+79I+jLqAbVUqpSaFyFoeeJ3Noe34XBUjv2AO6AHDDNO/L4RfUUnXM+tA+0Nk+A5Es3r+/BdEtbBtS3REdDVafgeXr0mfcYtHCMX4H+2uunjiL05Foe2kpXxYFRaqDptW7CJKvZ38eDhcpZkb4vuvTzivQfMLE4vYqrl4IUugtDrN6D912WsWydTlFKq5UPD1DFpQwnBPeB4eE/X98EkXnnUSme6lMyiUw5OebOGTt4SfFG1CjIQIBTYxMMLwuhZLidmq9JzE7hOHvAtQLQ79E9fHUbQFgYKXkZKzJG2ev9sQGnbbxrmm5g+dHtpxh9N4Bj9P0BZFhLHUX9/cwQvTEj4xI7kO743kM7cCH/Bw+bHU3Gmk+iikn9F2pCvXd3NtUsvHqpQSEqF3sy+4PHQ==;5:AqMmqe/PXodpXlPPnOSjgsUCS6DtNJTR4ecJQXdPUbED2g+Ua7yPFHfNlsqGjRPix34ohOATxZXkXiImdrA5ytBw8mbJI3XSTAJgxLMWJJg+2Or4xPwFzCcqmVBW2eyGU08Wh0C3EShGqG4a5ZFoj2GswAdNA2I9j/ys21dfA3s=;24:1M9vOkJ3FV5+fDzr5EHj0FcfZTEUBFFehwLDXGjWXvQz7dS/QcSwwgOgWqWdOteeMQlFksdk3BagAPR7Xf5clKLBxjGh8r5Mc2lo6/TFfXE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SYXPR01MB0591;7:djP8Z/KKnMlk3tXkLZU8ozsyIdYqmBHLPVp8qIN4rIAksKiL/K0UqyoAwdF8NEiL78o0JJ9irX+ZdBl0Q6+dGDeALDlFTE6+WkjpaMtpKdo6C+hLewsIeNsCZF/HFRtrSbrY1PrWtKG3aAKcBkSmPvzCdn4WMVEUn/12i60OGcrkuJ2LdDRIqffQngNiLIiuluBrNGVD20C1uR96HECz76yduwas7p2QjQVLU+st7ArmYISttnSNu5n/zNmLotZm
X-OriginatorOrg: enatel.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 22:29:33.5190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb3814a-bc0d-48ca-49d6-08d5797a954b
X-MS-Exchange-CrossTenant-Id: 60c5af6b-3b0c-4e87-85d7-9a81b4eb7f32
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=60c5af6b-3b0c-4e87-85d7-9a81b4eb7f32;Ip=[111.69.51.18];Helo=[mail.enatel.co.nz]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB0591
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit clear operation was missing ~

Signed-off-by: Michael McCormick <michael.mccormick@enatel.net>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index a06dff9..67bc763 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -70,7 +70,7 @@ static int pcf85063_start_clock(struct i2c_client *client, u8 ctrl1)
 	s32 ret;
 
 	/* start the clock */
-	ctrl1 &= PCF85063_REG_CTRL1_STOP;
+	ctrl1 &= ~PCF85063_REG_CTRL1_STOP;
 
 	ret = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
 	if (ret < 0) {
-- 
2.7.4
