Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeBYKFJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:05:09 -0500
Received: from mail-he1eur01on0086.outbound.protection.outlook.com ([104.47.0.86]:8331
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751558AbeBYKFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:05:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=arkadis@mellanox.com;
Subject: Re: [net-next PATCH 2/2] mlxsw: spectrum_kvdl: avoid uninitialized
 variable warning
To: Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180223131540.1065413-1-arnd@arndb.de>
 <20180223131540.1065413-2-arnd@arndb.de>
From: Arkadi Sharshevsky <arkadis@mellanox.com>
Message-ID: <907aca10-130b-3f2f-3960-eca019af3664@mellanox.com>
Date: Sun, 25 Feb 2018 12:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180223131540.1065413-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: DB6PR0301CA0046.eurprd03.prod.outlook.com
 (2603:10a6:4:54::14) To VI1PR0501MB2461.eurprd05.prod.outlook.com
 (2603:10a6:800:68::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e53f15b2-79c4-43b5-bf8c-08d57c373bce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0501MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2461;3:Plfck5wtrmC8WUYFLPnvsbZjofq1XqYEC51W3HYh4jG4k3Ndx6IfzIWQ3BoVvm+DdgwCNLfLE+6OvEmoiq0pH6vXGWwgDPnpy0DjLM1dAhrHVHM9061Uhrs+OyXFwqyJdG9LL8B8KjiDt5KyuErlzgwSWmlesxlbm8zLciGTgu6dETPaipW10lbhm6ySbbg1pembcdh6ZGezMNbk/ED9VXvQNz5yzo2Rq0g3NsIkH61GVXaU2EoE+S2rY8W0P9Ov;25:TQJDLyL+rsf4xTIN7NxR9L9hU/MXxe8eMTBfmcJ5D/7PMYn5JZ3eOIBTTVll+Mfd5oT5+79qMKf1uObuBaakwGsHU7VFK1beRu4vYhTJSMDcTNK4UZBS+tMpXH8JelfZXWi5bKWzfOPdG6sBybjwgVcwuCmRGfrVRjCJCll/Y8DkCmFloXT39LYSpOIDsawlS4Zh4pohi/7qcwDCaZg8fnbkVI5AA/9hnGRsGUJ06KyPvYbwja9EgZtqznPT5EMGN4RHo/LHp8nVDx/CG3IxwwVkQjmcwIhCAEQcFVDisFZrMIJxzHybJCivURjSzcRM7OwHovhEGKqRQuY/BbkA0Q==;31:/EicOeqJ5tmWb0+9oIlOjLGey5nbXPjQLR+1THo9fYSoRS98rYpT10cdq9fAml/CpaPhU5pY9/DGjQ9zpsUbDAIjjOJ/2BCWRxW8d5DKlZY5JbN/AzNZlJLmPzsTWhOlhum0odkNcVYSOriJlNP/zDTzvpdXtJrwRSQJ3TAYV4VASts/LwhiDyZHEUG85+Jjlrj/sj1BWqVnH48WmJCImhGr076BGuMEP9TDSkZh+6c=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2461;20:zo/BgVt60/M/C6JM9mJ4Ro2E7KtSkIyNGWCNR2AYhJpm8MJfoQNhmL9yAaRc4/CXcRpqliZC+D9+Q8JXVM4jVlxzwY8UkepNMK3O0Cntk2IgGNkQR1cuN7WQi78BTZnoSAbGg/QSf5AypcXp34vGWHEv2K2a2IOTpNeGu1AiIaKlM1pf58GbGK/KlMtWsN7lo81tJVypT3lnk2VsyW2RshV4c+4CkTa3hhbK2fCgaX6lOqw7hsEmuMUjTg3UZPiB2JQTk9M1mtuI0bxX+ME0hRXKbOWPVfM2z2JSljYop/KQKbEE+UxRoE4FlW8LQCdIWn7VYwZGY8t2to0f38cUEbMCPZii73Zo81pNnOgHUHWkrLbEUpVRdRidsZkdSCz1+3r3L+XyndxyB6e1KLXsJP4VkEpAhCRtiDAse1a4Ex/HDYzFBHrzgew9+xH0bvXDhVxxI6Yd4zVbizejGCbaqQ7DcO/uEjBEiK6PJnfORm+24mn3Krn189i/i6WOF8ez;4:uSVHUmCRwgs4EElj3YxGVtpRDVi2RweYobPwJIihha7GadVp2W7WyhggEUvpo4qi1pAGJppKpb+miQrzMos+UrMrLij6mPAgXy5UHKF2PBlrzjH2o4xu34OeHOC9sKedYU71vPsIFNP2w9ly3vlJpMuFd9LVniaL/GlxPyOPzyK495h3feh/4ctOTYYWv10IXyZ1SIDeNSEtiQBT5MbGqlo4pHpjSYAWiO74qAvbC3/KrFvXtrI75Q5s1kWhAMaXR1AowNgFVnYexiSc0Jwv+A==
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2461EE890E56E1AF0882B8AFC2C20@VI1PR0501MB2461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0501MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2461;
X-Forefront-PRVS: 05947791E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(39860400002)(396003)(346002)(39380400002)(199004)(189003)(64126003)(65806001)(6636002)(81166006)(4326008)(6246003)(25786009)(53936002)(23676004)(81156014)(8676002)(6666003)(86362001)(6512007)(305945005)(76176011)(58126008)(316002)(52146003)(2486003)(68736007)(230700001)(50466002)(6486002)(52116002)(7736002)(229853002)(8936002)(110136005)(54906003)(478600001)(5660300001)(31686004)(47776003)(106356001)(105586002)(6116002)(186003)(53546011)(6506007)(386003)(59450400001)(16526019)(2906002)(26005)(31696002)(65956001)(66066001)(2950100002)(97736004)(3846002)(36756003)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2461;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjI0NjE7MjM6RzJmR2poTzBhVzJnR2lvKzliNEZnTWpk?=
 =?utf-8?B?ZzkybU5HeEt1RkhTVlRmenJEYW5tSUlISE9TcFF4Y3lBaHFiam9na3cveGRZ?=
 =?utf-8?B?NWpENndlZis2N3gxeHlPK3BSais0YUxYeFRtN3h6MzNnd0JvTFBMZnVkRTI1?=
 =?utf-8?B?MzhkL3lRYkxQakx2bnQzWFc1Skp4NVNxS0dZOFY1R0NpWVFvTlZwV0w5Mkto?=
 =?utf-8?B?dmRGb2lYUmc0ME1MOWZMTEw0alM1ZThNNkVuZDRJc1RHR0RYNm5nVEZ3aGZq?=
 =?utf-8?B?a09lU1pBUUtpc0tsZXo1eFdTY3VQM2xsVXZyUWhmRkRhSmY4N0trdkppbEQy?=
 =?utf-8?B?RXZiV3RDMnFtWFpEMFkyNlFnTE1CbWRmM0FicTNtQWIxMEROb1cwL3dGUk5Z?=
 =?utf-8?B?YUJXQkZYeStoaStIK2daUzVockZrazhiYWNvOVllYVFUbk1scXFNcXo0K2tp?=
 =?utf-8?B?YWhSMDRvS0VLSS95R1d3ai9EYzFZbGZtaHZ4UzFrV0ZzVzFnNlBUbFJKdXZJ?=
 =?utf-8?B?Nmw1aGMxMXJxS0ZQK040cEZ6TFVueEQzMllhSmZuVEdWaWZncjhpR3dWWWlj?=
 =?utf-8?B?VzZTTml6a2NkUExZbC9scTVTVHFaemJIYWdIK25nT085NExPY1o0L0pRYjk3?=
 =?utf-8?B?dDc2NDhMcElFOWh1REp5K1VJaGZFTFlvN1dsZVpVRE1CQytHVUdQZ2VCa0hw?=
 =?utf-8?B?R1NtVXV6L2VMc3VmSW1PRTRtZ3paZ2xPQXUzMXh2TkFiQVZEK0c0S2JnVDBa?=
 =?utf-8?B?ZjJveHpQZXR6Tkk4TUlpQ1hHZ2hSbDZOUkYvQkxZNDNxVWlLUTNSaXkzUi85?=
 =?utf-8?B?MU1LcGhBckJUdmd5NzRSbUVqTGFEN1BnU1Z6MVViZTVXcFB5aTdLS0pGeVpq?=
 =?utf-8?B?c0NkRFJEdDJLVWhlZ1ZKakY3SkN0SVYwTnZvZGlKOE5RTjRWamRlN2ZwT3JV?=
 =?utf-8?B?OGJpc2ZDTFVKQjZDM0F2bkpWZ1BkQ3JUdHFIaGFVSWJGblVhMXNBMmM2U09Q?=
 =?utf-8?B?OUVUVDd3U2hlbCs0d2VjTFhDeURVa3RQSHk3My9jMk9vdWJCbHdYNWJGTVJm?=
 =?utf-8?B?M0xwUk51cjhLaUtkUFczZG9zMFBnVFpBRjd1R25DV0lQbzNpcmt0SWNsRjVO?=
 =?utf-8?B?c3VzNjJwUTRKSEwxb3h2YU1hUm9JNmQyVmU3MWhWZTJ5OGgvQklyR3lWR1NY?=
 =?utf-8?B?TTlrdERSdGRRRmc3UkhwR0VFb1VtOU1sTXI3bTJncGcvdmJaT2MwaGZIZWE0?=
 =?utf-8?B?YTNuaElxSk1YdTRFSHFuRXZYczBMNnNUUmhOSzBVS2V1UnB0U2ExZ1N3dmhK?=
 =?utf-8?B?cG9ERldOUEYxdyt4TEpTNnhTalpBdUdhUkNkTnVHaGVVQktxU1JoQnZDaUtH?=
 =?utf-8?B?Qm0zWktiaDV6Z2ZUVEhkZitGNnl1dTI5MmRuWUd2dEt5b0QweWJwbndhTFhG?=
 =?utf-8?B?Y0tnbnFrRy81RHZ3WWUrRUZYbnVyUTY4amJYRlJZbjg5bW1KcjhPaGdUUDhQ?=
 =?utf-8?B?NGtabVRzZmNocVNDRnRHQ0ZLZUxIRlJBT1Vhdnh4VmNOYnV3RmVvMExreW93?=
 =?utf-8?B?YUhGTnNXYVorajBmRG5xSGkwUk9COGIvQktLbnNkaEh4OWtyL1ZXZk5MNlRo?=
 =?utf-8?B?SnhoOXJ6MkRza2MxQ3czNTMrZkNIeGtncFhoeWxIL2FqTURLTS9PbDdwL2pG?=
 =?utf-8?B?eU96eTBzVDgyZU9xTGVEcDlGYVN5YmdEZ2g4aFUrSzhBOWtOVWppcGhFVkVT?=
 =?utf-8?B?dnJDZUYvU2lRdm42ZXlLUllQVkFDVktTWDR0N0t1VnVBUklXQ2hPWkdZbUd4?=
 =?utf-8?B?MnQ1M01saTRKa3pRdGhzZEJPN2pJS2JvRWpDcERtL2hEMXp3SElhTFQrV0sz?=
 =?utf-8?Q?nLLT74UH2H2hcmn6QMOLahzH5MNLh+ueIE?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2461;6:e7IWb86O+j3Wm1Ep2cbYIdda+CzY/ZMYiSzJcC4pYgrNOIfjFSbiAMUZQnXLby0BDQT9UOVk3ipodSbzqLdIPDyNV7Rosxext8j4+TZ7ar0CJi1vsk8pBmuBnPjVE1t9Y7S7eiTArDEBRbYkGMggoXtUaLWkIdrm4b1TOfr4r22koFaGb6lSRuOrUBoNiGgeAvaOc8sgxna3hKmV9Yu4vKrANEEJrFsR0KC8BhwDxKPLyfokuqlbBEKeK/jmDGoUrw6RczZi+/IrvhuDGMMtZ2s73zUNa00oJqaE9TfkzIXHS4/t0G9NemORi2+XM5OIaggbte5kdHfBfErc4eInPvZNJecWNOpojUDDVT2fa/A=;5:fliC0vhsxK1i+Bt4wlu9QjcIVT4e3/zjA4esQaOD21TwrFL29vdKSEzMEklQMmv1tBI17mq7nlbBjBIfSlj79QjD/XI2vF5WUhQK4vkw5qJVs8vjo6CueB+ocJy4FEi1noP0ZoP9+fKxfWEZVDB1SEpCZBj0K7VEP/CRC4Jf6wM=;24:F3zvAOWJVO3mwgq8ebLjOqh95NDaj01xZQx53OBENrWqISTJEZKl++NYHUjXcirejfvcfX6j/9U3J2igaFs8dtYEJ8QpS3MpiL4qdHc30tM=;7:qHYd9WqnsFr821CzIN4mxq2QyepoL9EmOUv/cini2+HymDmEbcI5RKPcYyaRvXfcT8rZxpJTd1KebYibYJ0Po51sPrrJc4LErmX1oZPyGq+oKNVib5RpA47qXk3rMycyNXu86+fae8nIYRH1HH2o0jsQToQSH7A+9Kv4yDywjunEG8iONXd5DViIO7Si5r5ENOE9Qc/U/N9RIv0qtjdRQ9UhFKPJbc+N+tk45lUPyD3gcnq6qN5ooPGs8e9btYYK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2018 10:05:00.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53f15b2-79c4-43b5-bf8c-08d57c373bce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2461
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 03:15 PM, Arnd Bergmann wrote:
> gcc warns that 'resource_id' is not initialized if we don't come though
> any of the three 'case' statements before:
> 
> drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c: In function 'mlxsw_sp_kvdl_part_init':
> drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c:275:8: error: 'resource_id' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> In the current code, that won't happen, but it's more robust to explicitly
> handle this by returning a failure from mlxsw_sp_kvdl_part_init.
> 
> Fixes: 887839e6960d ("mlxsw: spectrum_kvdl: Add support for dynamic partition set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
> index 6fd701db90c9..059eb3214328 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
> @@ -270,6 +270,8 @@ static int mlxsw_sp_kvdl_part_init(struct mlxsw_sp *mlxsw_sp,
>  	case MLXSW_SP_KVDL_PART_LARGE_CHUNKS:
>  		resource_id = MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS;
>  		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
>  	err = devlink_resource_size_get(devlink, resource_id, &resource_size);
> 
Acked-by: Arkadi Sharshevsky <arkadis@mellanox.com>
