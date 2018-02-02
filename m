Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeBBPjr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:39:47 -0500
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:36896
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751641AbeBBPjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:39:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/amd/display: fix incompatible structure layouts
To: Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20180202123232.477388-1-arnd@arndb.de>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <5307dea1-61f6-2c7b-75db-4e1a0885de30@amd.com>
Date: Fri, 2 Feb 2018 10:39:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202123232.477388-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: SN2PR01CA0001.prod.exchangelabs.com (10.167.12.139) To
 DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba0f0fa9-7b8b-47f7-8b0e-08d56a532b27
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR1201MB2472;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2472;3:NdXC3J6X2kIzGHJ+g+p/TYLg1v71UxscbpKXQLpveOH0PfusjFzcNoGPph1wge0wbCZIrYkOx6wV6oVxSZ7na49kgnfyTs9Jz8X9JdMYHhBwuqP1hEm2DHyODhs11/Dyz7ErLisyccw0tG+R8eTQuG1txsPovwYsNeZgZIrK6Qh072XxDPxhKdCsCktWQeUqoRvIhvY1AmM7qx1uLngcQ32Sob8gMtrSBSJPvb06OJHpUUwDbCEC7iZT6e5kIR+1;25:gjUTtbtI9sNaYOywcsLR49Gz3iqJLfIGKoTbR/YpSjt5DFZ7JArhhZol+QnWY4QAhk7E1zBlPs2HgOMbix585AVTa2HBwW2iGpzeMze6JM2EJucu4GSH8lcggQDG9Wg0ujOPUjK/ri7ZHDCub1RJJpYjPakeoe6mubkYLjMAikguwb9K1tJXNQtIC9fQSERS683rSwtykrGwybCUPbRtrocexp3YFTqwdL3kUGgWsA+ykySqe7m1fa0i/0rXe6gYHoVOtEq2Xrfwo7nQ38uc/LP7gsuaV9UppGgxFnsHDkrI6+B7dtB9r2sPegDbEHUHUNqYSP9JJpZl7pjT6YIb3g==;31:3rDMKSCEnKCBTpwzd6Ll4G7sC0ku3ZkIOW2+eqS1kuMfFEf6S96wu8hzJgDxYgDV3Sw4ZEk7TS8tcomiDkXm6+qumSN6odzMnhN0YFT0nzNoyZ4haUcFvd66MN2eZjeq96wnJGtgV/ImZdtqEnI9Wp+z74I4+mnZ8CQIGnkawYSvCBwMu5fI0eprWsl++ufjANcJn8R8g9cnGcDidl51aLVSSMVOIE4YfpG5r9YKdxo=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2472;20:nDZ90FcBK83ZyaRjQniufwjcHEDSw3IKSaPFhhZfJ94n0OYxadQY8sE5ZB1cCEed+pxGklPFLh5VhMFTgf/C5h6DdAAQZzbqnDO4BeAvf2TqxBHxNRHmYHSHZthBbcYsTq6hwfPpmkSVMvQ0SC4OK/XT9Hbax/hOVMM0Ve3+oQu/YJfyWynLdJ1hv0pBI2cklywysExTTH/3bGQQ+KOh4drRpq6rFl4ILeDUagidvsu0UsGXaoFduGHVrWQUnT5wt+sNrX6xNsuotRpQmHyNBnUTkxd0+0nkIW17uufuam5eyaJLvZPk6C8xyjF+lr9Qi+tIgiZZkLZrwf8+eLpiLuT6mdv7ZyXsrxoYn7u7SpBZaHbBxkRm0Hf4RBfU8C83fO3XtAsbYGPtl/86P5GI/Et1t2JKNcgoaUsXNPYI7c4lFelj7wrTYle2eb9j8VxuFW9I5j8yMOltg3HDi1kZl33gkxgPUA/4ZE9YSpIZiTewOMDGvZeUrXEBUzKKj+Wi;4:5upaEboS/yHFr1IdjTe2fxMfn1PLXluk67K44LlSHztqnXWz55/qGtmNHHmW7nhljxilFCAB1sEvgTbhS6io4x5Nk0BCmLUlxfqKaKCtMJfxRRL5PFs23UrIes54yUIP/0JEPuf03nusCc5yHb0rmjo3RsByWyjMnB1Na3BytRUkkg0gttaaK/w43T1koP+DbNGzHzGI8sDXb6azDVolg7kF7CjgSLZlUUlFKbFYAcwP2qoupozzIn740EUjj9xQBLode4bAgwknIAHLjxP+05RezJ1X9jXC2Pt3yl5kJbsGknGMdfFIe4hl1Lksxe8Z
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2472BCE26E8D03DB6030653F8CF90@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR1201MB2472;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB2472;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(396003)(366004)(346002)(376002)(377424004)(199004)(189003)(51914003)(16526019)(50466002)(66066001)(81166006)(105586002)(65956001)(47776003)(81156014)(26005)(186003)(77096007)(106356001)(64126003)(7736002)(8676002)(305945005)(8936002)(229853002)(90366009)(53546011)(52146003)(6486002)(65806001)(76176011)(2486003)(25786009)(53936002)(386003)(59450400001)(575784001)(97736004)(83506002)(65826007)(72206003)(110136005)(4326008)(2906002)(23676004)(52116002)(478600001)(86362001)(16576012)(31696002)(5660300001)(36756003)(230700001)(2950100002)(3846002)(6116002)(6636002)(6666003)(6246003)(58126008)(31686004)(68736007)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB2472;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjI0NzI7MjM6M1NtS2dYd1Ywbm5FOVpXU0x1YWlXNE4y?=
 =?utf-8?B?SS9UcndvRmlyRW9WcVlUUXNJUkNDKzhoWEt1M1VCenNNLy9JS0g1MUQ1VUVM?=
 =?utf-8?B?ZzNtcGpUOFQ2QzljUVVLRVAvall4Smd3OEU5a0owcGZ3dTUvOFRTN3FoNCtF?=
 =?utf-8?B?NTQrQ1R4NTQ5TnRGTFg4WmozWitCRkt3QjBiQXNDU3YzeXRvS3JpeXROUEJo?=
 =?utf-8?B?MlJUMllCVGZSSDgzYkdjaENod1JZNk1CRStmNTFtZy9xLzAyRDY3cFdRWmRi?=
 =?utf-8?B?VVlBQUNDMmdEdnIrNTV6TkxZUmp6bTUzYnMrUGRUQ1UrNVk5dkR2NVJQbHRP?=
 =?utf-8?B?Y3JQRTBQMmpEbzYrc3QweWxmVnc2SXErVU5zZ0lsUnFhL3krTlZwNlhic0pP?=
 =?utf-8?B?TXNnL2tOOHhKeTJGWFdUdkthcXJOdXQ2bU16ZExhaDFWclN5OXhDcmVFNXVl?=
 =?utf-8?B?cnk4OFpuSHpkaFBhK0FSdjd5WGhkdGYraFBYNVFuS3lyMkZGWldQSjRvZVQz?=
 =?utf-8?B?MlZzNmtVR0p6bUtiUTNKb2JtNWJ1bi9JWlI4RjY4bUNNSCt1TWJUQWhyUDRh?=
 =?utf-8?B?UFBqa25hTmNxRFVqU1RkdlB6eTZ2Y2RaUzRHc1JHYVRIcnBRNEpMM3owbkNv?=
 =?utf-8?B?TG55cDNOdGRjeCswcHFxcFlRNDhDM0FVczBoNXQ3U0t3RzY0L0gzOU1OV2Ni?=
 =?utf-8?B?R3BZbFFvMFA5NXZRR2JuckQzY1EwT1dsdUJXNXI1dDBmVDhCWTg5VWozYjdt?=
 =?utf-8?B?ZlV5Zk1IMEVZWXBWblFDci9wTHo1ZGd2MFYzZFVna2RXSmxQbFZWdnc1bHAz?=
 =?utf-8?B?L3dzRGFheS8yR2laT3FWOW9xMFhwM2hnSXdKRnJNTHk3aGE0bEFFeTlkVS8r?=
 =?utf-8?B?Wm8vdld4VklBdXE3ZVhwK08zSWlUN2h2U2hlcUZFVHlKM3FBZHZaOHEzb0JW?=
 =?utf-8?B?N3FUSXowR1ZoWVJnYis5RnZMVDF4ajRwN2VVL3VKKy8xNGtVa0pjRW9qcWJI?=
 =?utf-8?B?dEdZSmtaUHA1dWRsZFF1d1U2SGc2a2hyRnJaeW9JTzJvMFFuckhhNlVyRjkx?=
 =?utf-8?B?SXNsSjdnM1QyditzUmkvcGYvcFVuOVQxbHdJUmk1cTkzYlB5RCtnZnVpdEh1?=
 =?utf-8?B?b2tXbktCMEEyaXA4VDlkWjVqOFV4Z1Izc1padEcxUllGY21WZk5oWTRRaVcw?=
 =?utf-8?B?T3pFRXNBTG1WMHRwdVlDdzU3aHR5WlIweTh4VDJ0Y0hpYzI0RGcwY1FvKzBG?=
 =?utf-8?B?eStkazhPYUlLM2pDcUF4Y20yRmpkZUtmeEErcExCZ04wUldqdHlQdU1EKytz?=
 =?utf-8?B?RmRQTWpWamlnVGN0OGxZRjZvODdabFpBMTl0UU1rbjArQkpWeFNRN1VaanB1?=
 =?utf-8?B?SDgvcDkyVW15TTFUQ2tkZGdvNjBiZklFbkRWY2Z0WmdvUWhuWTNtZmZpdHFh?=
 =?utf-8?B?cUtEanRKNGhJT2FIRS9sK1JWMUVlZUE4bjI5WFBnZVFSc1pXUENuT3BwK3JZ?=
 =?utf-8?B?YUN3UTZqelM1YkxvRXZLODA4T1c5cEtGN1BwZkZwWnhPVytDVHZjMURONlJC?=
 =?utf-8?B?UzBkbWZKSVFqTGtmSkZKV2p4Q0had002NGsvYnoxcGxFR21sNWpjejAwWWlU?=
 =?utf-8?B?cDFmU2g5Y2VDK1ZscGFYY2YyWXhIS3NYNC93b0p4VlN1N2ZWeXdzVGVIMVdU?=
 =?utf-8?B?dFBBVWN4Y2Y5dlFmeCs4UGdCK2UwSzlTZDRzaHUwOFQxTDhVbG5oRUF2OTNV?=
 =?utf-8?B?T3V3THlIY2duRy9BaERGaDV3d1YrbVBxSDk1c2ludGhBQzBFVzlzL2xhYTJx?=
 =?utf-8?B?emNnbVRyZ3NJQ3hYaFlwWDNBWkVEOW9FS2pqNFRydys4MzF3VlRMNVBHZStq?=
 =?utf-8?B?NzM3ZE5rMDhtbTFRdmw2S2hydGJxZ2tnaFJOd1dvbHN1Smtsa1NnVnNYMEdX?=
 =?utf-8?B?SjFlSWxiUWo1RS9ydTFxREcraksxd2JzOUFlR0dZSkppOUFXNy9GbGVZY3di?=
 =?utf-8?B?ei9CZUgrbEhXbGs4MXhnQUFsMnNVVjV6ejBPdFV6MUdFT0JDNVRhMDNhVTEv?=
 =?utf-8?B?eTJJTTlQWXZKQ3RmaFJRQ2h3RXNsd3dZdHpnVng1dmI0YmtOMm85MldBZjlO?=
 =?utf-8?B?R2dMUT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2472;6:i9h5GzQ6t+DQiu2Nx2jLyIH196OgjeyJVX1GXOPUDNXcVhHeIGPU5bXko0xUN8gUNPS9B3rkV46Q5LC/fx6POK1awnbS1NranDC/zHAsEIqZ2xNFOCzLA90Be+dmL47tXjgwX+EzlqhQ/dE3yD/3D5RoMQ6gLeT5S4RlDFvuWyonlsStOVsRqDHw0M90AnfmTyR4rFwyYBMcHQ9eoE+T+MZtOXtlI+In9tNOycXjpYIYKS7v90/HIEWyFuCz4g1yCXL9LHXjUANfU08rXS4tVE/eEGWLd8/VEP81x4l3d/V4+TMbdAaEDgf7ROHCa14hKQaXlXOBcEtYdL7fGz4nt5REdXPH3hKxuJpQ/Q8K08c=;5:3ZB5L+EJ2xk6yaun6fVAmBzPyBkJ4o3QWOaDiPl4kjGwSeDo3z2UZjuljdEhUwHbbdPdQeRZ5F/WYJJ2PUv7DsCudI2khFtxp36IiFUy+RMxAvHcOGQiSfN5wz3lrDA6XMo61kTBDI34fyXkVoi3NzVwOip43C2TRAOEQCP4kzQ=;24:qKD2qlvGaWbTFprls8UUdmXUrbiT6nBsiYKD09Qr7cFoi7zei9j2oiffut1HDF3rwCS3DPkOoLLcBoJ11ZBr5dPTrjtDqbuTeULhnDTtz98=;7:yEm4bRwOU5lC75S04C4t0oVzVX8uypuC0w/MLCGTjtjm8UA4/mxqBl1tkJlJQhMK7R+LyQVdKHfIMgl/VSBhrnazT+At896PC04YDk17xUFVAuFfNRuHb93alT1GttozRZzOKuCE5/405lTSY4JLVZEo5wfpF/ijT3NxAP/kIzyAUrLIEWaRFdE3uycS0yWaENAI1SSZuAR5O4c9MSbyFccP3PCi9W0OoQ1YXTqdfb56ahT/EqwzWIc88ulBxZJw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2472;20:skP41HSyaUNawKGfEk81ticy9Hi6EGxeCCEvbBw97D1pPQLnXvuceQrMzpHrO60pelBPFnwuGBIaiP5/CKwf/QZoRru1fd+VU1o9O3HtEszl2CK1Yr5MF/ft9bLx/o1zAgCnvcA8c0Rrq7UFqVRTc9kUABE06E4WuA8cZ/UpJ63qMRpBU9JxTMlfEfyLZpOMR1ltn9OBbxh07REmV5n/Lj5EN3eQzgYe/2KW31vKDPomYc/uBajKyVfqYCmYXQ1q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 15:39:36.9603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0f0fa9-7b8b-47f7-8b0e-08d56a532b27
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-02 07:31 AM, Arnd Bergmann wrote:
> Building the amd display driver with link-time optimizations revealed a bug

Curious how I'd go about building with link-time optimizations.

> that caused dal_cmd_tbl_helper_dce80_get_table() and
> dal_cmd_tbl_helper_dce110_get_table() get called with an incompatible
> return type between the two callers in command_table_helper.c and
> command_table_helper2.c:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_helper_dce80.h:31: error: type of 'dal_cmd_tbl_helper_dce80_get_table' does not match original declaration [-Werror=lto-type-mismatch]
>  const struct command_table_helper *dal_cmd_tbl_helper_dce80_get_table(void);
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_helper_dce80.c:351: note: 'dal_cmd_tbl_helper_dce80_get_table' was previously declared here
>  const struct command_table_helper *dal_cmd_tbl_helper_dce80_get_table(void)
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_helper_dce110.h:32: error: type of 'dal_cmd_tbl_helper_dce110_get_table' does not match original declaration [-Werror=lto-type-mismatch]
>  const struct command_table_helper *dal_cmd_tbl_helper_dce110_get_table(void);
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_helper_dce110.c:361: note: 'dal_cmd_tbl_helper_dce110_get_table' was previously declared here
>  const struct command_table_helper *dal_cmd_tbl_helper_dce110_get_table(void)
> 
> The two versions of the structure are obviously derived from the same
> one, but have diverged over time, before they got added to the kernel.
> 
> This moves the structure to a new shared header file and uses the superset
> of the members, to ensure the interfaces are all compatible.
> 
> Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/dc/bios/command_table_helper.h | 33 +----------
>  .../amd/display/dc/bios/command_table_helper2.h    | 30 +---------
>  .../display/dc/bios/command_table_helper_struct.h  | 66 ++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
> index 1fab634b66be..4c3789df253d 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
> @@ -29,38 +29,7 @@
>  #include "dce80/command_table_helper_dce80.h"
>  #include "dce110/command_table_helper_dce110.h"
>  #include "dce112/command_table_helper_dce112.h"
> -
> -struct command_table_helper {
> -	bool (*controller_id_to_atom)(enum controller_id id, uint8_t *atom_id);
> -	uint8_t (*encoder_action_to_atom)(
> -			enum bp_encoder_control_action action);
> -	uint32_t (*encoder_mode_bp_to_atom)(enum signal_type s,
> -			bool enable_dp_audio);
> -	bool (*engine_bp_to_atom)(enum engine_id engine_id,
> -			uint32_t *atom_engine_id);
> -	void (*assign_control_parameter)(
> -			const struct command_table_helper *h,
> -			struct bp_encoder_control *control,
> -			DIG_ENCODER_CONTROL_PARAMETERS_V2 *ctrl_param);
> -	bool (*clock_source_id_to_atom)(enum clock_source_id id,
> -			uint32_t *atom_pll_id);
> -	bool (*clock_source_id_to_ref_clk_src)(
> -			enum clock_source_id id,
> -			uint32_t *ref_clk_src_id);
> -	uint8_t (*transmitter_bp_to_atom)(enum transmitter t);
> -	uint8_t (*encoder_id_to_atom)(enum encoder_id id);
> -	uint8_t (*clock_source_id_to_atom_phy_clk_src_id)(
> -			enum clock_source_id id);
> -	uint8_t (*signal_type_to_atom_dig_mode)(enum signal_type s);
> -	uint8_t (*hpd_sel_to_atom)(enum hpd_source_id id);
> -	uint8_t (*dig_encoder_sel_to_atom)(enum engine_id engine_id);
> -	uint8_t (*phy_id_to_atom)(enum transmitter t);
> -	uint8_t (*disp_power_gating_action_to_atom)(
> -			enum bp_pipe_control_action action);
> -	bool (*dc_clock_type_to_atom)(enum bp_dce_clock_type id,
> -			uint32_t *atom_clock_type);
> -    uint8_t (*transmitter_color_depth_to_atom)(enum transmitter_color_depth id);
> -};
> +#include "command_table_helper_struct.h"
>  
>  bool dal_bios_parser_init_cmd_tbl_helper(const struct command_table_helper **h,
>  	enum dce_version dce);
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
> index 9f587c91d843..785fcb20a1b9 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
> @@ -29,35 +29,7 @@
>  #include "dce80/command_table_helper_dce80.h"
>  #include "dce110/command_table_helper_dce110.h"
>  #include "dce112/command_table_helper2_dce112.h"
> -
> -struct command_table_helper {
> -	bool (*controller_id_to_atom)(enum controller_id id, uint8_t *atom_id);
> -	uint8_t (*encoder_action_to_atom)(
> -			enum bp_encoder_control_action action);
> -	uint32_t (*encoder_mode_bp_to_atom)(enum signal_type s,
> -			bool enable_dp_audio);
> -	bool (*engine_bp_to_atom)(enum engine_id engine_id,
> -			uint32_t *atom_engine_id);
> -	bool (*clock_source_id_to_atom)(enum clock_source_id id,
> -			uint32_t *atom_pll_id);
> -	bool (*clock_source_id_to_ref_clk_src)(
> -			enum clock_source_id id,
> -			uint32_t *ref_clk_src_id);
> -	uint8_t (*transmitter_bp_to_atom)(enum transmitter t);
> -	uint8_t (*encoder_id_to_atom)(enum encoder_id id);
> -	uint8_t (*clock_source_id_to_atom_phy_clk_src_id)(
> -			enum clock_source_id id);
> -	uint8_t (*signal_type_to_atom_dig_mode)(enum signal_type s);
> -	uint8_t (*hpd_sel_to_atom)(enum hpd_source_id id);
> -	uint8_t (*dig_encoder_sel_to_atom)(enum engine_id engine_id);
> -	uint8_t (*phy_id_to_atom)(enum transmitter t);
> -	uint8_t (*disp_power_gating_action_to_atom)(
> -			enum bp_pipe_control_action action);
> -	bool (*dc_clock_type_to_atom)(enum bp_dce_clock_type id,
> -			uint32_t *atom_clock_type);
> -	uint8_t (*transmitter_color_depth_to_atom)(
> -			enum transmitter_color_depth id);
> -};
> +#include "command_table_helper_struct.h"
>  
>  bool dal_bios_parser_init_cmd_tbl_helper2(const struct command_table_helper **h,
>  	enum dce_version dce);
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
> new file mode 100644
> index 000000000000..1f2c0a3f06f9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DAL_COMMAND_TABLE_HELPER_STRUCT_H__
> +#define __DAL_COMMAND_TABLE_HELPER_STRUCT_H__
> +
> +#include "dce80/command_table_helper_dce80.h"
> +#include "dce110/command_table_helper_dce110.h"
> +#include "dce112/command_table_helper_dce112.h"
> +
> +struct _DIG_ENCODER_CONTROL_PARAMETERS_V2;
> +struct command_table_helper {
> +	bool (*controller_id_to_atom)(enum controller_id id, uint8_t *atom_id);
> +	uint8_t (*encoder_action_to_atom)(
> +			enum bp_encoder_control_action action);
> +	uint32_t (*encoder_mode_bp_to_atom)(enum signal_type s,
> +			bool enable_dp_audio);
> +	bool (*engine_bp_to_atom)(enum engine_id engine_id,
> +			uint32_t *atom_engine_id);
> +	void (*assign_control_parameter)(
> +			const struct command_table_helper *h,
> +			struct bp_encoder_control *control,
> +			struct _DIG_ENCODER_CONTROL_PARAMETERS_V2 *ctrl_param);
> +	bool (*clock_source_id_to_atom)(enum clock_source_id id,
> +			uint32_t *atom_pll_id);
> +	bool (*clock_source_id_to_ref_clk_src)(
> +			enum clock_source_id id,
> +			uint32_t *ref_clk_src_id);
> +	uint8_t (*transmitter_bp_to_atom)(enum transmitter t);
> +	uint8_t (*encoder_id_to_atom)(enum encoder_id id);
> +	uint8_t (*clock_source_id_to_atom_phy_clk_src_id)(
> +			enum clock_source_id id);
> +	uint8_t (*signal_type_to_atom_dig_mode)(enum signal_type s);
> +	uint8_t (*hpd_sel_to_atom)(enum hpd_source_id id);
> +	uint8_t (*dig_encoder_sel_to_atom)(enum engine_id engine_id);
> +	uint8_t (*phy_id_to_atom)(enum transmitter t);
> +	uint8_t (*disp_power_gating_action_to_atom)(
> +			enum bp_pipe_control_action action);
> +	bool (*dc_clock_type_to_atom)(enum bp_dce_clock_type id,
> +			uint32_t *atom_clock_type);
> +	uint8_t (*transmitter_color_depth_to_atom)(enum transmitter_color_depth id);
> +};
> +
> +#endif
> 
