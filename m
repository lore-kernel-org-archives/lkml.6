Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3286258-1519662524-2-9321232603237937899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519662523; b=B49fFPeYKucSXLWeyN4OGg5xmZZoqSlaB/SZep1qr7ljrp+
    kG04EEwXsOzAm5dtOQwAnLq9loxU5oJ4JF/ytBWYZk29nCzw+4hultzCQs+RSgqd
    Awsd1aUH+mjDCxiSYRirx0FKsjYkQpGXdZtRA6RW5tDIKa6U/7CDc8Q7D9KVnoLu
    nyCx9tiv3p+cJZOIJ3XTGGlI+KJd6e8iQbZXBrmc/GNeHBCqqiLXacWeFVEnSRAb
    334hQN1tr4mYgvLPSVoXWBUO61w5vhYOYfPnnSiK6Zf2q7YWeQuM8BsVYxDNGXHO
    r7Xj0HyoCx3nleuIUVYJ39xTVQoOZkSq/5m7zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519662523; bh=k
    No6FrGuR/OaKLvHfudeVYCf5xwPe7FGIbconVejcRQ=; b=bPVe6teYWcu8q85jw
    oBjLxwyVaZioutot6p8QBVNXDYHltW0JVXw5fYY8aHK/PM1QjkQlnr4yu2kqaG+m
    XGLclGtJ2loIBtI1TwmpWDXBQWkyVol63QG3tIxou7oSgQimSr3ch2ta2t0oW7ML
    UyjfZADbRLxkOxFoTVmdcy8+v3czhG2sz5csG/NZ03THSOmHw3TqVvKvcdqLtkiP
    sUvwJtQUShJp6iDLlqWjmECPBskCARLF3hJPIS1FImDk93qdFh2JUHQCpBVHHQA3
    V6rXHaFS4fDWpNiacBCU6BpmO91NSx1AURzFI6wvxZ/4nVG3mL0u0eDTg+U9eAqn
    7e3ng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=hQLd4tNv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=hQLd4tNv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 4/4] staging: fsl-dpaa2/eth: allow the driver to compile
 multi-arch
Date: Mon, 26 Feb 2018 10:28:07 -0600
Message-Id: <20180226162807.20649-5-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
References: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28)
 To DB6PR0402MB2696.eurprd04.prod.outlook.com
 (2603:10a6:4:94::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e58e7e3-b1b6-46d0-43cf-08d57d35f94f
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:DB6PR0402MB2696;
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 3:IvRJ7E4kCclHpR/vbpsV6mUzY9aJO5XZIX8HdaksJBFmPXQ1cxWFwl3ly68B7qnx/ftC08ygTfAOqz41qH21wPw2LnpbHeKlS3niW4r91yQ6x2VtF3LEqg/QtuveHvHyk9LU//69FXPy1nXNDcjl+2dvazIOvUmWy0qWCT2QU3BWvG5iPhlPKjcJss/rODHMT8/V7se24ddpn4RTah20nsIDHg8+z0/XTGoa9OSZR/FEj9dhu3gk0wPn4pCumBgN;
 25:Jp3/Oc4TOYbzXZe347/Y/GypNwuc4p/tuHmzHfl5SpKuhl2ZB7x0JL7E7IZR0pkJ3TVdO80c1n/pMpFsPlEMQ2aye84DHPXjwq+P1KJ2jzgb14bWowZxeylcPWNHcbxOM/9p46CMOeUNubtFQwPKob1PGWtkddJnnL06Udv4/w+pSE646e8mMsvGOj1ZZs3CdJW4RlFiw8rLN8kEbYSuuj5QUMqe/tO3NOAxDtsg2CY9400hPSJAXgHSTgjWF9zo2sEsDqUZNgmsbscbXbGwwphH/dsNPc/H8DTWD+ZcR9YdHeoAR1731ZK/cmaPecE6eQ6UnF36pNHpZQ7fCNoYtQ==;
 31:OYM9/769t1/jIKlI5W2YGkALPZe2fGMyMN9OIDn4yaV9XZppH2pinnYOCF8EXT9MxhpuzT5dwIrm0qo0sEKKQ6FXtG8qUKtJ3gILDwTbVL3YImzz69Zhsb2lnd2Knw0fPBL69Inme7Tpbg+w4MwWtigl2UEpWL8Vb5OJ9Q3PO6sR0NfUdW7fF3CS2oEfEgibR8CtfvuvcDUsXoHaVwhpk8Ies0ewZ2LU5NoXIojqoEc=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 20:yYGLbHHqHW+BLFUofoBvK9+fohDCvl73WrBuxs0cXq5FpNFScZsjCmvH1s8xCnkQ7StmN0TCBHkSga22WdsqTbiEOYNbXWYskNU68d8/zx6+XkkKwS72ueuzEjEiSpbHWpsuy+lBzOnC9AnFvFaPlfQMeRgpfP1W40ilCL/9101ZxBiRkcuFdFjYLqu8589FY6IrZjbFXEi+MP3mevCjdqtyEglNDv00FZoEqGpI/a5ZdyvFzE2Kpm5Z1ntOKhHxWUxCQsviC5zXiH/zblQNG82zYFVCc4l4ZbvX2CRZE+uVK6z0v8VoaD7wXsHtDkCOC5u3gejQWbmZz9mzDdOneetDt2z9Hg23l9/bdEqg2GG5RinnT4swaIivHFgm7scL/Go/zOMAXyc4hBMiX4eFMAA8jH0O5k621Yfqoj00JRjr5zIVUN0j+s6omAdiOODuyrfKEJsZoNnfatwuheYNY44aoRZqAxPxFtYrhU+VP9/Dk6laZpbE7WOZ7cxIrCl3;
 4:zeb3eN0sGTowlr96+Q8LeqwGNHvvQKrvdnK+i5Plhd3tlMgIxHihenk3yPZafbPxmOtL3bJDxB1fiENQ2mTi2i6eT2PDcKgVN59SSohEcP+nahpDQRGrwpuMWviW20VO7NBR4nLdi8KW0oUk6bG0fAu8cfqcPGwtYo/UGk3y3x7h9Yq7v2FciYqsdeRMtOlzRKQ7nGKZ9VWphbpshG29MmTL0d8yv5RjUChn12izFgGxDIFBDhV+KLHVlpu/p2mXYVzr0V9RQP7OyouRmgRWuClXWHShYKcoPSLONqpvLZvpwJAW2ywNSyn+XDCe+VD7
X-Microsoft-Antispam-PRVS: <DB6PR0402MB26962160F56925C8AC329EC894C10@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:DB6PR0402MB2696; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0402MB2696;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(39380400002)(376002)(199004)(189003)(2361001)(51416003)(106356001)(50466002)(26005)(16526019)(478600001)(316002)(186003)(105586002)(52116002)(305945005)(7736002)(16586007)(81166006)(25786009)(97736004)(5660300001)(2351001)(86362001)(2906002)(8676002)(2950100002)(6666003)(66066001)(36756003)(4326008)(6486002)(47776003)(6916009)(53936002)(48376002)(81156014)(59450400001)(76176011)(68736007)(6512007)(8936002)(386003)(6506007)(50226002)(1076002)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2696; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB6PR0402MB2696;
 23:Cs7qunrk2C06xF/ptoiuPQatOVqVn4mipr2k/ib?=
 =?us-ascii?Q?bo4LPBsiBi9McimRqnoT0sJkjEBvK9nTJvoXqVVaEZM1+iEG4YN6KJmpRcea?=
 =?us-ascii?Q?gFbqJIqR69+FCXpKkSbxcQO4fwZUUBXXudnKWheXrAX7JnFo/CTK8seyzlYl?=
 =?us-ascii?Q?5nxmEiNW50y+tXCSEVyIgs60O7U/sPXAtgz2fodZEQoFuvHfrtjna91TlirC?=
 =?us-ascii?Q?0ZtHNXxRAtBPH+aAxR5LE2K2v9QpC05TzmFS2p/m/Ywo3BgexaV4MJG4r9yS?=
 =?us-ascii?Q?9F52kq3LgRiXYq8b9nZRad0FZiFMktJjstKg0mt6gYqHZCwnnLBzTxdSCkAl?=
 =?us-ascii?Q?QjT9iOcvNfiq7htCpXWK8ueQGj0CQJSxBD0DoiIKTvHRrRfHhUT5xoeetsKg?=
 =?us-ascii?Q?rdqt1+Fcd3tlBoEo1l4BV+AmjlKjYPUaqwQFQjensei8zJrKwhJ9XfN5d39V?=
 =?us-ascii?Q?guAorWOEIOUbP5uL4IsdGAybUMQBTqMkjM35JQQ7tVRqy1a/iFa9B/d/UjGE?=
 =?us-ascii?Q?i0OWDxPe7WpZBT7GPF4YdL0PdDDAkQ9A3Q+VZvwC2zweNxPHa1zZ1mXP8Vj7?=
 =?us-ascii?Q?/OJml/h7UOO3FuEScrAzHne4AP+NHlOJW09VMrYVj3iLROmliKdSs2QvBVn+?=
 =?us-ascii?Q?kEkyKQ5lkxyJHd9c4wlFfkcCsuemGH88m3lMPPeG72aRJCLwiR30oqQzqvLx?=
 =?us-ascii?Q?feMVCGRxaVTI3hzgKWzFl+S8ZjCAUSu54JDoJh/xKYmlcAyyX1vSX6rnxZLD?=
 =?us-ascii?Q?3MqFdYDJeX4jEt8A4YUu9QuMiEAM+GKjxoneFM6PUaZ+p+ZANXDTpcY11aBW?=
 =?us-ascii?Q?DU3lVvTnNQl6drTeqNXYB3+/ScATvzmVn9TF0Dc8/9p39MGTYWQpQmD8eExp?=
 =?us-ascii?Q?JvOpPqQzKj+d08qSOelPULlvuPJ+myAmyU2fej2/AVB3tYgabflp1LHCmEJ8?=
 =?us-ascii?Q?zuJ9dHBXSojCC6vGQNGX0sVhKUKU1/ndItSBtL1ymRC9IetjLQUgV+RJcx4O?=
 =?us-ascii?Q?ouCAnzk/LOVUJ5Zmaj70MRuoiyx2K+l8CiBRBOuIEgxYm77pmOsGra8Zujwo?=
 =?us-ascii?Q?h7Eal67VfuZ/5TPNIUCi+4Jc8Uon5/rcGaKvxO81dSZnmEotrA5CD+FQpQMO?=
 =?us-ascii?Q?Msc5jqSkqQrvg9p5Vred6IJBPZylI3rnULy6z3HMouS7lhi3SfuIAKkMqJ6d?=
 =?us-ascii?Q?/QszW5oigfJtBEXA=3D?=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 6:XxpJoHkiXOTIRBcoRtqSDjR6IQQcrtl1ZPtGY8yOCzWRvAXwch6TlmREH0JAeSiqMiYpSv4NjN7CLiIO/nw3daED4zHhl77wgj6oDmUDbcoracoulx6421O1ZuEHzeVwvgNRi3ug9tzYsSaLpEltVugXeCmA/77mtRIajqrhVfxpQfgmM5gxIGzVgLGombjKxcM8lpPzSMM9qcQi7+FYO/4Yj851rBdqUH+IVKT1QpWmKefmEPMy5OxgCzxLEak216Cnpj5VvwwVhaguWouL6pJSoDkWMRekegtajd9qNJjpjCTjED6kpW5I35vluRvVhbawynd25c1ziEHo8vOmIrLX6rdwCbra2bXKhigcPOw=;
 5:uaQvmKZNtDw9qYuDtjwkELflc47TENuPRgn7hKffpHj9F/dBlnfHrgcsnoGPaYCP5i5uBTfC3e6lazEEAMx8inyriOfrflqAyOugxozgQxqQ7y4E3uiUnlfxvbcXIwCf5eTpc4ZRsHGzeepDMBNolItPaLRVH8r2qKlmKbtaPEg=;
 24:qw/0b36cfnsYjXzN02XbD5Lx0lYM0xfqCqvDEMfcOb4aY7cIghVOg2kR11mnIdftVlqpwdGGNMln6XBPvprUOq9CtG7oMrH5mWD/wBqquqs=;
 7:qWed226RkayW5MoLdyBRQhG26sDtS2eju+hEFAlkKW+i/U7LmYg2xK3Edoz1da2QjeKFBHWyRd47cuoWMvv6yJhPKtULa6oYKbrjHuuzIND2CymsVPWbtOGBFInfj2Cjkq8xSPErljC3osz/+ymPl3dCi4ONHZ+MyS9ILGex+SuVv+8H2rVPdVZhPf6TcS7BbJ7a5ORYX/2jhMPomHlrbV8cUUnETFFziTtmYiprOUSTZsLcERlLFxVMOK3Kr+g1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:28:29.9909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e58e7e3-b1b6-46d0-43cf-08d57d35f94f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
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
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com, bogdan.purcareata@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Drop dependency on ARCH_LAYERSCAPE (which in turn depends on ARM64),
thus allowing this driver to compile on all architectures supported
by the fsl-mc bus driver.

This was compile tested on:
 - powerpc (corenet_basic_defconfig, ppc64_defconfig)
 - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
 - arm64 (defconfig)

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index dfff675..730fd6d 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -4,7 +4,7 @@
 
 config FSL_DPAA2
 	bool "Freescale DPAA2 devices"
-	depends on FSL_MC_BUS && ARCH_LAYERSCAPE
+	depends on FSL_MC_BUS
 	---help---
 	  Build drivers for Freescale DataPath Acceleration
 	  Architecture (DPAA2) family of SoCs.
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
