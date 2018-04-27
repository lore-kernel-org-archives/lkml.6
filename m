Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935395AbeD0OPA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:15:00 -0400
Received: from mail-cys01nam02on0072.outbound.protection.outlook.com ([104.47.37.72]:56048
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935291AbeD0OOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:14:53 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [RFC PATCH 1/3] of: base: Introduce of_alias_check_id() to check
 alias IDs
To: Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Alexander Graf <agraf@suse.de>, <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
 <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
 <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com>
 <ba081812-f532-5ebd-b052-cdeb1f02bff1@xilinx.com>
 <CAL_Jsq+3WnGNM0ip_v75s8f5-Wq_9ht19-T-MHyhKjzcU6jtdg@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <147e8ae7-3682-2350-394a-828c096f5ee3@xilinx.com>
Date: Fri, 27 Apr 2018 16:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+3WnGNM0ip_v75s8f5-Wq_9ht19-T-MHyhKjzcU6jtdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(43544003)(189003)(199004)(106002)(8936002)(4326008)(11346002)(446003)(2616005)(476003)(77096007)(26005)(316002)(336012)(426003)(93886005)(65826007)(186003)(54906003)(58126008)(110136005)(76176011)(478600001)(53546011)(2906002)(2486003)(230700001)(86362001)(31696002)(23676004)(59450400001)(486006)(44832011)(6666003)(229853002)(36756003)(50466002)(106466001)(5660300001)(126002)(39060400002)(81166006)(8676002)(81156014)(36386004)(6246003)(65956001)(31686004)(64126003)(47776003)(356003)(65806001)(63266004)(305945005)(9786002)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB0678;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:ae8vnW86EL8KavIjFOm6QrdGLHy5p4ViMMZlle/m1aNZV2UUc5nMxGvuJ7v6jjqtL0nmSSDN8rs+cIks8FxltE2HPxQukeQ4ZiTuDsRWcZudjVw9YIDfrJ1LncB2ktPt
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0201MB0678;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0678;3:m0x3CTnVl19MkTx78fvuBnGRUfKXQ/ctF34FEuynxIQYbFUlhdEU9JsBvsYCXj/W6jod4ncacrZk/xpYdmZ3Xjc+VOQJPq+FCFEDnHCV2k1qsnw/JCqn8wdHwT4kiVxQdXeF00c6CFqpUbhkeQyzbmtboJl+NSgZ0raKjamwUs+6hhzMLnJRUu13Fiu/w+27gugFw/sY+0JiUY6AIo+HvjZqalhPuxHcdCRWUpUSmmn3cq/PAddWbsl2MSRkKf7rmn8CoTXXRF+QbH7CObnRK/VX58y+hvhN3OQLACo2bQOcA12oo2Rva9dH+7i13GB3OBCcohwz7CEeluJ5kXdSzNClbAeS6E4/jWYowaIY49A=;25:1wlFMzgQqjpIv8s42ybmkf9Pi6OUPSwSXM4Wynw6Hl0vUthwdFllBpOhOB7OWpJdDBbxevzaj23nl316Hbole8Zx+jmgaweQpVXAhKxGtq9qzwAwyPf2NnJPlUabTRhBJgGA0YKy4zhyHNckxRATO5+gcsIHzlvSlkC2UhiX9akGHIUgGVx6V5/+aLQWtDGDeuunyGHknzTm6sPP+5uwXVv5NJYzwGklfEdfz+eA5FASw7ptXxhEWn+nURplpvE9XMnT1aBUxeLoiQjVufE5e7fXHXpCMkmflyDb9hg8jSaeHUGsSCgVKRG61IhscpbyD5CdPUezIA5eV8+D/90Heg==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB0678:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0678;31:Hs2/ZJFgJhYbqvycoSp5kdWhzONEjH4iTd70uN/XpoXZCWsdjhEDKLHMEMJ5CI0pkuIP4kUkxpeGAgjQcE0MFAboe7l4TWUePXMBExnYfx+q2doznBuZukX3j2+mFWEib3rZfFnqj1IxWje7LLDV2mKtNU+pkGZVG7Er4Oq83J2TS9IuCky3mD8JHNPqVCer7nlFwrgavE3aRqLWuUOZA2pjQCmxLOiN4mIeFX0JFVE=;20:98L60rxOlh1sRAmVVVM6Vi2RA73N2KrNU5RvZxq9FSduQmr6hi5C73poGqnZhXikIA28KZHYoGAno0WlldLBucGvQTIYS4fo+0EvvzojOqzsAllwuviI4tqhxYJJ0HvWGED0Xd3SDCq7DCamkIMjHKu/db6XKBFNth9Wh7G2DjcMVq/1GXgYf2J1BmAK1kk7I7wdg31teCdYBjAHWsMUVsC9iO1kLz46JrKrEinVz+PtftFdX/ivQN2vYIiVezFC2b7pEwgQYa4NOoK4sEBcWF/xVXqFbOWKiU7EqV5jGc0T5UZ0Ctee4xU1ufrEpgDvMy54Pjew1RTTZV32CU0nS9ggZgihT+F16ljoQ/4nK+ERgwiGlqm5/VuNtz0555G8XVfBi9op/zWPfmlDRH/MoTTlQl4wf/ScG1uMDasNdLJALr88/bV5QTVeY4eWFxuxFT9HeVy7hQZsULUt+WNG9Iytqsur0ma6zXP/XZbzP+qPWRF5tDm19aTA5z1xE68q
X-Microsoft-Antispam-PRVS: <BY2PR0201MB06788432F0B6C6FC5E4ABB98E28D0@BY2PR0201MB0678.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR0201MB0678;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB0678;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0678;4:V3xkzg6SUB6TveaX0BldxWrR612se+VEJWaJ36Yp0LjU5eLkDKWQEXXlxnQTaCN8CO9nSCtYx55je9wgOSD4/wZuoFveVXMSpPLA+7pcTMIJofq1WHgwbDtHT7dFIzi5ElNn1KHqcgb+hU15t5Gkqr81MNDV2GZcHAbZnMAwMP3sSpn17fe27iRO5YcWuQvBrcvv2XyX0Ldo1KxhhcddqhrQ+S9i1X4rDMyucAF/KhfJdHC7mZxeomQtAOw6U3PkNwwYylbVnDi21zbhRQXvS7gDQiCxHRv99h2ziZoUTV5qOkHUtSYYveqAjj2oGVTu
X-Forefront-PRVS: 0655F9F006
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyMDFNQjA2Nzg7MjM6VWRVUlZvV0RsVGc2U2JJNU5aNk5xam9q?=
 =?utf-8?B?bWFtQVpOU0trM3l1TDB0MEFycTJGNGhrektnWG1YTzg3elgxeGJRbUNnTk5O?=
 =?utf-8?B?ajdVcnUxaGt6Y1E4M08zRTlId2w1L0d4VzYrcXpnUy9VV0Jrd1phRWtndjVV?=
 =?utf-8?B?cHh0dUgyYnFEWHJzbXJVemJ5ajJlUWhKRlJzUTh0NWhXdFlpcnFRMmtZWVVV?=
 =?utf-8?B?U0FtRzF1akhBeklKYjlhODNTcDdKdE81WFNPZjQzUFJYL3BQWnRRRmc4d0lm?=
 =?utf-8?B?cCtzZndnSHd1NVY0bDd5WWZXWDFseUVBRmowZitQcXg0bkwzZU1PU3hoakVV?=
 =?utf-8?B?bi8zN1g4MWFQNVhEYVhVRFBMcVJtaHlMbUFqOHNNcWF2R2VlZWFjQU1sNDQ5?=
 =?utf-8?B?UTBqNTNtdUNOWWoxQjBzUzA5M3NmenNGeGlTUTJLbzdXL2d2bWt6Rzk0Y1Za?=
 =?utf-8?B?cmovYzVtRmpFa0IrKzNuT2tmb2FUNHozRWwxVTBoNnl5T0U5OUpiT3l1cDNC?=
 =?utf-8?B?YStRdXVkc1hkVlJueE5XL2xhQmRyaVdsaDRGS2ZxSEh0US9UZndjV1F0ZjFv?=
 =?utf-8?B?WkpMa2hjK2V0YzZ5NmgyeW42QmZLWGJJZVFzZnhmTHl1YitzdkJobkhZc3Nr?=
 =?utf-8?B?ZlV2U0h3RFZ5WERxMHNZMnNJcVlNbWFsNXRxbWcxejl5SkJMRjlVMVlKMmgw?=
 =?utf-8?B?d1NuSFN5cGc5NjNpb2V0a3UxRGpRVkRPdUF3RlVzWkc1NFlTdUt3ZTh5ZG96?=
 =?utf-8?B?L05LZ2laSGFuMzJ5TmhBVzVZWGR3QnNLYlJDYU1RdytmYUlSRG92ZEJTR0lx?=
 =?utf-8?B?UDRPbjZFUytyZDFVUllmdHVicHE5VElST2dpaU9xUzgxcTQ2SjBFL2lDUEtZ?=
 =?utf-8?B?aXZwRXRIUkNMTW00MXBUOTFOQXArTzk4MkpveHhwUUlKWm5Lbm96NTc1eTFH?=
 =?utf-8?B?QThscUJ3NDFoY1VaTERGSGZOekl4cGVCY3ozMitxR1l1SUkrZ0FwSURYYTBa?=
 =?utf-8?B?YjJjaUFqT21zTnB5aEZpZzR2dW1nWHY5SjU3bWpPQWlocGRyZHgvWGNINnFY?=
 =?utf-8?B?eXgxNVU1TFJZYTYwUThkM2RSN3oyNXV1ODh4QUgrS0dsUDlEaXF5N0JKRDFl?=
 =?utf-8?B?Ukk1Q0dzUFA0NEFQNE5uWTFFSXI2eW8rRGRWMTQyRlMwU1VQeHRKdFBYWVM1?=
 =?utf-8?B?MTZtNWhFbzJkSm96NU1jYU9yVjI4VlAyMUp1dmtPQnpnejFNZ1VkMHNLS01r?=
 =?utf-8?B?VGlZYStoWTNmenNYZlRmVy9QWUNvb2tyanNWa3FOMjJsNEFYL1pJWjkrZkFR?=
 =?utf-8?B?N215dDJ2MjNURU9ITGxOVk9VTG5TYlo1cGxRTjd4SURZcjd4bHcwaGs3OUlE?=
 =?utf-8?B?WU5ZMUZzTjl3QWZHM0IrYU1MVkZLWE9LSDhENzRzOHNHSGJEYkIxUFFPNVV1?=
 =?utf-8?B?alJ4K1YwYXlKVUV5dEVFeFhoS1hJQ0JLdW9jOFU2NkRTZ2JyUk1PaVJQN0VX?=
 =?utf-8?B?dEMzL1dVMUlMc1ZvV1BtWGVLWUhKbmJpSWNydTVhajZ6RDJaZG9uV0dWWFNG?=
 =?utf-8?B?ejgwM2ZOdmJIdHpXU3JQZWpubDJ6LzBlZzZ5S2psbm0yZ1FKZWNXdkcvVERE?=
 =?utf-8?B?Sm5jZ3ZGUURHZm9kdFVxSmNjTUV2Z1RsTjlRMnJVVS90b1JoWEhLOW10SWFa?=
 =?utf-8?B?QVFaTjFkU003SjVoTFB6Rk1Zb1ZDRFQwUW5NQzYvUjRleE1FU3duWjUvTG9r?=
 =?utf-8?B?QUhueUtCYVVSbldvdUxDSU0xaGhvRU5Vc3Bwc3NyTXNGd043MFEybUwzZW5i?=
 =?utf-8?B?Z3E5V2dQa3YzdVdFZWV5OFV4TXlSVFhBdHpQNnpaemt6aTExQmk3MDFPY0tx?=
 =?utf-8?B?cWVZeWRXZ2ppc295d0gzMkFvRFo3aWVsUzBsZGovbXhlTWRNQUREZXVCUlFI?=
 =?utf-8?B?WTV1SHNGNDd4dnJNL2hjQWpMVFpWYmdBdER0UWUyRTY2N2krMGNkVkdYejIx?=
 =?utf-8?Q?onAqR7/K?=
X-Microsoft-Antispam-Message-Info: hKFvID4sbRzdaQjEB9ImDXyM5gg423COT+XdqiawP+2c/6wLfTCe+ewXSlnPxA3gieoO5tHx44ehzHOKXlQIsCRO8ly2GVFmDIuWgvttC8cT+e79/2hqRQBDj0nohGA7mbpHdrkIsMKOvL6Dea0I2rmPtdUQwra3Q2E1cXtqeea6xxYzeHPkJ2mtJLQvgHf3
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0678;6:iLwEmbxELLKEshOfqNOE3uLWHUK0ePV+aYTzGe0ezLTjArIuXM6xEn2U801n8uRWGwjbioHMRJHQa5hR/g0y5oN0Py1WnL3zfKMgEMrgSH+9diCJwudAWKU9duaiJP5q1mjBys+swg5nWhrG5YMVAaSvAjeCmgq22bstYcf0TdElXjToqwiplrWC8QSzc2/4lOICU5sTdrydHMVnyLKo998w74J7kdn6zikrogz2NrH9idZncI5Ko5WANnBfgzhGGZAk1U0Le/ZpnjQ2SQE6YAEJRGJcuX5eWyptTLLKgzXhJJd1ieKEphUwZBPz42Dc55+KQ/2Gpt1uwbmZoj8F87a6y2Zon1rwsjSsrc8pwDv+e1sf4Xp9QKWfBcrn/qc/JE811g0WPCVpivVgwtzfplujG9YZK3cz1Mdt2ihGlXPweWG+o0ClRQjtfPv9sT1RkcmOQMDk2DAt9XufP9JS6w==;5:Gg50iF3f7UK0jdI6ayhZBbADHfIvhUWGRML6Z75PmKqJRJYlf//wyWgi/8RombPVBva5CpYOiGvblpjq63/052gr0Ic6fswe1QowYIgRl9zL0oQkFmXepUlk6DsDA9xaCfIm6nSCTmmIQzUUbL2Gq/09OnIkkC3YHrEbCGv0Leg=;24:TxrkqPsIdVeXXCSVxte7W7DjQrtUPAsmlARHQB0dSUuBF18Hi94U2+dkyVmBI0ccAYhIBmZFWifJSBoDnuEJ0G/fBerRYtFBfaUzDxjGqlA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0678;7:+o+lXXVSCF716mW5aq/+490mHmaKHr8rMyOO+QtcKvm2oLfgW8kjmYdQhqCKN24teQ+o3UfIyQzvrQEGSWNXVQCYQwhzmhevmoaD2faVx/44BoCyNyKKBufB03W4tyo+P7kuhw0zT4ZYpkarVB8wKBGJg9Iyxs5QenUJOIG8nNcK9ggHmg2SzKJ8buBQqCW8b1OGAmkFRfJh0lexPO7XwKHaoaZeXo3sgGhrfJXZWXQKXd7aZ9nnzHr+bW9HwuVK
X-MS-Office365-Filtering-Correlation-Id: 2d901044-a7e2-45ea-3439-08d5ac493d09
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 14:14:49.6271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d901044-a7e2-45ea-3439-08d5ac493d09
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB0678
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.4.2018 15:02, Rob Herring wrote:
> On Fri, Apr 27, 2018 at 1:10 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 27.4.2018 04:39, Rob Herring wrote:
>>> On Thu, Apr 26, 2018 at 9:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>> The function travers the lookup table to check if the request alias
>>>> id is compatible with the device driver match structure.
>>>> This function will be used by serial drivers to check if requested alias
>>>> is allocated or free to use.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>  drivers/of/base.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/of.h |  2 ++
>>>>  2 files changed, 51 insertions(+)
>>>>
>>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>>> index 848f549164cd..382de01acc72 100644
>>>> --- a/drivers/of/base.c
>>>> +++ b/drivers/of/base.c
>>>> @@ -1892,6 +1892,55 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>>>
>>>> +/**
>>>> + * of_alias_check_id - Check alias id for the give compatibility
>>>> + * @matches:   Array of of device match structures to search in
>>>> + * @stem:      Alias stem of the given device_node
>>>> + * @id:                Alias ID for checking
>>>> + *
>>>> + * The function travers the lookup table to check if the request alias id
>>>> + * is compatible with the device driver match structure
>>>> + *
>>>> + * Return true if ID is allocated, return false if not
>>>> + */
>>>> +bool of_alias_check_id(const struct of_device_id *matches, const char *stem,
>>>> +                      int id)
>>>
>>> Wouldn't it be simpler to just return a bitmap of all allocated ids
>>> that match rather than trying to build that up 1 bit at a time?
>>
>> Is alias list stable or can dt overlay change it?
> 
> Stable. If you use an id and then an overlay adds that id as an alias,
> what should the kernel do? The only choice is ignore the suggestion.

I didn't play with that for a while but on fpga case you have for
example serial0/serial1 fixed to hard IPs/PS part and then you add 20
uartlites or 16550 IPs to PL via overlays and you want to make sure
proper order for user application.
It means it is not rewriting current but adding new one exactly how you
should do that when fixed and fpga parts are together.


> 
>> What should be the expected flow? Find out maximum number of aliases of
>> the same kind and allocate bitmap and return it with length.
> 
> I think we can assume <32 so just return a bitmap in a unsigned long
> or u32. Use that to initialize a bitmap in the driver. For un-aliased
> devices, find the first unset bit, use that id and set the bit.

Ok if this is in driver field can be allocated in the driver and passed
also maximum len. It should be better then expecting maximum of 32
devices which ends with max serial31 alias.

Or at least expect u64 with max serial63.


>> Anyway if you look at that patches I sent then I call in the driver
>> of_alias_get_highest_id("serial") which doesn't take care if alias match
>> with actual driver. It means having information about max alias ID which
>> match actual driver that would be helpful but I am not quite sure what
>> should be the flow.
> 
> I'm a bit confused as to why you use of_alias_get_highest_id and
> of_alias_check_id. of_alias_get_highest_id is really intended if  you
> want to start dynamic allocations above all the alias ids.

I need to get maximum number of ports for passing it to
uart_register_driver which is called only once.
And using of_alias_get_highest_id() return me reasonable number for all
listed serial ports.
It is not correct because some IPs don't need to be listed in that list
but it is reasonable expectation for this RFC.
Even alias bitfield won't help with getting correct number.


The best will be to get number of devices which match that driver
because they don't need to be listed in aliases list.

You get 20 of devices and will allocate space for 20. If there is alias
below 20 you will use numbers. If there is alias >= 20 it will be
ignored in probe and number will be assigned based on empty position.

But this is also no covering overlay cases where others devices can be
added at run time.


> I guess the need to match devices is based on each serial driver
> having it's own major and /dev name. IMO, we should get rid of those
> and every serial driver use ttySn (with the exception of things like
> USB serial). Then you'd just need to find all serial aliases. But you
> can support both with this function. Just return a bitmap of all
> aliases if match is NULL.

This will break a lot of things which are stable today.


>> Any link to similar function would be good to understand how the flow is
>> supposed to work.
> 
> I don't think there's a good model. The pl011 code looks broken to me.

yes, it is broken.

> The warning about devices with and without aliases should be fixed.

The same solution which

> That is perfectly valid and should be supported. You should really
> only need an alias for your console.

Having aliases is quite good in case of multiple the same uarts where if
you have more then 2 it is hard to find out which one is the one
connected to certain devices.
With uartlite or ns16550 and PL where you can have unlimited number of
devices this is really must to be able to work with this system.

Thanks,
Michal
