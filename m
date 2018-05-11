Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeEKTly (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:41:54 -0400
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:40112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750746AbeEKTlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:41:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v6 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
 <152604925157.106201.5299224478351644530.stgit@sosxen2.amd.com>
 <474751d1-02ec-9e00-26c8-36988ad83092@arm.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <e4d15552-db3b-824d-42bb-51cdefa7ac5e@amd.com>
Date: Fri, 11 May 2018 14:41:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <474751d1-02ec-9e00-26c8-36988ad83092@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0011.namprd07.prod.outlook.com
 (2603:10b6:803:28::21) To CY4PR12MB1446.namprd12.prod.outlook.com
 (2603:10b6:910:f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1446;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;3:Eo0wZo/8Q9GBpIIGV6qzZioaVZWlWgTvmOgz2HyJcMvKMlDt+TSWJaLCgcNuSXeHVRcNncx7btDh2E5y6ig6I3YFUFx6uMDLA9hs/tG/A8+s0dFDaKLLyZ8/tCY7ZqgubPh1pCoO+gy2Kn51pzuD1Wrj6sVfxA59ZhOEViyM6V3XGaNVSQBoi9qLhqmIdyYFx2wcuFJAqPY3ubs1OZyPXn98PnwXbHXpatZN5B/dYKVzPlGWgLmRcbmaek/8Ze8z;25:9yeX0GtKIfifY8Wao0T/IIWfC6Pds/ihd+PretU9OwBwbAQzhMf21TCv6faZoN7928Lrlt8or6S1a0ouULsy22Y/ZLv9F6u6eJiT29q924Zbzx+8PUeWzmgsLnuSNTZfhuMQ5AVaroCJ9gCCVjy8JTY3xD8DtoePb1kOB3wSC6SW/gfT8uRmLTXf095brIG2foZ/maXfg5qiPq76ylnY8KVQGsNE/3I3upBK9uEDF2vh5v/26WtshQhBTEQm0qCT2hkkSsK6ExxeU3e3ybSTKrpOqZT2Ql2ILjKMXhblpXPZSDASiKa3M5ZIdh6fVlcInSGT9q8MyViYRjTOK7wbbQ==;31:Npt2186CfgHVGj14L1Xyji6y4+xopNw9PUyEdQVkzDF2ySCB3plXoWQjS0CXs1IPmPVGVXCGkI32siqQF6kSjPB2sjRwtGLgf/chHDqgxx8a3kOdx+7v45UFdx0cW9f/2yZLJXNmK4g+UO0SlJJpNc89XBjVksdVJ34qCpmsuUUlPMAzIxi6DEFtPUH5ie1Q0J4PZzBIZDtU2oSmpiRluQdubz/ezdpo8MSiYlSyKSI=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1446:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;20:ndoWyojhQXXrgH9QfYxP0nizx2IH71b3BC6MWIZfNaokMg8hAkCFb9B6w2as1r1YePkD2WyIRG4IxksBD2jGUISxZzCFmDUNGJ65T2DTnrftPyloR1+zfhw8sjtKO1UV00V5dg7HSjjIclQ748UPR311m23Xy0ydeQL5a9swVhbB+sA+WhIXfJpYHpT6b+JgXdqqR/sZ++wBAjXV12t0Ccy4HuyByLC5EANfaYUfHPkpQ5r0JLAvzlNgb1swGRh7iCBO6x95HJnd7vp4PS7zoGF5lP5/q7FwGc3TFusv1jgC//0VU0r32S1ZZCVFQMSu29V0o+x5J5OU7fjZk0DiL7sNHDjZFuQTIzACIkzce8IGYjwunw7k3fOYHJthguBh+DVL8cuu+NZrCmxWPWwWv9CISOSP3CXMmexvjYeqNG3HwLUkJP4fR1CZMFT6eEFDat24hrQA75BUWgsubFsgsTXlXo+DyRoOr8NcYhBf8/PBdcWXUM2bDIy1epf3GqTm;4:hK3by+frzeZKiX8/PZ2ryKsMwlZP56it/s2JW8qRta0YVD3jPHzlI1iTic6z4XG/KdjM6b6ETSEBmDRN7Q0x6+T99l+b8jyh4T+o1A1XL0BVNMRmxVhdUOCv33aLLY7Fnb+xUfg9k54c0kmCRRbEGUquiFLfsFsWf36z82oX/PemmKGgQZe3efyk2R6Pn/RR5fyTscoQjeFikCW8oHhJbcTTReiy6fcwHNlNQWnLb4YQMNNf8aroEQQnfGQzhlRY4Hj0zFAGoY5vK7qWD6K3SoZX5wfoxztp1HoYu0VlV4LvHP/eQRvY5MvHSIFZcqPucQGMF4PnbHV+9RMgiMHdQU/cWiaM42S2hnzP5b+ahuYeMkO8NxrtRln11/oDoqPz
X-Microsoft-Antispam-PRVS: <CY4PR12MB14463C4A2CA7AE1F2F357E89FD9F0@CY4PR12MB1446.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1446;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1446;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(52314003)(199004)(189003)(52116002)(2906002)(6666003)(305945005)(6116002)(76176011)(3846002)(67846002)(47776003)(65956001)(59450400001)(966005)(386003)(65806001)(25786009)(66066001)(86362001)(6486002)(31696002)(36756003)(575784001)(81156014)(81166006)(7736002)(8936002)(53546011)(186003)(229853002)(64126003)(2870700001)(16526019)(97736004)(68736007)(8676002)(23676004)(2486003)(52146003)(5660300001)(31686004)(53936002)(486006)(65826007)(6306002)(6246003)(476003)(105586002)(446003)(106356001)(11346002)(956004)(2616005)(316002)(77096007)(4326008)(58126008)(16576012)(478600001)(72206003)(50466002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1446;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ2OzIzOkNLWU8zSWxvRXQyQmVrQXNEUU1zVm5icnRk?=
 =?utf-8?B?TlVXU0o2MTJiWHAxTVdyOGRrblVEd0xaMVhTek9LQ3NtUjVGQVhEcFVqZnVS?=
 =?utf-8?B?MVJZNGZGM0NCMmhEcTBQUEFRZmhRSFpKNlh1cWhhbnV6eU1XeWJDMElTZEFm?=
 =?utf-8?B?bENZV3FUd2ppSUltM3BIQlY2akRPRmVSeEhldzZIK3RlOERXc3dVRERLREpa?=
 =?utf-8?B?Rlp1a0FKZ2hQbHFvS1I1MmFQMVBic1NVNVNhckoxeGZKYjEvTTNtYUhKdGpn?=
 =?utf-8?B?UGp0alBYTVZteVk0RC8reEpTU3A5cVU5S3FJRXYwenV0cHFFTkVMaGVxMVB2?=
 =?utf-8?B?TWU0c3ArenBNdEdTWDd3ODNjRXZERnQxajdRSTBjdUF0MW1xVVhvRkFzR1hO?=
 =?utf-8?B?dU1yK2V0bmNseDM1QjgvMFkxTGYyUDNWQUwvbTVoMmxNWU5RSHMxM20wVDM3?=
 =?utf-8?B?ekNod3BJVDlnR21SQUhhTFRVWldvOGlEK2VUOUtDTnVMcFZNenN3SnpkZnRv?=
 =?utf-8?B?c1lHZmhsejM4dTFzNzNtcDJkSUV5Y0QycktmM3BRQ2dJK2JleXdMYURiV2pr?=
 =?utf-8?B?d05YK1RNemhGcjl0QWp5SjRjeHVkU3dkWkcwdzJPcy94bEE1V2sxRnJRemI5?=
 =?utf-8?B?Wi9QY3pRRk1LeXhuNGlVWUFRUndNemVOYTBoaWhVSmxNdDFab29zM2h4ZGda?=
 =?utf-8?B?UTJWQm1SRmlEc3RWRlVmdWplWG5vTXV3ekhaNy9GL09sR1pIbFRST3dZNm1U?=
 =?utf-8?B?ektIY0FLK0o1N3FPbXpJQ2NVVENYQ0NBNWt5L1JjVGtIcTRFQTdPTmpobStU?=
 =?utf-8?B?Z2xENFJLYmg4RllSdnJUcC9rNnNUbHJKYUZaUE5UbHc2ZkRBZUtwclBQZy9H?=
 =?utf-8?B?ejQzREdpbkxaLzNBaG5nTXBEelllbW5NMGxhUjM3R2JMelBva2JieGdCNVU0?=
 =?utf-8?B?cW5lOUF6QVNLN3ZnT2tpMXhHNHBuOUNaL05PSlRUUXFRQW1qSDY2WDVrZWwv?=
 =?utf-8?B?S3NLYXl0ZmV2REpjc2N6UEZCWEFkSXIyc3NoSGhva3JObG5aNUFER0NVV01O?=
 =?utf-8?B?amRORVBBT010RFFwY0lMempjd2Q1dEpKa0cxK3dQVXd1dG1vajd4TjZHeFFM?=
 =?utf-8?B?bS9VTkgrMzBIS0JNQjd1RThrT2VWNEswMExxRGlZQmI1ZUg4Y2wveXpORzlE?=
 =?utf-8?B?OG9PeENaY2RBVENFTUJBSzFmV2Q3WlpYY1lrTElzT1hrWXY0OWx0TXBkQ0o0?=
 =?utf-8?B?TWRld1ZIMHJZTHp1akw4c0ZLdXpYK1ZGMDZsenlvMnpsUElES0RuTmhhOVlO?=
 =?utf-8?B?NDU1cWRwLy9DNlhzZy81TG5Vc3FFYTMreCtsQkxmS2wyTlp2VmFGbnh6Zmcv?=
 =?utf-8?B?ZWNETVAzcFo3M050SnpEd1RiNCs0TXZKTnl2RXZiTk9iWEdGdm9BMElvWGFm?=
 =?utf-8?B?QmlzMXNVSi96YlZ2T2JmOUJFbU5DekprU0M2ZlZSaXpVRi90Q1RGWDhiRVoy?=
 =?utf-8?B?Nk4rZFE4NTdDUzBFY2hQKzFTc2tZKzMwZE51WWFueVk2dFIxWlZsdlQwenR3?=
 =?utf-8?B?NTJzMnVPM055NUM1ZStnZmdwM0srb2thK2dTcEtvTmVHdHdOamlWWVl4UktW?=
 =?utf-8?B?T3hRSEp3bEVaMGwreVBFSGpqUkg5aUgzWm4xcGVvcjg2ZE8wMFUvN2ZLaFJW?=
 =?utf-8?B?MTdyMUNUU2xubk9mamRlSUp3MXhMVHVRdlZNcWt5VmNIbXU1R2JiQ25IKzRa?=
 =?utf-8?B?eENTbEhLTFYyNmVGUzZrRkZEaUlOSGVJRjZuRFBjeVVUbWZDWlNpMFdQck5n?=
 =?utf-8?B?WFM2REZHN0VWS3dBeWZ2d0QxeGR1Y1o5MW1RcTdFRTVHMVFEQ0dkQ096ZExZ?=
 =?utf-8?B?MzZKN1B0V3VpcWpKWXFIRFBUWXVUa2Q4UXhMQTMzaThZWmZCNVFLak03N05N?=
 =?utf-8?B?czlCdElReGlWREFEN2JpNHFCL3FIMW5La3JmZFhESVBRbU1JakNpMlpHdXdt?=
 =?utf-8?B?NUgxaGl5NnV5SVJ2dlJuaHdLYlBvTTU5QUpmSDBOLzZxcDJmbmdzcFZMTE52?=
 =?utf-8?B?eU9SUW05bkZzaENUQm0rZFEvTXN4Q1VPTFNpckxGWCtQNWlHODg0OGVjVk5J?=
 =?utf-8?B?R2c9PQ==?=
X-Microsoft-Antispam-Message-Info: P7JA06qfEpFYSQLiDwvkb2kcy6j8tBusPQZSPnA/D1zEv7tyc+PRjuOL1xEV6hCpnz4LjR2pGdOENUhyEBtfvcyjocz5TKpWaTIyCuI05eq/O6IsaoO4x1ajl0NN6VlqYKX0mlAopWVxSjaH1ZnQSA6Xj1lC9CHbofgV5LjIGsJnG2g7p64/pjOSby3zIbbr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;6:eajUXenzKdPBePUNPrXBegv49+6lEjvANupJW9Lgen5G0Y14FPGcwSgWVHZIuEd4Avwt9O8efC7qJmnZsOzy5m+RuQtxoUrDEkb1Ws3nOIKI9PHXkTJ+37HklcKdTxWN4c9k0AmWGZ2CQF2loyr98u3y24rOJgUsHcFhwpyNIrStLk4RwCWS5KdDr/HlRo8/1iouTvVIJae7CsCTmuXXTRTsur02mUTMsJle5dt/yzpDr7NouKHz7FMHX9OQKJFN12735oECiWEtFzhEnaknCUuT86vkIG71QjJABznkI4oNbCDD095BF0Adwv6KuV8GXmTSmwYx6pGnrOYaHuqEIBMhO9/9PexcK1zrFke0Uc0TEEZIk2vam/Y0Y4yoFqc2eG5ZLe8UTIdjU8HGJHOtMWPLSlFRZdCaEf+SZX+0UV8uxzVeDlJ/+3HwETAep0q6+DY32rC3iCqI+Ef7MXIlXQ==;5:GVilKMaav/XTS80kG7d3Efq9StTfRFOc5gAKT8gvAPASV+qLNjJrAcGtcZ6zTvnYc/Xh4c/6FKwT0GyiugRCl9oWFEKaTqSbjkG1vppFbTyfpnfqGIaDFaHHIZwit5z5fIk5lsGv8XK4LWPd0psbNJtt/6/1QNDxrPEyl/u8omw=;24:zlOesQ5Ip0kx/yiKojilSJ6hjRH/jloi3pmsLE9TAMYHZG6m4NN4VAThS6g7l0hSG+DOaqRbLdCSTB3bOtFkB8pJuQwa3eT1XmJV5+p8Gpw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;7:7LUdrRmHHvytppzjYI+cwFBSQ/b/SprfIDqg2+R2v5qzARhk1b79gC/o6iZt7Sweo29k9rmGJSTpqY3GVLk19mEt313/aQVWU/9QBijtYZwn44nUktLdcWWe5RLnQkthPmVO/XXtu8Kn/c42VTyU8UZtGA6nC/8S4wnk8YE6W/8Xdfspmax1PPAWHYT64IyWU6tDeKjVcyZwsjyr+IiKghQJ1ODg1Ao4S0oRPnP3N8QI0EtiAcsFpWEgVKQ1tmQ/;20:X2PelxbUUDVzFDmEkPG3oELRFHsbysj5XdH/KejT+4ZmnCgAH6CkCrbC3FOlmQ0g/4KpIEtqfQD8B5zVJqY4kbZ3xBWvgcZJ8Yoon+Qo1M+eXXlu5/une1mINNSSvMhbXL8bTgw9d6L2l1X+icZd/ZWp69IWV8GNeeIvyWsG4RlFZJ3grmmEj4nxcXPvDc2Gu5LhROd6dKMlGVnfntfcM5Md5igoymlUFjW8/ttqc263N1VDI1YCfnWMNXJ4cQjD
X-MS-Office365-Filtering-Correlation-Id: 74f755f6-69f0-4b6d-9139-08d5b7773ae5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 19:41:45.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f755f6-69f0-4b6d-9139-08d5b7773ae5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1446
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 10:22 AM, Robin Murphy wrote:
> Hi Gary,
> 
> Just a few trivial nitpicks below, otherwise:
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> On 11/05/18 15:34, Gary R Hook wrote:
>> Provide base enablement for using debugfs to expose internal data of an
>> IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.
>>
>> Emit a strong warning at boot time to indicate that this feature is
>> enabled.
>>
>> This function is called from iommu_init, and creates the initial DebugFS
>> directory. Drivers may then call iommu_debugfs_new_driver_dir() to
>> instantiate a device-specific directory to expose internal data.
>> It will return a pointer to the new dentry structure created in
>> /sys/kernel/debug/iommu, or NULL in the event of a failure.
>>
>> Since the IOMMU driver can not be removed from the running system, there
>> is no need for an "off" function.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Kconfig         |   11 ++++++
>>   drivers/iommu/Makefile        |    1 +
>>   drivers/iommu/iommu-debugfs.c |   70 
>> +++++++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         |    2 +
>>   include/linux/iommu.h         |   10 ++++++
>>   5 files changed, 94 insertions(+)
>>   create mode 100644 drivers/iommu/iommu-debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f3a21343e636..ff511fa8ca7d 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>>   endmenu
>> +config IOMMU_DEBUGFS
>> +    bool "Export IOMMU internals in DebugFS"
>> +    depends on DEBUG_FS
>> +    default n
> 
> bool implicitly defaults to n anyway, so you don't really need to say it.

Roger.

> 
>> +    help
>> +      Allows exposure of IOMMU device internals. This option enables
>> +      the use of debugfs by IOMMU drivers as required. Devices can,
>> +      at initialization time, cause the IOMMU code to create a top-level
>> +      debug/iommu directory, and then populate a subdirectory with
>> +      entries as required.
>> +
>>   config IOMMU_IOVA
>>       tristate
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 1fb695854809..74cfbc392862 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -2,6 +2,7 @@
>>   obj-$(CONFIG_IOMMU_API) += iommu.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>> +obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>> diff --git a/drivers/iommu/iommu-debugfs.c 
>> b/drivers/iommu/iommu-debugfs.c
>> new file mode 100644
>> index 000000000000..9df3b44aef55
>> --- /dev/null
>> +++ b/drivers/iommu/iommu-debugfs.c
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * IOMMU driver
> 
> "driver"? ;) I'd have thought something like "IOMMU debugfs core 
> infrastructure", but arguably it's self-evident enough that it doesn't 
> necessarily need describing at all.

Changed to your suggestion

> 
>> + *
>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Gary R Hook <gary.hook@amd.com>
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/iommu.h>
>> +#include <linux/debugfs.h>
>> +
>> +static struct dentry *iommu_debugfs_dir;
>> +
>> +/**
>> + * iommu_debugfs_setup - create the top-level iommu directory in debugfs
>> + *
>> + * Provide base enablement for using debugfs to expose internal data 
>> of an
>> + * IOMMU driver. When called, this function creates the
>> + * /sys/kernel/debug/iommu directory.
>> + *
>> + * Emit a strong warning at boot time to indicate that this feature is
>> + * enabled.
>> + *
>> + * This function is called from iommu_init; drivers may then call
>> + * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
>> + * directory to be used to expose internal data.
>> + */
>> +void iommu_debugfs_setup(void)
>> +{
>> +    if (!iommu_debugfs_dir) {
>> +        iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
>> +        if (iommu_debugfs_dir) {
>> +            pr_warn("\n");
>> +            
>> pr_warn("*************************************************************\n"); 
>>
>> +            pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE 
>> NOTICE    **\n");
>> +            
>> pr_warn("**                                                         
>> **\n");
>> +            pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN 
>> THIS KERNEL  **\n");
>> +            
>> pr_warn("**                                                         
>> **\n");
>> +            pr_warn("** This means that this kernel is built to 
>> expose internal **\n");
>> +            pr_warn("** IOMMU data structures, which may compromise 
>> security on **\n");
>> +            pr_warn("** your 
>> system.                                            **\n");
>> +            
>> pr_warn("**                                                         
>> **\n");
>> +            pr_warn("** If you see this message and you are not 
>> debugging the   **\n");
>> +            pr_warn("** kernel, report this immediately to your 
>> vendor!         **\n");
>> +            
>> pr_warn("**                                                         
>> **\n");
>> +            pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE 
>> NOTICE    **\n");
>> +            
>> pr_warn("*************************************************************\n"); 
>>
>> +        }
>> +    }
>> +}
>> +
>> +/**
>> + * iommu_debugfs_new_driver_dir - create a vendor directory under 
>> debugfs/iommu
>> + * @vendor: name of the vendor-specific subdirectory to create
>> + *
>> + * This function is called by an IOMMU driver to create the top-level 
>> debugfs
>> + * directory for that driver. The return value is the dentry for the 
>> requested
>> + * vendor directory, or NULL in case of failure.
> 
> According to kernel-doc.rst, return values should be in a dedicated 
> section (i.e. "Return: The dentry...") rather than as part of the 
> function description.

A style change that happened along the way; my model was apparently 
older code. I've adjusted for this new style.

> 
>> + */
>> +struct dentry *iommu_debugfs_new_driver_dir(char *vendor)
> 
> const char *?

Sure thing.

> 
>> +{
>> +    struct dentry *d_new;
>> +
>> +    d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
>> +
>> +    return d_new;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d2aa23202bb9..350819f1c5e1 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1747,6 +1747,8 @@ static int __init iommu_init(void)
>>                              NULL, kernel_kobj);
>>       BUG_ON(!iommu_group_kset);
>> +    iommu_debugfs_setup();
>> +
>>       return 0;
>>   }
>>   core_initcall(iommu_init);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 19938ee6eb31..25018ac0fdab 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -698,4 +698,14 @@ const struct iommu_ops 
>> *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>   #endif /* CONFIG_IOMMU_API */
>> +#ifdef CONFIG_IOMMU_DEBUGFS
>> +void iommu_debugfs_setup(void);
>> +struct dentry *iommu_debugfs_new_driver_dir(char *vendor);
>> +#else
>> +static inline void iommu_debugfs_setup(void) {}
>> +static inline struct dentry *iommu_debugfs_new_driver_dir(char 
>> *vendor) { \
> 
> Since this is a function, not a macro, it doesn't really need the line 
> continuations.

Yep. Done. And moved the curly brace to the next line.

> 
> Robin.
> 
>> +    return NULL; \
>> +}
>> +#endif
>> +
>>   #endif /* __LINUX_IOMMU_H */
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
