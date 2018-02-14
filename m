Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966852AbeBNEjP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:39:15 -0500
Received: from mail-bn3nam01on0059.outbound.protection.outlook.com ([104.47.33.59]:28539
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966753AbeBNEjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:39:13 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [RFC PATCH 2/2] KVM: SVM: Add MSR feature support for serializing
 LFENCE
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225856.22074.98252.stgit@tlendack-t1.amdoffice.net>
 <584e51cc-1a79-4e5d-45ef-1850bb6c155e@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <ee66fc2c-ba57-29da-0a03-498bc45a40fb@amd.com>
Date: Tue, 13 Feb 2018 22:39:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <584e51cc-1a79-4e5d-45ef-1850bb6c155e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR08CA0094.namprd08.prod.outlook.com
 (2603:10b6:404:b6::32) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d22fbab7-d4fa-4f59-dbd7-08d57364e43f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:CC70zy3kXgT8hXNTXaWSRjKw57ywSJpMSHjZNGjQlsZqgKx4+c45Xzr3HFWML0VrmLZgTP+e5pWyNVaft6QmOoZK2jUVVv8ygcEjJO10kQmhMiIj7quvbS1PzrnW5bhyBkMe7BLhCJEl5oPbPCuPfNP5PARsE9GdJx1pvR3RbTAALwq2XU3odsikc72V3k7oxSqSiiKbvso+i/jD+0RMapIuB0W/cqsDOcpsY/ls9/adMyvYQ0GJBQ30FOR2NUSV;25:5nmQ+3GBNBNbVZb9DsOktZ9YCB27THFXRkfco/JqF7MZNXvj83ExIkcflR2P3k8wFVqz8SRO7QarDhzJDiBpnc/7OvR6og7kSz9zrUePzVSW3Fm07tk19wU0t1KgjNf6B1OJynk4OEzypDol8o8wrN5qHIwYVpc1EjrFhOxNj8HaRhjfIChKZK8y/3Il5zeH7nF5owEx8wSR2SK17k4+je2A88il3CKtHqR7mAiHRn3qWMSbEZOXGOWoorI0kC50cHhd/c8pFC96LHuibUJxnuby7vcfGFNK9HWq4d5qUOyFoB3XezQuFodfd8kgni5JujpnWciIshWTwaYASj40+w==;31:NCvNS4+KO90Ok+q3fCQEpPWYiH0d8xECjnC7qBtjLJiQL3pjs+1LjpVy1Qbrv5lMY+WxCQGpDMCSCYrLhYdjC0WF118Fd5BmrFr/uuC6i3rAeJfGjzNUUYzqGos2rBi3FGqeCCnX5Pr/W1w8stVaj64SHXUJB8Gpb+6D/zJvveWtdtN6faw9MMotJNRNBU6zPCeAVMvt9ao8TAApF3h540dzXGoVCZtUNh3XHFUwBVI=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:JRhNq6KpYabo+vSyiUPHcX1x3jF0D55PwLQqhKE3N7x60CWGStwyQ0f6p6TRJFJHPsDbtgtBygYHGnBKiYb6AZT5Xw6XufR0RIRfSp1tiyQtxpWwuzDrTXyTpPe/9mzu1va5mmHcV7BR7Hz9QjN/VNbOYGyobBlg1drYw6aeTewtZhc6EiYeD1+6Z5Ce2knu8JjhZQu/7h5KOevqgd8yRwzmXS98bUjqhXZVXl3rIgiNP9MzGo7Y9D4q0zcswQBK8MSG0FB7CSH5KLDO3J2HgzssCr9YhNi1cy1UAHgwLNZQ55Irf9fNfPm9AV+QoU0d95dtUhjHLFxVJc9v6daNxn7wXHOPIeoEBjaYIG3AyYr8RgHsv3U9jP8ktYwa6cXQX3+L47JDCOe8oFmoHxzlakwgK++t2athUPWiuJn/96WrDC41zwXULedCbw1XxZjaHghZPrNCOgSsv+DOYJ4VDvtoaxY+oBl8CnWgn7cPZLOGH/Vx+9owQECjCUfZglVg;4:kHKWtNXzQuKv9Mp9p3294qVNPW1ONWlB+m81f2VTmHyMFMRTJiERPqmWJLSZ9nnVNeLF3ESh+cCeUpLJRAa68nDeiVvk+3G9iKApi5To92IS/Iu9sA5fAlVa47mxTtQYNZpjkBFAFpNLmc7aLMXjnSyANYIVeVZByOZzxJl0qCCY8RVPLfeKeBzi2HL9yilwGPCS2KeSS/wmWri50Y55urOfsRsmOAxR5EVhzRVWwAqWX2FhNbPyz/hgXITJ3DuKbbYinV9pMsgK0NyuKx56t4PHbas0bEd2iV8Um/uAhRZa7qrOcGn/GvbDCia4CCPK
X-Microsoft-Antispam-PRVS: <CY4PR12MB1141C488E854DE0175A13BB8ECF50@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(66066001)(52116002)(52146003)(65956001)(65806001)(229853002)(64126003)(8936002)(6666003)(68736007)(16576012)(81156014)(8676002)(81166006)(50466002)(47776003)(97736004)(53936002)(65826007)(2906002)(2950100002)(5660300001)(6246003)(83506002)(58126008)(36756003)(53546011)(76176011)(230700001)(72206003)(386003)(186003)(6486002)(31686004)(16526019)(31696002)(6116002)(3846002)(23676004)(2486003)(59450400001)(7736002)(54906003)(316002)(4326008)(105586002)(106356001)(3260700006)(478600001)(305945005)(26005)(25786009)(86362001)(77096007)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOnMwd2dKYStpeUJFNG8vN2tienc3Z1VLbG5q?=
 =?utf-8?B?TzlxczdmOFkvb2xFb3pOY2pVc0F5RXFiNGRLRnlxRzdDRTZ5bGxnWEkyZ1ND?=
 =?utf-8?B?d01ZZmxvU0cwT2FSLzBjMVRYTi9zcW1qV0ZSM0VFL1NwSVBLdjlGOFNCd0xj?=
 =?utf-8?B?NGxDNVFTRjgyMmVKR3NCRXRzTkR4ZmI3QnAwWXNlMys3ZVJCTDF6bkhtQXJn?=
 =?utf-8?B?UzZScjhQeXFiTVNqQUpnN016VXk1TVRHd1ZDcjZKTEJDWDF3WlAxV25lK2Zj?=
 =?utf-8?B?Y3FtaEpSL2VqZENUWTd3bkRndVpLYS9nVW9yQVR2cVY3aElBdTFlbmxZZlMz?=
 =?utf-8?B?RXF0cnhaSlg5elJiZGY5WlRlK2ttMkFxWmNyVit6SmJlaFc3czd1ckFZSkx4?=
 =?utf-8?B?bnFHbndZRGFqSkZuNWVzWWM4Wm53QnNmL01zSXZBOW5mNEVwSlVTYWthb2Ew?=
 =?utf-8?B?T1dqeitVL0UrZkEvUXlhMWxEajI1ZkVhRnJWS2F5OWNUNzdIcGgwVjM2Rk9N?=
 =?utf-8?B?a1I1SlhibnRmK0oyV0NmVlhTbGZTdlFscEJ0RWp1andsc2tGVmFWekJTc3Ju?=
 =?utf-8?B?ZXk3a1Uyd2ZhLzVTRlpWTHBzZHVldDZJRVd1RFY4bnArdTFudmdZem9ZUlEy?=
 =?utf-8?B?WkpvWmZURWphOWRzYXliYzg1ZXJQVlRkSC9rVkxnVy9hS1ZQWUhmUGhkK25F?=
 =?utf-8?B?SzJRekh4ZDc3dFBXOE8rT2pqaUFqeTB6V2tFeHlJWFUyTTJsZE9EYlNlRmVu?=
 =?utf-8?B?VDlpai95Zmpwd0NPZDRzNVIyRDR0USt3cCtaSzBQODVFQklGcWJPQVUvMXRD?=
 =?utf-8?B?dVNHVDF4RmRKSWVaK29sTVoyaXVibi9jN09qZm1hcWFPeFpHNXVEeWxyN1lN?=
 =?utf-8?B?c2dKTHFGSFJHd0YzUStLTjYxS2lpbGF2MTM5M1NyNSt3bVhHRFc2d0ZPZEIy?=
 =?utf-8?B?VnJYQitQcjdjUEdVZU4vUDNUOVNPcmhUdWxOZEJVRVRrdU9Tdm9zVHdoeHFC?=
 =?utf-8?B?dkQ2V1FyOHpKbnlET0RCMEhtS01BUXBQbUhLS0ZtQ1FGQS90dDc5SGV6dmRt?=
 =?utf-8?B?VXhJTlpac3F6V0FZSk1qM204WU1tTDF4NFhGaHR1V09nNGRxMDNqQVhHRFhN?=
 =?utf-8?B?YlR2cTZqL1VCY1RJdVJXbXFzQzZUWWRPTXhnT3crOTlrdStPWC9ldXorSmNj?=
 =?utf-8?B?QUo2VDhYUTlhbThaaEcyUjFESmFvbkNiQjZWM2VCMHlVRFY0dTF1b1pRbWdE?=
 =?utf-8?B?S1dPMnRkY3hQUU8vSU5aOGJEb283MFJZd3ozMDVMb1ZldmhlTzBJVmUzb0VM?=
 =?utf-8?B?ajd6ZWlXZ3N4dHlSekJWN2ZpR29KNlhEdUhnQUw4TFM1VmkzSHZ0c0t4OWh4?=
 =?utf-8?B?c000V1Z2UWtGRFRBeUs3SjJCOFhDTUdLV2dRZW5EREh4aG5TclNjNFUyZUNU?=
 =?utf-8?B?Tms3dVVnZ3VWQm9GZklpNmZ3RzFyMWthYkkrWE9vUXBnSWhjUE5EbFdwUGlp?=
 =?utf-8?B?TE5rdHNMZmRRNG0wb0Exd25sbmljRjAxVVhZTzBwTXVQMFltQ1l0dnRFZW90?=
 =?utf-8?B?ZHkvR041ak91NTRncUpRdmQvM1NwdnZIaXhZQVZ5NlpQanVXWml3bndjV0Ry?=
 =?utf-8?B?cDlhLzgzVW0yVnpjbTJteWRVOEM1bFRXYis1Q0VqRmxsa2xLcjlQbXhRMGE1?=
 =?utf-8?B?WWtESmRmc1hHNW5OaUZ1bW1YU1Y1YklTbG5VR3FLenkzZzB0NHRFeEdHWUdF?=
 =?utf-8?B?cjloYVNVKytIeUthbVlES3Y1QXRrVEpxYzUxTytjZTNuSkhJd2d2SXFna1R6?=
 =?utf-8?B?U0gxVnZoUGFYMG4vL0lzY1lUU1BBcm54TnVISFI0R1ZINUcxc3B4TlFvZnpy?=
 =?utf-8?B?VGlKZHRYSEJqZVZDUHF4WDkxMWYvV2xMNjZZYUZ2U3hlN1NoelkzWXUyNk43?=
 =?utf-8?Q?OiZIkfYeGJP83rnCck7zahCf7Aqgdw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:/b8pR5SwTJ/rKVyTC3aFX/7vsb+jIl+KxKsAXWQtPa4Q25xvZlVzKKqaHszBK9r/Kse8R+Iyq3NrdIdZXFD/N4F/3Q0QSez6HEvooag/0UZt042pJ1wRP4ubiTFH/8u0WH/7kKYqb6yINdciV0ODXnAwQnKLehjTR8jbbyZVbf72BifRVIjOs6150bh6vzFW9uMUnh7TwaYu9jwVwJMspggyO82SjScLpqfnIBijN8DqSqsXqZe4TGAKd8iNLZNFvlylhwVFYNNc/uy5Cr+dpFtRcYprMzZkM6cHT6j9gwYHlKDabnuTYtFdNy6WfE0hIdPDn64I1xRfBGQILcVOZYLf8RipdrrxTki+2oMFdX8=;5:pRI2MeSR97Ya1pUZASz1krq3NUmPy92J2Rgb/3KDA26jadlTarUsORWzLpl/zadllKk4SayS6tINQ9jNFMI4tPHJd1Ab+NCj9GWtqiVIQfSargcr47nlwYCAMiMqAjvQ8ca49nOmA3Cs6bktlEzSafLlVOqhpfwZNVc9/FqWans=;24://LULklB4ppATO9t+JO2JUM5HE55PxtgQ6gNuQnXRdDX/0SQ7+R4vY/OabNVEwux8wMS0YHuBRJPxPiCpw6nUTww0X+GHsgV0Xj/XXKGS0s=;7:0Qtxa5jvsZdT8na2HMLv1FktUHcYnxt3lI5MQiJq61Gy2fnE2Qux/hxpsmxJxK/47c9SzHggdLVVyf/I1Zo9EfFBARmIZMSLqG6SYX1QxOPeKV+GCSBc8ctQBgjtZ91RS4dYSmNmwriaBWzFe0QP/M9NoCCzxOPMrM5pD2DLSxrv+mEWqK00VfZjpCeZKJ/kYN3rtJo9hwxXY6Qyk+AxLyOlWv40P+ItjHV2iEhnhI1xHnipENNoPhPUb9cr8362
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:7undklswHB2KcnINmNJ6Q95A87NDvocPp0UXmyHMwlYcrXZn3lqrDhgarZs2XjDpvq3fDZX+OuwgYDXK1gLFv1ssTfLXa/DhnAY/JdBhG7KFChBLrehFCiQ85zgKrri5yNTbSDx9v2gACERAjRmMWGy175uoA7Hiz/1FqcOfH6fkjTn0JNVpTLaD7C/l8mvnOJRLrb0wmwv6IlXn7B/PmSmH6YpogIJE4Z5cTiUdMnYCWatMsauYslxT4UU22NGm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 04:39:09.6107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22fbab7-d4fa-4f59-dbd7-08d57364e43f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 10:22 AM, Paolo Bonzini wrote:
> On 08/02/2018 23:58, Tom Lendacky wrote:
>> Create an entry in the new MSR as a feature framework to allow a guest to
>> recognize LFENCE as a serializing instruction on AMD processors.  The MSR
>> can only be set by the host, any write by the guest will be ignored.  A
>> read by the guest will return the value as set by the host.  In this way,
>> the support to expose the feature to the guest is controlled by the
>> hypervisor.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/kvm/svm.c |   16 ++++++++++++++++
>>  arch/x86/kvm/x86.c |    6 ++++++
>>  2 files changed, 22 insertions(+)
>>
>> @@ -4047,6 +4052,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>  	case MSR_VM_IGNNE:
>>  		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
>>  		break;
>> +	case MSR_F10H_DECFG:
>> +		/* Only the host can set this MSR, silently ignore */
>> +		if (!msr->host_initiated)
>> +			break;
> 
> Just one thing I'm wondering, should we #GP if the guest attempts to
> clear MSR_F10H_DECFG_LFENCE_SERIALIZE?

It would be more consistent with other entries to do "return 1" here
instead.  The current kernel code that writes this bit is using
msr_set_bit(), so a #GP is caught and handled.

Thanks,
Tom

> 
> Thanks,
> 
> Paolo
> 
>> +
>> +		/* Check the supported bits */
>> +		if (!kvm_valid_msr_feature(MSR_F10H_DECFG, data))
>> +			return 1;
>> +
>> +		svm->msr_decfg = data;
>> +		break;
>>  	case MSR_IA32_APICBASE:
>>  		if (kvm_vcpu_apicv_active(vcpu))
>>  			avic_update_vapic_bar(to_svm(vcpu), data);
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 4251c34..21ec73b 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -1060,7 +1060,13 @@ struct kvm_msr_based_features {
>>  	u64 value;			/* MSR value */
>>  };
>>  
>> +static const struct x86_cpu_id msr_decfg_match[] = {
>> +	{ X86_VENDOR_AMD, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_LFENCE_RDTSC },
>> +	{}
>> +};
>> +
>>  static struct kvm_msr_based_features msr_based_features[] = {
>> +	{ MSR_F10H_DECFG, MSR_F10H_DECFG_LFENCE_SERIALIZE, msr_decfg_match },
>>  	{}
>>  };
>>  
>>
> 
