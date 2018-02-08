Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBHXDW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:03:22 -0500
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:28704
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751079AbeBHXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:03:19 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [RFC PATCH 0/2] KVM: MSR-based features
From: Tom Lendacky <thomas.lendacky@amd.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
Message-ID: <4732839a-48bb-9183-be4e-0b7233094265@amd.com>
Date: Thu, 8 Feb 2018 17:03:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa2ffc6e-4674-48ec-d3ae-08d56f482478
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:22CRLccv4x188PW7tpAzGTwYEZVEgINnmNbe1f8cYpIKimShEThBeX8E5231007BGlxkPEOY3ATN4UfPKN1tzEsu+YzLtdYRgHuaiKDm+jbU7CBPiybkndxCJ21EAC0UwnzhtPUl65/D5coXYet0qq04lZjnZgON68Q5rnjV/iGJtUybMH9hDK6Bx5ee75HbVIwteXOwtpGHDbKh4gZ8NoImrs240mEJOs0AA5xfXQUW1ai9byPFtEESipL/+xde;25:8kW8aYVzdpCodnTShaNzsjCt0LfTOiZAP4tXrMrQr2ONSTy/AtBPNOy+n2b4iQ1WfxBGPKsePhkPA5km7/1iSEDfIVPxmmhKxxJVSNApEsz1lSSUTR/UPPyIr0GsIvL/gH1rQI6VjHBtdQHlB15S9K+Bb946ELNon8vAFHk3DgE5HibT9auceGoVQcg8G/y3R6uGNL8os3+bpBf4NgH0gQG8NPDsaK0IOvzMnTcu/wx20GD/F9JV9Y1ukX8spdVxu/rOl3MQazZiLL4L+0uJKLK7TeLqb5g7/+roP1WUw07BcVZ96w+z+cXfRjRse/bH7yUg3Vwh9hDMFeMfkMRmGQ==;31:S5YFbMOcndRfn4uGO90wcQQ3whrSzgqBEr1WaNURwN4HbW3xLIHqvl8+guiPHsNEiA4qBI/kkL1IC+OWwq546E48hH5P4uBLoFxIvpcZukFU8fwL2VLG80Rdt94FCrLbvg+qIZrf3zf+iesfq5t+hmU/1ml/IVRJWczd2/gcWOIG8FQGsGSyhUZJgKbD6b+b/7OunkJzHOB4YUw/7/CHSnSCMsImqT2Cdik2/bbdx4E=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:zIc2gk7WjNFqdtRY5KMTbrteIHwY3g9UOUTTy3Cg6VGRsOZYNCCUjdorCFkNlGow2EA6vyKzXxchkqhjgyH2Gk11MTa1vwL9JWSxgfhNC46YCOeldR9Guuydbn7AHH63mi3Fh8PfEGFR4vcjYL8N2g0ibNOc+pg5mV91kCjHFjwfSOceakD8IQC99zA9L5RUCOZiFadsrdxviXdvsQDmUFDwftzYOS+vWV//uIOyBa3kOMsnPrXAKAQ3TuE/i0/CynoEGXrk6kjEDK5dUk6SZBmp702l0jhZOgMWX0Or4Pu150naP94uHopSQDp9FqCAKWptChmZsdEzPwmkM/oN2F3G8D2rMjb6MQO6CKMZfqz62KiZIEk4LX1ZMtnAI3AAeCdRLErqf3Zprz2/hBZfqfYQpXAzrlaeCjum7R5xB8X+OBw+VsPUSdQIxXD7Vfy/ANvR5Fuuo52qR1ngZez4QedmA0K5WjUrsnY9kevZ8ethQ7lCcCNqDTNIFea9EVRL;4:LLOfX0VCWzxTL4SK6OiLjQX8ORAa+iiUW7BM0TZ/EGzhs00ErB2iB+pbC/y4c9ifeFha+3lPJrUZ3mlKTTY1n+w6Fr9rc5A2fZvYPj79xgB8tUAznoNFgzm3rKLy1XROdISjfimAIQPkmbb26mVFGOBBnrVWyYVdEkBcZ1hnmPfPOM8ce6CmiDLAXk1KtbaRdjGXS6F0qfpqP6kBAjmQe2zFV3nkFo20EKDFQDUQ2y1XsqiFztQaju385Md1gNCYuZEfoU7I2Jv5piyqrerlgA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB11416953664E395263B984A8ECF30@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(396003)(366004)(39380400002)(39860400002)(189003)(199004)(72206003)(316002)(6116002)(16526019)(6666003)(4326008)(386003)(186003)(5660300001)(76176011)(2906002)(25786009)(64126003)(58126008)(65826007)(3260700006)(97736004)(53546011)(3846002)(77096007)(50466002)(26005)(6246003)(16576012)(36756003)(54906003)(65956001)(65806001)(81166006)(81156014)(2486003)(53936002)(86362001)(8676002)(66066001)(52116002)(305945005)(23676004)(47776003)(6916009)(52146003)(2950100002)(229853002)(478600001)(31696002)(8936002)(7736002)(105586002)(68736007)(230700001)(6486002)(106356001)(31686004)(83506002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOjU5TStETnd3UlBXNnV4ZlhtQkJaMjhVc1Bu?=
 =?utf-8?B?Mm5MM0VsRGFyUkFJby8yaGpHQ1FNTVF1YWJPYmFoUi9Mc1RNK2xBNUFGQlEx?=
 =?utf-8?B?ZWNpU09tTkV4aGpyZCsrWlZVNjZ5dWNaZmlod0hBNmZNYTJTa2laV3MvNzBn?=
 =?utf-8?B?UG9OSlA5N3drbFFteldyMnM3TjhsbDZndG9ubDhiTkhjc2Z4Rk1SdnIyUzM4?=
 =?utf-8?B?b1FMSmlGclJ1a1MydWFIQjh2ZEN5TEJSbUFIOWI3ZFdXdmF2NjFhQ2lqakhi?=
 =?utf-8?B?K2NERFZNU2NtRWN6Q3llbU1ISTBBSmNoSHNIdExLdm1QWXQ1amp2b2R3bjRE?=
 =?utf-8?B?MXUvUFcvelErSjFvYVR6TDNZcktmOXdFSXZoVUZVd1lybUQrYlFHekI1QVFu?=
 =?utf-8?B?VXJnbUU4akEyaEE1dnBFVWFldjhmdjByeW1EbzVKeE9vdmdDaXJmci93MEZt?=
 =?utf-8?B?eVFsOU9obVZKZXE3Um53c2JHcGFYR0xxS3VteHNkOWsvbW9sSmJyYnBjVTVD?=
 =?utf-8?B?T0t3YjNKQlZxUzJET0RodCt0VDJMRjIxWFdSTzZuTmpra0FESmpwRjB1aVBJ?=
 =?utf-8?B?QmxiZXJhR0o5TzRnRmR0VVJKZWdjbUczRzlCNXJiSFhvNmFaVDFkUWg4TDEy?=
 =?utf-8?B?aTZhZEhid3lsY2dqSytnTWFCcUMvcDhVSmNEOTJ2TXMxcjh5bTV5OWZmajZu?=
 =?utf-8?B?SzZvc1A0M2RIaWNKWldHSEpaSnhLZGxiMElvWFozOEE3MDQ3akphY2FNMzY0?=
 =?utf-8?B?UkpqYmR1M1ExWnF5eWhDTXNxQU1XZGd4MUV1R1J4TDNNYVJyc3dNcDNkUzFK?=
 =?utf-8?B?cW53UHovVFh1RGdYUlFKYVZKV3hyS01uQWZpNU1oOGxFVm5sZGV4cXNCVE1i?=
 =?utf-8?B?amUzZlpiVW5SUjQzMlM3RE1ZNkg5OEY2OWtZVm9HQU9vT3dMLzhmM2dLRGJ4?=
 =?utf-8?B?bS85a0VRSldzR2Vyb21jV3FNbHpiTlVtdXpIRlRiaWhFb1NzcEZtYnVuQ01y?=
 =?utf-8?B?Z2UwSWZqQ0hqc09tckROZElBTVZaZW9CUkdTMVRKMlFISmpJYnRqWVphZFBR?=
 =?utf-8?B?VEcwSHRXNit4aWhodExxWVg2VFpZRFdSSmRQb2FSZll5cWhJYS9MVUNib21V?=
 =?utf-8?B?d2dMUVozZStCQ2tZWHVLRkxxWU1qUldkT3BHRkd3dytZT0lENHkwUWp1WGVs?=
 =?utf-8?B?b2RvY0ovTTVqVFdQRXJINHFOVWJvZnAycS83RDdrVVJLWHUwQndyVUFLUzI0?=
 =?utf-8?B?UVZyQUtNRUdKSXA0OTkwcGlhMzdzQm5iY2Jaby9aR2haamszKzJKVVlkMi9W?=
 =?utf-8?B?cFBrL3RGYUVkMm80S1ptdUVxUDhiWkZsVGR0M2JnblJrV3VrK08xZlBabndo?=
 =?utf-8?B?UGJQbFZlRXpUS2x0dGR3d1V4akhrb0VzKzB1UGxxN0V6bnBRNDFRelVlYllX?=
 =?utf-8?B?N1Z5VFRieGNpaEZtRUFjcC81YmxBaDEyb3NYZkdvRVRMaTdnamE5bVpCRlpn?=
 =?utf-8?B?VVkyZHI4YmpjTjJERDBiVnk3K0tmbU1CRVJhTDlOVmtVMVN4VHNmcDAxRHpD?=
 =?utf-8?B?L2Z6VHR3L0NKY2RSS3BUUW5WTER2TU1JRUFUTDhmUmZ2YzBQTldUV0RzdDMw?=
 =?utf-8?B?WjFsNUx3eDlBS3plSVEzSVlvRjAweXZmMmFTMEYwTTgrNUZDVnhrREhsb084?=
 =?utf-8?B?NVFJMk9UUlkzVDRzU05vUU9sS3VKUXdzcm5BWUhRUVNkQ3o5MFk0bDBRcG9Q?=
 =?utf-8?B?d1U0VE9FSUI0dnhmMGpScXJqb2hrby85QzBTSG9DS1Ftd0pWcWNrZmphVWxO?=
 =?utf-8?B?RUx3OVg0a3hLL1hKMzB3TjJoL3Z5YmNBTk82Ny9OYVFKTGVEMThVM01rQkF5?=
 =?utf-8?B?RXFMem1MUldUdmFJbm5qUWMzRW85NXlWaG5oekJsVyt3UnRQTzhodnNlVjY5?=
 =?utf-8?Q?yRy9kUwIDnsw3qfnJDoW6Sh/oJkkwA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:k/AZNxbhz9BlsSsSX0tE2cxiVVDpq/EE+k/QnlABraTf+IYi6lTlZ5FgkeTDspDeYX9TaPUMcBswDkp5TU2ORUF/0ZPhhYnHTtgH5Ibr1h+J7w0cEykzrJneiILFZ3Y5ILe2/PqdSww2+jKY2V0eTqUSZJxLIEVAk0VveEymXhn0TwlWSCX/9XLCOH1lV03Bdm5duAedWD8yb8ukYqBuohFNe+hpdV58vOPdONZIwKfM6rIJXqDZtQ1iazsAvIlo+lG9TAlw88Pl+Vhz+oBbhZJq5Y7Kdbrnp5BqJRPNRwWCt7qX0rSNBvkvZ7bVXF0+gW4n1KHiy6OCjN/zlniuZHKWVe5uhQ2wII/RwV2bTUg=;5:+oobVE45o6HzBMDtVLd0XH+O7kZmtj/mIlza1fKQuF4LMsfC1jdhLtXVVVuJw/OeK+zkZRWA+JjlXz0aaWHYquKEN40AhM+lAlGqWAmdkTNNftCkdUnVtv5VHRorR+jEvSRoamjM1bdQFfsYrj4x7zyiIs0231d8euLkO6QzEps=;24:NJ0JHdicsm8tf0sezvc+eK8Qbildv87ymikqx5jrsvqUKUCfGZCWoLnuTiMDmbbgP8HM8twKXL2PsAAtY3qBy8+gyZV1UDF7q+EhQCMChLY=;7:qXJrHCsX42cLPDjiRWObq+nluLnNhzKJkocvF2Xli6HxXndCORTXL8TO+LtDtC87Pp6oB7AWamPuIfG7E96UyY0hDYEvIMBwOwnDf2ks8gybfu5wbIK1UcDwIAJMFHCjRFlG3ThjOtz150xdbtabxS7gxvuN54uQrRiP0mK0xIMJprk/0ZeJPVx8KAq92AA+nwpchq9u/1wkNyqgkT2xkvTcvOnFxmRpaMie0T91CsPgAkb8iz6r0ZzC5UkZyx/S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:mP5bFLaULWzE1OGMGkAAe4GZjStI/SKqtrXp156Y+GaWdE6pI10IeT2JB0M1JF58ta3H0yDBwBcrm5w58nY2Apex8tLUqe+mNCr1+A6bCyzer3S7XRp24aqyx1pshAea3yAnoZq55USuFEfVku5Zg+JXMB/JDgOnD0pCAjCJ+2aYsP5Fy+yEPGfBRi71Ldoz5dbPn0KOjPKnJ3+0XFQh8MGUKsxmkGgU5Lxl0ozECofbYm10cXboaCXEHGGsCsDX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 23:03:17.0676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2ffc6e-4674-48ec-d3ae-08d56f482478
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2018 4:58 PM, Tom Lendacky wrote:
> The following series implements support within KVM for MSR-based features.
> The first patch creates the MSR-based feature framework used to initialize
> and retrieve the MSR-based features.  The second patch adds support that
> will allow a guest to determine if the LFENCE instruction is serializing
> on AMD processors.
> 
> This series is based on the next branch.
> 

Paolo,

Let me know if this is the direction you were thinking of for
MSR-based features.

Thanks,
Tom

> ---
> 
> Tom Lendacky (2):
>       KVM: x86: Add a framework for supporting MSR-based features
>       KVM: SVM: Add MSR feature support for serializing LFENCE
> 
> 
>  arch/x86/include/asm/kvm_host.h |    1 
>  arch/x86/kvm/svm.c              |   16 +++++
>  arch/x86/kvm/x86.c              |  114 ++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h        |    1 
>  4 files changed, 130 insertions(+), 2 deletions(-)
> 
