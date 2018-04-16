Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeDPDsM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 23:48:12 -0400
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:27168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752736AbeDPDsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 23:48:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH] drm/amdgpu/acp: Fix slab-out-of-bounds in mfd_add_device
 in acp_hw_init
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Jason Clinton <jclinton@chromium.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS"
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180413161601.109431-1-djkurtz@chromium.org>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <6e46904a-d721-d583-8ab5-82cb07df7934@amd.com>
Date: Mon, 16 Apr 2018 09:17:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413161601.109431-1-djkurtz@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To MWHPR1201MB0190.namprd12.prod.outlook.com
 (2603:10b6:301:56::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0190;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0190;3:3JYk2rcVzBSgTJgjQuvCU8aZp4hsWZCbjLJJiu8gKUHv7Ne7KTBEkr7jVqYdEUFqJq+vzQZf/6DBAYa2ij1qSys+1gxE9C/3NVK0lPM8/Myjqb5xXEdufxyRux729J28OtcVEXf952VubQ6r0/pm8Y/nDFduTkw8y5eYFeUGxOesY5iS+z/WG/ZPpzVAUMK0JHVFI7zFgAcHoqx+Yf+ArqoRI6+KO0w1WIwuSGtYUEJpIkdyxEgsyKSBb96rYsQk;25:9S6g61No0YmPdVgHiwIvEq3AsI9sDcPV9epoCuF/i2uYAQNcvdo6E4lW5Oq6vw8Hh5VvDETaHQBaFMqoyZtFxoV6plSfkFNUt1f54SPpVU2loZGO7HWWSZIGyKcSUe4A1AaHM1KUlP4w9O+lsdpg1UearkY3xm1sTrL2vM3thmZ3DLGxOXl32auhKOkIhEYZsWjfI1ndwfA49ikWSV42NhFefkWUNKvzshC1ZgjjcTUOQ01M2Ah02hJjvCLxGatp3uTJg3Q0CaGz6OjhIzx/lBH6EL9unr8IcxnUwUYpHcYxV7L5RVTDk7vVrwZz4cVSL05fq1GISc5mCrShxh6ZPA==;31:Z4gQvDNrRT9O5pYTyMYZCbErZPCdP18s6DOI38zHvZEVhqcbCTApSAaVxF4V54ddXbJZVQ/cImpcKlUOlY8SsoVz/zYSb0ioWbizjX9daeakQJDqkpg0+E21RK/Odnd9PbZxbBYj/KdXcxo8icj6/q96W2m8g9cffqj31CClKonu3pqMkGOCp80ZBJuaOaOPuXNHloxKEGVQBfTRiuxxBH6G99t/91jLcuE1W7zqXlg=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0190:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0190;20:wCgB8Qm/VnEN/XN7c/hbbIzbHF9J1ls0pYcf6vXAZ1ZH1GoiugzTDjXyviC0w9TFcc0tPjfEX4OFZ23C5clL0xxwXSqKwum8Wy7MGuB36a+QeQImlp5nI4RoiiM5J9GQ3LkjbtBI/jRumR3YMsK9vWgDXGYdibNLwgpkcyQzohivdYKXAgPJsjvCuWgmrHaIOD5VIxfurW/DpZP71QcQRgvRubkgKMIwvg71xeyyFCiuWNHdnNrLg0sEcOYQUS31kv1UIVNC1tkME9fzWcY94J111aMU2pjfiuKEywiQ+8cRK6NtWnNw2Op3/2/xGhlE5IIzntLoU9+HzE5g8scCeYfxZwvceXBsOYfNmIz3Cndo2jRGdqG6pE1PBYoeOJXb79cTrGD6f12AK9ItP+Ur0+Dwsycil5f3Hjc42AZoiXogDxVhIvw2qdgZ732/qBPAhdmOEd5Gs5Ltr62JINEmDbbKa6El891E4EKI/IR8KiuG+u3nPpyUePqOAoDJxMVn;4:zcrz+SFdLTpSPN0fZLucARMQy0OT0ZA6UuMASGHnjq4oyHs3qDwO+heqjU1lBtuayo7Fkyt5tAIAjN0va5EpWeWuU2EGmsG3NrMp5fI40lPp2HtXGtjNmDe5oK4FGlH83RXEXDrcZ2P94qiFsdszpvFaTjNeLz9IkrbhW4Jv0efXJsnW186b0h/3Gh2M5MvMtI3hbumw/Gn9JgTztMRrsIKvb2pKz8WVJMUYFEH1FhARIZWB2HVb2PjPhCzaE5F6SuXefkRwAP5AWTq7dtX0pRHBzId3YPE9drZlF4hFBq8s+uRXQIzgMEyMqp8rSiqMueWb9XoHHZA2qX+abgGDxiYOvp1IECkJMtgld3/W2JM=
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01906F0E5C417D379551DF5BF8B00@MWHPR1201MB0190.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR1201MB0190;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0190;
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(396003)(39860400002)(366004)(39380400002)(189003)(199004)(31696002)(186003)(5660300001)(65826007)(106356001)(230700001)(16526019)(25786009)(3260700006)(6246003)(26005)(77096007)(4326008)(6116002)(53936002)(3846002)(81166006)(81156014)(7736002)(8676002)(86362001)(575784001)(31686004)(2906002)(478600001)(72206003)(105586002)(47776003)(476003)(8936002)(305945005)(66066001)(65806001)(65956001)(2616005)(956004)(386003)(2486003)(52146003)(23676004)(59450400001)(54906003)(11346002)(446003)(76176011)(58126008)(36756003)(52116002)(6916009)(6666003)(67846002)(486006)(6486002)(50466002)(5890100001)(68736007)(53546011)(316002)(64126003)(97736004)(229853002)(16576012)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0190;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxOTA7MjM6Q3FaYjM0R20vcmxOSVJBL3doRmlSVjl1?=
 =?utf-8?B?WW5oeVlrUW5tM052OFVSUm01dnR0dWtod2xQMWQ5eHpOS09zUUEyMHQvTERJ?=
 =?utf-8?B?MkZNZ2tQYXpFV1NPb2Q1a2hobjNHNW93TWpleURNcmw1ZDg1M0JqcCtvOG5H?=
 =?utf-8?B?b1RZRy8wRmxkSWFHMXR2cHp6MjdmcnBvY3pzMDVIdkQvTWMzdjhKcS9lZENt?=
 =?utf-8?B?dVhQSVhQcWNTN3BPRHlLMFg4Q2lkZXdQQTdtK05NUkYyMzM3TDVxcVVIVzVB?=
 =?utf-8?B?Q0ViajV2b3lwL3AyeC9KRS9LbHJvdU5qUzNNK2ZVUFgyVzhtdm45Qks0dTdE?=
 =?utf-8?B?R29sdG9BVDNHdmpnbTNrVkd5VVFDYnpDaldodEEwSExRT2JPa2ZxaXJzQnRr?=
 =?utf-8?B?K3BpMnJSVU9HSjZLRnZrZHB1RzM0cnZoRUNnLzhQR1ArUkpMazZjTnluamdT?=
 =?utf-8?B?YlBQVzJUbytuWjF6Q28vRFdPdlowMTNUdDl2L21nV282RU5lNlpZSzZ5NElT?=
 =?utf-8?B?V1pVRUxhNTNpdk1YWFVKMEdUQ2tXOHc3QUVTczZYZkZsa0RpclIrc2RXT2du?=
 =?utf-8?B?YVFKS09vQndteU9FYlNjWE9uOUxOZUtJR0hINzJRRTkwVks5eHdvSDJVeEVk?=
 =?utf-8?B?ZE5MMTI2Uyt4eUhRUmNtMmplT1NWQnVNdlNyOTJIMStZeHB5eVRmWjQxWW1w?=
 =?utf-8?B?S3J2Rzc5R0k3aW00Vm9tVThuR20yQWc5d1kvRHJwWVZvWENTRmY2clI5MkVt?=
 =?utf-8?B?WVBkcUdncGpMd21LOFBCR3JFT3VyVmROd1RLd1JFVEVTUzhVMWdBeWpZdFZh?=
 =?utf-8?B?OUluNXUvdHhTeWxObFVFNDd6RDEvSXR4NzFscWZaZkQycVBSQ2U0d3FkYjdD?=
 =?utf-8?B?aktmOSs4SmtjcE5GN2xDTDNUSDlkUkRXM1BrRldJaDZybTNEYzc5OWJaMjFM?=
 =?utf-8?B?MUZDVllQbXo4bURyWnY3Ly9KZUtFN2hEQmpBZ2RLVVc4RHc4V01sTDBaU2R4?=
 =?utf-8?B?SEYzbkR3bW55OUFJSFhOenRxV243NTg5MEJCNVZlUHJlNXUyaG10bENreUla?=
 =?utf-8?B?dDEwRkZhQWFBZlJnWU5jK3E5M3pkekVHYWhOSktINHM4S29ycHE4VTBUaVJq?=
 =?utf-8?B?OG84UTFBOUtZcmFyWnRuck5QeU5KVGFSQk9NcmM1b0hRR0hIeGFvL284d1Bt?=
 =?utf-8?B?MEZTZXppRHVMMVdmTlJGTzhEMndKemxTUlR3Qm5wd3c4TWgydE9oUUFyN1d1?=
 =?utf-8?B?TDlVYkM4TzRrbXdhRGxhaWRFbktwZ2ZQcjNpUGE1ZnpwK250eEdSSHd4OEp0?=
 =?utf-8?B?UW9neHVuQi9iWTBnczAvVVJ0STg0SUFHc0plNlg1TTU2cTRHTkMydjY5UE5t?=
 =?utf-8?B?bDA1bW1qUFpLVHlMOHlUREVJNlJ0U25Vd2dkVXlHd2loa0hXcWFvR2xXTVpk?=
 =?utf-8?B?MGFmTjZoWnpyMDQzdTl0ckJEQTMzaFFBTjdEQXdXaHJHcHB1ZnhvYyt5YXpl?=
 =?utf-8?B?Vi8yYUQ2YXU2elYweVhZczNQUDFMTXdHRlUvMUFvN05VQndGVG1LZWRQV05q?=
 =?utf-8?B?TmJoTUxsU05ES0pjdjltR2xJN2RMdFY5NjV4akZvb0NtUW9GMm1nOUY5dm1O?=
 =?utf-8?B?WW1qTUQ4YTVnNHBtb2xxeWxvK2FqRnhPTTNtMkRyRTNtcXRQVVlaVWRTbHlr?=
 =?utf-8?B?VEhkcklhMmVUUW9jeFdubUtmSUxpam9VSnQvM1kzL2FpcVdUNVB3ZEVVZ09V?=
 =?utf-8?B?c3owWXBELzArU2ZPZ0JBb2Jaa2R1ZW5naTBoNjB3b2dWVDNCYjZwYXc1dzNw?=
 =?utf-8?B?ektrSUdCWkRaSFBVQ3pybzRNZ20rUFJ3a0dtbUU1TDY4SHlJK1lVVGhCaURG?=
 =?utf-8?B?VTUrak1QUmk0ZEFjZC9URmYzU1VCVHFScXRlM3ZiaFp0a0VrRlFzNTY3K3hx?=
 =?utf-8?B?YW5TVkhhNTllU2U5NmxPbUx6T3VoV0NyUklab2JpWVRxNDJPWGFQZ1o0bUtR?=
 =?utf-8?B?Qmt5KzliS1JlVHVEaXVacTVBUU1rVWM5Mk5kZG9XT1QzTERMTkU0Uy9KVk5p?=
 =?utf-8?B?NTZGN0lPUGZkSlJlSGFUVEJha0pBSlRnblM5ZHlUbHJtN2JrbkI2WDYvNDIx?=
 =?utf-8?B?MWNyL3ZaYm9sY0s1NktPazVKUVNudDltYXVROW92dkRFT1Z4YWF6cDB2eXRI?=
 =?utf-8?B?V1ExeE4rUTNxK3Q2U3dJaG96VnVjK2c9PQ==?=
X-Microsoft-Antispam-Message-Info: ZT5Colcq2IBuO7ETLgn6e34tNJiDbg6WNyT5d+lTCAYcwUWZ1Nm5UFGK81/TLR6svAcZcTUNXB/8uJejKJW3DkiNOLlhSNNNteIRp29kWNu41ihsJ4c6t4Rkozm5H1djzRNxo0giJgxy3PxQKr596gDqaCGFHWGKaMDa0ijIOPU7X26uk8dVHYrgCXVUj+f6
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0190;6:WTkd9pbUqbq3tmuhrouXYz0EzOj0yp6R5J5fkjiADTwLh1FuMJFNMX51ivLL6amHarGBulmF4i9Ej9OziyY5y/zx9q42hUocPAkpjG7LdvtVSVAap6yCGLyVxqlCN+XTpBL8ivy+XS8CJPWHJqa5lAYHZh4/pKMJMFfj9OAVllDDAj9FlcVBhfMMCu8ChHlRErC6XpGW904AUG8uXcOkIFo+t1LiahQXhvyztG/Y3fmWamHNKebjFpf14+hAE1FSKNuc8qGV0CyG+/ya1hNKV2T2aySfCJAUypIh1HbTJZzoU3WC8gnqita2EIf3gNSB/rHn59oN3sedhDHw+zVNEqidXYsEVWl6cjJ8YC1whpE9ujgW3bufX8X30rnnYPCAhpRvp/A/7QhkhBpbLo0jti41X8a8ILwxDkCGvKIxglZ8mVyLa2NTrDjWKDW4WRwRH9eojE9KMUY+gK3vSFxTdw==;5:T9zwk5ae7GQfwhHT1wo9NeEYgx7gt4o0xPhEzaLUJH6cj9cB5Dk+oBGruhf/tyo4OwLgQCS6Rgi3p1Xwh09I10ykEjx/ZtQhr7qb1lhm3M3/E+hNtPiK5o94KOvOVsHlE/zpF8Y2iWJInnjjgcVt2UiH+tchJXWDxN0jVyC763U=;24:7/ZnzAQblZgDpi4xBWESYiTkw7q1/L2UIghqZ7Y3W1PjNFA70BAkNYx1IiCB9e41gvEdnN59eqhNCp/+n/TOH6CiXjems1BQGeHV2s1MSR4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0190;7:sDcatLIHeMIiWnlzycv7a13XLiz4aPn4xsqO8dw30zBwXJC0ZSpFajD3ktgISLcuRjhiNOI2as67vhMQ0UIKYS3NETJMSiYVBxEQPLkQOWZbspWI88igQu+sYWSiwgyOEzXLRLBZq4WtXVDq89Pq5Jly6O4QLpb19vckIYsCXj7A8TYVkNHV3d20rpZWUWpUpcmtNENalp2PZQdQj1FYtWhaDn43WT37v/31nWDnQslZsZxeOA1/KLdfCpQYAWfT;20:T+bP7I/ipR0u7UvUuBvWxL3YY61EamsrCJJDBimRNHa+/sPz4WWM0ucPcWnnoWge0jWQIoae5rO7OycX2dpHVUNlHK1135BRHy7GMinrzTNAgiLes2Kzr1hu4tqVPB6VN8oZyy15U6oUlz8RkymDK8tYZGcBrtFCN1i5U3Hzp1PkXZnlTzHgfq8yx8paqvNlkOFsww9ZFsHY3ohXGJY+6n1YE1Ahp7cTCtJwHdgcp6pYjFeihgCp2bwGfwwSa5ch
X-MS-Office365-Filtering-Correlation-Id: b8a5eef6-ed3c-4ebf-17b6-08d5a34cddfc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 03:48:05.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a5eef6-ed3c-4ebf-17b6-08d5a34cddfc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2018 9:45 PM, Daniel Kurtz wrote:
> Commit 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for
> stoney/cz") added support for the "BT_I2S" ACP i2s channel.  As part of
> this change, one additional acp resource was added, but the "num_resource"
> count was accidentally incremented by 2.
> 
> This incorrect count eventually causes mfd_add_device() to try to access
> an invalid memory address (the location of non-existent resource 5.
> 
> This fault was detected by running a KASAN enabled kernel, which produced
> the following splat at boot:
> 
> [    6.612987] ==================================================================
> [    6.613509] BUG: KASAN: slab-out-of-bounds in mfd_add_device+0x4bc/0x7a7
> [    6.613509] Read of size 8 at addr ffff880107d4dc58 by task swapper/0/1
> [    6.613509]
> [    6.613509] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.33 #349
> [    6.613509] Hardware name: Google Grunt/Grunt, BIOS Google_Grunt.10543.0.2018_04_03_1812 04/02/2018
> [    6.613509] Call Trace:
> [    6.613509]  dump_stack+0x4d/0x63
> [    6.613509]  print_address_description+0x80/0x2d6
> [    6.613509]  ? mfd_add_device+0x4bc/0x7a7
> [    6.613509]  kasan_report+0x255/0x295
> [    6.613509]  mfd_add_device+0x4bc/0x7a7
> [    6.613509]  ? kasan_kmalloc+0x99/0xa8
> [    6.613509]  ? mfd_add_devices+0x58/0xe4
> [    6.613509]  ? __kmalloc+0x154/0x178
> [    6.613509]  mfd_add_devices+0xa5/0xe4
> [    6.613509]  acp_hw_init+0x92e/0xc4a
> [    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
> [    6.613509]  ? kmalloc_order+0x53/0x5d
> [    6.613509]  ? kmalloc_order_trace+0x23/0xb3
> [    6.613509]  amdgpu_driver_load_kms+0xce/0x267
> [    6.613509]  drm_dev_register+0x169/0x2fb
> [    6.613509]  amdgpu_pci_probe+0x217/0x242
> [    6.613509]  pci_device_probe+0x101/0x18e
> [    6.613509]  driver_probe_device+0x1dd/0x419
> [    6.613509]  ? ___might_sleep+0x80/0x1b6
> [    6.613509]  __driver_attach+0x9f/0xc9
> [    6.613509]  ? driver_probe_device+0x419/0x419
> [    6.613509]  bus_for_each_dev+0xbc/0xe1
> [    6.613509]  bus_add_driver+0x189/0x2c0
> [    6.613509]  driver_register+0x108/0x156
> [    6.613509]  ? ttm_init+0x67/0x67
> [    6.613509]  do_one_initcall+0xb2/0x161
> [    6.613509]  kernel_init_freeable+0x25a/0x308
> [    6.613509]  ? rest_init+0xcc/0xcc
> [    6.613509]  kernel_init+0x11/0x10d
> [    6.613509]  ? rest_init+0xcc/0xcc
> [    6.613509]  ret_from_fork+0x22/0x40
> [    6.613509]
> [    6.613509] Allocated by task 1:
> [    6.613509]  save_stack+0x46/0xce
> [    6.613509]  kasan_kmalloc+0x99/0xa8
> [    6.613509]  kmem_cache_alloc_trace+0x11a/0x13e
> [    6.613509]  acp_hw_init+0x210/0xc4a
> [    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
> [    6.613509]  amdgpu_driver_load_kms+0xce/0x267
> [    6.613509]  drm_dev_register+0x169/0x2fb
> [    6.613509]  amdgpu_pci_probe+0x217/0x242
> [    6.613509]  pci_device_probe+0x101/0x18e
> [    6.613509]  driver_probe_device+0x1dd/0x419
> [    6.613509]  __driver_attach+0x9f/0xc9
> [    6.613509]  bus_for_each_dev+0xbc/0xe1
> [    6.613509]  bus_add_driver+0x189/0x2c0
> [    6.613509]  driver_register+0x108/0x156
> [    6.613509]  do_one_initcall+0xb2/0x161
> [    6.613509]  kernel_init_freeable+0x25a/0x308
> [    6.613509]  kernel_init+0x11/0x10d
> [    6.613509]  ret_from_fork+0x22/0x40
> [    6.613509]
> [    6.613509] Freed by task 0:
> [    6.613509] (stack is not available)
> [    6.613509]
> [    6.613509] The buggy address belongs to the object at ffff880107d4db08
> [    6.613509]  which belongs to the cache kmalloc-512 of size 512
> [    6.613509] The buggy address is located 336 bytes inside of
> [    6.613509]  512-byte region [ffff880107d4db08, ffff880107d4dd08)
> [    6.613509] The buggy address belongs to the page:
> [    6.613509] page:ffffea00041f5300 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
> [    6.613509] flags: 0x8000000000008100(slab|head)
> [    6.613509] raw: 8000000000008100 0000000000000000 0000000000000000 0000000100120012
> [    6.613509] raw: ffffea0004208520 ffff88010b001680 ffff88010b002cc0 0000000000000000
> [    6.613509] page dumped because: kasan: bad access detected
> [    6.613509]
> [    6.613509] Memory state around the buggy address:
> [    6.613509]  ffff880107d4db00: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.613509]  ffff880107d4db80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    6.613509] >ffff880107d4dc00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> [    6.613509]                                                     ^
> [    6.613509]  ffff880107d4dc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    6.613509]  ffff880107d4dd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    6.613509] ==================================================================
> 
> Fixes: 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for stoney/cz")
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: Akshu Agrawal <akshu.agrawal@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index 20f20079935b..42f0d60cf3f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -402,7 +402,7 @@ static int acp_hw_init(void *handle)
>   	adev->acp.acp_res[4].end = adev->acp.acp_res[4].start;
>   
>   	adev->acp.acp_cell[0].name = "acp_audio_dma";
> -	adev->acp.acp_cell[0].num_resources = 6;
> +	adev->acp.acp_cell[0].num_resources = 5;
>   	adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
>   	adev->acp.acp_cell[0].platform_data = &adev->asic_type;
>   	adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
> 
