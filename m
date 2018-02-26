Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeBZScj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:32:39 -0500
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:52039
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750762AbeBZSch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:32:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v3 0/2] KVM: MSR-based features
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
 <cb405817-0bc5-fdea-baa7-e11e4a7a4163@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c2194502-4326-3c7a-27c5-eb6c0d82b8f5@amd.com>
Date: Mon, 26 Feb 2018 12:32:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cb405817-0bc5-fdea-baa7-e11e4a7a4163@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR22CA0072.namprd22.prod.outlook.com
 (2603:10b6:300:12a::34) To CY4PR12MB1144.namprd12.prod.outlook.com
 (2603:10b6:903:38::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a360f23-e86e-4c00-a2a4-08d57d474e4a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1144;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;3:qHbQDSJy0Piew+B1IrGhGPcSSw42ZTe+FjeGTB3XQe+wQXIssPkQiaMGuiypa+ehHcRZnVeFVfLQOw/ggz+f/VaUwQeFejaUtr2g+j2YNZpes3mvKoa+fIpu1qi0SNxso76Q8ebeiuBPCVvD1kccjNR8L26FTZwKC3B3mM9KE4Dcma1PJLROtUkJev0CLOtdE+6pQlvqGLXzDRywoczmHqWjObJSc2nQFOPdmX1t+SwT6TPAMSP2r8FxcezpQIFQ;25:sGuGuTI54dxXuL19DP1yZoDNEm3iOYlotj452ZfUqWSK+WY2xDLn6X8SnZkhEY8iVyNIMRmDPqCs6HiNdbNTkV9MBjXnCAvmi551EBBfvTdHThJ1mDM73GNKzZr44r+MBjjtBZ6me1hU9AhsdqiWLT3nL+mt9mYPBglmdEeFqMDeBkwBjPb0gXNhOTkpQSyVfZjxXLqXS+TEkWfTyJHnpCQRCH2D+U2eZ4Yg1wb8uizFR4ViyFXDg1ZEZRjsxJZEfaDoiemSjjmSxT1rXaM5QrNNp38f9NGknSYpAn4WD2zFHm5dhMAJAbF6UwnaAuKWi4MUoN0YsT3VW6vw2/Gqkw==;31:YcjE4o7hJW36t5vZhcYv7IdTZ1wgTN7u5gcn01L/Lu6WYw7+yarwC2igeZ3ok3QEk/p8aEirvSfxCWeyUAfeGd+aJJYxEvEKRV90PyD0O3MKfaEgf9On5Yn7pQBC222EdG85acrReJRMM0sE2IGeDqN3OGRXfI4sBgeol9nbP0K++Erk2RO+TOai6fgZfMwUpqK1a8OnGppAClXPCMnXDcYotPePKk/9Y2sw4wyCinU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:tQb3hYIKKq6lOKxDyNa+p06FzSTTEsy7HAk6w3gklSW7w//P0xmy6yRs/LJGukaz39aj6x4HcJB8+ISxp/00D6kAg6ggzi28SaCBPVdVbwrGgj6Uxgl5qxjg+u3tL/lMupyDTyOXcD8GA78Wege20F4thS0yermSgR2lfngBc+5mp+uMVbO9cFswDHu89N8p9dRVYSEu45M+zrRzrTxqGLc3K/2qd0wwp+gmEcL+JYkiZDkIWWXrqf9xWkn7d8SAToraRS1CRD2S73OZoveD9wSqPruk0K6hTlLcogH58EXP9LiEekho8425Nkcr5NJEz4lJT6VG2HAsURgEWXVMM7HVaWhyEP7+TIddDl82WXyB5svPrdWXVkxAdomzj2EImAQItxg9thBcl501lesMn0POE1mO+T9uIyTe8qurCiBORZ7koGkLsgoKZdHBviw+UGhefG6gc6y8eG3MD/gHaYE/e2H0uQl1iqFyA1UsLuoydXfjuhwOfQjAdCXBrt7l;4:KSIEA+cx3UkWn0oH+GgPY/wMBYXuGoN1ytifccPDbhTAy+h4/gsRh/WmEsCw1t3gD0K+Bs8IaF3+Cms/X71L0YKABuo11zkEKVvibbs8dggh7+pVo4UXywh51T3Ue9mbwi2um/yZofdiPJqOXJ0eJ0pfJVFowz8NNcwjTOItvXZfy8MDOukNgUa8ZrHtwP8m9/vItEKZYirKe8MqhT/v47fqka96vHaqz9oKEpeLCsqqPBjtLfVQ24N4ZvpVGjdk+BTNR56QocXX3mn1kzK6e2JZ4tANXLeK2glfADb1EsDLl8Nl1a4NmCg69UVNRNww
X-Microsoft-Antispam-PRVS: <CY4PR12MB11449F6721158CD7C4036122ECC10@CY4PR12MB1144.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1144;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1144;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(81156014)(81166006)(386003)(64126003)(105586002)(229853002)(53546011)(26005)(65806001)(16526019)(65956001)(47776003)(3846002)(4326008)(6666003)(186003)(66066001)(6116002)(106356001)(76176011)(36756003)(86362001)(305945005)(52116002)(97736004)(5660300001)(23676004)(77096007)(7736002)(65826007)(2486003)(52146003)(8676002)(31686004)(31696002)(53936002)(16576012)(58126008)(316002)(230700001)(2950100002)(6306002)(6246003)(6486002)(3260700006)(25786009)(72206003)(966005)(68736007)(54906003)(50466002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1144;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQ0OzIzOko1Nkd6cWwyWlN5OUxzQ0RUMXVzWGd5V0dH?=
 =?utf-8?B?TVBsenROUmYzSzFYNyswSytXQ1NwbllKWkdWL1Vud0dmY09Sb2JUMkp6UHpT?=
 =?utf-8?B?YzB6dkxEVkd2TFpnUXUxRzhiTTUrYTJvTVl0UDZqa2ZNV1RCWGg5VE1EbVRj?=
 =?utf-8?B?cDNsSEVZOHR0ZDV5ZlU4TWp2RVljU3lDamdpcUJ4SDliUC9BUk5VOUwxQkkx?=
 =?utf-8?B?UkdiUks3Y1VzUUlIcHRKSE91WDQrMy9GcW9uaEgwbXlsUi9FQldPMkhJa0Nv?=
 =?utf-8?B?QWo4L1padyt4anhXS29mMC9qSjE0a2pLM21zOGkxMCtITk1lNGRuUU8xaUh0?=
 =?utf-8?B?akZhSXVjVFl2WTV3TkVYMUN1dWk1aXdCeXR6L3BEOC9jL1FlaEJTbVg4dE5j?=
 =?utf-8?B?eGNTTllnV2I5UTArOUszS2g0ZXZVQ3Q1UUtJd2VjRW9YWFFqTHJuMjA0Sjdv?=
 =?utf-8?B?cmhOQlh1bERFRGp4TWtuUzNmaWhIUUtSamR1NHhON0FNcnFQZFgrdEJ3bldL?=
 =?utf-8?B?NHNRNENNK3VxOFF3UUhhVDZmNCswaEt3NFBmL0tIdUREcjlSRzBuMFp3SDBq?=
 =?utf-8?B?QlVBZzlSZHNDajRxZ2phUFpkRWRzWHBIRDlxdzFrM0xQNTJnNDNwT3VtcWJY?=
 =?utf-8?B?TUVscWt5TnBaMWdzaEp2M1VnUmw3em5sOC82RlJaanpxaXZWSlN0VW9SYjNl?=
 =?utf-8?B?THoxMTE5SUk5aGlLR2RGN0pmMzlYbzdicUhpYi9rejBOaDE4S2ZjejBCelNO?=
 =?utf-8?B?V1RMR0oxc1lraHVjV0cwOXZTSk1CY0V3TmpWWVRpMFFIS1lNL2lZRWFOYjYx?=
 =?utf-8?B?ZC9SZm9YSG9kM1JHN0RsN04yVW5uZVFTam9rR3NNRVpBWjloNWVkUGdxcGVw?=
 =?utf-8?B?eC9vZGhEV2JROTVXOWl2VkRlZkhjb3p1bVhtcG5ITnJSR1Z5OTlJcG9MSzJ5?=
 =?utf-8?B?N1lud2hvdUJpbXVnSzFZMlNZNGhBelNHOGRyb3Izd1E1QmdLMkRIeW9vOFM0?=
 =?utf-8?B?NnhpMFJnQzNHUVRyNUx0b0ZyTnFKeU8yUWc0WmJNOWFnRTFXeFoyZDZvNUlW?=
 =?utf-8?B?anJDTW5TNkJJMWRFZ01uMG8yL3NHRU5tMVVMRHVLaUp0NEVIRkZsRTZLTjBr?=
 =?utf-8?B?RFRCSHd4TWtFbmxPdWlya0NMWlJDNit6N1hiNGIzR1JOUk5Wc0YxTC9jOEJa?=
 =?utf-8?B?NEhNc3Vid0pQdmtEY1BHZ0V0T2gzekhHbjByR0lUTDI0RGFYK2ppK3YybXBD?=
 =?utf-8?B?Mi9OT2luWTBtck90SEZnbXVBaFNSVEtkMyt4ZmxZcU15YWl2NjVDR1NtRGVj?=
 =?utf-8?B?T1JXSXdPOWttQTdWL2JaSUVWWEpLdXh1djJjVCtCcXpiNGUrTjBXbkNzYXJM?=
 =?utf-8?B?ZTB3Q2pYN1cvaHdRT0xneHNWaFM0ZW02VFJuamVkS0hoRjJySmFqMTZFSHJl?=
 =?utf-8?B?SEkrRzhhVi9oR2pmaDFuM2xUbERDQjhHM0lBYUhJZngwNkZxQ010V3NlbjNY?=
 =?utf-8?B?Tit4andVbHJYbkZGZmV2UXVUa3VSeUVWUkpJa2Z4bzNybzhEdVp6MHNhTDZR?=
 =?utf-8?B?K2RvQWlvOHZicEtMNTEzc29QVEpOSmozSHhVODlIS2IrU3lUY05nVkJMOURw?=
 =?utf-8?B?b3ppWTRZTFJRM081V1JZbmlrb2dNT3IwVGVEd09FRVhLWUp5UER0Nk1lU2Ir?=
 =?utf-8?B?WU9obTJ0VjB4VVNjWW5KVW9ZYy9aSlgwZFdaYlVpTnRMMVFKMFhBdHJyb2kw?=
 =?utf-8?B?MjBWQzFiNS9oRXdMN0Y4c3A1TFcrTXBScnI2aFVWQzZOQ3FQY2JvRGl3SE9E?=
 =?utf-8?B?RjNHRThNczhxK3c4TFlZU0FiejBOYWxMQlBxUVNIemdHMm1EakJacDl0QStC?=
 =?utf-8?B?RDQxdjhUYTdMTWNaUzVuWmFRMVlHZTRLL29EbHlZWEFBclFINncrWmFLZ3Er?=
 =?utf-8?B?MHZJRTJGc2pnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;6:KfyOmTLWgZrMf3L2H0sOk08nlOu8T0WVmxHq1iCD6leY+vKkA6WCR1ACH6DAuz7KUdYw1Oem70CrxspKmoiwn/4pVJrMAc5F+Qp2eDT/Sr6Fokoutb1807YxJiNMmG+Q59iyGy8vqbxa3U1Clts1ou+7LULDP/8On9beZlDp/XHSElXJSVxWby8mNIO3djDvSqhXpRNHCBvNQjsYsqvIZjNQurjARllteYH8WZ3jKKARZGRWBx2WR9h5uIqmbKl25B13n3ZAzkkHDQZnb5i4yW5kZrx5nraQC9SvhBQLpw6KsKwpocgSFnsCF4v/Hc94yXzTDM7iaMUIv681+/Y+cbv1nssgbgNDGMTUdIS1RCA=;5:42x8xrxmp1XNnA17j07t5vsQwFqHf7IXEBmsWFQ/sM/27J5ynXzIXciSKEG4w9f9/IcY8LOwJ4IcgtmFkB0sB8XBxhjjEjiZbJCTXmn6G5ONOdz7p4BROmddxdzRGwZPExFdw3o41SYmhZLUU5qrnxlb/P6GE8kQFe4QoFyjIk8=;24:85309GW35qBGyWvQ59VjyBL3tbl2mYGk5/aZUqbpJCQ8/wTU1Uc+YwsW+DZyucSF1UAqs7Srfr7CSMKfRAHKNNHuven2GicAAT1Bo7g6uTA=;7:igFrIE6njjkchW9JRmvlSNgaG9vFlhArmF+Jws0bfJy8l0mtRBJ4dcU2DWxcVNQRPwMz41qeTmWOTQQuLu0MqNf6u2gkUYMWOmo19qAroTZaWoY/IQ9ai1Ua6zXC3bPzIwhvPDE7zwY5h8q/6VZ2h8R9c6Ps6KVvMulpwtM6zsTfaNu8cGaNrhQOWD12hjPBZAaYX1hfNTLMFgIv4XHTaAzR4yufNYH3I3p9+UnwP3o731786ILWLxX0Ol/sm8Ai
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:yyD7+V7cKwmo7cQJ0qUruhLJsSGD+VQQk7OJXn3NgB4eC+ih+QArEt/FwEv97tNmvcbWsjQaASUityE/J5ylQuwth7IjawiW2IBwammntIkcDrfaZ1T6LzG7paSGYEBcCRZ8GR/Qncq3cJLZwhAF2KSQdi6q05h/h9ydwx75F27ozA/DfCh/67cFgny5p2jMGd8P88wac0tQeJcqlNve1QHCujmx1nVLeja9L8AxGAvvvSKx8s1CUdtKwlBuPgV4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 18:32:34.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a360f23-e86e-4c00-a2a4-08d57d474e4a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2018 5:38 PM, Paolo Bonzini wrote:
> On 21/02/2018 20:39, Tom Lendacky wrote:
>> The following series implements support within KVM for MSR-based features.
>> The first patch creates the MSR-based feature framework used to retrieve
>> the available MSR-based features.  The second patch makes use of the
>> framework to allow a guest to determine if the LFENCE instruction is
>> serializing on AMD processors.
>>
>> This series is based on the master branch of the KVM git tree.
>>
>> https://git.kernel.org/pub/scm/virt/kvm/kvm.git
> 
> I made a couple adjustments:
> 
> - use a system (/dev/kvm) ioctl, which unfortunately means a new ioctl
> #define but is more consistent with KVM_GET_SUPPORTED_CPUID and
> KVM_GET_MSR_INDEX_LIST
> 
> - rename msr_feature to get_msr_feature
> 
> Please take a look at kvm/queue! Thanks,

Looks good to me.  Just some documentation nits.  You have an extra "S" in
the documentation for KVM_GET_MSR_FEATURES_INDEX_LIST vs what is in the
code, KVM_GET_MSR_FEATURE_INDEX_LIST.  Also you have "vm ioctl" listed
under 4.3 (KVM_GET_MSR_INDEX_LIST, KVM_GET_MSR_FEATURE_INDEX_LIST) which
isn't valid anymore.

Otherwise, tested and works fine.

Thanks,
Tom

> 
> Paolo
> 
>> ---
>>
>> Changes from v2:
>> - Moved back to initializing the MSR-based feature list in kvm_init_msr_list()
>>   (based on the kvm_x86_ops callback return code)
>> - Removed the definition of KVM_GET_MSR and switched back to using KVM_GET_MSRS
>> - Consolidated the documentation to group the ioctl usage and describe the usage
>>   specific to the version of the ioctl used.
>>
>> Tom Lendacky (2):
>>       KVM: x86: Add a framework for supporting MSR-based features
>>       KVM: SVM: Add MSR-based feature support for serializing LFENCE
>>
>>
>>  Documentation/virtual/kvm/api.txt |   29 +++++++++++----
>>  arch/x86/include/asm/kvm_host.h   |    2 +
>>  arch/x86/kvm/svm.c                |   43 ++++++++++++++++++++++
>>  arch/x86/kvm/x86.c                |   72 +++++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/kvm.h          |    1 +
>>  5 files changed, 136 insertions(+), 11 deletions(-)
>>
> 
