Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812695-2-7938075998021487387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812694; b=q3yK28WSh5Xeo+ms3mLglX7P3kUDV+Dv8r8k8cKSfX/Ezky
    oezae5q/8wCGdROqQEkfdii5Lp/D/Skbym8VNZSkqLt3onzZ94T4tDe+IrXXE5Nd
    JVcy5nsrjGXCaQF+m+gQV7JYNwOzkUPtfnf3lAjWwg+9MLwM4Ti/k9TGLn1cP1DY
    tcpS7fbWkMpLyJqjMbCmZIXCSNMBCtUPN0BA/IGFzEn10Bsi0mgtMdZxEPvtbXPG
    KT6HHC/VmyYmCBN32iJI/RptEP9fPrqX+TfUg/CkQj77tteVv4hNNT/agidg5pw4
    qmNbHR7HlC5m2mAVB1m+C9gxAtx5x7GK8FjLFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812694; bh=I
    OXDW5qB88pMCiwkP7vFyk/1SIoUhLnC2PtM7Kph6x0=; b=uVDyGk17wE6TlmXMS
    1hKIgE9qFtw9fgcUmw72XI/KulA6fYLecB183eAD3tLCT2U8nVbwKnwrjUBcsAl+
    D/LTx4Bf6xnQ1eQpyWozEeefpbZHUJeL2g1Ri8Amu28wYLdkPevp8pWppYDYOwj3
    s3npdbtys1+s6ZXzNvIoztO7iw+GhH7GNgdx0IPs/RV2eR449I3iYynvzuySg61o
    FedO3ypxMsELSDGe+xnzcx2RaurxZ3TWKRKG7hpoAMFkPvz8lN6jRnrj7+KrUzVD
    +ywJ4HcRYB6cj9mEd4Y2+Y72LH5PM5xWuu1Rqa3o6aoNCTM//9mDQo6pZdnDZZss
    FYifg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=DprMnw5X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=DprMnw5X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 9/9] staging: fsl-dpaa2/eth: Change max number of Tx queues
Date: Fri, 23 Mar 2018 08:44:13 -0500
Message-Id: <20180323134413.1532-10-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:405:39::27) To AM5PR0402MB2690.eurprd04.prod.outlook.com
 (2603:10a6:203:97::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89c6a0c8-919e-4fea-bb37-08d590c43925
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:JdlZJKeBH2FWQPnS2DZiHXbM2eC57wNh2s9C015QdNn80mrSQaKALy2s3TCrOHyLcVKAppbA0yeLKSXgQ1uvYADGkEbdOQRipxotO5FVi6lGLKUIPh656CzBnePDDJdm+gxWFGwGIbK6Ry1sPhkohx1sWuHAtUHLUjC/j5WHNjX7bMPaarmt8mI3wGRmbvz4ElZiClggJYK3ZakKg3fyiPgoeD+RNc0/Xc9jrmCVe+ABjRmINYzElr8rbLEBulvO;
 25:10PsjBrLDGTRXLvDP8A3rjeSc2aLtPoxFbTnDrkN169IwHESbr1TQtuD+IrO5gz5vXY4zY1c/DCAsJZ39PjpGXzH3DlVPPAKsitZXrhEgDtniIf+Y/xjbGdTzKYsTWjm+eQD9npyapolWGrh2xtxt9k0x1l7a7phhNO6dw8GFXLrfXGKw201lAXnUQ5+zkANJOI8TEHycopECx9y4bBVHdI30vR0cCgukG8YONQ5y3uEpbwOXT73+Chgekly2IHNTohKDn0Kf+5wFDt51pWIG5www0HBIsHg7MSQiAtpP1Nev7sbN98qhd+SAEennyQo4llncreHXTip0MgKlIrWRg==;
 31:bEtzjlmCaRx6WwkGtpNgJoqnpzaNiV6Eyl1RMT8mGqjQwN8iYfEBx8hIBYwKYl3R+rgpVeENsQfHHnIwqZG/QeV62dezjuJUYBhGpjU0A7HSWbcWadWxjkEAO+TA9gcrJqgRscxJ15ck401cRuyGx7WmygOhAyb9svV4hrv7K0DujQm47X5ooMXaBWV4BwTvBEJmV6ibvKBmBOhVGnmUmCpQRZX6Hlhqy3WfmjBakeg=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:TUFgoPX5tFXIo83BOeyZqFgPUHuxRK2nHlzuWe0WYvJMie0twrHG5eohmg5oyiWW8X2jbGHG8Ea1P0H5gpRW0P92XOlVJzza4pzVotuWmyBgjeFY2hrrCTj4l67jdYmjHUb34K/zLaZ2FDvoWk/6yGZYHX5kv3CxAgjVtFcwwji8NLkfxL+l4KVoV0X9dviMNzltT3Vi4zCTq5HiFMRwLcewH0jDEIl0o+W0N39aRBbkiUWdYOQq3YE6pm86IJTAMF+I6ZcslIS1HBGeL690Z5lmbXDvJOy/KjEJse3WqIldhD0OFHxPqGWArDyh1lonCsffhLS3QH3x1OHapDW++P5r6fvNGxjbNeTaoFBt+QhtiubBQk3Ua4GReGf4pk4RtPXfEqJU1ctESjQHmCUhTsHBg7JXUMl33Gcjs4FV9dKB5chiR0jbW9RGjC/ITL3k4YdsoZoCqQFJmXp9oCFdZjBlqPbJYAWGYL9+yixGZfDf85z1lPEpflIaSpRObiau;
 4:8/TzUulLkGNMYOMbB32futv7hbfmv5OnYL+lgUvBlWuX9Gf0lfgYuMMczg7kOUQfmZrsfFwU9qNq3TGTuSTHSFCgbWIHtQ3K8Olja5SUOzQ4zVmdaFX1ZZNqKnoYvqmOudC6IuToQCzbWQ39PtiRK/wtzBgEMcxH6E9cfdAKwuDOhbvUqUakD6IFY5br5vizZdND4kI9r13JkpjjC+rjP21Rj/mX4g/7WugRVT5GXvO6xIZNkB3bqKUPgQJohS1lch/9vjFruMFoLCC5n4mQBEuYBlwMQQYz/ai1J91YuQLfICU4YrFLT0mvbBZDPrOu
X-Microsoft-Antispam-PRVS: <AM5PR0402MB26904C4DCF6F18FCEDF6126F94A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(59450400001)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:HNj3V+J+lR70njg4y07V706+dSJBZxM41FwA6TK?=
 =?us-ascii?Q?ZzxleiNu8UymM9L5PMe239yf1Ozfl+WhuoqSpO/UNmEsrvItxM1tnqdpsMwq?=
 =?us-ascii?Q?kj/Q5zuXMxYBgepos6thF4EC7gZ1k7DnlHBIRtVKg7tot4msad1Bx1wf9PR0?=
 =?us-ascii?Q?+/BgkbCudDimV/1Nnln/gJorkysisFRk+hJ69Yiwo4TyGzOUkzCgH3mQx6Fr?=
 =?us-ascii?Q?w3iLMqCIHVoknJI5Vqeg/rUAME4vkKf4VaBW/wP51k32IV+8fq8j3Z2GfN3v?=
 =?us-ascii?Q?Hl6l6/HzCEz1qFj9woUkumtEiRDgz7AhC9oj5pUTTDRr5ciEshZXVr6lhxyJ?=
 =?us-ascii?Q?YrOE0VxJHO7VTgR3fxjNZjsCvjBaCmtZaGEsnRUNUWRW53sx771WAhPokBaT?=
 =?us-ascii?Q?/yEWbLhWOUJZ8aL9/SZAC6thYxNuj5VKCgxHJ6pqmMg3/Ey0TZhk8fWZFdND?=
 =?us-ascii?Q?jGrohXlKaskxf/6J0CK+2KUAXdwzZmGJnys150xlD8cSDTPTUARuydICSt5w?=
 =?us-ascii?Q?5vNZE9o0l/NMdP7SFDIt2T1SbPiPmckORqfxzdPiE4PXHH0ak6P5L57hR42G?=
 =?us-ascii?Q?fN5hT22v9zxUSaZ1c1/TNUe3+cAv/1Qjil2vZWjutGQBMpyrShG+yg2ES10t?=
 =?us-ascii?Q?oeM/YeUn/M8aCiMcC41TZSH/r1rKGm0GkF+03LD7wCKj2E7AByg/TEuNMMjW?=
 =?us-ascii?Q?7omwzqX2bfccwbvNOpARm4Jb+OZyPXuV0j95NiSyjNkdPJ+5rh7r0QSl5e7I?=
 =?us-ascii?Q?ldTxlNg4vaKPqTUdOoc3kb/2UINMVhS1tKfHlC3vAHaaTQZk/iJhvXhgZ2sN?=
 =?us-ascii?Q?Bp2BMIo9TNfxeW/aL9k4b1f4SWoXisWZxm/P6WOOpIImQQF3sJG77UIRZOMi?=
 =?us-ascii?Q?rq6KlOw+W/ySRSJXzwMxJk6IRdryk+yqdZg/93QvfwHy4a0QDejf5VuSqSY0?=
 =?us-ascii?Q?GdwyCSwTt1dqrJt9k7TcRdhDJvW4qCGXJQwKPqPxkWP+qnXFYcXfEWzC1Mau?=
 =?us-ascii?Q?ChrxcbJQ4JGejrJ+PaxBLfr7WQcUh8yFB3F8Tc8yAcRAE7JJ4v6MWkqV+egH?=
 =?us-ascii?Q?2K8x5W/NoIrdAqWay7xbL3/WsgadFcFi8c98Zrs9IeV07OSH0yGzlz86q1hB?=
 =?us-ascii?Q?O9pxRf/Fw1bQoP0JU3T9xS8oMCkE4lDBZwp1+aADCQ1ts1Iu4aTUTr/7sq9a?=
 =?us-ascii?Q?cDeGZYSj4tU1QOWk=3D?=
X-Microsoft-Antispam-Message-Info: 0K2i+uTmL3O9yzrR02Ock5gGhkuoqUgpvU2tFGq4eSHExiAAlDY0nVb0VSddzj80+BEEqoALRg5yWTU8JStgEicPmOFZt0+h57G6YSZj0VJjWs52PjRAZhh0LeTqlUys4OyyqV6JWwNO7bnp0NPzBxcUQ0DTDE8izZeKzSJNtq2pDqwl3FvDnWcRnj/znhAF
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:/ILMP0a07x7V24z1QD3lNj+N3B/2F+b1lxgBk53fams819Bv8ZeExf97s+mZuc2arNpJ37Pe7G+cc27AF+SCUUxTUy9+iICULOqjt/Ab+h+racrGo6o2MQ8rnWEkIpOoTYFfsvb7vXa6p53jtyQJnc9XkbC9mqVicP9nYmo4tXJ8q4aZVo4QZtwPjdvQDDr5XRSoEh/gX3Fjs7rLflo0y5oYAvuaWq04549KVk3XB8j7mHF143BEauk4+2YJ4bhWonVUgnfYw1hY9TPScyLuZNVZuET1mpWb4bgoqo44cRnU5zbOfzuHTwflSL0dURDbk2PGbzxFzxl5tOKImhOS2lqjeSwW5tDF/yPZ8m3LtOst1TUKbc/+jyLQdI1/+Gongzj3FrSbjXwffpZQyHQI6iJCHWlMrrPmepu+imFwekig8kn1cdiXweeL8qn2MUwgVLCIgZnC9y5Vb+8/AbqPpw==;
 5:cOCHGPIuSzuEDTH2D+snZqTirzKY1wkop29KdwYDJrE5FrVvu0QjxTyjWz055GZh3MoOob2k/z0XVd7bnbMVTlafzFOV8oV2IpkiUU73nH+KbqzJUSghJaNxXNuYo4hS1SCIuJRCdK65g6so7Wmetp2z7IwpBmVA9tyWtTw1UtA=;
 24:AXntg+g2XElhwYdQm46pcLbu/4m63bJyTTaLcv27IvrQNT190U6b/aQSdcxfMFVqBjKAuO5gYM2D+P7meZ2vSJY6iUVCXSqaYP67anDNFIc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:EztSz4uJHaheVaKfMFlkFOjdcI3hXs+gURCNhfsLdCXWCr4r/YuK9DhKUzHWE2RkYd+tGHe5UZCHBeF+5VrpY13B3Q9YL7KlgrNqkAdPyd9gIMuXyKzZeCTPHR7elds4o3+3v9JL91Td82TZa+VDTHrf16jfT2FcM3hf6GH3V7Wc5UW+244AdR908syKFN5BwzRwBqebfupDb1TXYza7CzRhiq3/yRydm4jOopzNZi4F6Rswb7bezkuSWMWpEMe8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:38.0259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c6a0c8-919e-4fea-bb37-08d590c43925
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2690
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We use DPAA2_ETH_MAX_TX_QUEUES to dimension the array holding
information on Tx queues. At most, we can have one queue per cpu.

Until now we used the NR_CPUS macro to set the upper limit on number
of Tx queues. However, the platforms that the DPAA2 Ethernet driver
supports have at most 16 cores, whereas NR_CPUS is Kconfigurable and
can be much higher.

Avoid allocating memory we'll never use, by setting
DPAA2_ETH_MAX_TX_QUEUES to 16. Same for DPAA2_ETH_MAX_DPCONS.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index fc9a255..54cea2f 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -251,11 +251,11 @@ struct dpaa2_eth_ch_stats {
 
 /* Maximum number of queues associated with a DPNI */
 #define DPAA2_ETH_MAX_RX_QUEUES		16
-#define DPAA2_ETH_MAX_TX_QUEUES		NR_CPUS
+#define DPAA2_ETH_MAX_TX_QUEUES		16
 #define DPAA2_ETH_MAX_QUEUES		(DPAA2_ETH_MAX_RX_QUEUES + \
 					DPAA2_ETH_MAX_TX_QUEUES)
 
-#define DPAA2_ETH_MAX_DPCONS		NR_CPUS
+#define DPAA2_ETH_MAX_DPCONS		16
 
 enum dpaa2_eth_fq_type {
 	DPAA2_RX_FQ = 0,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
