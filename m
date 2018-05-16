Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeEPE4A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:56:00 -0400
Received: from mail-by2nam01on0072.outbound.protection.outlook.com ([104.47.34.72]:50720
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751046AbeEPEz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:55:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v5 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Date: Wed, 16 May 2018 10:25:16 +0530
Message-Id: <20180516045518.6876-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::24) To CO2PR0701MB744.namprd07.prod.outlook.com
 (2a01:111:e400:142f::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB744;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;3:y8hXqiEOq9u/UZRWNHwCIZzsdMBeMOcXA24zDbuepIKwuC1svRnVUriA6Y0rv8UJ8u0UxmEM/xjOKfPwGdmKWU/nuBRROLz8or+yvTRNcP5G4rZrR8jGsSWC4k5Llx6bFN70VK6j0sBxP2XWH9nqEL+PfKDdME4fRtGQWaO0kuwL+iiziwqwEogqC1Q0Ca3AqWkjbgDH4z8fpdzUliIfvmO6R4pu5JMsrSZ++RV0FHQRDpyBIVuqI9X4sFSS1x2R;25:tuFN/7F4AvlGfOT1x6MSMTwtijN3wcpGjTlYA8nGuTvspaMXbPAWtqv/+3AA7MYThCWsc7B4UesKmh2nnjZdb7ng/MqUmmPtlXbCsU6+9+Yk1s/3y5vdgxrthP1Ddbhxt+xfBqcYv73frudf2ShGholOT/64w0EJ5DlQZKJN6WgNHUkIxYrFMyXXOakzcxRpCaG7Jr/zL5JEiaefNpuwcvCRBPO33DABq0WLIDe5kzPsiZIqNE3ZEhxW/LiLYhKotrRtujM83RmwSmWC0Scu+sG/6kkZQ5T1L0O+DOGZZutdOvHlD0QtrzMvKB1Z5zTqzfRUf2eLPhyH4HrBeoEnEw==;31:8vsPW3GwhEb4cx4+JAZSzSYXnD8S8wpV66Jo1dN1mai4+aqWPF+yJoTDMgBMwqr41Zn8Z27uLBUpX+ZIk0p7u/QhRghd8EMMT9SwQ14lzyze5DY7yM8C+8oCBirC9LMG6NVLTWiAOPzZdl848yyyERBWOcn9RNdva90vlALqQsyXeG58PoDvmT68JtXhHGxZCdJ8Khdf077mQgkQS74eXO6FifVorGXTb9cO1VlC+9Y=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB744:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;20:TguoSxPMgKhGYXIw8xA1tjgenaiXmQTGOQcKPkb1CqZUpeXTzsMJazasxFPH5vlMjNq7zpiOS0Sr8fYgIzVxPddJK4E4QSmlwFxXPyx9iIKv5G0w+Okrkhxx6CUOOdbb3ZBgfaXnmxXvYbteI6kOkH5ZGdlAr5Zjzm/U24n3ixPokrv3vUARE4HtOYvZ3/KasXfalEYL9Tqs9do8or1+sJMtYOJh+ptq5emwtJ3MW7dn5J+4LumReRVbXdaPNhQALPzxle0GBoN9DI0k/DfLnzalHpJEW4a7HJ8aR36kkjFN7VigLDMhYd14RgB9R17eUCgRwy6Mzi56McGn+Y1i1qR6Qwz706wWvfIE/+DXG82JEPXvLbDeHVGq3SqrRTDt2fKpZQWLO8R0WMwMf7YfUgOYVEFJMadcxGeh7fgwrFn4CRBMD5lo4QSihs2hPKgkGyJ3AFwhzgfn81DTT2ilS5o5G9atCO0hf21hKKD0HkMt4UpTMaEpuBjGI+Il0y3F;4:CTlha+mhKT0Q2YpOX3PMRLrDI+IH4CRm6tdIJudp0Y3MDpkzM60dIYjwrsC7lD909CdqbZFG9Rkv5OizBJiw699RJ/NBRd/XKo7QaQcQ0QGlec107et9P8VpqtNlR6pYVUJRcLUZyWm6w7oYAmyd4TnWLi9VBArUoB8cO2bU0fOSGsJvI3nnXyfMGzMpAgeNGrY7939GFsMacONv4Di745P6T7H8LsPC0lJLaFehGbeiNTiQGfhYBtcMe1kMiN3eI96feHK1YHvtxVFOj/mVIeRNmJL+8JFPkmfreGsvgXbysRGFhTVQoBoQgRS/V4pR
X-Microsoft-Antispam-PRVS: <CO2PR0701MB744B589C0A5ED4EA0BABE8083920@CO2PR0701MB744.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR0701MB744;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB744;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(376002)(396003)(39860400002)(189003)(199004)(72206003)(6506007)(966005)(2616005)(47776003)(66066001)(956004)(50226002)(478600001)(476003)(36756003)(44832011)(8936002)(50466002)(486006)(53936002)(48376002)(6666003)(26005)(305945005)(16526019)(186003)(7736002)(59450400001)(51416003)(7696005)(52116002)(86362001)(25786009)(386003)(97736004)(6116002)(3846002)(105586002)(106356001)(1076002)(2906002)(81166006)(8676002)(81156014)(5009440100003)(68736007)(6512007)(6306002)(316002)(16586007)(39060400002)(5660300001)(6486002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB744;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB744;23:+rVO+tKb7LqpRqmZREEIyKAP/iQCe6WqrDH7nAhG?=
 =?us-ascii?Q?MMhGXLprCVpvLrEr+aaRK1qlROniBTB9wPyN9kaE+Tc3Q9YHdd8TB9s8+Ycu?=
 =?us-ascii?Q?4ZMKrzRYWn7kPrRVHUje0i7RxRU58sioLJ7JbAXO8Y+LET/X+kuRSrqA9e06?=
 =?us-ascii?Q?G8ykR9kLQc684mMY9RyAZKETvne3ta5gOeVwqgRtYCpO1meIYzb5HHnc+gnK?=
 =?us-ascii?Q?idRTQIR3f8tlRceBIaI0f5VqJLEiXODq3PBpLwB4nSQ36J7hq2untyHrvjNM?=
 =?us-ascii?Q?JHEyGtY/yGCUinehLdAqpluWdIJBUfdphpyDHy7J5h4pL/0bASCj4FQ/GthL?=
 =?us-ascii?Q?gCy0V0iPQonNHTF6Sqp3dgtBdK3R7FReEos1mLcSCBTwGQgCKunhnxhFQ7BE?=
 =?us-ascii?Q?uCwQNR9UfxniGlQtRevS+4XDqN5HxbVrfuIDf0ksyJGcvxKurHDs/sYoFyKp?=
 =?us-ascii?Q?69z8EcV03dbpaLHKRnH7Wf7K6ba1DSxYENmrYOLCuBTjrt7fdnnhKUd11qM8?=
 =?us-ascii?Q?t2rk+25ZkCOtZKxaxgXj7Avi+yPO6dW37GI4Qd6QGznCyzxiN5MZCdzuqd1z?=
 =?us-ascii?Q?YU2n6Pek/BFzjnFUVG4POGfiawSa72j8ncMRZ/1HdbPCvb6/v0KvQndlot9w?=
 =?us-ascii?Q?hjlKNc/Kw7reBj3oFTjsEXPpr3aMmjhobLbOS8ciQpMY0lZflQJ0iYyesH14?=
 =?us-ascii?Q?eoQ81YUZd+keM2IVTv6ugM6MxlIixzhXf4drabeczR+oTf1haPvAaMVfwhiT?=
 =?us-ascii?Q?eIMX9DJpACjP1ZMNCsbfsSMniNuZuoLhuMIE8an0iICwWiYiRWgDhpkdeFPZ?=
 =?us-ascii?Q?n88Jlqf0ZFPl/x6YKqMkkjIHFERaqyD5UyWTeBKkwDq5L5cE9FvPOtX23sOU?=
 =?us-ascii?Q?gb1prYXuqviUelWMVK29x6AcrCvLqIGo1ZPtwVjUhKeWGsT7GijC9FnM1L8I?=
 =?us-ascii?Q?TNNn8lm+PNS9ThQw9C7b+lnIhG1gjaQk92KqzSEsHkCaXHvMzVvbVFIw/7jU?=
 =?us-ascii?Q?WgeN6V9ZBkk13/+iguKSI4NNPCdqU51QhBSWqOHgkntRPXtEZlcNgNcOAQDi?=
 =?us-ascii?Q?64SCzusDcxCx94WF4Pq7u1jBewZ8Rm1nZKFCexOqAa3HGJmu2u0yP+OShIDZ?=
 =?us-ascii?Q?KeGYEryEeHuJhu1hRr3pj7LM/mG8zvjlX58fSWg7aSSWOIhxrOCFJLM3ZXzO?=
 =?us-ascii?Q?M73KbfzpRmbutWqOKKZN9pTqPz2taB7UXn5y0RhLV6ozCxGFHGKNVRHM3kCo?=
 =?us-ascii?Q?6rFEVIZ+IMFjSvsxyKk58NCKcwC8A/3jYXaPiJjbXALFVU3A91el45hruuPv?=
 =?us-ascii?Q?9WSVXul7RDjUn5R7T6fnFtw=3D?=
X-Microsoft-Antispam-Message-Info: Cmk9DpFg5iMtl05PNstfuwcc4gf1Lv2mrmX6EIfaz+7M3WSZSudVYew4/2/N/S1F6dRZ41JQtz7d7N1dXlBfwF87C/qTA5SzcSc5g5mSbeShMlTrQuEeb10M/dWwMGip+8CjLzB6rEshubXNjaoOL34s5W8SGDL8iQPCZME3LYMGZY/gy3n6BNEShb7/GUPD
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;6:0a7IiJVqkmjeQAI1rd9SMFKtxQiiln1IjE7sD+q9ohxBYr0zpYipu6X1UB3T9JgneXH5yG62b3zjuqbGLlYfPlx7felpk+lCW28eEl62z9HHc7Tj4v5mEAjnGmxWAhV0KNqao3Xbsn6Vr7Z3gBS69nVyqbr1/hHYv8+KzJFmeEgDQAH8ImEPHgAF1gJitlW4zlorNFr7WFxCWa3uYJ22Vbqcl5mrUT/LBgx1Lu2aydS+2C3WI/dcz8FaMWdVd+Cj5OgyfL2LIhXRkkTmTNAYCO4l4GMkR7JKwd1GAi8gHWLqpA+G0ADOLAS+HCO4OqhI+/VEArp89zHIuir7BrcFL22TjMz0yEr01zMSyK1VepxXLk9lnJGh1bZhrp6p+Qk/gYAkZOOB6drM2mQlEw+B1oqG11AbCKMyQt2+R1+NQ5Da/90B884PPdE/vW2e41hr7kezgru4BT7mtZM2rJRYBg==;5:6xW6pZ7moRpDpBAI8z4rlyfdJv9WsQ1s83W4+DUNpqLkCYZGyI0KYS18jZSrZR0T4xbyNoLgFJ3O68aR9U7lSGBilCC+MSB1rD1wegiSTFUP7gh5eQ2aRFxAY/uQCklO8lGn1hSoklfL/sPg8xSC4ylE0dUy1rON+gBb9PM7Fxs=;24:Xojat+Zsak6+Gg7nfYoHXDRHTIlwpFCTvF8R6Ab5Q6VFrBSPfQLFRy9WtvcuhiYQnAUGPtNnJ4cmxW0AjMtJgxlGU+FEfHvUUkNpavvewfI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB744;7:TkTPXvl6aggjZePiUSdOAFAmZoRSiZ0p6f+B4AvaxYcssQX4cfNn6l0QmZf7G8d6QeBSkyek8g9HQcH0LUOF9HN2CM+npz2PwdjxwF0oQW0vwJKtM9cRrv4GLBD5kVxX8eE+DTjL2ob94gF07gxAjOQyOnI+kQ0M4Ttz0zZrVW4XMkKsz/YiqEDdSw6Pqv0d8xx1NroGTpBnZ4vVTV3IQ3Tpo+OBf1Jfdrhd6/KMLASE8m62n71IeXjW3HvTMMSS
X-MS-Office365-Filtering-Correlation-Id: 3247059a-f6fb-4ec0-6616-08d5bae94e70
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 04:55:51.8615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3247059a-f6fb-4ec0-6616-08d5bae94e70
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB744
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v5:
     -Incroporated review comments from Mark Rutland[2]
v4:
     -Incroporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html
[2] https://lkml.org/lkml/2018/4/26/376

v3:
     - fixed warning reported by kbuild robot

v2:
     - rebased to 4.12-rc1
     - Removed Arch VULCAN dependency.
     - update SMC call parameters as per latest firmware.

v1:
     -Initial patch

Ganapatrao Kulkarni (2):
  perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  66 +++
 drivers/perf/Kconfig                 |   8 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 965 +++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 1041 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
2.9.4
