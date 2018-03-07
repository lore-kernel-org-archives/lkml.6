Return-Path: <roy.pledge@nxp.com>
X-Google-Smtp-Source: AG47ELuLnnQdQIqWR297GXAzSn12n2JYdWuMgBuhPb7xhjZd73K8yU8ss2QkyjWjbNmq9/vMfXam
ARC-Seal: i=1; a=rsa-sha256; t=1520459450; cv=none;
        d=google.com; s=arc-20160816;
        b=HpXEFtuW3yutnUV+oywgSG19m7dw+Ab4tsQAwxW9xC4mblc7T+hVF8RV+/xq/QoY4q
         J6V6aFchTCL8+Qcba4JT23Tch8fw9oHnmkLmH4vWd0Ouwjf/aldTkV61/dGJyc0e00ZD
         gO2SBz93dKg7Favphg5lPnYw0Nm/DqkyiO8uV3Z79udfKOv9DVYWoxICNHeqCfh41Oky
         N/IKQSzokexES6A+GHXccz2B5clsXPqX2/78dTZ0NDQeklTRepOmN6HtBGQtzgOoQuxg
         bfhZ7cXaSVTyXePs1t02i7pmWu3Ppd+a1jYgsxygLd6ZO9FSqC25mMFLrcz7enz+NAXP
         NtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=F0tSE5oSRM08vaR2LqqZ6ctnens1TubjvXNa7y/Wqpg=;
        b=SIwfPdjneteeSGBC/aKVVdnNkfxGUbiwKz99Zu4PomTCSAvu0lJgGh9+UFO8nPcSUN
         NeosnTY7yx5jt1W+/Vm8orfSsjtYpMvgFPY6hMwL8aKGoAAjlGaVCSPKnY2gmHWEuQmR
         dCEfj7Jav6iz7mLvXEjFnzFyF9CsHaQxipoGiDr3gP9pnXBqA/36BH9BDonZEiM18zg+
         F6v0Mu3Vsbm6imHRtBUqFMwSaat3K+nH4Ck5xSNONHiSC94chBaV+KIXq+aUyItOG57D
         J0meRdg+Lzm6hGQI+z22fZ6LdxI1p7HVFGdsmJBc8v3lMs/GYGwi8NyOkAH7KyEq5m7y
         wdzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=X2Owk0zt;
       spf=pass (google.com: domain of roy.pledge@nxp.com designates 40.107.0.43 as permitted sender) smtp.mailfrom=roy.pledge@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=X2Owk0zt;
       spf=pass (google.com: domain of roy.pledge@nxp.com designates 40.107.0.43 as permitted sender) smtp.mailfrom=roy.pledge@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	laurentiu.tudor@nxp.com,
	ruxandra.radulescu@nxp.com,
	Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH] staging: fsl-mc/dpio: Add missing argument identifier
Date: Wed,  7 Mar 2018 16:50:27 -0500
Message-Id: <1520459427-7002-1-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: SN2PR01CA0058.prod.exchangelabs.com (2603:10b6:800::26) To
 DB6PR04MB2999.eurprd04.prod.outlook.com (2603:10a6:6:a::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9fc9cfa-7f48-4d26-f014-08d584757c7e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2999;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB2999;3:QrBglJ63s2DjJQtG3+hgvrNY23iHdxmKMjwyUelDW2iBVD8KGvw1vnvcfjFkx4+UfzLzn932P7SJfcJdU4yLp+cBNsJm0ByeWLxYfz3UBzUoln/jv2Rei4K4N2NTsRuBgT5XtFpxcWnF6BXTqCYLtodaKmz2mJJZ5wmI1+PLO49igUPQ3d9NEXNCWezhy2itx/0hC1xTKIclstxRixtwtFLSIupJhxLdwlXtM7s1leCMemutn4DoDa+BdrDv1tBk;25:Yyql/PAI1xZrBslKL4peujbOB9tL3Varig+WUWYm7iJacGkJ7+ZnAI+ZdI0tq/32+3R1BsDXd6DPxfvDzHlnJXBPwKXfD9XckOMg3tddEp89Dg+gTEjI7K5rsDMwFvlqjKQRcpowTzwlhpjCmfz3bzHvfMjvOj4aoOEgxa7s7rOXTKcSTJvS5yYdt3mvsU7SbBYylSTgp6XVafCgeiZCRoMdHgHXYS7Rhgq8ny4pnEqoV9dfdVl6W/I5f0Fw5DXzkxTuXEOfkJCSdp61mZeNyObe94WsakoGa/P0C8/Krzc4vECgsTJMdGwj7+e5JcapXWn6PjSfCmPUlx+wPNJBNQ==;31:RpRkDWwF29s3PZrGZLU/bTxXOPLNn/b97gvm6S/mKLiNgiC185T2chyE8AeF1YKpeqbvNDohDOGko1LAfqI9dGe/KYHWhBXMYri8x0pQYVaUcjxFBoYgySZ7gFLErzyVxBrrLT+R44ntLV3Jf0pQKIBFl7WW+QDHomh1+YZ6wJVf/X6T1LmCdqvpklxTy2y7Mrd+QvnAntuN6iIMUjsaMR1HynNstt19fbstcgBwzYM=
X-MS-TrafficTypeDiagnostic: DB6PR04MB2999:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB2999;20:Pyu9nsIpfVlFxa57Ei7ZLjKuTgS0y8zz/AeJTP3B3yQTyWo1cGjYkqQrn+taVer4E7a1N9kxNDKUu+G5riTfc21tVPc95Cu/8jTSDZsRLTNWCSDdLJn9w66DHvGFqEBRTqIGUfXhDFiKGeTi4TM5fvJY93KbhkncS0qPad8G3c1CmX6yP4Vk7qCGwdhu/rMH+3Yvq8MgHoDsJp451SNGIM4dzGunWs37FAPsW+PK1j6TmMeJwI8Elkczs+igjL0ROZ7wxLBfQ/+5ghdNKEeJgOkEsa6wM4YugKZv2p0yhvJFWWeF4G/TW4fQDcl3fSHzNZxkQ1hIVU1h9trlNRc7paIC5g6Bnydp6UkiL2p2Vyqsabjst4fcZKy1eKDUVMPxX5ELwE2wFVsJfgljxFV6wRIkopW5qI+DJZp3xxFwJZfGN42dLr2UF8WoezWX6IcdQ7EKO9E+5E3nF4I2AGiksGvInM2UkmqLeQS5jjY0JEATuvZ2x5Jbu4zbJT1EBdw3;4:nth+68wNGxDZXx1+61swa5fztF/u4s9Q2IpCqhbAl4TL3btpgcvAZvbdLjelA1wRdVFN5LjZAaSCVR81qP4AS4TCaPXs6cK243KDjJATXeBroVOj7jekBHWShnmRoPe4kGK91VuqtDRB4tY57YuTUD5K9FqXvFmQW3PvwKt6nCKWq4MiYSIprpIkJ/vdfbC4P5ZsFxKKvVCvE3HCdu0EHdevNEBw3h67oGkQAZNH0rRlMdAH2xEI+wgpV9CWGXuZ5TCvuGnSk5nYhynDSv5aCyzqa+l2mKrlDMEwS6Nugp/O0VgiNCyoVefSMZ/Se3mK
X-Microsoft-Antispam-PRVS: <DB6PR04MB2999C7D393D34F0B74D1DB3286D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR04MB2999;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2999;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(366004)(189003)(199004)(2361001)(186003)(1857600001)(6506007)(386003)(59450400001)(16526019)(26005)(36756003)(105586002)(305945005)(47776003)(7736002)(106356001)(66066001)(2351001)(478600001)(5660300001)(52116002)(6486002)(16586007)(316002)(97736004)(2906002)(51416003)(3450700001)(43066004)(53936002)(86362001)(48376002)(4326008)(6512007)(50466002)(25786009)(6116002)(6666003)(6916009)(68736007)(8676002)(50226002)(81166006)(3846002)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2999;H:otc-sw1.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB2999;23:rl0pwjm4YHnK0pUauu3e+GKbTb7fHLAGLV/3KKfZC?=
 =?us-ascii?Q?bwDkDmcbV4sj0rrQsZA0OMYO7IRtJTxNyoTBtaI1tE+Wt1USpV0Lqa0QpQ6B?=
 =?us-ascii?Q?9JLZsMQseb/3Y1CW0yPxiGy4iZGSJp+EEvHsqtlge03aIDvZ76qkucGC1YC4?=
 =?us-ascii?Q?gWJ7RyZ3k2cua5Yve5XkkBM9Vxo/Gdh0xsDjMkJbV4CGxlgOhhj7nf2IsScU?=
 =?us-ascii?Q?Aw33LeFTDtjQskS9yRTBT/jfSeHg2bYu5GQNV+PrBS8ij5arjAM8gxRSlenk?=
 =?us-ascii?Q?VmjJZO07PmRN0/HwDSKXLGrPB070qLCbam/Ofn0Xqj80Q61e8B1fy85mvXAK?=
 =?us-ascii?Q?ddjy+tT8smQKuRmHYK20NGC9P4r9D7Thns+dy76N83dnCPwx4GQYlrUYhkHB?=
 =?us-ascii?Q?FG70EwU7jgj8mBwkN37JsoYtE1IqEZkoKbi3cjWwtK5eY8kLWOiFf4U1SlJq?=
 =?us-ascii?Q?BYLzLb7ewC2W7EdL8DxTCQvsg1IGonrBfy5CRiW1PX2hhIQ7SCkF78f8KHuk?=
 =?us-ascii?Q?HlVOSNEGx+wNyKhLqomw52uBKNS3YcU+ldmHW9SLGDpec1UUQUSg+c4rAjS1?=
 =?us-ascii?Q?o7w5dLhg8Ue/hzF1dDihds3yP3+jzsbdKAtp+kEBZKeSnxu5dNhGJ6NKVSet?=
 =?us-ascii?Q?wZwWOFEoXLFVmSGySA8NS3YeOjQOX6bi4pFyLygooKE9VAgJvIxN04yhM+fa?=
 =?us-ascii?Q?ZBzzAvXucz9IFT9XSnxOPvVw0XiUoswOPim54LGnBW+GsjBldb56KBlceIBq?=
 =?us-ascii?Q?RURaAT/lOoUwsTLEzvbgCYekdhzOupZS4gMTlcrGrU3LH3Q/jS7XnpnEt5Vi?=
 =?us-ascii?Q?bR0OhlwcIA9ZVftMiUehcGO+PwIW3Ext05Y44WrETlb6TEeYp7mFBlU0qYo0?=
 =?us-ascii?Q?Uec5G6c5FV+g/IavW4KvkBfsnDwegr0P1650C7mPwhUrqiti84A70uWK51qQ?=
 =?us-ascii?Q?Yag7OXRo+SZi57B+ssQUgpZ5GX70SkiKGG1uYOmwPoLE4ihUmoil+GJusKHG?=
 =?us-ascii?Q?xaB1d3n7E2q780penoIpZAe4838Hg1nrKaU+Uq/He9LjtP5D9l2rfPI22fba?=
 =?us-ascii?Q?KNQYEOqVu3AK4DtO3yAjgwmL6FOGR/kTLgeLwMDWJONSV6PaErxinjR/Va3N?=
 =?us-ascii?Q?ODJHqaw1MjZ3HuP6DVr8jK6E10pJFZaA8nuIDcLczyVg2apHtkBXRh2uVvhu?=
 =?us-ascii?Q?6k3CF4sT3JWFdg=3D?=
X-Microsoft-Antispam-Message-Info: iux7okZIzz+YfUAW7FT4eoQj+eapAKXykTRjZRJqPiSNv82Je+oJdhJS29kdIk1pyO1kVCJvg5cf8f79raKoptMPg+kN+17IUmTdDIA81FSeGjM2qS7DTGMz1vwP3f3cZNdi0KybyAnFvI+ljxpyc+eiJxFMaPL4CXKDzeQ5MM1Kw6JoQla0Frgl7u/ASVzV
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB2999;6:dvvXFTyTudPrjBkMj0CIQN3Nmef82nxdxqMpJTh1o34aNgOVdT8rth01rwBOOuZemtn5e5rlgWfIYRV774XIm2NbGrsYt0dRf5EOu8ESPpaCCZWxd3IRTvQR52xUJe8rXwkap/5XlVnbu832NJG7KF1hPTxBb/q/600WdiU6MldvelcqoVTHbIAt+fDM23gJ6q8FRVD6t+MgYtuqMheEsvNT40i7wSLzF2aSVPQePfH6zk2QFknS5WaKNkJ1a5eHSn4590ntKGSiBXcXlY+2MvBUqSzCQL0EF0br8Ko9lehX8m/UUdGnOXKH6L8PfFdkH9+TbWq7+pmCRukWPPd7Y9F5vIS3SUjhKF3+foQXoQo=;5:uQOBoapk/5Rbd7ncpoAs/e13FUNXpPpcJPzKkc4/LeHfFLSN8Sf1ALpiuTmCkys8c+f9aIS5kLbIpBGiVd2QGqx2N1zcX3Wa9m5abbxs2BZTjaRr3OkllMXl20bOI/dR6+PyJpedwfVd5s0wZb+4NuU+L8xufERaoLBd8S+lxkw=;24:yGSbdFV20wnJtBsaZTTyAfozpewmz/ZBidwZidtU7wziCAn2KCWxNpiM+WXOiCWluqXvktyfhbcTAd8HGZa4mmlDQecEeXi3ok7jt3v0Rgs=;7:huS0pXsJjNuF5y+jsosg9Zszbq+5TrKk9kk4oa6Llo/IM+8UbDyhGNMfizJ+9OQIpn3MqhIZda5Rbti6NMbq7VXY3V75/k6Xrzw00vMfcX/uTBTyvxPhg83LwAMS3fWCLBjyA0rr8mEgcP9AEwT6SLp1h+k/lAgltFmdD34QPdYUGrQf6G+4fIe7tbihUhBquC7VJFe1ssU8TZFqDM0f6UVKCjlFCnmGlQ+q9oyhPJYvwv8lyJYvXArQIP3D3NWp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 21:50:46.2995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fc9cfa-7f48-4d26-f014-08d584757c7e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2999
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317288581993145?=
X-GMAIL-MSGID: =?utf-8?q?1594317288581993145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When running checkpatch over the DPIO code the following warning
is reported:

WARNING: function definition argument 'struct dpaa2_io_notification_ctx *' should also have an identifier name

Add the missing identifier.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/include/dpaa2-io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
index 9cb1eec..f71227d 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-io.h
@@ -80,7 +80,7 @@ struct dpaa2_io *dpaa2_io_service_select(int cpu);
  * Used when a FQDAN/CDAN registration is made by drivers.
  */
 struct dpaa2_io_notification_ctx {
-	void (*cb)(struct dpaa2_io_notification_ctx *);
+	void (*cb)(struct dpaa2_io_notification_ctx *ctx);
 	int is_cdan;
 	u32 id;
 	int desired_cpu;
-- 
2.7.4
