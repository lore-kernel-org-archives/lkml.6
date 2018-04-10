Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeDJN5O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:57:14 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:47904
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753359AbeDJN5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:57:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com;
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
To: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
 <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
 <alpine.LSU.2.21.1804101355050.8026@pobox.suse.cz>
From: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <127f954c-88c6-30cb-bf14-7ab2fad70158@virtuozzo.com>
Date: Tue, 10 Apr 2018 16:56:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1804101355050.8026@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P18901CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::26) To DB6PR0802MB2439.eurprd08.prod.outlook.com
 (2603:10a6:4:a0::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0802MB2439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2439;3:NV6UnP4yhZoFmjZU6KOzxNjM3mDAa1MMpURB4bhn9qXE3BgNPFAUPqNFEMTA+akbTG7/qDlIg7rhebSgh3dzPzpzMHyWGQsLTIYfEvz+Q1yrp4VXPXiLtuP1Y8uZfim8nSpcHifBgtTUPyeKbp0LwMN3ke4SHO0mJpm8llLq0MqYDp9LBsgmK/0Tp+rf64SNitEpCzDjcrmWMww1FuORo5gHSrKh6EzLdfb82A+Eq/ZwiPlJHPTZ9uyvBvbzxcCm;25:vasYzAnfp+zX4CWVprlN3oPyAlRwqeFGipM7/fa00BmknadydDSIAO6Sgl8ccO7gtYuuoituqferqFJz3+k/gm6HlN1Zn+dms8HccZoecLWEJlRIQpghejHVp/Imjr1w5RZYWpP2iDl2K5Ph28hZy26YQKFdzVh05bSXpLT9tgF0HzZHuqJuoMd0KT4oat/BJ4AenNgBfzM2Zz4NS3HCEGLpA2qeCI66cCgS43pAHzxigJGNx6+xdBDHOxtCNlK9yomcoRyH973PZxCm09tD+/JciKN8x3D05Fxh3iN53hRhCSP7zMKygeVJ3q4KVDhkzHyr4NWWQpfD8d9Tii4Ntw==;31:Y/Q8H93UnYbNcSFBHPBolBoB/zW4kg6ZlFOWtHFyuRNpSOEgDShwbN164xFnjxg156r6T19uNV8oarixGeiV/ysvxv1HJ0xb/sgsEQDkvFMZ7/Lv96E8jVrTgN7yXWrDMx6OMqM89Ccn4rnLKJQ8j/0kDsSZe9GkwFPFz199llJqXk4ZzEwwegNGq54Nt8r/Sw77P2axsNOZvscPpl6BansHXM2EO5C4kMZu9kXBqtM=
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2439:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2439;20:wU0aU5DOA9C1JfvTT5i4Q3yYyRPUGSDqyd1st5Csghh11RNk2mfpdxnUqICVj8XAxpo9bXag3OzoPpz46DnTgi6lCtUnTUxYXxOSgMN0GY1Q8cPeJrCBfJLOlBBrDQgqSKBSWD4Fw6Q3dv1SzV9sMCgwBpZw/9nhO/uhnj9bsVA9Um0YBTHnpke2Z0Fp56wZOBRqEU7qxjQgL+sgdSaGwmwD+HrA2Sh7ijJpGBlbAQTqE8QnNCTXFAq13JbYCjDz+hqybFSfNIDebjwvyxtvPpXiIfHL1TNPD3BQ40IgCmUzwFsLLGc4RRfcT/5XORF1fyqHCIHw69b4D2rXOfjB0dnKGIw5DgJnh+0018L/NZ1GpphUkPfxRzhVHbnk3I9T90fY+d8I4UaBubTV1Q/yZm8mw+l7gKKIVdrt+gbBFwSqtpMg+3yg7e3lCa9RTe5DalivnloCC/eXicgMQV+ZIniKLlW3/1ft7QxK+4HMs9TDjvBSG1lN3nsGR0eNsTox;4:gTqIjnQObqrcjYulxLFkdS4TAald8cv7C3m+1CPCGCIeJP5tPcC2oZ17S0cG21Ha7G5m10Hnx6jXdQxn5wGh7/RE/+GzISeAmtvR51BJiED11Qdq9+ExJ4AHlk7Hcp/X/lKi9GXcYuraWm+sqfbVScjbxs7k/7a7NgkX6faXWvYjsZzVQOisbZco5I62QQ/OpuOyubifdmtuavDbbFzSZpdTSUq1TBTaMhzhnnTAnb1cGlXV5ULVIbaR4/zFIdbunlGuwJIMMpPd+Ri7MLtq7RVuaKsBEpQvnZgd68wKyYxJYDT5ZucXL60g5Kdp3GRp
X-Microsoft-Antispam-PRVS: <DB6PR0802MB243924DB425F71B783017832D9BE0@DB6PR0802MB2439.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR0802MB2439;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0802MB2439;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39850400004)(396003)(39380400002)(366004)(54094003)(52314003)(189003)(199004)(305945005)(11346002)(65806001)(97736004)(64126003)(66066001)(8676002)(65956001)(65826007)(186003)(16526019)(86362001)(6116002)(36756003)(478600001)(3846002)(58126008)(446003)(53936002)(110136005)(93886005)(6246003)(8936002)(81156014)(81166006)(2906002)(4326008)(54906003)(76176011)(230700001)(31686004)(52146003)(2486003)(16576012)(6666003)(67846002)(23676004)(105586002)(956004)(229853002)(486006)(52116002)(7736002)(26005)(25786009)(68736007)(386003)(2616005)(31696002)(106356001)(476003)(50466002)(5660300001)(47776003)(59450400001)(6486002)(53546011)(316002)(55236004)(77096007)(551934003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0802MB2439;H:[172.16.45.27];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDJNQjI0Mzk7MjM6bDdOQ3QzdVVyS01lekM2U3ZQeEpoQlZY?=
 =?utf-8?B?bEdEUTVFRkxldEFobXZmSHEzMzI4bGs3T2ViYkVvODFBVEhNUmY0WnVadC9a?=
 =?utf-8?B?a3ZIS2N1d1hnck1RSHRtMXhJMllqYjBUQXhBdUxCTzVMVHZpelJ5SlNCOWlR?=
 =?utf-8?B?U1pRNEw0bkRGSGFHcWJCd1ZveFk4bE51RGZQL3A2TXlNTnZvUjFrWFI5UjQ0?=
 =?utf-8?B?Y0JkY0pyTEE4Y0R3WmJxVWVld2lwRXdNZkFIMXR0VS9iMDd4WVlPTlJyaEhH?=
 =?utf-8?B?ZDhlVkF3WERWMEQ3Q0ZVak9ycWNMQTQ1dk82N2h6TEsyYVhDYUdlWVVFWkZw?=
 =?utf-8?B?clVuYVpxcFZJR0MySkhnT0xlUWhnZnVSQVRxcDZ1VWZxbm1tK0RCQ09lRjV2?=
 =?utf-8?B?SWdzK0t4TTNQeStvQnNmSXJidlZ5Y2Z5Zk1aV1V5U1NIMytUVzZtTkg5SGYz?=
 =?utf-8?B?NTBCaVdkNjg0a0ZOWVJXcTdLb0RXdXhoeU95MStYcjY0UGNMYzB3SWp3VzZG?=
 =?utf-8?B?RXZHa3BhdVEzVVpnVDh1WnphZExrd2JLVEdGL2c2cTc2ZVpURmlzVVhZZmdw?=
 =?utf-8?B?L3lWbnRka2ZDVWNsTzNidUVpYkphWFNaYkRaRFdDMjdSYStmSUZKQjRwSzN0?=
 =?utf-8?B?VlpRdHAwRFZLWTZxT1Q5Ymk0NW1NOUhOWFY1MVlTeXJubm1vRDByVFdWa1la?=
 =?utf-8?B?TnJmbFFxSk1BejVYeGloWjRnMnF5eG9oZmNkQmUvV2FvRFNPcFZueE1oTnhq?=
 =?utf-8?B?OVF6NVozbVRMK2lLQ0tiMHNoNnpITTltTHUzc1ErREI1dml5cmpJZmt4NEsy?=
 =?utf-8?B?TjF1Q25pbVM1Y09odGI4VE9VWjVLUWlWRHkzcHRaL0lnbTNHUTNLNHJ1TFVh?=
 =?utf-8?B?VWpUSThpVm1LRm40MXVEZ3hyb09EKy9TUkpRU216QzBtdXFsOGF6RWlKZnVs?=
 =?utf-8?B?eFhZNGR1bE54OFdHWFgra0hwMGNJcmh6U2NWUjFVazJzR1c2cFFBS25mTXkv?=
 =?utf-8?B?OVVqNG1WRldzU2swd1dBSjc4WXU3ZjFzUk5lWDhURkw3cnd5QkRjUlQrQVJJ?=
 =?utf-8?B?dlo2eFh4aUZKYjdyQ2N1OUNGa3V6WGcvZzZFakZSQkNRNUdHeTdEdWN6TUFa?=
 =?utf-8?B?d1VNNitmM0hXY0YydTZYRlg4MEdnbEUraVFiVTJtNVZWR29Sb25RemZTdXBv?=
 =?utf-8?B?azUreDMxNHU5THRmVGxxeUhrVlROQndTMjJDWDR3OS90TFRyTUVJUy9SbDdu?=
 =?utf-8?B?Wm5vaUtzVTlnL0YrVUR4Rk16ckQraWIrSG13TTcwUGl5UEtIOVNyd0YyS0Y5?=
 =?utf-8?B?M242Y0JacGNoZXgvQ0tOMEptL1k5TkluTjQ1NFZYMnV5UmE5VzZDWUJjeWRw?=
 =?utf-8?B?UkRlb2dlVjFqMEpldHEwVnZMYmJBZVFRbHpZZ041amVzaklUUDhaNTFEMmJx?=
 =?utf-8?B?cm5TZnI2U1duNHBsdXI5bmM3M1Vjc0g4MWlNay9NVTIyN08xR2o3anptcnNi?=
 =?utf-8?B?Y2tleFhZbHVTREJBMkZLdlROQlZNMGxES2xDQzBuUTZsZkI4aUJLWThNMDVK?=
 =?utf-8?B?cFV1NFFYa1o4aXYxd3JKY0c4MHEvd01TWlVFR2RMY2ZteHdEQSt2cjIwMkdH?=
 =?utf-8?B?dUowcWRwejZSZFc5NVZzVmVYbWhkUFpHVEdlMFhYZFp6d0EwcU1abTV1OUpj?=
 =?utf-8?B?SEVocnRld01TWEdYS3JOWXUySnlORHBJQmNNdlhqOXM4ajhPSUpZTEpORmpQ?=
 =?utf-8?B?bzlPUCs0UmJMODRRNHJsVGlLeFhHN09SZVJWYk9wN0Q5MkxSbUN5cXFWZVlY?=
 =?utf-8?B?c2F6RjhzbEFnVjZ2R0JjbGJhVXMrRWVNcXdWUTFEZHljSkFxUERiODQwN0E3?=
 =?utf-8?B?Wjg2NXZWNE5VQVZqeXhqTitjRmUyT3JCSEw3L0JXMlV0bzRNWmJUaGw0OEdX?=
 =?utf-8?B?QkJjNDlpZTJqNEwzZldmZEU0SUhsenRkOE0vWVo4NkpaZnBxTk9IVzlOdHpq?=
 =?utf-8?B?dzZyLzhDUUNIYk83VStNdkIvb3RVS3NLZm9lcWJ5UDhxbFpac0xMVGd4Skpt?=
 =?utf-8?B?eUtJSWtwc2FidmlnMUI2NmFRcnZIWjc0TzBYeUNGNnc1OHNJd0ZaNHRXVzFm?=
 =?utf-8?Q?Tb/mKF0su+//68jILt2JoRF06zQY8KMSFt4QPQZH3gMCw/?=
X-Microsoft-Antispam-Message-Info: tfW1bX+CWtW+XWQHVXNtq+pMXMFqR7AXgP82VGw8g85vKUw4dpDljcD8/dgMy0uZU2lsKVOe9Q9BJWC6JxJGOqTzPwfp8qDuy4wxtOk7SZzuJkm8n2dgJhdUc9+XGZHacct0vHweKCc8etsq0VqfdCU/K+p0DYyGWIl7CE0tNNTID8xSGv21DlLyQ/6A5E68
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2439;6:tIOpRKqE+jHBEFFnWyeyvX6RhB5l+wsNNCIAK6fNhquZmIootaCYqsN8AnLF1d2uuRlr53QtdNkdfVtvh/ZqTzg7KMBGD3ZP6C+CQLZ273ePu1pjGp67ENUfRgGoh6MA5L+kcHIdlugEizHSOqKyviXR0ejmxVZ/DrPCvK8fVXVi2m+aj8HpffrTN+AMbAsQgdVGa7zBsQSoi6kv8l9NdZoA0kcxBh/dyjgESLhCVYvM+oHgD2VVb8zo9zbt3hsBPQqtCwFZ3j9VQCz/BunNYeFe5M+OQYgpAQ6XUw4q0Z7I6W3qiZ6Cr6/JI7VN+aFgcM7LFdImfHQc41injtD5srGQJOgx+AP3czqt0FJjMe7rHVo6SCBj6zYklNlqG//AkoNGWs4k8rxo3XrJxob+gjDbsCwVg70UxVKg8ub7DswVncTXED3LT6PJ+tlInnCyN/pLVcL7UkVunhAwx7ABPQ==;5:MQQS1SnX7wDpw4mmR9TOxJz6ulcJlwEhJxmqd6rp8jIry4FEtE7QENkNMI8Vbs8bmaYwXIDG+UG++CQ3XkqoSiLV9fmaISuPlUmAJxBivAvui2lx+i6ffvxeuWTKIkVWGfupraZ4eIiXJPOGXRLKxtSSNWBtGZgu9kGbe9dVjOA=;24:H+5LKSOzn/vMDKw/i+PbQqa29dzgpOJW+sasnsi22JNMUQR3Bhwc1BPWT69Inj2/mOqTiJ1qQTUgDlmCSO3aJio8/70OR62Y9O2X4sSV8ls=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2439;7:Yhu7hRGg+EaQ0Iay4wSqyvBYAMVRswwexaBS5F01E6bihDRuUneGyQXYoHV+2dUl2Wc7AHYuS8t6ymXUWde9A4vv/b4O7uAJjpTdY2z6y0jIZFpV0whBXxkEoR1BPo5/x+H2I0cnaUl1x3lu6eCLN6bOHE952OE0wXg3E5RwsZax67HpnP9lsZBcNpmwV6BmVxT9ID8Ito3AUPhhP+xDjWg+AksLTpVSOQRXkvsaVkt91VejM174QRgHo4nZIyK/;20:J7DMd8x7qdBFTPpsCD+YweHprEJ8m0e/1sSKLJZ/vevXOddCNJ1yZfJ/bl8TBSZT3CGiDqEzGxkUAq8ZKSkJWfq2QTT+Dk7dF1LkNKoj/FEhfBe7XDmsEtpyq0Ga1sO7KIL2hhLxto/NHWnTA8Y2i1m/yV6fpUyJPblKVKhg15g=
X-MS-Office365-Filtering-Correlation-Id: 37639eb3-624d-47bd-9c36-08d59eeaf2eb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 13:57:06.9262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37639eb3-624d-47bd-9c36-08d59eeaf2eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2439
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.04.2018 16:21, Miroslav Benes wrote:
> 
>>>>> I think you're missing my point.  This isn't about your patch set, per
>>>>> se.  It's really about our existing code.  Today, our patch stack
>>>>> doesn't follow real stack semantics, because patches in the middle might
>>>>> be disabled.  I see that as a problem.
>>>
>>> No, please read it again.  I wasn't talking about replaced patches.
>>
>> I was confused by wording "in the middle". It suggested that there
>> might had been enabled patches on the top and the bottom of the stack
>> and some disabled patches in between at the same time (or vice versa).
>> This was not true.
>>
>> Do I understand it correctly that you do not like that the patches
>> on the stack might be in two states (disabled/enabled). This might
>> be translated that you do not like the state when the patch is
>> registered and disabled.
>>
>> I wonder if the problem is in the "stack" abstraction. Would it help
>> if we call it "sorted list" or whatever more suitable?
>>
>> Another possibility would be to get rid of the enable/disable states.
>> I mean that the patch will be automatically enabled during
>> registration and removed during unregistration. Or we could rename
>> the operation do add/remove or anything else. In fact, this is how
>> it worked in kGraft.
> 
> I've already wondered couple of times why we had separate enable/disable.
> If there is someone who knows, remind me, please. I wouldn't be against a
> simplification here.
> 
> On the other hand, it is kind of nice to keep the registration and
> enablement separate. It is more flexible if someone needs it.
> 
> Anyway, we should solve it together with the stacking. It is tightly
> connected.
>   
>> AFAIK, the enable/disabled state made more sense for immediate
>> patches that could not be unloaded. We still need to keep the patches
>> when the transaction is forced. The question is if we need to keep
>> the sysfs entries for loaded but unused patches.
>>
>>
>>>>> If 'replace' were the only mode, then we wouldn't even need a patch
>>>>> stack because it wouldn't really matter much whether the previous patch
>>>>> is enabled or disabled.  I think this is in agreement with the point
>>>>> you're making.
>>>>>
>>>>> But we still support non-replace patches.  My feeling is that we should
>>>>> either do a true stack, or no stack at all.  The in-between thing is
>>>>> going to be confusing, not only for us, but for patch authors and end
>>>>> users.
>>>>
>>>> I see it like two different modes. We either have a stack of patches
>>>> that depend on each other.
>>>
>>> But if they depend on each other, they can use 'replace' and a stack
>>> isn't needed.
>>
>> Yes but see below.
>>
>>
>>> And If they *don't* depend on each other, then the stack is overly
>>> restrictive, for no good reason.
>>>
>>> Either way, why do we still need a stack?
>>
>> Good question. I suggest to agree on some terms first:
>>
>>     + Independent patches make unrelated changes. Any new function
>>       must not rely on changes done by any other patch.
>>
>>     + Dependent patches mean that a later patch depend on changes
>>       done by an earlier patch. For example, a new function might
>>       use function added by an earlier patch.
>>
>>     + Each cumulative patch include all necessary changes. I would say
>>       that it is self-containing and independent. Except that they should
>>       be able to continue using changes made by earlier patches (shadow
>>       variables, callbacks).
>>
>>
>> Then we could say:
>>
>>     + The stack helps to enforce dependencies between dependent
>>       patches. But there is needed also some external solution
>>       that forces loading the patches in the right order.
>>
>>     + The "replace" feature is useful for cumulative patches.
>>       It allows to remove existing changes and remove unused stuff.
>>       But cumulative patches might be done even _without_ the atomic
>>       replace.
>>
>>     + Cumulative patches _with_ "replace" flag might be in theory
>>       installed in random order because they handle not-longer patched
>>       functions. Well, some incompatibility might be caused by shadow
>>       variables and callbacks. Therefore it still might make sense
>>       to install them in the right order.
>>
>>       Cumulative patches _without_ "replace" flag must be installed
>>       in the right order because they do not handle not-longer patched
>>       functions.
>>
>>       Anyway, for cumulative patches is important the external
>>       ordering (loading modules) and not the stack.
>>
>>
>> Back to your question:
>>
>> The stack is needed for dependent non-cumulative patches.
>>
>> The cumulative patches with "replace" flag seems the be
>> the most safe and most flexible solution. The question is
>> if we want to force all users to use this mode.
>>
>>
>>>> Or we have replace patches that are
>>>> standalone and we allow a smooth transfer from one to another one.
>>>>
>>>> Anyway, for us, it is much more important the removal of replaced
>>>> patches. We could probably live without the possibility to replace
>>>> disabled patches.
>>>
>>> I think replacing disabled patches is ok, *if* we get rid of the
>>> illusion of a stack.  The current stack isn't really a stack, it's just
>>> awkward.
>>
>> I personally do not have problems with it. As I said, I see this as
>> two different modes how the life patches are distributed. The stack
>> is needed for dependent patches. The cumulative patches with
>> "replace" flag are self-contained and independent. They might
>> replace anything.
> 
> I agree here. Practically we use only cumulative replacement patches at
> SUSE. So with that in mind I don't care about the stacking much. But, it
> may make sense for someone else. Evgenii mentioned they used it for
> hotfixes. Therefore I'm reluctant to remove it completely.

Well, it was convenient in some cases to provide a hot fix for a given 
bug on top of our official cumulative patch. So far, such fixes were 
only used on a few of the customers' machines (where they were needed 
ASAP). It just made it easier to see where is the common set of fixes 
and where is the customer-specific addition.

I think, we can use cumulative patches in such cases too without much 
additional effort. For example, we can encode the distinction (base set 
of fixes + addition) in the module name or somewhere else.

So, I think, it is fine for us, if stacking support is removed. 
Especially if that makes the implementation of livepatch less complex 
and more reliable.

>   
>> Well, it would make sense to reduce the amount of possible
>> situations and use cases. The question is what is acceptable
>> to others and if it needs to be done as part of this patch set.
> 
> Yes. Input from actual users would be tremendously useful here.
> 
> Miroslav
> .
> 
