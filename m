Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvmhTdt6lsOovHUXj39pnrf+95RuQHdru+hgGxW5R9pVYdFrEAUVm0I9R8He92f0aUyUe9T
ARC-Seal: i=1; a=rsa-sha256; t=1522078234; cv=none;
        d=google.com; s=arc-20160816;
        b=vCeYBFC7sRUX14S0CGLJ0qCoDK8+K3wvFBsKYVR/fCHtiFHZotYDHzHhPhgN+Kxfta
         pTsiy8ipLEeGnB9SKff3X4P2X2C1DsM+SBvkFalPed0SkKCjYdjrajdm87r0eK4yuIQ+
         O2cCX91mL7sXlUZ35KqQCUcR2/Cfcyfu4RWhb1XIZDPBUdKh+3qKc0sgtL/e0ZVy8rV8
         wp7OdSiO58kXTpp91nyUAu2Ben6GOfbjOI8i7a7y+nNH1mgTf9Hv+eh4nKG/8VnhOJRc
         zHBDnu5meFAZkZVjqwyj08wIVGrT0i+yyVHQhs9VyyzCxD10qdseP7dqovAvSK1oo1xy
         PiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Z5TVvMtuG8p4hjysa2vzfTjzuLIXwWHG8lWAhsE8Ml4=;
        b=fIM+HymkGC3qMXVeQNzgJTN9miyc+PQ4zm/md7SMkEbgmMb4+6P9EH07AGvoA0R+J9
         BhNakXppe5fFidFE6DXhE7YsGt4DT7pWrm+fhhLsoAaMcYG/YcX34RMSfRhEnjspnNUG
         5fe0B3K4sg2fNOwwDeetWpr4xw+n4zbpTEluDgQ+1d0WMB9fM5mUUBeXya9Qvhn8B9SA
         91kh9avIb7bZaNdOalRbgQOOXKh9SMijEcW5vCKZO6xaRZGYlfJaS8J2s019q07mvfqJ
         IzUZxyjIYdIk2UYDi3ADtKHZ5Ncr7UdfI+ndE/xh8iLOFAxaK8zv8ekCuBA3eh34hLvz
         1i5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=FRJudBK8;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=FRJudBK8;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 06/10] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163853059.21546.940468208501917585.stgit@localhost.localdomain>
 <20180324193253.y653nm4z6sh7u2kd@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0fe02df4-3d55-2ee3-95af-156ac63f29be@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:30:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324193253.y653nm4z6sh7u2kd@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM4PR0701CA0016.eurprd07.prod.outlook.com
 (2603:10a6:200:42::26) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caba0bd4-3c6a-4b14-b94b-08d5932e81e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:WrS9HZXwwW+aof8i/z9P7YxQiS4ZCcryBKW0YOMpZOcQ+L45qlBSWh1mhFRGxRHB/uKXfAu7pgjcasGc865l7ESWqtMQUD3Zn/Ww2m9JgDykFvG9xESdTLhuEZ8l/trPDRfDvMwq1jSngTWu8LQca7ji5bJWwDZcY7SOef5ztO8a9Kkk+Mis5pMstqodNIGo6iCbi6+xXUUjgfovYTQWw2FzaRONfthZ0YQytTk/08K6pPuLCXPhK0BRgMeuAhDp;25:87+0FJwJMUfuBhygh4CfoJh3hZj6r/Jy9OIEDoF1sqc8TGMNH+xyjXO6YZCBmDvnGbYxzVbRxS7uNL4AUa0TCMNLty6VQcUGfvlPOiK/FWR8TkSMRdg+ja6oV3lQIyIrorNMMwtqLM9IbNDdSxU0wk7XLZ0eVdVvDn3dWzh1lFUTVnHcEV0TEIDpuneUUhHnnTLetnYI52WkVdUOpOr+9sOZjyG6EBiRU9EzZtmKZV9xjMMoQ40JS/S0togpSRRXD1NNEf2E1dqYvxNFkPtQYomaW6zWafMiYKzCnL4dElKj8PGdcItoJZWzi+Nb1M7Vu2pXgNtOiVs7AQYe73ceug==;31:xO9OLKlF+KsdIcBZWOq9PlP0urAGH4zUhjEuMQ1uoV1tldeZftpzYetmH/eHj3hv4/LcDIxf0WVL/qBW/76R/XSlF0wqlQgEMOmTOHBi+udVnpils4qrl5DThYe9VSXmnKTkSLt19WiWmhzIrK5TVQjIXM9SBRm5J5z6aaQwJz9wyr8w01lcGUHFepP35mHhEVaeqQ0wl8XWiGeMkzmzFRbg7s5s86CihKV7aondzCU=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:sbk8LmxQuTBkZERY0b8PZM+3I2bsbC77F7EKLD+wYEGiGJaUIPLvEFzRN5Cgx+JENM08YyKUjk4cX7K4bMsBHLM97R7ysOshe5Db/o6xfx19QvLvVzZMXpb711EjB2FQ9jHMkEfGKNLi4+zRsSHSrnPukaqqFjBdd4b5xqiUH3+HG5axzgei6ou29W4ctY0awObl576EQHwrs09q688DuzTVfs2j0/1l6DuExowk8wrQFc+dhk8xM0yIncjctADwybeNQjoujoZE/NaA3S0JbyPmkrpPnzcg0+GmDyitXHGBeTAJaqXXzuoJ/JxgNixSK45coi53Te3dbvDpNhp0kMVqvP/o00fvF4G84Krle/uKo9lGuccL3cQjyFKePEOrMef0lEUBA+oIvEBqp+8PxCWbf6vEtJU41SoJ+5jRlf59itXntqf+nSMa89h1cqXOti32eJlwVATXXf+2w5au4cfH/o2N1ffdKhWU5vn43o4Z1vcovA0vWwCjB8Ahmlk1;4:8Soc6VWb184Dw9C/YXXwOpctIHjLgCP4cGuwwEfOTTSZMj1SRQGfddNPG+5fJu95G5OF5NDV7A2KOixq8r8cyjUS19aziPCOqlkEb8phjx6fcc8nYfFPBgP/a16VXYLrSBDvikvIP0a/NvDz3pq74kxnj1u12WZj5DW7t4mkMOglyrOZ9EIsjReDTbbVB2FejKRy1/WNvQqhq7fwWxYNfYW43kVVsw5zu+wXL2WttbtlluLA1cZAQWVISxdj1eRjdd2YldduuXoPUp7+/5p1tQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13295D3154BC7A45A322D701CDAD0@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39380400002)(376002)(39850400004)(199004)(189003)(3846002)(11346002)(66066001)(6116002)(65806001)(65956001)(105586002)(6486002)(7416002)(8676002)(229853002)(81166006)(81156014)(55236004)(230700001)(386003)(53546011)(956004)(2616005)(47776003)(446003)(7736002)(39060400002)(97736004)(6916009)(305945005)(53936002)(486005)(486005)(68736007)(31686004)(65826007)(31696002)(106356001)(25786009)(2486003)(52146003)(52116002)(316002)(478600001)(23676004)(4326008)(6246003)(2906002)(59450400001)(8936002)(26005)(77096007)(5660300001)(64126003)(16526019)(50466002)(36756003)(16576012)(58126008)(86362001)(186003)(76176011)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6eE53SjFHQ2YwclVyNnZQTjlwbkxraHZ1?=
 =?utf-8?B?RVVUdGs2SlVMODJUQTQ2UlFGUHRhWW4wcCtBUmJrdy8vWDEyV005Nzg2LzU3?=
 =?utf-8?B?TFRGWkxYcDFxenZqV3hWUjdQMURoNkxqWFpOQ3N5L1N1RVFxTkFaU0l1N3Uv?=
 =?utf-8?B?UzBseXFGSElseXVFWVdqbGZ5eVpBTGdEYm1yYnFCeXBwSTROVmRtSzFTVldq?=
 =?utf-8?B?OWlTMFhneUx3aUJrdDJMNWs2QmhhSDFPUVNCTlFqYUZqVSthQ1M4WDRuMGgx?=
 =?utf-8?B?STdVTTlKcnpEQitaK01mUVM4czJCU3luNW5xbm45Qzl5OCtpenFSNzF5MkFr?=
 =?utf-8?B?TUZ3R1pLVE9mNUNRSmp1amhjeHVWTDB6NHJhamlHR285QmNKTVRlOUJJaXQ3?=
 =?utf-8?B?SDUyMFBPWlMyandMck5kd2s5NnVsMFZyWDV3Qk5ZTXl2SXpXdy9qdFV0VkVu?=
 =?utf-8?B?Yy81WDA0YUpPcHlqMmE2TTR2QVVsUWg5TlJGSHl2MlZRWS9GUVliNlpGQnk2?=
 =?utf-8?B?S2tIUnE2R1dyeFM1dUJYUzJwU0RLZ2V0SHQyTFRORUwwRytoNThVT2xnWlRx?=
 =?utf-8?B?SlhvTUQvdkJPVDAweXlNbm14bEljQ0VwdW5QVHpGY1JOWmtIT2Z6RGJ2a2hz?=
 =?utf-8?B?OHZvRkhNWXBCMGNId1BHaVc0UVBCSEpLRDEvb0ZSTG5samNiR3hGUGRkVFIr?=
 =?utf-8?B?YnlRUDNJKy94cFdkV1RWZWFDc1R6M0VyTllObTlTV085aEJMVlNhUjg0K3JY?=
 =?utf-8?B?NWx5MS9kcTc5VGM5UUlQWjFaYUM1TllkdEd1WGxpM3owaUg5OXJ6V1dRVGVu?=
 =?utf-8?B?YmZPSzlmVzA0ekwzeVphU1JmYzdpb0kwQzFEZTFhSXNMbnV4S3hyU3EyTGFu?=
 =?utf-8?B?bkRWRlZwNTBGV2R6NUF4Yk1PRitJZ25RUkpJRlVsUW40eDBKVEVPSC9Ic210?=
 =?utf-8?B?MjY5WmdwWGNZT2t5TUJla1l4eUdFMDk0SEhqdFZ4RXZlemZtZVVhTHpud3B1?=
 =?utf-8?B?ZWdYWkFJZmxCVkVFQXlJTStlTXhoKzM5b2VKY3BmNzBDRWFDZk5qTTdOa1F2?=
 =?utf-8?B?dDlaKzBQQkdZSEFlU1Q2Y3NMVGhWd25KRUxjMVpPT3grQ1krSmt2bDJmUzJ5?=
 =?utf-8?B?YnFUcnYvM2VlRUZTb3VHT1FpMExoYmt1TVRvVW1uQ1MySHJ5Rm1XT0xNMHNy?=
 =?utf-8?B?VXY1RG9Zbi9EYVVkRWtZR3ZHbGs0aXBvVkxMY3JFN2pmU0pSbTFIL3N1Y25w?=
 =?utf-8?B?VENhdm1iY1Vva1R0c1lnVFN3Q2RRMjVTck9ZSlBWNytyMlhsL05hSUFqRHdP?=
 =?utf-8?B?blhueUxmbjVucWh0T2l2dWVXbkxnNjI3U1ovRzFHMmtYemxpaXlHTjVGNHpu?=
 =?utf-8?B?ZjRMUnR3SXo4eENwa3ArSzQ5SkptQzR2QmFNNW02VE9qTER1R0JCTXBkWFlo?=
 =?utf-8?B?Z1Y0TzRCTzZnaGJQWkhOK0RWcnQxMTN6dlRZN290SWt5emVHQ2FBbXFMQmJh?=
 =?utf-8?B?R0dzMWlMTDNjOHY2dm1rZFhrbDhuUUVueTN2SHVTd09zZlY2bEprVkxzZHZ1?=
 =?utf-8?B?R3dZQmRsYTl0Nm03YTZxUm91dXlmZWFralJyWTM0MlNKSlQ4U0RoWjlTcFF3?=
 =?utf-8?B?RVNvVnJEZXpLRGlXSk9SUmNORFhpcVRtekVmREMwaGJwdkVZTWhmU0pZWGZV?=
 =?utf-8?B?VVE2SVQxVTk4VzVnT3lxQlg5VTZWNnQ0c0s3enVhR1FqUU9TbEhsZVhhUHpj?=
 =?utf-8?B?MVdhOHphR3RsMHhCRGRZQUhseDQwM0xxRE1GSXVVdjlWaEduVDZLTC93Mmhv?=
 =?utf-8?B?N1pqbHY0Q2l6dnlvY2tLQklmWUVKYWpFYlU0R1llSUJuZFdXd0xaRnpmM3hX?=
 =?utf-8?B?U0hVZUpCNDVRNWlPQWVWNDdJckxyZG9LcW1ES1F3VmcwY3E0dmlwd1dFTGth?=
 =?utf-8?B?Q016YmhNZlJiNUErUjRndGE1NHNtYXFrbHJ1QjZNcjJsQWVwY0hZclc4SU5y?=
 =?utf-8?B?cGJ2bEpmWnlUZDZRMnZYSU5LcGZVNVJIQkVSam9nSnFPclFKamFka2prWXF6?=
 =?utf-8?Q?g3j7fE=3D?=
X-Microsoft-Antispam-Message-Info: 66VHXkkeRFlerjRwTdfEsx9nsXevOf1zjb8LM/TPO9ToLbs0yOyJBJWBnLxFyvwrcLw9EYiw9abCQMC8LsAsVgS/tZ96jEFAk1z3uSvfOPE+6gQaiIKCUeKNwIxbKOeYR1JXC2bExW71fQX40FzZKEBB7QEkX8FEDL24FcatKvomb1bTaSlE584S2pdGLsIp
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:B/A3fKY2XQ4keLiC6FDodY16jCxEcRAoqaT93LNF5niZuLEHXIutD5QOYVCWAXelpF+2IzmALVbXcazlFRRNW4aXy+nVoocGz7YsjMWV67Vbaez9dg1ktuaA6igTZklBBtfGCBxnGWfZTV05uihzBBCKNN1Z+502b+64mRCiAQvLfoubWG9P4tkATtYoqu8V6fGqKR8UGlabyeVfFfYB39v12gXbA8EfrK71Br7hrP2B7Vrt+VqTf3/1gAOIfEKTredjeiXQSF+pQK8AHetAesFkNu4kMmw258ucMl67tVoqcHcCOzbFrGFUxEfTZAeTiAdueDFOgQEyfdxTqNWSJCZZJOHpagHrZh/r2FsNSuMkI5zB3gFVAexA8oZKCgLd41BUk/QLsvFVqlBi4jGiCjEtLJXeqOFSkoLb2T3QML/3aAzv9HPXqSVlBcA8BKCyksp+Zj85qENYkXtekSP6oA==;5:fn5vE14sL5fwv8nfcSHegxPqBZAdRaUWow9RCBXFGcUDLJ8IGRp0tVnt/pIfisQvwoK1atbCQoXbozzQ5gmoCFgDXOCLOxbJ56MGNCjYY1hUowPsbvzdITFa8lPnAxNOf/VtuaaEeRvg5Zm4SHUluCm36WxevEAA2egrwdIPgR4=;24:IPk2sPaD5C2+P0q6DTzLi2BjFtJFya6nd+CZl48qaVlwM3qipIVCQ4PyxRCaaP85lf4XrWGrzibPiXbCuJumHgiQrmIXISqbTxDgO1ufo/E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:Z2EQ0rfmgnyY5sPuO5Qu6Xy1X1iKXt2fVbpMuLNBkBgw9jielRh1fSpoOm9/U3FxrWulaDmwmUM9ZTKVzY2qy6/xMZTzPmk5K6RI8E43magtffvbtihERlnIfNGi/outT3LnLwJ9FwJNT9vvK/2Mz4u+wkUN3IPLPAQXwhc/CEZwD2FESYnDABBTT/sJCeio2mdC2JZF4ETIHfAtO2v5zWE4YmcXKg+fsGl+1eydtPOjTi9Ufo1CQuOK202pcHEZ;20:ZipqoZlZcwprC1G14p2fGYujzNXKzmQ37VJpw/LPuL/PBYZOJIZkvyzzXiTPB1ziObTCif2xOncpbo6qplu/EZq7q8+REFZ10ad9FJxwxC408TtbsvaSFNFMTcfdJ5ViPe/9mzvMYCnH010hZv1hVrO9UoyEYl8ltskLd25g0pM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:30:28.5922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caba0bd4-3c6a-4b14-b94b-08d5932e81e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553658469578349?=
X-GMAIL-MSGID: =?utf-8?q?1596014707275391442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 22:32, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:22:10PM +0300, Kirill Tkhai wrote:
>> This is just refactoring to allow next patches to have
>> dst_memcg pointer in memcg_drain_list_lru_node().
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/list_lru.h |    2 +-
>>  mm/list_lru.c            |   11 ++++++-----
>>  mm/memcontrol.c          |    2 +-
>>  3 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
>> index ce1d010cd3fa..50cf8c61c609 100644
>> --- a/include/linux/list_lru.h
>> +++ b/include/linux/list_lru.h
>> @@ -66,7 +66,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
>>  #define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
>>  
>>  int memcg_update_all_list_lrus(int num_memcgs);
>> -void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
>> +void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
> 
> Please, for consistency pass the source cgroup as a pointer as well.

Ok
