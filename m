Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeCTMtG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:49:06 -0400
Received: from mail-he1eur01on0131.outbound.protection.outlook.com ([104.47.0.131]:59568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753084AbeCTMtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:49:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com;
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
From: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <2ac2f797-6f72-ded6-bf0c-6b3c7b50a5f7@virtuozzo.com>
Date: Tue, 20 Mar 2018 15:48:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::47)
 To AM5PR0802MB2434.eurprd08.prod.outlook.com (2603:10a6:203:9f::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e79ac9fd-7f30-425f-e8e9-08d58e60f44a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0802MB2434;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2434;3:4TX3PRTRoAzt9ehfCdTc7Snc2aMZi4+Turg+I8iGiYcEcTIM1UT1ZVmXZFahZXFnDhtGzNoX3E1OaK/n8e3AhKRMEmNxWmkb+2JYOzdG157m3R5HtzzgxpAt62aIsjypx32UdQFtH6td7+D/Vq4vZE3fIdfgTVi4Um+QUdRAxwRcmEkPLEVjU3gxHtQTLQtDEGSYljpiWLZwG+y/mUaS6iUMyEiaGY+r4FnHs104amh9EvQZL/Uu/4nCNLSXGShL;25:RGEkVr30HslHTiALZivRPzv4A8yuwkNX4W9zg8M0b5vRbbXLCSrW3K8KEy22t7A+h97M9V1r1V0QmFfE4e0+gs+N57cIdM89FbEuT1Dr68PT0Kyzne9vz6uM2y79tBozyGmU2cOCZkoTbkFSUe4mWIrRZUjuEAc3sphmQod9jnlKX/Qx4/sXYpnRBCPW69L9WfK7RneNgIeM4ZXpHrJT+FrBH7V5P+esbwG0Hl5aN9p04R6pdQZsrZpt93q1b9h+V16aItWri+SMaeTqaEdQNJahFxmg+c2d4wtEu9SOiKpK5yWKOA19ipxxbYTZjsNBQ4jF0QTAlSS5VZjdf/udBQ==;31:mS1wA5N6VJd+YKHS1kBg2RH7/AeQ1zc+vmEQsW3yyVXNTMgJwhe+bht5gm1Nsrzuck6jQVn9T19r5L24OFaGeamSqyKHqLYGIVJtpBlnaq+b+kvHhHFQbPRrHkQkGB72Bicm95/0/p9Lnc5UKPvwYcZ91L9MIMBNoPEWGrKahAfyBMjzQ2gOwg2F1rTp8VvHT+priMvjmiNYH1J/OfoRgreTqujKV7Pa+2iHGRFo8vY=
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2434:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2434;20:0XbbZ85267h/gdASFnSR+FJtpqvwfTxKNzQ7FNq4yLq2/UvD0wWhIYUZM+2ax8Sp+yFk0KCwiWyoI4pY7IPZLrVkt5U2IqyymoG8YVUrsDNqUym0h68Z+l3l6iKHyt6BXa4C2by8GbeomXwS8f2TuEp4TupbZsGTVvXL35QA7ONkZtR+Svju4pGKw2ya3VeiMJuNtSsTHYR16/jXoq/HkvelvKEp5LgvJttEla/WnZk8lHWeVLLKX3LrNls4sbzRkTJOD5GN4BYh7yk0x6g8S+Mdtaqlk3PKSBI5cjGdcvMY6CG8fLLeI5jZrsGsSPCqY9YL2yo+9cduOkoplzejCtkuhBUtj6dc+HNYT7/pHtPqA7eNNC6QlRDoy1VtmT7QytqQj/Bui/SxCD5+7VVgbDCRj1b5aCAEsQzF//wFjnAJdIulx91/XFoZaipnOc3ROg2U/H26IuvwkazmE80WKm9mYwBXWvpi+zCMRu3FjMlyPIEEw3S5W4NOinQDU1sk;4:5/KZmbGsH2IT5ngaJceAItAFUONm5gGk3JgE9yiEsePs0bVJb+afh0W1lee27hqgt2JuvzK1yJrF3p+9qjgBj0Qu8qj7NOlk0i/CupYjy18Y6l1OfnMN4D8tgo+PCKnk5oydB7d8wncuk+TszCBx0yZ12teU/Uo2fF/VSFzSSFRI8xDL7/GpFAnIVo+ydyoyISdhPR139ynoOJFpLhmSfgoNnUAt1BirZeLwHmpx6yqZkk5ze/3pAqbxFtZerCpSicE5ZD0tygw8FHTuWYCjooLH+Sheij4nLzmSqPt7U/0Oab8qyRAA/+k8WkYeMWb3
X-Microsoft-Antispam-PRVS: <AM5PR0802MB243480FCDF3E94F657CA1AD5D9AB0@AM5PR0802MB2434.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0802MB2434;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0802MB2434;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39850400004)(39380400002)(376002)(52314003)(199004)(189003)(377424004)(8676002)(58126008)(2906002)(305945005)(16576012)(54906003)(6916009)(2950100002)(6666003)(8936002)(3846002)(68736007)(55236004)(6116002)(105586002)(106356001)(36756003)(81156014)(77096007)(7736002)(81166006)(229853002)(316002)(31686004)(86362001)(97736004)(65826007)(26005)(93886005)(64126003)(25786009)(230700001)(67846002)(4326008)(47776003)(6486002)(386003)(478600001)(59450400001)(53936002)(31696002)(65806001)(52146003)(23676004)(65956001)(66066001)(6246003)(52116002)(2486003)(561944003)(50466002)(16526019)(186003)(53546011)(76176011)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0802MB2434;H:[172.16.45.27];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDJNQjI0MzQ7MjM6Y09IT2E2T1h0UWJwdXJEWWYraGIzNzVs?=
 =?utf-8?B?djVzT1FydjE2YldmcHlmdzJsWFZjSG9HbS8zU2R0MEVDeTBRTGZkTjBKZ0hx?=
 =?utf-8?B?T1N4ZUVNSTRJelhMdWorOW5scGRaZDE4S201WjlnUlpLbis2VFU3YlM4OWtl?=
 =?utf-8?B?M21QK3BIWk9ndlN3N1BONnBZVlZNMjh0dy9zZWZGSmc2d3g4dkhpWmZYVU1E?=
 =?utf-8?B?SGpxSXdFMlRHbHhvRkJUdEVIVWEzVU5YbWVodmJENG1HeTRYZnFBbERHMmpW?=
 =?utf-8?B?VHdseDBFQXIrNndtb2U0aFh3SHRWeEg3T0d2elVkeDR0ZFJTSFdmckxCZ0JS?=
 =?utf-8?B?OVVSM05Scm9FcFAzeUxzdjlhUTdJU1I3SlNoWEx0MndITGhUUWZvSy8xTytG?=
 =?utf-8?B?cittRy9CdExZK0VtV09ZRmozYVJNSGJlT045Ty9QRjFhNS9oWG9mdU13MGJy?=
 =?utf-8?B?QnNxdnJQc2I5U1luYVFyK2tNSGVlbXI2YkZKSmZtSkxUQWRwNTlLa210QmNU?=
 =?utf-8?B?MFRzSlFTQlZtcTFObmFLZFZmdzJYUmpLOGNqejV4RU9qbFphUXg4dHcyaHow?=
 =?utf-8?B?WDdhUklqcDc4Z2F3b2FpdFFEUWxtRWxMRkhkMmdUcVU4cWd5UnZlOXZQMUs1?=
 =?utf-8?B?QnhtRDhzcDM5Q1JBOGlha0RRWmZPNlI1OEttZzdlaHJPUm53M3A0VDc2anVa?=
 =?utf-8?B?djhkN0oxcVc5Y0JhVXQ2KzVGN2k1dGdQWE80ODRZdWhYeURzMnZOZWJoWVd2?=
 =?utf-8?B?THNlU2hjeVBucUhPR1JZakZFOEVHaER6KzlWMEVoVXcrOWRFb1BLMzlkLzB2?=
 =?utf-8?B?MVovYnowMDN6anpaSEJDK3NUeHZpZmdTYWRncUJ3S1FOMDZSTXdWN1hMTDda?=
 =?utf-8?B?Z0kvTkZSTUZUYmV3SkdIb2RqOHFuWitvbzdxWmFhZEZjMnNxZEFWZWZmbFdi?=
 =?utf-8?B?TnlzTnNHQmthRlV3M29BdUtpMk45TlVEMkxZNzRZa3JsUnZPbG5yZUk1anE2?=
 =?utf-8?B?Sm5iZTZsbEszbkFZOGFHY3EwMFVBWHJLc1MwL3IzNlpSMzNwQnFLYWxqbFJ0?=
 =?utf-8?B?R0ZGaFJBRGdQQXBmNXd4UWVzNmVFUkpZL3hRSSswVmRsWmY0aW5DR3ZkTzVC?=
 =?utf-8?B?TzhiV3ZsN0lSQ3FTMkhwbFJSRjdCMWFFT2RQcmE0R3lXckhWRnNlMG1Mcm9u?=
 =?utf-8?B?eENyMkdSSlRzTE5mMHBXVUROTjBjdjBWVUlvcFk3RmQxUXB6WXN3N2xxN2dt?=
 =?utf-8?B?aStZa3NaOFBhZEE1bmNkckJVdHpqbmFNc0pCTXIvWGFPUXYxSVozdWp5ekoy?=
 =?utf-8?B?MXUvVzZ6MHFrUTEvWUQzbEQvMjljU0lQTmRhRmFZTlJOQmlDVVNtaVU3Sm8y?=
 =?utf-8?B?VHV6Umd3OW55WmFTcDdHR1J0TjFiSWJCZHJQRG4zeWdRNmljK1V1OTIzcHQr?=
 =?utf-8?B?TFpPTnVCbG9pWE4vZHhZak9kUFRWQ3ZzNXp0bER4YUxUTm9ZcmFCaU1KVmFp?=
 =?utf-8?B?TXUyVWV2ZWdBQ21rVHhlYXkxODRmWlllYmJtT3ZJRjB5aTlNM2ZXSTh0eklU?=
 =?utf-8?B?QXYwQ0Fub3FUblFBbmVZMm1TbGpHNk1HRkdoL3loVm9vWUxheTlmd0ZmOHZD?=
 =?utf-8?B?anFKekpGU291T3k5UjNvaWxsNTFxdUE5eEFlOXVwZnowU0Z0S2hucUlubUFa?=
 =?utf-8?B?VUFGMU9TVzIzaTBHTDJtVmJrVGdUdzdlVnAzcnBYTzFEK2NHS0QrMWVra0JQ?=
 =?utf-8?B?bGQyWkQ2WmxvMVlSYUQzMXBBWGZPaGRmWVBGVXk3OUxSWmVuTVpGa2xvOFZu?=
 =?utf-8?B?WTN6a2hpOWJlTWRwRTJONmZxMkRseUREZUFCdlRWQ0ZnN2RZeFgyL0pvOWJ3?=
 =?utf-8?B?S2JiWXRNVWtLNDNoMkVJU09sTys5ZVNVbDZhS3R6NUNGL01jTU81YTFib3Rr?=
 =?utf-8?B?SEFldXk3SHJJcnlkdks1WHIvZk1GbXdEUkZ2bVoxU0tYSzdsbXQycGh1eXF6?=
 =?utf-8?B?WWo2VUtTNE1oM0YxZy95WXUxRStNRktycFBSZGorbzZjM0FlYm03S3lqeUI2?=
 =?utf-8?Q?tKc1b1a4oP3oMvDAsw6uA6x7Prv?=
X-Microsoft-Antispam-Message-Info: oBVkdKXZa3vJE/V6N8dqr6gtSnZ8tpU5I/bVyjN3QaPLOBJ+shcYAXMncwQfiBqeQGcNtujSDeECfzOkcMb8uHgdNRI7Y5nrQSAwCk0vA0iiZ3owjU6wwo99R/84yCKm/IkePEA6h6Nt8l0t8N/RvLKVrOjK6SeauHdoiS6wADzAuXxFk7WIZIRWFdx8IRgs
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2434;6:CJbBbG6rpvnNdlFL8pyiHHLzqsd2bT1cYSNjUTN3EkcchG+Mthp/DtrjS8lLGirlOKycI1J5ROU0tEbqX8TWHDSLWi7lnrWZ2l0TAuoa2gdGU0iGLMpj+jV6VPGNIeVkhWx9GE0PPB2NjHVsnNJGB6KcKWw9beqpVEeIcHnvmYC9CCOLXh/iiZL0IHl3TAboT88PveQ5ij5j0qVJh6AjIAm4uSDCTXDcBh+cyJuPlc+fo7YBJ1NS/EPP2VT8Bw9LIngIpoHfffm/pdSIqDn+oZB8Ui7zf1aNzT5YA+LrSiFq25xngTTRivLvUlc17BQsGleqs/kqi766mUZ7/UzT+Pd4GalMC8guAt6jbXBhH0Q=;5:XYlwtb5Cm95QTN1HFnKiB4KsOVRkw12Rt+yPIbhlJm5rQAeO/iZI3/oJRyJi1jUkODGUnewukbV2BvbKEYGC0s5bz4yG7PFwpoCGmzWlXCeebriMgLlbQCJ9XsgvdrVBeSK74LYRJXBssHb0F5SI9dZqbYYwscbFi5DaiMnJ0y4=;24:/MahCiS+qE0XgxmQAYRMI6BbLQV1Oxr2maGIauQUcATkuHlI2TDDPWUs5CbprAipodfFppM+qWz5xdBRH3/nolRrSrYnpUmUHzQu+SicE9g=;7:NeFdzSNxkbTEY1CT5HK0B5aJ/rJH1mDeL0RaGO0NDblk8oXC0a8satKGH6GQDd+6+pfk7Kc0PUwXtoxMHRPhAfHPBY9VEa2oekwe7vJB2hiJa4mfPXEd5jVkm5bqGY/KLwRs1bsmTh//WyDjWQXqDQnkjlam5czIKxktmC+ETVvhptjQPcixUfWkj74l0YHAHngeh04qOrPatBwgnaIqoU1WswXXvp3Iuid9Wto2UhL/yWQ2iLUe8kv9iuFB01v+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2434;20:jZsdBATIs1h93uid30+XcgvjBqAHLf8HCK6DvV1TxINLGp3sXCl3Z5R6CUwPA1JvgTqG6f6Na5Q85bWnWrEDviIYh/smcWqkDT/3OyJueG9xgaK3hAIAnrhgnfoh49adNoS6QYrWhVHnE5sAQXObBrzREQCWrDyYXwBSZ/oyMBI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 12:49:00.2316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79ac9fd-7f30-425f-e8e9-08d58e60f44a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2434
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2018 15:25, Petr Mladek wrote:
> On Mon 2018-03-19 16:43:24, Josh Poimboeuf wrote:
>> On Mon, Mar 19, 2018 at 04:02:07PM +0100, Petr Mladek wrote:
>>>> Can someone remind me why we're permanently disabling replaced patches?
>>>> I seem to remember being involved in that decision, but at least with
>>>> this latest version of the patches, it seems like it would be simpler to
>>>> just let 'replace' patches be rolled back to the previous state when
>>>> they're unpatched.  Then we don't need two lists of patches, the nops
>>>> can become more permanent, the replaced patches remain "enabled" but
>>>> inert, and the unpatching behavior is less surprising to the user, more
>>>> like a normal rollback.
>>>
>>> Yes, keeping the patches might make some things easier. But it might
>>> also bring some problems and it would make the feature less useful.
>>> The following arguments come to my mind:
>>>
>>> 1. The feature should help to keep the system in a consistent and
>>>     well defined state. It should not depend on what patches were
>>>     installed before.
>>
>> But the nops already accomplish that.  If they didn't, then this patch
>> set has a major problem.
> 
> The nops are enough to keep the functionality but they might harm
> the performance.
> 
> Livepatching is about preventing bugs without reboot. I could simply
> imagine that ftrace on a hot patch might cause performance
> problems on some workloads. And I would like to have a way out in
> this case.
> 
> Anyway, I am reworking the patchset so that it implements your
> approach first. The possibility to remove NOPs and replaced
> livepatches is done via a followup patch. This might help
> to discuss if the changes are worth it or not.
> 
> 
>>> 2. The feature should allow to unpatch some functions while keeping
>>>     the others patched.
>>>
>>>     The ftrace handler might cause some unwanted slowdown or other
>>>     problems. The performance might get restored only when we remove
>>>     the NOPs when they are not longer necessary.
>>
>> I'd say simplicity and maintainability of the code is more important
>> than an (imagined) performance issue.  The NOPs should be pretty fast
>> anyway.
>>
>> Not to mention that my proposal would make the behavior less surprising
>> and more user friendly (reverting a 'replace' patch restores it to its
>> previous state).
> 
> If the "disable" way works as expected, see below.
> 
> Also it is less surprising only if people understand the stack of
> patches. If they are familiar only with replace patches then it is
> normal for them that the patches get replaced. It is then like
> a package version update.
> 
> 
>>> 3. The handling of callbacks is already problematic. We run only
>>>     the ones from the last patch to make things easier.
>>>
>>>     We would need to come with something more complicated if we
>>>     want to support rollback to "random" patches on the stack.
>>>     And support for random patches is fundamental at least
>>>     from my point of view.
>>
>> Can you elaborate on what you mean by random patches and why it would
>> require something more complicated from the callbacks?
> 
> Let's say that we will use atomic replace for cumulative
> patches. Then every new patch knows what earlier patches did.
> It just did not know which of them was already installed. Therefore
> it needs to detect what callbacks were already called. The callbacks
> usually create or change something. So there should be something to check.
> Therefore the way forward should be rather straightforward.
> 
> The way back is more problematic. The callbacks in the new cumulative
> patch would need to store information about the previous state and
> be able to restore it when the patch gets disabled. It might more
> or less double the callbacks code and testing scenarios.
> 
> 
>>>> Along those lines, I'd also propose that we constrain our existing patch
>>>> stacking even further.  Right now we allow a new patch to be registered
>>>> on top of a disabled patch, though we don't allow the new patch to be
>>>> enabled until the previous patch gets enabled.  I'd propose we no longer
>>>> allow that condition.  We should instead enforce that all existing
>>>> patches are *enabled* before allowing a new patch to be registered on
>>>> top.  That way the patch stacking is even more sane, and there are less
>>>> "unusual" conditions to worry about.  We have enough of those already.
>>>> Each additional bit of flexibility has a maintenance cost, and this one
>>>> isn't worth it IMO.
>>>
>>> Again, this might make some things easier but it might also bring
>>> problems.
>>>
>>> For example, we would need to solve the situation when the last
>>> patch is disabled and cannot be removed because the transition
>>> was forced. This might be more common after removing the immediate
>>> feature.
>>
>> I would stop worrying about forced patches so much :-)
> 
> I have already seen blocked transition several times. It is true that
> it was with kGraft. But we just do not have enough real life experience
> with the upstream livepatch code.
> 
> 
>> Forced patches already come with a disclaimer, and we can't bend over
>> backwards for them.  In such a rare case, the admin can just re-enable
>> the forced patch before loading the 'replace' patch.
> 
> 
>>> Also it might be less user friendly.
>>
>> I don't know, does anybody really care about this case (patching on top
>> of a disabled patch)?  It just adds to the crazy matrix of possible
>> scenarios we have to keep in our heads, which means more bugs, for very
>> little (hypothetical) gain.
> 
> It depends if the we remove the replaced patches or not. If they are
> removed then replacing disabled patches is rather trivial from both
> coding and understanding side.
> 
> I am going to add this as a separate patch as well. Let's discuss
> it with the code.
> 
> 
>>> White the atomic replace could make things easier for both developers
>>> and users.
>>
>> I agree that atomic replace is a useful feature and I'm not arguing
>> against it, so maybe I missed your point?
> 
> Your suggestion allows easier code but it reduces the advantages of
> the atomic replace feature. We would achieve almost the same results
> with a normal livepatch where the functions behave like in
> the original code.
> 
> Also removing replaced patches can be seen as a clean up after
> each patch. It might be more code but the target system might be
> easier to debug. Also we do not need to mind about various
> disable scenarios.

+1

In our case (ReadyKernel), we mostly use cumulative patches with 
occasional "normal" patches as hot fixes and such.

After the new cumulative patch has been loaded and enabled, all the 
previously loaded patches are unloaded. Yes, it is seen as a cleanup.

So, most of the time, a single binary patch is loaded and active. It 
helps debugging if issues show up and it also makes it easier to explain 
to the customers which fixes are in effect on their machines.

Just my 2 cents.

> 
> Best Regards,
> Petr
> .
> 

Regards,
Evgenii
