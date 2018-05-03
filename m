Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeECJ0E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:26:04 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:47159
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeECJZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:25:59 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Tejas Patel <tejas.patel@xilinx.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH] clk: divider: Use round off divisor instead of round up
Date: Thu, 3 May 2018 02:25:35 -0700
Message-ID: <1525339535-25595-1-git-send-email-tejas.patel@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39850400004)(376002)(346002)(396003)(2980300002)(438002)(189003)(199004)(478600001)(126002)(336012)(110136005)(426003)(50466002)(106002)(48376002)(54906003)(36386004)(9786002)(486006)(2616005)(4326008)(476003)(107886003)(8746002)(81166006)(81156014)(8936002)(356003)(6666003)(50226002)(2906002)(186003)(8676002)(63266004)(44832011)(1857600001)(305945005)(47776003)(77096007)(36756003)(72206003)(5660300001)(106466001)(316002)(51416003)(26005)(7696005)(59450400001)(5890100001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1676;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT047;1:Zl+2r/aCpYDQ5U0GiWWDAQgCB7DGt6u6SUEKkTKzxXJlyn3fwgJvlx+sHy6Lky4dhZGHtxy37JA14uZFCnFhfMMLtBsR6nTuMjs+5JnSEzbb9apEt5Ovm0wQQG6L5nq/
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB1676;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;3:mNpdGlKQGTOj4zy3o169DAYboGduBeXhAMaWotz8Y+Jte0WuylJhl5IZ3uEQjZpHCGy8MfsaExNNOxC++yfZWLvC9pACzu+HLUAGao2asq+efXMkZb1UlFbrRyx6Zk4Hd4hESysCLDcq5K/gkjy86AoGktE2QIlE/32rkAyyGCUF6A699NdPGE6t6/jAIt8L+glBc1yEdgj+KUqwJTZWSzY55vEW75xYVwFj8wh0ncD642V5VM4BSLuGlCyStIxfvq/fXIotTgJlgdaI+NGxUZ05bVpt8brWndRgN0n3qAOdUu4EvHM9h2GqJuBMm6LShVXDwwW1Ut2qIRXgFfLBvlJkw5BQEW3NozsGbRKnveE=;25:4sATjfdYdoHEXvHVV68QEBpsGiTHJ0n6+DAx2R7fqJWqukETsVDNBFnYaaDWYZ3yOdbytdqEUPzIlgxd4eg8DUXGtwyHabWVnu+JsU09T85Rbo01tDOFQuSAIBqstJQC0IC6mzrXW2LWNTYcuB+6t+28F19dQORsxpnBrPmfoRH/LcI994PE/yZ/ANWgu/PVPn18jZ4UoXylLedVcEHv+XH2N63m5B29BG6Px+LlAfVwBQfnlTo3Bn6pRvPsk94gXEFBsIpyXdWOTUiS5DDuBNEhlsoT7EJZebYm49D8vSwctfcbecsPlYUWZGz/cGP6eAzi0wOG+TjBxH28v4RrvA==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1676:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;31:mjjIKtyYB7aAH4pOpDZg1Ji5Nz9xr5TTIFHItaygwqTdZdou5phLfiiMHOYEagw1PlCFpQYM2fMkFrGMJFlmbiy4tyffKoiqQMn9YsuTpUw4GRlVyfwNPYtNIsuxp9eYYXvyNBESFoz8ph06rh+yUN5T/mX9JA++gkO2YTcUm4cM9L/LTyUbPeAWxNL8R+65wTEgMRTwekLrCTzqEh2Od4zT/7bstT0rCgQ+kLrNWWk=;20:C/QePQfuYqgrPkNMgeiOFflogjPRA0ZcmqSwsnmUNcboU2p2+0K+oRFl0UuSd26WR/B+pV6R4VtvIh8bzAr6eVa1EvpQN7c3alLgS790gedPWHfJLI/4eR+XPTaHZcltM+VxISJ+JPEExw3RfsNa1urhPBxVOu7NiYAVpJ5FKKQduv1vIijq6ju/CeTEGpQWHeRkZmlsxC4V5Zk04ONIwE8orh5A0VRtsmCwGfGHJ3yYMWirMtDf1VdDOPqud0s0PM05/O3ttZyRzPfKWcEm6gh7AFoms5pBezmqQtJOPzofPmfkS3FLf8PyCWIpgcpuJ/g7e1NXpCdkeZdTXpgaKWPJjAb8gXGd5X9dsRE+n2War/Td4VF3jS++nvA4vXLgud3dwdDPH56pLg3uNTXVHy3CfYc0C7xigJkJeC2GSpT8uz7yxn2BcyTq9qMvoQS9y5L+8pV22EPlDk4+uQTwlJwSFYGj/3a8jWvpSx/kMQS7GoSyDbhr37JqQVehDaD/
X-Microsoft-Antispam-PRVS: <CY1PR02MB167608B93625174469E9C79BAE870@CY1PR02MB1676.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR02MB1676;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1676;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;4:HxPrl76vohNpbBDp6LHbmjPGxOwkfYwwbJORCINSccwBMt8PfshrmfdhbNeTv2p+xV+LvtDETUgxqDsaAUBp78yejNYwXOBNpelAYs2VZXJng0ZVpH+ZK7TzQVsyEpyifq9jdKG7Qe9FhQbeu0TYdkwTXUzf2tPyGrT0Agra0nvkSYtG5w3epr+jXo099QRqx0tDQxJE5nLturI/wh4Q0/yNR9STJG0VXe8i0/tmioCFgvSAtvYVDYh74MYzdHNKXoDKWmDWK3Xv4IvF68c1si/VLiVN5M6Ly8bCdFVasA2HrUMJ8IJ4Ye9tA/gwuMVO
X-Forefront-PRVS: 066153096A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1676;23:T7kXhH3cQkf9J/Gp5IbFAjsBeAeq1JWsrCIA5A2t2?=
 =?us-ascii?Q?ClrdPcSNb5cqHuHGUdldHmC+WCwKGjIfI10i6XUMkK3Vjp/2DOCm+C7GluNm?=
 =?us-ascii?Q?1xR+kqS60v7HO8VnNkchm6hzLGNAhWqZ+RtWMEui85DZFigd+zQEW2QMI/EO?=
 =?us-ascii?Q?e18qJlEqureN21ncThKmXGH99msBE2xiQvDQfWcGJKrzPEs8eKH2yfjIqHi5?=
 =?us-ascii?Q?3QpXg/v9AXMojVwkzvJ19HehAVSWMj/4ZURl+DUYJiMKMniV4nh+nT6JvLs6?=
 =?us-ascii?Q?Bl4mD0XGb7VGjSE8NMbR59/3vozTwJTabVVuqoySs8VXGIQ+P+ykntca9MYu?=
 =?us-ascii?Q?T4j4YKEMy9Y+GcYZcjQ+wNLGK992N3zV8AXfLxHSTIN2VpzicgFKi69b2r6K?=
 =?us-ascii?Q?3br1MH+VqgH22/ZwKop5oNy+8mLhbM3umURrmf646XOIb11JQFsiXyRCP9Mf?=
 =?us-ascii?Q?88oHCkF+NfzAFhq0lirfoYbQYCGE6RXeCdMs8jYqTIKZG+kMMrC6r4kMDvJv?=
 =?us-ascii?Q?jjeNr87wK9fwBGzS/yeywZ+985s2+u6Izd2ctybwwhaSrvNe2J/g65iNrCq1?=
 =?us-ascii?Q?uShw/jwp1BOKthPs7evfRaDBUfd1npzLjXVQSseOvUWzxg3XiQkfgVzFzVhl?=
 =?us-ascii?Q?5GhyzZRTyAIUHwimhE2OqeOT6+NS0J8Vxz6UEcHL1RpIJ2Ln02XGvME5mxNT?=
 =?us-ascii?Q?l+ukkhTzIlqJgIaSrA3riOm3NMOJzSGBSvtpzA9isGZIx5AU8pZwNkUSVopF?=
 =?us-ascii?Q?9VaCUnOgt6sBYVpwccbAd40SVUHk6KioHd0oRBuuJm6zulkaJ7lkGmsIR7i8?=
 =?us-ascii?Q?h8Q/Uggz9DofG4k3oteC1oyFip4r48Gv0C+mz2wIaZkWnt5NK6g3Vy/vY51S?=
 =?us-ascii?Q?EB7YlcbVfp/Xes+z2iPCLSxrLr6b06jjoBJ7vj7t2cCTTc+Ww6R1fFKRc+GL?=
 =?us-ascii?Q?2l7lqS3pX87fV8z+S5juVu6ID69yA4rxomkzXI40pB9HwrMtsTeGyw7/2I3x?=
 =?us-ascii?Q?Gkp0iiq/0pJpD9/d6BhmfbGGFqGhV5Ncs9HCKCJAEjsegjf9OO6F5zYkYSkE?=
 =?us-ascii?Q?wcGOYw9XDccaSxi0TASdh2K1YKMufARNZkB0OFbFgoTz/HBVGLIcPyfaXqHf?=
 =?us-ascii?Q?KWd5LXwKBOOKROMvhL8jHVVKmP2CIwMP/BTc/qqv+LazMU+BLoOm0uKUUO4b?=
 =?us-ascii?Q?qxXgH4FIHj5X00=3D?=
X-Microsoft-Antispam-Message-Info: a/ANySR7a/xi9L0EPyH/isw/ohlJ8mp2gTDzq222LC4E/2yhuDW6tnXGW8WzP+QDxqlK+OY4dcuRxjw0QvtGr/nrkmNllh3mu8mvyBxUmuIFf4eaWNIZQMVY01Vex7tTAG+IZJG+C6PBd4EfI2rmSRDmkU0moSa4huzNOY9qeP77uEkS5aqu5Gpdham4pBAC
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;6:3cWEF+ocL4E52ER23cmJZLi4Sf6UMts4q6T3LVfgSOhg61SmhYU7GHNdyzFF78ru/H1yPRRj+ZQTaXhGGU0osR7fcJeJ8p7eDONYKu0fYTO1dJROH9N9aTZMIH6aODjDFDFaNz40iRrkRUt2qOLL2XfQGAgEKO/RdHVKjzOR9YObJxv/MfeGiYo9X2WA0z0gbeWZBs8pRNJ7wDSRJ4TZ2+y74pbzHhPbmt7YllnuBtqhjTfIOL6sTZejqnhWmuBaJoORMWDRJmAGwEclGum5O53WF7nIMACTpJl/k0364X9GMub0okTCHnMyLb6jXkyZ2Q1x21glCH4flZp3sqZ29YNZ5wjKhGhPlULpMyoKZwBPgdu1IGxf1zaPldH7Adxh3PD7c5S0kY8y5sbwYyIR/GzRDQ3x/bjXneqDwY8onFfARjkoWRZvmBuU60NiKoNcsliJ/lANILvJkcTAfUd2gA==;5:C3o6xdZ0iyonL1vR0Edx2vh32gpWTrXC6MLREiE+EQYrUnzcQL9rYXt4w9qpOy37LNUMx3SmtOrVAHnyYK+02CbBKZNQcvvQnCIJYCkO3Z/tmmyee91j1Fk70yny8GVjTVB+HR6QsEF7byTnwDw4N6z4Z/2X4alx6r8GoBGN79o=;24:vzQRpvweJt4OWozNtzUt2cbmov/pKEJwKXO84+5kjF11/TRB8pbm+GtNPDCI2EPQqbifCKz3QgAhk5jVKBYPz2fby9F6e95KZfzk9TJvyF4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1676;7:xQkxILH+1Rxoe3JOmkFsWIvAEm1mayR15bvzxEgjSMZNYfeO7u4OzVityMkHgm39oc6pJA7zVDMcJhlfntfg1PsjoFHqM3+ZNKMZWs32XrL2bnEXYylhXXRdXatoYnFJQrFFRpy4/O2LezVZjoLBDrrlEQklMjj508WhtJNtlV+6ncFgRB4RS8nFcGtJ34/Fh09z5clKoTBod21Sh525fHjbL6IPXV4e3kds0w/+TpeOo5BnkyakKi+/3pWJ2b02
X-MS-Office365-Filtering-Correlation-Id: 3dd8ba1a-7fc3-450e-e014-08d5b0d7dfea
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 09:25:56.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd8ba1a-7fc3-450e-e014-08d5b0d7dfea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1676
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w439Q9Tt004110

divider_get_val() is used to find clock divisor which is
giving round up value. So even though actual divisor is closer to
round down integer value it will return round up integer value.
This can result into large variation between expected clock rate and
actual clock rate.

See for example:
Parent rate is 1400MHz and desired child rate is 693MHz.
So if we calculate simple divisor for child clock it would be
1400000000/693000000 = 2.02. But, because of roundup logic
(DIV_ROUND_UP_ULL(1400000000, 693000000)) divisor returned from
divider_get_val() will be 3.

So actual child rate would be (1400000000/3) = 466666667 instead of
693000000. Here, difference between expected child rate and actual child
rate is approx 226MHz. So there is almost 32% error between desired and
actual clock rate.

Fix this by using round off value (DIV_ROUND_CLOSEST_ULL) instead of
round up/down.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
---
 drivers/clk/clk-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b6234a5..6ae6d43 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -391,7 +391,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 {
        unsigned int div, value;

-       div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+       div = DIV_ROUND_CLOSEST_ULL((u64)parent_rate, rate);

        if (!_is_valid_div(table, div, flags))
                return -EINVAL;
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
