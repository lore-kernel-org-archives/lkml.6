Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeBARZx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:25:53 -0500
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com ([104.47.33.79]:47136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbeBARZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:25:51 -0500
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rename bitmap_copy_safe to bitmap_copy_clear_tail
Date: Thu,  1 Feb 2018 20:25:08 +0300
Message-Id: <20180201172508.5739-3-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180201172508.5739-1-ynorov@caviumnetworks.com>
References: <20180201172508.5739-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [42.107.64.135]
X-ClientProxiedBy: DB6PR0402CA0014.eurprd04.prod.outlook.com (10.172.243.152)
 To BN6PR07MB2900.namprd07.prod.outlook.com (10.173.28.146)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43077e6-73c4-46a4-9ee3-08d56998d635
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR07MB2900;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;3:TV8K8JVF4tfC5Bc+8oiMw6/b0Hs0/Kkaivr6zlDX51h2/CVOK1T1zcZVm8p80mBWIbgZdRxIX9sAWUzicBTcSm7Q142Ud5oOm7SbcSMFIK5DmY9s4uEvzGZFdZ9U0IdauIYLQywNbYK0f2Ygb9xCxBBooLXtXQ70f1Bc7o+BX0hlrI4HADPwPOpETUNsxUjpHFu+7EJVpjf5gdDI1eKS8bxv0Ab4351Sv8AT9CJG/VoTpPNXm+Cs9btRXOts7XC8;25:fn2IwNPS3CHSDMxnpQt7FEzA8lGfajHA+Mka7sfZsLAs8g2lHKHCz5ImVVf9h2GM6tHkj8V/Q+eB12hnJLyf1/x6CvYJywa5y2k56liHh+zhxkHXeZqFekt+ThW1jy0gX324VNb5L+MkWx+diFOrfu5S51Laa6l8YWZjhb2fyZuwRxwQBE3P6Djp1CC43+L7m3stOgp7iGxcovocOd/M6bAWuvtQy0agHT9i6UzlHYueG3h7dLP2/qItkNLMS1JRoUagcZdh1Mq5737oWpc66prOE0zPG9s66AyQ3m5gYfbd4xYKtKv72fiUNRchMIniuTK2bZcRt5lcak2zjGxXTQ==;31:FHKH9c9h3QwiuCS96WpqWIiVSjeHyWYZ/zjzQgxQsHjc3VEzSrk6t/y6Ak/sMXl18OE8EbZVOZN/HW/sWySEt3vxqcuPzrJpgwpPUV4VNLszAFNPPz7XJ3IklsZiGLt2Te7fge4GdscWOll/+bXSTv+iL7Fm/8zezC3U+y4bv6pd3WU54mbchPDjAtQ3z9cRvRUJ3g+/UX6DXCt1tPMMkl2/CYQIeAvoQGCUN5NVt8Q=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2900:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;20:D8/oKlvAvgy29nZhpHsDGfXlTcPPJDYccsheL8rXQ20drIxfHyNfXDWvNJiJDAd6EkhrOati1qf805lRgp5wIsrM6HQghFpVQrJnVyoRyGi/Qmy9kJ6MBEvsTaBxXEze9kheynb8zOL75B7LCadOi6wIRG8VttoU+byL4CHr4O8/2beOvlNEkS8E3iBHloM8cYFWIHlSyYHbNMEdRF7aenppPOGHgoc6DR4PvfiOSoSejpWH99/VaSYJ/K9OKLr83XYYFNTVZz/RMcji44rlqA/9wHfv+5UpmBzwcufYIWusAL7UdwMwc/zF4k4FD5ucQluF+NDLYdP2nNTAD5ag76YNLirbl+5DPnaBPHpkhmeWh8v3VRzxgeRFwpdZkaa1Mrh/lfal0vOzbjoLoX1zfe2qTGnI4CnRSoeOythFLH5+Qama+INlnzBDcCzGoF+YMyitgxCeOqYagU4DpS1UusGZ7DzBwY5nPgRdzWfNkBgksvV/V802fOXCL9/LFMts6mPD5oNywynKz3oxClZZ0YbkY+WV+9sQ8I2Y7VFS3YvMGWTrSDQHQpbcL83rMmMCt7ax7AeWI93msv2HHnc+OgO9XBxDbI9z3LHkeqbIPsg=;4:uMvfM9sGcI8my5/xAr7HsGyYUQ0UOoP7Sx+bnyWUoF99o4FwI2dy5wdq+mmsmTyGn5m0WfmA6s84/OMpdwJxL/zEpzWQrJc8JbGCY900lindbbdUxBlLv/SjQcdabV3baOrKQTSjjiUuwgmUklVk58aU6t3CPm3RNYgnDCisc1NFO9OCncnxSDnuBKk1io+4mGu3cEIjDN8rW4iiIQbejKrjLfYvNXPQBPeXKVuxKHovXgs6H7pk5ncK4OKit7cLpq3sByqVdK8KMJ14QwwhnA==
X-Microsoft-Antispam-PRVS: <BN6PR07MB29005E67797A4B71367F61B5E3FA0@BN6PR07MB2900.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231101)(2400082)(944501161)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR07MB2900;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2900;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(5009440100003)(305945005)(575784001)(2906002)(7736002)(50466002)(48376002)(68736007)(25786009)(386003)(76506005)(8676002)(4326008)(76176011)(50226002)(81166006)(8936002)(81156014)(316002)(51416003)(52116002)(6486002)(6116002)(3846002)(106356001)(72206003)(53936002)(16586007)(105586002)(54906003)(110136005)(6306002)(5660300001)(6496006)(97736004)(1076002)(2950100002)(42882006)(966005)(6666003)(26005)(47776003)(66066001)(36756003)(186003)(16526019)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2900;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2900;23:79A9/mTbLLL+BuJI53j2BGN9KhHYguttw3iM2i9nA?=
 =?us-ascii?Q?ZrauvV+YznSY8VA9iHSPEqka2Z2PcWukuufH+Sjglpx4CgSLNtJRRkkd0v01?=
 =?us-ascii?Q?zpT0iKSUukSqcu3EfZsW1esrDcyf8Cv8wv6t6qqRuhfOoujJcXV97VW+ulUq?=
 =?us-ascii?Q?rYaf16VUV2bABKflxXf52UUlFADIxm87InNYkDEOksonQxgjH11SSpLMyrl4?=
 =?us-ascii?Q?EY+Kv6uz78eQVVfjTLS5GVw0zW35oma/M2ElbqxjWcbLmRhPD8etjZDAl1yM?=
 =?us-ascii?Q?q0JWzqPeo2AeTCIwfQnq3t2RlJroDCNZseG9awbr8tcuwuaBq85slnrPtmNG?=
 =?us-ascii?Q?uBG1NXvFo53AX5iY5RbAoezSYta1eX8/8XCDQYcxtlMtekzoGFPv5guK/Lvm?=
 =?us-ascii?Q?/G2sGiQmNBaNQFsVXQ9no4VE+qEPtqZOBcavpIx8d3jKZtJXL/T1l7tSySb+?=
 =?us-ascii?Q?5/RwZLd6CzPwFtld1/t1SijTGJUxbXBRmgY8Ltg4LBj5Wc4JyoP8PgCy9nBH?=
 =?us-ascii?Q?FjGzmVcpObABb1+y13FbyCttv+xWMimzeQ0cKzoD/pUb7UgL6aAkVhyY9I2q?=
 =?us-ascii?Q?cXHuBrdDF/NMWIMouAwYUk6pIdsvOd2RoLxr9OMdjm3Ze+fgg8IO5U21mMJc?=
 =?us-ascii?Q?YJW62uRNGwH73Z1NG+ex+cnHxxPcR/m/VBUfBvqD+xwQL83ZIsn4laJGWPcp?=
 =?us-ascii?Q?kh78kYRUDWoSr+Y/Lq5XmK1MJ/iQ4WGp6wcUM0RhrnFD7F/kzcPXv/wCggOV?=
 =?us-ascii?Q?xOwdVDic+KPiuj0C7zcBLDzB2D5P510+alCKlUsbgEE/lRQ0XnBK4Z75iMRq?=
 =?us-ascii?Q?028amR/ChRLweejbTVBxN7qXCBMLUaWI22eLhR/fbtlOd36MdPAvPCWZsaa8?=
 =?us-ascii?Q?DV9um74o9m5PFBsofVkNgAUMBq/71YPWdRLzm1Yr1pLoqnO4ERlzlTQdhYti?=
 =?us-ascii?Q?pjr3XkeRr2OdbmHxo9kqd9Di07g9ktjnpnGl9i0AA+vCECxGWjOQ7ljaTp9Q?=
 =?us-ascii?Q?KcJ4o/e6J4xXkK9o5YKBbQphp3kjn12XRXjbNdLB1leEYoLCe5GLTWESwQrZ?=
 =?us-ascii?Q?aZUphcu/7uqSNNlMXEd+PM5c8Hj3PvyULgGcMEyQz5IBm8n1NPQGpQt+lpYn?=
 =?us-ascii?Q?qQ5HLdYViD6SqriQXGJ1TrIXA6ZN/0XPFO1rzUptUC8RSzMcbkn+sk/lKYFK?=
 =?us-ascii?Q?DP8G+8RIsPkzB65wVlSPfeQLVTgz8RRTF80YuBGL1G0HFZfEOOz0f2kMzxCK?=
 =?us-ascii?Q?CxQVDNPihRj9uITCfDoU8qtSurlop2Yn/M/jM3j?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;6:mvtR/ga8NRpfLfiVzMbRHlxXqTiPqURDfzETR9UfkFMUA61mABkNhLZaipZZz4niCqqYe0ulIj/2frfa395Uftk/qbnpv5LPldmoT64EYjMFthjAiLo065S2Hw1IHx/sUktTIzf9GlabL6IjEEtHfg3cb48dopzxU9V2SRvx63nSQpwZiHDhsbLXHARVxWcQ0OLJSRtUu7I9331BJ5NTL6QWXxpqYgc7/gLxhL+Q/9u6vVNQmshKep8gJjNl1dsC0yJPfYvNzzOW9cQRA3f4Wc50/ZL2ifhnJ1Fc+BdiBEphoyA8RuK03on2p9gLSfQgPNC8p4eNVA32seF7TC+1htey/+A3urJ5+cLPS363J3Q=;5:w8tidBpl7m00eWf6cnUTQIji0qSjNnmAY+2NFezIb0jG2n3HlkP5TcVOO6iTR9+IpLqacFPXWG3E+T0C2gOR/BkLLx2qZoJgif/MlDU6BgLa5YPNgLRDBhAo2dgt0UcXSNz9zeZk0eI4/33j/n5+RMzvlO+QZHqUvQI+FeluO8k=;24:gSeLt1iFSoSc0L41YiYbCCMVYdQ4EXUnKjCTP7DIFULdyQKAaUEqFXsWW81m1SArw1hcvsYTwe4V59bSsDH+kkMXU+w2EJvtEsgnkrbQUgo=;7:8Rb87xfiP9en4f0fjC/eNrEfGGJISpvW7QSBFjY/w+hf4zJ7xloOvQQ+kXmh2uWe2EoSRGWwhp5ndlGhgLMbv9hhi6Y+8FrLMTqnvdwyiPlng6jOyQ3FlPb6YExL8Uzx1XGuX9ELdGV0RLL0TJmkLZ0b86cMpRrPBwyiQqXkFLMP7PRcXWlZ67xYUZZ2mnz1+uCj1NQAFdbtlxnjEDOxCJnmFmO6pcYFjOUyu/VvfARSLjZIIFMYM1+nW+xQaiIV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 17:25:48.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43077e6-73c4-46a4-9ee3-08d56998d635
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2900
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename is proposed in review:
https://lkml.org/lkml/2018/1/8/1052

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/bitmap.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 49aea0b37994..5f11fbdc27f8 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -233,7 +233,7 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 /*
  * Copy bitmap and clear tail bits in last word.
  */
-static inline void bitmap_copy_safe(unsigned long *dst,
+static inline void bitmap_copy_clear_tail(unsigned long *dst,
 		const unsigned long *src, unsigned int nbits)
 {
 	bitmap_copy(dst, src, nbits);
@@ -251,11 +251,11 @@ extern void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf,
 extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
 							unsigned int nbits);
 #else
-#define bitmap_from_arr32(bitmap, buf, nbits)		\
-	bitmap_copy_safe((unsigned long *) (bitmap),	\
+#define bitmap_from_arr32(bitmap, buf, nbits)			\
+	bitmap_copy_clear_tail((unsigned long *) (bitmap),	\
 			(const unsigned long *) (buf), (nbits))
-#define bitmap_to_arr32(buf, bitmap, nbits)		\
-	bitmap_copy_safe((unsigned long *) (buf),	\
+#define bitmap_to_arr32(buf, bitmap, nbits)			\
+	bitmap_copy_clear_tail((unsigned long *) (buf),		\
 			(const unsigned long *) (bitmap), (nbits))
 #endif
 
-- 
2.11.0
