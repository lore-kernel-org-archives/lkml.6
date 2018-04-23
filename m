Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbeDWOvI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:51:08 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755198AbeDWOvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:03 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 0/8] drm/arm/malidp: Enhance support for system and runtime power management on malidp.
Date: Mon, 23 Apr 2018 15:50:43 +0100
Message-Id: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:0gbMCJ/Wlf2FdRDCItHt5NykLgCMv2g2A15HVisTNd8+LbKJ6eLdTtaOP4s+BZWJ0EDDMnMw6ZHnK1/vCs5niUzehHlAQG8kDfDV8Lx5WtB0UMCrYwhU7xYMHT294+JJqcxkp4zFMnNbXVyi7ZM5GTn6Drtmpvu5oGe+RaimgdvbnYn8a7M4rTf8fJ9Cl5rNL0FsejgQHl3YhNcGSMnIwOcMFx4eJ5zkzBZigm5NB4cTBQHwrHKtoosqLHU2gJyL;25:kk3ssBZl0uR0m7hthNu2FXWnHdTDQTFERgOD7nSv5c10x4yLX20tJn8ZNMIZRaIGJJb7Rkn6itXAWu+WICH5iMXB14kz9SzyfvG6Rqt84sX09jcypFQTZyLHmfJl8vQjnFEjxhEKNul9XE0+IB/ltyQo36kDmEYyPUkykdjcc7LBxz7T3WFsIXjqyl3qPQo9ZaTzfX9UMYqVkdKIa+xGNBQkZWE5Qv++dYawlLnoa62sFeVTycrZ4s2Vn2KEcR40bS3cfgGbm1RzLFV0vlsRSQV6vRSGEAtJqUYIge1upm74TAnufATUIWyZ4WAT/1PDcANR9eXbwtk9torRAV7Qqg==;31:mjOu1+HYyrS2qGrf5XUHg4K4QqM9/U7Hb+z2y7DG7Th2ClFYq3xNtfIxrUnMuY2T9sJ9RU6ZJ3guCHsd1EEkpu1mOVfOJi/Aausca2sU0ZOPJ8P9Ey9KLBMAtTtQBoDCRgPAuHzH8qptPltLQNxuQwaVYg6+imu56ueBOSiXLv8Nvbx2j11NGLbchOMsf35dWv+4/7pnCPzs5Rsh29Sop8p9VN3lMoMqVulPo10LmHA=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:ULe78VtlOX05e/gL9WOzwLieM1YJmBjGfyUAJNcd5P3L0sF+94Dh/ZywUM/v7F9za3T9q6+fDQ9TLbEuQHeZSnNhl4z9s9LRs6b06WOvauadTSHASjYAhUTq6/YeBkoq32j3ilCFlawKhpSi0Hk5jPM7CTO+37BMbDSBcl+mHTj8McqO1USQjPlcUq1O1PRnzYLAn2jllDWj+PfWVASOCsMl/Q6lDlqemFGdvwPvDBTCvpll0OpjZrYkxPeHEJjU;4:WkeorF0TKGzsdkDOFVZoIfppbstOVz3F7MXal4OfPumvfHRhlqS5+MBufiSB8LvUkO92wRsTZ/ndeq584P4Jm1vmxd35rUSpp1zH6Kl6TOAIiQd2SigYzra4i0R7wig5xhEegji4Pbe67PV4GtMSgwBRDq1SUTHojDzgmEijaHTOXddj6zV+PeQS4pma7UM6NGymU9cKGDGMzW8DFMdcprt0G1jqfPsAtxpNxxKHvsYI3DlmetBcs1psJzsZbPlhB4A+oKodExfo4oBCjMwJtA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB303999C6C47EA025458280FDE4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;23:9sw8rIqy5ps4BLJil6vVhlYvAznpFpWFar3+Xw+oknmPmSrT12f47NgSuosUHZ3YfQpaVytJZn6SAqk2mZs5eKBpevrqA7ux+e00cAPXjMadRcyoEQiS/9LWbX7ohHoJro0JkvEZX+YsxHakpiIk6rtx/vuEbgV+0Q2ks1nRABjFiItzwttzIP+ukXemTVWqqOypM2u6kITGVDun0X3fbgmbTgG1+YiAPVcoVTIA3eoElZophai5RtNwVx4KTZU9vmgo4jEERyokRu05tSUJBESOwQ2+xRbfPZms6b7E7EizD+aQltUoSM2AHHqeBOFKS1sl3MO6B2A0Hekc5BnXVaoFbXQiRS16T/QSIcrRk3icKYxozrvMVWH7EvcsPrMkUgLBTgRTitJ6onKznU+CGLE+9svgSHg9k5klb5qrcAzX94u8+JvXu/IOahouMJQsWC/jBhyU39IZolDZPb3DFbA3LweupK0Zg/XKQGEhdFTlvLPdsts9b7UCL+yn7vA+HEwT/umqvXOdjnS07DhnXF20MPwf483+ZgDJqriDSA1olug23OKZoWx9MR4hrKmaxWaMKl/DplhjNxQi26a0GkFYwMvLX3d/WEEn0SWFzw4fo5A8/VUnwjH53YxFyc4HI+EBtAq7Vm1HFhChshH2yCV9u3aSolm8hWtY4Yxne2ahw9hW1BzzVMk7jJO3gKISeelkGatYISBz52Knou9jXdY8nfvSwAdD6iMiGN3/pqtYHLdgUnDbtr9hrwV/UkVRl91w+8d05Tg3DblewpeQ57k56TxZCJYauBUqh4X8z37XMVzCJR4H1wTuKBaTJAXydXFWA1MHd0X6MRM8DTTbP5xMRUGB0pTPLJ11K/RhvbrlY7pERXS36oeM7g3O6ExBGIsm2BjghpBn2nZeD8nkgw==
X-Microsoft-Antispam-Message-Info: RyvdLzwNjLba0G7XppkoriJNpXV7KdoZkbYR66klGzmTw8bh4AOOqP+d0y9Xd13kjDtYYE+WYHjpIJT96HDRQWJHqaZgi3sIHzUCZS1MBRWNlSEALm4gct9e4AcuHxEYGrtmmteXiZ6A2G/uw6SC0mdg5/CkRa6KIMd64erKcrbM/Tq/YXSQGar4Qef7WzU+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:4DpyiU6WRjBgisQ0c2gldRZya6pggvwkT2DW/jOeg6RDuBMFz+qJ8r1/YbyMxaEbBvyETGX/FV708pMbuXu+6UAE424gUN4MpmT8QPfPDnxhqMcdxsdcpS8QlZteDwjZtizl/MXqeDteMWLyKwgKI0K5CjyukYc+sttK+lcPlw2YrPns53pp1aajhBXdER/XbRx7Ype0KUJLE1rhFWAzZgrPXZ9FBZdhxNZgg1nDX8xIcv3fPg7UEA3M9TrasxFLvjJRUqgz5TUOxnghHuGRnNWKUC6Q1WseO+GA8EHH7J1JIYfO7HN1H3gCoaHitC1dLs37yvDfegRbjoqtlIW/KVcntwgYsnGQSOkySy4ffMSmUI3AGkQfXOV9TWuFRAw8HlM3ffT4MPv5mpRNkIqeuH9xD4M+X6pUq8xD7aqya2hRFx7M32X0dHIvEFlENsTCf51YGps37SShSPgTpKeIYA==;5:qelbdqS7aKEMTFBxBskfz2kXE4VsRTZXiNIyefFBr5nZ+RAeZ8GyeRnbpwFw9/UElYdVOEDNLyRCJzGKjUcKHG6bpAALA/6oGH9PpNNNrjNdDofdqLqRLk5I5QohQ9NoG2f/+T1v9W5BvAyTI7yBiUqLIB99XICAKcB4Hidq+44=;24:5HS3UomB7GuTxxaIYVZ5G2bll+c0SPaK/ZlwFJd2e/59z4sWu84xp06eUNNuPqZmHlpJC+NtqlDbChzRefmfVPytbz1ZFlmz0VqsT+oJb1Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:5EUa+5sg4Sox3JaPgW5DzAet93jNlOJ8E/IQHN3PanBZBhs6UgmRdjMS0t+iCocbe63fav5pPq4VQp2UbwxOi1OelDEmoZV0AbGcqU90/J4YQmgO9RsfHbmjUf86VLYeM3ujEWKIQg4cfKH41applcFV/K9Wxi75Pm/Bz6+f3v1Oe/ZhdYBzqFbwz3rTJsimx85Z6GOg/dK9eLtykpBKoFh1lz+hqHUV+yREzthR4bXC0NLqXikYKz8oj3v4COhB
X-MS-Office365-Filtering-Correlation-Id: d6250a84-8ec1-4ecb-7a00-08d5a929a103
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:50:59.8687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6250a84-8ec1-4ecb-7a00-08d5a929a103
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances and fixes certain issues relevant to system and
runtime power management on malidp.

---
Changes in v2:
- Removed the change ids and modified some commit messages

---
Ayan Kumar Halder (8):
  drm/arm/malidp: Modified the prototype of malidp_de_irq_fini
  drm/arm/malidp: Modified the prototype of malidp_se_irq_fini
  drm/arm/malidp: Split malidp_de_irq_init
  drm/arm/malidp: Split malidp_se_irq_init
  drm/arm/malidp: Enable/disable interrupts in runtime pm
  drm/arm/malidp: Enable/disable the scaling engine interrupts with
    memory writeback
  drm/arm/malidp: Set the output_depth register in modeset
  drm/arm/malidp: Added the late system pm functions

 drivers/gpu/drm/arm/malidp_drv.c | 33 ++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_hw.c  | 55 +++++++++++++++++++++++++++-------------
 drivers/gpu/drm/arm/malidp_hw.h  |  6 +++--
 3 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.7.4
