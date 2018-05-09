Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965932AbeEITsA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:48:00 -0400
Received: from mail-ve1eur01on0095.outbound.protection.outlook.com ([104.47.1.95]:38915
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:47:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: viperboard: return message count on master_xfer success
Date: Wed,  9 May 2018 21:47:48 +0200
Message-Id: <20180509194748.29222-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0068.eurprd07.prod.outlook.com
 (2603:10a6:3:64::12) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:WpUGilAi3xwZKNq92pDyh+sFxwWknjmNfpwDXhq8l3VpbaMRlaZTnUJ4FxbyZdvX/AfAcVXJpIrkaJ/ELfV9QSCb7pcIcFy0tpPattewpDFkTxmnfavj8gWLXBUMmv2CEUoDEiV/hoTTvdIHgI8uGyulq8jZm+dnJOrF3L1/1n3Q8Vmi9Au/+DNSr9UAsLKkbOLowSF5Sb6quf2RC/25u8fCmsu2h73lzdoN6gtNJKUxvID6DK2g+JVBf6t05y7z;25:TW19zVkN9FOmWE891c7J/9MnvaM9vDoD+4b9Fw+DNSZzFbxtQRCM96YcSDv2GP2dp+JECDrmDz1pBcpgjCnVCIAXsj5E9WZRlkRpaMB09vn/uJMnIBk5ezFYopUScuO7WLFWcx7o5Un/rh3wBhBVGj54i8kRwKKdNL85+9MdyfymsPDFAQinAC6vhOiV6G85us5PBsy0ehQJ7y1BOLggictmzEg0SJt5c9Zp6fpykB7zS1MlVFGavjeKdkGCfY4pnHJHldfmWPlUA8EHfhz2sAW1fv1w1AJzjjR2eYcNsVDe9klyJeu6fn6UeriM5VtMgBxbKjDS022j/+XsZAfybQ==;31:BA4lUeMwq4Ar9AHNfqkbPYOshSSr/9MEF2olniTT2OrGuzkamuhD5GWvrZTagR7ecjzxSQiwANb06oPbAqlAUwVWvi5by33WSJmh8435Vu/597FV1yYOuamuMwC//9aZ72tttHd/zuLKno863hJsoUdZri1BCqKgRPlIf7hlcK63pBjGt5s/bn1pVbPcyEwFdxuC/kvMir29imdaLUZxkRJ98QEH7B5yiGWBESC7OSo=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278206086A6EBC0CFB2DB60BBC990@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:JbZbMUE8Axpp2lI0XpCHTCO2+5Z0qb5Pjn0v6IeW6qX5ud597ZGJGpEnTGtvl3ELrwb0hpZQ6XbjV+8bfApGw81+WgXDs+hfhASwNOgOGD/ZRyhiGFdVpom/FJ7JSVjjAGIba029y9xrlkJgvUzbpXOSWRpt0fp28j9Whmei4+pHWNM/1Q+DYhDQIwGZ/3GZh7FrvRmgPjZ44N0NiMXLRxhG9aH/dSOIzDNkO6zYmewi+qxKE4PvNiocVydy+0phWiwKdRDa3xuegczCk8vbGw==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(376002)(39840400004)(199004)(189003)(450100002)(26005)(2361001)(956004)(1857600001)(16586007)(86362001)(2351001)(68736007)(106356001)(386003)(478600001)(6916009)(25786009)(66066001)(2616005)(50466002)(2906002)(316002)(36756003)(1076002)(6506007)(3846002)(6116002)(4326008)(48376002)(105586002)(6666003)(59450400001)(97736004)(47776003)(8676002)(50226002)(186003)(7736002)(16526019)(53936002)(81166006)(81156014)(51416003)(5660300001)(52116002)(476003)(74482002)(6512007)(305945005)(6486002)(486006)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:F0T4zx8wkDGDmg3IAE4Di4fGO+H1MiDqueL6GTw?=
 =?us-ascii?Q?9ZjoqaBjHxSPhaeWnP6LTLHzV8G5EQvuTR0XOLZt2wVWyNbsOrgUG7kd1c1d?=
 =?us-ascii?Q?14LeJPTQrE2unls0PFbM6nlIJ3KAnmUQr2suYS1RXfeWSewx0UyOxAGWFf57?=
 =?us-ascii?Q?VqXerQMaimq64IwqOt/T26PWJWyoy+PrNZegl0CEZMAGlYJbLxsL8AfGHfG4?=
 =?us-ascii?Q?vnun7HM+1d5nRfn1Xm4N4X9xDFqN+iwVTg4rNG5SzpUlckT0NvdqnVB8rca1?=
 =?us-ascii?Q?oFZKrlwjKohbrY60d3qxhAxCXu8wupo27PNfgOiTQipEGQEoM/n28Ei8msH1?=
 =?us-ascii?Q?aqCSqOaXfYDPzZr1LIffhPYqvtKzLVEgkwg2Saw5LSeM1iqxK6kL3+R/QTxE?=
 =?us-ascii?Q?f057YF/15qMElm3Xs40VQ38xHXid5C11k+4wXBqOXyq0/JO1KpYWx9HkKsXP?=
 =?us-ascii?Q?rNHk1LtyeIHJlHc6y9vvuaccNqTN7j8nnCKSkXHpmzHTTDQPzZBcPsE/rNG4?=
 =?us-ascii?Q?bhzHPxGajcYoC3URH1JaQWIL/BtSvrYreSjvwxcL1ykXdQKnktJiPOEsT/m1?=
 =?us-ascii?Q?/ZUCy3X19XgsOVKo39sMNHmtZVR3Cj1GrBYYAOuU+r3T5qeIWwdSbIwksuqk?=
 =?us-ascii?Q?Z4cAne4lBBoiBin7brfIUicVhi3Kl/11U+CfEFHQOnDQSoG+ACx9mrz8/l5m?=
 =?us-ascii?Q?TKWvdBRedQmMVGaq6WbV4rizyv1WzxBeHODVkrXUoBf1cHDaxzPVviRtUwXc?=
 =?us-ascii?Q?I1UJ7wqE2CdgA/UcmvRWEB0jGB9kamB6YbCBPWV4bk3i/mtR+DfRECByAi7r?=
 =?us-ascii?Q?mf8qaPJ84F8oHtBbGkiMvvHrb3uTHLZS2RwHQrttbIkRJf6yFqmodu627Zre?=
 =?us-ascii?Q?+TyBxQH7u8AmzXCGz5n7I33+ZLTBcErfFnEXIKiC/LBtR0nWF1DKErd6hDK5?=
 =?us-ascii?Q?hdIcd9pwEkRlIceZMoAnf6zZV5NEWDICM+LfveKNwYa9/4PyVO3XxyR+UVL5?=
 =?us-ascii?Q?e7rxjg1zbqm4UgMgAjwE6C1VxxfznOAbfaOvTtlfj+V+W9hJctsy/OyE8xQc?=
 =?us-ascii?Q?qJppcbdEH7Gzxw3x8bkP3Oc8TmBDvpuiqXsONKO6vORlqFsuFxA6X8yXzGer?=
 =?us-ascii?Q?H5E8TOMqSD8vlvndW1peS7m/qkO7L1WYdV5d/g7qtEBrE93znVdNf3FkLowG?=
 =?us-ascii?Q?sWklvzpuP0ZoR2CR43E65rToR786/Pvfr8r0P2DIh4dFrLb1f+QIicQwZJoR?=
 =?us-ascii?Q?lAdf/63LD6NVCICPRHmxf3Gdjfw8GC/2T3LQ71qAjWZ0spzKemvAcxh3EPaz?=
 =?us-ascii?Q?eHw=3D=3D?=
X-Microsoft-Antispam-Message-Info: W2MTwtSq5v9yRiIiyx2eUbjpzoTNtWSCg8AwgV1bqxOhw83tDYdpAaMZHkMGkqkPQdqZIlzm0n3t3hWbyWFmZXc8pE7ISxdbMs3OrYPYw2FHsZpZKrU5MkPObLIAjg9OtDBkclYgWZ36dS6LAySJ7bX7XFXI+p5+SNfBpRJitQSg5SsJ5mXb1lKNOwEereyU
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:B90FAeE9j4cYsnLl9ub+v5WyM2pIYPimdYd9zWTYoCp3kwashVYRXImEu0wcKdAGkFp4G8Od1EUfsxQp9spzyt7ctHHKCsAPJtrfFJ3o0frjlg2XxSEZdA+owblFBZ9cHuLYJVmB7aExdKAUHOQfiBjmDnd4HhIwPQ7RypuO5iJxE71xBpb/JosmcIrvPwELw0ms/5wLp4fZN62pFp9UZh3AuCrYs/yMIB5HpBt/Rm+yOMJkG014vkV1JY/n3SlbVKI/P83jFf0pdFtS8Fyx1JXosaez7sgTZMwlnEaNvZWMDKxbniGPOwVUPn+Og7nGzOQ84JGDKWNk8fNgBzUd70bPDEAd84T9Kgss/Y4A19kpgCtoootWt+yGfvI0s0wrCTbl11VWJlX/h/t04IoOQxqnQOis9TmBWrqMHHGp5OZrKvPJiV7QXQZchwbLWy74s2UvUyw5UHE5y/iX5LVQUg==;5:Uxxo+hXWiRF+NWxxxM3OgltMSPu9ssQd9toJD/nnnBUP4A1vFW2Gp+0NEvqtRmYs7oCts+frcUKIE8wOFv6pgyb8HIlGbHVhiTnPtp7GdlluJrw85jRFQAgG4UDeDShaiCyqsK4zxtiiSiqEupjzwQjsOYnWQ2RkK5APGNaDFmc=;24:SbEEuus7z+eS5cG08bzA7gWxkDsK3h+2g2PI5stL/dtE5Fpyp0uTQM2riGT8l7iRLn81Pz58QGWyOGdOXbaX0c6GShmXe0jGkTKSrNtMhFI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:g1gxYisry0QUfYKqzLKgDMfyb0MrzC/k0191d1VTc6QUb9gh7tkTmdSgeKmk4Lrzfh/SosrXF9XxH6zfShyFirnPztYXFypG+LQumT4kjpU2RztnEdE1FMu0Wop1pD14zYjh0vlwwKCPfJA4fVb9/lRH5Cu2EStW8M4I7AyTzd0gb71Xs+2JZ1nZkzbGfTf1foN+WGoB6qK+MmgVoJfEqN25SCk32wqiluSw66GH2wIP1qpsp5hb8OFn5DTAtpxI
X-MS-Office365-Filtering-Correlation-Id: d040efe0-31f9-425a-4b7c-08d5b5e5c20f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:47:54.7744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d040efe0-31f9-425a-4b7c-08d5b5e5c20f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning zero is wrong in this case.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-viperboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index e4be86b3de9a..7235c7302bb7 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -337,7 +337,7 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
 		}
 		mutex_unlock(&vb->lock);
 	}
-	return 0;
+	return num;
 error:
 	mutex_unlock(&vb->lock);
 	return error;
-- 
2.11.0
