Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeEBHk4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:40:56 -0400
Received: from mail-ve1eur01on0126.outbound.protection.outlook.com ([104.47.1.126]:59104
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751036AbeEBHko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:40:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 0/3] drm: fix some bridge api misunderstandings
Date: Wed,  2 May 2018 09:40:22 +0200
Message-Id: <20180502074025.12421-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:Ji00veqRLrBFs+O1YSuySEj07aVoPdecg9dd+xkjDOuu0hX2n+cYOF03sv2kZEdSE5HMUjknbfUv/LyJgoaDAN5vHEpXC3Pzid4/+on807n1UO2Gk29H7kj4ZHbLOo+V14dZtS5BKgH0069LQnGvfD50g2OB9OGkEReCzvSILc1BUvhtUj206zENrvw1psLjfM3jZCZkN0XDB8IKgmdkPU0E8EaFSJLPQQiJoHIpb3PPry76Hkqg6/GmIjv5A5Py;25:J0yDP3/EJ3R/wkSTo1Mf5SH+kCPU91BevnxK8jGzJ6IZrI7RSEzvROCXHdbpb0+oDJ9jpDr76lJpbEYbUXtOtVLbh+/sEd+ezEFRkZqQKfX5whYPuEcD7syLNRnmcuL5St+3BVuV6QaAvxh2e2O1T96mqfd76t3ZsT0JxUq2wNMcUNBSBLyRhWO46sf6xlTaOghtzFf9isA/6w4WI4mI93/DNQVQED17OxXstznu7nTgg8YbHVNF5OM1SseiStOS+cD0yJWphnrE5hptzNNQcFIy43koE1hc5tSmFMWiQIlfEsvOsZDiwnp42zZ2iSgeCo76yspGw3IycHZVQ5OcdQ==;31:l7WoqEAfhBtPMv8hC1jaTTXm1G+NLUf04vdyStMAGEb4FVFs0j0KskRxP2zh9iQj3tMgMK9aJshRR9MH8/Q9Y+eA4C8tfyaEq1LLA4xW0tV7WGAgYo/UOFg3OEc478yvAY16BISw3vC7xb0NUedBJonMNDanjrAxEUoiWj6v2/uAvYlle0zr9h3av7dxvCE1UPas9b/x0A9sZNFaAV4JqBMeCS1vYPHwfcxzG17bPCk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27848F6052716C23110D4A04BC800@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:beQ/nhCqtXdb0AKLjZTKMnrpu9EhhrHtg7sVLb5O0Jbh+2aZU2y2W/iJxc73QtVRdLcjHffxcPelbgq05VLhmD0t55QruJXdV5OyPUhEMQUm80E0sZG3fBHidyFYzvPHsEJ3wBOJlZpahw7F4UCj720zWN2r3A+uvSGvbHBuZwcUWvVLp7BDE2t3A5f1/g5CcM3Oo1Wv3QpvbwJ/PAyubDlhBTGaW8d3bCelvYq4+vFlmAHBMREpfThzAuGaLrkFjdow4yjSbRbqqWFGObNfvg==
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39830400003)(39380400002)(199004)(189003)(105586002)(36756003)(7416002)(50226002)(86362001)(81166006)(5660300001)(81156014)(478600001)(50466002)(48376002)(8676002)(8936002)(2906002)(106356001)(6666003)(6486002)(68736007)(7736002)(186003)(305945005)(6116002)(1076002)(16526019)(6916009)(3846002)(2351001)(5890100001)(74482002)(2361001)(97736004)(26005)(53936002)(66066001)(47776003)(54906003)(6512007)(386003)(6506007)(16586007)(316002)(4326008)(25786009)(486006)(476003)(956004)(2616005)(52116002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:kCUzSQgcgAlWf/pVn6x5XP8kKxKTAo17qCiXe5z?=
 =?us-ascii?Q?ZFbrTSHCkECgDXaqTxz3kkdJvrPq2CGUwHdKNEbaJo8c0u6OwR5QRUHV2tWw?=
 =?us-ascii?Q?WgEW35LO10uROC7qOWOHzNzHnMwk4885mGHvRTYWsuSC1i7DW+fHmaP2iQ93?=
 =?us-ascii?Q?eHNsWX/UCPBTqvH3byglHhtXPx9VwBBax1i3vpSkIRr+1zTVgavHEUmjsg3h?=
 =?us-ascii?Q?e5xgXaFlvZbOEN3QtHP7jQr4eixKljqkP2OJMPd5M1h8yx6+kDGBNdhr7dmC?=
 =?us-ascii?Q?0lLw7Fpxho7r79jP6BOjxDaD110lPtL4+n2XXlvbockjocvKqG3vpqkRqMWa?=
 =?us-ascii?Q?aZRFzDaT21r9vLVrNqnDk3Z688BCOIajbevrFjtmk65JojGlF7TBKCReCyz8?=
 =?us-ascii?Q?dlJpxhx6d6h1WJTYgJacuJgefnEpj0Za6vB2hZXzn/eVtF9ILkkU4DHJBawp?=
 =?us-ascii?Q?awLQXjtAPbDkThyBVMK1Cnp09UuJXuiG5+9swkXjPDJCC7WfmriJIYHRu3QT?=
 =?us-ascii?Q?GXzlunTG1CwubD4sgonBaRtq9ZZAsYpJwS3piPJ5aLw4jO9AjBpGXv3s3ex2?=
 =?us-ascii?Q?0aIQYG8NxNgE+EYjZHIMl5g51qtsHLhbJIXTaML34BxYzhJIB6bXi84UeNsH?=
 =?us-ascii?Q?nXrJwLv1yir7eewFGNiCVsITegj8Lx5znyPs6mhV2dDoTY74xixt8Fdxw1vJ?=
 =?us-ascii?Q?00wLJidCRR4X1eoevQML3EKOS3aadDFj0hi+iSnZfepq1zibyz/o317qd605?=
 =?us-ascii?Q?2j+bh90TsYJZh6kdhjBrEQpq0kyqIwUqVViG9vWxLTeuUhyMj1ntH43lPa7s?=
 =?us-ascii?Q?LLH7VS5nUxL8reE3Qa5eydXZUZZ7mxvsHMihaCxmsmZdn7jYkPeIkePNeWAs?=
 =?us-ascii?Q?q/IOr79ieI/rMUzpO3XLdnI881neJX0F3aAypLxDXBnt2+3awa/WJFmpsh/T?=
 =?us-ascii?Q?0pWNLmVsYJLS+KfsjmZd7XjAKz444PYyEUCtZ+4CNqAbCk1+hGvY7whl3HCv?=
 =?us-ascii?Q?5V5m38Ij5eqTs/U5kNh6ZsmyxlmNvbPcBCg3feMJ6cQL8Z9DbzuzHqksouee?=
 =?us-ascii?Q?qAaVcDTBKgkQ7tfnYiAUHpi+6kTbKUWQmVEKXlR+0GeuZ2AlKwwvEU7onrpw?=
 =?us-ascii?Q?Lelkhj0l6rOXcGWr/cLiHfURNyd+Ek8DoOBsVndugmia32Kmy3gbQ2phDKNy?=
 =?us-ascii?Q?re18Kr1clBTO+aMwpmY+qgZtzcuGSSVmKlnIKTgMQUqvRLr96NpUi9453Mtf?=
 =?us-ascii?Q?dPxnlIU/If6W8+T/NlEvVohsiz6PNal7yyugH2o0IkllUbB+msEPgidKEPEj?=
 =?us-ascii?Q?MyA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ll77goVjKi3ewn72w2UL4mhu9Nj3AN/YjkQCnouVKWXPrDn6mmWQOMTBfB5CLp+gioDbBCjuP4gsd8vdbpuQt39wlLvp8yVR9HGDsHRnzxvlR0vwsqLE3vAwpLtBSPrAeqLUFlb8Of976Z+EPxG1ZSt3OE2O3NtLNIXwwIVpyTg43YgEYfNOFdfN9UbChqmh
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:XHxac9arl8NwrGyg2+9/gfnjHUqRgcwvVpr+l99mH2raYkd5k9fTusPnwMMqr/PhyFOTf8L3AEGDtsX+3r7tAPSFv0k4R1Hi6dh8Cx5iM7K+jiOdQX/Z9UlvJmRbsyPD/1KQViP0zDEWsDZoM4ri8UVlFWGRVUeB0RU7X+pPYEGNVqgw90i6ijY18m/lpu4ae48/a9aqmJVd6CW7UySI19RE09k3/p772sTyIQvr/pbH+pwnxogbC0ZSCfN/QT9nXa4OZep37I3tAhSl+vYFeAjnBC0POb4kAwqk5t+Ub1WHnj/E/1esCwUGnrZ2qClDZAVpbB4bzsIl38vgEBsh9kM5kE0EWutIyyxFqMKhVMZZzg/RTDXZAc9etBm2GfLQ2l7oKJ12Cs4qg6eVF38z7Y/bkQ3ZXXZmAiau8/e7Lcj29ZRMkHh+IVEprM16CLwf6Umgcv2S1oF9FwzsxvI44w==;5:eHSFRUmP8R8BShioY/ZhjFsboSJsFzRMcqXFYU3elU/iPG6Bso49diYpNM46d06iEN0SGEcAdLBVI5C5UcRnstlcaobbIyiS1QEhCaPuY7XHvfWSc7UxlraK+DyQ233u+h5FnMRq2v4W8Brm8lUsxq2VEAvKi0m8uL/A0ou8Zow=;24:Yhbm+tsRNztlPkzKTF9goRuFy69XaAsD5HJZ9gLes2Mwpr9NRgAyorJotciziTChyvKaG2SJApQUKLuJ49sayaNgygIcDo9oFOtL+pStE2I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:M66JDIdw7hHCnoaurCV7UPVVa080g2y89F/Y1kMiUaPFO0SElem+dCTpacQjzbcDe0Moi5WnzT2NrOuXa8ZlETkg62To0qEVIbziqKFcAtybfmyD2r08sAbSBY/6mIo1xHiEgNZAkE0DjgIq5OvI5ugrhgcSoS+BkrWC74FGcSWBl0cLpUB5cfCvVKMhX3D25/UdaHl/S9SzyTudx0cyjVZVNj3zaRcGu/tt+zhnwQjkvMCthh2dEdT/T9HyUWOa
X-MS-Office365-Filtering-Correlation-Id: a1478653-26d2-4975-7a9f-08d5b00000fb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 07:40:39.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1478653-26d2-4975-7a9f-08d5b00000fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While looking at various drm bridge users, I came across these
issues.

Cheers,
Peter

Peter Rosin (3):
  drm/sti: do not remove the drm_bridge that was never added
  drm/rockchip: lvds: avoid duplicating drm_bridge_attach
  drm/exynos: hdmi: avoid duplicating drm_bridge_attach

 drivers/gpu/drm/exynos/exynos_hdmi.c     | 2 --
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 drivers/gpu/drm/sti/sti_hda.c            | 1 -
 drivers/gpu/drm/sti/sti_hdmi.c           | 1 -
 4 files changed, 6 deletions(-)

-- 
2.11.0
