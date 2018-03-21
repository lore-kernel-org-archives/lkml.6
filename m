Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeCUDUd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:20:33 -0400
Received: from mail-he1eur01on0053.outbound.protection.outlook.com ([104.47.0.53]:4141
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751456AbeCUDUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:20:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 0/4] clk: new APIs to handle all available clocks
Date: Wed, 21 Mar 2018 11:19:47 +0800
Message-Id: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KL1PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:802::12) To DBXPR04MB320.eurprd04.prod.outlook.com
 (2a01:111:e400:9425::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34caa3f0-d595-4b4b-d765-08d58edab17d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB320;
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;3:EaDtjKJon5p8g6HzSEL3ZvG1i41+xPqpYBHnnteYZPbTr7bJVR1rvYn7wDgySTdzycahY243ssbraXBFmmkl5glTecJzZPbCOKsX7luqj4rFGCApleM4r9zTZqntV4kfAdzZhGYmNf6wU+ZtnTHbXNcFlTPd/VEYGtQZ2vd/56CVmwbS+RAnl1dt1X7T1ExLY1ij4Wv53kR61PZpZlvVKmyh2tiOpNfaCUiCo5s+ERz38rYJisbyL0e8FlxVNwEK;25:vDqmo/AdFF/I/80PuzYtL4qdwcaNVfcevCc7riM0I4g1btNa69oIwtyvaFi5B1pgJn3Rj/bGdxedSNFAEDlxcbzSMagD5wiFKj22Cglo0YdCddaCAPnI0BNhl0OR1As/lSAhRSFxjmf8lSsg/S9CRoqAmSlAPKIJlFIcFeC6gm8j9Xogb9AvNfJ04tYjWWlFFUhrUEvg0w3tkB4ACh9wN4Rdtyu2ijCxpNMpMnuMc1odabSrmvAu7zPfF8bA93LntWWLa6fVdiX9WpW9XGN1C7/iBUC6GFa/e0s6g3WAxB/OTtvHYF8YPq5MfQeNOeJRMq0/twwZsqNPnlFo8Puv/A==;31:Evl8U4Bo8Ag5zMMcD3wxHsl4jtbc99sXXhMwENK6jKy+/V48sTcWV32s0ruPhQUrGEheN4bEnWX17nFIcadaoPf4o0TdPRADc0gF1bBDLd6ysgZvEFO49XacJJkYnbGuxSZHlvd0z6dhe89nEQ1TfW342NM/kkzr/r31McoqUUFg+nNyYZu9+aXa7y7zBj4jZLZQqCO0eRSxNs91xfkzm5t0jvez4sL0z+HlDaVUQzc=
X-MS-TrafficTypeDiagnostic: DBXPR04MB320:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;20:Dtr5TonDD/m5EvKVOyek7Tb7z0qmmnYPpxeoOfYlQbQCm89u4oxGV5fQvN+hf07eMiAGUt3RoE+g3uS6nFGdwEinhxriDpl+JWREQhM2Kuqbcj6pUuImrhwCfo52UjkYpgEWROjsWWGngjuQRG1z/JJ5/MrgTdRF6rT90btoqgi0C/m1y3BfUA3jL6fAd8AJA47IJVZ02kvO4QH989RHjuxov+F94UCY9hQgfZAiMMvLDepew3y25FJ3xJ/OrhwZEEqnv3nJFhwqD8SQdDhMyhR9tL2EmnAfTh6biMStuWYkVHWdKhaYOoOvuWHrsOKDp0prsmdghcQSd0O100jhTYQAskB++Nn0cag0M80+k5/tEuuHVjpKLsA+/JZ8tXQA078s4f45BWDP7E96PzphV0x774z1F8jmunCro7b6CiHniHQ/bHy5GsRg5S906cReBe17q8whLXjPhKf3NgNWZviMp8IJznqUt72rsWIosyTdi+l5Y6Pi+DGTOKJP9tIG;4:XY+xyTTk8NT5ucHcnNKD33f8659nZwBhit1wxTccl4rtOnoSaUfAHIBgQFmAOSBs2zo6cCyyq3cqezSa7MudV1xqx4LK822PIQxDDjzWBaMrr8AFeoFaW7Iq3kzSCqgJWQDEt7jdGdl1OQFQuMYExuYDfKZvvMiSSEyCj9loB93pchMq2l+qX8AVfy21libTSk5+kne6lHpvhAmJSl+ad6O2kC3tXYZ8CksQZ9MIxXAGDP6ZmUkRQ1HXb2fwQu61E6gUaQ4gYGzfyAyIxUjTZQ==
X-Microsoft-Antispam-PRVS: <DBXPR04MB320311A2FCD0EA906C2A3AD80AA0@DBXPR04MB320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501318)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DBXPR04MB320;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB320;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(199004)(189003)(6306002)(6512007)(47776003)(53936002)(186003)(66066001)(50226002)(105586002)(16526019)(478600001)(68736007)(25786009)(966005)(106356001)(4326008)(6666003)(2361001)(6916009)(16586007)(2906002)(97736004)(2351001)(316002)(6486002)(36756003)(8676002)(305945005)(386003)(6506007)(3846002)(7736002)(6116002)(5660300001)(81156014)(50466002)(48376002)(81166006)(26005)(8936002)(51416003)(52116002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB320;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR04MB320;23:NJs4swTTUkFmQQA4A5FZ+qS7s5wzMmzmNLbn2xbkRA?=
 =?us-ascii?Q?vW+vzDVo3gcHvzbWWmq9Dbxqfi7zVuL2XOYgOQHduu4+lRFMdXk8rAo83mnh?=
 =?us-ascii?Q?sl9AihNCF9hfw48A7jdmh05eoxCWBfTcmyfsdFGi5y29zHASEjoMdMG6cAQg?=
 =?us-ascii?Q?UFMlf+xqqlTDCrBR+t+1awgfH3HP9zqT+ySzesaFTdPWV3VhGUicNcP4Zsac?=
 =?us-ascii?Q?oYJhMeulQZ8iWLd9nGVVvT1KM/VH0zaaTqHHnKNoH6PWUidz+dF/rnePA/vt?=
 =?us-ascii?Q?MhbW1iVvIM2BIqnZW0RTMjYXhEkzf5gDcAU2Wzb+NTcl+JrFZY3cUo3SI9u4?=
 =?us-ascii?Q?jY1RpX5aILdNDGB4Q9UnEP7W4e9NJ5x0Sl97bIwTktbOyyxsdmCWL46wiHj/?=
 =?us-ascii?Q?SXwUud2cHqqZCda4DXG9GJ0XbIRh0U2WgXPJl5lGWXcezfbaV4292UjiRXrT?=
 =?us-ascii?Q?nvnMjw8szR19/FJD9H9F+6kTIXdu6gQlheDJFC1MIwbVBGT8ixaTzadB10AV?=
 =?us-ascii?Q?bHF3Oovsa/3mrIMw/1BqjDT8oQoa/xiVbtUroqaizwMsw870/A035WbP0OyW?=
 =?us-ascii?Q?6OxlrjwR4oW3cuJGRWkeEyywtqEIASpg/DFg2uDl3dF9VkvOJ19Sc2fgUQUQ?=
 =?us-ascii?Q?42526IJ2UBdwV2X35ggVN7SVoJvAG1DcRGCpus3ajhk45BUX01t05gSAPSGr?=
 =?us-ascii?Q?3juLzNC4e8lLESrBaaFiurvaQ5k8a6QNB4pIihyMZ54WJWzFkkq91GMacIGs?=
 =?us-ascii?Q?+eCSw/upE4+Y6/37o7N4kcQcM58Gm2j4uqFZxENXLlO81p1an8HwNnJpiKml?=
 =?us-ascii?Q?H2XTZ+zWvxaOH5YJbqnA/i5j+WrM6jwAyNhQxqoofwiIYk2vUftiGIemqTam?=
 =?us-ascii?Q?PWlNbXw4jItvorwZC+Fsy+Sia0MuiWRemRc25dpW680RFbz/dNn1TBPWX2Ry?=
 =?us-ascii?Q?TWdZZARBxT4tG+L4exspHmfrzDKA9+Hp0uFY0EE79FwDqRodQH5mwQCqpnQM?=
 =?us-ascii?Q?5aT1Ch3RCBG4zSnkG157rEx0CBn5aPsUfWAN7JsNinFoBIkTxHxRA2g9B7PW?=
 =?us-ascii?Q?389clDQuF5YAg8YLd5HIrfB91xP8TxBcMBM0rKvKfCSwEcXzwC09SHwKdfxG?=
 =?us-ascii?Q?7ymqX4ZFU=3D?=
X-Microsoft-Antispam-Message-Info: MTj1eW/IiQUGcNtAuWUb2vuOFUQvzAwOI2wyyDpfV1teXIXwrPLShoE+Faz/DU2zsZO9zDIUUkqlBSLx9tMbbSttf+aIQ7l67kZbQm+DXB/tknEyXqQy9A0SZbVHb/En7+fo6RWqGBsTnl1NbAiRaWNP2tTmtaBb0iirrnLdqaV5FAT7Wn+uqUlDB+eSYUgN
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;6:2WA597B87NJeR7uyqc6B1yK7tOA8Y9cxZtBl/N2bKWZ27JSFI1EZzMw1DJS4pJd996Dor/f7SuMrt0qcchuMNXvu8gbFHN1safteaK8VfojvH7DfSGFVvITVpGNBOZWL0+fvxkDyY5apQlFbxtn17DDcJfmOoFLSjXZ4lOfeF6e97sRFK1/9qsui0oGZ0F6Uzfx1aZmpWEeAPGc8ch76pfj89jUEBLWBQZoyDvP1DvACKJmIo+V24L4ljtW3wm5XcQYd1AUL3hPtzsOh2dd1K7/MMtjm76xowGhwfSaVJbLv4tFWOhAS+xMdlsZjpWFGX2grifrcVxpffOZIrDvSMCEqgfiliRlSVbEYc8MJAwI=;5:pVAnoGZScriQtry/Het/c3pURlMC43iReZsLx1Ik13hUaMQpJtYtNHePVEZqmqiLplOL1jZjo6lzH+3T+EC+ixUqDd3mWzNW/DImu4itg2D8xL9QH8VOqUk1CfXPQD7rN5jHiHsoWForokGEMcIfkuM3zJIFH8nBnRA5W666ULE=;24:FSa6roqz1zOPBnzn1CgRtQPYq3U8XP9iSbx4I1uQpZAeSg9UFxBP6eQhZX9KmT1An80DDhNo/Fv2zNBPPS1C2HC3qyQih3AywmbTA1F5+r4=;7:0zC3EJjjESsd1IKa8t1K7xPcvfOLAyJPOEqmAD+HeaqIuERSNa1ZqoiHLJ7vVuAGP/5NCKK6oMKnrhnhocKPxnfGZuZ4rzsczLP8Mj6mkSdcr3XUQqrqXjoUfNAKA9FTU/yP1q52xBmPu6nLnDqGiPyIBrReGbUcq1U7itBEsViKldHe1W9wvv1GwgSOHtrcd85dnuaGYEc1SkRDPMfmV8YGpnf0iEVy6+VRJ4w7s6weQuzJlhkRC2GyK+CTzDxt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 03:20:24.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34caa3f0-d595-4b4b-d765-08d58edab17d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Note:
This patch series is tested on MX6Q SDB cpufreq driver with a minor change
to switch to use clk_bulk_get_all.
But patch 4 only test compiling. Hopefully someone could help test
the function.

v1->v2:
 * add clk_bulk_{get|put}_all() which only supports DT platform currently
 * remove _all variants and the wrapper struct clk_bulk
 * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
   proves they need it because they don't have a struct device pointer.

Dong Aisheng (4):
  clk: bulk: add of_clk_bulk_get()
  clk: add new APIs to operate on all available clocks
  clk: add managed version of clk_bulk_get_all
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 89 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-devres.c       | 24 ++++++++++++
 drivers/video/fbdev/simplefb.c | 69 ++++++--------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++-
 4 files changed, 190 insertions(+), 57 deletions(-)

-- 
2.7.4
