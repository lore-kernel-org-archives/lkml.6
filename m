Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDGUWT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 16:22:19 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com ([104.47.1.97]:23808
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752461AbeDGUWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 16:22:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com;
From: Jeroen Hofstee <jhofstee@victronenergy.com>
To: linux-can@vger.kernel.org
Cc: jhofstee@victronenergy.com, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] can: ti_hecc: fix close when napi poll is active
Date: Sat,  7 Apr 2018 22:21:39 +0200
Message-Id: <1523132500-26070-1-git-send-email-jhofstee@victronenergy.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:1c01:c06:100:8df5:a758:6a23:e358]
X-ClientProxiedBy: AM5PR0601CA0042.eurprd06.prod.outlook.com
 (2603:10a6:203:68::28) To HE1PR07MB1065.eurprd07.prod.outlook.com
 (2a01:111:e400:535f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f25da56-99f6-4016-9352-08d59cc53fd2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR07MB1065;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB1065;3:44qn9uuxaegJ/BP6B2+eZYiZ8KJd40GVhf/Pg08ub92mfb4rKwCdFvvN8p7lbHidB9CmqOBEswXIacEsedKYLz9RoMWnySEXgzrPisG1hb0umFi4+jIU096fQTV17EPuWuXeqgJFGmqiGx7TS0ZyzsVHjFEC96wS3u08EfwXNzMCicEnAD+yGcsHetA/rzVs9IefffLPMlX1h5z7HxT/GkQwTu/vryMWM6YfuHzeLJ0OeLVFseqg3PWy1+vm6ASQ;25:b5T31JGyJDNpFWrNN2vemA/IHjYC/ddOZ3lllq8182v1WwQySlEmJTJA1lAQvQ+RJ31gLzK/imqERaRTFU38cE2jHkW2D5rfHf3JUHe69Ckjihw618FbenLWc/VuyEmg/vaSjE4fu58Aza8KIVHDxLF0+ChNrtysImtIMi1UvFtlMF/DmGMzgTkbTKRXbqguiN8hEw8e993nGUjon1kMy4LFrOSfh37LBXT795N+6GmQsh762mOR0i3HnSmC3vNVfQPF082ootJN6I486VNIDiLK+JforZQNoLHl28C65bbACpx1erJITUa1xnJ6pYb+E46qkzDAlCjXwwNkrghJtA==;31:rr4nvgSejpwC3Yylbl40+VPSd/mN7Xokuhe0pPw/hLGwWBH5mNSYcE44sGWfkO4QFk4uN3rZ37jBZTI2lcmnHNnHCnqPYT708M0i0tidB5XJhNWoXcWwgMI7pz8lWzmGVVs49U5jAcRSctetxrXU6vFn3o1C9jsWBny+XYaLslfn0o3bo3roPZ16EA3eqsxQf66kopxb3InslHHuD5Pc4h1nzFHey+l5Dwg00k/8cmA=
X-MS-TrafficTypeDiagnostic: HE1PR07MB1065:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB1065;20:IjDmYJmyVa+hwCD1R6e7Ds+qEflNUsEn3NVx8WfHE6uD2aXqYLBKIlQoetFmtzDTlsX9ANKOHy2xZoOks1CyEkpPHRZ3V+ZDCgwwhzN7xdkr2c786Jupz1XqvfX5cbrRPNBMTPs29YAIgcWitP8dn7YmFU4Zu10g+HoM91KU3NBlKLr2gunQOgCNztlUHaZwfywDCFGockDYscob3peextlLilsCjZgzb8VEqL576Ikz0jrUAFkLgLEmOU1paA9i;4:w89Nvi7C4zXPcif5/Lx9xEGK4zm3HZuP8filP3hhsfIe+7LGuuzwdN6yS8MAxUmffx9v89VNM1TwDpo7C93cCvkK8WMVfGad/+oDdad0yJDEnv1klEgypq5Eze6XetHumDCu9ifEHFbyb3kaLnKYWfgTN5fDN/rfHo7y8KxceeUQnQE0Z+bcESP+A0CtcQINKA7wVmC8XiyJ1/nUEpO1w7aoBqDOD/B1G37OBmEO6P+ayYZxgzs2+Vk+2lP/iCJoX9znGa5QTXX107wTkrHPcw==
X-Microsoft-Antispam-PRVS: <HE1PR07MB106515CE48D6509C9D07E10CC0B90@HE1PR07MB1065.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR07MB1065;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB1065;
X-Forefront-PRVS: 0635D5275E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39840400004)(376002)(39380400002)(366004)(396003)(199004)(189003)(54906003)(4326008)(316002)(105586002)(2616005)(476003)(6496006)(2351001)(7736002)(6116002)(52116002)(305945005)(51416003)(50466002)(478600001)(16526019)(486006)(48376002)(2361001)(36756003)(8936002)(2906002)(1857600001)(186003)(386003)(81156014)(46003)(81166006)(53936002)(16586007)(6486002)(5660300001)(25786009)(8676002)(50226002)(86362001)(97736004)(68736007)(76506005)(59450400001)(52396003)(6666003)(6916009)(47776003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB1065;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR07MB1065;23:RY8rLtTKyUWEOHuwMoVnL7VGBWACU0J2gfIVEX2wX?=
 =?us-ascii?Q?I34aMiQLL0/W8d35z6lyUHXgPrObtzkR8CNgu/6NeswfEs+JNJbUNJPXkNYh?=
 =?us-ascii?Q?Awp/JED1ZVSI/a9f7yM9CaxVaF0zWjPCITxSfHk86R8JM8um8EQkPVx7ffhW?=
 =?us-ascii?Q?bNWJGHtU2jms6T+gtTRZ9RcdBiobjS2l5K41NAGecq/kHYm0MaiiK6gDpKpD?=
 =?us-ascii?Q?vVox0hkqCY0XTwRuF6XxE3G3lk7U1gjDenKu+MAcks2AgkampMaYJ6NhqnQQ?=
 =?us-ascii?Q?LjVDgC/YCtr57R+wdEdJeWJfw8bShnk+yz2PMczdoXT12bYv5oM84IZbadZ3?=
 =?us-ascii?Q?7Q0jNMKKndYU3bYR5k+MoNqR/ncaeM5+v58j00buiRTFT4t5weofOpsvh5BR?=
 =?us-ascii?Q?ttkNC08MMHEKw/5cnF7YMK9GxSWDDpZhfks29SwFU+wIfdPjA1G4oj8Vq1XD?=
 =?us-ascii?Q?bgM1uUEzqSE2L0GgfqBbag65MMnH2DJefW8lYq396BcLV3j0A+Uy9xoeNsoG?=
 =?us-ascii?Q?PaKtwUib5f+XVi3o2Wuw8RhsnKt4ZGKrZwjSL1ag6LhiGLxv4n+yX93bNAD2?=
 =?us-ascii?Q?gKMhbfoy3IJh2Yx7p/OPrkDl9pPbLv5ZJjYT7U9oPqLUL72vN9j4wJA7QQk6?=
 =?us-ascii?Q?sdLbhYKN3XmJ3D0XNR+rVsZm529Ttz0MfuSMaPDjpL9g0MXWxB6jPDLheiiC?=
 =?us-ascii?Q?KvzRqi4V5BwDYRwAR/HSKZOVkLNsLQmXvAX6wxpPIx23/Kw/ZtUk0EsNo5g/?=
 =?us-ascii?Q?08TxGoh2el7e/tqY/rco7gcaWLztqMc09Mck2fi0hcJf3fRJ/ZrQFUlAO18I?=
 =?us-ascii?Q?kCLD4pRAIxsrAAqe8apL26uhiYqtlFVpLLYsJGQEByI1D+NEQhArGGTo+Z8x?=
 =?us-ascii?Q?b0hq0buKZnztf8pU50gmxdBFq1CBxMVW4ZsDSPj6cNLDqw3586iJBuhlwGxP?=
 =?us-ascii?Q?78s1TPAWL0Qg1TEPAQIF7XlMhZ0ODE5g0neDWabhPvRHJLqqmHoERo2T80AL?=
 =?us-ascii?Q?4pEfRAYVvM4flpfRWsILJmAg4f+pECDg0EDe/9r+c+YhCAcF/yYCKk+ZHeRi?=
 =?us-ascii?Q?cTLaretQUjF/9ESCxVd2BVGmgbnRtp696w8xfq3RvLa6fytAsUUDxKB3qooo?=
 =?us-ascii?Q?LJPpaNXl7xkOOMryj7kXHMzBSZnU/RKAjJoPHqwqFD50NECFqznXdB6zCQbz?=
 =?us-ascii?Q?kNsGlDXzhKmv4ufKJJtLqqF7Mkvg+lj1VBPlQjgrKJGzh5CgZyDP7k3mA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +dnnM6broIYKDAAjEiS9Y2bLAcs+RIijQlMgTt0+cnPvg6F8nYW+rxu7h4O5zS7Q4PYqiK3mBHa1t56Sp6y39PVKeyxkKN4I6gF8iBn8K4oaEebTfGN6vw+LSfPcTfmzViiUc9FgIJMdFdGdC7eVw/PQkvO0+JWmYk5w97PflvgTE6NHMVdlOx6unnvdA1yg
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB1065;6:vdHQR42sdFvl/dXnZjZJcIu2HGED1FjSFZeKCRLm3pJvT0fVHLKZyYldXSU2WEvTOnD6Tvh/Nqd+0lXIT0O9Mh0w7jghWpTT4QksHnO4GwVaThf9Bgc3njdJbv7T0oqGlcmvsUsV7Pl6waePgPjZ0rShi3l1DbaQr2BF12aTrl/+NHYYY+Ss6e4oHdkkAcnCMdfDj8uDSHMxk92yW/I+ysM9LjaqOSKeLEKM0zaWOnBdOmgpkZRFOkKgeVNlUYTccel0jjjfZN4kVstRcM+NFd87Z5y+tABK19dK0NaucvWMeQ0asz3Llw6zltidFrh2qNaEufw2919UtefUVqpIgIb9Jck44MGraDBnmJAJPdyeh7K4TvqjrK/L+qmMb+3Lr5IA1cITDsBiXgcixC2R8IjoXhhcoI+dspUkedvYIjmWFQPBXP+xpAJPVmca0QPSVDXqyQkzq9vVn0PP9fTNOQ==;5:EdfuYH4J+S1xtDyNMu373UdT5mJnmIXky1FtHMTozD97Ha+kZ+CPqB+YFi2SnYqlljxmCVc7EdVE4Lmfe9/ey7KDpz0z78JRzw4+O3MCtFhTMkVzqf5+/xvJfcXrb/rDH6wtPqVMIL0nOToqzua0C1UUEbOFN2Nlt5g+WC7lbBA=;24:/3NU1TBuwjZ5YsX5T96G2+7dQHFs3H8u3V7jpMv99Kd5SNFKG2QAViILD79SKorMEZdl5YzUxYJ8i81ej45C98xG9sfUJERohQzuzW3Aw6I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB1065;7:6Cago4m750O9KjkQy1CqJsLLozDArNl8u0Icx9/H0AC8iMhIfDB9ZTVx/WsLiEbRaOveRog22azQXqC5stpp597nQUxgdpZCiEBc2sJ6+DH1p5N9dO8kUrXq0rrWtSWTJ2rqTCHZg+9bMaJL74k/qmRVc6an4BfpPT+TtsEvY7hGkM7UWciRyOb6TLrR1rNpC44scx4fukwOBoLmjJ7yeXFwRg5rVkpdtf4kxGoBrKS4wYHUz0GgUenjZ2XkoA9y
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2018 20:22:13.4957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f25da56-99f6-4016-9352-08d59cc53fd2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB1065
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When closing this CAN interface while napi poll is active, for example with:
`ip link set can0 down` several interfaces freeze. This seemed to be caused
by napi_disable called from ti_hecc_close expecting the scheduled probe to
either return quota or call napi_complete. Since the poll functions has a
check for netif_running it returns 0 and doesn't call napi_complete and hence
violates the napi its expectation.

So remove this check, so either napi_complete is called or quota is returned.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index db6ea93..42813d3 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -603,9 +603,6 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 	u32 mbx_mask;
 	unsigned long pending_pkts, flags;
 
-	if (!netif_running(ndev))
-		return 0;
-
 	while ((pending_pkts = hecc_read(priv, HECC_CANRMP)) &&
 		num_pkts < quota) {
 		mbx_mask = BIT(priv->rx_next); /* next rx mailbox to process */
-- 
2.7.4
