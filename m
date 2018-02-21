Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBUUAI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:00:08 -0500
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:18662
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeBUUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:00:05 -0500
Cc: brijesh.singh@amd.com, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1
 (different base types)
To: Al Viro <viro@ZenIV.linux.org.uk>
References: <20180219161228.46931-1-brijesh.singh@amd.com>
 <20180221174910.GI30522@ZenIV.linux.org.uk>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f55f25f6-559d-bb93-5605-af66678438c2@amd.com>
Date: Wed, 21 Feb 2018 13:59:55 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180221174910.GI30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: BN6PR1101CA0007.namprd11.prod.outlook.com
 (2603:10b6:405:4a::17) To SN1PR12MB0160.namprd12.prod.outlook.com
 (2a01:111:e400:5144::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4c3e04c-fbf3-4e3a-3ddc-08d57965b1f2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0160;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;3:3SNK2MzqKhsdcq9majpHx0jGXfCygBEZbdpTkcu+q8JY6b/IYaDe8DsKXyWDQfQmSEuLh4xILPrTrR+M/Tcb02mG1I7A5YLJ+T4w2U/toh8KMDsvhrM/jqoBqrAlORrDbLRXmD0Yw5zfP9ByINL5asL5XxrIUMd5HhimHefjtjpSO+3okKetURoQcCEAg81cMuKQ9bn5Ezd4q5R6URtT5q4ZiXNZ/89Vh1ZLST3cWPAez7rP3EPCgeh2TLeboGLZ;25:2dP9Ex1muUP3a0iUHAMY+CGkY/V7FDJNq1HQCYmpClGEHvTOH9RFV2TpwzvdAproOlHp012za2w0q4uAVMouaM2qCAmzX+eUfN+s0WX2CWjtkz3RPeEp9bDK9gSwLOLxu/lDF7TASlFW0EKGAJt7oD/r7fm074vmD21sbieXU7dIvWIZ8TU6dPIkTWdufjAhj43lkFGNDRvB2yFHv0/xGQqtcUEOnzspx+xn7mF7wK826vKbn5m7uTl+AHGD4gNXMmKxYFP4nTkBxIKgb7c0QAVI+SMSrXtL07R2HdNsuumdSXBHZoZC0CQRJwN6CAkfNQIqGPnSdYb3ZYu1bJ3/Wg==;31:TYhx+uNwXEoWrgcuxXzF6wFOIAuXiDOTPWUYSIH8rzttitycYhsPDa8WUkFUvVooN5+PLw1t6gazjAeBqQIBZoqCJYb/AIMan6QwjqiHeW08AMvbMP+Zadb4Cf5j0huL8jpqzMjTf98BOK2k25LOomSNFDdC3ybBp6yRrZqGr6Mi1zICAc8c9RAXw8l+ITuDmIBl0y2vnGok9A/T+QOzaCl1k4cDyIVMX3RRZGBLk9A=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0160:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;20:Woas+nYBKtYUgISyy+zlGy17Aa+fOaeQ/a8WtAIfBuh5x5ByxN6NTlI8EMWtVPEpqQ1X6NdpGHLJwnqx7M0yCHW0buyrFIxw3R+B1yiU147rdKu0oupQoV3zZ9prWDTA8EJHY3y4ZW1ZWPFXbiDrPpFbb7tSXUDdy9xoKb9J74iSEeNL55nqRKOaxEmg6vdP7m9bAKpgcX9Ebjo2++kj8JWRtinAhdhAZc4ACU7Y55/JX52CQwmBRoNv49iRsY/l7z+JaZ7fSWriBeU2YLWNKchhQG0VmO9OrHPBXsHtAPeIx6Xqrw7xHyMvkBUZeyHORPZf7fiTuseH5HGlJfzluAxmpyWMcd/goz83gqowPkXAzDxWLUG6f26jZe6+yarc412MYoo2qv/juNN/7ztcpHGbAqyAM9xcsRg8B696+n7UjgoUqzurodMp0pCjTEJB4BOX/iMnxjM/mC7LMY2YC6BYArZ2L2EdApWZcJ9mU+h4FKUJF29WjQFHPcfP3Ogo;4:hBdFhdFPJntePkwjWhzOMFRYaaPZWN6o0MRFm3BhTMrEhoOH3oMYu8SVtxOu4VK3qNWDXBYUNw3eghK63fy3dfGSf350xq3L3UC9P3cxelyRZLqz6JCRU9+wjr95sCA8ejdL3xfCda42jK7cCck2QjojrKxif3OGVxSYTHL8ISJJw9rnv3qhrMDCuihFZn/tKNSVW3zGwOKojgIgpY8HtqhG7TTR1zlolrkInoMnr7hM0Fe6SLLx6djN4dHmo5KlurDGZSWL4jAx/n+hD22/5w==
X-Microsoft-Antispam-PRVS: <SN1PR12MB016020E0D5CD9FF0D8F3F168E5CE0@SN1PR12MB0160.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001070)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0160;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0160;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(189003)(199004)(6116002)(5660300001)(8936002)(229853002)(6666003)(6246003)(6916009)(26005)(16526019)(186003)(4326008)(6346003)(2486003)(23676004)(52146003)(53546011)(59450400001)(65826007)(386003)(76176011)(6506007)(53936002)(6512007)(2950100002)(65806001)(86362001)(81156014)(65956001)(25786009)(31696002)(81166006)(66066001)(52116002)(47776003)(8676002)(316002)(54906003)(305945005)(58126008)(68736007)(7736002)(64126003)(6486002)(31686004)(2906002)(105586002)(478600001)(36756003)(2870700001)(3846002)(97736004)(50466002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0160;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTYwOzIzOkhueGdBOHFaN2ppdy9VWTBDWThnVnJSM2Fv?=
 =?utf-8?B?SzdIaUdKaUpmc3poSDFkSVJaODRqMXpRdGJhclErMnVkbjIxczNxK3hjcGZC?=
 =?utf-8?B?Ym00QzhmUGRqWkVvN05BdmNPclRuZ29iblI5RDRmVTlicUNlZGFmVE5yWjZW?=
 =?utf-8?B?V3JldXlvdlFCSHZUMThwQW1rSVVQYlZBMkg1TGtOWVkxL0xlSUNhcm1EU05X?=
 =?utf-8?B?NG9KU2dlZHJ3QWl3THNCK2tCUVI4QmpxMUduaDdwQk9zczN4TExwbStpTG13?=
 =?utf-8?B?NkgrYUNkQWdMcmJhMXdLODBUY3AxUm1Mb2pZM090N2pwM1N6a1RZdjhmYVRp?=
 =?utf-8?B?eTFjU1Y4dyt5YkRva0RNZ3l4djBKekxPMlFITkMxYTNlU0tjZmxqNUt3Qm1X?=
 =?utf-8?B?TDhuK29vMEljNDdWZlRSeHBsOTk4K0E4ZFB5L1Jaank2bC9kcmRpZ0VBUjNJ?=
 =?utf-8?B?YitBQlM3TTIvakt5Vnd3cTVtU3lpaXd0eHlCKzFibE5vVEtiMnN5TTNpTnBa?=
 =?utf-8?B?amsrU3RhRDdNQ3RPWlB3YkhoNW1pYXJlNHZrUjZzemtYU2NzRFZCMjNTcjJi?=
 =?utf-8?B?VlJCOVFYMXlPcVRYd0tjaTREVTVJMittRnBzc0dTbU90ZnBkbVdaOTVkYUNL?=
 =?utf-8?B?VHpjc25lMmdPWXB5clVRVHlrOWsxQ1Q4Vm42N0VpcnVRbHM0Tlo3ZTY1Mnl3?=
 =?utf-8?B?Ti9MNnhqQzk2bTBFc2NRMXFnclB1NnhzU3hqdUFYS0lsbjlIWlRNbDcySWFv?=
 =?utf-8?B?KzJySFVZdDFZdkNSV1BRNCtvcFVtTTZETm0yWis4R1Zic1hEOGNwOFJPaHJq?=
 =?utf-8?B?MkJaMlk5NUt3a1ptbkNRV3N6cy9yL3J6YUF1MEVJaVpQWSt2U2tWSFI0dXJs?=
 =?utf-8?B?MnpIa0t0Um5vck52MFBCVm45UzZIdTdRTU1GLzVwR2dUaFJnNjgzUFkvVk4y?=
 =?utf-8?B?NldzKzNaZlJxNVNpM0RPZkZPMVlQOFhYWllDZ0FRR01xQzBpd3pJQkJJSFdE?=
 =?utf-8?B?dXNRSzJLSWdjYmUva3RxN0ZYU01VNFZmdHdTRzI0LzJBU0JOYm5iaTdjSnRn?=
 =?utf-8?B?NWRwc2hsZithZ1pCLzNndTRDaS9DN2xQeHJDckF1c0FrZFUxclpvbXRON0lP?=
 =?utf-8?B?ZHpKVUpMT2VXNmh4QzEycEZrcGNuU2hRUXRmYjVlUXVueU1wS1VFY2E5VzRn?=
 =?utf-8?B?NVFTZEtFWnZvQTZIMHBKcFJlOWZyU3pqU2pTT0xSSi9pWXdDd0JmZXZ0RWdY?=
 =?utf-8?B?Y3VIRFl5dVlLK0NsV2R4QS9ULzJzcVVQMkVNUVFpaVZyY1B3OW1RSmZ0V0hU?=
 =?utf-8?B?eU1hOVRvaDd3dnkyWXBFdVJWdm82L0drSHJOQnRlODVXdUNYUFpMQVZTNXM3?=
 =?utf-8?B?TzFRUG1NVHIramE1RnZSM01kMno5YS9RcjVVdmpoR2NkOTVaaXJHTFAxWEhx?=
 =?utf-8?B?NllOVzc1a3lmVGFvKzBYczFraGZkMWZyamJhUDZ4WlBEYXlMMkNOTDRFV3dZ?=
 =?utf-8?B?LzBtMWhGTlliY1VZU0dHbkdIVFgwdGhBOXEzblAzSGlGbEJlRlE1eENTZEt4?=
 =?utf-8?B?THpNUEpLOG8xc3BNaGdjYUdNZUx1QzRFZXpIV2JtMnZXZnNFT2I1RTZzQW5S?=
 =?utf-8?B?a3BFMFNzN29KNVlFQnJXU2wwR0ltQWVDMHFxT050ejNtMCtHcndaRlFLTU9F?=
 =?utf-8?B?NlJCUnNPcmpwR0VQWU0rNk1lWnN6MVRLYXU2bVNVVG1BcDJDNHlsT1ZGYUlX?=
 =?utf-8?B?Qk1rRUlSWWRSdGFMbC82bWdLN2V4Yk9iOVBlWE4rQnNHdDcvMEVrVjdLSG8v?=
 =?utf-8?B?alduYVp0SmpXMU9HM2lyR1RxdXVtTEk1dU8rZzBnNmVRdTdlT1VZMENCZndz?=
 =?utf-8?Q?u0++fmRyjm8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;6:FmMYbgs2JVbYjO2yskX8O4Ug0hdF8ORY85Ff00UhL+N/yIebSFfwmhJ8eu/gGQgePztKemQvvTYQaTyZPjLbehgtb0BFUAdaDCMvlUzRmcUQiNMzUBW2JbWIVBkx0CHLqTf/0k86I4/cx/9vO7ofPQfEATySY/KYOaDvrsQCuabCM/cX2fNgVkhAyVfNmL1ZheSD916wrKJsKQ3xHOtyNUiC7bCgEMjhsEG8WqGUaF1TEYoNjTW3w0p/Z5WJnLFjnl2xuIkLhYL8t+0VdspgVX0KYQX+CL3Swx4/fw7WUeDT/lJabVAPqhpn9L0fBPnHJnmbQnAibFMub1vQkYIqmr66pR5bZr2xy5ekZYwN7u4=;5:R4TtggGYqRRfrk9O5WZp5R1NRcxATRNWlrOITstkJJ8R+o4gqM0NHy3i+aTE0ncKgmXbZAOZigqFKsF7xgdAYj3IqIFtKCKlkCknLI6hVQ7PloGVfmHDxnh2+gA/MA8nSlS/LLFx2KRxRaaH4j8cdG0RtQpfAEtyXyHQDiKkhuw=;24:BhUQh/GyHgia6Z6mPK+1jQZTKJe5eWVzf2z/O/dewhWyCOfEc3Clz7QeJuM3VXSQx0fpsE+8hC84eElc2BLVM5EW69eUX6iCB9m8hLg48Ho=;7:LAGPUbROq5wlQAuQHlJ60HJbFW1xE8ryeDfthVs1tk21fqY6IjjB+GeRbXLh66Ua4fA/GqxF1HoGg/QslwsCDcnivU7hOrs639vKIB8tKPp8d6N08c5RveUb/Sx2IyI+cOyYuai+clu6bW6C04abpLznSnZ4esocMeLooVaUy49YwmKk9jJwpQ1/ikFnTs/Xu43qTsSDvvr/erhLrm5RNIuWDleysXGAGnYKUOAoFYxJPNGSU2cY+T++UOYcVgWA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;20:NMUAAPxWSDZnu2phV9WhcVp7TIJ5Yw0gg1VTnnb5j/QRf6Y8ufOJ+wEEmkL6feUV80BG+VLdqfhB+gDSmGqyrD5k2EY+8v0fDf6QQNl0QP6spUpdjJ0vhzhpHJnY99Ucq1sv8MhH4eMEMIjb0Tyj11LHjy8nPscS+L5FUpESTX4smwusIFnYmRSx3vvF/irE3ULwWmt3x7LL7AvERkNKTukPR0F2Y9vJpR/iWyMWYdH2oX2tR9cOT6jmixlTAC/D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 20:00:01.7206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c3e04c-fbf3-4e3a-3ddc-08d57965b1f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/18 11:49 AM, Al Viro wrote:
> On Mon, Feb 19, 2018 at 10:12:28AM -0600, Brijesh Singh wrote:
>> Fix sparse: incorrect type in argument 1 (different base types). Typecast
>> the userspace address argument.
> Better question: why the hell do we want that access_ok(), anyway?  The only
> thing we do to params.uaddr is
>         if (blob) {
>                 if (copy_to_user((void __user *)(uintptr_t)params.uaddr, blob, params.len))
>                         ret = -EFAULT;
>         }
>
> downstream.  What does that access_ok() buy us?  It does not guarantee that
> copy_to_user() won't fail.  


Sure, checking access_ok() does not guarantee that later
copy_from_user() will not fail. But it does eliminate one possible
reason for the failure. We are trying to validate most of the user
inputs before we invoke  SEV command. The SEV command handler does heavy
lifting (which includes setting up PSP mailbox,  issuing FW command, 
and handling the response etc). I would like to avoid invoking SEV
command when we know for sure that copy_to_user() will fail later.


> It does not clamp params.len (we'd just done
> that explicitly).  So why not somethings like this:
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b3e488a74828..ba2c1a606985 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6239,13 +6239,15 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	struct kvm_sev_info *sev = &kvm->arch.sev_info;
>  	struct sev_data_launch_measure *data;
>  	struct kvm_sev_launch_measure params;
> +	void __user *measure = (void __user *)(uintptr_t)argp->data;
> +	void __user *p = NULL;
>  	void *blob = NULL;
>  	int ret;
>  
>  	if (!sev_guest(kvm))
>  		return -ENOTTY;
>  
> -	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
> +	if (copy_from_user(&params, measure, sizeof(params)))
>  		return -EFAULT;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> @@ -6256,17 +6258,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	if (!params.len)
>  		goto cmd;
>  
> -	if (params.uaddr) {
> +	p = (void __user *)(uintptr_t)params.uaddr;
> +	if (p) {
>  		if (params.len > SEV_FW_BLOB_MAX_SIZE) {
>  			ret = -EINVAL;
>  			goto e_free;
>  		}
>  
> -		if (!access_ok(VERIFY_WRITE, params.uaddr, params.len)) {
> -			ret = -EFAULT;
> -			goto e_free;
> -		}
> -
>  		ret = -ENOMEM;
>  		blob = kmalloc(params.len, GFP_KERNEL);
>  		if (!blob)
> @@ -6290,13 +6288,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  		goto e_free_blob;
>  
>  	if (blob) {
> -		if (copy_to_user((void __user *)(uintptr_t)params.uaddr, blob, params.len))
> +		if (copy_to_user(p, blob, params.len))
>  			ret = -EFAULT;
>  	}
>  
>  done:
>  	params.len = data->len;
> -	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params, sizeof(params)))
> +	if (copy_to_user(measure, &params, sizeof(params)))
>  		ret = -EFAULT;
>  e_free_blob:
>  	kfree(blob);
