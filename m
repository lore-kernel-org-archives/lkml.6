Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeEOQEe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:04:34 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:19657
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752453AbeEOQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:04:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 0/5] Enhance support for system and runtime power management on malidp.
Date: Tue, 15 May 2018 17:04:14 +0100
Message-Id: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To AM6PR08MB3029.eurprd08.prod.outlook.com
 (2603:10a6:209:45::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3029;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;3:GcXues/nvdBrnMIOOhZhruMHEquiY60ulAmUXBfKcILBdL09LNpVxUddbuKCyGsBHIzRc8yw8hCEhXpxM4N900vno5TbVUgKQaos80eAqe+xFrnQsRyUooR1+aRnzTpxq/tWMgrfGu74adYL2SpUdEgqjdmYexEFbImybq8Ldz1aRHDNZDgoRDVW+rrSZfkA5Gql/nXD68bSA3WPlxFmJtmq/EdZBjmhHSdYA58xG3IansadC2+pj69dvw5GH7Su;25:iNqwZ5eC5gTBIRBZMuDSACtPsa4MqseMQ21QB+iuWyFQJrahZB7VOdqHFzzjpcWZ6rzTW6RPfVEY9h3L1JSIrQGitkF9NLgR1hJAKY6Zf+M3aS6Jr+8gEO/Ue63dMblpf/nlweEk+RQvUg9o3nRkLj56N5BjXP/gcsrRIA1W/hynDek28jsZDAFaXkbrxM6gLAsGHRXc2rBf7VQC4cGIWFCkXbNlOXWqbCTAeKSZxrWfTNgGUh4Ed+HOHzTbdOF94zoyX4ZKJ5AbS7QN2N7vDiTQ19p8UYBvh1cPu2v4NBNPk5ZFhyWcGCkz3tGpd+eQcQ1zEQjQETclvlTLE0OFYQ==;31:uDe7AfP4hyIyrCpxGkrpukWk+BXoqujUl2xy7QUlWJa+3WnIKVq7pj2O3xqrNfoSWFd13lTV1rIohdrBjy+5xQWRjudrTtScGIk8yOdPp3GPrcYCCPL0W60JVE0zglqjMS3gtbJA2p1y8uWNmqMJk0CgMYEohmXMTsmGrIG1/xQWPWfNM8U8XBUY3ByIXJCv+5DZRtNxqaza1nnymqTJod9t5smcOOIS0yrkkKS29b0=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;20:e2+IkFx0ouZN0roaIGfxbm+LI5BSqxA7m4NuuTR5yMLkIqh/OFePDegqnJe777irJoKUIII9y8VQl5GNCr7Qhj9l6IuckwXVfr0qhFc4xOKF1bu7QvuruXniLtb/QqeKjdMv9Ij1ReDI1kevI/faR0xP6VtGd7N59RTLuSZD3zwC1oAyDZpcF5+cQXlu88Eqd4HfHbfre9MJSfeixhZaqpWI2hT4CktJqrv6oXE8HVFsrTimZR7A12HSVAQv0NOr;4:sK7+ahVHFyi6nw1TbnGOjCvfa6chUB/fZx9dwtFGHY0DXULZSCoEgVGF/eAnc26OrrvfASnTPwBY3p+EUonqfNbtbtXT74GKSBn/8CNAOUfkU7n/g/+vsCOA/qXh31zqldc0g/PO2xorSt1pf3zNeCc05vLKZHoOjDHNct6uvpc+1LnvydVm1KwflDLxNKnp3QepDDRJMuaEpSXvrzvJHDSrK/6xGiJkfhr4l2cWdWZtqh004CJybQAnCklA2lcI0EW1YHUFZQoOaWfqC5WcWqIATQXLj7gn5gcwzZRAq/ILZhlwcPXp4cABneBiPcmj
X-Microsoft-Antispam-PRVS: <AM6PR08MB30296A00BD76CEE118297A63E4930@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3029;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3029;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(3846002)(16526019)(68736007)(53936002)(5660300001)(8936002)(2906002)(50226002)(86362001)(52116002)(26005)(7696005)(51416003)(6116002)(386003)(2616005)(316002)(476003)(16586007)(81156014)(106356001)(105586002)(97736004)(81166006)(6666003)(956004)(486006)(478600001)(50466002)(6486002)(305945005)(48376002)(4326008)(7736002)(25786009)(47776003)(66066001)(36756003)(72206003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3029;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3029;23:+eIzt8iB1q2teUIgrJ8ORV2UtEXJpx8f8i+KOxvrS?=
 =?us-ascii?Q?iJVnJi6KC4HURI9QuAgixbatlPAyxFbSf0+kFUib/y2hXjHUfZi6fplm2ph5?=
 =?us-ascii?Q?B4CnNPZEa+iDRbIdpSCK5QySZaDV8Kw1Gr30humoYOVPky1NlAsvC58cG+dU?=
 =?us-ascii?Q?p7P8TPJjvkozMdhYINyfew0Tn4j0Rw2i9oy4UMSkoib/Mh8J3NwIF/y0Q7YY?=
 =?us-ascii?Q?NNG29jCv7GyBL/6oGNOQ5SoDpLj/PWN/DMHltpUFJE8d5kgd4pd7M4vwZPlR?=
 =?us-ascii?Q?jGfj341ZbFwe6Llp5smhcNYnODSAiWx3vHgbXjBZ/4xWr9jMw4TxxRUMrLvC?=
 =?us-ascii?Q?cP1i6WKFy5EDvS/wkZNApt3iEyoK+u75KE/eQfq+8UWnBmKXT+mOKg4K76VP?=
 =?us-ascii?Q?6U29ZYTXc2vRK+QLMm/GUuToh7lenVQo0tDXNI6zcNmWRWOHfboTpoNYl+/8?=
 =?us-ascii?Q?e1hKrSJo/pgNqHQsUT3/mDiybGBASq0hsxESeSlwMGKX+e7SX/DgrCsvy2t4?=
 =?us-ascii?Q?9D7L9P+wHAm5PN7j3FK/rS1+v8PGAH5fPF5LyvT7jNICutsCMK8ZPKk1uata?=
 =?us-ascii?Q?77JAI4F3IBGGW/NWv7umeAsFsge9Rh4+NjNJvfMVHl/0hbxJqPppp7BP6wUJ?=
 =?us-ascii?Q?wwb2eN0Aaa+kfv7dvmDjZjWbbYXYWfqE6m2cij4vSty1uI6ckJEjQ9oR8CLJ?=
 =?us-ascii?Q?dxSu8gpH/Bz/LfzO/b0jl2+gvOfqhm10y31ZJhSl44Tv46uxKrAx3ihvL1jg?=
 =?us-ascii?Q?BFZIXWBQPJk1ahtXVMZ2iidZMS78AbaA6MWzFMl4cHrp4hoIHHQNTvxEClLW?=
 =?us-ascii?Q?sVzUKzqQ0oM/JencIQtaiqGf1E+zBMaeGrMGO81ncfbIGP54YtPyL1aUDYoj?=
 =?us-ascii?Q?fyLFILEHY578AzkIDds31iYafDXcE7Qdt5ymG+VanuX9S6RHGF408PS5BlrL?=
 =?us-ascii?Q?wPGkDsvW8LHYjRPIBpHFi5QKTWpLGdrU0mrnuPe3DQZi2sHXGouT12TfNIOK?=
 =?us-ascii?Q?1iLsXRgq0X0CQoCJ6yWCLGcwpfEzh8kn3AWSjsbJUW8BEmj3fKArtyjBF5Sg?=
 =?us-ascii?Q?yawfsUfFuDjjbvDbD8qkj5pnUorKht6/8dti5Njl1vX3+D6pw=3D=3D?=
X-Microsoft-Antispam-Message-Info: UQfIT6WNiPgS//oSLqcL3emJMvByppxSnVRx/S8rD3punoniU0OOiZxxLb4/wczKVmo3ann0SDhmEOuTcrmbJ+Q9jksSRfDiHYb/w22MWKlRkNiWoS0CoPyzuxnavM2IYntIRnvCgVTgHU9tOA++af6rQQQJauyAUgWPC8CfKHiaH4UAPN0EEUCuMsCr0BDs
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;6:YpaaDThuSTHw7Mr28v7qldw6cvD2utXTcHzBIIPqViu370BS02/GK/pPY2WqEW29gHgzVQ0H3NCgNbboK9Ty9TAAi0iXD+3z9yfmxhW8iE+AQhdX9kcv4OKcb+DgKEVeaFhwdc6l/MB5rWmKoCaWVOYi9xu50XIJXCmCghuBz4xe9QiBkwkTy66xTPowfPV/tkYt3I+XUwoOT88fCqtpESiPS5k3N8Zm+DeM754KVsZcmGuMDUVbHMmovfxy/BQB5txoNy4jZMxioFnQf9PceWF9etM6653SfKcyu5N/160mWBDMuwf8dgNl4ylbVV1mmF28IOcLpBVc4fdso+O4biI/bhoPL5JgjL6bgFyKP+uJ48FH+QZj497qsB/bps8O+g6gd4ZljUMoNXG8j55OqJjAd9YzmYZ1Nd2uMHU2YJWsbn487bxhZU8MrSQatG/f0OfnS7bddtcCiZwdVNjE0A==;5:EiyyMau1t28GWMRxR6aWOkAEI6XY1iM7W8ciD2Q0prPPG3llnkS+XZ4VkUzZrSFcxI3tALZjBTe0968zSB1/SmxQfcvmtpyNFcga+Zlh/dqmJw9VY9TC4kIpuIpURPQnZjd3ucV74P5DFeNIljpur7E6Q383LMxVKaAQRRtk7/U=;24:Wn8sejdxi+GfUPEfiF6ut2xLh7b2YzWGXJkeRLw00lqp1OYkYjg4yTsMi6jW9gREAAIkQ5mPBIAgCnsKDmwd7Nb64et73Vv8+eUras8CYs0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;7:AV/lzinNTd9nad0IjRq4b/we5k6d//fJimlXXScmO+wLpCBrVqVhtllPq36ZHapzWREq+mxXh8u3Ia656w3DISO6t+9XL39W9j6NmJpnOllnexjbFMh56Uyua3ofkiVVqGB6XzZ8WuLaKdhdFi1EXCoJRg7QW/kID0rsdwTQJ/hytcpTV38FhIERARETAV8UmOXj6zUjVfTTmLFc9OwnOk+d5lAkufe21DXWVkRoSBVPWWKaAPX/MUvljUY4Pusi
X-MS-Office365-Filtering-Correlation-Id: 53a91808-d8ed-45c8-ae4d-08d5ba7d8a21
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:04:29.1747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a91808-d8ed-45c8-ae4d-08d5ba7d8a21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances and fixes certain issues relevant to system and
runtime power management on malidp.

---
Changes in v3:
- Squashed some commits. 
- Fixed an issue related to writeback.
  Reported-by: Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>

Changes in v2:
- Removed the change ids and modified some commit messages

---
Ayan Kumar Halder (5):
  drm/arm/malidp: Modified the prototype of malidp irq de-initializers
  drm/arm/malidp: Split malidp interrupt initialization functions.
  drm/arm/malidp: Enable/disable interrupts in runtime pm
  drm/arm/malidp: Set the output_depth register in modeset
  drm/arm/malidp: Added the late system pm functions

 drivers/gpu/drm/arm/malidp_drv.c | 35 +++++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_hw.c  | 52 +++++++++++++++++++++++++++-------------
 drivers/gpu/drm/arm/malidp_hw.h  |  7 ++++--
 3 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.7.4
