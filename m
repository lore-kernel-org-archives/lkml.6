Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELtOW8pD1bTZU7ntSgtPRfOJuS3OJEBEHEJ9bmTQqXS+gWlldoWhlqEOqurgIJlyCq2fENzb
ARC-Seal: i=1; a=rsa-sha256; t=1520358248; cv=none;
        d=google.com; s=arc-20160816;
        b=oUBxb5RZQx3pzzyNlrLDFdO+d23l2rFqdD/wR34JDiZ1/Ys/k78pcFx19FxkNdpqy2
         V7xw8WIEf4TzUcFA9BkzqiS3FRAQtnd0ZE7SzO3Wwa3iVbrm+S4YyV3qBMcuxpHbtP/e
         PqGBEa18qB6w3FnANnOdjtS+vSZbAbq4+FfaBv8JHfbKhX6Pfw8DzmfKxI1mNDHc+oEZ
         ws205ykaxD1nu2sWGnyWPugm3uiaZmYpMHJ+Eel5RX5Ywyv4wJahAmKg4bu6YY5ZnEkR
         XaF1Zj0z8jneQAx/wf0ShNk4Awi9T/19IBYdTjaJPBmBhG7VuDyonf/oQ4gjwyxMrxe6
         l0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=N5xe3l1n7zJmh7yTt0s1m5GSPZpgnLusQMJos7UGZi8=;
        b=RKvvV+QawYp5di/N2IixVZsjfzy0dKFQSUSoEZTdmGFrk+tHUXpEOo9M2Jk/gFeuYe
         kJ/2NqvZ5K0XeLNkwBfKcECCHcJNac8n8b8W+fOiV6N7t/SSgA9+CYGhqadG73uiQEo2
         w6+VvYsbALFhUDbiIWwLDtxYKK6A0tsP5gk9amaIMuGmhwR3vl7pHWO2uBZjy1fgB7v2
         olSYy6cPcpmijiZJtTxv//iSccRgfjIYVDKZzN6oRG0dNjlHtUUe6lJKzplAOqvAl/eY
         4xyM21EE2jEZNzBqVi3DirkHdPtusJYceT4pqP/rCGQZdXCqjXS9acPhcZTyVpgQQHyj
         0bcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=vqQG4z35;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.70 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=vqQG4z35;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.70 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH 0/5] staging: fsl-mc/dpio: Fix sparse warnings
Date: Tue,  6 Mar 2018 11:43:43 -0600
Message-Id: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fac24abb-99ba-48a2-fdad-08d58389db3e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;3:T/P/t76jgEJLenEUAPS5R4Jrqhp30lsbFHDU3KCAO3IERdgY8POgPMHD2weoQ983K1RvIde7I2eQToxYjbi6cVzCuXhOnGTzMfRpnwMqWlpNJUSP71sawM9SceGsYEjSIkZo4w7Tb4PJGrO1gFJ1v72YD6zHqI8JIhEIwkuBUZ+hO9kAHQfPZyP9qo8izgweAUVIGR81MjwP7SQsnmfD4ezNg7pAwskSve4CDYgwDKnejLhG1Z4Rr7id2ekAxxTp;25:h2/+SOQ0KCudriyCyi5JqcpBcctRyqdFwMjBOH3u5VA2c2y+UfZdAhJiPS8hpA+2ZMWwyPvPErd5c8oIFhT/vbreIb0xrtDWuVzrqTfS0h1FG7Fv6ambli5JKwgFwhl3DtbrxpGUYAtBWzUyWq9vtEOrGlFKwABTci7VhO3f4xFG54roiGAxOjeNWmgvUA6FAvOrhO+Pa+a5rsvxnBvQzkRSOfrY4MLJXg3d6Svw/6JPkwmcpY7jg8LI0LDH2wKApSYekqDCYEm7v8td41gLK1n3h2pL0Aaz8QRrY/TvDB10c7djpGoVZeHEqwUVGDiJ+CLfQ5J7gb63/JZBucgfJQ==;31:szW7Qy7dgn5ezjrP1swdgo5FtYl5F6M2SuHdZs5FnGWL7CntocgaHjNTndN4q3RIA6J9XVUMcUVN/Yw/I5KSGPXeyNrPzM2gCpcSOEllEjbRZgI/jA99aEoqZc2EPC5r+N7quvDqTnfojrOecjeCoqmxlBzblggufP2VrDNMHCoRNKkeF4mzZLCBA7agp7qc4jsHMfIQPg+UWk+rbrIRIMcT1PyeHdaJtlPUf6xiz6c=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;20:uW6vsyrgKyfyXYDiELYca+14PZ0zcbW4wCKKoAVarIVcJciBIxNBpTTy/hgFnSkvsifVNvW6+jTbO/2KOzOSklU5wZA0CVqHfkVM/ujp3PJeAsN6LMyB9G5OvVIKfG6wkJ/cG6ggPgFUib1q7lXTKhc8Gg4MuJDN7fZ7wNGG+H/UIy7vs9HZVklEEFgJLTpGZN4i9CorWIMmalhiYc+v9GGSCAw+htpAlEXLcjczX0nq6sZqseHbOyYy4YwXL2zZf93cLbyw+xf7nNstIs4MaVT0KQeMmHW634vEd/uulJjc2aCS5LQpMgKzT45ELr1IBpGalxFpOrihW9N5LYeaBKXY8DYxcIYDUvKBnXYxUNUTQNjcrpAgFObIxuUAjDlkhv812rYaAV/8lWCIBsXfRFM5H3TBhi6XJ6/uwv7FfwmMp3YXC1LQ7Q1xjOz5FyAqOkE9+6eCPdMvVhcFLtZhkEV/GuJhQMr5rarDupu6V4MDmdNXLrB9NS6CGUngyzcX;4:SEGTWtyzSeNOIKj6okk4nX9HAcPfYlENpajhdylP5++9HXSJY7lXNQP16VRBqS3KA5/ofDh22atDmr+zMNOBzb/2arU64RFXcQYNLPp+adpvBiyW7s34AAXQ9c2cy8/04yrG3dCYDTpY2sOsJdlYVIseLvwWkT6E6BjVfYwyOqtBr4HvxtVDl5SVaBUY+CMsaIrmyF9LxJk484MTXXjp1aTD/lzxPe76Uu7K9g/p7Fk/Vp4PnReBkNr6TwLea8Nd18R0fdD9IQxBy2GCIay33A==
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27009BA6B50A585EA9F4C00D94D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB2700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6916009)(106356001)(3846002)(48376002)(68736007)(53936002)(6512007)(47776003)(2361001)(66066001)(7736002)(97736004)(51416003)(6116002)(2351001)(52116002)(8936002)(478600001)(105586002)(316002)(26005)(8676002)(81156014)(5660300001)(50226002)(2906002)(4326008)(6666003)(50466002)(81166006)(25786009)(6486002)(16526019)(16586007)(6506007)(1076002)(305945005)(186003)(86362001)(36756003)(59450400001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2700;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2700;23:FXMYgYK/CYioFXOTXBC2QZ5ejlQEd+IRzvvnPr5?=
 =?us-ascii?Q?zNmeVKJVrwO/hbdsnlrOzXnh4PNJMITXhWICuxiJ9t8yORoeZl0oK/infA6I?=
 =?us-ascii?Q?rPC8jb0+tqfIiDq+yZAlM4TzVUozCndaemyD0ic3Bi2XAk35y2WOt2GbPetH?=
 =?us-ascii?Q?75BVo5+zXUisWRRlKljnMY/zoKqIViecZMYOdMdrBXCRlxSe/QZl0CNukBTE?=
 =?us-ascii?Q?7TLohds88JQGhCxk92Fb4RRx1idiO4/PlvVPGIdy6cLrPT0QM2/rp5rhKEJS?=
 =?us-ascii?Q?FjUZhT0Mu9sFZq5mffcHEZVuhXhgoIR6DJz8XBOuejI3/Ans9u58M0ZPkFnT?=
 =?us-ascii?Q?1hzFaHVWlj4wuD3yg4P/1szuV1oN5qVxB4hDySsZcOtjLdoIIUJkE9F1axzn?=
 =?us-ascii?Q?YpZ/xA1ireGGK60aKXV5RIKIa6sc6CG2q9u1FXf2z2M2CLv42YPmORWaO56B?=
 =?us-ascii?Q?Og11SLt6YuNiKvxGqNMEXu0T0g2XOW0sz5DaUJcek/s+ZHQm++FwfNj93fii?=
 =?us-ascii?Q?XQYWnfZA3IW90zfTBkcc2dirKh7rTCQ3QH9neINxvkn2Lzf4ojnuY7duntpS?=
 =?us-ascii?Q?zlGY42uCLnQSF0DDmBq43Om/aKr395T69P6mSzmsLWnGfLUXqXFxShz6PQuW?=
 =?us-ascii?Q?q+mAWVa8K5ng01sXkyC3gxeMhkhO1LU091LfPmOBAvKQnWb0dF8MCreiYDXv?=
 =?us-ascii?Q?DjhfyHPXi97xSWYgKYRu1raA1vA1JI6XpvywqyE7V/HVxP8cMF/pmeh1mmpb?=
 =?us-ascii?Q?QlelBYHquv01Q/IyJ7fbcv9/+5EOmq5aGoMszhunCYBrZJ1R4iqrW3YMGe3U?=
 =?us-ascii?Q?Nt4wNhGQcDdfI9r/LsTIrOjl7g9eiHPnbUNc/aOndNL59pI15n62n8gbHN7B?=
 =?us-ascii?Q?EM/c6IIf7dbH7KRd3k2wmHvfk1ucUzoF7L3iVamV7rLWqRxsnyqxYqw33Ucz?=
 =?us-ascii?Q?PLuoh392p7OWPJsuQzxPy8ln7w3dnJSZbMi6FJXt7dqOeRI+/c3Ea4cA2ssT?=
 =?us-ascii?Q?4cMCZEkAjHHwn+Yzf6HuQjnp4dmP8QQh+VEUU/zF5iD/Jo8n258UpPJ/uTlG?=
 =?us-ascii?Q?nLMqBcrmjJ+UVzwc1IdlOfVWd53BQn8lrZNcwA8ECDMTZ9iqZFucNu0hO1GK?=
 =?us-ascii?Q?VC94MHsE9+FipkgyfE7ASWQSPZGvL74GW?=
X-Microsoft-Antispam-Message-Info: Z+Q++w1O1Sk+kyZ07PzFQJquoeH4aHve7AuZWMMKAn5wJT6h4sr8VBIz+pAfZfl9zj/fMJZlsKKkMKb8aN0u2YsxZ64IqpR/nyyv9hTjqrWASG4bDUlW946H8hh6KYSdgYzM4zmoJRIDSaNPzm/KLqyrZHkmibsJ+aj5lxgEsO2M8M9XhgL2zo4gCG189Sc2
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;6:yKLKR9s5yrNA32LgQtRe4xaczcq6pI4G9oiRX5mKZc3rekeSqEwRfC+V5lRJGuO7JqMN/T6CbB1hFbb8Vu5s+u2VDcA15nlYFJi+8KR1PxtgqzmLY1m4kYVrAH9pntC1dZspXUUiwzW+b3w57QCN76VM5MyR35C/m4uy0bhtJJ9vF2ZFDomp21ttxUOlY96Dg0pDxJp0Vbsx9IRLBdzptXLg5Mt+Tl4P6EL3GQuusruINqUCucmvq24u3XPPTg92HBWQphLElOsVz8yLDCjUTAT2Kod6XRGu5hs5aahN577z+MrgzEK0PWv8ZyQlkU8823EpN4lZHcQqmCXIwc4Hc2SGU2Xwh6XlOh28THKqgQU=;5:lfRH3styR1fnoEOnlTMs/KhdJjEyqj6PI2o/tmiRd7iSZwke1ujIZ7yw5QSbD3dEAyCX/Qxh44Wu0+SbTikk0VOPZJWj6qGEnHIJJPGKfKHhPlIhCui4zVUjEpyBPPQwEt/48TNMLUmRs6/BBCCUaFcuwTsbhLuM1KtYXs11c2c=;24:FO4IL8LzKCM3vrOy34wcaMUCS2Tsz+8F8q/rhlB8f/lPy/7fqtocaa6YjQOzp2LY3QCgQxdhnEcIk0tOPtG4oD6uOx47Iibr6fR2AyQXdeQ=;7:EDH+Qm/ctYBu9stSx7vwM/khfH5eKp2KjcV9NMb4VgKDDfPZFC/Coo/2aa9GRF/n+duXhBquFxj7m/It32c6WOcsgBppNyUnSwcJCkLKxNu8WDEPQFHXVoBVyQV9re4VQnHg896tnoNYPTUGrB9KhXWmLwdEVX8OPDAjT8U0Dy0Tb6fLmye1O1yU51NizbJcblP2py6FPmx/+FZ6ZgCNyjUo4D53Apmq7H+1sk2PzKL2dcqocwyn6nHXfCYpf9pU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 17:44:04.0983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac24abb-99ba-48a2-fdad-08d58389db3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594211170834333411?=
X-GMAIL-MSGID: =?utf-8?q?1594211170834333411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some code cleanup and bug fixes based on warnings reported by sparse
when building on x86.

Ioana Radulescu (5):
  staging: fsl-mc/dpio: Fix incorrect cast
  staging: fsl-mc/dpio: Fix cast truncate warning
  staging: fsl-mc/dpio: Use __leXX types where needed
  staging: fsl-mc/dpio: Fix incorrect masking
  staging: fsl-dpaa2/dpio: Remove dead code

 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 23 +++++++++--------------
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h | 24 ++++++++++++------------
 drivers/staging/fsl-mc/include/dpaa2-fd.h      |  6 +++---
 3 files changed, 24 insertions(+), 29 deletions(-)

-- 
2.7.4
