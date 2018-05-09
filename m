Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeEIKBa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:01:30 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:31886
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755400AbeEIKB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:01:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for general system clock on ST AMD platform
Date: Wed,  9 May 2018 17:58:59 +0800
Message-Id: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::23) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:hoDJlr8rCQUpKXP9kEALNJ5Sv5vz5AlzchgOfXN2sQoFMjlscPFGYYfw0FDVHldWG63rqMaaZO60EWCkxwfSnk6ajdssN/2U8PkjN5ZDYq3nG4S7FLoj+6bmhVnaTBN5L0brYTik10zTRfAH7/rGTLpzQoAcZRieAuz2yj4cBX9POZgtcMs8fS+RSKx3b5PafagaS0CR3oojrl5jz35SW8WzHtl/cBMPTCU355GYQfqHt7tnJUW7UhEFYg9HD4bj;25:J58pbzpVl+cwA4S1aemtHZZ8iy1l6GjB6Ofb1ItHSbrQU3eJ4nNLmmnY07FFBG3rwtypCoPmWNhx4ls47I+TAiL2MPvycQsx5zgQHKqU3dpcNxfUw6PDJjxYwUWAEf8tW8aLihr0JdNG07pKOluwRoEPrQl/8S42iOOXqfFLVS1XzcqiTwUYoqLVH2jpI0rEArV3cKSzRYqdvojLaqrpqdXYLLg2iB1RqH1UYqfEjvIHFJpkD88I5iWoPxTspPU4TwIZn03W85WslLvszTY2ZKRbziUYf+b5D8juW+a3uLgMo/dtRn7Hw655H01NnoIvRvVNddt+ZS51duVVlpwIpA==;31:Naruoibi3pNai7Rib5N7YXMGz+CGIK5o2Sz8ivRuL363S93U/EBpbUQPqkTTmP5R/6A75GqFyJRkpv96w5G9hpAZsD0RZDBVJI+n7/9M2I+sjNC/rYP1vCHGWwob+OGNl7Q1aEGw4OV6RFALH5XAunfO7GJavlYfNW3XG0w8JYsOhjxZ0PaG6dcZSt7W/PA+RJc5NZMUX3lz9uhVGmKZTD2aHEud46gj94M0PAPghlY=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:tq2CV5l+6AGAmkKpKlUJVQGmEkEx5Cyjc5KF+QDR/tNyPk3ztsNlAPMchg4vPwO+/TusXY8W82VG6I5vvAKqZtgpBfRXiFjVC7oApTu/RRoPwiHi7vs0eAXKqIwLkpBvK05SpNMunYgkQX5bMwAMQW4YrOGOSp5Fn4ip6mDvMovwWt7e2g1hzvZz0aHte8myAdgPMqE0PztPjhlD9nxRQyC0aiV0EnCb5hu4wMPIFep0cEcdxOTaJ50ssqZzeAhafCmByCYYV//7VNrkALwhzMRp/Ego/KVuAUPl6qhUmVy2PQ2x+xYwwuIyyfSOd6u+mkRS8RYwYEB5s6Anox4XIk1ue0KWClSy76lF3Ns5APbD3ve08jOkGe5g/FdfXnerhIznsZtPjYzCi6PX7GZhnvDrO7eWP/EiCUvgONd7pKf5WvA0WJQsCuornQLoGPRE8rLbsu0M9WsN90SOIkeDw8BT3oP6FNVvdd5IwqLR23uszTjP9uugnJ/h+wZvLyzX;4:I1csIR56y5iOH2cvY7NztHW1Y+OppZZcHwQo2/AjOgTaN1OHkPZ6URt3QxhZ/aSFBduNUIMBUUOL0JHILV2KcEVqVe98QWoVsULhyXHxs3xs8mrVKhWI3QN8SccfFiYpadsmKnN5LO7+wg3Zx3VFGakA/BFVv8XretDLJHyGG36iLnsYHRiV6MO2lAH+MYUyEI0HBvkMC+9yHKliQU/cRLNTIdfPU0BNm+ONUF2mR4qM0M1uDZF4m2nVh+gPmKQhwBr8jgiumznxJLgBbqF7vg==
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364FF82CE4DDCEA534FC8FDF8990@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(54534003)(189003)(199004)(316002)(16526019)(305945005)(7736002)(53936002)(59450400001)(68736007)(16586007)(25786009)(50226002)(956004)(105586002)(186003)(109986005)(2616005)(53416004)(476003)(486006)(26005)(51416003)(386003)(8936002)(8676002)(81156014)(44832011)(7696005)(3846002)(86362001)(6486002)(52116002)(81166006)(4326008)(478600001)(66066001)(6666003)(36756003)(72206003)(48376002)(1671002)(50466002)(106356001)(97736004)(6116002)(2906002)(47776003)(5660300001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:zIG5h0h1jdssM3G75LZOBhEdnn9o14eUT0FXmHYVm?=
 =?us-ascii?Q?esgPJVNRyUQBIDA0ijLwyy5dJiIp6CA9YnNrprQe9eHpnXbyq/z9jYw3smWT?=
 =?us-ascii?Q?lFhmZZzJtZE1+k+CrKmjbco8B5oL55JKtBJOBJYCdS9NTFCVFp05nlFJLK+z?=
 =?us-ascii?Q?dtWltqc/2me8FKijnFFwkJ8CcJ5n15HaRVTJEqc29f0orksWHO/ZxM/BuFeJ?=
 =?us-ascii?Q?mcqLP29HlLgvew1laATPUimTPx55nFtK+xUIFQLaQQt7/M+/l2yxJBsIWFFg?=
 =?us-ascii?Q?ABsK70ST40Kiho3mucWDchxZidIGNoBMgygJE5ikynMQ+zv9L7Dg37qzcvqZ?=
 =?us-ascii?Q?t124qwQEuUWL/sWqPgSsocF3BIgim8id0Srcco8JzBRAdhE82qxVsmj9MzOS?=
 =?us-ascii?Q?KQXpnrMsjwyqS/KFD300JF2in58AqArdd9Zbz5VQAQGtH/xkNs0Ec+L37DDh?=
 =?us-ascii?Q?waVN7LX4Uv6EBgtoioQetHX8NEYOJhKrI4/gP72aVP7Na6KH9J1+RsOcbFsq?=
 =?us-ascii?Q?zC0qQhLrjTDVuSJUghWJJDh7PLvaMh4OyJ8yZRSfojRw21OXvER7E7TjxVPj?=
 =?us-ascii?Q?+y+HaW/lfEQVQGMxR8leVwwq9XjscUqHSV9TH4hyXzS6nIDjX5ySnQDYoJ5f?=
 =?us-ascii?Q?GUVCYjy45zxkihwFe0NELgoWZkjdyHJa/QDtXFFw0uJIEMQ7TBB246W+94ls?=
 =?us-ascii?Q?DQaiY8JXPFkbX9lImcoKdVd1wuMQ9VoNTMEzP0Re+HSMnGHlyLH6Ue5XLuye?=
 =?us-ascii?Q?51d62ZCndYp8pfqwOqnB8rAI2cQMIs7MPvQRP/xKtFByQ0fn/tX6pdqfTbyR?=
 =?us-ascii?Q?jWodTFOjetAbVPKG3XbYoDp9ePbK3RdIsCOZf1FWXAoVnelEEepGh9267sB+?=
 =?us-ascii?Q?FvyIwU87J7l+GxPl15ixGyK3kCjSlmoLqGxkFXXNInp4K2TPQf11Lm0nEWiW?=
 =?us-ascii?Q?UiUgXBtjVIesScejH+fEGs8EPvKDXk5EUeoOcUKtpRKN49Z4gL8GJoTp6Hiu?=
 =?us-ascii?Q?/5PeMyR9R4ddnrLVm6KVp8O4ou0HMGcGoqqNWvxoVh1z6QjaztQ9UChpZW56?=
 =?us-ascii?Q?vkF+lETxe07ObeqeFF6s/oGCQPQpySLEpJ6UZV1pIYFvCeYXGCSxuLrLl7w5?=
 =?us-ascii?Q?M/GTjezN8SAx/9+Z5Q/staxJwiDfDf2kFj3BKzlHPpD+/vPOJ8d4cdwQv1ez?=
 =?us-ascii?Q?9+a+vm2QG/cnKEAu7fWV6MnGIrNGBPPlZ6ZxQXaQ6vP8rGar1RYQhWEwi4kr?=
 =?us-ascii?Q?seNcylllC+bGQ6JNCs=3D?=
X-Microsoft-Antispam-Message-Info: 0MVaOPj5tYbs5XS4WKe0qdDVpv3DPVuQChDV3z/TLaiM2hm+C/MxtHt/ufq97xq0zfn08oBxA77aJvF5+eXtfGZi0EwFf6+tgn/sFUqVz9mBWUH1q3Rsx/VRXEohcCjZHlHsgT9czUFuTzesjG940H3iRqyvgW12sKQgqHL41M+SCvjBv6djv3TOKH84eHji
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:rIpfQCr7v+tqwlRh1usotVFeLJ47LBVnDWrQ2Uw81CrThu6ZIZKDAkgJ8bFrydk1lVFwVb7iqJXnfIPomrdsUc7LFuewBOJo5PKSJ5WMRcoRVjSs3i5GxHH8U3TyLcgl070YQEL1JULYZCHFi840eVLCOPSOHPQQdsNTrChSQtDBBNuGjLgzLFq1kwyobawslgNN0tIvIW1C/aJN2bLcZaqNH+7Um4BJK3cga62UgRU6CdAgZTwr7oU99OR3O/vW01KPOuup3HqsE6JiVvhiA+DGF/xU3aR1OHla6Ja9Ir7wRyO8kqk6lnWtIKJbYTXc5tjW+k23IqTGTLOCqpFW7Pn+8kQ+edZxZZjthY0eq6shgo7yLkTKOHl4ozVH7aTHCUKLHccsVDsmSEPNkRv3JA9bguZFo1ujQuSVhK1tP0SNMll8tKgbXpMgRpl2yJaLqTMAvtFZXudvw4NorJdrtQ==;5:pX04+gKnCrFrqjg+hNRJNfxHaEtqsb7yXATozsNB+iKwJDM6LSQHVtaHfjGJpDcn5V9VvCwrr/WhH6i8c0eKqVohwv+Yz9D+WTln4Uu+0TuxY7TczeOycAnyqtuLJixBtG9X6ppoIH9rgralq3/v1H8jhHTYF/TZmRoYI7kNF/A=;24:gr6ZxG1Rm1us7b44PsT/+bikgnDWVq3R0vxzd6z8PvYMvSnIh6u8CB/d4jJSlUng0d8cZhPP8stj2Z35iBFokAPKn34wSzqpNVaDZjn///k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;7:Sfccgif4IW15haxmHwo5UdXn3KAI67cDHSs+rwLT+pCi0nZ4aECy10+mHqdGosTRKwz7V86sEnJnXI8LN0oqVHbTOamdB7qQ01aqXRcxmkAyty7xk838WBurlvhgYpcjWUa/Mf59b5mswDF6YGDSebUgwXsgClGCpMPTWslEBI5cYjiAKdPFXsFIjG6MtxEkj0d37jDwddePHcmvc6DiqX3awIDxhKKmPslh9iUzMXCrBcww0jCoetFLttq2FNa6;20:18Nxg3FQJXsbpeq3symqVKk0ko6JT+86nnoqKx/4DviKcf3KjAxAbn7Vn5evvvPiOvjSaRGfHgimgfkGX39OKFP3/oZnrJIiPdzDYmRohISpd/hsXeQZqpKBmkD26TFPn9HDBYEEX2q5ux/dEQzR7K6U2HgZiL4l5VaYygzFHbZPIqTX6HvUTDdidGeytDc3uynxD/uDPVq/iAu0WeDNsTAuxCjPIJ9I41Sqc9rq8+Oi+WOy1JpfA+2EK6N/m+1v
X-MS-Office365-Filtering-Correlation-Id: a28e30db-bffa-4fa8-20a6-08d5b593d2be
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 10:01:21.1413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28e30db-bffa-4fa8-20a6-08d5b593d2be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD ST/CZ platform provides a general system clock which can be used
by any driver. Registration of this clock will done in clk-st driver.
While the ACPI misc device will create the required MMIO mappings
and pass the same to the clk-st driver. The clk-st driver will
use the address to enable/disable and set frequency.

Changelog:
v2:
  clk: x86: Add ST oscout platform clock: v3->v4 unregister clk_hw
  ACPI: APD: Add AMD misc clock handler support: No change (v2)
v3:
  clk: x86: Add ST oscout platform clock:
		v4->v5 use static array, change license
  ACPI: APD: Add AMD misc clock handler support:
		v2->v3 use devm_ioremap, fix warning

Akshu Agrawal (2):
  clk: x86: Add ST oscout platform clock
  ACPI: APD: Add AMD misc clock handler support

 drivers/acpi/acpi_apd.c              | 50 ++++++++++++++++++++
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 ++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

-- 
1.9.1
