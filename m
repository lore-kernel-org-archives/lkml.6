Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCTRWY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:22:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751669AbeCTRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:22:16 -0400
Subject: Re: [PATCH] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on
 other arches
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180320125851.19650-1-cascardo@canonical.com>
 <4a497245-1864-3036-074e-107134e4b9b5@fb.com>
 <20180320170001.GC3632@calabresa>
From: Yonghong Song <yhs@fb.com>
Message-ID: <3da78e18-2967-caf7-f412-6d8afb5ed0b3@fb.com>
Date: Tue, 20 Mar 2018 10:21:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320170001.GC3632@calabresa>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::5:ba97]
X-ClientProxiedBy: CY4PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:903:98::12) To BY1PR15MB0070.namprd15.prod.outlook.com
 (2a01:111:e400:507c::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e185dd77-5a01-43c7-c1fd-08d58e871046
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY1PR15MB0070;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;3:Ul9PW65CK6ki6e3u5GPjfElclSOaB6STk4JMtj/fkf+NIsF1rBz56RNagoBsiCIerDO9qc5EOXzqfmuSEE34NQPcNO/Xevji5kYvmzvv2pxWbQvQ5jKFpAqe9hulS3pxo0nUYIqg6Nf4HecNgr7HRveI2qRvCP3v6EA7CW9qX1IGSqH+xb/2FeZT/oSNahHP6xzU8EJUkq9cZ/YODhak4XIxTPPrw9PsKeao4z9hjFmbyN1W5TTbaAVkCOOEf5mT;25:ELdHb+BB6y6XcMtW+nQbC5QHJb+UfDaYbB2w1MJfsgN+0I2tfvfUo6YrXP7yp/g96h8lUkpG/nbv8GPSNLPKvgAWM/5TAPd3beVztVDhTengtoL3Lv/9pQElJRH3SOnw05cmtN13Lf3Y7tkNzcwL0Q350aB+cB9YpilJwnyQysTi/QmY8M1f7/bk11ks7sSRroTmdX7Dg3qnO6znlVyr0t4qDqHMdPp2vELW6a6t4wFbBJz0mp9AtBJ0snUqi/p8vzQkMLI+oPl9PXoKq32uy7IqKOvQ9Woj7t2sA3Z25DdZbRX6MN+mT9dzU+S6un3dLgsyEcwlqAsDZRs20ycyKw==;31:8+dtx+Tsxtid3jo4BWjZr50yHeSAzxIRaHUI4t7QQnUlWGB+l9Y2dZ7387shzJ8Y4RiRQfOedLWdTg3wx/tFV2gpbMiOdywGUshZ02+PbKCvxszgQxWXTPElmP11gx7qqt3qonstnhmvtAbz86wjS36VKpvho/m/Tk30+Ggio6yMyg8GxS/zy6A/xXkyrp9fKL5bW+jWcByQQZSaIZd5qQu6lMGs0ISYNMixnCfSWcI=
X-MS-TrafficTypeDiagnostic: BY1PR15MB0070:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;20:Kx8gXq1yVUHx0Whgr33uFGZCbkcy2w9NqqcfI5B1scWBahItDdtL6FOnnjb3rxg8BfJ6ccxVEEAZvHTSruRnScIYxAUChbxnPgRnjety2Fkxoi9GXkFQmX1RTEyB7spZTjNlzsX7qxTYPo6iqP8z5hqGqTiibGDZ0TnbWNJjiUZHyEvRxKSaAnzOsI/IfjwKwwwvVoWfOAr68M1XFq/Tn4b+kT6OwEg1c9HAoEz4oQzPks8odkEo35uCed9DrPfQ4J0NURaxz6AzpxKoiOhxizozS0++OzupXdw29MH0k1DJ5n6VAsVMVpMJ3t0Tmvp+NIvWJ8ZjuZZYiCLesvs4m6xQ8n0Go0RFHXRfo7H+sPLTWp6JgsJOzoLg4yKvoA0aRwIi+lyyWXHTD3z70+QYv7eekCTRVWns70YuJw43udfZmO+GPyM2IjWOIgBDeA3pZcha11/xJEOgHOCg2fPScfOd3RoqnaWOEQB/ha9goRvyxCW3bO2QMuYkrzlT1MbO;4:pFFSp4nJ1p4tQIUxIaJwxAdWGioUbzxDgHQPkrUGTbNW64hB/ondoSEkkACpL0hydwbhkLalV3xtm9t3eAoCHkiPexfsybaSg4+TCcfoUbcRk9dfmMH9Z9iUV/JX3J2PHniU+lV6ZGRg4zBLwGmruD26PJJ2GhG295dD3JUQkWbd2GTkr3hWADYaJrRjS05mLlboBSFkHowPmQTh+g83bXNByGB6+Rqh3yw5U/uiy7l8S3LCorueOBFiS7xKEpSqs+Y4ulwBFTSCMV94IBZeQ4mYo0BlrEBhO7RJF3PkkkwwmRdXPWRq1mp6g6V4bquirHzGIaeIyhPwdcDKZeEhal+iUaG6tzDRCgdP/Jwy4ag=
X-Microsoft-Antispam-PRVS: <BY1PR15MB0070AB744F94F981C8778F15D3AB0@BY1PR15MB0070.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(11241501184)(944501313)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BY1PR15MB0070;BCL:0;PCL:0;RULEID:;SRVR:BY1PR15MB0070;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(51914003)(189003)(199004)(47776003)(46003)(53936002)(86362001)(5660300001)(81156014)(81166006)(8676002)(31686004)(316002)(7736002)(6486002)(53546011)(2486003)(386003)(52396003)(31696002)(6506007)(16526019)(6246003)(52116002)(76176011)(36756003)(23676004)(59450400001)(6512007)(229853002)(52146003)(2950100002)(68736007)(230700001)(65826007)(97736004)(478600001)(6916009)(186003)(67846002)(305945005)(25786009)(105586002)(4326008)(6666003)(8936002)(6116002)(106356001)(65956001)(2906002)(64126003)(65806001)(58126008)(54906003)(50466002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR15MB0070;H:MacBook-Pro-52.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjE1TUIwMDcwOzIzOnpPUkx4ZFdzaUFmeEFUbEZFdGtWc3daK0Zo?=
 =?utf-8?B?R0pXZUZIZXdVTWRoakg0N0dTT3A3dGJRYjVnZmh5L2tvd3kxZ1A1bEV5QW94?=
 =?utf-8?B?dm5aQ3BudmpsUHNLYUUra0FKVVp3VWJsSkJQNEZqTnpjUzI2M21BbFg4RFUz?=
 =?utf-8?B?OVVUbEhHdStsRWFsaHBKVHlCU3BDdkk0VlhYc2d6U2lTaW5PM1ZRNjF5T0Zp?=
 =?utf-8?B?dVo1S0dpU0pKTVlteHhwZzc5TDFVMDVGUHB5NjZyKzRsVTNMZ2kzdlhQTDNx?=
 =?utf-8?B?aVNRc1dhNEcyQkRpbnRYdWh6QUJpeUxLMytpWm9NVVhUNHpYd1FPT3JuTHBG?=
 =?utf-8?B?SDhZbDdzdVNXeldzdWJuMDBKK3AxalhVdlIzeDVPanlvT0ZYQm9nL0I3YWFD?=
 =?utf-8?B?UDB4djRIdWo5ZHdCak1hZzh1RldxbUVnc3ptQzFZR2hCQ09xeUNLc1B4aVBz?=
 =?utf-8?B?MkViRG9yNkNhVGU4SU03RHBhUEsvdmdOcFJ5U1UvbjFSSzlFQ0FuNXlETmhv?=
 =?utf-8?B?SjAyMGVqeVoramdyS0hGL2RaS3pqRm8wTzE0MGJTRlNHb2grdVhmdjQzWll6?=
 =?utf-8?B?Y1VJSE5HSGY4QzNYQTZlNGFqLzBpeVFiQTk4RVp1MnRDS1F0b2tkRDFqMGxH?=
 =?utf-8?B?NzJHbmY4bjZHODk4bFFhNElMajVIMTNKWnVGR0lnWG9uRFNSK0lxak1tMUJi?=
 =?utf-8?B?ckRLWS94U092dWdOZmFNVXJpRklobkZvNnFrOWptMWhiRHIvTXFMKy9uWEdu?=
 =?utf-8?B?Wk5RbFhhOUh2eE51VkpZR3g3eWt1UWxvQ2N3TlpzbVNMMklaMHBPWW5xQm45?=
 =?utf-8?B?NUlLSUVwaEsrMDJRTlg1Qy9SUGJlSWYxeHNrc0t3UHZHYkU2UFpySDhHRVJa?=
 =?utf-8?B?WnZiWVQydzZmMFRNVGJkZXpSNzN2SGZvbXptc1pwM2ltUGVwVHA3ZmJhWlc0?=
 =?utf-8?B?WEZGd1VjUzlnZ0hxRkpxeEtSSHY4Unp2RVl1TWxndSswWFhoRS9PZHQ5eGlE?=
 =?utf-8?B?MDVFOHJvdnlKUytjb0dQQ2EzbmQwa2QxbzFkRW9NOWcrZGEyNlVETlRHMU95?=
 =?utf-8?B?bUllb2FoRmxSU216MkpLdmhzZXZ6YXVnNmNjMnhXT3phQ2FrclM2eHRKZHNk?=
 =?utf-8?B?ZDhZNVpiMGFGRFp1TDN5ZWpUUFAzeHpPS3BRbDFTU2o2UXZRNHRCVlhReDY2?=
 =?utf-8?B?bEpZZFM1alEvSmdnVGdqTmxCTTZYUkpkWFBaQnNnNEg2c2ZhVlp1b2NlMVU5?=
 =?utf-8?B?MGtld1BKK3JmV3U3WDFIZlY0ZE9XamcyWWxKL3JNck9VZ1J2bTJKQ0h0ZlFo?=
 =?utf-8?B?RXRZeDIwY09BdTBxUCs3dVVwM2M2ZTU5a05vc3pXTG8wN3pSTm1jWVdrNUxr?=
 =?utf-8?B?RnRnRGttYTlIOWJ5UzB0WWdKbXBCN2VMV1JZcVFDU3B4TzBUWlI0ZW1JRlp5?=
 =?utf-8?B?T0w4Rm5xNXNWTU9BNGhXZWFGaHF0L1U0NUt5R0V4bnFZMG5wNUxWOXNSaUVG?=
 =?utf-8?B?b0dFaDJuQWs1bUFUajZwaERHdTZFSWx6clNTRzVEeDVuS2J4K0tUOUl0Vldm?=
 =?utf-8?B?eXRKNmUzTXpZcWttSkFlNDMvM0NBNFRnUEVKTWQrZzhxOWRwVW5wOFhlaGxz?=
 =?utf-8?B?YmlkWjcrYUJMNTFZdjUwclBEUllrMm9mSTdkN1lBTFpOdDMzUERaVkUrRU1M?=
 =?utf-8?B?MzFzSEQxVy9pL0JlSmR4QnAvelAzQWExdWY0VkJ1S1FhSDdOT3ZoSTVMVTJ3?=
 =?utf-8?B?Wm9DTkIvb0s2Kzdra25oZmxzS3U5NTBZQlVSUnpCUld6VG40UnkzcVljbDE2?=
 =?utf-8?B?TDU2MXk4dHQ3TDZaSzJJakhpdTJLcFN1ck1IcGJ2cFgvSFNNSnVJVEcyeG9P?=
 =?utf-8?Q?lL8Sh0NSVsOOOyTvgYqMT+ie4hrxjXW2?=
X-Microsoft-Antispam-Message-Info: S/y6PglEQBAIoxhvXJCivcEs5pvkJFlAV3Wd3G+91B9dvbQngTjarB/gf7CgGI8/QTm/Ye1jwHhnKyGWK5PpU4LkcWckJveoB9SIx6EL/iGF2BSE3CGe4aOwE5/SOgUMhvH2RQBP8tbAsfRY1PraIEDWTpfWVdZWSFSGyA8mEHcDyP0QY9Tf5ODK8fOglx6x
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;6:bPXMHjWdBFp2Den0YKFf+51uivbbafCX+JXytrol05Vlcr/jXDijvN+n9Ch8M6CWCDs67Y3wn02Dl42bLrma9r/2YTwvKX3XKJyFGtgVRBKta/iiLrJMJ9ptNWit0k/QYHNDln2kbIHYC8wTlqKS2xyupx57px0GSAeK6NaexWHCfzVgFwU4sbwvWdHcTjEGyCxCrmjbj7FUL801raq1J4YaVUkow8t1FeZDJMWMOuYBvfEay8o909ydDVAwSYe7XNul843ju20w25lKxBEyBWDSWEz/N5bStSAsZor57nWsSuaU8rwBr9z73C/5wtTYOG70IqoTZ4gNaL0TFLCfbI2hnuMTbPdb/6uwG5eSeXk=;5:+J7DkuMlG1IKG3+3Ybw3bkqjWP7LqGTGHZywTVjjoWlfXO4+HL3x4kDFytysW0lPIeB5OIuzJBPVOilzvNCr/DHPcboOqtI2OAYS1IhTuwdsLznc8lz8QXikMNLoSsqNq3BJ2a32Va3/q9dWEmxV/Re5rj9m+WhosowELt/aplQ=;24:wvJZdfqwZgi/z0iXdlbVJ+YiazQUkf7QRzWXoqu0ISc4Oh/6xdWWrlNAvZobtwe0o9zZMeFAjYwVDSpWTCLRKM/+jAuNjqTw80vBtbYW9o8=;7:I7f4yfLMH19298xxEM7HmxHB5aIBWWrIen5oOsUy3FpTwm0Ua1yq5E9BKTkngm1zlt2vDBWxq+9Y9OskpLZ5pn/0KI+t1dP9nQFrr69MEvpIfn8iuxeis49+UFMF1xwNVsLnqT1qz8DeITPHKYSnD3ewcdMybIw4vPeI4KHi+NmO7nGs24KH8mb4h+N0jU7J1B0e6/wRmr26nKMD/txMd+EhZR5H6R15w2GnMm4jIhEQlnrh7qItktGqKqE2nFFB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0070;20:gCHXY/pA9c6uWbHlTzs17/sYp3NhNw0UbCxCscqFso2rMkriaeZVqkln3RDPaLoO+d3Et8zNQh4p8+fZSysH6QAQYKp86YIa+KtEYq7ohf03rbwdnDhz6cipfEPT9I3OdzgpkG5lSpy2Pc1CTziIOKOMYuXL7dpPV77m1Vfm43o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 17:21:47.9939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e185dd77-5a01-43c7-c1fd-08d58e871046
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB0070
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/18 10:00 AM, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Mar 20, 2018 at 09:05:15AM -0700, Yonghong Song wrote:
>>
>>
>> On 3/20/18 5:58 AM, Thadeu Lima de Souza Cascardo wrote:
>>> Function bpf_fill_maxinsns11 is designed to not be able to be JITed on
>>> x86_64. So, it fails when CONFIG_BPF_JIT_ALWAYS_ON=y, and
>>> commit 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when
>>> CONFIG_BPF_JIT_ALWAYS_ON=y") makes sure that failure is detected on that
>>> case.
>>>
>>> However, it does not fail on other architectures, which have a different
>>> JIT compiler design. So, test_bpf has started to fail to load on those.
>>
>> Here, you mentioned that it did not fail on other architectures. Have you
>> verified all of them or just looked through the algorithm.
> 
>  From our testing, I know at least I get an UNEXPECTED_PASS on arm64, arm, s390x
> and ppc64le. i386 doesn't have JIT, so it doesn't have
> CONFIG_BPF_JIT_ALWAYS_ON=y.
> 
>>
>> Could you give a little bit details about other architectures are okay while
>> x86 is not? Maybe, x86 JIT can be improved some how?
> 
> As the comment on that functions says:
> 
>          /* Hits 70 passes on x86_64, so cannot get JITed there. */
> 
> And looking at x86_64 JIT compiler, you will notice it's looping trying to
> minimize the size of the code, limited to 10 passes. If it does not converge,
> it goes back to the non-JIT code.
> 
> That's not the case on powerpc or arm, that do not do multiple passes. sparc
> seem to do 3 passes, but does not seem to go back to non-JIT code.

Thanks for the explanation.
Reviewed-by: Yonghong Song <yhs@fb.com>

> 
> Cascardo.
> 
>>
>> Thanks!
>>
>>>
>>> After this fix, test_bpf loads fine on both x86_64 and ppc64el.
>>>
>>> Fixes: 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y")
>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>>> ---
>>>    lib/test_bpf.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
>>> index 2efb213716faa..3e9335493fe49 100644
>>> --- a/lib/test_bpf.c
>>> +++ b/lib/test_bpf.c
>>> @@ -5467,7 +5467,7 @@ static struct bpf_test tests[] = {
>>>    	{
>>>    		"BPF_MAXINSNS: Jump, gap, jump, ...",
>>>    		{ },
>>> -#ifdef CONFIG_BPF_JIT_ALWAYS_ON
>>> +#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_X86)
>>>    		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
>>>    #else
>>>    		CLASSIC | FLAG_NO_DATA,
>>>
