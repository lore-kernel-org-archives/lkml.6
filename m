Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeFAMl7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:41:59 -0400
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:15744
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752077AbeFAMlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:41:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v3 0/2] drm/blend: Add per-plane pixel blend mode property
Date: Fri,  1 Jun 2018 20:41:09 +0800
Message-Id: <1527856871-3007-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To HE1PR0801MB1977.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;3:MVUPG3XEvMthZ4iQfM1F6l3xVDjkqPc36bwl93ncYj6YDPlMmX2FSvy8IQDhWQc7T5iwgpMtvSDZR4aBiGLMJZZ89BY3KlEqWz0GOCUIKiCtGdW/2Uqz2HWJds9xvtks8IpazBi6llWRAMRIne/+PR32dfk5+c8RxPEPEQFpEOrwuMB+0vOkymNNUgZogFP3iqb8koqvECP/ydJM8X0t8sfvWs0POQxX8EI3/RlMLzRvxSxX03Aczp6fwVixHINy;25:SZ8pp/ysGC40O1fam9MAs2hyUMu6UeK/d7/M9HS/vbCJQ77h+0Cy5++QIXZClY/mP3TbEWnthBVQavEFYPntt/T7oEw7EZ+pPjL+50uENkYyCANN+m+YpNMKqxD3J0qn41r938GJMZJB94s5LtOptXvf+esKxU7v42rZSyrNwe4g06NoiZ3hQOymaEaqqpG0i+zznYShqzIFLAnw9PJ0oLfy/2E6fHJts5Evn3ULGxdIrP4Twu3fXvjy+AeBataFGhZIukgpFOVjzZi3pkv3bS39sQI6J+vHwxHaga9e0RNAEZB+ZcwWnlQdlsI6RueWrSiJuVOXMS4JV+b8KYbhAw==;31:Vmu11xNQT/1P8c79cIprExNgdajJ/9dGZPsrUJKJLD40TuQt5Dj7qRcVwcl4kv94dxsXhIs2gCN10Zsi3yz94jem9+NS3t8y7B/quB0arjeBgh4EAY8S3i0P9fARCkzro8My6a3e68pJRc40IZpjboxpVuBCgdQnySyBrey6yHi6524Y7/fCRd8KYtKsjIsCJwznB/Rmu4ir7lqLxSrgWWjNSzZTmTQyIhoClqpwYhU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1977:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;20:LhaakRaCM2+nRKCT4oVSAqFgFwLqcqzvtogXRf7l11mNk/nfSVQIfN8Zwfp0a6BLyTvxt3PaOoK5sS+mw7qa8J4gBwVqAI6umx28zApOu6uVLsDs0vIlb1JPIpCOlz4QhWz1BfNdnI/3p9WGkW58bM0BdQsOQkK/PCI7DlttIGG5G5N+PUPwP3eEu29j66Gr2ghPO/P0Hy4w6/j/buh1STjk3HesfhvvYYC2HvzEkOkfQXGFg/4CEQHCmMXg5Zqh;4:/xvl5Ay91exLjYHxMAluu3lRv8uxA+aI3oILlKRWYFnRuQaIuppBlyE31Gp8iprsT8pkgECalwmunHfNoqxnUD8z0aBKx8fotYzUkkDtrxjqons+LIs64FEe+O9S/9qZdKrl6qvPJrBY/uPWpt5UVx6ixdnaeVndJJutWVbVb+4pPkowpitQEtX6Ul3JBHOE+bBMGpnYkE6cRDDO3XY45wwlSPVhOnPL4zXg1iSfAMGDZNEfaifUVy1/TrVNYOTz+4TfXvAnTUV9iV38LwTbDw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1977BD63D10715C14D3E4A9E9F620@HE1PR0801MB1977.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1977;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1977;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(189003)(199004)(97736004)(478600001)(72206003)(47776003)(6636002)(6666003)(6486002)(66066001)(86362001)(50226002)(386003)(105586002)(37006003)(16586007)(5660300001)(305945005)(36756003)(7696005)(52116002)(48376002)(51416003)(2361001)(106356001)(59450400001)(26005)(8676002)(16526019)(50466002)(316002)(53936002)(4326008)(81166006)(2616005)(44832011)(7736002)(486006)(39060400002)(34206002)(476003)(6116002)(3846002)(956004)(25786009)(8936002)(68736007)(2351001)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1977;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1977;23:ciAEUsqaOCr+if+3ZPYS6H02NJlSj/DUnX78uVv?=
 =?us-ascii?Q?6IOexpAhWyBM50C8gwYSYnYaz71+8Jnga59mmk21G1JwVYPw3RwfONjUwXnu?=
 =?us-ascii?Q?E24xQLdE45K7y6un5nJs4yZN7v9TD74pls01caAnW9nUnPkgFHXpzuwubFHG?=
 =?us-ascii?Q?Xv9W88xh5wEDrR5L3pif8nvg7cmrqAzqc3kW21EwECUS9qJwyxxwSCPB+fTv?=
 =?us-ascii?Q?H09PkKHotQlrVc93vgHzkhrVP/Xq27btJDkl2dIjqYnhw9zAaVKJ4Bh2qhwi?=
 =?us-ascii?Q?XB9yFhNQVOcNhYMlGn3InxKmdGFidUVvlowj+sY8J2Cc0oyWFHvD0e4IALX3?=
 =?us-ascii?Q?TgA8fmedvWkxGA8VEQuTev9h66tifpkiZv32oMC9tkSzBMbD8LNMNZWqGkrH?=
 =?us-ascii?Q?12hh+j0lWqm9ccKbKFGfJiRN2Bwa+dhKdUETNtbxnfHPrODr94V9qw0jZqLr?=
 =?us-ascii?Q?8BO0ihnXmLUo5VsvHmuA1a4ML3zuhqxfRdDSG/yMWQYd/sBXHOzxdqNlfV1e?=
 =?us-ascii?Q?9YyRjEpA/aPv7PrK2BdjpruJtda7WKrNsmy263SoWu1pmzih3w42e8bE52KQ?=
 =?us-ascii?Q?ynJOOc61B9gWnV2O1Dq2lKFXyMubooo8nTvN5P/vX9NItjYNGvLDhF4u5zIR?=
 =?us-ascii?Q?EPL5G8PfR433jOr1pm3tOFiyP/gXXzXJ7LPQXwb2BRTpyqQWHeKgzeKz4JpC?=
 =?us-ascii?Q?vgEFPYnQKAamclNGQOJTJurLcKOgduUb6LZC5cRYGKwSwBhKZQjTL6EjSNbY?=
 =?us-ascii?Q?2bQLbRfShE6Zz/26p0ZTOoOtvNPpWMTdAk66/ojswslf5+Udhp+zF/mxEcCM?=
 =?us-ascii?Q?NJHVZkKvErgH2DongUnR2WfqEMnkG4NJwbKKm0c7HFmO5wK3JCYz/JUWxvvp?=
 =?us-ascii?Q?dOSSaMKqPcpF0n4NQWurHQ4T5Xb1J02lJjk3pS+CYi6GTJBqjYXEsdB1bZ0D?=
 =?us-ascii?Q?ZckZcRtOJmDzTciTqKfgJ5vJfczi89i04i3fk3s2puLq2m+WNPhAGFgxKH/+?=
 =?us-ascii?Q?zGcdIMh4D8wkZbtR2rqBF4HLElanACDfz7F9J2AmdDCH891Z3mTcipfYTsEd?=
 =?us-ascii?Q?9yHT48u7AD4QPYAcheD5KmI0nQ7MP4AZ5AlSD5CF+Z8/84lG3jTMR+ydmL4Y?=
 =?us-ascii?Q?4HGbZVKWwPEeSzEXkiUKvKllm6qfuiZv4QoSidk2BhBisSeQfb+4o0NHifIc?=
 =?us-ascii?Q?Ng+0fWofgo9zWbOq9HGliDaquVdJhipPIxxqGdBsZYkDwq3WwJI+npNl96zK?=
 =?us-ascii?Q?Uzqx7hfhxdD1F2HhB9EtuxPf6hYAWHWzIGgjNQSDZ?=
X-Microsoft-Antispam-Message-Info: XtjZsNdNOT59NfVLBlBgZi/ra+HdAqlOqag9AN7cfSSWBIwSMNxUqZSVsoiUnrF+J01l8peOHg6ga488MLp/pOHXSKB+5AiIwUpTeyZEDelusOeHt8LCxGZavNeKZ+NEMtbZdUCo9msHw2m81wPnOYcn/taWaGFyB5oYdqNl9VnSOy94wqHaNXmcPQsIMEod
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;6:+ieVHQIehJEnC7STsO+n0vUpoLvyY6fPewaHMitjto+Mj1IMI0qGvM8I7t68Hi+oWlakFL3aWpO7MEh1HnlH1Jb52ugzC4YwAp0CjHf90evrHABPVfFEQsSdKBVhZtOnw3y9YA/VEMt/YJrPkcriF5MGytwobgG378NzbnMi5jMkPjLifun861QUds2+W3bhLxpoTYu0PVE8ZI8ogUcpD136V+SfKoFyL1kYny0FgyAsGS2Oixpy7hUTEdIheHfl3MqXDUB5ePHteLZNEaM9ctfT3Pv20dXShLU44NhkOeAlAjJGCvfGgC/3jPZmTlkKP++0OfahCvHo58t1jApHHPeltO2D7dTU5n/gJSx8swsZFT2DF4pKWbJKtDM5dluS1F942r00RFR7En9NBhMAVU4oHjvZWyaaiBpYLEQPArXTMqIdS8UOdEuRbeQxGbHibVWT0DAiFqXXHhfje+IJzg==;5:jkFXHNgb/I0oOTyVBTzeTFr1WfX44kEyLyzrO73YYTSiGgRicEZqBFzVbckPLiO3C8/yXPtbsIs3wnBQTE7UBVzc8y8Gmr2t+cTzd9ZjuY0UWQ+nNRBGY/tUnk/3w8AbL9tQEE6hohGCUL74ImzWUUPKwI4wz9BVfJ89UR+Gk8I=;24:yioONr69hwLYtHh0Oc02mNq/c+SGanfy+dkA0Js0AxpwWGbNAxGn1KV9fm5sghyHJNU3k7AeVkHRyjaI/1JMoss7zVKjrLVGapOaCEMqfK8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;7:5tergh9S05rB1HEYHr7wB/WwhdfdRionFnXb/0wB6xpiJDVnJg1NHHgwq6SaxzoSoUajl+urDqSAQ9Rj4wS1aOGblrqMaZcZaYUmTHBFIfmr7tJFTJkRlmMn5lcDJM5qMQBMxV+lOJNUCiF8MbmA6HzOUfJP108a0t87hXw/aayovtE8vsMr+aHjL/TP5JapwgsJzMCco61Wv4nAVnNtqsNbOyE1qWxN1FWck9ItWBGj/13bcIX2Y9yIol7dYHnc
X-MS-Office365-Filtering-Correlation-Id: d96462b4-1c79-497b-71c1-08d5c7bd0b68
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 12:41:44.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96462b4-1c79-497b-71c1-08d5c7bd0b68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie aims at adding the support for pixel blend modes represent the
alpha blending equation selection in the driver. It also introduces to use
it in the malidp driver.

Let me know what you think,
Lowry

Changes for v3:
 - Refines the comments of drm_plane_create_blend_mode_property:
      1) Puts the descriptions (after the ":") on a new line
      2) Adds explaining why @supported_modes need PREMUL as default
 - Refines the comments of drm/mali-dp patchset
 - Rebased on drm-misc-next and fixed the confilcts with plane alpha patch

Changes for v2:
 - Moves the blending equation into the DOC comment
 - Refines the comments of drm_plane_create_blend_mode_property to not
   enumerate the #defines, but instead the string values
 - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
 - Introduces to use it in the malidp driver, which depends on the plane
   alpha patch

Changes from v1:
 - v1 is just the core changes to request for commments
 - Adds a pixel_blend_mode to drm_plane_state and a blend_mode_property to
   drm_plane, and related support functions
 - Defines three blend modes in drm_blend.h
 - Rebased on current drm-next

Lowry Li (2):
  drm: Add per-plane pixel blend mode property
  drm/mali-dp: Implement plane alpha and pixel blend on malidp

 drivers/gpu/drm/arm/malidp_planes.c |  76 +++++++++++++---------
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   5 ++
 6 files changed, 186 insertions(+), 32 deletions(-)

-- 
1.9.1
