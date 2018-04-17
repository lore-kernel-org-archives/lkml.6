Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDQNLV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:11:21 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:6496
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753150AbeDQNLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] Add tda998x (HDMI) support to atmel-hlcdc
Date: Tue, 17 Apr 2018 15:10:46 +0200
Message-Id: <20180417131052.16336-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:kAx1J6R+XmB/GsNy6eEhUHh9Nz4HFjnRLaO+RR4KcV172og1MphhLoWHYcgc3/GxKbuZFP5Zu0gpuOSA3XaHLzcgTLwHUNkUUZL7J4iBteLFJIdPaXk7+Sit7R262tC6r6Hp05jEolJE77jVY1iLPTFA/YR/BUReoXNVvEAULHg7pArlImtk7D1fYm6iqx8R+kieqa44MTUvdFhtUhxN19MCNIJoru5XK+w9lKZKS7kXXRkbrxc2vyBqMwLxndGl;25:NgRIO5KrLzsYK0cOWOhoBWtaW9Xo3cikRprCgdMOue0s78IMEnxc/sMSgQU/JvbVDt9TnxqgHTgfkOBYAS9QbgbRuwAjbw9X8EJKy9A3z5rCbzNlg+fJNHDxIrsVRg04zhS+oRsHCNsiE9AtLdrtirBemYyNEZHwPSc/YNpKgShRnqpvCLWiRa66ebhOFaj8eA75XmQPl2fdOgAtm8UpwhkNajacvaaXgcNhlahnohsnVoj6KK9NuvC5ArPza0z3dthT8lbrX0pUI82jguQNT741DtoSGC7fO3wcqZYSrMwrgbCFspEkzMqiyi8d+66zkDVsc/9+khI37GRlofBYrg==;31:7I2UahsfwB05DxMeD+W8+XJVYYHSg9uYa2PP2XZTUVGwdTjPqHV0TmMuTF/5v0ZJ8K9feDqXNJRan3DjQNJeece83b9xe0RleUM0H4noKtd+jMKKFfPeK6K5EUwzMI4KJT1h9TR5qENaK4HDc86RmWXN7sMBbeADq/tF/2CM7UwflzjjtQYOwaXSwhJfg504QlSjmPSI2m3Q+4KtcUKlir+a8QgvhmugnU0M1QKHprY=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277838B7ED046F8EB8E7C5CEBCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:MKrADAaGSsTkiyfhk3BRkX/G/XCuxPqag7zoaDgF3xYR+vQtAAY8/ZGqRTnGwUmJXOYlu5AtBmhy0BDeXYwLYClPhEp52Q9l2ir6XQ5POan19RE6pXWOjO1QWXkzXozxkXWcDUxQckb/QY/nmhao+5JhBI1zFuulIklvfh+rFpcbACOiFaM2RpEghN16rHN0uGr6eme8N7FlKu6HS022fBzjF9rnJElXL6nIzBplbVYMeD8sxKvJFkYhysWVzLtjzcCIA4su7RU9mMbeO5yxdQ==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(346002)(39830400003)(376002)(52314003)(189003)(199004)(386003)(6116002)(6506007)(8676002)(51416003)(106356001)(97736004)(26005)(52116002)(4326008)(53936002)(3846002)(6512007)(6306002)(476003)(486006)(2616005)(956004)(6486002)(305945005)(6666003)(6916009)(7416002)(86362001)(1076002)(2906002)(2361001)(2351001)(105586002)(50466002)(36756003)(66066001)(47776003)(81156014)(74482002)(54906003)(16526019)(186003)(68736007)(16586007)(8936002)(5660300001)(7736002)(50226002)(966005)(81166006)(48376002)(478600001)(316002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:Baixu0JCokS7pd7MElRyYxuYEG2i46fZwroIjoF?=
 =?us-ascii?Q?HwsKet0sSVJBDNMmfqXq0Mb1Bs7t3VrEGINb/Yfslu6+Eyms++aggVpBh1dY?=
 =?us-ascii?Q?BVvJzUSAGjQ0lzXpGL4Ya2W/a95oRKxfecQN8FzpxFHDLjQl4OmaUBIlpvea?=
 =?us-ascii?Q?Dg47SnvKIoZHs/LX3kKDXNmx/VmrN++JSI5WJdKYQWUGt+sGQYzXbaJdGZWA?=
 =?us-ascii?Q?eK9dZ/XAF+U3XFXkb6fykHtVJSDGHZ7l/99snxjQgTYHR7KspSY29QgMNbsF?=
 =?us-ascii?Q?J6kGH4lZIpOhsIvPkzYX+YXG7PbggaPM2EshF9PEWj/1qKH8mSK45kUK7J7z?=
 =?us-ascii?Q?y9iQyz3f2Ppc3QrjG7MaGw2KGpcxVaNuM6ri0JKPqmUvXiePj1tDBx0Wq8O2?=
 =?us-ascii?Q?O5DjSnUd8PWoiZYHRcXlp1dtR0DmVlk5cgA7tOyT91LwCAuHGe3+viCIMCm8?=
 =?us-ascii?Q?opL6vNy/Ab6xJvUpiMb1DmmL77MtUhR+5pIpjBjsnPaboPeGKXEuF6CpGwnC?=
 =?us-ascii?Q?dtMdi09Zx6XpvaUN3qyk7bKpnRc3jCSUrLhEUG9tHVtZv/whljWv5DmqS2Qm?=
 =?us-ascii?Q?KKDVDyx+2La6qsDurjJ4AlZ2YJ3oMkZUwXpMZLqwlVctd1BtBbAZ88j+vymu?=
 =?us-ascii?Q?DsR0TTYa2ePS+H+o/SLxPIr6wPtSFQg025qjV3sBNWm6VGg6xrQW/Fwz0AQg?=
 =?us-ascii?Q?uNqEcmKfDlo+uSczW+ETEgHiA60aB7ekPukmpIJRBO3xUecg4K7T1Sa9LhAZ?=
 =?us-ascii?Q?HxBBarpbpHcMK7aqC0ok32zG13XgygQqxXjtOVJqgXZYqRS6PllvMACFjazI?=
 =?us-ascii?Q?e3gSz9pPwV9jXfEnXDkOTD/htZ3t5ri8eOr+TsY0TK/I8NQzNGpO3u+ImIAQ?=
 =?us-ascii?Q?ToHJ4MAPRdEL0TUEXGrUz/Vz6V2JkdS8ZO5fhSYpiZunT7YTepbRrmgEbrHp?=
 =?us-ascii?Q?CF2cEBWg97LnXKsfjfjQocIIWmWT4CD6k8sMKdcMZUrD9SMC0WN7feqNNyVt?=
 =?us-ascii?Q?XixhLAo7XNLSmrGZbKjFv5zuun4p5ErmYYq8aXnIE+okrnEXrA1jmB/srfsW?=
 =?us-ascii?Q?l4lrRpj8/3c+ZPvrtF6CzpdxjLo7QCmT2uE/PDriRqWRG/w9uyqNgROqck8l?=
 =?us-ascii?Q?sqlhTsvdplidXHWWkI7Da74qa3IUvZKgrPKETFesAuhgSUPIIkc0GMxW5ZWh?=
 =?us-ascii?Q?7Y6p0dh3IVUyHzydc3ESwiLcUjYPwzw5cFyTRTD8kac83r+hWXgQK3qbfq86?=
 =?us-ascii?Q?nXAI8B5pKDap4strdHjO7HzPPdSFpn1SrQygEm1Hr4KD2EIud+FGoCSU6m1v?=
 =?us-ascii?Q?8gdq1BFGTYCqW6QLPgF39os8=3D?=
X-Microsoft-Antispam-Message-Info: DQtQLKc3p7CQ9o1dvoXm5syuUGg0fM7sh8OsW9RZn5IfH6v3NM5T3nd0O8B8AkLhr/zVbyyjTSwadccBUFvwq3EFxn+dDoPspS5OAGe8q3wYYkgEY/peXwnsD9hZAryNKc2TekZ8EDeIgn8uhPqfI06h2OA4nLDm/0NglsXCfDfU9c/k2YfYZ5cHRQS4Sw7K
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:9MqbVJCZ5EyGrFVdPok1EI5W7qtPzStobUdpVz0AdRI0G0wrvvlahPRcVzyj8HHsCqRqzzvr1YcHzMKvOc6FC8yU/zC/cPFrCIxDRz4bpxZoVTRm365l7ToE5LcyKMrA1lGzVX+GLg5TZw881vIZvHH9kv2YgIKcHo2izvPds45JyUQ167wGeqhqANc4Fo0SJxE7GfCaquYY3LoAMnNmKRiw2uU97rTQSkE9b9o/x/hHQx6ziLJEUFxGFPDPEZqaZl7Yk7AfIAP6bz36VBQkQAxi7eC2vDDOja/wj9g1Rc2MqX/UkQoKgfi+F3gJb8T827Vhz2k60JzUYO0lYOcGAGY9p5b42IGP7WBsh42S7BQoJinsFQ2pHR+so+nlV2U8t0NoulVe1pB++WrIE1U4vx3GJGzfL6agcgPpqJ8ta2YhTMtFJC6tqgNkDaVIE930V+vzte/qby9YJbxLKA5pSQ==;5:5iQXSLmbHbMmRrCkknTyyUpE0hU988G4eo7bRkRZj4daUWXjoZvqKO1hVVEPN7FWTufUYPMhEmX8CtNaI8Xua0kbol8X0ylDHms4m6z5eNq8iftGPQ5cPjIAXG4I8PjJvcrBQSE1oMBis4zI1cNZpXq+FFes1VHB28t/p+aBSqc=;24:iNQmr2bJJfmQ4hO1ML6MRakXHAX8IbWTfoSjOY5lxjlCx136gwos1kgJIrVAmcRNpoqZNLWvCvUZ9oRCI8Eaw3leBifpHO3qYSglNWRBfRM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:LIqP7IWcA8ZDNU18C1/vhGYuv1ag8EZcXVnD2fm+ho4nftep0XglUl39o3wPjocqbq8/bllKUCk54wnsQQl7zJw+5VlTqz/Lz0cHmvJMkLFla+2peen1BUNuDeLdKfMA9mvxjFzUnT89hKjibsltwwe90XKLQIae/PA94xXEGEFK13Op/tiEvC78ya9l3xiSu2VuLxgXOe8iwmCjLImlalJfC4g8SSh+JP46p5+1SPfmRwebTDAK+vyVKcsfaeN9
X-MS-Office365-Filtering-Correlation-Id: 7c4961ec-4131-4995-62b7-08d5a464b0f9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:11.1705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4961ec-4131-4995-62b7-08d5a464b0f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I naively thought that since there was support for both nxp,tda19988 (in
the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
But it wasn't, so I started looking around, and found some missing
pieces in the tilcdc driver. I "stole" some things and made it work
for my use case.

In addition to the above, our PCB interface between the SAMA5D3 and the
HDMI encoder is only using 16 bits, and this has to be described
somewhere, or the atmel-hlcdc driver have no chance of selecting the
correct output mode. Since I had similar problems with ds90c185 lvds
encoder I added patches to override the atmel-hlcdc output format via
DT properties compatible with the media video-interface binding and
things start to play together.

Since this series superseeds the bridge series [1], I have included the
leftover bindings patch for the ti,ds90c185 here. I also noticed that
the driver date for atmel-hlcdc is bonkers, and added a patch for that.

However, I don't know if the tilcdc driver is interfacing with the
tda998x driver in a sane and modern way, and I don't know if I have
missed any subtle point when I "stole" the code and componentized the
atmel-hlcdc driver. I also have not tested how this behaves if I run
with the components as modules (not targeting that). Further, I'm
not sure if I interpret the media video-interface binding correctly.

Anyway, this series solves some real issues for my HW.

Cheers,
Peter

Changes since v1   https://lkml.org/lkml/2018/4/9/294
- added reviewed-by from Rob to patch 1/6
- patch 2/6 changed so that the bus format override is in the endpoint
  DT node, and follows the binding of media video-interfaces.
- patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
  media video-interface binding (partially).
- patch 4/6 now makes use of the above helper (and also fixes problems
  with the 3/5 patch from v1 when no override was specified).
- do not mention unrelated connector display_info details in the cover
  letter and commit messages.

[1]
"Bridge" series v2   https://lkml.org/lkml/2018/3/26/610
"Bridge" series v1   https://lkml.org/lkml/2018/3/17/221

Peter Rosin (6):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm: of: introduce drm_of_media_bus_fmt
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
  drm/atmel-hlcdc: add support for connecting to tda998x HDMI encoder
  drm/atmel-hlcdc: fix broken release date

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |   8 ++
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  85 ++++++++++----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  85 ++++++++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  15 +++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 130 +++++++++++++++++++++
 drivers/gpu/drm/drm_of.c                           |  38 ++++++
 include/drm/drm_of.h                               |   7 ++
 8 files changed, 347 insertions(+), 29 deletions(-)

-- 
2.11.0
