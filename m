Return-Path: <Thomas.Lendacky@amd.com>
X-Google-Smtp-Source: AH8x224QDj9Gz+a2/WiFPNmQAYP7b9QbQcCPTO7SbIZxXMBXj7aQBciOCZu/hpNhbTwUCAkhcXvH
ARC-Seal: i=1; a=rsa-sha256; t=1519140165; cv=none;
        d=google.com; s=arc-20160816;
        b=urcmq79ZpjShvppPdZmwYKZ/lpUbhQMlBSEGu1cc8GwZPpTmt8GV2AZMeA7H+d+WJJ
         IwhwSOoJegm60Pe1d3vDbjtD/sqjZflzN0tpGGzJ209Bw6lpLaHcAsasfkZp5IrGJQo5
         aljBgn8liOo5RcFKpUXhTq6geo8H+GUWRhxhtwugfwNxeTc6gx3XywW8VIfxEv9iu7w+
         7VzhR9U9t/FO1d12PTdzdRg8YycuvmNmqdZoUrfk+RIzvD8nHqfZWBlDp3I0smltcXG2
         Zvnt8FQQ/ZTFQCm5U4nOu8ELCZ3izn5SSaGeJpnit2lSCCltUa5GjtJYv1pCRdRWMXNp
         JGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=R9RT8s/flWK+Kp1JiofGVbkeuE/8JQDWu4Efdv2yRUc=;
        b=UrYTGxiMNkC67f1nfoMZzaPGNDi59+flzWkpdV/AQBgPodQrCZX5A+og9ifbEuH1V3
         69aGmTPvL9I+4+WFHDuL8xMGwaGM0Rn5w4EaReltlV54LpxG4NSSYzncm8AcgoQC2Dhe
         bJ7e6sXdtmR2xd0zr0QNd3sZTu6Nj8Nh9e/20f3fQJ1DMPULa87vDbCh6wfLWlpGk1yp
         wma5jUtzB+IwRI9Dd/OfzMQdj4Oeq6prhZbR89fIx3a4rkM4one1D91yJGoZSkWpORZf
         2P8rUsew02t/7irF98eN66Bdc6RYGOmq6moXlS68koP3KLIYGIP2g+jNa+ypp5vtBXe8
         on5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=44ePuWkS;
       spf=neutral (google.com: 104.47.37.77 is neither permitted nor denied by best guess record for domain of thomas.lendacky@amd.com) smtp.mailfrom=Thomas.Lendacky@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=44ePuWkS;
       spf=neutral (google.com: 104.47.37.77 is neither permitted nor denied by best guess record for domain of thomas.lendacky@amd.com) smtp.mailfrom=Thomas.Lendacky@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v3 3/6] x86/cpufeatures: Add AMD feature bits for
 Speculation Control
From: Tom Lendacky <thomas.lendacky@amd.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Greg KH <gregkh@linux-foundation.org>
Cc: arjan@linux.intel.com, tglx@linutronix.de, karahmed@amazon.de,
 x86@kernel.org, linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
 bp@alien8.de, peterz@infradead.org, pbonzini@redhat.com, ak@linux.intel.com,
 torvalds@linux-foundation.org, dave.hansen@intel.com,
 gnomes@lxorguk.ukuu.org.uk
References: <1516813025-10794-1-git-send-email-dwmw@amazon.co.uk>
 <1516813025-10794-4-git-send-email-dwmw@amazon.co.uk>
 <20180124172002.GE16646@kroah.com> <1516816633.13558.166.camel@infradead.org>
 <ea50b592-7664-ffd6-8e9d-e26a4ebb7257@amd.com>
Message-ID: <df8c19da-50ae-e608-6961-ac56939a4248@amd.com>
Date: Tue, 20 Feb 2018 09:22:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ea50b592-7664-ffd6-8e9d-e26a4ebb7257@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR0601CA0096.namprd06.prod.outlook.com
 (2603:10b6:910:88::37) To CY4PR12MB1144.namprd12.prod.outlook.com
 (2603:10b6:903:38::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de3f532f-37f9-4be0-1b4f-08d57875bc36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1144;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;3:LiQYTo0QbBKWN3zQ6XPHrBYPBSkZJcLTWH3+pnpWGrDFc9p39N/U6rB476k6k216R1EPn62H1KoaY6qYlQHnXS9x6JDNvNGylFDWwBr80b957sU285FpVZOFA3K0mQZ8DER+QH/wqtKQUDEM9wQ/U0wlA2BkLGikEqNCQOMKzKJEDV7BPSMb/2CAICo+NKoOWZxUEDKOP1mSFpaSsRevP/zJk0hr2/N0VDgR4qZYq0O6ObRRnKmAT+turOBwX9mA;25:onCJyB0J6Ug0AXoyFUbEzn8BEXkcbogtcoiR48VTxfITcm7IujV5WmJcz/wsAj4TeMO85hgRww8dBYCqJeQ4R3qxVd2XzoiauEf8LqKB/voSU/xIv2+Zm6Orm+xz0asBsZMV6uCYi8PFkDQnVp6+n1muOYqFBn4hKy10Wz0cimuqWMwQklCvf2xz2zd3kqhCXNBKbeGFQxAvaWhtF63WrJSPW2VYdcjlEH+L/xoKnjPeE844ZuQdxIdopQg4bigWK/n++DyAH7TKaePcZ3YBvDxEGlCnYpWyBIWCrKO5SWUCaQaWOBBHMf8QTfCSo+XM5QWG5sQYzb0SQwsjrx++hA==;31:MM3Wd9CKzue9IwnbIwXi14r3oY0MmOuxeouT7oZMnD48iminqLxq9OZbXnI8ZX+VmB7n12I+LLne/pTvGIUEHackMxVpyTj0Dtblp39+vsFsM6RxDCo8i41IRYUYRHZLqkQz+Aa1ZcYh6RSI40TKFX0sw/jyiFOkL1LwrTv3vektfudBLalHS+BLN3ACLk/kuhK2cCp27ljcVz4Zq6r/GJqUwbyY+JUb5lmBxPItxwc=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:oCRm/Lq+KW+Z0E/VMO9ZfngOIsQ8zqVkXPmtJzqahN0Gx+XgbOyHUPMmA5c/6uRkBOkmA1K2rb6Ks4TH9WLOQFpNaScFBHJbGt2bBn+y36iAHfqr9ZrfmGGFWoKTuN73IfEIR3a7RXD+VN8YOok+5NgduRYxRjDDz5BMEgx4kZ3fsjq64QEjAEjvgaqcmH5VjUompJ0oiSzfCtTsjnYfj8u0vYp8mb7PObiAjHyObu9xlihmpY/m57yB5CrFcl6GpiZlGeP5bzN3Z3kwx4AdQ/9Ye5UCupQmCyMXMp0+F/Ya/bioxjPONaYF0okuHh+ssKF4TPzJpShwGjVyStaEaXfNVTq1Iwe6cGjEn0Y3CtHhucf4M2ddYBSJSj74bxAz+HJhZGGYwzLZQ4lafKidQUzbphTiKfqTG07hU9EYceVJoRSlLF1r4eGLMomKd764VLQmXndERHVdTQes0Up7ffI4ihWb/qntCEXQS9kT9kwBRm8qSeOUGWKqEm2WwhlP;4:qBXHUU6FD6YYEUGLVA8koAFNoS15O4Aafnqyk656B5E+aV/9/2NcL+1cdlHIoLnyW1b0ch8gTSPHqscO4CsyN1froV+w7VC6qICiqpmJ8Lp1LclE7QvlAShKgKK0EM4kJUPYITrILyiQvZCtu3QMILOtpLOQwfp71QXDD1aeTkaPmlFFWVFixk2eRBbfw9wHLvRPCZTPZLgssqLuFvNa6vHV3DHPMl1hcZCbwMgHFWzjjXxYgCRT8v7rO2Grb3Kxhu5jZGwlZP9/fWDIimVa/yfK/ab1c+JHlEJ6Uiw4J70r9xtdGzsykgDWS1rYf008Pq8pM9C/VufgpUBPFqcSwA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB114450AF4D2A5E59274C4E8FECCF0@CY4PR12MB1144.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1144;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1144;
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(189003)(377424004)(199004)(110136005)(36756003)(31696002)(50466002)(64126003)(65806001)(105586002)(106356001)(31686004)(7736002)(305945005)(7416002)(47776003)(66066001)(65956001)(8676002)(81166006)(230700001)(81156014)(97736004)(8936002)(25786009)(3260700006)(4326008)(58126008)(72206003)(316002)(16576012)(68736007)(2486003)(23676004)(52116002)(52146003)(93886005)(478600001)(6246003)(76176011)(6666003)(2950100002)(65826007)(5660300001)(16526019)(59450400001)(77096007)(186003)(53546011)(966005)(386003)(3846002)(53936002)(2906002)(6116002)(26005)(6486002)(6306002)(229853002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1144;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQ0OzIzOjZmRVRLc0JCZFJUT0lYOUI1cXJvRnBwUURL?=
 =?utf-8?B?N0F6QTJUajlpSW5RV3FKd3lDajlGdzNrQ2M4Z0JCeE1xREprZHVnNHdHSUkw?=
 =?utf-8?B?cXp0RGdtRjFxSjhGVnpFMXlHSk1YZGtEQUpYaElHYXF6aTh0WUJhVGlRRzZq?=
 =?utf-8?B?amlGWlBFdkNLMzIvTlhOZVNkWGZKc3NhN1ptSUQ2NFRpTzdwWE1ZWGhycnVB?=
 =?utf-8?B?Um4wNTFvU0lENGJrVDlMVXhtOHRRdldOWTFoTGk5SjVwbWZ6cDRKeUIrdHU5?=
 =?utf-8?B?MHRQQm1DeU5INVdYL3NQRnFlbGU2ZVVJaS96OUtBSExwcGNmOVFjd2Y5MVVx?=
 =?utf-8?B?d1c1RkRCL25CcllDeE42NHNUMlU5ZzdnSWpwRkh1MVBGNW1ZTU53QmkvM2RD?=
 =?utf-8?B?d20xMDg4cGV6QmY1eHJlMUF2SnpUR3dsWjYxYXlRMkxMSldBVXJYZ015Q3Fl?=
 =?utf-8?B?Z3lxUldXeVRNK2txZGkzYnJkaXhUNDlUc201bFNCUEpnVEppTU0zSC81ek1R?=
 =?utf-8?B?ZkpiLzE4eXRZam11UzhhMHc0RnF4OW1PdkdaVnMxZFRVamlNVTc5RUNJSkJN?=
 =?utf-8?B?cWl6aHR6N3FTd1VnMjZNWVR4cDFhR29MSSs5cFg2Q04zOEJ0SE1sbjd6eHpW?=
 =?utf-8?B?MDRkWHNGVTlNRHhYVzVIYXhuZ2hCTmVMUEdvU3NLR2habURFaHRFZnV3SVhq?=
 =?utf-8?B?ODZrdWE3TFgzdUdmdHhKQ2ZFUjQ3R3hCS2lyd21raXZBVFRjaW51OXBEWnRU?=
 =?utf-8?B?bFJuNUFVeEZzQU0rVmZjaHVCK1E1UERnRGt0cmU3dkN5WitPUWIvRlU5bW5S?=
 =?utf-8?B?dHQ4cTJtWmFYdnZOTGpxWFg0dXdVWlN6c21LeGtLM3lIQjZBL3VNSnI4bkVD?=
 =?utf-8?B?SWVPM2pGRFBVME1tY3hoMUJzUmVaUFA1Z0gwRVlJL3JYN3hYK2QxSncvcExp?=
 =?utf-8?B?Rnd0MDRBN2ZpcG1QZXMvYjFZSFVabmtUNFhoUU5Tcmtvd2RyUDBVYjQreHk1?=
 =?utf-8?B?OUZMOUdHaFo2VmxrREYwalhuRTVUK2JUVTlpZ2x2c1dhc2dKeFRYY0Jpb00w?=
 =?utf-8?B?aEMrc3poT1FkbkkzT3VObHZIWStQdTdGUGdJVEdyTkluYXA1dGhYVEM5c3ZO?=
 =?utf-8?B?aG11b3lpeVVCY0NjUXRLSDV6SWpia25UN2pkWkw2dU9ySEtpMzBFSnNKbkJY?=
 =?utf-8?B?cklHU0o5NSsrM2g2U2ZRV05ld3liTDlGK2dSZjYzTzRhSG8vU2FtTldBMDVO?=
 =?utf-8?B?ZFB5K2xaNFhab2drOFBBQ0NOUTZydmJMYjMyWXBOSUptRk9tbHZNWlVoQXBI?=
 =?utf-8?B?VVozQVh2ckthQk9zc0hsUkh2OU91RmVMUHA0OUI0b3dFTHc0UDVkc2JCVkpE?=
 =?utf-8?B?czVQanpicDhiSnMwZ3l6ejlQL3FWL2FRdjR5QzRMTGxpVGhQWitGM0c3QmRv?=
 =?utf-8?B?QlhvMDZiVzNIUkdKMzdvKzVQSXREVmFpQStJZlFjdHhpZFhjRmM5L0wxcUlU?=
 =?utf-8?B?WFRVb2NlRjArM09BV3V2bjJTQU91Z1lIRkhPbnY1dzhWWk9FVmNmeDkrdWZJ?=
 =?utf-8?B?MWJTQ09Lc0pub1dYV0FtTDNIQ3ZCQzdHK3FtZmFUdG5LeHJTeUszbGd4SnBV?=
 =?utf-8?B?cVJMK1YvNmJxNGxyMUVCVFF2RGNHa0w4UEEyTkwxNGpuOE5sUU9sNkcwVUtN?=
 =?utf-8?B?NXRvQ0ZwaVJmbzVXVWxRZ2hsUFFNOUNDZDQ3d2NyR1pObVJlQ2tLbE5XMGk2?=
 =?utf-8?B?SUowVHNpeWd6ZWVGTW4wUFNnZE4wUHE5S3FiaEhKUm92dEtacW1vdGdSYlRM?=
 =?utf-8?B?MmZIQVliWk1xR0R6d3RIWmxMZ3RSZlJxeWNhUzdGdjFYZWYyeE96VDhDd3ZK?=
 =?utf-8?B?aUZGb0RWNitreHJIWDZKK1liOFh0clMwcTVzblF0SXN4V1dxUWJNRXJEcjls?=
 =?utf-8?B?THorTmlyMGFPRWZSeTY2ZDFaS3AzUjFkajlzSjNhd3FrenJka2Q3eldJVUJ2?=
 =?utf-8?B?SWMvRUo1aklHakFJS2QvSWZPSHRIOU9VOGc5UmpXTUVaR0hhZ3hmQ0J6dG1C?=
 =?utf-8?Q?wbNE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;6:FNuM8uebiA0rzkUoXxx6me7p139CFOuNU9pUYRvD3VJ7+hJcRNawb1w+dYxQv1cl1icGUkAfNsLeIkqhVu/fa42s58AvM9Gd/bbxrbC2jvUg9TgDmxi/XGM7zTRjCmOC9cumrkiFRsl8jIHSAInZ4VODAPWpkALnoga5H+rLStB0SsNSl2QWF9k4R7xe03FM2Rt2P05K5J7JW1BwzF1FuzC2t3W0znHpLT1f5wUs40VC51/l905nHvSJ273TNH/4P/G2kqbpC9tj6GtC/Mh6Rh3t/zDKu91mL+pN0IFyQbA/8HTAGTHEKPOKcaA0cszaHEWtYhvtORutPf2ztXjUDgdLs2dQwL37fKlt8sH45oo=;5:RR0Y7NCPzWzDhYkEhrmR1vpt73WJYfTI5ySNGCCYpUfkqNFh4OiBQutXqNermGLg83fNrUeCiT3j0EE9OsdiANQFOpYWEVLQzzd/0xa3H1J1YemjsWCyORcg2E/SCwN9Wv989auj46V6gKqrzWuBgyx4YsBgfW6Yn/Uzz4CySCU=;24:XtEwE6eQ5sK0FBPomBkFIR/x3NupwfwX1o4KPNf+pV/3e/5F82hmds4Z82GK8xtmmdTXDzOZbMD/4j3wXkjRUiMTEY8n5Q/sdtJxlT/dx9k=;7:Gb0yw1WHUnBDBeHSAuJFjGSxSvxqXWJhZFQ8ggdCuwn7nWPVq4xYHtBo83n/k9L4yrIDR/0VvzWxm2XK/K5nP8/9RqwpI8ZLEolqCnJPUI+bOLcz6rbKw00yBc7FFH0oSrHd+BJcMD21Uj4VQdD15sSeqn05dpNRsM1YCeqppV9dRIyCsMC4qvLq9/m+29GRNKhphI+MPJanMTIk/TBC6N/R4YQkB/H2wUWLV++sq5pZxCgJN0wU0uxa7nn83c03
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:r/XAXjw6yoR2+ayxpoXsucMnJaz/twt1VSkK84ddUX6Ax0/SejGNTA2kAielwT/6uu3rnw2mYY9fMX0bP/qmSN/pg651+DYIKw+3gpgh98sKWSh1kuH7JemqL5gpGSS+iYxTftd9Oql1GqPLNLKBez9D+/nkZ12H0fdxKgOfTRLsVE9/UK53zE5QZS1ohFxatANLS+qL7kqwVryVJjffjRHbA2/5GUfc91gTwtyHdnTBaSxPIcp27jf+yrE/CQNP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 15:22:19.8528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3f532f-37f9-4be0-1b4f-08d57875bc36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590493826599421101?=
X-GMAIL-MSGID: =?utf-8?q?1592933918049557160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 1/24/2018 4:52 PM, Tom Lendacky wrote:
> On 1/24/2018 11:57 AM, David Woodhouse wrote:
>> On Wed, 2018-01-24 at 18:20 +0100, Greg KH wrote:
>>> On Wed, Jan 24, 2018 at 04:57:02PM +0000, David Woodhouse wrote:
>>>>
>>>> AMD exposes the PRED_CMD/SPEC_CTRL MSRs slightly differently to Intel.
>>>> See http://lkml.kernel.org/r/2b3e25cc-286d-8bd0-aeaf-9ac4aae39de8@amd.com
>>> Oh how fun :(
>>
>> At least they *work* the same :)
>>
>> Although I still haven't seen that doc, Tom...
> 
> Working on it...

The CPUID/MSR information is published:

  https://developer.amd.com/wp-content/resources/Architecture_Guidelines_Update_Indirect_Branch_Control.pdf

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
