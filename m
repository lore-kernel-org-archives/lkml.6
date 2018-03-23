Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCWR7v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:59:51 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:52135
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752175AbeCWR7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:59:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Fri, 23 Mar 2018 11:59:36 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Pressler <danielpr@mellanox.com>
Subject: [PATCH] kbuild: rpm-pkg: Support GNU tar >= 1.29
Message-ID: <20180323175936.GA18412@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: AM0PR0102CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::21) To VI1PR05MB4461.eurprd05.prod.outlook.com
 (2603:10a6:803:43::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70024f63-de3b-4fdc-7df2-08d590e7daef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;3:UBgVoe3FyEDD4ro/zNRBW25b8MXCB00m+DZMwueF2RsSxkDx5rHd+o5E08bHXWnAD0NAGi4af4NMMyyZNTIzfIvrPTtSaXaUI5YfmRLwhY643TmvQtcW+zmEhTaRB9/KYbhyiHuoIIPMtXrjhSXRkk8I9Sn30YeCx+xSn1pOdvQA7sIms4n3pLtZHowGtrlU8cZQdSHkYh3/5NFCvI2IK/hCAU/zgXUHgEfsUgClPwrUs0c/frQWq9mM8vYWsVsF;25:9ohhYKJ+3fthMxZvylqO42iHY2oXBuRwpzyMxI0ozJ2Laa0bXyaRBJMO+6ZAKX7jVv2rS23fPgQRv1T4ztXCC56NfxkzhxR53o5AGOGR4C04WU3qRN8DFUr7oToOIqJ4g1YRgvb0asvaNFhmZhB1csY9Dg4eJUympAGPY+eNffKY5+tkkJgfRkfjG7kUXHMNbqH2pb0ls6MiDUSn/U3P66SQvoxhtAL0XHvzRaKt/qTra6jg/PhlN7cqiyOfH0Kym/8aEbhzsK0hXHvW4yc0HFn4j3YuwGtQiyGRDO6Sg3yRmvoMo/WHcNRhxIKWK+rQgoXE9F5wRiaJuh2904+L/w==;31:IPkD1OhX6rNHflwd6xvs7S44pTtm7UiO2TwjypTaJ4U+9xk+fo6zgV3axrpC8bGrBrmWVPaBkPJqFnAvyJaYV7guZUvY7Cxj7Tl+0gVp2zGwillP9tJfR0rxnPgGtayHR4mPJhrvtktBYS32H5uYtKqc88GwU0TlWjYz9yMdHYYOX73dcONTn6SFPFVg93WWtJr/nJUnFPEbjzY9iIyvx/zuKI0HzTuujhxn/3IagzI=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;20:+8SQg4aRE1tYzY3qEASMVrNBlMFuiQX3UFNNitjr1Zqvhf58iCZrVssUjS5traXzKR//ZhvjzlqzycRLpFiyJE2ma0N0iWt+UeY6ROSHtLKYCMEYrX7bT95Jf8qWwPHsCHPHdkKq+8vUrsjA9dMpv653gwFWRUZPssx3jzkqG+vf46WyJE4Er9j/I72nE4DT6/gEBRz+FhSTUDv7bGYde+B1uxVW9sQ5Tvid/CVlbvrhwiQj5xWXaU2KZhbi6zR3KAj9Wyo4aEvxbwMGRBHNbQx6tCrZIZ9ZinPSfaU+jzHP+v3CyZHhaucjaOESPhGljELSJzO8umMYlJ/vEdiw7TZ6RIpyLQfOFhK6PGnbyYCFG7sFQBySiYUVQFp9a4diOieCeI5YsTBeXZKP85+eHUNSLTCmIVCtRw0rDcI5A8fhL89wmZizbAAlnbJqA0Y6mNnR4lItJs81o/Tr7kolg3qRBP37Z88fp3K5SqPk3C+9etTtpgr616+a2vw7//Xh;4:aFz4eCDR2doSEcgmrtSbB/2/b0LTzGiWjKztrKgtbGGeKCGrPzUpaLtt4a4yYLhca4O7XZ8RX2FPSDOs6Ess8oZ5SVesfIoDGTeD+YkbLQ7+PieqOCZzFKdDoIkVt1b8/MlmCdh5VR1BBlSHoOdMtP0thyuhjmK9x7y1EYUNjTgu7JIa+9jQU9l+7nQyzAu3gkpVT3xCHeei5fj7hzLKQqZJlsIQWkVBH9x1LbfW5YXOZkpYdyrRHOyB3AF1hZ/WySQCm64r5I8KeQVfVaeZqA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB44617544B124415ED2C97975CFA80@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR05MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4461;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(189003)(199004)(1076002)(2906002)(478600001)(59450400001)(33656002)(8936002)(23726003)(52116002)(107886003)(6116002)(3846002)(386003)(316002)(8676002)(81166006)(4326008)(50466002)(33896004)(68736007)(69596002)(9686003)(36756003)(97736004)(122856001)(66066001)(305945005)(46656002)(47776003)(5660300001)(7736002)(86362001)(53936002)(26005)(83796002)(9746002)(106356001)(9786002)(58126008)(16586007)(1857600001)(110136005)(186003)(81156014)(57986006)(105586002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4461;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4461;23:pgc5NnZNj0AE1ID4o/gMF876LcOFzaGuoeT1ydEk5?=
 =?us-ascii?Q?TCpOW7KEBOXxI1K15EafadOJgo4UyLLbi5dhkz7vED6xDp5uM9Q/0ATCvU+S?=
 =?us-ascii?Q?nLcagGrDEDqLZaXqYaOAgRm7s5qV49UuSFdnwFqHP6QoqxaYagvzbluE9Syg?=
 =?us-ascii?Q?1Vhzv4D+33i5E2DOmqea730fWAJuN7A9vKRiIha9IiwfyVoFaAWMbwgPye2D?=
 =?us-ascii?Q?gKxlaUT2W8pJ71WLhOlByffCB0ah9B4EIhCxc72y7Mjf8gRVIhVwLgtDk0P2?=
 =?us-ascii?Q?yVLwHRdpmlFek57m0Bnad6gHoi+H1BkfResTE5Oks2NOpJAcPtuVDwRXfHdX?=
 =?us-ascii?Q?i4sSDwms7FjAbAxNLQr131cuCnbaB1hOeyvxU0YgjrrjTSuXH5+PVzbzhu8j?=
 =?us-ascii?Q?mYMLKg3o+BTfIImoGpWOcrBqs5FIYDcTHtgg+u+RCpzbN+5KlhU5amiv29Ao?=
 =?us-ascii?Q?VFKxATnLtev3tyTaOCfntjJJHkIbwov3zM8R0k6Yfqfbl3k1Nu4b5IDMESJf?=
 =?us-ascii?Q?zcCCsygUP3mi0/+X2mgxp4wz3oYjY//l3iKyZ7ddyBHMTPO6osTB+2D7m3Pj?=
 =?us-ascii?Q?/k2hjfA30YEP0IT4Cp23Y4I11OMoDoXo4koGUGa8D/s220pdhh0GsG4k0QJK?=
 =?us-ascii?Q?OluFSvDHTGa687GXECw+T1sjJBgWI4C+W+U8uXHPVBo1sfMhNHxk+tfjSrE2?=
 =?us-ascii?Q?6/JMPm2AuPyPHyf5ByRt++kzEELfbw9kyG4lD3cy5U2ZGE+S3km6oMA/YCCq?=
 =?us-ascii?Q?nSDquD3609tbJE/2AarA+tLLUag3aOlAGzdaMnEwhAHp6l28C+REilLN2tma?=
 =?us-ascii?Q?SjWiPYPKjjf5XMDvWqc10DOnHsTQ2fEMUOuSjLenio123fT/uhIkqFQRfPVL?=
 =?us-ascii?Q?/NKr7NjYy5Zs1RiSEWle0ilS4gHmaPSWUlcWT3AmSlauwQ2IB/Z9PswuaZSJ?=
 =?us-ascii?Q?NpWQ3riCEcbisiNnUamvkAe3q6z8KKKoDUG520Znd95P2BeVrJU7UYBC1Goq?=
 =?us-ascii?Q?djTAIQIOq4k6vy6l2lWqNN+RwK/4NZfMWue71qrgYm5qSnTaylx+aeInhs7U?=
 =?us-ascii?Q?CkiKLKJifSPESZcitnvpICJub1PaVcT4WnSHMOgy6EdCewBV58sQQfekcnSn?=
 =?us-ascii?Q?oD70vKN/qzsPdG8hn+WEmjanf1ClhqiG51BhyCmGo6H6G+YoWmyGaKgeyVF6?=
 =?us-ascii?Q?CGXlXA4bcjBSPMYWf1Ufb+jX3IitQ/IXmNGSx49z3HEsMbJZb6Tz3wQrPORc?=
 =?us-ascii?Q?ZIIzw474WjMp5ttp1zfnc/l8ha3+GgvDdZjB8R0t0mP/hxr11PZ1+AmKDiyd?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: SoxbiSyuMHXPpR2X/9n4dOQHSIkt/5yJbuCsZAoV5k7n5RmAoUAY9xulRUbgytTq53ZFGHJrtyiZNuVLhg2E5ck2Cu0rzgI/uOAd1qFuq7CFJ0ey0Cku/KeB8h17jUh9rxCjbBKXPwWCneXROZiDVae/+OEmS+SX29fe2ZxJivbENqgIOZZE7xY5xaBR/uYq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;6:+Omrg7+RGy1xus7j4ULTHYj8BMdLDSrqJU5xTvZsnplBeA2O3QvWgrS67PKPy9/Z1a8IdZgKI7AHpVjiH8Wo9d/CDEIMyc2rqehYb8GRNGCPDZarQpYpugrtfBpSlYALNIBYBGGR6NvbWxEKKLUqIYqIGKAJrk2JAYVwP9+iaEUYzxI15UFK/ubXrjhTA6qGedRpvDLmS8290uuQsLtK6HX5pfKHSm1Y6ZIxnkfp9VaFsqJ2qxwXb/HS+59uGSETUXfg8QEXwwL3tGMEW806/hT2SiqWIR0zb++YYeHvksIoqaSF3/U5h1IW/5hK1/hlhZRb1sduPiFwIhNAjGZU/tfgSeVrI6ATubZ12vwuYHa1JqUFb90ia/0gqc66r6kEldV21eu0XyjbQS0+Iujn2ngSC+sILSB/38S3iAuMYJ73eZ24OQ+10smDi8Hg/Ff4Cv5XipmcUc5yQT0a2z+Zhg==;5:FA+0UcPm5uYJeLwimQUt40cPn+5Pr8HyCChFUNJ9voyH/8G4eS0pDgxFF6US0BDqa6Z8n9gxQ1mFyVwFT86Uk5khukmLc+pq5riW/FT9Qrd4Tnla1KVJs/HhF+iYtq6xjuOD2noMf0kyMffnUp9/QksjO7nUo0KdN0PXobbY8R4=;24:HY30OdPkSJChW1mNXykKDXnrTqpkXv0FGM8nYZpPZvnt/OCQARwRSp49q0eLJF+5zvV2htsEiknd9eDphvWVxbuAeHgmddESq+gPlTpqj7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;7:cGO2/LRyvbE5E34F/C3w87rBTymzudT51Sa1DjoOFeOZx6nY9CcP9YvWJjYTlPjRc1JtDq4XtLxiuirVwUd/0tq1/PIyK3cOt47qZ5kzl4fRGADI6nil3zcvQq7iarlLEI6KhJnjg9+ehmbfsN95CbCYapLVvRx5PB+KkFYqOgiDbBb4ssWWPeotrwsfi6FAr6A7aTSNCZhdYgYMCBVrKvqlp77N8iW0vaaJWA0vxGS0bkehdmGfdriIGfpRKRBy
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 17:59:42.5891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70024f63-de3b-4fdc-7df2-08d590e7daef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a change in how command line parsing is done in this version.
Excludes and includes are now ordered with the file list. Since
the spec file puts the file list before the exclude list it means newer
tar ignores the excludes and packs all the build output into the
kernel-devel RPM resulting in a huge package.

Simple argument re-ordering fixes the problem.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 scripts/package/mkspec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

At the very least this effects FC27.

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 280027fad991c1..61427c6f220922 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -98,7 +98,7 @@ $M	make %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_instal
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
 $S$M	mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
-$S$M	tar cf - . $EXCLUDES | tar xf - -C %{buildroot}/usr/src/kernels/$KERNELRELEASE
+$S$M	tar cf - $EXCLUDES . | tar xf - -C %{buildroot}/usr/src/kernels/$KERNELRELEASE
 $S$M	cd %{buildroot}/lib/modules/$KERNELRELEASE
 $S$M	ln -sf /usr/src/kernels/$KERNELRELEASE build
 $S$M	ln -sf /usr/src/kernels/$KERNELRELEASE source
-- 
2.16.2
