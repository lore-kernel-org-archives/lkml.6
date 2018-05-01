Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeEATww (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:52:52 -0400
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:42925
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750766AbeEATwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:52:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH 0/2] Tweak AMD IOMMU logging
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 14:52:43 -0500
Message-ID: <152520429853.30928.9793486018349326103.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To CY1PR12MB0698.namprd12.prod.outlook.com
 (2a01:111:e400:c43b::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0698;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;3:TUaPvjnEjC248g9ku4QWBqRU7q793fGdEIMmZN2HNlpjqMZ1ZY3arIJNOYdyoo4+OZx9wb+X5AWEgQaFh+kLdcsllz/q7QxWufU3nYiDusjFRexj8btkE7dSz/bx6SnI+5lmuUb71lP0ZBSeT1pm8mJjwIvRLPRdyi7AxqZDKb1apHM2YHyaBVK/p1dYA+ioYvXaDX0hTvltViCUkwruNzfIFQRDvFhYYkNmVmZyUCOEEqUBw95gTyVjI762QJ9r;25:AWyqDZ5yT0XVpRZGVS/G8tFHegCFUEs8P3c7aHi1GV+g1XI62hts9sk6X7UENGwiiJRLRjz7+YeTPqPHiocrq0O9nSpcYD+Sjz33yGlR0jRy3AbgtRzWzIOzZacZlIYLNF790UWXV2hUZNQ+B8wQsBd7lpsPdRoXpbA2QJMJnWv8j6HoXUpI9WCsuk7gQE/Q8exzyRHLDEYOrkTK5UiKxj/deFJm77i6QDj6zZ4NP39KPrxDmO0tt/0T1JLnUGtabkKszJWiiXIJNlw58cEQ5rgbZZtwF9+xkjeVsGdT76ziJ+Q7gHWIqDcwqMZHT22kQbg9tJl01GdovvWHwF1/AA==;31:8dG/8Yc0Hg2VeRzRhnJESdhL+9DcgJ6+xuCbbFun9iWUdmRLvTYtHYaPEYvjQikKnMHCmZLCDeB8FTV7Jr6uSLyE2vCZcKgwdaCmqCvjAg6CqIhsmjoSXdIZ4eu1x0TrNeGFpf/hSgv1/CROX9tk+UiOLSn9fzqgwYfiufCN2pFugDjk+VxP6ItWU+XwLSR2xpPnheeHUl+6kIQTHYoYSc0WizHqafkZd9MeQs3DNGk=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0698:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;20:Igp160rc4+W0bxKfrK+20cUkd6KBv7XWQG4uCKT1rui7ZFVh5U/yqQzwHPCe7gdb5thLrPJdylUqMs/UQ5Cz0plDUUMry/NMBlBs3t1o+YWUvgvW6FtI+ZycoW+7V4w0W4hOO/ILoLyTppoik27WZsLViTXOYo1jR9208HQwst64Hyw5Bjj/oxKi0UkiIeJyJzT27GlLCBq2qIIdTX8IEyURS595qyHv0LzGwAemvg2L576YmdQ07fwujSQyTdc6LSX7QQ4d5uucHIjYRb6YT8K7JknNIklUZDmV5K6w9juYsU9FRNMkuMsd3mQzrLNwZBQPost8cqgYwUnisl6Vi/ChxA/rnN8/X5jySLDd/p7aiNUOv5wVwrSqRpcXI+zFHAFPdqnkfnhBiUryOZtbOyEhG6psfy2lgt9do33DM2R6Rq0mFwWo+G6RPUotGJgiUS3rmoLwCRK3Q8MNWSjwH83toOa24DULT2zDtXpdb4R4hkO7jzrgqdli0bBxcDBW;4:DtQVFC2dO3uuEPbbN7ywsBKTEqPJYqs80igTjWLZRVDKRIinJFwWACkYF5bUk74LXCC2xA02UHrEdpWG0UhTKj1/UtdPr5IGmu3+eS9E6IR3rOTM0AApn6Iha1D6Y2Gi6k7eWPUIr4jQSEh7mjX9RSRBTFPg9xSc/X2Sp2oiqpesZHP97fF7NBi+Se4Q5ad81/7mVEC4aBgBg466ALjKv4jhJOx3GJH4euP1ZHXYl011jHaRU1IlX4YyPia5G2GXWyWZDBqLAp/rwu8uaBPfWQ==
X-Microsoft-Antispam-PRVS: <CY1PR12MB0698AA517D1F43CA6A5D377CFD810@CY1PR12MB0698.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0698;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0698;
X-Forefront-PRVS: 06592CCE58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(366004)(39860400002)(39380400002)(346002)(396003)(376002)(199004)(189003)(86362001)(316002)(2351001)(305945005)(4326008)(16526019)(77096007)(25786009)(58126008)(16576012)(3846002)(478600001)(5660300001)(26005)(186003)(68736007)(2906002)(230700001)(6116002)(52116002)(97736004)(53936002)(6916009)(2486003)(50466002)(59450400001)(81166006)(103116003)(81156014)(47776003)(8676002)(9686003)(72206003)(6666003)(105586002)(6486002)(33716001)(956004)(33896004)(486006)(66066001)(476003)(23676004)(106356001)(2361001)(8936002)(7736002)(386003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0698;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNjk4OzIzOi9CZWN2d3lCbk9uWjAwUVkrSDZhQzJpNlo1?=
 =?utf-8?B?QTFWMFRVQzBEc2NlLzBtM0Y1RVdrRGtWd0FpN1Rqb2FHcndwTndYS215dzhJ?=
 =?utf-8?B?NUhYQ21HRXpUWDFKdCt2UVA2b2NkR25xVFUzSFcxQWtlWEdwVkxVTkNOQXds?=
 =?utf-8?B?RVl0OURkVkZYdSsrU2lnNFFiU3dCaXF0Vk1uRGVsdWRmazhXMWVvU1hBSzJN?=
 =?utf-8?B?bmNUM1lxRk1JbGc3UDBuTEl2MUtZZzgxbHBYQk1sSXhFZGJyVnhxTWdyU2gr?=
 =?utf-8?B?NFlRRUdhb25ZLytNVm5OakxuOERWcTE0UXhLMTdHS2QzZ04yRjhNRFIzckk2?=
 =?utf-8?B?K2JIMTR6dDByVVBVdFdOMmV3dzFhc0wzUTFneTZ2OFZ3bGgxWGhYVUR2VHBx?=
 =?utf-8?B?Z1U5Z2gydU02MEZlVFpZdGhNVnVScmEzbjViSzJwTlpoalRoWnRDRzZOcmw2?=
 =?utf-8?B?bEF1SWs4SjQ2eHFpWjRoOG5tL1hvdHdjOE9semw5aE56akhtUEhBcE5mV3F6?=
 =?utf-8?B?VWxCNFZSdE9Sb2JwSzBNcFkxbWpqc1ZrYXFJY3lDWGtWelFUdU5Vb1lBU3Yx?=
 =?utf-8?B?TjZpdjBxWjZJc0ppb3VRVko4VFgxNjZ4K3I4bEFHY2FQNmxESDdyWE1laUZB?=
 =?utf-8?B?UENLblFVWEE2bVg3R1I0U1FoSWZSNjVDaEU5alpBSUJaVnNBaExFbHlLNWNj?=
 =?utf-8?B?Z3VhT3BocmI1SUs1eVB3ODZ5ZTIxaVpxVGlVT08yS0VzOUg1eDZkZXRvOE9k?=
 =?utf-8?B?OSsvb2JCNmJ6bUFRbFN2Q1lTTnhVT0pJa0Y3Y1lYbHlvY3hXdkNla0xXWTNB?=
 =?utf-8?B?ODl0VTA4cUFrUlRCL1FXVkNsWnFtbGZjT1g5ei9xOWw1d3VzNnpIa0JNaSs5?=
 =?utf-8?B?bTFmR3o5OEFCVFd2N09naGpLdjV0UjR0allpNnRndVkvNGFrdjd0ZUJReEho?=
 =?utf-8?B?a1ptNE83cTNnblkzUjVBc1RWVVBzSWJPR2dQTysrd2grZmR4QkJ5eHlOaVhB?=
 =?utf-8?B?SUY2TzhZUzlxSTlmaEY3THAzSmlRaHBxSlVOanZZbW12U2RJelBRc3Rsc0Zi?=
 =?utf-8?B?SEROV1RCcVhlRmV5NUM5VEpiOHd3OEl2eUJOU1FHU25Mem9ma01QUHJQUG1x?=
 =?utf-8?B?cW9GY1Q4WVpmK0xQV09KemVUaytidjJ2QXBlMTY2ajY3NTZTK3RJQ3hadVd1?=
 =?utf-8?B?b0FJQjlpbENMSHdiWjBGdWxjZ1cxelRCY1EramxGS290ZlhSTkVoWGlMcEZq?=
 =?utf-8?B?Y1dtMkl4ZENPcU1VcHJDbkFVUFdkcFU2Q3IzbFl2OUw4ZkNvRG0yd1duSkt4?=
 =?utf-8?B?MUpvdUhoUDlXQUtqRW0zSHBUSXRRQUlraThaRzZOeG8waHVsaVp3ZmNmM1Ez?=
 =?utf-8?B?SU5VcVk4RHY5NEpINmVxU283dFNGblVFM0RONTZZOUJOa0NtK0dWQWo5TzJU?=
 =?utf-8?B?cWFrL3R3eHpYa0pCVHJyRVVZbGxuays4bTZEbjdZQk1DYWd0a3ljYkVxTi9C?=
 =?utf-8?B?SWFCSkFVSnR4cUtmU1lKWGdrWW1HMGFRS093T2JBM2EyNDhKUzcvczRTQ0Qx?=
 =?utf-8?B?OUhSTURMN01vYys1TXNFWkZhdEozU0pQbWovaHQrUzJzNlRXdlBSUWNOVDA5?=
 =?utf-8?B?S2s3eDIwVWFjNXMxSi9kcmhOTjZWR3lKVzBPSlR0S0JJaExMN0MrOFRqOE50?=
 =?utf-8?B?a01PWGp0TmExYjJheXBWb1FDL09OSWk0V0w5UnBIeUtBelc1dlIxeTdFM2FW?=
 =?utf-8?Q?DNB4dQt+cFXASNXjW7tfynwoOu5UiK19A+9VU=3D?=
X-Microsoft-Antispam-Message-Info: PWbLJlPtIs2ZYm8CzVQhYoRSgH3mFyqi7IgDtTFBBC97kb0xw8OJtVV+KDpYF9FFPOIjlbb0lV8tJLxbRXeyG9XJI3vccH0of20QOvl5WVIyUCzHEjQQx2V2n5dkzQrljzyMYlcrjaNkDDuK2xTtKjNNrRJ3/0E9uyp+K55n7fweP9s5UrPHTch2GZHBl7Wu
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;6:kmmtj19PKGBhP9NKs8mUIL81VAnaOkjOWA6QWqIOn9JAUStXTU9zwxdt3hYnylzzifEDNonVe+zjH3ef9ZOr+zoSFyAn+rvF3HX+vdN4UGT0U6DP/HIKGXL6vEaM6L+JSQEN8B9hRnDbPsfUTLh+oFsqEkhirStqBFH4O4lC48R8WsbGETIfbN4jMeBXnlZnV0kXpK60qvQB6itVt3nRSkbsD0uIhWgtwFdSvcTkhy8P12ebgSGmvwncL+fBg2hcqTGnUqrVQBZ5Oy/XY569/AQbf/MhLjzhvATmUcZIxEYe856/EYqS9RFIU9bo2rE5ZIiEFxiZd0Mgzkn5cNzWL8UPnJnk2WBY9E44n/cRw6g0Wq+8d7by+VU3v9e43P50bGeOFTiHzZfu6gehL2nvMi4LXDoRnaV3eBGS9nmUwKjM4KEx/bphbTUatOiqO1thYfMlSfkmLTuLFHrwJRIZIg==;5:3B5YW+n9RbAIFuRfmSQ+PULSPLokyWEiTBG7c2CubRIILUAxFfn05yt2VUtG4RXlvn2dWvzmuabH64+x9hRHUS4wZZjHLkA74S68iJIWYwuKcGN1yzuwU/QUdkDG/hp2pGvgj5OB0LUh94EwtzcvrA8pcW7JAH2161NMoJQPY6E=;24:spp6Rezqu8CkOeMMRYSYLO35A2bkxvrw88UeIBc1xgshjQA+1gpEx2EuvLwpUIuaJCNoosHdImuKSrcCkPBce7YG3OcRnletTFMoWIut5gA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;7:R8M6WUBNsgsOlEtsP1zU/hJxBujayfCQzDDnkhNKnjSQG3Q1EeYuxzbAdHzvzcPlLe02zNTiR6/mUCAInsKV9cbgiWI0sc+10BoUez0pBp/8URyEYqHTwoKcxtlTJ3sQQYxzuKVwrcZlIkkmZ1rbioGhPJH7RnXcSV0AX3VHnS4E/fGrCxVpQgInK5OYs4n9mB73q1M3iF3WHQCyH5aQL00uStGbba2uSVsn5TBgTozt2C/xHG6xXfG6+AmEBNHM;20:P7Vo9ekGnV29wSYLf3FAhIdYU/FMNWkHOZ+of+6Ew/NLtjR2dy/33oftj5FM9bEjcfQbunmU5o+1xr6mKX7YGkoci6x6X4GnFTgKQpO3E3Ch4d9aAbadztjy7LXWJ0xTxW2vnEVP9jaQVNMdXcMcYpPaXmYRLmRoj8kEIH1NcjWSSZabVOsz3Yb43F2qZERcsmd9SeAaG498ZUCXC46Ihu23ISO07Auc+rvyWY1d54RmiRzefnz2OcrqF6ryFBve
X-MS-Office365-Filtering-Correlation-Id: 0ca10328-5ff3-447a-ff06-08d5af9d1c99
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 19:52:46.4248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca10328-5ff3-447a-ff06-08d5af9d1c99
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the AMD IOMMU log messages to be more precise, and
add a log message for a new event type.

---

Gary R Hook (2):
      iommu/amd - Update the PASID information printed to the system log
      iommu/amd - Update logging information for new event type


 drivers/iommu/amd_iommu.c       |   39 +++++++++++++++++++++------------------
 drivers/iommu/amd_iommu_types.h |    1 +
 2 files changed, 22 insertions(+), 18 deletions(-)

--
