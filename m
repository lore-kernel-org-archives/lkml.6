Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757456AbeD0AV0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:21:26 -0400
Received: from mail-he1eur01on0114.outbound.protection.outlook.com ([104.47.0.114]:26448
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757181AbeD0AVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:21:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
From: Jane Wan <Jane.Wan@nokia.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ties.bos@nokia.com, Jane Wan <Jane.Wan@nokia.com>
Subject: [PATCH 0/2] Fix fsl_ifc_nand reading ONFI parameters to meet ONFI spec
Date: Thu, 26 Apr 2018 17:19:54 -0700
Message-Id: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: HE1PR09CA0086.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::30) To DB5PR07MB1608.eurprd07.prod.outlook.com
 (2603:10a6:0:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DB5PR07MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;3:MikY4oiVvv1O2FzGBm+YaE/cBXFy+0HoX84RaF2Mcejv4Pg3Txnc64vYQmvYZZLbVGgsZ1NgwnefwrIOrOGu1iCCdF2mmSFErmgYa76nq8+2bknXFS+TfdW8RNSxpv6CJg1O1IMqXVd476nYJ3nfH6cjDfqSA4ApHA0nEui61rde5TYRhRDl0pCVTNY12lU5zeSHDRFmwS3+hF4FxGeC0vXqjJUZNwlusczvi18/Rkg/NHSkOM8zlXqG/uu+Zcnc;25:wOtQW05KmUBADYexEYCPJaI45keCmnqYIrff7FGgOxze8wRSpP2+b3fPcp4/F7ocBJsiGL9RYlrWB3/Z3QtfINvd+XAVyDo89Ng0XthT9WIqAPsPowQqFishJeFBborqdkWswGuVdBXbEOdYrWYYqOzkniToWXAK7Ahx6S9rf9Q5CmTa3NzFchUB4mnXB7kWboedjHmfHHMZ0/YDhYikz5HNEBjaZIu4PPCVl64HXppdrnSu7CFpgzryi0k+ift7rP2HBwyYhgBLgryn6gqOrHPGJi71NGC5nOxNIxFF+R77xoyYOF+zXtD/S7zAAXBJ2m96rjUDZ7MvtKs/Ko6BBw==;31:JjlNomDA3spI1U5Wsx+kAR2BvbUR/3LnawbCTWqBUJsHY/2x/uKwCIN8V4F53FjrCYKiOd/XdWSfX/iV9I68AMxWsab8I5aihXpxAEetrP74d3shbzg0Xt2yjE4iPc1dJtrmkxsk4XDlFq8BztapMzhFTPCmCLOBp3YeUxyt/WUPZ2WOTSzMqZ65MQkeTtJlkzeIUhdshLq5gOxZ02EDJ8zJPZdxQzHBcTNEFm4W0oU=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;20:Ga86U+6qzjdtINIwgX1fzJpPKvauUBh2LkuJ6DUtmEk4zQJJW0VwfJNOgSQ5GeufLXa8xVREXVFc1ugdHET0A1lMdrbUuRUm6c0VvNEVDJ39u6KJz1L9Ng4M0jyGvfxq4e1cTBtSii9gVVh9YI3JS1bInQSA53ADqPPTUB2vVt6J+kheYR8YASIpgdlqNNaZfGpK6nBr7IBa8xhvRq8mM6nKtIXhFAZRpINHFfaqtvXrj4A0vN9+nUk6KMgpaDNCF0KjAv888TymDboIlelDo2EDdZCmxlLoGeWrnK6LNsaoSqQD7VhzfDdqKyvtH2cfDwFJYse6oHNr2pPa2jx6OPDj6+WTvMxbbG3ojLDO3Zf233vFV51cUK/U1Ye7jf2ApmvtY6alVoY6Wvz3tyTuOLNIN8x01pi7bfAD+BFjgMuM1Y3V2W5h3Myl5ssPzULi1JVbMu4acSV9lCdSvTPkdnRt9XKVPkVmUonsarjs08IwhKd+YlbJSb4t1Hrr9yQq;4:VL4bKKcKt+96tRntf1Vr/EHL9gNRHDUffHjiqr2alJjDhGUipGuEdfcby473I3evxRarpypDyEegdg18sBLVXGpADVNPY6dQAwLrMuKffXHdwiUBbfcWsnhxBmEiY4NMnpN9eRibbnX7PkXintTOxtBpEtpG6NBl5G4/CFt12L6hNvIfZcBqArAY881I3+6WN+J9aSLoIdtkDuqFaKXrg/2m7Uar2LpASlBl0YqPs8izc4qpW49s9qbYJo5AjqC7WfLbnqdN9E+Bm7BIwi5rWw==
X-Microsoft-Antispam-PRVS: <DB5PR07MB16083540ACEDE4A1269BA679818D0@DB5PR07MB1608.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(11241501184)(806099)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1608;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(8936002)(316002)(16586007)(956004)(6512007)(476003)(106356001)(105586002)(2616005)(48376002)(50466002)(39060400002)(107886003)(16526019)(6506007)(86362001)(26005)(186003)(486006)(52116002)(51416003)(5660300001)(478600001)(25786009)(386003)(68736007)(81166006)(8676002)(66066001)(47776003)(7736002)(4326008)(81156014)(97736004)(305945005)(2906002)(50226002)(36756003)(6666003)(6116002)(6486002)(3846002)(4720700003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1608;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1608;23:Zs1tbGtMMFmf8Zznex4lhM9dxxZEzSSpbH35yUJNI?=
 =?us-ascii?Q?YU9BZEOb0O6sILkzhmBotvP0hsh3CpxH1MH5jbQKBhYeI+PrmAPZ/OqXK7SC?=
 =?us-ascii?Q?RtS+OLLXXbBJN7xZZonRkTQmRYfigX9CJYmFe3u6JgbvIvl1VKAg4F1JZcrL?=
 =?us-ascii?Q?Ks/RDnEOaj7n4zjk1irC/TFbyNKCvCW3/hqo0oOICKMLiWr673KeBHoVRjVT?=
 =?us-ascii?Q?U5gzFaR7XRCkKDZOUzF7vjqVXAIMi44rweF8U5deq/H/ZniEvNGPce6hrb0D?=
 =?us-ascii?Q?foRi4QZza7uRLNlhaG9ns1uuBRPIGiMszelJMxILwbIksemvYLep0H2CofmW?=
 =?us-ascii?Q?ilenv2clg37rgcg9DkYIXfRh74AQjYuI5IaNpN8c6jI4ObLWpZcT6tdLCvUc?=
 =?us-ascii?Q?/BM99wS8BvlSD9ZCHqAwA1oIO6Pr7IEL2kXeGG9O2WWcDouYoO4MyOnSIq27?=
 =?us-ascii?Q?8Fl9Ds63Hsm1/m8ekmIlD2ZslI16iOJNqDXTwcOVAkU7quHf6fstd0ViKHrc?=
 =?us-ascii?Q?A3RDZSIPAW8hFfZStuxd+qF8068DENL0AGeNDk/k3MTk16Fapbbkvo4QiuiX?=
 =?us-ascii?Q?3yfcuKz1WyVhLA78YqSS4/fNxLuUml+CFF/BMxuPcgTegm8mbwyaJeiBoSQU?=
 =?us-ascii?Q?6SkskyT2DAzqfOIhZ6Nn+Z8dyG4VQLuUgCQyGJ62DibvQ1fsW+x7b7MoizCK?=
 =?us-ascii?Q?hl3YMJ7hiGbPa1aAMe3PuPCWgC/mr8ZsV9y42kObRvqOtjYrVPjd5zUnV6De?=
 =?us-ascii?Q?UO4yEmjA9CWr3bY41ScXGpkfcunhv4o90Jeu+jOUAZwJS/z5eKb4J0k6vZWW?=
 =?us-ascii?Q?Qkej597+LCMyaPXD0KOKoCNYQoOB0kfq8b2m7DNbbvEJmSUJEVJWB5XLe3Jc?=
 =?us-ascii?Q?oQDom/KwmRuORfTyCvwwYNkKRqDMbn8Ur3YJqhK4pNcEQ97du+cqZtJNuFBH?=
 =?us-ascii?Q?81M7l+D10aB2NLoIz34NWKRyaqHxgJHwH+jIICnus9mO6j5ceP4kZPPd1b3v?=
 =?us-ascii?Q?SHOfiYqDaN1kd5QkgYNdawedK/9wgliOVtvzSSJusfL0Mw/M3saLWYpmLJnO?=
 =?us-ascii?Q?/1jVaWwMSwZmjyaumW/Xc9wwgKvScCO+cpBQuBqE1qbIk2vjxz8m/zuuC09X?=
 =?us-ascii?Q?bIWQkWe/D1WG0T3gsCP8jl4LH0WBGR5gzjSWt0W3EgpNY3l0jvOKvUpghyx7?=
 =?us-ascii?Q?lvkDaSkayQh8G0=3D?=
X-Microsoft-Antispam-Message-Info: F8AtqN2cZ+gOlvlEJstGlI5DBjF1H2bQ3YJtRF+Ld78DENw12CIqJyQXGlvjfiZ6A4qkkfS37A9cbEoyRN0l645rZACtieSUqWayitvjujT5DHjyEYh6R7x2kFXIaGKjpMY8ZM9k+lhSE4vQbfqLFTk70Qa4tYlqx6J5t3PWlsTAd7wDy3Ft457WNJY/B39QbRx2btpuNDbcSc5nfNYv4WIbE5TAV/b8eLLkjzNV/6Y=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;6:Ztc7pvOaUGmb4hHYyDsJEBKBCQfYpNlanmcoXm0JQfvs/2iT0GELexP8eBiHJVnpXIROoHo4dlf2XbPKQ5Do7R8IjD4idVdHgnzA/wUBgibDFaTk0R2NeDrT25Jq7qightGT45Q5ToS1oQTamsuZQGgLjvIDJJ4V1ub4uHGXUiqkG5n5fdr59Hgn8nfaNYVrfe0uzHIg94MHBV8gubF7BXna3LsC18tovNoU6ftpORO6JBepklrkxny0c804PGwHW5u77bGSxI7wv6aZLDaeYDFc+HEiW58fQIJNuFKbffm9oCvlmaEIXSJwgQsefSJfJzlWR2daaXtpz48bBf4RdNz2pruk82ftqfyaVeYmnP9EJTtR3P8T3nEsoIPBkzYkfr/sQnyvVnQLb2bFjk3RJd+qTRKOU4zt3er0YlpDh5ieJZ1gSUnd1toSJ/o5ibaPlB2B0TVvbcQ4gCxEIBx7iA==;5:XhnRhcIQygDPDqZDViQDcQoaZYNv5257TZfQ60airyvKArlxMnzxPrvP/UFGmLXkeJsx2IqBElVcGF8V76Oh4oVatiYeysVleKdmyOHKAAU2e/zbhdPfsrt+c/NGS+ESGaSJr2qE+TJF20sT5FqGfswbSsM56/vQX+N0wUfokBs=;24:eGLFyynBjARnApXxkOFTW5n/1snQ2+AZBdRvUyDaYfK2AgYRsO6pKv43ImVHB+2+8J1MKvww4D1mqQEjejBdQK9efmP9BFz6Fai5U7LYtoY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;7:uGoZ+hdjeyk29KMzafli6R63UI9SgiQIwJUHPkDNvZErr46CRv8XA9JcxjBmXR/a8sky6Dslj1wNvppUjqKR9ODnCms8HLWD5GC5CjhKjUL/+DOWDuVqaOPk+HueQkeghr5FJkvlt+NvikA/yXjZUki6I5LbYatzc8xYvtkGmLmlzwxRKID87VqwM55RBCu1aS6aARz/N2QgibzmErezFS+GXkBNYyy302xUA7eH2ze+/gKyb2Hj4gtwywrn/DbH
X-MS-Office365-Filtering-Correlation-Id: 412e4722-20cc-433b-1401-08d5abd4ccd7
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 00:21:18.1481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412e4722-20cc-433b-1401-08d5abd4ccd7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1608
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if the CRC of the first parameter page
read is not valid, the host should read redundant parameter page copies
until it finds a valid copy.  If all three parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

The FSL NAND driver only reads the first page.  The first patch fixes the
driver to read all three parameter pages.  The second patch is the change
for using bit-wise majority to recover the contents of ONFI parameter.

Jane Wan (2):
  Fix FSL NAND driver to read all ONFI parameter pages
  Use bit-wise majority to recover the contents of ONFI parameter

 drivers/mtd/nand/fsl_ifc_nand.c |   10 ++++++----
 drivers/mtd/nand/nand_base.c    |   35 +++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
1.7.9.5
