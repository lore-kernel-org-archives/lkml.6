Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759459AbeD0WR2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 18:17:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57168 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753569AbeD0WRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 18:17:24 -0400
Subject: arch/x86/net/bpf_jit_comp conflicts. was: [tip:x86/cleanups] x86/bpf:
 Clean up non-standard comments, to make the code more readable
To: Daniel Borkmann <daniel@iogearbox.net>, <peterz@infradead.org>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <bp@alien8.de>, <hpa@zytor.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <linux-tip-commits@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <tip-5f26c50143f58f256535bee8d93a105f36d4d2da@git.kernel.org>
 <44202670-ed43-366b-caf2-f72863ee7c6a@iogearbox.net>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <7741d4cc-2d1d-9831-e0ce-38afdd41f0a1@fb.com>
Date: Fri, 27 Apr 2018 15:16:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <44202670-ed43-366b-caf2-f72863ee7c6a@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:cdfc]
X-ClientProxiedBy: CY4PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:910:14::27) To BYAPR15MB2503.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2503;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;3:sVuBbUStYCJJqb9a8NKOY9JhH/0DZDQlLVHlA4oiVl/h7OWFUbFfYNd02SNBInZTRZHY/l6OpdERsB18UYBlAeR6Vot2UiyRHsVNSK41MVrzpqWEjz71iG8Qv3TIcooiJFX7w3RV39XLtqJhPUwNRFh6O1jO1mMf3fXG6/T5Ga3An7ZN7U2XQIx0cZj6ZD4jGsmnqN5StBYUmXbJIsg11MoP1626sZiLCK1evVcdbXs4m7eiaxSw4ZxrhViXr5O/;25:QMEIZ2MqINMUpyE+66xZAnEsfNC5ylXXbdWqDnc+3h8nS7WIAwpaGC0HJ38Td+FqdlJ99eB8VVLkygVnu6xVWQ/j6zIHefoHqMBceJmcmumd3+X+8ACuupdJx7venGZ1MT42IZZ3cDgnhhFxfs4brxetFZmnEr3Cu82Kwsl0eSmPTFBQXfW3rSrl7KMzQgjwUd7rj4VA6jA3Yz9U0REj19mEKGOInWo9okpNNVJcVDmwBmLFrD4AkG5kAPMg9FgjlfS5qRkVmPyolV4VnS1YLpXgSOU8B0Ng1mP6SI4OlOz8Xi5bzfqWBh71gw+YdF0JOQWJiBI/blC6LyMThXyBZg==;31:nrVTFe89C/t69CJUtZOdqYAPedjP6Zc0fnwETp3eI8SfzQMN3oCGJNSIJgz37yLyvK/rhUqXIuOhc1RAs82sUAsojFktVW/2LFRJ+72mu6i0o6STrV+iQ1oXoZ1mE6lxoDhv+n9MrLNEcb+fw177ZCiR428o3gqtJBSyy+8WR18G2tFDQ4SUR53DIbnsKvsTeKB6Bx/rzNYP1TOlLWQOm6ViTbukmCtQHOFKIwaGVDY=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2503:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;20:I/Pfc9lAsOrdV2YgoNjVZQldlZZ9FAX/Ru0aMNL3iVSBbLZ0p72eW3WvLiG64MGnAVShKa33qruHiYI0aHWCjm1Bi7lk3xgN0TTJBX7myGC/lL2mtum3+EC9/l51vHYTGEtbEDJ/Dr1Uf39SXb3FYfNSRI76EElqY9PZd9kVgP71+ERxmHx7cDVUG9eLDRlpVSLk/xermhrtC81j7nSSSIj5df4TNCYfQDTBZ5oCB/wCEvGA6F4Oe9mfeGjGC0r5vXvax4FG2aygXkdFNx8Z0Ez4yelHNvky/7pX+vwIvr3Mc0Xa+4gKt5rpjrFYS9SFOkQKuXJBWGS5H2zwlE5xz4SqPHCfRt54T8OKSPUj9cSisAEz/F3mSXxOYiQRXblKcEY0KQnKrtCjhlpAhzEQ9VCFjfKumwzRFLWytQG6TVNX7quiNrjIX4J5a6a79PdctAJf9pKWYCg1t7srNt33sdeemFXfkJQ2BPQfs0NKu+e4YmFyqnMV/zlATzqrY8U6;4:l5M3GfHtML1yY0sQ/hfzyPhIeJ3QXcX87wMvA9bZcPk+ggwPwDS/u/9+kvlEuRM3yvRRYp51jpKzjL/LsUofo8YL/sJsHuLazyaajW7KbzhCTRd43OLAuzHyliVnLEgNn/nyt4S0lw9DA6hWPNHDAjD1VbRS8sbSeZnjfvGyEXG021xFJF+uDZeZv6iBgGmcRb0HQlwx31/u3W6PMOu+E0SG9qQZTOV8vqsiTAJ1HLpCoL+HZ7bcRk+kr59mDOtaUu+myQlMKdVAcGd0LjOZHbBB7Ry8/PyXbt5+kMKIPSXMpvyLN8wnVim+cdzVKvN3
X-Microsoft-Antispam-PRVS: <BYAPR15MB250395EBBA221EE710BD83A6D78D0@BYAPR15MB2503.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231241)(11241501184)(944501410)(52105095)(3002001)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR15MB2503;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2503;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(51914003)(199004)(189003)(6306002)(53936002)(106356001)(7736002)(45080400002)(966005)(1706002)(6666003)(68736007)(478600001)(36756003)(386003)(316002)(25786009)(46003)(305945005)(6116002)(105586002)(53546011)(23676004)(486006)(97736004)(230700001)(7416002)(476003)(446003)(52116002)(11346002)(65826007)(59450400001)(6486002)(31686004)(5660300001)(31696002)(58126008)(65956001)(65806001)(2906002)(2486003)(2616005)(52146003)(16526019)(52396003)(8936002)(186003)(81166006)(67846002)(50466002)(47776003)(86362001)(8676002)(64126003)(76176011)(81156014)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2503;H:[IPv6:2620:10d:c081:1133::1084];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTAzOzIzOk52QWZDaU5TTFNPQ1hodlN1M3o1alBXRmwz?=
 =?utf-8?B?MHovcGtOdTJGRjJkaUZrMFl6S1pZK0dEU2tScWU5eVhIOWlUblF4MWFlYmNC?=
 =?utf-8?B?cytvZDBPSDBYZFBHMStKcDhjSzVMekc5QTFsRlBIVWwrMFMzMkh2QlJ1QTY0?=
 =?utf-8?B?Y0dMYjJaRWFkckRvYlpiK2ZzK2JaQS9QcGR2dTg0RmY0N0FRS1NMSnFxNFZJ?=
 =?utf-8?B?VmcwalBoTklRWTBzQ2lNOVB2ZlMzTzEzOGo5dlVmcllrNUFOYW4ybUFmN01t?=
 =?utf-8?B?eGxPa0NBY0JBV1JGeG0vek1Yb0cyOFNRdXNGNE9FcEMvbllJeXZvSVFWMGRx?=
 =?utf-8?B?ZTZkRUh3M3dBUUphWkNFVjZ6aHh0NldNcnkxeDdnRjNwS21BUEtaWTNMa2N4?=
 =?utf-8?B?YWNRQTZ5M1pCc2NhTW1teG5za3Zzd2FhZVM0RnMyc3NLZzY1UFVmU2RqeXBN?=
 =?utf-8?B?SzUxNmVrRDFiajNzb2VEa3NYU3dCcHJUTEYwbldhMlBGTzBia0pGdXNPTUhX?=
 =?utf-8?B?VkF6OE15RzhFaEdJQ29IK1orV3VHSWg2c293aGd4bkkwckppQ0ViWjJibzYw?=
 =?utf-8?B?V3JmV095ZXBOMFBkbHhwSG5OV3FKV2dnSXVmdjROTkpOd0VaeE83L2JjN3lp?=
 =?utf-8?B?NitUUW53Ymp6NWNwSUtwSWFlbVpDYTJ1aXVjVVRMMjA2YnVUVHdRTXVOZ2dj?=
 =?utf-8?B?bllybUZMZnJ3SVpYZ1hhVHJXZkR3TzJjM3BZMlVxTjR3eVNpdGRETGZteDhq?=
 =?utf-8?B?S21pK3lwRzhMWVJiTE8vUkNTTVp0K3pZN28zdGVBTEVwWkZ6dDNrVEtTZlJ0?=
 =?utf-8?B?Y1dkOGJTdTNwUk4vNWdFNFBBYTFaZ1hTdDUvZFd2alZhd01PWlVyZVJ0K0xj?=
 =?utf-8?B?aGhpbmRVVUtLbWwzL2wxeUNaTm9EUmF4M3QrM0NMYmRCNXByaDJKaXdwSnZ2?=
 =?utf-8?B?alN0aGg0WnB6UTB0MVJ1dm4zdEt2VkF6VUkrMDkvalZpbGJCWlB0OVJZSHhW?=
 =?utf-8?B?cVhMNnVlT3dTcFpkbzh2bG04TTB6TUhta3IyY01wZ0hKbzErbHprWllVTW9F?=
 =?utf-8?B?dzZYK0RYTWJsUUlobktUc3JFa2Fya0RPeWRZSVpMdm81UmpxMU9HUXdVdGRS?=
 =?utf-8?B?ODBtYWRaNkhTU3JZT1pZQVNwVUEyeGFlRGx2OURFL2pTWFUzMEhOZmtoWVhW?=
 =?utf-8?B?cUFlMTRKT1B5UmNpdGhZdzh5MVBzWWR0UGl2eGV6ZU8rUDl5VE1YL0d5c3BL?=
 =?utf-8?B?NlZ1NHcvQ0pSbU91emtWeWVld1ZkQncxVmdvQW5LdFF1cE5PNmR1b1ZEeEVN?=
 =?utf-8?B?YkYxUzJmRWZhbDZ0bC93QzQ4SmRHZjl2OW1LUy9XN25KS3JVRzNJWmg5ZGFC?=
 =?utf-8?B?cDZkaXFZQW5FUEM5QzgzSEd2eWpsYUdKUk10Y2tyNEg1ZDlXVkNlZzhxMW9V?=
 =?utf-8?B?WUNLOWpoT2pNZE9WTE5vUVNOTGxDc1YxVW5HbmxGdWVHcS9US2lJblRBSmJL?=
 =?utf-8?B?YXZaUHVwMnZDb2VXTE12WHB4NDBJb1VVOVZ2cmFZN2EyWEo2ZEV2Z1M0Q0dm?=
 =?utf-8?B?cW5pZnlVS3kycUVnWlYrWFJmWWVNcVdmTG44UVJESHlzMHMwM1JmbXU0dGk1?=
 =?utf-8?B?cUtMWWNPTmpNaEpKVWZ6cEMxTGwxQWNSbEROZ1FWemIzdzRQMGNCZ1FrUTl4?=
 =?utf-8?B?SjgxbXdraXQxMDhjc3c3VE5tRGdzZFlZTmVPa0ZrYkZHMEd6RFdXeGttbEYw?=
 =?utf-8?B?RHowNnYvbkRMNTlDZ1NwUHMra0J0VExEUzFMRkc5elBFSkNTRzlzVTgxWDR1?=
 =?utf-8?B?aUhDUXg4dHRobFlQZXhqVWEyMU5abm5YRExyZk0wQWtOVXFjRStnais4eFhy?=
 =?utf-8?B?K1VONE9wMWlvc1ZqeVI3T0dQMmtqWGV5YVNyRnV1amIvUE04SFpEUTJDOXAy?=
 =?utf-8?B?UnlJYlBocmtUOXpyV2JHVUZqT20xaFBoTUdxalB2VElDcDBBbUJzVnljLzRS?=
 =?utf-8?Q?FJzLtD?=
X-Microsoft-Antispam-Message-Info: dC7reyOOVvG5kzdqQEpCuYqDE1Eyhks6xHbX3zePoLBWuxp6IWgBp2hP+S35NmEzUDV58YUEjs5MDLhVNtW/qeZTs7zivB0w3ssfL5R5W1GBMTCiWQmgmswE02Zy06xEy+X5k2SA0h8olghfGGS1i3vMam20IRlXl70KfpsC7z5juk0dchqVDep+pFrHqV1X
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;6:GOlJsQZbLlvKr3KLoEz3pWAASP5UELtD8N4H82eCMvR5rm0cQCkL59bnnZte0zWmD6De42747KVLXO2HAM2muH9+SQsCwnorw4uVrUgiOOFuRVVs9Uprhl3Yy09RswcyUyDSF476kxINFwWCsD0vvpEcjBMhw9ZmiL5fQIih1NC7Hu9+oivf607Xm6nKQJBrbDKsuoRVkuP6hgUPg96T1bGcT7V0P3xh6BgR0NRSKyMDNEryVA5a0l3mHoeOPBe1PO8Xgi9Mx3U8a6Z3kcOd9utv9JW3lXB80y1IPePNuTB/36niUNrTGmM89GYsC/03OANMuMlLl6YKG7D4gVUXDte6FAUM1T9s7Ht+V5dvUutwlHg+aHltYgJDFKD50VGSBCc9cvZ3gs/JrzuwgFgXRLzIUhWFecBXlr43qIjyVu8m+RNLoKw/RK0OuKOgim+MKH2UwbMelGv6puZG8dA/4w==;5:R+otSjigf4jr/heM2S9BKJ2uSjzuYhoDYE4lrzzfI1FFJb0Iw2FYRSRINLEmwxYXZUWibJxryQ7G9/jAd7qGIxIt/1vMNwouM9Tp6BovEzsM26HtshgbWKaIlA+fZDznT9DIFnnv9sgZ8N6JxT38ixy7CplEjdmJo4CXTzvofhE=;24:oyH0sO/aco7wpsytcVE0rM7tyNh8GBa8A/BToGeFY2jVk86YIm6prne22/1Njy23V6GyF2t3J9XAgXzEPIUJvnqVvwf2gNz1qCyavZdFRK0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;7:Idyqe1TeqR/0NKsapajtw5pMK2oA+XTk72+Og5O/Jf1U4CDldW3hkRkMbhnQaS/q2yuPTaLCQ7GAaKwtQl3wzAZSemJ9qefNMNyzKHPn6nuAQbCV0TSvEf+/0wxdYYJBfNJzvKZ4EQRrqV47Hrey4tw3ykuxparJ4pOU/OXc1p8kCLAKnjBlZr/c7BP6C4X16Z+89TxD4panW1n0J174nuTgIAGfNdIiyClxEwG2pp7kGs9bidi5XOILVYuYCnhX;20:Cikk5O5S1rVo3B2R5TwlvujYA6puKuZn1QO7OMd/nI2uchUKPmc/LLVuLNbL6TtDkyDlbE+9159aifB09J2utiCpUknYgALCKaet9dj2/2B+EeWsYgI/8936u895brQvEVhIbTTn7PAtihxARd2EbiYKyB9gx+XBdMXHVxXs1zM=
X-MS-Office365-Filtering-Correlation-Id: ff471684-c476-419b-32f0-08d5ac8c7a99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 22:16:07.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff471684-c476-419b-32f0-08d5ac8c7a99
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/18 5:13 AM, Daniel Borkmann wrote:
> Hi Ingo,
>
> On 04/27/2018 01:00 PM, tip-bot for Ingo Molnar wrote:
>> Commit-ID:  5f26c50143f58f256535bee8d93a105f36d4d2da
>> Gitweb:     https://git.kernel.org/tip/5f26c50143f58f256535bee8d93a105f36d4d2da
>> Author:     Ingo Molnar <mingo@kernel.org>
>> AuthorDate: Fri, 27 Apr 2018 11:54:40 +0200
>> Committer:  Ingo Molnar <mingo@kernel.org>
>> CommitDate: Fri, 27 Apr 2018 12:42:04 +0200
>>
>> x86/bpf: Clean up non-standard comments, to make the code more readable
>>
>> So by chance I looked into x86 assembly in arch/x86/net/bpf_jit_comp.c and
>> noticed the weird and inconsistent comment style it mistakenly learned from
>> the networking code:
>>
>>  /* Multi-line comment ...
>>   * ... looks like this.
>>   */
>>
>> Fix this to use the standard comment style specified in Documentation/CodingStyle
>> and used in arch/x86/ as well:
>>
>>  /*
>>   * Multi-line comment ...
>>   * ... looks like this.
>>   */
>>
>> Also, to quote Linus's ... more explicit views about this:
>>
>>
>>   > But no, the networking code picked *none* of the above sane formats.
>>   > Instead, it picked these two models that are just half-arsed
>>   > shit-for-brains:
>>   >
>>   >  (no)
>>   >      /* This is disgusting drug-induced
>>   >        * crap, and should die
>>   >        */
>>   >
>>   >   (no-no-no)
>>   >       /* This is also very nasty
>>   >        * and visually unbalanced */
>>   >
>>   > Please. The networking code actually has the *worst* possible comment
>>   > style. You can literally find that (no-no-no) style, which is just
>>   > really horribly disgusting and worse than the otherwise fairly similar
>>   > (d) in pretty much every way.
>>
>> Also improve the comments and some other details while at it:
>>
>>  - Don't mix same-line and previous-line comment style on otherwise
>>    identical code patterns within the same function,
>>
>>  - capitalize 'BPF' and x86 register names consistently,
>>
>>  - capitalize sentences consistently,
>>
>>  - instead of 'x64' use 'x86-64': x64 is a Microsoft specific term,
>>
>>  - use more consistent punctuation,
>>
>>  - use standard coding style in macros as well,
>>
>>  - fix typos and a few other minor details.
>>
>> Consistent coding style is not optional, at least in arch/x86/.
>>
>> No change in functionality.
>
> Thanks for the cleanup, looks fine to me!

same here. thanks for the cleanup!

>> ( In case this commit causes conflicts with pending development code
>>   I'll be glad to help resolve any conflicts! )
>
> Any objections if we would simply route this via bpf-next tree, otherwise
> this will indeed cause really ugly merge conflicts throughout the JIT with
> pending work.

right. would be much better to route this patch via bpf-next.
Though all the changes are cleanups in comments I'm pretty sure
they will conflict with other changes we're doing.

Ingo,
could you please drop this patch from tip tree and resend it to us?
I cannot find the original patch in any public mailing list.
Only in tip-bot notification.

Personally I don't care whether bpf jit code uses networking
or non-networking style of comments, but will be happy to enforce
non-networking for this file in the future, since that seems to be the
preference.

Thanks
