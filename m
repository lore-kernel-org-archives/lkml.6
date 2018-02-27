Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeB0ORr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:17:47 -0500
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:34848
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753422AbeB0ORn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:17:43 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v4] KVM: X86: Allow userspace to define the microcode
 version
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
References: <1519698910-4272-1-git-send-email-wanpengli@tencent.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <10bd15a5-7a0e-83d9-4324-eaff6e417b47@amd.com>
Date: Tue, 27 Feb 2018 08:17:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519698910-4272-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:3:151::14) To MWHPR12MB1152.namprd12.prod.outlook.com
 (2603:10b6:300:e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6ca0845-cb1f-4185-c303-08d57decdc97
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1152;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;3:zC9yiVK87tVzLPQEFTf+dHgU2WSxtODkj0eTL9JKD5R4Q387177WIrLd4iol/IADJzcytTlOl5lJBAmMBlPhrKEUTnO1xQ0iRuifinUwE8pFkl/3ss39ScJ17m9Smhy9PraXX+g8UF3ux4miNZ8xcCrt2oE2EGqQgpMTYvDxuigjdkMX1TZCpOA7I3JH2Wl4SIAQ0LJzxmrwrE3/iw/059vGGWE38+VPKPnwqOB3yotwsYRZYz9UrtlnROnMtlAP;25:O9m6G5a4WH/YaMuhENsecPqJabqHAo5lKhWEuG8cKPHtNJKsrI7juGT3awZ73CyjZ14WjQHO4BQELegihu2+4mWZ0mSRd1GcJysThlIZhHZQHvOk0kwYdPsa5Gwg7mZuixdhjCzSzP5VuwIe3NCoOtcOVN4mDr1cfCtMazhEio+cFB4A9YGhLCH0SGnFP5uiYFXpCdSgSoP0irtDrPLTVDIm+YWTYcTrzqVs6ps5UztXxY3Bz2zqSt9oiVuY+p0GaPtnWA/9NM2uKswyUDJZ9KNIZ1zYy55b4H425VFZjTGGsfJLl2my8asyNO6qNL3f2UAeY5H8mAzCo3FeMuaU6A==;31:PgW0SFkVX6iEGvFjsd/3mmisyiNHfE+L92cXY5LrpAPTvhoZkkZOJXhPxOxiXrTKZ/6NA/PpWsBYk+e0VC5zF4hnMlGxJKU58AwLwVPhqrCc0K0CHVSwd5snG3Df7lwsHzoQEtJ6cYCDMEhjzLwUUSD312tsxvPiic2Pd0Q8rNcsXV+DapCksOgx/ROecIfP6KQ9d8tocHS3NejgezvjeV3KUh1yEmTg8TurmcwtwEU=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1152:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:g/ZnliVEq+lD6RDNdhrGX+u+xW6rGvYX74Ce4ySt7NkFk0lg9RJvcPaEP2JvDonG1nttjpp1Uo5LaNjrOcxxcCEy7RrFO6UpgMWtiabQl63XlaqLUXER/EaDeoDyXleXP5cRZTZtT+OQ++4zMLhgKpBQXajSgewXusZ5aJahp6aSz8MKOyFAIvUMCe3/d1tYtbhLjCFIxzl2CcZHtMG3SsX2SxmqYTdm93CS2yScPmarPqa9jVC7y/sDjiMfstvTkgKDw0MVx8ZOPRILnyiKcVxdJlu1rlkux6Mcg7g+PeTUJFZTd1Op0OdJlLn8RmT/nG6PhnQWtDg/FxRthjO14A2hvm9BAPCRCp08rvY9pF806VZJUnxpaJDNip2+rwn42hdpYiMfMyw4/GtQz9NMzVDtk8BGHqRzQfEpZeH4URJmoNrepO4Ilt9/zjoJAyLhpPpObLiTvtsgepe2cgj0Av1UBzJGHCupD9QoMobA15LWxMlXfZpqa+uqRL4ta5+z;4:v8N1lAZvlwKMCWnfB392oaASiFSGPwj5FRuA3hxsLdEX2Rankwc0nb61jJH8fhmQtqehz91gK0Pj/Sj5AGjp9gk1xP4xxm+oW+g+tVWIrVF2ltMSmaa1Pg9uk0PjoEcpy+QbnJZ6Y+8m5NpAbhg0Du24Xsj0rTOtWcvFk7ZPwc0U66ExBTV3gcQqEQuBxTWTWQGq2ilIuYlSh+IK3LITnUEmNrlsTeeEXEAbWiYfN8vP0Ww3uKuwhC1UyzL+3cxJzky5URD03ZNsuFpxTNiLhLrSa4xyIODKQlQ2qxJ7MqUDmL9ce2CNk5PDV4yTdGR02u/5juhhF6POYSPPIPUnIRwq3whE57c0HOVK55eoYWQ=
X-Microsoft-Antispam-PRVS: <MWHPR12MB11521E8890EDEDA3B3ABA345ECC00@MWHPR12MB1152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1152;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1152;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(199004)(189003)(16576012)(5660300001)(68736007)(86362001)(39060400002)(4326008)(65826007)(53546011)(386003)(50466002)(229853002)(316002)(3846002)(36756003)(25786009)(59450400001)(2906002)(2870700001)(3260700006)(16526019)(6116002)(186003)(105586002)(26005)(6666003)(31696002)(77096007)(31686004)(2950100002)(305945005)(6246003)(64126003)(478600001)(47776003)(76176011)(53936002)(72206003)(8936002)(97736004)(7736002)(81166006)(81156014)(66066001)(52116002)(52146003)(2486003)(23676004)(106356001)(58126008)(54906003)(6486002)(65806001)(65956001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1152;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUyOzIzOnpzbi9ML3h4T1pnNEl3Ync3SDBVL0lrWnI3?=
 =?utf-8?B?RndDV3VWVmJXeFlIYjVMNUY3U2dJdzRBV013VzU1SDdaazFxbzBiVjZZVnF3?=
 =?utf-8?B?aU5PREl6dCs2K3dsaXdST2tlYnJSZUhib013UnNPV1R0ZmorK1dGOFJXNkJS?=
 =?utf-8?B?ZmJMNm5NZlJlVSs5NjJNR2I3bzdvVGlQYWZFL1pEWmMvMkg1ZzNXaEVyQVJj?=
 =?utf-8?B?blpTU0lGL2FnSzVDMzhleVJhRDFyb3lMUFhqNFhDMkpZZ1ZibFB3QWZxNzVB?=
 =?utf-8?B?ck1PQk8rREh3dFJaNkNKaHk0NXEvY3o0dzNXWk44NzUrNk1kZU9SNmZVV2RY?=
 =?utf-8?B?S2JOUmtxNkptTVpmKzlOaVpISDU5ZXdJOTBaZVo3SmkzMjJFZGs2SXRicGtG?=
 =?utf-8?B?OER2eG5vb3ovVGhDcFpXZnFDOUJUbmIwKzRoc1RmblNxSWk5S1NpRE0wcTRX?=
 =?utf-8?B?ZDVOTzRZSGpIK1dOWnMyeGs1Qm4vNUZ3REEzR0Z1V1BjS01tRkdxZyt0blIx?=
 =?utf-8?B?RXBMVzVobTNHalF4MlFJQTlvRTN4UVZ4VzlUdGNPcEVxaStnVjFrMnFQYm5q?=
 =?utf-8?B?dWJnMDJoTlJIL1BKTjcvbGRic0c0UVVSaXpheVJ0cVBMdm55bWNPWEFwRzNl?=
 =?utf-8?B?RXVUbWtLQVVzY3hhR0ZJMkRvRldQRXdDT0l5Mi8vNFQ3MGV4TjFzcjhINzVn?=
 =?utf-8?B?UnJrTDBrTm1WeGNHcUZQelVsYm93My9MaXFHSTh3UnJJaFU4ZHdDSXphbVZJ?=
 =?utf-8?B?ajVzcVhHR2NHV2o0LytIU2NERGJURWU5aVRvM0w4OG9BZDRycDlFUW9WNVpO?=
 =?utf-8?B?YnI0VVNtdkx2ZHBCbHVHMFBOdlhKRGtlOHF6MWh6T1UxRmorNEtwRkRkNUY5?=
 =?utf-8?B?WHdrWktxODRHNDJianVnS01YbDdPMS9hM3BrNE9MWU1UcUN5KzhEOHlOUUNT?=
 =?utf-8?B?MVpWclZ5bXFoaEpGM3lvSmZMTXg0dW04bjNQS3k5ckFSRU1KZEdLczBaMFZ6?=
 =?utf-8?B?N25DajJUaGQwM3grT2VlSFBYemxqT2Q1QTJwQXNEZHN4ZUc3enowQWN2OFdY?=
 =?utf-8?B?OEk2UjkvTDNObW13Sk56NGE0b09mTDNFbHpheGVickgzY2RFbGp2RFBnbktt?=
 =?utf-8?B?bGlrakF2dXhmV1VlN0tJYkc3UU5IRWZzVXdSMjVSUGVZN0ZLc3ZRUWU0cEk4?=
 =?utf-8?B?aU9nQ0pXbm5oMkNWdXFXenhWTWM4ZDVkK25BNy92bEZwTllwOFUrNktMOGlo?=
 =?utf-8?B?dnJOaUF0cmlzb0x4ZmZ2QVhIbUFhak9WOUluVzhMMjk1L3EwYWt0WlN3N0s5?=
 =?utf-8?B?MkNFajVTRXYyWkJVS3IvRjhMK1Q4K1FQTC8rNnp3Slc4TW14MzVCbEpVWnhu?=
 =?utf-8?B?NldiMU5JK2d6S21FYXVHTytFSjJYaVFaTkNNeDYvWXJETGd2T0F4aVp5YWdR?=
 =?utf-8?B?VGFJQzNyb25nMTE3a01oSU9uaDduTmVNRm5FTEYzZFJ4dUM0SVBvayt3Y2pl?=
 =?utf-8?B?WGZNYlIvcVN3WUhmOGNoYThKdzJMSHdjV3EzWmtKUGlhTTlZb3AwVUdUb29a?=
 =?utf-8?B?ZkNCT0prV3ZUbjN0alBSMDROVmZFb1pDa3RtQlZ0d08zaDNTMGxCaS93MXJ5?=
 =?utf-8?B?dDFsUGFpRkxvTnVFd3dhcnY0dFFMM2xuc0hTMWtWV2RFZzhja3M2TFZ1TFVG?=
 =?utf-8?B?aXQxR3NqVGxWS3B3bVhGZHRnNUM4TDErMGtIMGIrZXV5L21wSTBzbXRtR3Rw?=
 =?utf-8?B?Y2Q5Tkx4OVIyS0dycGl4UlVEL0ltak9HRW1hdTA1dEdDa2pGakRUN3VtdmxG?=
 =?utf-8?B?TUJBS1VQWUU2bkY1VW8wTFplQUdXQklmQ0RjK3BETjI0VkZVbGd6aCtWRlc3?=
 =?utf-8?B?K1VvOUdId1NBUDFjeng1OXRDUGpFTlU2NmZ6eVIxMmsrUWdwdHd6Rnh5Kzcv?=
 =?utf-8?Q?TkIhLoR0BpSlz7vpcKjdr2M6BOGU68=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;6:SoNHDUPwl3jMWofh8R9xDjv34INns584LyB7KqUoKHcFGyIm+tVcIHBtYbY2LTY8+SPV9BV5ZVuVPN84G7DuUgM8t3wozn/NIYrl65WB5gi//c4HVqndPZQlKB22+VuuiyPEv41jSNgP99zR8lPLXGBj1SLCvPzAfHQ9/lf5EGP8++P5MBqvJVnoLWPIYC6pMZUYUyGlj+/iwnza1ILZRsAH02yGzCW5ygB8ioHaeyHD9WPuKahlQ0EC32AC1PQVXzuFsDWwFI/oGzAYZmrtSkEgA8GQe5kRpV+JpvT8IZa/D3n0GuCRN2raqRSvjpDqA9t0rdXMaql00V1Nfk5aqh/b04QQvsxpQONkMg5y+Ig=;5:Trdklh1d/Bq0sX9oxcMkjC4QSKxO2Pwk7GoQYXakvAWLV4O7gvRGGoIqL6XQrkxtnLyE4gjGzY5Nq9JazJEJja8lxpbfHRHVCX4nzxJT16Hg89RvFoKqKjtR8qz0GI9W8KOyOcF0a+Cf2I4quQcc3+kfeoli/EZ9X29KOejaAvI=;24:fyHRgWOd7GpMqKDlcjTBA6wzZzEHXep66feW0oobq9M/chYlTPm5cnSOxpYvDQAo56vVPbcPtQVvyAnAnFK7GH6/7NiW6fFX5fmpWQA7ghI=;7:4JQEzFwWePVEyD8CxWTUoUQOf8/apJjvcyaVUduK4GWljvhRnWcy0ufGttwDZ/U21F/4OZfCEijMMIuLZAY7PyGThPpN32bukDU4e4vYpkFblY1oipA9+qUsdtYohRDYex5hvlIdzobidfcPSseBrAgtR3CuIGOK/4zpjaCsPOxdwqjImN1PGZ+d/MVSTexr17zpdviDV2JiQuaP9gyOJvYcw0deNvTCnNrcZoBHfTTqepu/D2u0+XgyLw5V9l3r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:+pvmEzZAo/QMHalspIpJ23rHwKZvXi0IU3n+V94XHZBQvGuj/8zD9gN+gTi6lZ/utJyfRst7aW/gNv+k7QmILjOlNWce9mx6Ov5vKNVoh3euNJgzAkVxIuMDR8lv5U+J7Vd24oqTqJoqJiPcRno+TZJAJRv98hoyMnB/67jN83v1dQNubAdUarL2nRt3RfGOkwT3cP2+6w5D1AllHUkXdneB559ZA3BU/5LPROh+1ebb4A3qJ2Ha2X4iWe8v151c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 14:17:40.1511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ca0845-cb1f-4185-c303-08d57decdc97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2018 8:35 PM, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Linux (among the others) has checks to make sure that certain features 
> aren't enabled on a certain family/model/stepping if the microcode version 
> isn't greater than or equal to a known good version.
> 
> By exposing the real microcode version, we're preventing buggy guests that
> don't check that they are running virtualized (i.e., they should trust the
> hypervisor) from disabling features that are effectively not buggy.
> 
> Suggested-by: Filippo Sironi <sironi@amazon.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v3 -> v4:
>  * add the shifts back
> v2 -> v3:
>  * remove the shifts
>  * add the MSR_IA32_UCODE_REV version to the "feature MSRs"
> v1 -> v2:
>  * add MSR_IA32_UCODE_REV to emulated_msrs
> 
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 19 +++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 938d453..6e13f2f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
>  	u64 smi_count;
>  	bool tpr_access_reporting;
>  	u64 ia32_xss;
> +	u32 microcode_version;
>  
>  	/*
>  	 * Paging state of the vcpu
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d4985a9..0299b6e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1058,6 +1058,7 @@ static unsigned num_emulated_msrs;
>  static u32 msr_based_features[] = {
>  	MSR_IA32_ARCH_CAPABILITIES,
>  	MSR_F10H_DECFG,
> +	MSR_IA32_UCODE_REV,
>  };
>  
>  static unsigned int num_msr_based_features;
> @@ -1067,8 +1068,14 @@ static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
>  	struct kvm_msr_entry msr;
>  
>  	msr.index = index;
> -	if (kvm_x86_ops->get_msr_feature(&msr))
> -		return 1;
> +	switch (msr.index) {
> +	case MSR_IA32_UCODE_REV:
> +		rdmsrl(msr.index, msr.data);
> +		break;

By not putting this support into the svm/vmx get_msr_feature() functions
this MSR will be removed from the list of msr_based_features (see the
kvm_init_msr_list() function).  You will need to either add this to each
of the get_msr_feature() functions, put similar code to this into the
kvm_init_msr_list() function or create a "common" function that can
be called if the svm/vmx function doesn't directly support the MSR in
question (similar to the get/set msr functions).

Thanks,
Tom

> +	default:
> +		if (kvm_x86_ops->get_msr_feature(&msr))
> +			return 1;
> +	}
>  
>  	*data = msr.data;
>  
> @@ -2248,7 +2255,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  	switch (msr) {
>  	case MSR_AMD64_NB_CFG:
> -	case MSR_IA32_UCODE_REV:
>  	case MSR_IA32_UCODE_WRITE:
>  	case MSR_VM_HSAVE_PA:
>  	case MSR_AMD64_PATCH_LOADER:
> @@ -2256,6 +2262,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_AMD64_DC_CFG:
>  		break;
>  
> +	case MSR_IA32_UCODE_REV:
> +		if (msr_info->host_initiated)
> +			vcpu->arch.microcode_version = data >> 32;
> +		break;
>  	case MSR_EFER:
>  		return set_efer(vcpu, data);
>  	case MSR_K7_HWCR:
> @@ -2551,7 +2561,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		msr_info->data = 0;
>  		break;
>  	case MSR_IA32_UCODE_REV:
> -		msr_info->data = 0x100000000ULL;
> +		msr_info->data = (u64)vcpu->arch.microcode_version << 32;
>  		break;
>  	case MSR_MTRRcap:
>  	case 0x200 ... 0x2ff:
> @@ -8233,6 +8243,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	vcpu->arch.regs_dirty = ~0;
>  
>  	vcpu->arch.ia32_xss = 0;
> +	vcpu->arch.microcode_version = 0x1;
>  
>  	kvm_x86_ops->vcpu_reset(vcpu, init_event);
>  }
> 
