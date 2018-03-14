Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeCNXEz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:04:55 -0400
Received: from mail-by2nam03on0040.outbound.protection.outlook.com ([104.47.42.40]:42400
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeCNXEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:04:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 0/5] Add debugfs info for the AMD IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 18:04:44 -0500
Message-ID: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:3:ed::16) To BLUPR12MB0692.namprd12.prod.outlook.com
 (2a01:111:e400:5951::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b4db2eb-4ec5-44aa-a3bd-08d589fffcfa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;3:oKuuWE8fooy4sEoOnZKTNm4DU4snhfioH7jF0fSReGnIuhJvM7L8bVx/fLyxe5+3R/kLthINKzWrDjJKTCKq/JYfruSyQfHMdMgijrl+RqumHD6VNIBjr9O54x2NEWYpuJeI1dyWXRDBJck77E3/7vuq588w3WrWgO0IgCJKluPGSGb5SqxQiNHCq75KvFY/0KyNn/RP48FAlgMYYt95ILBB7kQLNVahICTouWzbvLis2QJdaIzOH08p4aGiffhS;25:wlfrwtyZIf+sJLTLG7C+gWIkSj+TMvBgvv9tFIzRF7yZiydc1r8D+93uKeAbsksPU3pVpq3DwC3DqIDuk8LB8FMUffqRgUwCXMfGBW7cZVccAQpK7b0bm6YSHXS0vyyPP4updhFJ/r76rOD5x7D9Ig8eUfyK8LMfkt+CXVHI5XEQegudnZ2fkO9D7J3vCccAnZNNPKm63KgmyY2J3TjrY6F4dnH1kAnlu0o9LKmex0arjR5jV2Izo+p8CDKVELbsAS8vA/0qi/hGRU2gXfxUzP4LUlEj2oSpN9kmsoWcFUoymL8G+j+IpGuDUKvCqqCGge8b4X7JBWpxx3pmqDjVdw==;31:WAZP1d2cyHU0m7LkxuulC2x84NNwPRgSd1uk8+LzLYnkO2D2W2f4egXBqkfdt6EDgZTreerPN9VuHTd6s7RmYfkgkOjkLyXeqSvRIkZBS/go/3Fx/7uDVGWLGZduBR6MDqR/lC2hCdyEIhHFK6L1dlGE6VaK8NIazOr1zuvbLRTuTFqBP704b7QKIZ1j+ynfZ9FWMhUCAemP0QyOfe76j97ecwH83qfIJ2olFLpOCxw=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0692:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:oaqom9x8wiXVW4N0lxmVj+RzyQ1CSD42dnnX56POcvsZgISVFZsFAIQZBqDk2UCJEIYYghraQRoe3vJvTqzTlwRiuOQmGO8ltPB6JpwuFyrbuZNaV4Aq2Q10qlblZ/UEHSzFwwxwAV9T/3BMvt0Ala2EH0cveItrc1oHPk1jKk2AYuhvaS3VoZpZk4olQYkA/jxdLrJCPWZYPrgqAV2L1TwojbYG6yz0aARSmT9aPHR4/2wZZd+LlSQOaXze/MrA2ie3YccsQGfix3387tetYPWujMIQyz3I3qEzdRZ7SnvYqFC5Ta9MP9DjuLxvEks4L+7O1AzJ1xh5FyX2v4jLc6WPyco7FrX5qUGjL60eNDKR7sPGMv0qVZw/QTqVDvTVY0rJQ0305yy9QDDeeUeuDb9I75qwUYxtaMooPg8OFh8LGjF6mK6bZHf/dJnVf1FvRB6l2ayKIlFu/rd2C2nYqeXWOwhR/svJd7m5vC8EyE/zH0NgtdXFHXSUDi+jgnh7;4:wzJuiPir1SzCSXuGy/1g0BG3lbFVpR8n7LWMRm2bhoWvdFhdiRIMw7CP0ww76NmDpfFVnG4nGnPp78hGL6Jo97tHy9Lp/WiqsEf/FVHvJZfwycOSbyGfAXMUT6NF+DbNrZsk8MqGH4y5SFPid5gmd/0cZSMNH5JHyIDDj+OvVf0Ur09KQgGbS2vuBv/ecJM3xQuT2ixhvJTArs0BDNBMpHNTj/+9M92xpnRR0nF+rSgdF4MCD1AYUIhEaTjNoTgXVL+rZEw8O8/A9ZaUUcEpCXjM9RFmRoz8lwwth+PhQX3PPuFlCR93Q725cKCtNVPZ
X-Microsoft-Antispam-PRVS: <BLUPR12MB0692614673CCC727E26CF168FDD10@BLUPR12MB0692.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR12MB0692;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0692;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(199004)(189003)(4326008)(97736004)(81166006)(53936002)(58126008)(8676002)(59450400001)(103116003)(81156014)(53416004)(8936002)(50466002)(2361001)(7696005)(52116002)(105586002)(25786009)(6916009)(23676004)(186003)(2486003)(68736007)(2351001)(55016002)(72206003)(47776003)(305945005)(5660300001)(106356001)(7736002)(6666003)(2906002)(16526019)(66066001)(230700001)(386003)(316002)(6116002)(26005)(3846002)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0692;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkyOzIzOlhPNDdhejZnb0x0LzJLYWlqdVlZeXhtM09Y?=
 =?utf-8?B?RGc4ZWY1dWJ6alJ6ckRuVUlvMGMwMmZOWTNmdk5HUUlRVG9PVTR1YXhMRFdN?=
 =?utf-8?B?MTJKMUF2azhoKzk5VDhNS0tKZXQrb2Q1c3NKelNJMFpUaFZRSmZzaFBxQmwz?=
 =?utf-8?B?L0RLRlNWVnBZRnJJSk5DZjNWVzM3d251dmlRdzVIQnJyVXFXZGhjTHlmeEpq?=
 =?utf-8?B?RzNIRDAvcjUvcFZ1ckduUW1RdFB4Yy9JbTRVVzlsQU5uSFNPK3dTcnl5ZnI5?=
 =?utf-8?B?RWREZmRYT25CbkVYRHBUakYyU0hWdk9VVnhIS2k1NkhGRVBmOGcrc1dMWlo1?=
 =?utf-8?B?Y2NEODgrbWpmSUFTeGVKZW5KSmtoNGdJRGtUamFoTzNhSUQvQ2tDTmt1bEZZ?=
 =?utf-8?B?RHNYNDlnQTRKRGlsR3BPTXFuUktkQ0RPVUF4NE1RZ1RVMUZ6QWMxWTg0dVJV?=
 =?utf-8?B?R3lQdzVya3cyQnYybXR4WS9YK1RzWnBuWFlMZ3FzRi9pa3RITlF3ODllSXQ5?=
 =?utf-8?B?MWVEVWVrK3JPWjJYOWk0a2JOVWJYTTlXRU9Ndm8zZGFOdzVkbnZIVUdJblJZ?=
 =?utf-8?B?bWhTc0l4Ymd6Z2t0emIvRkZzZFR4RFc4S0p5SDRoUXRKejFpMFF6OU5KY3BG?=
 =?utf-8?B?VFBmSllvZ1R1V1lRYjVwK2hCaEt4cWNuaWtiOWF5cDBpbEVuSkorK2FGaGE2?=
 =?utf-8?B?YW9JNy94bEJ6ME5OWVBlSzNPNnVYZEdIWWhDWU5aL0trSTlQV0M2UGRzK3FC?=
 =?utf-8?B?RUN4cE9yWmVqczNXMElLU1dzUmRaWW1jUmx5U0NNSTh5V1NsdXpaQ0p2a3dY?=
 =?utf-8?B?RnVYOFVhOXZ4dE9sdFhWSHgrOUdwOXZkc1pSY1JZenNZRzVEUXUzTjRWWm1p?=
 =?utf-8?B?WHZwbkNObG9LQW95L2I1TnBRNU1CS3pFT2hnb1R6T3FjVGNxL2psUnZPbUtQ?=
 =?utf-8?B?aGNKMUZXVXhGUkh0UVV2aTlVblhlMVl4NDBkTmsxTkJMMjdKR05HNVZQclk0?=
 =?utf-8?B?TUNUK1BqcENsVVd0dm1wZUNqZFB5NGZLN2pVdEVyNEYwODZWLzk1ZW5oaG9t?=
 =?utf-8?B?SHp4cVFORnNHZldsZm1rcExnT1BjTXFSZVRWY0RPcUk4eUxXQjJVRm5PNFl1?=
 =?utf-8?B?VUJ0SUJ0aWRvU0lVbWFrT3JmcWVOQ0JVY2gxYnFnZ2NjcHl5VWR0NjVBNkxT?=
 =?utf-8?B?NStnaURuRnlxUUswMWR1Y1VTSGJoNjlCN0hqNk02V29ScFhYSkFtNU5GalRX?=
 =?utf-8?B?cU1JY3RjM0NmVGU5NWxRczdrNnpkb3NIdUQwOThEMUpHdjVUSTZYdDVzcU1v?=
 =?utf-8?B?MW5yeHQrWGRwQmM0c2hmT0gzcEFkYlZmRlZZWU5UUVovRDRMMHlxcjdUWUN3?=
 =?utf-8?B?UFBCV0Q4VG9rWm56M24xL2lJNE80TEVBekE5M2QzSjAwa3NuZkU1VnRFeWV5?=
 =?utf-8?B?NnJJUVB5Z2Y5b1dXeS8yYVpQMUgvZXVtTDN6cFQ0Q1JyR2NmQWJaOTFkbVBS?=
 =?utf-8?Q?mYGU4K2Hv6RyRntIxNh6UqpalGSAT67jnLZG5q+zB6oyF3?=
X-Microsoft-Antispam-Message-Info: hB1bI6xoRJO2jjo7sRIdATSh/5KwYf9bGwAPckVejN76vSX33M5G5oa3v7P4ydSwv0HuJTzVKXrrvmVz25lUmNJrnDjr4GlD4Z6iV9ofJ7n67shL1/ByPNgSKJrc5u8JDsrCjJaE8TPle7vMcOcmEB4vmT60tpIueBIJyiKLRxyHbBkt8wJ38XldO2AAclVF
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;6:VfkqID45SQUDNrC42pmZ1ihlIHT4S8WySavvtqJZxt5EY6vhpGd2ma0XFNh6gZkV+QgQL/RwP0Gs4GL+n8tIbCTUH9JQ2RbdiPW23TJBufkF5cW6JApLbXJyzK+y7CKaxFCZI6arn7Zppz8hfaaSgqJansMCXywanq4Kvz1kgIGSHMARInG8Zjp8FHAtyrqCKbSWy/SnWBlQhbGfny+ryt86QI/NqNJlyk7QUkiSmmvsV9wCJvyzWmNLePadC/zDP1Xoi5SKIauuN9f7dRRACn73CF9XK/v8Uwgl9C+aR5MVFHqmvDdLnCOmFKikQoIGNzz1FS4SNVyvCh8AuJqd9iZOgN5y41Yc54C3OLR5Wx0=;5:RW9uurdnMEtpd7jBGAhxaODy8tIFEmjf3GoLePQ/O3NF8/KORvQOLGQ5U89Tm4jtEsVDq9KycG0Uks2f/xj8YeviIF0hN7wGEmZ6NKhiEqYBXqapQKKKiiKVg9glrdrcC5iyOG/y9CQl4Nekf1lUzEpE1vKqlJ7AtRc/ktxZQxc=;24:uYHATMvdsY3EOMLr+yx7S5G5CNI6VtHXoKhmgyf9wkYrb0cR7zpOYilByNE01i2eIJlfh6vKfBIMdGRx71E5XoDtmxJOHRNqG6z/UaJN+Eg=;7:+APUmvM0kjTJkaelHeRXIoSnhuVipKDnifupT8PfUianXCHyCvEW4nakI2bdU3ImA4enyhtl3mXnh4F9h5Ccg9QWfneQBm8VhZOigv7Sxkt8IweDymVWrwwIJp3EoMSQuiSFbHmWnUwg9cU0O7roXoxcLtiemwlkJtq2txmVbG2x2aa9cnds08m0uUYrBiqrx+sb+4Gpy8jZYUi9QJ19H/2Xsra/RDEH6+liV+t7XcoJdg7hO5a9MKPwvg+HV7oU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:S/dFkgjEOYFNKtNoC2s67e+Nj8Hsb3DC0Z37WchcrHJBJgZlPpcuy5qOoFW2UR11hy+QoYFxd2q8+ObW8JPgcc9A4La3v3I7fUWaBq1bXixrLNW2//AyEnG/qrSHIqVatLimV66iRYmiPGT2CnD619oWyBw6qcw3sxwnEU726BwKDzMNcQUjniVwM4ow99MfyWZsTuAUx21CTWcpUL4i5QYLfN7zfkfnkKOM8GLLONTwoR33UBHgoKLrcB5cPm44
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 23:04:49.2680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4db2eb-4ec5-44aa-a3bd-08d589fffcfa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series creates a debugfs directory for AMD IOMMUs,
constructs a framework for additional entries, an online README,
and a method for dumping device table entries. Data is reported
in a default concise mode, but a verbose mode is enabled via a
filesystem entry.

This is the first of three patch series that will expose a number
of IOMMU registers.

Changes since v2:
- Change lock type to a mutex
- Convert a #define to an inline
- Alphabetize #include files
- Remove unnecessary checks for pointers
- Use kstrtoint() instead of sscanf()
- Added comments
- Minor style fixes

Changes since v1:
- Correctly use CONFIG_AMD_IOMMU_DEBUG in Makefile and header file

---

Gary R Hook (5):
      iommu/amd - Add debugfs support
      iommu/amd - Add a 'verbose' switch for IOMMU debugfs
      iommu/amd - Add a README variable for the IOMMU debugfs
      iommu/amd - Expose the active IOMMU device table entries
      iommu/amd - Add a debugfs entry to specify a IOMMU device table entry


 drivers/iommu/Kconfig             |    7 +
 drivers/iommu/Makefile            |    1 
 drivers/iommu/amd_iommu_debugfs.c |  316 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 -
 drivers/iommu/amd_iommu_proto.h   |    7 +
 drivers/iommu/amd_iommu_types.h   |    3 
 6 files changed, 338 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

--
