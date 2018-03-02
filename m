Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1243504-1519986280-2-6777868987702454437
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519986279; b=q0Gad81/em3h1EE7q4lAijQ/K/UzfR15HpXpZsdNyhiaFnP
    XXVS20hOvClt94fENIbJKUxKjKmDzfuuJiN3akarYrJRZA3ialNUkt9FlsGWUU6P
    NIP6o+1kfttOnfVClHYceGLbApA4g3nOwlkuYwfJatZIO8h+W/C2Ixkaq/gHGA2X
    /xMBztBb6pV+OQJ3JY9pbspX/yOdxv7noS7y3vEs88fCd/RV2BbNZFHA70+RxNWx
    GJLksABGxNCjJkbXOD+K941eipIOVzhJn2o+ySg6gbLjGQPfRCxnZqqQIkoFDlFJ
    f9IKDlPEaE6WJ2PboQft0qQUDRtVvdhSfEnRFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519986279; bh=F
    ICiofrvrGTFdL06ZAE7BE1ibcfHln+NIbwdcip+h8Y=; b=E3zf0HCxBA1VhG8f5
    EIZqkI0JMAvQF5uRddFkJFp26BITlwlQNFiT3e9a7p+Z5w2jYotxi6ya/zPkrP0V
    eLRHoQMvl5I4aP6jKPwpJZk9ja31Tml6J5YtWDeeCdpHPvGdOkTeN99sgJvJuGOp
    Xhv999mmEuP1BHxeIvCFRYOHVknQaQtaVdPXMvKgPXLphZqa8IQ7mgsJHjeV6Sej
    KlbtqGiAvseY2kQU4zTGC6wW26++npHV2gmzZLq9wfHCTV6sJW5kZCVgsBttTy7W
    4gDmfdZCZP4PojRIQrFn9XQJn0vLioxYpBlqHOjjyBOSHcu0H8/GlD2aNKjo3qKW
    P+IeA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=mDDgjWrm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=mDDgjWrm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH v2 1/2] staging: fsl-mc: Move DPBP out of staging
Date: Fri,  2 Mar 2018 04:23:58 -0600
Message-Id: <20180302102359.16979-2-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
References: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR2201CA0055.namprd22.prod.outlook.com
 (2603:10b6:301:16::29) To AM0PR0402MB3649.eurprd04.prod.outlook.com
 (2603:10a6:208:c::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a84a132-7016-4387-af28-08d58027c6ba
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3649;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 3:manz56YoRYE+QzzVNy2sm85pH6XyqtqUa1pzPLZWxPW0+5FSe8dBRXNaT5Kh/3mlK1LrEqqS6W28k+3TJwszxODNFTkvJol26zmEV17Zb9WfQvF65IF7HPnu6NiS14HFvgGtkbPDtY6TjGll1V729thDPoRPDxlKvWwSa+P20ER3W2nDIawnCoyxbjq6HZ5k6k3cSRLYnzm3ncvlZKrB2lIvThm/7LA6O+2lvf+z7f/o2jX7rEmkBbRfpqGuE5U7;
 25:PJtzyPBQZt6aMv0+xCwUGP1WpFcregzluOQi1Jzc5zRehTIJjEYPHYvQizpoNm1rSKpT/oLQck2D1JnTwc4I0CZHiv1RJGwy98BgS1cfmHh+t4jybVw/L7vj+eTVpTm+hJhKDbY7dU+b0RWIoG6mcbK76MqRSigIgXKR623DbvhJlPCX1zr7GDLyyvWjQw6ffMKxt6IwqydohKQ509VnsC5CGj9OqMaudJBGHQh5T1iFMIoJehKl+uM26mHDpNJ1cTAHh5egcU8hNfMrr+t0QliOc3ObcnUd+nTixACiGlYg8gMjR4hh52WVlDvGThoYt84gNyrWk4CX/xeCrYMu6g==;
 31:hvG5mkMFKgS7W0QTHono7X3seCreIt5D6NCZPVPHRc7PuUAbQNCbIlN+3K83FLjqoFpCzax55IvrzCjS+fwSR2wKvwX9PhzGA91/mtiiTPlYdI2xuVuzndRFXwb4o6XbZTG7ZlxwzI4pb3AFrlwk8QrS8YpTv7kNyDtRUbvJY3fwqA3iX867W7HL9csJHMsL8CF3HSQAF3IIgATi9pvWmkRnuzSZ3hs0OqSBd9O91Jc=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3649:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 20:g/hohvnaaTWdjblqFGlJ2Up05/0ilwRMzu1+N1A6VSLY9e24jFH1ku4l8xqVeqGJ/Vxzpbs2nBG8SfVrw7jLy7J+2tYo8xJqWczjfZ8S3q9h+ShLztM33ROa5wuoC2CME1u9fAVvsJLkfDY3nKFmZJ98g0AF5vOMFU/BfGyDeedqWkBHtXO4ggEXjh42X1EAmbKWT8iD2ukc37YYDUFeXXmH5dwnJDTQflvCOx6NqP5MgFvJGkOG1d4KKAa+Ahe1LA2hq2VhYb9dmd06+VUOEo8fu8fm/sx7XQLjiqI9/ByO8YpewVTjQduWfB2SF1vQKNYTJpmvJuXipcjE5HazhIMPoz8ZA1Le19M68k559MV5fFHhxHxEc2Z6Z6V6LF+1KAXAURe0/IazlOR7zEJuE63wAFj/ZreHR+18zKrUjc0gb0A6ZwnPmdYNPeCOGrFJagJdIMjBtNFGlIelM6NTL/1yfd85LYo1tLk590lE27Rr2pofFsncVK6S5ouYGK/o;
 4:xPHmgoIQ08JcYfOgc3rqjhvn4JpWqyu3UKYHRKnpZ0PYRd8ktEO8HALx0HKCXOsWVjr9AeLioefb2tBfjQLf6XTJ68t7g7EvpxG5s56WLW+2+/s6XrtIo//Pnhd6Go8v5zRrJSdcnZz9SIiksBRjN7T18GIvGTZc523PRIzfTL+wncjMmlJNbAdLJ2e6BIbxamZx3dKOATWBO4awMijSsUDR/NG3RfamrklOKrBuysaReuyzTfnGb4Hq+f7G0PAPopuX6j2wv4ttwiP6jydStIdjWnLVyuHLWJLmsFR1ydiOk1j7FID9eP5FLtXWDvAa
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3649D82296D847A8434F27E1EAC50@AM0PR0402MB3649.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501238)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3649; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3649;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(81166006)(16586007)(86362001)(50466002)(48376002)(53936002)(76176011)(106356001)(6512007)(5660300001)(51416003)(25786009)(186003)(16526019)(68736007)(50226002)(36756003)(97736004)(478600001)(59450400001)(52116002)(66066001)(39060400002)(6116002)(3846002)(1076002)(386003)(105586002)(8676002)(81156014)(26005)(47776003)(4326008)(8936002)(2906002)(316002)(6636002)(6666003)(6486002)(6506007)(7736002)(2950100002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3649; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3649;
 23:hIZqmnJ0XrbkKWif00rT0W++CPaLaxQJZqgVH8m?=
 =?us-ascii?Q?ycl6JxCV9DiReYY0rn/jBnByYAX8YKZJ2BvnokHOOkNv1JdtlL6O13Whn9GI?=
 =?us-ascii?Q?TU8emU7BcbCRF2PWadtvV5lC8+lqdEWPDfn7ijW+tn30FXZp9l/pnIDBOJLa?=
 =?us-ascii?Q?twXHy6hChyOnB2sdvwpblx1u0qmE1qUUjVSMaNjZXWz1TEMQe78aFMZeSqph?=
 =?us-ascii?Q?hyccC3w97S29Fft0aamCBuNjt+j61GnZcWtsnPZRePAtmdy4FvB2tVuRp89c?=
 =?us-ascii?Q?YMGYjvuinb7zOXzW8ruR1J6w3OxNd4l14/JIARBEqDZ5poMYgljKoeRAvG8V?=
 =?us-ascii?Q?laLrGccX6Tn36VqoRdR0TD6ZupOubotWWqyO4FbwCpNztUaJ043w0zmR1RGh?=
 =?us-ascii?Q?BoL26dADGE2jHieELnVUfjfl/9uMRnrB2+k1EB7bphkJ9chItNSxG/UT/T+v?=
 =?us-ascii?Q?Xjx02/AD9eFb3MuJ+ug//EomNzUojNbbxxdJSvPWr3AR8+Bz9qJ9oE/41y/f?=
 =?us-ascii?Q?ol8Qu1WHgvlHG4VexhgBC5PnmdD3YTiK8ztB3GFmB+iadgheRc1IgyniLzpx?=
 =?us-ascii?Q?0iaQPWCqV2fZNtqmLO1ggMlA8msmagvV3tCiAZBvmoUNZ1fRaH5n5G4RZAvp?=
 =?us-ascii?Q?i5lCt41tQaBDJuh0lMpXQ2xbk82dkjZLhe48ODQqO2EqjLWGbpU0+P2hIBUb?=
 =?us-ascii?Q?LdU770w5BFT+uV32FymNq3A6KKkVFzxOUTAKw5hn0+8IQ9U1oPd0cQE2oLK+?=
 =?us-ascii?Q?Rrys6iKQu9X3yniZHzfIDx/7/ZZV/CJw4167NFKtMxRnIKBSwR4P+qJwepBg?=
 =?us-ascii?Q?B700yGjVqkoXTDrGEn8ftX1M52zrHujC2pDJfbJt6RJLyhnq0PVV23RgXQHI?=
 =?us-ascii?Q?B7U0GtGSl5+BftECpJkaMdRNVMK8QZZ3tcMZDf35rZmgwndOhGp/fBrHamKk?=
 =?us-ascii?Q?FEZdxvUXrh+wtvXBbHW74XVkULvG4JaYInGC46hcrSWCuSErWg0UbJW4F9Fr?=
 =?us-ascii?Q?Kn8y1dfgKWlfvTvhmLDq/IbjG6C5OjNBFLAVL9JZ3DN3UGsSG5XZMR3bnvWM?=
 =?us-ascii?Q?YFRps1x98N7aV+XOHT7z+DgH6PpWY+fWjyMgwjM8j51fhX79gF8zUJOj7KmT?=
 =?us-ascii?Q?JahgCtjhkKt/sqpwkAxE3wACctkKaww7eqAvJt0tBwmqEVa5h4ggWtw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 6:GaVYGtbsJo3ROAgTE2Q7H170HOEpxAtF//kqNCtEIr5JGe7kNLnGGBJiMu8ti1bDHy0r0CT7eU6NsKtupewxNqg6JRIe03rXjVOQvq9hm738Wa2e7jX7qvBdvS0Hc9xkXFZzrC4LLGlruWEyWVHKGVkIsxkOkb2b2DKjLtlntkcoUmhzPsTWIRvJT7qkqejZ6hV8jcaMlDy/oLl/AvMLdrvwr1J+AC7Tyex0QHhvO7zsN0qspai2keklI+1iFDTFNFuh+7Me4HMMgUQzXlcphrdwe6j3XVcWE2e4vSDyz/EiVbcipBC0ltYyBNS0UmikLwOGsnA4/gJBPkAtEAdSS3dlsvDhV8IW6xc+yuaGXVo=;
 5:Ye2JjB8VLfigZwU9P2GzOP1hUbxTWGWGHMt2Y6C5KtJNYt+ja+pWDVGnnD3Iv4bMKG1P9wgiS8ggkIxIbziLY7NQIK2Gxy1Av2qldLOzBXQoIJ7XwUno1DN3EhbxVTgkrUIwOpKguGPBajITrU/Hdh3Vz+Uhp+Zv23z0EeOEQTM=;
 24:socERGEqGZnU/5Xi/N+LQMY08bJNzkIhki6FFdUMWOH8A+UdIfw7Ex4r10YAdYRY/Tw+OuOInnWCBv2MHY/61P/a6QkjBLkZS6IjKpi6vXs=;
 7:dLgWIh5w0zC/d1OGN6wHRof7Qc7zOwBeORr2eQHq2iwqwx0umAi5nIqfIwCMmYqdZzZuScZ+uY46NrSIGfj+47CpujTx3zNGm4ZQyDzZ0xRaza1vbC1llUu2pt9Q5phBl5yjDYyNoI+ulByeZBCE+nNDyJ7PSNhYjkBwI+Ejl4dAEoVwkA6c700U+/+kwG+qZbp8CXmDNqbGRu6ilSURsZ5CBJ+FgVL9rzPy6ipQzG182CJ1X05OYZeh+fb2h46/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 10:24:24.0402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a84a132-7016-4387-af28-08d58027c6ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3649
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
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, horia.geanta@nxp.com,
 roy.pledge@nxp.com, ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org,
 nipun.gupta@nxp.com, Bogdan Purcareata <bogdan.purcareata@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the source files out of staging into their final locations:
- dpbp.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
- dpbp-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
  to the other internally used APIs
- dpbp.h gets merged into include/linux/fsl/mc.h, exposing the public
  API

Update references in the dpaa2-eth staging driver.

DPBP stands for Data Path Buffer Pool - you can read more about the
object in Documentation/networking/dpaa2/overview.rst

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v1 -> v2:
- properly refactor #include line (Laurentiu)

 drivers/bus/fsl-mc/Makefile                       |  1 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c |  4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h               | 39 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h    |  2 +-
 drivers/staging/fsl-mc/bus/Makefile               |  3 +-
 drivers/staging/fsl-mc/bus/dpbp-cmd.h             | 44 -------------------
 drivers/staging/fsl-mc/include/dpbp.h             | 53 -----------------------
 include/linux/fsl/mc.h                            | 42 ++++++++++++++++++
 8 files changed, 86 insertions(+), 102 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h

diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 6a97f2c..da26e52 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
 mc-bus-driver-objs := fsl-mc-bus.o \
 		      mc-sys.o \
 		      mc-io.o \
+		      dpbp.o \
 		      dprc.o \
 		      dprc-driver.o \
 		      fsl-mc-allocator.o \
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpbp.c
rename to drivers/bus/fsl-mc/dpbp.c
index 85735bb..0aeacc5 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -5,9 +5,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include "../include/dpbp.h"
+#include <linux/fsl/mc.h>
 
-#include "dpbp-cmd.h"
+#include "fsl-mc-private.h"
 
 /**
  * dpbp_open() - Open a control session for the specified object.
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index bed990c..4ef8d7e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -379,6 +379,45 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  int *container_id);
 
+/*
+ * Data Path Buffer Pool (DPBP) API
+ */
+
+/* DPBP Version */
+#define DPBP_VER_MAJOR				3
+#define DPBP_VER_MINOR				2
+
+/* Command versioning */
+#define DPBP_CMD_BASE_VERSION			1
+#define DPBP_CMD_ID_OFFSET			4
+
+#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
+#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
+
+#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
+#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
+#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
+#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
+
+struct dpbp_cmd_open {
+	__le32 dpbp_id;
+};
+
+#define DPBP_ENABLE			0x1
+
+struct dpbp_rsp_get_attributes {
+	/* response word 0 */
+	__le16 pad;
+	__le16 bpid;
+	__le32 id;
+	/* response word 1 */
+	__le16 version_major;
+	__le16 version_minor;
+};
+
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index e577410..ce864ee 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -35,10 +35,10 @@
 
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/fsl/mc.h>
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpbp.h"
 #include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index b67889e..ea6479f 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,8 +4,7 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
-			    dpcon.o
+obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
deleted file mode 100644
index 3340021..0000000
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef _FSL_DPBP_CMD_H
-#define _FSL_DPBP_CMD_H
-
-/* DPBP Version */
-#define DPBP_VER_MAJOR				3
-#define DPBP_VER_MINOR				2
-
-/* Command versioning */
-#define DPBP_CMD_BASE_VERSION			1
-#define DPBP_CMD_ID_OFFSET			4
-
-#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
-#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
-
-#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
-#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
-#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
-#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
-
-struct dpbp_cmd_open {
-	__le32 dpbp_id;
-};
-
-#define DPBP_ENABLE			0x1
-
-struct dpbp_rsp_get_attributes {
-	/* response word 0 */
-	__le16 pad;
-	__le16 bpid;
-	__le32 id;
-	/* response word 1 */
-	__le16 version_major;
-	__le16 version_minor;
-};
-
-#endif /* _FSL_DPBP_CMD_H */
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
deleted file mode 100644
index 7b9f7ad..0000000
--- a/drivers/staging/fsl-mc/include/dpbp.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef __FSL_DPBP_H
-#define __FSL_DPBP_H
-
-/*
- * Data Path Buffer Pool API
- * Contains initialization APIs and runtime control APIs for DPBP
- */
-
-struct fsl_mc_io;
-
-int dpbp_open(struct fsl_mc_io *mc_io,
-	      u32 cmd_flags,
-	      int dpbp_id,
-	      u16 *token);
-
-int dpbp_close(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token);
-
-int dpbp_enable(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-int dpbp_disable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token);
-
-int dpbp_reset(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token);
-
-/**
- * struct dpbp_attr - Structure representing DPBP attributes
- * @id:		DPBP object ID
- * @bpid:	Hardware buffer pool ID; should be used as an argument in
- *		acquire/release operations on buffers
- */
-struct dpbp_attr {
-	int id;
-	u16 bpid;
-};
-
-int dpbp_get_attributes(struct fsl_mc_io *mc_io,
-			u32 cmd_flags,
-			u16 token,
-			struct dpbp_attr *attr);
-
-#endif /* __FSL_DPBP_H */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 765ba41..66118e1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -451,4 +451,46 @@ static inline bool is_fsl_mc_bus_dprtc(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dprtc_type;
 }
 
+/*
+ * Data Path Buffer Pool (DPBP) API
+ * Contains initialization APIs and runtime control APIs for DPBP
+ */
+
+int dpbp_open(struct fsl_mc_io *mc_io,
+	      u32 cmd_flags,
+	      int dpbp_id,
+	      u16 *token);
+
+int dpbp_close(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+int dpbp_enable(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpbp_disable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpbp_reset(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+/**
+ * struct dpbp_attr - Structure representing DPBP attributes
+ * @id:		DPBP object ID
+ * @bpid:	Hardware buffer pool ID; should be used as an argument in
+ *		acquire/release operations on buffers
+ */
+struct dpbp_attr {
+	int id;
+	u16 bpid;
+};
+
+int dpbp_get_attributes(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			struct dpbp_attr *attr);
+
 #endif /* _FSL_MC_H_ */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
