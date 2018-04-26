Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDZGfD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:35:03 -0400
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:10082
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751508AbeDZGe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:34:58 -0400
From: <Yasunari.Takiguchi@sony.com>
To: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tbird20d@gmail.com>, <frowand.list@gmail.com>,
        <Yasunari.Takiguchi@sony.com>, <Masayuki.Yamamoto@sony.com>,
        <Hideki.Nozawa@sony.com>, <Kota.Yonezawa@sony.com>,
        <Toshihiko.Matsumoto@sony.com>, <Satoshi.C.Watanabe@sony.com>
Subject: [PATCH 1/3] [media] cxd2880-spi: Modified how to declare structure
Date: Thu, 26 Apr 2018 15:39:17 +0900
Message-ID: <20180426063917.32068-1-Yasunari.Takiguchi@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
References: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [43.25.41.244]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.41;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(39380400002)(376002)(2980300002)(438002)(189003)(199004)(8676002)(426003)(66066001)(336012)(316002)(478600001)(50226002)(8936002)(47776003)(36756003)(246002)(126002)(6346003)(51416003)(486006)(7636002)(86152003)(26005)(76176011)(356003)(50466002)(7736002)(6666003)(48376002)(476003)(16526019)(106466001)(107886003)(2906002)(16586007)(6116002)(956004)(186003)(2876002)(72206003)(39060400002)(4326008)(1076002)(446003)(106002)(49486002)(86362001)(5660300001)(110136005)(305945005)(11346002)(3846002)(54906003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB2032;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg101.jp.sony.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:UqT3A8O/zJh6245uYClyiNSAZfH+BPjkiTvcglO5pg0Dakjlv0VgjeiRXS2dCYoFuVuvgMqmflGwkwYMnkkZatdVwdNJxfn7FTF58qYa0vSn7i2i1CnlO2CqlT42fcqv
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR1301MB2032;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2032;3:0tEtmEJ+dlVifkllZPWTLJfySy0DJhYK65cP0Yw12fTUhuUh6cD1IlvXHoWbcjnx0Xw9lFMXTqKmkpJ7PxaYZo+l1Vdi+kLtLL1Uz7nK9l+4WcoO5A9cb648/JehhBd3G4Sz1++kr/sGM+UaQkJoXgDW79nHn/rG6ghGjPzhC/9XzC7wJ7f3/5DXobw3o/uWwAJUwgrAdqEddIjF14sdPvqPb2DvF/6RpWlZoDQjdvrm8RL+38vakTpH4YfD5d8q23KCKACkBB6awoawBoP419NUyD0bulWsCQHYe3jFtSx6bX1FelertT1VGJMCvTHJu9h3ktb20DmiboJvhelOZUk3mZFYNjeI96TcRkL+WOI=;25:JKHNhJFsalX0i42EleksX3U8qoIM29I/2a2Gxt7eYArMbItURw17pIp/hbfSCodhVBs3rH2hXE6vCRfHdIPcJ6H7d0tpmhSoZPU5WsEGuGrI0kmQpk2pudsWOhyfN2DCT/DdfhDy8U6B5FCSumKCo2xR70ys4e8UDegnM6M6+2iaptzv4nUcoTwDbnQb3WxK4rjwMUGbrTvw129dee9TIlbU7WC/QpzvsZMbjX4TMnWRCYpLsy0RfmtVtzANjW9as5UnioLT2AX09sLG9rnXcj7vB2ctWjewKDmxHK7OEFZqPPpn4IX16dziB2Sj0LVliya68kfr3ijSecQu2wu+1A==
X-MS-TrafficTypeDiagnostic: MWHPR1301MB2032:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2032;31:2kWrMm0dt+1m/sqEtkVTe3aPeJfK4shlmvpKIC/MDAAnasOiDC1p/0YU9QAa3UeYWcI3n0galBT4xL13z7/COQIcf6oRIeLlb3rBi78gh0pYgns6L7BkzM8c/+Li7xXzk4tuHBu4fg4OBWEEhPCUMHsaejCyyudxMI09L2LpSGaeCiKs8a2wFCLjkTZlxrjd06mzAsJaXQw1NF19wTfVMg4MoVltsgWFUC6AV+Ae8ks=;20:vU64h18QUKv947PgHE7pDInzKmBR9IyNypnMj5VL+auSdwVwA+OWpWtmHa8HrZt8HoIVHfAHsmvkzCx+euTAgG/Jrr57dDYBQKGFLvNBkScRlECr2/egpwKqZ5F3kAobQNrIz8CmhOnEa2hmn+PcsPzczlB9JRhvTtL/gBLfEdy2ILDmtLptEtPRFkqGvYHCJwhdHu2tOscJVZV2iB4fkCFi24W3+vPT1OrwygiNWpz+Y2SvIgIx8Rx0A5DlRNs0lcnCKy/uEbrzfI/7iz8ymlPGCbhmD5Lcz1dENzBpCvMTEQLu20uEzw7Pl3duZY0BHyVtNNm6yQScGWBVyMccZWRlqWSw/4j3PlixcByI+ifmn9VjMYrxA1RgUE3n1smSRHUNylr+tc1RwSFv73fBN24r47elLE8U0RTecYql2qe6PAMkMHAZh82f1sXarB/eBtDr6Xm6cVSTzqc0fwdHpjcErlXP4ojolDL+Ior5av0JU8UdMZAFOBlVKopO3Duc
X-Microsoft-Antispam-PRVS: <MWHPR1301MB20323CE53297F1FF084F288BFD8E0@MWHPR1301MB2032.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(11241501184)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR1301MB2032;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1301MB2032;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2032;4:8Kfjsdu3S1yOHeUSE+8c6nSrE9VO+pYPMIR6pfDOtGjeR/nf9nnBqyhomBiivhEHhhoaOrYugaz5VV6T/GYiiQ8ZaA4iZZK92g3SLdb3IJEiujRXTYiIThbV9oxDLECRcMc0k3bKOzCK9WIf7Yb4P4RkA91oNJzkcIN4dXMS1kfA/gdvBpBQPFYUS5fiPbf18MhvZ78nWCKwjg1OEiki71k6CpLbD/ZsG+sXMroMa9uVUMTTzEvQXCQdDmUGvLSYiP2peTSZ4h5sqTWdvDtdet4+cUDKrb5GIeVk2H8YljyO9poh7MsXYifdWRdsfpUa
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR1301MB2032;23:dIU3GNf06F5tVK48Nm0btNDzygqu5yixboEE3yJ?=
 =?us-ascii?Q?WFfm2brk8yBUZsvW0im1maZI44pGXTsblAeIKYfFXLX5gPgZnrmXfaP+8BXn?=
 =?us-ascii?Q?Ib+igH6rVuN1EBjEBefZ3DIi/om8kWQpd0IuraMq2MmocsfDHUvCal7Qqaes?=
 =?us-ascii?Q?zrSqJ/zNhFokBpc8pW2RBwSykmG+muZX/DGJ8En4exXH8xLmIW7amgQ4RDqh?=
 =?us-ascii?Q?AYfFd+S+UXYaXNKBs7AXHMpRsGgdMKtBqBsL808A1hOM7mf3YEoSXmxlk/Lb?=
 =?us-ascii?Q?YYsovw5hDFpWPZOhAZrP14p11bRbvWKP70Id/HlchG7EXGpa0tQ1ZE2HElB1?=
 =?us-ascii?Q?ipsFJuuOoSSq6ECGggIRuViMeojimhsWLaziqwdibniVc+n7sMK9/9ULaRgO?=
 =?us-ascii?Q?YWWOQ8/w+bV82oL5nWw5CK6+Dj7g6opB6osjweOV1aSgK36joolDdrWaqda7?=
 =?us-ascii?Q?XFIKhZpokzEQR3r+ybpkuJpFnaNbsA3LeDRwv3HWBMIk8SZeGyTmANS9SSK2?=
 =?us-ascii?Q?sVXNTdZG9+mRazkI5PLFXiLvoxyQZuJSZeBe5T595gU0XJSDWA/SlDMO6KW2?=
 =?us-ascii?Q?w2KyN9ihX4pb0ubagws6lYFGEkFN35pzAQEMusb2YaYMW1pK1Nqbw+HawAcj?=
 =?us-ascii?Q?gEos1RjSPqU1PAXS7Lfvsm97u414TQO29q7DvW3DDcsCfCB2lunvSy1yZ7NN?=
 =?us-ascii?Q?bCkEgHvt4zFG5hISTwNp36dukDVx98/p1DMAKDeVWcU6a4onzWLIR/3AG2bm?=
 =?us-ascii?Q?YzyurAA7FKeJDkWzMr3xo6zLAP8VfAhkaXWSASh7ZsbIei3GCbupYS5d0SZK?=
 =?us-ascii?Q?UzLb6fsYeh8mbcZZtzI3mzaahMJPqyUAO7jVsM3x/xI3d/fqAIWG2QlOXcQ4?=
 =?us-ascii?Q?GBYa1cm7CE/dbE/p2uRT7NWwyyNyWz4TOrY9MV8soxJtUaXuEPw4QL6VrjZS?=
 =?us-ascii?Q?bBuvXKsyeMLt7HWmaSuZmo1hM0hfilW/1jDbRDFEI2swCeldIW4661Gsntt8?=
 =?us-ascii?Q?jv21y1waSzci+UW1pYiENqkfjc8ep3/SCHrDfoqEMqKcohYC+/gFAsnnLLlX?=
 =?us-ascii?Q?6hzPjUvy1H7/cLGJ6I/zMQP5rM9pR/owpe+27S0hZBLzrgPwDrxHsaUYNSVi?=
 =?us-ascii?Q?2/AbTb4tvqGcy5dGsC4G1o5nN4211vWBNeKqGC2+QR40d7Sgv5ochrXluKNW?=
 =?us-ascii?Q?mnqQyidUudZs4VQC+SnU55AOGgaonVKLZYAuYB1wBZW1dK4d64RFqPmTaptE?=
 =?us-ascii?Q?PMRzYmonvfJbJiJKe5hkinMNHTS9GuSBmaKOzgzbc?=
X-Microsoft-Antispam-Message-Info: ynSe/zkn72ZF1MkeCJsKEalSBA7vxtn5xtjNCiOgCGaz0GGp8z+UDl6JRQwponC/oYDxF1AB3xyVIxempn/NmcBCAzoH10EY8GQaPFyGvd07asHErx85aztvRI7sgxplNIuql+sr6D+VXS3LsoIXmn4AmjFBOpdd7ZR0XvCaMypfMVxBdD8/Hg9Ny4xDZdfm
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2032;6:45Bmflrqw8nuufPdxCnhl/qJo4uihrAMGyzFyB4oPOXKswrnaeysTz4tP29eplXEovODo81BQSqtDHiN1J6siUnMdqPxMJntrwiXQTkQtXP23KTpb8RwMyDjHUd/la7IBm3UNq5SPqvdkrTmwMVTUr7hXVpghrjI+CU21RqIdjRQ99Ekwjj7rPXBMLDKJ9a2l2jgRSfp+5FOqBkTnqMGgAWjimtKS12XmGMjBSnAIkC/gKr4Hg8YiLp53mmYkeLCM1FG2MItUxyrd3rcL0bw2n37/ghw9X8vxNiA7euaamRfdlmed6oSSmHUPn5XVXiz7LL2hk4RbQv/+j4yBhkQEg3oD5NAdnRkZy9yiHetyU7P30SlAzTpYvLwOOQ3XeFX0HsAH/yjgsbh0GdZiz+F6l4sCYyNRCrpF/m4NwNR98tUi9NArocSdvuYdV+zd+2PreGr7s9F9ExRQmVJVTdqEw==;5:QR5UbAmjDX1RGLcnHbROK1ot9kkoXYR7OSwf7CYf3cuRfCqhZPNw5f52cpBdYocLDUeJcR9VO2juOfgmOwQiAgj5WVgddEPPTdmvN1CaicX/K+xZwVxSQBJ8XUsxqu4jY4HXvMH/xLa8pKLzQm99K8Hc8427eOg7nZkkusGaaQo=;24:7iF0k8Mk+8iwxzv3U3djNPST4Vru4ybKslWcFkkt33hZ+i+iSQcT1tyvQFv5ZtA/8ffSZHwk5GolSDon3XzTf/1GUcpuqBQ407Ntp8xm1Ok=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2032;7:Yiqh/KAQLgRWhfZciacalen+XDFE6blCjYV6qXjWDWflfowmlBooARXRjyqb4VZsrT8mpmEdmzCEET3lxJfo2VI+NA8yoUAhohRT3QHt4i205qESQhGAW31neGAuU9SEOOZnEr/9PXljBop3I9QmfaOWXjv1p5GJezi1H6VyrAlbnJ+DYFNnek4dw+oesxKQRGR56yjmvcpBMcaYnMnYzuizq1wqsdaPOAAGr3ObT9fEl7Bdbk3ujsfvD57ZMcAK
X-MS-Office365-Filtering-Correlation-Id: 7f8b52af-11b9-4653-1b53-08d5ab3fd2b8
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 06:34:54.4988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b52af-11b9-4653-1b53-08d5ab3fd2b8
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.41];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>

This is the modification of structure declaration for spi_transfer. 

Signed-off-by: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
Signed-off-by: Masayuki Yamamoto <Masayuki.Yamamoto@sony.com>
Signed-off-by: Hideki Nozawa <Hideki.Nozawa@sony.com>
Signed-off-by: Kota Yonezawa <Kota.Yonezawa@sony.com>
Signed-off-by: Toshihiko Matsumoto <Toshihiko.Matsumoto@sony.com>
Signed-off-by: Satoshi Watanabe <Satoshi.C.Watanabe@sony.com>
---
[Change list]
   drivers/media/spi/cxd2880-spi.c
      -modified how to declare spi_transfer structure

 drivers/media/spi/cxd2880-spi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index 4df3bd312f48..754940f7e964 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -60,14 +60,13 @@ DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nr);
 static int cxd2880_write_spi(struct spi_device *spi, u8 *data, u32 size)
 {
 	struct spi_message msg;
-	struct spi_transfer tx;
+	struct spi_transfer tx = {};
 
 	if (!spi || !data) {
 		pr_err("invalid arg\n");
 		return -EINVAL;
 	}
 
-	memset(&tx, 0, sizeof(tx));
 	tx.tx_buf = data;
 	tx.len = size;
 
@@ -130,7 +129,7 @@ static int cxd2880_spi_read_ts(struct spi_device *spi,
 	int ret;
 	u8 data[3];
 	struct spi_message message;
-	struct spi_transfer transfer[2];
+	struct spi_transfer transfer[2] = {};
 
 	if (!spi || !read_data || !packet_num) {
 		pr_err("invalid arg\n");
@@ -146,7 +145,6 @@ static int cxd2880_spi_read_ts(struct spi_device *spi,
 	data[2] = packet_num;
 
 	spi_message_init(&message);
-	memset(transfer, 0, sizeof(transfer));
 
 	transfer[0].len = 3;
 	transfer[0].tx_buf = data;
@@ -383,7 +381,7 @@ static int cxd2880_start_feed(struct dvb_demux_feed *feed)
 			}
 		}
 		if (i == CXD2880_MAX_FILTER_SIZE) {
-			pr_err("PID filter is full. Assumed bug.\n");
+			pr_err("PID filter is full.\n");
 			return -EINVAL;
 		}
 		if (!dvb_spi->all_pid_feed_count)
-- 
2.15.1
