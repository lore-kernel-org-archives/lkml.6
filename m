Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeDBVJT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:09:19 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:18893
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753218AbeDBVJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:09:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com;
Subject: Re: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link
 speed and whether it's limited
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <02874ECE860811409154E81DA85FBB5882D49870@ORSMSX115.amr.corp.intel.com>
 <20180402195820.GL9322@bhelgaas-glaptop.roam.corp.google.com>
 <02874ECE860811409154E81DA85FBB5882D49AFE@ORSMSX115.amr.corp.intel.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <6dca1536-654a-fe94-7e55-8088e0457cf2@mellanox.com>
Date: Tue, 3 Apr 2018 00:09:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <02874ECE860811409154E81DA85FBB5882D49AFE@ORSMSX115.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.67.222.167]
X-ClientProxiedBy: VI1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::27) To DB6PR0501MB2599.eurprd05.prod.outlook.com
 (2603:10a6:4:5f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e571007f-1367-4884-35ce-08d598ddfa67
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2599;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2599;3:uSSDl8891G7nbnrXc0yyOdSJo29c56+v3YjEsOPFpjxRg9Fii65FCkN9wHFPoHcZIln6UNZ5WbheAZm8GIr48KMFnh2o7rzorOhLGpCzod/Xftv+XUffW+K2qEvl9g4grrwP57ERRqs4oJYmbTMkeRU4qtggycSbc7LPQY1ildb320g26t5HBEM3bZCTeLdrGROQZLgS+Hv+B20AoPHeixT8ouylbojnZhueVz9tzgg/67L0GDzyBwQYPQnwQ7F3;25:etXA2dW8EqXFPQFkyjvckrvmHavmfWVADgkz99KK5X8qpEAg20MRgmjiqEMPV4+CuOSohoEdMU8bDCPMyF2Xkz3hklsHwc42+xY7P5g4zbtd2iE9J8eG1QpsrBg/YKA7gure9caK4+JAzyurfnEJtIzSkehZcFoXDAljvIAPzqaVWQQwY815JFScgsC44Q+vXKM3SnfS+Qn57BXo7xlFbm3joRdr/cyKJG7Vmr3+ffC70cg/LNegxVBM8qTZ8RQ3huFBl5Qm6mgD8t8jDr8t80cu/vUgpNuIeis+SMKtsKTHTBPKwPDCmwfYE+BmCLr3kp2xv+4asbjx9oKQ0RroNw==;31:rMw8WRFLwRZVRu0sTXYinOe1pSktKNBFVyB9G9qTKwB1gttp8QyPI3dMZu2/E/sd+uto9zdAtBl7DRLHpHBp+EUlPcINGilHVpTtBjQPcnSI3SexPaoV50ev75RbY111mL0B+uQRWYlOC30rou9p+ocRwkcF0ez5pwMtBetJIXrZXprWsy6p02RdBa35qPW1i3MuxE6XV7qZ2D47ljGGFTqFVw5XtusIV929mf04/xc=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2599:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2599;20:eOUPh2hmwxDxpmaZa/XUDorKA/RNIUpw5iJSTnQtTigjMqYgj9fcj0sWeqGq+2hOEEDkQVfviijbxlZx8A1aelyviNp+8Hg//eIE1AIUvUFwq6kYrD2y0Ph1KmpR0JUEg/7VAr9+GI1nZ/wtUzOFi33LgqBy9t4ybSCEr27ggHLgu7U6qg/rgjvu9RmTbgkLTRS3UZixMbbzKrfK1Wg4RJzD+u1IWvBRmmoOBRZBNjRtbQ+sUixwoul8VQvrKBl5ipj1U6xzZebL1xWRAKUn3E5u7/WQU0cLRKrho8x8rOmbH0IBHL7nZBI8Vub4KmoRoGj3YjwU8atjoMbYmHjepwRhpXNWHJXDAkWlLaPTfpwjxaw5JYJV3yP0KtrmmRwyGKcVLztZoYy5gtbrBzjkX5gArr5KiUehlrKBsS/1DgkExSyttFg615ic/HtMYqukF4QEY628PCZHjePSBuipgHO3qBf/DFImN1tT+ArD0YNxGCze4kdMUXiCLABUoRB9
X-Microsoft-Antispam-PRVS: <DB6PR0501MB25990214D3A9BD635EE01170D2A60@DB6PR0501MB2599.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(9452136761055)(211936372134217)(100405760836317)(42068640409301)(153496737603132)(211171220733660)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0501MB2599;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2599;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2599;4:KEwd6LqaqERsN6aTEj3jHC8ta3a0vhU6HMlnnC9ATfefWMYaRQYn58KGr5LBILX5MNIw4IlXoIcNoh/A7ISB/frlP7Ju66yr285vzfVvFEezJPl7ahhjSEvGCEoSREEj/Nk+RGVdwdmhAFT4DHkoyHYAaghhV8NIecFzdnZgjL7MrAArbwnkzgbWxjaeZ7FkKRrvFGpGszkGGHFVGhFbgKTXQwomoBWrmZI7cytRi2fndfTYkEdmYdwpDShql/miI30rQoApHctfQj1W/Ovnmi8R+DOd+x0MvCKX/HgqKHQEZaYn3Oa+CAkA8UhiLemkTwozwEKdCertYRtZzMpmIYujOH4CKzMVw5iuITuP/bM8m4+PRsZ3m5SoiP6vAFiLTjmTn6uTM2cj5UfkvHkItksGmcwzjeZvE/TXVhuacnYQgX5sGxa7ncusZVc8pTC8hUXoKKWh6tWSEkG0BjFdZvLu0nyfq3JRVU2R6WYzn+HMEN26XRwG3GC2nOL75l+VBoF+Ts7ON4UMz2YM9Z0kQjoduYzCu5OaaiMoc06QLHI=
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(51444003)(13464003)(54534003)(199004)(189003)(93886005)(16576012)(97736004)(561944003)(3260700006)(58126008)(25786009)(316002)(6306002)(117156002)(53936002)(6486002)(65956001)(4326008)(305945005)(53546011)(446003)(386003)(7736002)(47776003)(230700001)(50466002)(5660300001)(59450400001)(76176011)(66066001)(65806001)(8936002)(7416002)(486005)(956004)(2616005)(486005)(81166006)(81156014)(8676002)(11346002)(67846002)(229853002)(52146003)(23676004)(6666003)(2486003)(64126003)(65826007)(31686004)(52116002)(966005)(31696002)(6246003)(86362001)(106356001)(575784001)(68736007)(77096007)(478600001)(16526019)(3846002)(105586002)(26005)(6116002)(36756003)(54906003)(186003)(2906002)(110136005)(476003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2599;H:[192.168.14.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjI1OTk7MjM6SUdjaEloaGk2YTVscXl2TWFuaHFhaHR3?=
 =?utf-8?B?S01ydzBMQUV2dDVVSnNPZFVpMEU1Yk9CTEhHS0FIaDAwanI3bGNvVnlTQnF1?=
 =?utf-8?B?NFErZitGZHZxVkpQRHNINlM5VHErTmlrV1ZHZ2pOMWJ3cmtEdjBxdU8yYXN4?=
 =?utf-8?B?cTZSNDg0aEdRb21GUFR1UlJmeS9YMXp1L1ZlcGFmcUYyVzU3a2wrUWRlVFlG?=
 =?utf-8?B?ajdHMHErdlAvbXpjUytIdExkblVxL3Y3ZTM1ejlXb29VV0Z1ZHZpai8vOUli?=
 =?utf-8?B?d1VqMUJwVjF2bncySmx5THNnOUlwb1RzbEUvdXBBcUxwUW1BSDBPNm11R212?=
 =?utf-8?B?OWNtTWluT24weTlaRzFyejVIRi9PVEsyVDZnMVd0Q1RPb2pVanFTYitDY2Zq?=
 =?utf-8?B?cHhWbVl1UVpEUVBQb1pBUmRUSzhMN3AvTTJmY2x2cEdUbEJKQ2RPelBQN0NW?=
 =?utf-8?B?Y1czd0VDYmw5SDNCVGlNUmFDZFpXM2c3RlZIVktja2dxaFpRM25JVng5c1lG?=
 =?utf-8?B?alN3ekwzRnJQejBIaURWNlZTYjJoZVJsRlFzRzhseEd1cGdjZXY4TzNPOWVF?=
 =?utf-8?B?N3NIc3IwbU1pME1NSWR0cHpRY0VqT2R5dW9tYkd0NmZwYmxLZGxxVDZBcTQr?=
 =?utf-8?B?Qk5FdE5QRlMyZDhvc3dSakhyd0hMeWhVbHE2YXVnM1Y5b3IyNTlXeVhhK0V0?=
 =?utf-8?B?MFVmUlFyeml5Y2lkSnpVZzR2bGRCQ2NidzRXUGRFdFo5N1Vyb0FmdWUwcDZx?=
 =?utf-8?B?anlVQ2NOV1loVmRrN3RxNkNFYnZFSVA4bVpFY0pyaXowaDNrMmhET1lKelFj?=
 =?utf-8?B?V0tuN2NNODJxMCtzNTZuODNQVWFkcTV5a0xnVldtYjF0cnJxbGc3ckhhVWZ2?=
 =?utf-8?B?djFwTWREMkdLOUxtTGp5cUZNRnUvQitXTUljN0liM3BoMFVaMWNLeHN0MkFx?=
 =?utf-8?B?U3BoeDN5czRIU1dTVGRFN3NHSnU3cVBZbkZJWms1Y2FZM1VabXh2ZlNaSUtM?=
 =?utf-8?B?SVBReEFlZFlLbHVHN3lBM2ZHZ2MrazFVdEFtN29odk9IR0xsTnN6SnJWcFV3?=
 =?utf-8?B?VjBnOVZ4Q3RZb0p5bWw1VTN3Z293NmhlcGpVdWRYMlZtQVIyS0p3OEpVV3pl?=
 =?utf-8?B?OWxJVHpVSXRxbEhtdlNwQzVtakYrVVdCUVJ1VnhhZDVaclEveGl6NmhhekNZ?=
 =?utf-8?B?Q2plSDNKcUw3cldGZC9RTmZKdjdsbzJTTmt5RVBRcjhZNkZUVXd3cmxDem1j?=
 =?utf-8?B?ejg0cytMRll3bFFoY0VQaERsb1BodmpCL0ZsaG9NQnQ0ditNUE1sM1NQV2ta?=
 =?utf-8?B?M3d6QjA5czVaT2ZuUjZLSGE0VkJZQXNyWnNkSUE5SHVMclZpL1JGZk9rQnpJ?=
 =?utf-8?B?OUdCdlVFeThtWFpEQytpZjNlVXZjRlVHckZkSTc0RG5ZTTZlcVErdlJpOGdq?=
 =?utf-8?B?bmthMXFsRTAvT1BRa2QzOG9rQVZQZjVsb2RxOCt4ZElyUXVCSS95WWYreGYy?=
 =?utf-8?B?Tnd2THpQRzFlaitRVUVCZVdVdXVra0tjeG5Fb0llNFdoWUl3eVRaNUZvWGNI?=
 =?utf-8?B?Z2pMcWVYTEQ1ck10Yi9KMTdKQVFyS1p4L1N2a0RrQlB0ZUZYb3FyWC9SWUQw?=
 =?utf-8?B?VGxwVVZWckhsMnptdS9ycGhNWFRqVTNnR3hoeUVhU2J0TkR3VVNnZ25OQzl1?=
 =?utf-8?B?LzN2bGVFdlhOeFpjTzMrWjlGbzYwRGprYks5QUJZY2p0cHltYTNMUDF0T3pJ?=
 =?utf-8?B?MkFwR0x4aEF2RDRKWmJSVmp4NkR3L1duNGQ1dGVHMUpVSDJPZ3g2eEEzUFls?=
 =?utf-8?B?bXVDcGpxMTM2ZmRCWEVuQ0gwZlAva3RQcnhUVDRxczB2OHMzTEpCdkhGUlhx?=
 =?utf-8?B?RUdHQk5ZN2MvSitjK1Q4OWVSOUpXeGZNWWJVd0o4bEp5bUgxaHVsbmZqVFBq?=
 =?utf-8?B?dFlDS3ZGOC9rbG9MZmk3MlhkbVNJcEIzY0w5Nituc0JTMFV1VEt0TWF2ZXMz?=
 =?utf-8?B?VGZHMng1S3E4TWZzSFRKdTB1WHYwbTVOYmNFeitGQkdiWGtVelVmUmwyQ3FM?=
 =?utf-8?B?aEZUMnpqUG1IbmtFYVgybTRoN2UxeXVheXFadGE0VzVTNUYrV3lmTTZ4WXc5?=
 =?utf-8?B?a1hhelk4VG4vK0pzOUlXRXJTU0wzVkZqcFpCbWZscWlNME1McTJRMVdiNit2?=
 =?utf-8?B?c2R0SU9PN0RNUytBbHAzaFpaRG9UQm1nUzUreXBSeDJ6V1pzSXdkMTlvRHMv?=
 =?utf-8?B?NUc1REFGZG9vR0N3eVllWVRJdWpFYldtTi9mdkhNVzhMU1JMODlBYjBQVG83?=
 =?utf-8?B?dEdjU3ZqTW52NlpaR3J1WjdBQTVWM005ZW5aTTJwKy94ZWJkWEFpeHNDejF5?=
 =?utf-8?B?YlF0VWpOc3dybmUwV1VJZz09?=
X-Microsoft-Antispam-Message-Info: Tock2UKTCzOV9bKJqGzuSaZBDD6yfCWYy5D6C+PzvHrBaCVebpjYUf9SaTygZgBC1woMxcaMSARr3sSvyCvcX8r6hrFfA24i8kx3X2JycTN4lXgDT48h5iDHvCfaMUmr54ciBpq5sNkAxFZ8Tw2IsY1noK0afbAqKx6CTXi0P1JJejbqedOp4HBQUoQLwx5T
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2599;6:1M3LdpvWdd9Fara58rI83pkVYYK3aELn2iBPJKUK3QQo9AkV064EBKMChyJbqMovQrPs/vDDF3mYQW1QDMKQDXqGlNht67YgmBEiSaS0w6kG+lOIYZxLRp98ABWmcKU2qOPbkMw5w9CzzYuOWjF80aFb4DHIRjL1kQTYMKsKcLtP4olav8Qk7GteryVqjuqVy/XB2sMLC/9D7lLu/zdQjpoXRjxwB756RcGYXRP8S37CVfVUdVICvJE+PsQUE84p3xYWH4YYcd51MSnVMW1l/y0SzFqclsHbr96Ap6I3Pu6I3jjL8N20xGSb4hx6JUImsGO3y32CFv/ALhBNLB7FcnYzUHOdgfzj8B54KIz5rdb25FrlvnY+gLjTebV0og8aMEEcVoH9z/kcsGjFhwAQNoA4amFiniZw3QK31PvGjV5i26+gB6Orq2KZDZBFoNf02kg9a4HMflcdgdZdSc2BwQ==;5:H8KsLFpHv43FisCQj67x9tXbyIgKRn1EwCFtBo3SP0AoAt7N0aJ0Wvs0PLCRpRl3Bv7iPHXxihFBx+n0DehmTN/1v9JxgdPyLEc6DZTQBmXrddZsooLA1bMb2qKuCtkz8trkwqWCaP6jSqIlffLDtFbPFxKi5QC6ciq4PoXEwJk=;24:6zzh3U7g+ebB/UNmbCEnKu46SVbiZvoSkbdeCnLZwILgod4KhFQUasZUldS8sukHOiO2obRs5yV8htg/n3m6rEpADq30vsdAgYRVo8igI9Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2599;7:7oZMqS3c4IGzhQA0MMsMPTJPBteaiIB5ccgfvnuUI4ErHHvOJloXiiJCUGja+x5XKpTOsTngMBp9a5+QFTnrjBRtNmWb9ConAbJjTBHDTUIXgWhcDo/10hA7ehZuqWpOvCdA28hDtSHsyg0Gpdek5Sf6iMIVBtRRl4wlm40e6lonW05fbG+kBrn+/iORG9BFr7pyblXLk6Am3ffTynnGapa5bdMUKgltbika2+1sp7Bcf4N0FaQMD3y80/HJzxNA
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 21:09:08.2805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e571007f-1367-4884-35ce-08d598ddfa67
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2599
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/2018 11:25 PM, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>> Sent: Monday, April 02, 2018 12:58 PM
>> To: Keller, Jacob E <jacob.e.keller@intel.com>
>> Cc: Tal Gilboa <talgi@mellanox.com>; Tariq Toukan <tariqt@mellanox.com>; Ariel
>> Elior <ariel.elior@cavium.com>; Ganesh Goudar <ganeshgr@chelsio.com>;
>> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com;
>> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-pci@vger.kernel.org
>> Subject: Re: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link speed
>> and whether it's limited
>>
>> On Mon, Apr 02, 2018 at 04:25:17PM +0000, Keller, Jacob E wrote:
>>>> -----Original Message-----
>>>> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>>>> Sent: Friday, March 30, 2018 2:05 PM
>>>> To: Tal Gilboa <talgi@mellanox.com>
>>>> Cc: Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
>>>> <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavium.com>; Ganesh
>>>> Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
>>>> <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com; intel-wired-
>>>> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> linux-pci@vger.kernel.org
>>>> Subject: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link speed
>> and
>>>> whether it's limited
>>>>
>>>> From: Tal Gilboa <talgi@mellanox.com>
>>>>
>>>> Add pcie_print_link_status().  This logs the current settings of the link
>>>> (speed, width, and total available bandwidth).
>>>>
>>>> If the device is capable of more bandwidth but is limited by a slower
>>>> upstream link, we include information about the link that limits the
>>>> device's performance.
>>>>
>>>> The user may be able to move the device to a different slot for better
>>>> performance.
>>>>
>>>> This provides a unified method for all PCI devices to report status and
>>>> issues, instead of each device reporting in a different way, using
>>>> different code.
>>>>
>>>> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>>>> [bhelgaas: changelog, reword log messages, print device capabilities when
>>>> not limited]
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>   drivers/pci/pci.c   |   29 +++++++++++++++++++++++++++++
>>>>   include/linux/pci.h |    1 +
>>>>   2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index e00d56b12747..cec7aed09f6b 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -5283,6 +5283,35 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev,
>>>> enum pci_bus_speed *speed,
>>>>   	return *width * PCIE_SPEED2MBS_ENC(*speed);
>>>>   }
>>>>
>>>> +/**
>>>> + * pcie_print_link_status - Report the PCI device's link speed and width
>>>> + * @dev: PCI device to query
>>>> + *
>>>> + * Report the available bandwidth at the device.  If this is less than the
>>>> + * device is capable of, report the device's maximum possible bandwidth and
>>>> + * the upstream link that limits its performance to less than that.
>>>> + */
>>>> +void pcie_print_link_status(struct pci_dev *dev)
>>>> +{
>>>> +	enum pcie_link_width width, width_cap;
>>>> +	enum pci_bus_speed speed, speed_cap;
>>>> +	struct pci_dev *limiting_dev = NULL;
>>>> +	u32 bw_avail, bw_cap;
>>>> +
>>>> +	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>>>> +	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed,
>>>> &width);
>>>> +
>>>> +	if (bw_avail >= bw_cap)
>>>> +		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
>>>> +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
>>>> +	else
>>>> +		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d
>>>> link at %s (capable of %d Mb/s with %s x%d link)\n",
>>>> +			 bw_avail, PCIE_SPEED2STR(speed), width,
>>>> +			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
>>>> +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
>>>> +}
>>>
>>> Personally, I would make thic last one a pci_warn() to indicate it at a
>>> higher log level, but I'm  ok with the wording, and if consensus is that
>>> this should be at info, I'm ok with that.
>>
>> Tal's original patch did have a pci_warn() here, and we went back and
>> forth a bit.  They get bug reports when a device doesn't perform as
>> expected, which argues for pci_warn().  But they also got feedback
>> saying warnings are a bit too much, which argues for pci_info() [1]
>>
>> I don't have a really strong opinion either way.  I have a slight
>> preference for info because the user may not be able to do anything
>> about it (there may not be a faster slot available), and I think
>> distros are usually configured so a warning interrupts the smooth
>> graphical boot.
>>
>> It looks like mlx4, fm10k, and ixgbe currently use warnings, while
>> bnx2x, bnxt_en, and cxgb4 use info.  It's a tie so far :)
>>
>> [1] https://lkml.kernel.org/r/e47f3628-b56c-4d0a-f18b-
>> 5ffaf261ccc0@mellanox.com
>>
> 
> With that information, I'm fine with the proposal to display this as only an info. The message is still printed and can be used for debugging purposes, and I think that's really enough.
> 
>> Here's a proposal for printing the bandwidth as "x.xxx Gb/s":
> 
> Nice, I like that also.
> 
> Regards,
> Jake
> 

Same here for both.
