Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeAaBsj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:48:39 -0500
Received: from mail-by2nam01on0070.outbound.protection.outlook.com ([104.47.34.70]:44736
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752146AbeAaBsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:48:36 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommu / vfio: Clean up iommu_map[_fast] interface
Date: Tue, 30 Jan 2018 20:48:03 -0500
Message-Id: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: SG2PR06CA0102.apcprd06.prod.outlook.com (10.170.138.28) To
 MWHPR12MB1742.namprd12.prod.outlook.com (10.175.55.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13739607-d0f0-4346-5655-08d5684cbd73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1742;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;3:vHr3gOFeJz6JBYGw+AZXMfhpjwBWj7Qu/7Dk5XltuX0u5U8fAWwlk8IZiZiVYVN+hS48/0Uc+0d35ZqR2+lfjIy0S5YrBNAtMUPddWCHXa6wpoWqD0S75QF6lv+lsE9eubvGG/zIDY7lbeKr2szVEJlpaY5gShVn3Fz8guQAo8zVG/aEmIyH9cgWFTbB/00Uvp1rYkZz9FaLxdOWc5Fmt8wLhZUfjXhgtY38kFoLyzfUiz8Tk16eJs2ouPrOiIur;25:ZsqF8kaIUTZkaXAwxmFsowgezryY1h9mZ1JvTY0PeE1nxcFP9pnrVEXcbZt53KkbWGj+A4gHb75PsSmS1pSfAN6pGjEtS6HbuOnvHVve31DcZkKZvu1bl0OJflcuUvbrKoY8DHpWdDe7K++oQ/svrkV/jGhP/9r+tf2vMZ2ztdPkhappRPBcij9L3dw4GizX+NZRB1UnaO5V2s1rOsW1M2iHm0ud5APit+U5p6fR5wEMa+gvl+NRpSdt6W+grsAHs9eOaLAYGIjvpajqqI66GZ29tJw7Bqvw95Dz3mUJ/rLGkumYu6w5hg3QjhMK2L08P5hGzYi0bIRnZwX/hZphfQ==;31:dq014zXuGG4YpWaTpgCxISXKlfE0TF7ukrchuCgg0hfpSqMSYwl2o6UH1RxaQFdEujCJkIrSVpp72OzrXGILw49lhwk+SCaWRD0TKhPn+ikIHCDjMoZ7HqA5IkAwe/y9XqGD3pQPqtnSOtwrz0UHooNc69KKPDQxUe2z1YtP+CZiKhW5TZAwFORqv8kIZ/eJgOA/jXVMPC3iK+1I46RwXEpAf0LNIHL33vcTh0nQTQg=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;20:0dl3BSbHdhI0BetmEA3HhqNpCFZDH+6AHlhV8D6vHNgyxb77MZ5627oEZLHrXz3DnDF0TfVGMRvhoCbl6zyjLlN7a/JSpyK1zEkFMQCRfg8QoaXzwIdxEKDABBoC9np2cAe7oKb8eeyXoJUWH60nO+HZzZg3XESDHFyuj2Wegnb5hO9ttVxoKgJjcVlz57nddL1tUJm99dsuN9SAmFlD6fJdlLM0zuy6td1IFE4d1f1gcAW+NE4KYrBRGiHFXKpwM+K3VHfKJllF81AO1aB5AVYoXUq/TPshP837nD8PXtEg6Lz+kBm1eejWEOyupSmkEmLT8Fy6goD+3BorDbG4zIYOW0enieLOyl2vIkSFMiUKdiWaD/0Jyzmo8O6P6rGcMhlgMFmAVOl2V9E6nScrxpuhZnKpFjawqdoKpfnUjA9tiRoA+XYDv/pha9OVi2BOQEwzENtxpx8Y7rDxxRYnFHWYM5MWEBMv79+H4lx50Cknm4cZGg0lXSP+toEoeI96;4:Cy4lIOmt1SFcl/ydixaJVRZAK4nrEbMVpaqvkCEQspWhFiXsHC0OetUtRn1XzcSUXERZlfk9xFjJSDWw2HEhwc7TRG0LeVGECsrfI1mZemYDphc7/iD7l7PVodH723ww3fRLHwnbtOnJO3V6XEHwO6QkW+z6KS8icy/0JwGJNqtcAf81mHXPaRNGvV6+4rT/n5JyO22k2MlWb+GkwI80VIhk7WB0JYxCzszyhSsAfNFc6CwWG80Hai2FXGqR6uM+yW/tXfmgrqgQSDq2AcnuDg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1742F8F3518CEC2F777F43E2F3FB0@MWHPR12MB1742.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1742;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1742;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(39380400002)(366004)(189003)(199004)(106356001)(53936002)(6666003)(86362001)(4326008)(25786009)(66066001)(2906002)(68736007)(4720700003)(26005)(52116002)(6506007)(316002)(47776003)(386003)(6486002)(3846002)(48376002)(305945005)(478600001)(36756003)(50226002)(97736004)(105586002)(51416003)(50466002)(72206003)(186003)(7736002)(16586007)(5660300001)(8676002)(16526019)(6116002)(6512007)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1742;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1742;23:f9C+rfwkvAiV+Kb7L/cjpn60SAyh6aYeXKqiJiOsD?=
 =?us-ascii?Q?EQfRUKzlRUiVXoqfBZMY6qOs2b3rXFr36csX2tmtOsyE+IUsdznEytnJfuT5?=
 =?us-ascii?Q?fs7KT7JbaHXdb7pGD5YEa25S/8IrykPhg9/SkBnwHVAg3uW5akYUDQBRwbXd?=
 =?us-ascii?Q?xzj9Q0fClj7l5GPKDWOhOQSqA26KHcDEuGfAbmwv98Ce7tPypM6mzp5OZLmM?=
 =?us-ascii?Q?zt9lXra+dLXdcE2Ya4gD9Rgfp3hf1bW5RZpYU+m0AUCb2ZZYG+YdxoDBdZZ2?=
 =?us-ascii?Q?bFdjEUDYNGws3cgEOWM+uTy9bjZ6vDhjXLQjzF8FmD3/7XroK0FzIJu9xClR?=
 =?us-ascii?Q?FhC/KqIrnM6t02R1+JXPWH/MgEQSo5jRhbO+8n455Ju47p6ng7ND7L6baKuo?=
 =?us-ascii?Q?1LgjxG5z8WazpPBgAcv2aK60qiLtraMaxgArb/EVscrThPMju+0ZTw2Ds+5B?=
 =?us-ascii?Q?LWZTsX4Q+263eZQMMpXDfFvQn5R5DweCXqw7MK3quIR666fYfk6X7bR7LY0j?=
 =?us-ascii?Q?Y7G5FCmJ35zS7lp3Xf/tadKTLxk2LRPjGhk8pzVmZr3xArsi2xLzYiZmH8zN?=
 =?us-ascii?Q?WDyAeQH7HsEfZ/LP5y00+jJRylkkeOwXoOrZn8WnJynJ3GnhRZryyxDRVFTO?=
 =?us-ascii?Q?Hu7nEZ5QW8oYWj67ve4pbcRy8GuC+DQvhj+yHSrKnm49bnAt5S0mwh3v0MlS?=
 =?us-ascii?Q?YUOxl/cUpaD3/V+XC66AVt5fU/303uoKpYff7AFcNp8Hcq4jL1APmzWsZyt7?=
 =?us-ascii?Q?OuRVXmr12dQRZBpHEWfnOz3ueJ8drobYX3DbNJoRw5gwirfhTdtf67VcRLKe?=
 =?us-ascii?Q?cpy4nvGjaoNYT5Ylr9G3SiIP7ABtdRZhYOa1aXWORfi0WRH9Cs9g+2wRGnw4?=
 =?us-ascii?Q?RqpPBwjayEZzfunhg2BrrXeu/ExEyEgAqTnA1yDBXGmgpYiTnSKZHGvTjeoJ?=
 =?us-ascii?Q?ihkJuXIw5V5dO8QJ5K6bkPIuiSlptzYtc+h8HDEU15mBEnegA6gWjZZ65Nct?=
 =?us-ascii?Q?wjzC7Z7PuFsmADT631Q8mZUop7v+HYWMPfiB94/szkSRyXgQLMtamRFo1GAT?=
 =?us-ascii?Q?XwTroqEcsX0Mjh0niesVbXec1fz?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;6:87qlpysJGLWWuPsOVM+9o1KpvIWBw/UYjuvQBqF5yAgc3y4vWkqapxjAmCLgBWgcKSfImRPvafoI0dyrHfy6w+rwUi9o5g0/l9K4f5CrstH5hnH5WtpYk//8beDYIjRlk4wipxDYaeWMOnPjXhuWkTD9Pv/dOnjib74YJmM9T9ASWO8fkQBGX+PdYCHI7S5RnPDzqDQ33M+CqxzJsaS5KAh6SEiemMBwvTz2R8ZU3T73FuPCCFV1l+XUgRwkIQM2GGPv0nouXqQ9+L9hZWJflm1ndecgArINpP5u08jhTnB4Pn9nHGhZg3gIEcPoKCLN8J+Vigzg5RCQMj744ahUd6g1b0ohq2cyCFIrdKgdhfQ=;5:2AOaqyjHC87N+7LHKylUqQq9Xmfln4nWOj6XCAultZE/31pifp1G/qLpEgRd8zTNoVqZGdWm92UdBwwvTJugtNXaUI3YL460hGRfKUCp6nyVU65JJDMHOKoA659lZUgbxBBpU3FCRCWxdaDR7uJaA21YOXjWNDC4sHs93Q2A954=;24:aGQJ/7LjJFuOVnhvZiBWx5zJzIZECsDoZAOfWzZf2NSicbuiZsCnx8xkx0BWQ+zd/f2QwlQcpxt1vksHethpH6YkYOCTa4dGAHN1g/4x4+k=;7:kZ0bODNlknepvet3UuRYzm9Y8z/A4AIZgYmBVO1tUUsRTEHUyx0kBvt8CNV0TYUOkme5G3gSo1CanK+V8FUNmzNWNIo2/hBf8HfFrpHQLQDlyw0pt7gx8h6mx0cl9UHwB3Le9Oie16y5usuRRvcDyIavfNUXLMTxR4BxlA+ys3PmRyMlW/U+EvOvWRi/QE0GwsKUbkJpB3kg6tbNDUA4e8Va4zILjRkXfQlZ9cEffUbEWh8slVXnZs7uYzpwDnT4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1742;20:JSnp3hLjI4fSRD17wlQ3IpTeiVIRpT7J7nGymnyIJ56qA8cPVvDi07E5OPtvuZpHZzyxPPQpbiWSis8c0mYmeiP0qga+kLiNLZ1W4Q4XlTskIeWYzS45F5tw9sXfT7CBc9CU/jZnbNE0SMY30EfbLtSC4e1C0I1Oz5OZlazz8P3PxujYeoBrIr3Hkd41AITAymBdzx0BsJyYOP6jNGsfdJuQau1mfUOH6BEwBp75FBgWVr/pMfkmUUir8QdUobrA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 01:48:32.7580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13739607-d0f0-4346-5655-08d5684cbd73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change iommu_unmap[_fast] interfaces return type to ssize_t since
it can also return error code.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>

Suravee Suthikulpanit (2):
  iommu: Fix iommu_unmap and iommu_unmap_fast return type
  vfio/type1: Add iommu_unmap error check when vfio_unmap_unpin

 drivers/iommu/amd_iommu.c       |  6 +++---
 drivers/iommu/intel-iommu.c     |  4 ++--
 drivers/iommu/iommu.c           | 16 ++++++++--------
 drivers/vfio/vfio_iommu_type1.c |  5 +++--
 include/linux/iommu.h           | 20 ++++++++++----------
 5 files changed, 26 insertions(+), 25 deletions(-)

-- 
1.8.3.1
