Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeBGVxG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:53:06 -0500
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:40847
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751039AbeBGVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:53:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] amdgpu/dc: Fix enum mismatch in calls to
 program_color_matrix()
To: Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Tony Cheng <tony.cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Yue Hin Lau <Yuehin.Lau@amd.com>,
        Zeyu Fan <Zeyu.Fan@amd.com>, Charlene Liu <charlene.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
References: <20180207214352.109924-1-mka@chromium.org>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <dd39ea9d-5bf7-cca1-f805-f16cb5c2bf94@amd.com>
Date: Wed, 7 Feb 2018 16:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207214352.109924-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: SN4PR0201CA0028.namprd02.prod.outlook.com
 (2603:10b6:803:2e::14) To CY4PR1201MB2468.namprd12.prod.outlook.com
 (2603:10b6:903:d0::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 169267ce-9296-4622-f99a-08d56e752834
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR1201MB2468;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2468;3:HfrHAgzUKkNfeRzGlvwIauLuUKgr14Z9j1EV5nD22Z2r5gEgwO7oe9m84ODVoAthXFdl64tWnBTfXLf5ofcZmb/qQ+dgMVTMIpfvwEFASX4WkwW79y9EfOILbtDFi0sJoIbt9ZboiJtEJHU6H1zonxOoOoQvN4MmPN5yDI1uU2iy1ofz/2OkoPwTaDk+o8OCSKkhMCod6I/LXX2h5q2ALkIN2AoT3tGKZ+8FtBo7AreAXjZdRsD11uETmlvFPPNC;25:VK5qEn5n47oLHkafLhfYuYPF4Y1hUbnAkbNNF4qqKDkM+2Kkt5rJCmgJm/AaBWUl+G/1cYa0k2dYQq8Me1gCcvmhQjhGKPXGVRk+8DBrxxpzrIvM6vyfpUSFQ+Nq8BmNRmECf9pq785OnPA2bPgTbpKkeXc39lCJfJkWIgmB7fuJplSuwajLMzEGt92W539W5jSvVD5IoMj5XQ6iEHLFH9SZzQRslK0TnmpUpohezXbLM5WHprxwlQOVP/eRFrMkpQiAsgdzQHIqAZBMRv2AhcRg20RbXVvlFJli7cMYcvRmPnkQDXtPv761sQy8P0Z3jT0nn3THu7htx9+XBx4B7g==;31:KevGVFtypvc+EPYnxWPmCPCnxKQpel2wkbtfJcHWm1MqwRcZUDxH/eJk1ZhaQb/bAVKIJ2jfTnvT9kR0W+9Vrlp7Aeq1b4oP9zMy/mTgzMJNz9X4khC+EM041bvtglbDFed02lNRyQp8d+fqvmF/TBLiOYQG0HKJawNQwImYFnGkqWSJlk7K9gQfyYJiImaIU119NO2817K6YXsQ5smFXMySc/KeNQQVvKRV/+x0RGg=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2468;20:wpbMXRx18uvIZ5VcfmF3VbTdYJmts1tkYI+mNNv1mmQTW+Im7OMQ2uIEPwtogupYMllMC7D7UJoo6VulD4z4Gf2owj8w4UtoVWEezyqCI3PVNM97GxmuQhv+uVnR/8z4YETee3/HhYIYLxz3pv2llfiIb3yskZzQmYtvLO+TZuUl1DqZQkBxGGATQ53NYHb0HNeqz47jC286i6lt49VA43TLIbKxfTCjE5m0pMFnVgpA24geqmpRfDqUdXMkU27aEokx5Wnb9HBWa5gWOgvmIhkM0KYdceyQ+FnXFa0MXoj7swnEkHNA7qjFTabY1QHsSnQVsBbVnhVcvD1X2Az3ckEDiBFd3n8KqrHjYzMH1L9aqj/nNbvXXiUohnGEqChzAfXjlyF1Lfg4a2M5AiQEbZegYgJSrA6YQR8gex0R7p4ZjB6xVkNIs0vEqkZW5ckVNxZcnnSi5F70ah0AD8MzMOg0ThrFGphr5Aunyk2Iuw+UUyECeGPwqarKuromLRPU;4:aQx2fJu1khm8jVb9mBt5loSZRo7f+0fth6d94JVgGoNRasJM1/we0XSCSWK5Zw0lid1q016oiZjOgRtGcgEKcVws1ipX3a2CiKXP86QcPFIyao2gDrAZ51FNR9l8SR0vuA9U/g/GOmCaaUIkP/E77dtMwhFXS7pYxU7vZC59oenebI02TLHQPk8NM3NhK7aMP1N3wuReYzm6CyD/xeVm6NSKRsbwUqt+3im/cvQ5RpO+iqKCwg72nQFOxrnQ7WmX2UELhPtvc+kwFRI751UTXH/I6ZbRwedTGPAMwiGVIZXrY00uVSsZCBG4fMUddVh2
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24689D2E205480766E96A3F48CFC0@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR1201MB2468;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB2468;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(377424004)(189003)(199004)(386003)(5660300001)(50466002)(65826007)(53546011)(77096007)(26005)(186003)(16526019)(81166006)(76176011)(8936002)(6636002)(53936002)(23676004)(305945005)(7736002)(72206003)(25786009)(230700001)(54906003)(59450400001)(83506002)(478600001)(47776003)(4326008)(81156014)(229853002)(8676002)(6666003)(110136005)(31696002)(2906002)(58126008)(52116002)(16576012)(316002)(52146003)(97736004)(2486003)(64126003)(2950100002)(106356001)(86362001)(6246003)(65956001)(65806001)(31686004)(66066001)(6486002)(68736007)(36756003)(105586002)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2468;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjI0Njg7MjM6L2o0MENhVWMzaFpCNWZJRDM4TWljTXE0?=
 =?utf-8?B?NlQ2NzZtK05PRitCS0F0Q2JuYWx5MGgxTVg1QXpDWWowd0NnSUdxSVIxM0RC?=
 =?utf-8?B?dTNLcmVxbWkzWDI1c0JST1NuQ2dnQk4yZ1Z4MjJyVlBLWkxNWEV1eWgxdFpD?=
 =?utf-8?B?Q25sQTVQY2FlQ1BZSERONkwxZk9KZmJlU1lXOUVUQzZKWStiMnBSZngyV3E4?=
 =?utf-8?B?ZXZtL1h3andRNkhVKzd1ZjRWWXVXa2lWL29ZbWc0dDRsaERQMzREVERpV1Va?=
 =?utf-8?B?b21kenBLL1FjMGxIRE0yaE9vS0NiTEV4dG1uOHJPbWFOc1FXbVlZaUc1d0xk?=
 =?utf-8?B?eXd5bWVEazgvak8zQmJBWjlNckJJYlhRcVNGNktwaiszL05ZZ0xEazF6U1NY?=
 =?utf-8?B?QlZtYlE5N2pRNG5VOUFYTnVMSko0Qnc1Nlo5dk51WUNQckZWV2NoankrUjcz?=
 =?utf-8?B?K25rZE4zaldkQzZuTlkxenNFNnFEWFJwZDlwbFZJNGU2b2taYWFvN1lzVktE?=
 =?utf-8?B?NllOcU1Hak1rQ2N6WEZTYnh6SWgvRVZFSnBaWmVZMElsdmJqb1REbVIra3RG?=
 =?utf-8?B?OW5FbzJnODdIWmVVWVJkU3o1OUNDMFVjbDJpNFV4Tk81MEU2SkgraUl0ZFJO?=
 =?utf-8?B?eTArKzFRZWtYM0xyNE9uVmpSNGNyNk1VaXRCK1lhUmN2UzRJOFJoRStvY3Jw?=
 =?utf-8?B?UmlSdzVtOFEvcDgzVXRselhaVnZmTWg2OXhHTjRrY0g5Q1V3dENsU0NkczNY?=
 =?utf-8?B?YTB0dm1XY0h5Q29qS0ZvMW9nQUR1SURDamZEUFhpejZvc0R0SU5kck94dWZI?=
 =?utf-8?B?NlJuSUZhVHUxL3lZa0oyZ045MTRLQ1B3TS96RGVjMmRGNXAvUmpZODJmbWhW?=
 =?utf-8?B?TXljaE5iMFFGQnFWNHlhblRaSnl1ZHpaR2NGbnhlQkpYclZGM1lsUUY5NXlB?=
 =?utf-8?B?SXZNbU5oYVdmWWl5S1VTcGVEVzArdTBEK0R4bjN0ZXo2dC9lSy9qeHJPS2s0?=
 =?utf-8?B?bS9CU1QwNTJsMTFrOGR5dnlJTUpjVXE3T3l2aERnNGdXYUN4ZXRXeE56R2FE?=
 =?utf-8?B?dnowZGM3d0x2NVpmLzZCZU5Td3JIQjkyamNKUUVsMFNzTjlvMDhBUTNLRlFM?=
 =?utf-8?B?Uko4NEhob1FWNXQ3MVhQTHo3amVrUTYrd3V3ZWxGWTg0VUFFSzYyb1JONlNj?=
 =?utf-8?B?ejF5YzU5WWpLc0tCZExONjR5THVuWGgyNkxCTlpQUE1PM24zeGZOcWlVa0dW?=
 =?utf-8?B?NzRKMzF3TUErRmtzUStnQXY1L0pHYUkwbFpnZ0M0ZS8wRks2NzNPb2g2OVhs?=
 =?utf-8?B?cGdYRGtSMkFpZUxmQ3RseURVbFN4dmpZL1J0cUhaelV1M3FvMmdpUExRa1Jo?=
 =?utf-8?B?am1IR1FRWVEvSzQrU29YYXdtVFRBOS9yaVd1ajZRcHoxZkJkbHJRNXZlUGNF?=
 =?utf-8?B?QmsweURCV0xkazkyM0swVFBha0h0YStOU21BUXZlckorQ2d3N0FNWXNIUjRp?=
 =?utf-8?B?YkEwUnA0WVJuMmhKVVlXK0NiYUdCb1A5KzVONFNHdlR6RmlzdXovNGFucHkz?=
 =?utf-8?B?VFozUm5YWEpPVzNRTFV6QkNUd1JDZzdtK2gwSTkwb242Z2pWcEVQWUhTTXFH?=
 =?utf-8?B?UmJlVmJPODRzZStUVGlINmdOTks1aStETHVOMU0zM3k0VnFKREZlem5OZnUz?=
 =?utf-8?B?R0hSM0hjbXlVUFI3ZDBvTGsxZGhsTFZOSmE5djhLT0ZXQ0RVVDhFOW1ZekdG?=
 =?utf-8?B?MStmdGtWYVJvZlk3dmpwemlLN3ViaEVxRVdZVjM1SGpwaWwydkFYZGpaRTRh?=
 =?utf-8?B?bkZ5T2ZYdGpGTXZVcjJkLys2QjZtRkp0YWNhVVVmdFRGN3N0Um1PenJ0VWIv?=
 =?utf-8?B?VUR3em5LM2Qvd0xSVWp3Nm91M0RkL05oTWV2bGYvMkF6bHkyR0luUUt0UUlv?=
 =?utf-8?B?THRqK1V6OFY0QnVPVGRrdEhWZkRYaFFJRytEa3kyNHlnaGpPTjIxMlg1dkdN?=
 =?utf-8?B?SmxWMFdjbXQxUHNCeWtKNmFFMTVxTDkxVEVRNnFiTGptUTFrOGNXZGsrQXBj?=
 =?utf-8?Q?tmMGgA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2468;6:h5KKLzp3LC7BPYUixpDTSffmjPlwAstT/Boy+gczDLlS6kCuQQRiaTQY9yR3Kurf74RAJTNggWkXBtt+eAsL6QRhmluyHqZ3TJOESMW4uACOCAOPRRZOYBKBuwI6f+Ui40L/hCcMXGkmlz+HNWOYy9/gS/qONEf3Poc5qvJN7DtGedQDBGZzSKIE0RwpRsVuX7d/YwToO/pozVCxa23LuEYHX7AnGhmahP3+SnjkGyI5mtvOi0uaKyqHuQ4E3em4UewYUgNQZlFPdX4ZBsxjg0u2gNlPFK9+YeMbnkmLHuJNEVAX38FvU3eH1xId3R9uJQ4j7G7yiNt+cIBiouAYO3MBJO4rF3YEk+H0bQ/M3sg=;5:42kDWHnrONFZc8vXeVr/bA4Aq9XwijZMoN2TT3q1PkDB4cUbMDNPlI2/ZeX2Zd066jbrKvNFq6KNGZJJUxzz1h+YH85T4IIQXZInOTRDaj++2iGY7DLZ1h8u0/UXwUIJbqWXVgQhQDnvDh6pI3dxIItThugeI6QiZHv/y4aVi6Y=;24:br/JaYcqUSJLFw7Ft8ABZrrLGL5ECg9v6Q6f1RAspcNw2jwK/ZiS069Dmr2zzZlrDjdsUTsR5ibiOxTQENKtv9fOwjLNrDGBZxwyfqN/d6o=;7:OiODfJQuBP1nqZybon18aRCJB67Zk2xORLw6O3VSg/tt7BmdhYgni+LctqH5VTB8CI62D8WMXA4t48hAcSzvq5n2n5wtqLV8uMViRu+0BktYLs/QJ8P1X8iaJBWfhz/B77o9TOmgsgDynjbcPl86/91lM4b+wjbNwXFhbTJGybkCZDEG2H6hnfe1BADDm4I8plHnIP9mljTCUP3G0jRjfbb3joiCkDlYD1Oim3s7oPWeHVgHamX3r8X4g5pcf6Mu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2468;20:FPso/4go8NlW3U8wGxullQUJxVln1TDxkfg37SuPJKDQh2yHYorokGqVPhgZxaZ7bBrmG6P3GEZrlFaxcztYz9EbCL6bYZG5LPKSc/4mgcbOgRx6HLMBx+LLqUF5hHlpK0laETM3JMqIUXfeNoM2JjPUIAGPFPDnmShpeehMlEqaWWJt8jzvWgxdvDHkYZ38vDfUaMALMsPDK95BALm3xvNfIfPegxwjXINEoC0iETvdLBOvGSyLfPPLHKDjOGBr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 21:52:59.1488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169267ce-9296-4622-f99a-08d56e752834
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-07 04:43 PM, Matthias Kaehlcke wrote:
> The driver passes GRAPHICS_CSC_ADJUST_TYPE_SW of type enum
> graphics_csc_adjust_type to program_color_matrix(), however the function
> expects a parameter of type enum grph_color_adjust_option. Supposedly
> the intention was to pass GRPH_COLOR_MATRIX_SW, which has the same value
> as GRAPHICS_CSC_ADJUST_TYPE_SW, so the mismatch didn't cause any trouble.
> 
> Pass GRPH_COLOR_MATRIX_SW to program_color_matrix() instead of
> GRAPHICS_CSC_ADJUST_TYPE_SW, this also fixes the following warning when
> building the kernel with clang:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1129:24:
>   error: implicit conversion from enumeration type
>   'enum graphics_csc_adjust_type' to different enumeration type
>   'enum grph_color_adjust_option' [-Werror,-Wenum-conversion]
>     xfm_dce, tbl_entry, GRAPHICS_CSC_ADJUST_TYPE_SW);
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c       | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> index 0f662e6ee9bd..ac28113c4d67 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> @@ -1126,7 +1126,7 @@ void dce110_opp_set_csc_adjustment(
>  			CSC_COLOR_MODE_GRAPHICS_OUTPUT_CSC;
>  
>  	program_color_matrix(
> -			xfm_dce, tbl_entry, GRAPHICS_CSC_ADJUST_TYPE_SW);
> +			xfm_dce, tbl_entry, GRPH_COLOR_MATRIX_SW);
>  
>  	/*  We did everything ,now program DxOUTPUT_CSC_CONTROL */
>  	configure_graphics_mode(xfm_dce, config, GRAPHICS_CSC_ADJUST_TYPE_SW,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> index feb397b5c1a3..4245e1f818a3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> @@ -727,7 +727,7 @@ void dce110_opp_v_set_csc_adjustment(
>  			CSC_COLOR_MODE_GRAPHICS_OUTPUT_CSC;
>  
>  	program_color_matrix_v(
> -			xfm_dce, tbl_entry, GRAPHICS_CSC_ADJUST_TYPE_SW);
> +			xfm_dce, tbl_entry, GRPH_COLOR_MATRIX_SW);
>  
>  	/*  We did everything ,now program DxOUTPUT_CSC_CONTROL */
>  	configure_graphics_mode_v(xfm_dce, config, GRAPHICS_CSC_ADJUST_TYPE_SW,
> 
