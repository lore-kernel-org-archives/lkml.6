Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeBYKE2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:04:28 -0500
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:61172
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751653AbeBYKEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:04:22 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=arkadis@mellanox.com;
Subject: Re: [net-next PATCH 1/2] mlxsw: spectrum_kvdl: use div_u64() for
 64-bit division
To: Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180223131540.1065413-1-arnd@arndb.de>
From: Arkadi Sharshevsky <arkadis@mellanox.com>
Message-ID: <7de58656-c772-c13b-5a35-b6065adc2128@mellanox.com>
Date: Sun, 25 Feb 2018 12:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180223131540.1065413-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: DB6PR0301CA0057.eurprd03.prod.outlook.com
 (2603:10a6:4:54::25) To HE1PR0501MB2459.eurprd05.prod.outlook.com
 (2603:10a6:3:6c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ecf822b-d11c-4d60-ee28-08d57c372364
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0501MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2459;3:aW6ihMvjYy5n+DLDnz7xU8XQLRku+AAQh9OguDdCPLVjoHh3Y96XkZW4sNSaaYFmJQq6DYtgqUxqmicgjgYb2DuQRBpEiP3ELL+2HRamvt01si47D6CLp4VUNgX/s8nRmkv6s7J2492QFps1JcIVuahiFrPimSp+7cMX46S9dMvFQytzUBBxjceKRbeU52vbasCFIm4IxliXf2bvyiPAEetl79zRooN3yNa0z6yAOiqJdJyUh1KdSI9Unoe0eOoF;25:1vAOd4QdsQTJ09CYuGuYM9nCigxOt6k5DXXPeP5D2HxVTp8Ha0AQYOzwaNAKoQcpQlwxoX0bFZmYoI+12MmSW0oLxIfN3s9U6jjDwSU7H+iO8bJUdtbx8FaWqZzhV5eROe5eH2EMJ5P1JAltC4j9j0uvot4s3OFwvUi73QN0lu9SSb4gmNyvZcWq0TsXSArCWf6fgUKayn6GFRNgaNLCHDz4pm9H7qY1TPFJ9I6WXyVsrRhEbDGj7Csn2cqVrEMac3o4EH84h76neJXGy4QIs1F9D8D3MFVA8hMK/G1FzokshQhDmvdOC9pHmqisvChIJWJIVqJlXsIgVDHBL9CBHw==;31:nGAy1Z9dC556uQD94HRHrv/qnZlNZE2p8vS0cW4nkCTVqxvMSlpFIM2eXkwqALcqrA/YCi6gf6zM8TGxLd56uIqyQKlkgkZlk6Q6o5Z/N8V/PA7kFmgcdfRxgiCiuM1to1OvE0F9fTkprZR65k7L55+IftJFALLFqFTZqDHp1RIpB0beyoT4FDMp4ObGoyMTJpWupMv6w1PLLiR2Zr8rj83IjzvO2MZ8xZxFvuvymJc=
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2459:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2459;20:adypikOqZ4Rc6ivJfApeZ3nl1o+gqxcMHBF+YQLncBbkdV909oHK6AKPBHDXfsDdL4dhZ7UTWzrOMk1DFhdhSTvBUI+6sUm2b2QFW3/vNGAlO34Lir6j54GWZbwF2HzBDiACuPh2VrjqFbnUv1sEHV+fcIwyAC4B6qzV5UCssD8e3cutxzfHJHG39OWt/H0WKxSGfA5vvPjkaKwzyWe0iXko3eWvNC28k8WZHWIF0ylZHG9MRGc2eUCUDeAKcwgQHte9l/Wf0geMMhFDR8XHjthjk6wZ/VAy0riC3ofuUTurVwhegSK/SFAWo7VgGXeRml2OuXmzbApiZlJX3IEpO5u2wWaqxE1bZW43mF1o28t0SbUkZ4T2f8KYMxfb2X8C/rYihQCSVQScAUo8fp1IkXLnOTlGb562FKD8FkIVL01gVdSOo0qwF6OlID45KuIlomnnYbe0USpeIXuhKmoV6QjyTTJLOXjBDM7WhzZ093AALWWfEqoMM0Mv4bvDhooN;4:FR+ufb2EMvur4ck83En294jHK726w/rbV2/zNRDn/OGaTqV81/xZSwy1QJaD+CwcfNI0wsqRyT7eMvCncpsBfaSOPqvi4Fzmnb+Hk/58bgknFISjiUyYqSdfm5qFX+dQVk1prJpNv4qcN0ZiHHde0/CWhD7XgbeQP4DUwZcOSyTrceruqLW2tajX2WWuzprfjTRCK6w1yY+LWhvXf6TBkmS/rswhu0OGaRnFhto8sAr1M4ty2ZTU1RBoUh+JjSlj5cxf7cJKf4fpCv6z/64xjg==
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2459CF56819129399EE0CB1DC2C20@HE1PR0501MB2459.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0501MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2459;
X-Forefront-PRVS: 05947791E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(189003)(199004)(97736004)(66066001)(4326008)(6666003)(478600001)(65806001)(65956001)(47776003)(31686004)(36756003)(229853002)(76176011)(2486003)(52116002)(23676004)(52146003)(86362001)(8676002)(6486002)(6116002)(25786009)(3846002)(5660300001)(26005)(2906002)(65826007)(6636002)(7736002)(50466002)(68736007)(16526019)(305945005)(386003)(59450400001)(53936002)(6512007)(6506007)(316002)(8936002)(186003)(81166006)(81156014)(2950100002)(106356001)(6246003)(31696002)(230700001)(64126003)(105586002)(53546011)(58126008)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2459;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1MDFNQjI0NTk7MjM6V3BzbTN2cU5qdnZDNlQwLzRnNnBQV0Q4?=
 =?utf-8?B?OVRISGVLYWtWeXJ4b0Z1TTVheEFkekNKL2pwNlJOYmpPZmtueGRzR1FpRHg2?=
 =?utf-8?B?ejZ6bmltLzJvdmNPMzZVeUprZ0RUYzVRdFc1NWh1eTEweDR2WExjVGpTbjMr?=
 =?utf-8?B?WFIrMG1QT0lNSi9aYjJzNTBKSlVqTlVyWk5ZU0hnM2dSaXhwc0k1ZWFrbVQx?=
 =?utf-8?B?M0ozalpKUGxsbXEvTlM3dWE1MHlMa256cURqeXRSemdXc1JmbCs1eUMyODN4?=
 =?utf-8?B?RDlMWk5ibi9udzJkN2dRWTN3cmE2eDlVNU81U0UxQU1nandQYnc0VjFPYVR4?=
 =?utf-8?B?SXNBeDlwRjZxVEhUM3g4clVhdGJXcW51N2JoeFRUcVBaUFUwWUF5QzB3Y2FX?=
 =?utf-8?B?cnVRKzdGRXk4VjhIeFdGblk2T2ZxNFdHMzFLWW55VzBLekxqaVptQVRFSytQ?=
 =?utf-8?B?cEJxd2FZbG45VWtWa3liNmtmWmcxNDJhdStHQ00vOTZETytKcGtQdlAvOHpt?=
 =?utf-8?B?RHBDUDlkTzltUnNYTkdrWDFMVHc3N2loN0dHTmNCbVE4UFNaQTBPZklJcVcx?=
 =?utf-8?B?Mm5obG5LeC9SdlpZM0dJczR4aFRRQlVxZmx0K2pUMnc2aDdtR1NPN09kaEND?=
 =?utf-8?B?bzlyQ3VjQXJteks4TUFWdW1RQzFBSTk1TmZFKy81dlo4U0hZVVR4UmVFb2xh?=
 =?utf-8?B?YlZWOFpkOW8xQXBqQmtmRDN5UHpHeEpxbklNR05vVkdob1BTSHZPbkRZTmNZ?=
 =?utf-8?B?dVN5N081Z25qd2Y3eUloalVQVlVjQVEwYWVpSmk1N1h0a2YxcE0xWXo1czRq?=
 =?utf-8?B?ekFWNjk3YWR5S2I3dVRGRXArOFIxdWF5QzZ5a004emdCd1l4cVRUWVRwcStz?=
 =?utf-8?B?MmJjVnhDSjUyN2h1RERaOXdQNnFyTVUrSDJMRkl0Z1FZSWQreENzeWJ2S25j?=
 =?utf-8?B?SmZvSGFBek1QZy9TcXdUME9YNWFGNG9teFNlbWJEUnpUdGY0Y214UXNqcWxG?=
 =?utf-8?B?OFFmcmgvcTBsamVYZHJHbVlXdEZaNDB0eElyZ0pLUXk5MHhFMk1DNEJiMjJk?=
 =?utf-8?B?RVM0eThkcHk5R05DNnVUR3B6b3h5WDN3Ylk5d0pUQ1d6VDlSUDAvcjVySFp6?=
 =?utf-8?B?RTRzMjRVK2VZUzJjbjdXQnczMnBUYXdrd3FycGcxL29MbGkyRWdkY21OaXRL?=
 =?utf-8?B?RnlBcU9VM3c2RDd4aVh3c3FaUjk5cmYrS1A0Yzd2K0I1VFJpMzl6VmNMeExk?=
 =?utf-8?B?aXdsSW5tMjc0S0pESWZ0OE5Sc1p2eEVFREtOaE4zQk9aU0xtaUlWVGM2b2E2?=
 =?utf-8?B?WTNOOFlkVzFXNUxhWElCQnR4QmZYL2U4aUdMelpTbGJHcUVZbG5XVzZUUkN3?=
 =?utf-8?B?VVdSTzBucDdwVU1LNjVWODlMUittd1p0SmJ5YnBYTi9oVjZtRjV4bmw4aktn?=
 =?utf-8?B?eVV1bXNvL2ZTRUpJdDRoZ3VqbG4xN2U4NHZyWnVPQjdkQVhaK3RzMjBwNDNz?=
 =?utf-8?B?c2hxNmxVZW5rZGcwNzlMQVhMVmh0eWZENGJYT3RhVkVDS091SE9YbHROa0tj?=
 =?utf-8?B?eXFZM043UlBCYVZVWnhwQmVnQlc3bkVaaW5hRUp3MkwvNkt1Y0dka3AweW1z?=
 =?utf-8?B?bCtyd3hzSnNxelloNm95ZmhOYldpcEJERU1zd2pwZ3dEOEdPUlZERUhJdTc4?=
 =?utf-8?B?dlBtcUZkbkQrRlVzT0JIaWtZdk9MZkJYMWVzOHpJYTc5L3NRbW43RSswS3RQ?=
 =?utf-8?B?aEw1TlcvYU1JSmEvMTJRVU9Ma08xdVNlb3Vnbnpnd2ZCME52c2ZZbXozYTZO?=
 =?utf-8?B?bTVSZ0ZnRHc1SlNiTnUrWEEyS0tKNW1OVWVUaElnQnZkc2c5U1lZTHdHZTFi?=
 =?utf-8?Q?wvmbU5utgfA9NA3sX/ChIqahIZuEnT4ETj?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2459;6:LxotiWop7dLR4ByjCcPbVNfnWTXKoW/l+puah/kE3677ng78QCbkx30Dl1aHkkX7jr9ceXk7Nwo4dP5iD7WEfrSWgKqoEi3GnpTk4q/FxKO+EZ4l9Rhm6voLOc8ktuY5AF19hMXaKwCYCJ9PDCHVXhicUaaslDvqz8Slbph5Pz07UMSSLS2vFcWGAUOSpRhSiGbRhVBzWb33r4EaDkyzbcM06RoF/1s2NdAVpDMO8jy3XauYdpl54BEujEZ1MxObXdkGV+Gs8vQXKG5weE9bCLMG2ejJHrtY26HW53dNLJoqgNvfTyXo5lC1gUjxi8LUHqwwaE5/vhYPRg7rNPNEDnR/3uWLyDQAddiGzckRBaU=;5:qA0s0q7o+UoIiOHJ5NVHhg9OCAjXKfe5wiTXoElEaX1LkyPmKiCgZI6uhXSHwMEiHgYc9TCSDk7B2PJgt8cxMGgbFwzRFbQf6oZGdzX+spKieOiwRI7b7Z/FLgIVtHQrYHCg9iUaw25mtJ2g2jSo9ej81+h0P1vLItO+shFGRnE=;24:V4CVncPdf+LcQZ+AAjk20XqP2BHLSFU9Yeqo1ladz4dLWHoCC/j29v6lL6NR0sjZMyHrrnhZYFhyGjUNH+jjb2PZIuutwLeBhavzGZvsd78=;7:X6TbzZk1HOgJ6OREzejY2AtH9433NXt29AGXpJJYVIhY/aDGdLeVrOzyk3xY8GIAqfvETel0iRn0XQxjbOp+W5GqALhI4uEn5541pDKX9jJ+KFUH0q1qBswXxmpMkGnu2qljbbozedd1Xi+aztjQ3ccdSg0ND5/Grve7DVn+qmQ8qvO9Waoc3qJcSYtD8dHYkHZg9SLORYhfoEY7hTFlqyYdY7JoyEaBVgp8noa30+aCal4dQGyo6DsBhFU67Vno
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2018 10:04:19.1187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecf822b-d11c-4d60-ee28-08d57c372364
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2459
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 03:15 PM, Arnd Bergmann wrote:
> Calculating the number of entries now uses 64-bit arithmetic that
> causes a link error on 32-bit architectures:
> 
> drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.o: In function `mlxsw_sp_kvdl_init':
> spectrum_kvdl.c:(.text+0x51c): undefined reference to `__aeabi_uldivmod'
> 
> We could probably use a 32-bit division here as before, but since this is
> not in a performance critical path, div_u64() seems cleaner here.
> 
> Fixes: 887839e6960d ("mlxsw: spectrum_kvdl: Add support for dynamic partition set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
> index d27fa57ad3c3..6fd701db90c9 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
> @@ -278,7 +278,7 @@ static int mlxsw_sp_kvdl_part_init(struct mlxsw_sp *mlxsw_sp,
>  		resource_size = info->end_index - info->start_index + 1;
>  	}
>  
> -	nr_entries = resource_size / info->alloc_size;
> +	nr_entries = div_u64(resource_size, info->alloc_size);
>  	usage_size = BITS_TO_LONGS(nr_entries) * sizeof(unsigned long);
>  	part = kzalloc(sizeof(*part) + usage_size, GFP_KERNEL);
>  	if (!part)
> 

Acked-by: Arkadi Sharshevsky <arkadis@mellanox.com>
