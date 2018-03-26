Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtzBoG1YIOj9ITyIgTB6gQwjwcApnX78eipA9gXmzSxmrl/hIWnJjo5NPvI4l5nlk4Bbw/g
ARC-Seal: i=1; a=rsa-sha256; t=1522078199; cv=none;
        d=google.com; s=arc-20160816;
        b=fpQ/zCDG/W2bFFXozS/1SIgEa1cHEj8SRzwEfMfJPOJqGrzQOKIvIrLFrFNVq/pxTb
         igh+TBqVQw11/LWfaDuNKDQ9d8W9EEu9Wp8Z8aMvc+qzWTzlFcJIlDNfThcrnMHYGvji
         Tw40+Zes9aC1lRBm4TB0VdioeyNOgbM3isDGBhPs6MNHoWHaeBOMuLHO5hF3kO6eckxs
         7aZM1R93IFmLhzRqQhYGK2OYcA7nZNMpb8BN3WEydmXHqiuqSfFt9dbt53H9US3wwsVB
         5j19EZ0E3l+OCAwDLvwNCFAlWEe8ytpiUIqcy3TfUEbbEqxT7W8cvhwSetu9u2Z61lf/
         Gp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=RWis55cGiXrLMicBpV1sRqXzvJA4a5UYu+bEFz+maOc=;
        b=nMt0mCuIzt1LDZqkEBlUZ2Tgj+z/wiw4MSrw5ygfVjAv89If0lW24892N9yc4Wva/N
         1CQfQbafuOoxwj6U6fugkSWnLLqP40MTDSMORqKQpe0rRfND3zOlA4cFgSImP3axhSiw
         B0Tcgxol70/w1qKq/2TykabBIkvoR+iWDiqa52dlrIuz/fDHfm1dibuyio9NMX3PtrDZ
         vAWqMboRDw93mbxD3PounfWdcqD/a0x4r7J248LdCFawR95T0yIjB2rvRs7Nf5Y9Y4sx
         971Wgkyz0T7sKWcS58vRfzquWUTFH+puNp09OsWnQkwPMNJAO1mx69RHSL1CxJQpNLbM
         tqqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=N0I/ZbFy;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.94 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=N0I/ZbFy;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.94 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 04/10] fs: Propagate shrinker::id to list_lru
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
 <152163851112.21546.11559231484397320114.stgit@localhost.localdomain>
 <20180324185018.iibbx3zjtzikjtlc@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d65c7a9e-eb8b-a2bd-163c-4d6652ecb74c@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:29:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324185018.iibbx3zjtzikjtlc@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM4PR0701CA0042.eurprd07.prod.outlook.com
 (2603:10a6:200:42::52) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0915fb-9212-44e8-b09b-08d5932e6d6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:alnQareF6FCYhPESR5x5fJea17N2xlDamnFCF7Iyf3Sdrdx48NY7GyCCTx4ww1jfItNA5udnbVIWKS/4f7Ea2m2zM/+e9KxiPI/F8mGscsaCoo95bmGSy0Os/ZXU/NfYPUO94pdZ3M9pRSG9K+Te5ORvoY6+K8UKBZ6Ecbz70mbwsRFA6teQOgbFcjHW42NwuDSy4fR4Ar53tdMlBNqdpVGfnbUkzbZS8pZQAjXN/atRtJVjuirAAk4i9GJDQdKv;25:OsEmKGuBKg3yjX4M0zghAYv6V8Fmu74xJl/tDGsSCA7q19IXGStQazfm/DzrLlMtxMkANgem/36MDUO9LYNpwNCfQEcvLDSQfyWfCHatECjeVoXpL5smcGgdbb468BbGgBx8wVaz6RxA2wHSRpPdVgYa1FJZVWivdVBmj9VzgcbdgUCfN/7FTeP/sxHLsHf8FVrVwWLcJVTRLnMEhmt1ec6g/b+AYCuJw7NtQ9MPh9/1grex+1LChBD77WV75Q9OevDvKFtZiC1HhS9neECcMueZV1UlzS454Lmz+7elDe9snihE6NBwiCGODIrqpRQJLdkE0J/1/4zAMrqUnvznFA==;31:Ll6fR5jSFK4E+D8TbWsWIrNHC+EXXxMTmlLDdY7JZAvwnn89bB6Iiv2HOMDJcPIs/1FKXlKiMH1u7o3CdICqgrIHili3RxNwoYjnwxpNEwQWNSXgEehZHezwwQ1gG7vEJkZDdWixLXxJwG6jy8IUfaOddT0jeCW2G2gPus3+LcxWAt/Smi1DzW3u0YzsrK/4/LQ45cppH1Q0zrY/TZXNWYx9201n9cJwUJgj+Ij7V48=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:VeOiJLfDltnlg/462OuQFY+aSdF4kOpRVbgsu3n48X4wEI71xn5yuNwTkNrIgHY9LRvpoFuNd8ypfJobAN+LJvLuqI7ihuPwk9BUdrO0R0QQrglIcOY0YzjIopxNVDAL2Gu3KnZcsOgdPQnR/6TKMUH14qGCcQYQsmI1kiar8pM3Av8ST2svEmkT0j1TymRNtJ6eKrMiA2IhmrCnZ51Gs7ECWkVq0O+NXi73w0KIOPm+d6Pct3pAasA5VCRd//ShammaI8BbwG4h3w8mCkakaYD8v2zPKU7DdAORB7tPvNX6e/ayZUqgIMc1O8q5FBXlnJWELsmIfZtFayXwCidY3iJeM5Tzgak3a0eWPklon2SyfgC6OoMg4G1UUIZ20+/zS0ghF5ZjS7GclWaPWAYY424KoynJgY2rwIQUGupoBZVtddmNWFAcRFc9KJY2yg3/G3AaOhvNgf7Dnpq/fOxUzxAtl2m4x0ucLCsM6vABTxe6wGtJj0L9xiEljKA3sTXw;4:5BYjyCP9sTaJoM3vc+jQiD8ucHLKSe4zjh5QlWwWOOg5I+uuMPC745tj59RqdMQBYB89nGD+E7u7qHVtQrEyjXo2GW+GensKL57Ja+PZZ3wbBdOWpOesQtg79cJHal/BsctxMx2WZvHjJjEtHzAFvLjnX0+SJkACOUrxx88elHDHrkiCPwRD5rCYkX1LF2sNQOzWwQuNJpoRH/ChdjWcc7l9m7d9LQjc6SRY7SORhp+zLotgo6vwy72ZlRL4+pLibHGvcHG2jQmcN+KcxEHzKw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330FD21DF3AF08513122359CDAD0@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39850400004)(39380400002)(366004)(396003)(199004)(189003)(52116002)(52146003)(2486003)(25786009)(6916009)(478600001)(65826007)(2906002)(6116002)(6666003)(36756003)(68736007)(3846002)(6246003)(229853002)(31696002)(305945005)(39060400002)(106356001)(97736004)(486005)(486005)(7736002)(446003)(8936002)(5660300001)(7416002)(31686004)(6486002)(8676002)(16576012)(11346002)(86362001)(26005)(77096007)(16526019)(186003)(50466002)(47776003)(316002)(81166006)(58126008)(956004)(64126003)(2616005)(55236004)(65956001)(81156014)(65806001)(4326008)(230700001)(53936002)(105586002)(59450400001)(23676004)(53546011)(386003)(66066001)(76176011)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6ZXg1dWhENEtoaGRSRkJmN2pmYmpIM2Vm?=
 =?utf-8?B?ZFNTQlZWT2xvWDBnNDJSamxlT0pqK0VqVzBvOFlRZE84RkpKam1qaHk4SzdH?=
 =?utf-8?B?VXdyR1ZYYlozZFNFZGtZK2E2YkM5VU9MM2R6MWgwY3RYblIzS1J4akI3OW44?=
 =?utf-8?B?NnpyWVZkZEJ1Q1hZQmJsZGM3cDczYjE3ZmZSeVNTaUFZMzcxTkxwWTh6Mjdz?=
 =?utf-8?B?WDJYQ1laSzhCQjZRaG0wSjJxRldoaUpPYkdYT2JseHpkRVhsbE1iV0pLYWR6?=
 =?utf-8?B?VVMrVVFqK1BlTnkvV0lJZjVIc3Q2cmpBNHpUR0Z4d3dhK0tmdU5TdzV4SS8z?=
 =?utf-8?B?Z3d5ekMvQllaZThGbHVVYVEvWUl0TklILzNDelpCN1ZPNDYydjZoSXdIYVVO?=
 =?utf-8?B?STdlc05tam1TNDdkeVJENS91N3Vpc1lTZjNqdEdDenBpV0dPVnVoOFdyNU5x?=
 =?utf-8?B?bE9ZTmtoS09STi8xTkdteGs4cUM5SS8wWUQwR3RST0hKYTZDbnU3WkFiTFdY?=
 =?utf-8?B?ZkVlc2t0V1E0UkdMRmV3VkdaS1BMdXVZREhEMGNjZWx5Zll5R29zZ2ZqNk5i?=
 =?utf-8?B?cHlMV3A4RDMveEl4YU1SQXQ0U01IVjlVVnBDb2NTTHpSc0Z2OU5pcnlnRmF3?=
 =?utf-8?B?SzNtc1JDUWwxZ2FMbW5Na1ErRHZ3ajRtSHE1aEdNdVJ6VXpzc0hlN2FXdEFE?=
 =?utf-8?B?U29tYjY5ZytNcVk4aG0rZ09zcmR5QXZWZnZhajZWSk0vdm1kalYyY2xVcy8z?=
 =?utf-8?B?WFBNa0JobWw2Mjdtc25yWk5SUHBCVjM1ekg3Um1CYjFyTkpRQmliYSswNWxZ?=
 =?utf-8?B?OWJmZ3VLMmVvbmNiZTZyZkRKNWRhYmFYYmt5VGpRWjJaQ0s0NnFRdm4zNmVh?=
 =?utf-8?B?UVgra05nY3NZeldtT0xyM3g0TGkrVFlSeG1CdXNidEs0Tk9vN0tKclFCdHVD?=
 =?utf-8?B?bWV4WG0xeDR1WnlQdFlMcUJVWjlUbnIyRTVKN0M2TUNkdWs2dXFQYjM3SDVK?=
 =?utf-8?B?UnlLOHVDM2d2cXkyc0czRTl4S0xJckFxemJCS1hTcnRINEFXTGdjK2RuaTN6?=
 =?utf-8?B?bGE5WFY1MmRNSDgyRG1WeHVsbkdZWUNBdk5KcTFIUzRYakVwbXJvdUJHYUhh?=
 =?utf-8?B?di9kL3VLUGVzVXE5V29USndjdktOcTVsckJLeVNhWFRtWnk4VlJXODIwaFVF?=
 =?utf-8?B?V0RGbW96L2Y3UTN2cW14K2NTVzF1MEIxc3loQkhyT2hIc0g4dUJDQnVPZzNC?=
 =?utf-8?B?MTdaR0tjY2hueXVhcDdyMXFqTVd2dTJnY0wzcVUxYldwK3F5ZjNVUFdxY1lJ?=
 =?utf-8?B?Sm1BcWNYdk1SK0RkdFJuQW1oTERDa1dYb1dTSnorc3ZXeDVCQ0ZnN1hoeVVa?=
 =?utf-8?B?dllxeHRBY0dxQWZWNjZpb2pld3cvNkhoQ0toa0lma0hGVTNwV0xERTM1cldM?=
 =?utf-8?B?YmRkNzU2ZzlQTWFOeUVVVUFDanBSUWlGY01tK2lKMi9KUkhma1J6d1JJZlVp?=
 =?utf-8?B?U3pxRjhYa3RoWXBBSERsMEJxRmtGRVdkdTFlTUlBZnR1MDA5OEtYOUJZR3FC?=
 =?utf-8?B?YWFZWFNYYjNrVnBkRFJJZG55cXlkWWxwc0trbzRCUDVTZVZFeDFjQ2x1ZExX?=
 =?utf-8?B?Ui8rcC9sSXdKS1h1UFJPSUJab3VtOVljbEE5TmRqY09rTGsxa2d2K1h3eG1o?=
 =?utf-8?B?b3Q2NGtadCtuS0pyS0pndk9aeXFrcnpXTTN0U2xlckNZOThtQnJ6VCt6ZzRs?=
 =?utf-8?B?ZGFwNndHcXZOYnNBOUR2aXpRUFAvcW5pU3lRS09vMkxpTmZYaHJLTjhlbm1z?=
 =?utf-8?B?TUtQYi80OUMxMjJwZDR5SGhhbklrdXlmaXdiNlF2a05qVi9lTk5WT3dWNEJ0?=
 =?utf-8?B?WHI4d3E1WW8zaTZVYjVsdlZ2UW4wU01Gem9XcnlPb05IVWNzL2Q3dFptRGEx?=
 =?utf-8?B?NEsxUUpaUUZVYnlBRDBlOXpTNGVKdWM1bkM2Ri96dDAxSVFURnRNdVRpd0I0?=
 =?utf-8?B?dWlPNFBxZ1F2MDZqWlhXS2hlUGZDS3FFZWJnSUR3cndzcXBGOVlWc1paaHBF?=
 =?utf-8?Q?xl9vwhjve1un9PQtW+SUjVjDEwU?=
X-Microsoft-Antispam-Message-Info: 6lBnqvg8jmVQw/wC8JXJV4E7hIarUvWl9eZj8baXvXXAmeVqzOPUNLygjto1POf2hxRprLxyES7TmUcm8h71Aq6hMmrxtAeXJnSqlQm7YaRYRRTLf5KOGOaWzm7nijp9bMcLrV5E5mTUWVNiy0x2zaGH4FyjJlF9ioNK8W+MydnN0sRHEn4Wq97U7j2Bnhj0
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:0pJZOsiAAp9828UXxrJCQtIfTNGxdGZoUOoXvWi4dlyABPCESV4KWYjE9nFCjkD4WoPAqKWIqN9RMjlNI+QOEVr16dLNkHpFngEL2d7XoSaP9uxgd5GF/3b0LlSMz4L/uCO89uk2iHdm1aelP2wMEtH0G6Sc5sBigUHvsRvf5WPoWzaRd3pMXFCdQU3GRF7fAhx1u1eK/tA3b4zza5j+sHU31V5yQL7flqjLzleeiCTvIEoxZyCRATURhwbgSn1vMqnwrC4IrXSjc/qbHHHzCAMs7SyWm3xwbYC/scYeXEYUYobn9dLPNSGf7UhcnBmNcxGn9CiKkhg+7gYna1J3kLDp1if3U6g7BOuc9gBU+h9FsYKPacQ0rWHai0t1PXi9GiVhpE4kghyYjO0Odjb+oDIWzH7tov8g3eRHWRl7hzjIFCVF8DeK9n9mTGWQKjlEdvjINnF97u1UjBga+uc/fA==;5:SwNyq/Kt5+oe6nWxuEtOeOrgFQEbMxyeTFa4q/AOkamSpfN4kbVIdc50KHa8ogjg3BAbWrEByo25mXrrmvaQtJ0OecH8sV4bm/x6AntiM58UUtHf8Vl5m4zd48997W5vhqI3nx39EQVrhEHTXcVFspGNcz8TSigT4qsBQRZ6a6g=;24:pFBkJ+6CXZBNAYHLYoLAdNjYbp0B9TrYQXhCBWvnacwaBtYx7niA6BMl01BVvWOUpibH0Mnbufg8rSJWcOzAhljtOV37iYZY6pjDYSg6j+I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:leo90LxpJ1+x1o7f0SoLZqNzqUSzWhOjsUMF81A9+I/Sa6xFI3H4WDHITvcMf5UASuFr88YZGm7NhmosQwntf5s9IGx4eZEeS3N7BXeBk5N1D7cOeALeDuEpLhk108HZ+3N0Ca00FNBc9CfqzxR8Xd7wlnNBUKYhcbRY5I/l6qhrdAnQFJPLP2+r01pwTZYcgaJJ5UWRigx9hkyGDSgfc2WfQj8G+EmADB97hja570kliB0tD8UO3G0G/VKYcF8R;20:F2UoaY1PVSTjy2y0aytsvWvBpGfdAH2U8Z8AXimZrWW1TKxn1FtphgMfN82/FTppoqlrPa6f2rhl+dOAAszxepJxNwxr4Tsc1HmRGRkz1OfN3Ciks0EKSG73TF0Jxy4EFHBDdKVWxBKJ8x5StBqEEJwPuk3cOxEKfOoagwQ1YE0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:29:54.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0915fb-9212-44e8-b09b-08d5932e6d6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553635124492604?=
X-GMAIL-MSGID: =?utf-8?q?1596014670621109823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 21:50, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:21:51PM +0300, Kirill Tkhai wrote:
>> The patch adds list_lru::shrk_id field, and populates
>> it by registered shrinker id.
>>
>> This will be used to set correct bit in memcg shrinkers
>> map by lru code in next patches, after there appeared
>> the first related to memcg element in list_lru.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  fs/super.c               |    5 +++++
>>  include/linux/list_lru.h |    1 +
>>  mm/list_lru.c            |    7 ++++++-
>>  mm/workingset.c          |    3 +++
>>  4 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 0660083427fa..1f3dc4eab409 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -521,6 +521,11 @@ struct super_block *sget_userns(struct file_system_type *type,
>>  	if (err) {
>>  		deactivate_locked_super(s);
>>  		s = ERR_PTR(err);
>> +	} else {
>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>> +		s->s_dentry_lru.shrk_id = s->s_shrink.id;
>> +		s->s_inode_lru.shrk_id = s->s_shrink.id;
>> +#endif
> 
> I don't really like the new member name. Let's call it shrink_id or
> shrinker_id, shall we?
> 
> Also, I think we'd better pass shrink_id to list_lru_init rather than
> setting it explicitly.

Ok, I'll think on this in v2.

Thanks,
Kirill
