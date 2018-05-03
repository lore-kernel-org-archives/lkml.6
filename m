Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqSFz+oaglX8/ZFbyY/jQhcOa8h+1yqruiNM4LKVAddu9o4rs2yyLjKvy1fdUF7+q0qjXXn
ARC-Seal: i=1; a=rsa-sha256; t=1525332782; cv=none;
        d=google.com; s=arc-20160816;
        b=spauhvfE+gzYNe+NP5UAjK+QP3OxF453wvLAYERsp8tGnk7BNXWHFTDaT8bTA68pRP
         hXbkTyAHnYDRduKNdUZRHfFig6E6NkgENwMzf/vWdefKz9f4MfrGc/3amzX1GH4/r1PO
         QqFKwwcVITYSMkBoSZp+JPXtHSn7V/W6H/lKHn+uBT99JrSax54VuK9/9dLr5WIBig1Z
         9Fnyc8wxGekBUogfqd//Yyaat44Ci7GrrXDITh48+6d3kSBIpOywPdy9RnS8Yq1122xt
         dcEJD2vTob/9z1V2Tbsr6m5SJDEWg7SDD28MK1Qdpje6iV0Dd6c9nSLgJBs+NPifJ0pR
         bODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=HrOwgpgfhjhBDOnCzkeGLIPhx5si4EhfmU2YDBxCWCM=;
        b=fN9m+1w9LK5ZjkJB1uMOD77x3DaqSFmyHfLmXf/LhOxblaLMW96jagga4hk++3nYyi
         XcC20BA9W04sf2CFYdkfQWbHU0qgaS1kxHgXq31VFuXymHScR58c96MteZHB+wkFjJ3O
         wyEAFJ0J9tTSp7G3DMDTQqFHN3EguRqqkI7ldEaXr2YxzB6MKIL+3wMTyeXJeIQA3n/J
         ncTbVxUQEsNdMdEoKdi+noLBpv3htY65dzayVi5dlk1N8nThEyoIV9H/xE+Fc+x5j1Hu
         9XkUoqlQfGo8LR0R8aN/wYywidTE4V36vK19SxIWB6OSchlupOuKAfk8EJ2pQijEFOeG
         5HzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=GC/5dYMr;
       spf=neutral (google.com: 104.47.37.54 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=GC/5dYMr;
       spf=neutral (google.com: 104.47.37.54 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH V3 10/10] ASoC: amd: dma driver changes for bt i2s
 instance
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 Akshu.Agrawal@amd.com, kuninori.morimoto.gx@renesas.com,
 alexander.deucher@amd.com, weiyongjun1@huawei.com, jclinton@chromium.org,
 linux@roeck-us.net, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omC=fZsFvSaxqFWEo0Pkj1Rcqhixy_oN7PWry9F0L_9c-Q@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <06a8f6f4-3bc0-656e-9c55-84f88727d6fb@amd.com>
Date: Thu, 3 May 2018 13:05:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omC=fZsFvSaxqFWEo0Pkj1Rcqhixy_oN7PWry9F0L_9c-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::32) To SN1PR12MB0318.namprd12.prod.outlook.com
 (2a01:111:e400:5146::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0318;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0318;3:srYYf6OcoWgrbSvAZ9wDU+y6BZpgYnRTzpX/73aIGJfDQIIxRXvVylulS0YhAe+T1NOTQprG28FAUU1odcVeUdLVvvPZcUJnj+O+pKgwN0pwdnVQPOEaxAbGl8qMIav4MV+50K1Opnv1+uWcME+2k/tdFzkZJCpwKaukkqH8Te/qZdgiMsmOcmIyMdfPoH4S+6HlUcQ06tL9TG/236pocPM9QdWZvFSIAomDyuAL5j7jXmTgB7wPa9FttZjkr0fU;25:ImQ5HzJgdWOLBaQsbVHzLgBzwfW++Jo7In+VbxLMHcsI1/6vPlq60JhfozgOLO6Hxe0JanrYZNRd02Ed8uf1/Wm3ydP+H0bngmnzf92OdUM8wup+JURp+dLwN4m2RUrhW0F8CV+17VOxWClY1PvaVQy0SteqGoPqF3RP/E3/ZCoWVKXda24mlkyjpsXAh0LW2vEIN8QSWwOXuk63RGWyk9zv4RRlkfqF/yak0a3uxLXrwmG93Y7q7SCySdSpkjNN1ov2U5TtODYF+mSdD5H51nIg6fJH7BOfLVvOdr8yvzWTR09P8UR3nYBY3kK+agsTBRQidDnLZsguiJJN618rBA==;31:TxJ9+R1SGsOXPBp3sijVZx7TMjU1TFj7tC3zMbdSa3dMGrglffcGVZuoUO4LTl0U5PU3OICfGybaeYgCIvDKEJharHe05aRhr0chx4h27yWzL/+9A6J0z6mkgM8NJNPWbPqA6xvOZl0UgokX2EzFzUVGpA6tsLOwSOIeuWpLPqMJ0h362E+V7zNwitjKZSaSWZSHO17pTOFsOoVhiL/GnmaFoUcQkCAngbheHWXQnb0=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0318:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0318;20:bZTJ71gHhNUoQbH0F29RPXE0G9Z0mth1ZH/D/m8Ye9I5mLVb3p8Wm8aGFCrwWbfFxN42W9HT61r8JheY3oDg1H/zay38PmBQrD9JXcGKhoTlCkfC+9Eayabrg166tWf6Xe0rOaUGfybF1Npe6owc5Gc91s/nj3YkHUjQ35t6lYmhPxo8AIGOe6ZuvD6RpdTUejKXCYFc+2FQeHtbulWYNM+LydJgRju2BWXbDyaKEY41c9ZTsnOJYJobv5f5DQbTBqe+xc+jBHJJZsGNobXkMpTUOLsbNsVzWtdnnbuwdR47XG3JE3729mQeVRZHOau1MY6ucMThXt37GjYJ4kb5r9AlCowuE/xP0cZy56HZ5dfWIHbEMoiWkhqnedBkzWtswzeq8WwND4XLpW96zAhm3/N0kIMWybSbzMrgS8TorTzKL6uTTNstJPi2EXGEyKCaGBBgilTmrdnXpUKvqXnZD7fbUl8abxcpls+JEGFoS2aEp8yi9BxL/RgZO7gPh7VW;4:L656w2fCh3nb3ze6pKLj1M7HLGZQtMv0izVfBPjoZLuaiMBc5h+zIS1D3XjhE4CFvUqI6xa+xWcnrQLHJ8IW5hxviG7DvxxIiN/CDkABHjlCVYHlUXtLecoVoASDs8mwUslNCh/QbZ8OgTh+5J1bWq1kT4trWKcLB/bJGOoRSmbyfTEZMKiW6UYX+zfsfDIwfht3cjlsTrq4RjldaKV3X1LMFnj7wPDy1NX4B0CjravdYl0AE8IcgGKPYM5klUaWLt9varO6t/BwoS9r7w2I4EXQp3uemoGwPFYx1U+DNoyA077B9gRlyEzLgtziwl/J
X-Microsoft-Antispam-PRVS: <SN1PR12MB0318309F4A939D974A93C69197870@SN1PR12MB0318.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0318;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0318;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(346002)(396003)(366004)(39380400002)(199004)(189003)(3846002)(39060400002)(97736004)(6486002)(53946003)(229853002)(47776003)(2906002)(305945005)(4326008)(66066001)(53936002)(25786009)(6916009)(6306002)(65806001)(478600001)(65956001)(966005)(6116002)(72206003)(50466002)(16526019)(105586002)(53546011)(5660300001)(575784001)(7736002)(386003)(7416002)(446003)(2616005)(86362001)(67846002)(77096007)(68736007)(31686004)(64126003)(59450400001)(8676002)(36756003)(230700001)(16576012)(23676004)(26005)(186003)(8936002)(486006)(956004)(106356001)(81166006)(58126008)(76176011)(316002)(31696002)(65826007)(52146003)(476003)(2486003)(11346002)(6246003)(81156014)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0318;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMzE4OzIzOnh4VDlPQzcrTUdGUXJ6b0tCaW5xSW9QbVNF?=
 =?utf-8?B?dkQ4ZXJtK3JvbWRDQmZVUzRWZjdCR3lNTmNTd0ZDUGhtTGVBZ2xKRS9uV00w?=
 =?utf-8?B?Wk9hNTM2VnZsUDljQ1BQeFl3bHBBdVZuTXhJLzRRdDhsSWNlbnc0Z3duWlhZ?=
 =?utf-8?B?eno3TjJjcWo2UGRVUXBwVnlmZHpVK1YrZWdEK3pGaGRIdTRqL0tFV21GcDJN?=
 =?utf-8?B?ZWpDRXdqTEREM0RRbmxrbFNxUm5tSlJza2hzTzZKbkZ3YUQrbWhnVFM3dTJr?=
 =?utf-8?B?cGRHY0VEWWhuZnZuN0k2N0pzNG5Wck9xcVI2RTBqRmtwRXNzYU1vWTdTOGVQ?=
 =?utf-8?B?WlVCUnlJV3RRdlhvdDc3MitTY1Fiald1em02Z1pQRTVXUXUyTnFpWEswNFk0?=
 =?utf-8?B?dXFFL1ErZ0hRcmtzSGZRaFFKekdNZnVGbHpoSWdFNzVlTjBFTEp5OER2UHhL?=
 =?utf-8?B?a3dmVitDZ3BqdXRQVVJlM25aRzE0Yk5mdkFkN0FQczNXT0pjVHp6Z3FNOXA3?=
 =?utf-8?B?STVMMGVIbDgxRklFWGJqUW5reUFXVmhER01GZVNZNVJqbmY3UUJxc3JENzZX?=
 =?utf-8?B?TExuODlnNnVuTjJaNHJRUEJvdWF0NXMwSWlwbmFpd0pjbnE0RW56bGdQZ2VE?=
 =?utf-8?B?VkJXb2xqVkx1N09kRUdWUGlYWmJobHphUGhsMm5XbGpxUVNoV0E0clczTWcx?=
 =?utf-8?B?S2JSUzFNOTdKWGtLYW5kdWdTOWpVQVkzckNDbDFyQzFkSC9TelBFTDJtMEha?=
 =?utf-8?B?cDhnbjVpZU5vTFJYNmFDSlA2QmVnWHgyVmtGUlBsNlArSW9CVkxUTHVhMVpJ?=
 =?utf-8?B?M0lmUG5ycms5YnJxYWduQVhuK2xUek5iMHQ3c1BkZHZTU2syNkxuTlBJeG5y?=
 =?utf-8?B?MUUzWng5UkdZNFJWS2YvSTZNNVJ2cDc1ZzN6SWdyTVBhSTZwRkgvL1gxZzJN?=
 =?utf-8?B?ZzluUWl6bHhUOXFISzVsSVNsNHF2ckRtY0lFRHhjMUoyRUN2Nk55WjBmc0Rs?=
 =?utf-8?B?M1VVak5jU1EzMVBCUllvM0Z0UHExZlJIcDhRU2x5Vk5tWU94S3VZS2Y4Y01j?=
 =?utf-8?B?MFRyMkEyRG4yUEpXRC9teFhTZk1qUjRnVzQ1UmpnMWp1c1pkcTJYVm1ZcE84?=
 =?utf-8?B?a3NTeWN2d2x5N2tZVGZYSmVrWm9aWk82VWFMR3I2RkNGZEdWTldVcXhkVDBr?=
 =?utf-8?B?QzU1Qmc1RnN3VHBxejN3eUdpMG5rekdXa0NQdkNsZnFLaEoyM1l1VnZkK1lh?=
 =?utf-8?B?OHdFVURBeXZwWi93SUhjcUFrc0FZYi9jSlM5Qy9pRitaTzV5eGovWkFYZTFu?=
 =?utf-8?B?dDNWVmpFeWlkcGJXbmc0aytGSVQ0aGtaNWNaMGNuTGlEQnpEQ3EvWXdMejlG?=
 =?utf-8?B?Qk1OVFYrbnY1WStlQUpYNkF2bXNMdDNxaHg4UVBBYk9jL01nNXpIaHYzZVR4?=
 =?utf-8?B?UDIzUlhLQytSdC9jNDFOT3ZyaXIrdCtUcUIwZnJnR3dGMGRKSEtXOUNGOXpr?=
 =?utf-8?B?TDB1RUQ2MEsva3ZBaElsdWVQWk5kbmQvaGRPdDYvZk5aWkZ4ZkZQRitrOE90?=
 =?utf-8?B?anNSazZwb2ljVEFMaUlzamd3aVVWT2pWOWlNZVhUS2hjM1Nlekl5UmVYWXcz?=
 =?utf-8?B?cnpRWGVXdXE4UW5BZ1MvaXJsN24xb3FlbzBXMVhRQTBHNERPOEF4eWhteHhu?=
 =?utf-8?B?NmVkNjFDejQ1OENwaFFiU05NaTBSVzRnSW0wS21oQXpDTmhLWlkyQi9YRUNU?=
 =?utf-8?B?c0Y1d2xOc3QxM2tQbW5YZWlhai83LzNsVWIyZFBUNVN4bzBMZm8xM1NDcjVE?=
 =?utf-8?B?eVhHZTJzaDRvbnl2NlF5Tkh3aFkxOWJQS1dLZFYxZHFhTjAvbmIwUmphTk5y?=
 =?utf-8?B?a0tmRFdFNW84MDRoUEpvUDloT3hZMjZUanFwS2xTT1JNVDZKdk5FQ2J0L1g0?=
 =?utf-8?B?M1Jsbk9RMXZWTTc1ODRla0duS3Jqdyt1ZlFLMi90S2h3Z1JUYWhaREMvWWUw?=
 =?utf-8?B?SzdNQmdXN20rYjNtM3hBWHJwU1VIdnFJRjFwSDdZRTQ0R1hRck5yVFBRS2xw?=
 =?utf-8?B?NnNZVGhVRFVPZ0JKVlFOT2lkZHBWRUFGaHlKYytxNnpMSUxyVlZyMksyM2c3?=
 =?utf-8?Q?ZQGBsT3s5vw3tInK/nemMd4rJmjsAozOu+ZHh4geRaCO?=
X-Microsoft-Antispam-Message-Info: FGImN43tl68ZL5iEC7DUt/o3TUZYwJGYO9SJgEjOizaC3MsNapCOTltwikYb1qTkbgMCPACVOZfEW+dAhe5XwD0E6NQ5oGCFSGnZDGAbQzmcLcznL2tvjnJovVs0f+BPRpsCMvH09GFYBvN6fo3jfsR3gxnpBpgS+CP/ooDkQ4pbVs2ME3XVM5E2FlEl4HT9
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0318;6:x81jJaCFG3CcKKGaXSFR9es48BeOwPgFibUMey07CigwM4P1i8pWS0H9ZultZz+4bUmoVoa654+SUfIOR6RhmTOGmhLBPX0K8GnjFfodmX9s6mH07uyuxzg/oWb7vdFp3m8GDpO/Cn/J0LsHKmILC0uRbLcH2qxQ4ydJXs43pIQArcudcpAbwvlTxE83q8HHYr2tQWcRAa721XsCu1sC6Sj64nlPcgWxZ/7oDa/n8d1GXN603DOZlH698k1NHXHlpJBPdJTtYMW29WNVHv8u4lyYUvTK2rYAEXqxoXEX5/HcMx/XmeESSaKJTaSCQUE7ZNy5OIk7x9y/j5cUGrlUwejIi4M6ohzLpgsXsujJlonvHhaSdwZiDkJZIY6ICacNhm6Zrsd8UYVMBUoac5jKOrRqJLfd0P1iynTVXS/WnebKJKla/NG3Qky9lZRJ0dXoaa3pCiuGP+BmjdCV86116Q==;5:vzuiu1FIak8yI+vrIpLQ7sQsA8oQnpTZFrp0xTgFN5+LWuCE2nuNhNgOveo4t843BJA8+jKNC+eyhksd52QqQJhxRsyW5oJCAPDezk2EYOxVLh+6H6yXE6qVe4uGW9EqIlT9VpCsZk2dcl5vrMelsy+MElLQ6mfRJekXjxEe//0=;24:Ut0BK4Q+5j3zlvgBp9QFRoqFmoxyopQU9nnYLZialH1/pRLWY/jIWoAQRtvf7b2GklNRJhX5EJGbft44Hcwp9a1zWSB9e3LbzGgIA2y/A3k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0318;7:5tT/Luwf7sQMrM8Wx7cNIYboqvkHONBpFLlCUZks8GYbaBfTb/Jp5vMf0rRrVXJbWg7Nwcsjg3ULvQvxLj7bVsxdFDM9dkLPQirvUBInHlHlonQ0ERiMXApzvTpo2M1SyLr0+JuR8gvqhbjzdNgcQJ2s03GGPGhBaRXogx3vFdrHm7YQO8Fn0k67N684vVUxBHB9M06OJZbBASo+ftY4Hst9vFE7k21xPKImi+L6+piy7MCXACq7VShNjQhnMiis;20:eKwyRN5cbZNluHZb30LdhnK9Epe+ze/zX/DYC/50inXYCP3Z5zc1348Zdogk2zKt6jN5PyMZeB8rHRLT226yzPekHHBCR677uaV7R2V/bQf4ZIqH4+u3PiELubX+HbKLFlbqsMTzlSl5PooJDEjJjOh3VfX1DyJgTo4CY7HMwvW3dVHkDuI4okA9lenCVNXAKahfOGI6FhHKw7563/DmMqpHMSS/NCdIxG+HpZiAfSRRReB0V2KZKKEiQA+m7Nqh
X-MS-Office365-Filtering-Correlation-Id: 3da24f18-4de3-47a1-6c07-08d5b0c8173c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 07:32:53.1482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da24f18-4de3-47a1-6c07-08d5b0c8173c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0318
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296505721371971?=
X-GMAIL-MSGID: =?utf-8?q?1599427347286701115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thursday 03 May 2018 11:13 AM, Daniel Kurtz wrote:
> Some checkpatch nits below...
> 
> On Tue, May 1, 2018 at 2:53 PM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> With in ACP, There are three I2S controllers can be
>> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
>> Default enabled I2S controller instance is I2S SP.
>> This patch provides required changes to support I2S BT
>> controller Instance.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>> v1->v2: defined i2s instance macros in acp header file
>> v2->v3: sqaushed previous patch series and spilt changes
>>            into multiple patches (acp dma driver code cleanup
>>            patches and bt i2s instance specific changes)
>>     sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
>>     sound/soc/amd/acp-pcm-dma.c          | 256
> +++++++++++++++++++++++++++--------
>>     sound/soc/amd/acp.h                  |  40 ++++++
>>     3 files changed, 262 insertions(+), 57 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> b/sound/soc/amd/acp-da7219-max98357a.c
>> index 133139d..b3184ab 100644
>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
>> @@ -36,6 +36,7 @@
>>     #include <linux/input.h>
>>     #include <linux/acpi.h>
> 
>> +#include "acp.h"
>>     #include "../codecs/da7219.h"
>>     #include "../codecs/da7219-aad.h"
> 
>> @@ -44,6 +45,7 @@
> 
>>     static struct snd_soc_jack cz_jack;
>>     static struct clk *da7219_dai_clk;
>> +extern int bt_pad_enable;
> 
> WARNING: externs should be avoided in .c files

We don't have .h file for machine driver and It can be ignored for
one variable.
> 
> 
>>     static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>>     {
>> @@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list
> constraints_channels = {
>>     static int cz_da7219_startup(struct snd_pcm_substream *substream)
>>     {
>>            struct snd_pcm_runtime *runtime = substream->runtime;
>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +       struct snd_soc_card *card = rtd->card;
>> +       struct acp_platform_info *machine =
> snd_soc_card_get_drvdata(card);
> 
>>            /*
>>             * On this platform for PCM device we support stereo
>> @@ -143,6 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream
> *substream)
>>            snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
>>                                       &constraints_rates);
> 
>> +       machine->i2s_instance = I2S_BT_INSTANCE;
> 
> I'm not a big fan of this approach, but I don't know any other way to tell
> a single "platform" driver (acp-pcm-dma) which of two channels (ST/BT) to
> use via the pcm_open() callback.
> 
> Mark, can you recommend any other way of doing this?

Hi Dan,

There have been couple of approaches worked upon this earlier.
1) To compare cpu dai name to get the I2S instance value in 
acp_dma_open() call.

But, Mark suggested not to implement this approach as we are comparing
dynamically generated cpu dai names.

2) We added i2s_instance parameter as platform data to dwc driver.
By querying dwc driver platform data in acp dma driver, current i2s 
instance was programmed in acp_dma_open ().

But Mark's latest comment was to implement platform specific changes in
machine driver. Machine driver and Dma driver should exchange the data
regarding this. We accepted this and current approach is based on the
same comment.
Below is the reference.
https://lkml.org/lkml/2018/4/18/597

-
Vijendar

> 
>>            return da7219_clk_enable(substream);
>>     }
> 
>> @@ -153,6 +159,11 @@ static void cz_da7219_shutdown(struct
> snd_pcm_substream *substream)
> 
>>     static int cz_max_startup(struct snd_pcm_substream *substream)
>>     {
>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +       struct snd_soc_card *card = rtd->card;
>> +       struct acp_platform_info *machine =
> snd_soc_card_get_drvdata(card);
>> +
>> +       machine->i2s_instance = I2S_SP_INSTANCE;
>>            return da7219_clk_enable(substream);
>>     }
> 
>> @@ -163,6 +174,11 @@ static void cz_max_shutdown(struct snd_pcm_substream
> *substream)
> 
>>     static int cz_dmic_startup(struct snd_pcm_substream *substream)
>>     {
>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +       struct snd_soc_card *card = rtd->card;
>> +       struct acp_platform_info *machine =
> snd_soc_card_get_drvdata(card);
>> +
>> +       machine->i2s_instance = I2S_SP_INSTANCE;
>>            return da7219_clk_enable(substream);
>>     }
> 
>> @@ -266,10 +282,16 @@ static int cz_probe(struct platform_device *pdev)
>>     {
>>            int ret;
>>            struct snd_soc_card *card;
>> +       struct acp_platform_info *machine;
> 
>> +       machine = devm_kzalloc(&pdev->dev, sizeof(struct
> acp_platform_info),
>> +                              GFP_KERNEL);
>> +       if (!machine)
>> +               return -ENOMEM;
>>            card = &cz_card;
>>            cz_card.dev = &pdev->dev;
>>            platform_set_drvdata(pdev, card);
>> +       snd_soc_card_set_drvdata(card, machine);
>>            ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
>>            if (ret) {
>>                    dev_err(&pdev->dev,
>> @@ -277,6 +299,7 @@ static int cz_probe(struct platform_device *pdev)
>>                                    cz_card.name, ret);
>>                    return ret;
>>            }
>> +       bt_pad_enable = device_property_read_bool(&pdev->dev,
> "bt-pad-enable");
>>            return 0;
>>     }
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index ec9cab3..2ea103a 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -37,12 +37,14 @@
>>     #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
>>     #define MIN_BUFFER MAX_BUFFER
> 
>> -#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
>> +#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
>>     #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
>>     #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE *
> PLAYBACK_MAX_NUM_PERIODS)
>>     #define ST_MIN_BUFFER ST_MAX_BUFFER
> 
>>     #define DRV_NAME "acp_audio_dma"
>> +bool bt_pad_enable = false;
> 
> ERROR: do not initialise globals to false

We will fix it.
> 
>> +EXPORT_SYMBOL(bt_pad_enable);
> 
>>     static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
>>            .info = SNDRV_PCM_INFO_INTERLEAVED |
>> @@ -357,6 +359,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
>>            case ACP_TO_I2S_DMA_CH_NUM:
>>            case ACP_TO_SYSRAM_CH_NUM:
>>            case I2S_TO_ACP_DMA_CH_NUM:
>> +       case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
>> +       case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
>> +       case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
>>                    dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
>>                    break;
>>            default:
>> @@ -519,6 +524,13 @@ static int acp_init(void __iomem *acp_mmio, u32
> asic_type)
>>            val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
>>            acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
> 
>> +       /* For BT instance change pins from UART to BT */
>> +       if (bt_pad_enable) {
>> +               val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
>> +               val |= ACP_BT_UART_PAD_SELECT_MASK;
>> +               acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
>> +       }
>> +
>>            /* initiailize Onion control DAGB register */
>>            acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
>>                          mmACP_AXI2DAGB_ONION_CNTL);
>> @@ -637,6 +649,24 @@ static irqreturn_t dma_irq_handler(int irq, void
> *arg)
>>                                  acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>>            }
> 
>> +       if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
>> +               valid_irq = true;
>> +               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
>> +                       PLAYBACK_START_DMA_DESCR_CH9)
>> +                       dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
>> +               else
>> +                       dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
>> +               config_acp_dma_channel(acp_mmio,
>> +                                      SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
>> +                                      dscr_idx, 1, 0);
>> +               acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
>> +                             false);
>> +               snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
>> +               acp_reg_write((intr_flag &
>> +                             BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) <<
> 16,
>> +                             acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>> +       }
>> +
>>            if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
>>                    valid_irq = true;
>>                    if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
>> @@ -659,6 +689,31 @@ static irqreturn_t dma_irq_handler(int irq, void
> *arg)
>>                                  acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>>            }
> 
>> +       if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
>> +               valid_irq = true;
>> +               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
>> +                       CAPTURE_START_DMA_DESCR_CH11)
>> +                       dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
>> +               else
>> +                       dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
>> +               config_acp_dma_channel(acp_mmio,
>> +                                      ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
>> +                                      dscr_idx, 1, 0);
>> +               acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
>> +                             false);
>> +               acp_reg_write((intr_flag &
>> +                             BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) <<
> 16,
>> +                             acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>> +       }
>> +
>> +       if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
>> +               valid_irq = true;
>> +               snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
>> +               acp_reg_write((intr_flag &
>> +                             BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) <<
> 16,
>> +                             acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>> +       }
>> +
>>            if (valid_irq)
>>                    return IRQ_HANDLED;
>>            else
>> @@ -714,11 +769,11 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>>             * This enablement is not required for another stream, if current
>>             * stream is not closed
>>             */
>> -       if (!intr_data->play_i2ssp_stream &&
> !intr_data->capture_i2ssp_stream)
>> +       if (!intr_data->play_i2ssp_stream &&
> !intr_data->capture_i2ssp_stream &&
>> +           !intr_data->play_i2sbt_stream &&
> !intr_data->capture_i2sbt_stream)
>>                    acp_reg_write(1, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
> 
>>            if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               intr_data->play_i2ssp_stream = substream;
>>                    /*
>>                     * For Stoney, Memory gating is disabled,i.e SRAM Banks
>>                     * won't be turned off. The default state for SRAM banks
> is ON.
>> @@ -730,7 +785,6 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>>                                                            bank, true);
>>                    }
>>            } else {
>> -               intr_data->capture_i2ssp_stream = substream;
>>                    if (intr_data->asic_type != CHIP_STONEY) {
>>                            for (bank = 5; bank <= 8; bank++)
> 
> acp_set_sram_bank_state(intr_data->acp_mmio,
>> @@ -754,6 +808,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream
> *substream,
>>            struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
> 
> DRV_NAME);
>>            struct audio_drv_data *adata = dev_get_drvdata(component->dev);
>> +       struct snd_soc_card *card = prtd->card;
>> +       struct acp_platform_info *pinfo = snd_soc_card_get_drvdata(card);
> 
>>            runtime = substream->runtime;
>>            rtd = runtime->private_data;
>> @@ -761,52 +817,109 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>            if (WARN_ON(!rtd))
>>                    return -EINVAL;
> 
>> +       rtd->i2s_instance = pinfo->i2s_instance;
>>            if (adata->asic_type == CHIP_STONEY) {
>>                    val = acp_reg_read(adata->acp_mmio,
>>                                       mmACP_I2S_16BIT_RESOLUTION_EN);
>> -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> -                       val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
>> -               else
>> -                       val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
>> +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +                       switch (rtd->i2s_instance) {
>> +                       case I2S_BT_INSTANCE:
>> +                               val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
>> +                               break;
>> +                       case I2S_SP_INSTANCE:
>> +                       default:
>> +                               val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
>> +                       }
>> +               } else {
>> +                       switch (rtd->i2s_instance) {
>> +                       case I2S_BT_INSTANCE:
>> +                               val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
>> +                               break;
>> +                       case I2S_SP_INSTANCE:
>> +                       default:
>> +                               val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
>> +                       }
>> +               }
>>                    acp_reg_write(val, adata->acp_mmio,
>>                                  mmACP_I2S_16BIT_RESOLUTION_EN);
>>            }
> 
>>            if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               switch (adata->asic_type) {
>> -               case CHIP_STONEY:
>> -                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
>> +               switch (rtd->i2s_instance) {
>> +               case I2S_BT_INSTANCE:
>> +                       rtd->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
>> +                       rtd->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
>> +                       rtd->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
>> +                       rtd->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
>> +                       rtd->destination = TO_BLUETOOTH;
>> +                       rtd->dma_dscr_idx_1 =
> PLAYBACK_START_DMA_DESCR_CH8;
>> +                       rtd->dma_dscr_idx_2 =
> PLAYBACK_START_DMA_DESCR_CH9;
>> +                       rtd->byte_cnt_high_reg_offset =
>> +
> mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
>> +                       rtd->byte_cnt_low_reg_offset =
>> +
> mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
>> +                       adata->play_i2sbt_stream = substream;
>>                            break;
>> +               case I2S_SP_INSTANCE:
>>                    default:
>> -                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +                       switch (adata->asic_type) {
>> +                       case CHIP_STONEY:
>> +                               rtd->pte_offset =
> ACP_ST_PLAYBACK_PTE_OFFSET;
>> +                               break;
>> +                       default:
>> +                               rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +                       }
>> +                       rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +                       rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +                       rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
>> +                       rtd->destination = TO_ACP_I2S_1;
>> +                       rtd->dma_dscr_idx_1 =
> PLAYBACK_START_DMA_DESCR_CH12;
>> +                       rtd->dma_dscr_idx_2 =
> PLAYBACK_START_DMA_DESCR_CH13;
>> +                       rtd->byte_cnt_high_reg_offset =
>> +                                       mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>> +                       rtd->byte_cnt_low_reg_offset =
>> +                                       mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>> +                       adata->play_i2ssp_stream = substream;
>>                    }
>> -               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> -               rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
>> -               rtd->destination = TO_ACP_I2S_1;
>> -               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>> -               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
>> -               rtd->byte_cnt_high_reg_offset =
>> -                               mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>> -               rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>>            } else {
>> -               switch (adata->asic_type) {
>> -               case CHIP_STONEY:
>> -                       rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
>> -                       rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
>> +               switch (rtd->i2s_instance) {
>> +               case I2S_BT_INSTANCE:
>> +                       rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
>> +                       rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
>> +                       rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
>> +                       rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
>> +                       rtd->destination = FROM_BLUETOOTH;
>> +                       rtd->dma_dscr_idx_1 =
> CAPTURE_START_DMA_DESCR_CH10;
>> +                       rtd->dma_dscr_idx_2 =
> CAPTURE_START_DMA_DESCR_CH11;
>> +                       rtd->byte_cnt_high_reg_offset =
>> +
> mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
>> +                       rtd->byte_cnt_low_reg_offset =
>> +                                       mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
>> +                       adata->capture_i2sbt_stream = substream;
>>                            break;
>> +               case I2S_SP_INSTANCE:
>>                    default:
>>                            rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> -                       rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
>> +                       rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
>> +                       rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
>> +                       switch (adata->asic_type) {
>> +                       case CHIP_STONEY:
>> +                               rtd->pte_offset =
> ACP_ST_CAPTURE_PTE_OFFSET;
>> +                               rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
>> +                               break;
>> +                       default:
>> +                               rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +                               rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
>> +                       }
>> +                       rtd->destination = FROM_ACP_I2S_1;
>> +                       rtd->dma_dscr_idx_1 =
> CAPTURE_START_DMA_DESCR_CH14;
>> +                       rtd->dma_dscr_idx_2 =
> CAPTURE_START_DMA_DESCR_CH15;
>> +                       rtd->byte_cnt_high_reg_offset =
>> +                                       mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
>> +                       rtd->byte_cnt_low_reg_offset =
>> +                                       mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
>> +                       adata->capture_i2ssp_stream = substream;
>>                    }
>> -               rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
>> -               rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
>> -               rtd->destination = FROM_ACP_I2S_1;
>> -               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
>> -               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
>> -               rtd->byte_cnt_high_reg_offset =
>> -                               mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
>> -               rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
>>            }
> 
>>            size = params_buffer_bytes(params);
>> @@ -999,24 +1112,39 @@ static int acp_dma_close(struct snd_pcm_substream
> *substream)
>>            struct audio_drv_data *adata = dev_get_drvdata(component->dev);
> 
>>            if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               adata->play_i2ssp_stream = NULL;
>> -               /*
>> -                * For Stoney, Memory gating is disabled,i.e SRAM Banks
>> -                * won't be turned off. The default state for SRAM banks
> is ON.
>> -                * Setting SRAM bank state code skipped for STONEY
> platform.
>> -                * added condition checks for Carrizo platform only
>> -                */
>> -               if (adata->asic_type != CHIP_STONEY) {
>> -                       for (bank = 1; bank <= 4; bank++)
>> -                               acp_set_sram_bank_state(adata->acp_mmio,
> bank,
>> -                                                       false);
>> +               switch (rtd->i2s_instance) {
>> +               case I2S_BT_INSTANCE:
>> +                       adata->play_i2sbt_stream = NULL;
>> +                       break;
>> +               case I2S_SP_INSTANCE:
>> +               default:
>> +                       adata->play_i2ssp_stream = NULL;
>> +                       /*
>> +                        * For Stoney, Memory gating is disabled,i.e SRAM
> Banks
>> +                        * won't be turned off. The default state for
> SRAM banks
>> +                        * is ON.Setting SRAM bank state code skipped for
> STONEY
>> +                        * platform. Added condition checks for Carrizo
> platform
>> +                        * only.
>> +                        */
>> +                       if (adata->asic_type != CHIP_STONEY) {
>> +                               for (bank = 1; bank <= 4; bank++)
>> +
> acp_set_sram_bank_state(adata->acp_mmio,
>> +                                                               bank,
> false);
>> +                       }
>>                    }
>>            } else  {
>> -               adata->capture_i2ssp_stream = NULL;
>> -               if (adata->asic_type != CHIP_STONEY) {
>> -                       for (bank = 5; bank <= 8; bank++)
>> -                               acp_set_sram_bank_state(adata->acp_mmio,
> bank,
>> -                                                       false);
>> +               switch (rtd->i2s_instance) {
>> +               case I2S_BT_INSTANCE:
>> +                       adata->capture_i2sbt_stream = NULL;
>> +                       break;
>> +               case I2S_SP_INSTANCE:
>> +               default:
>> +                       adata->capture_i2ssp_stream = NULL;
>> +                       if (adata->asic_type != CHIP_STONEY) {
>> +                               for (bank = 5; bank <= 8; bank++)
>> +
> acp_set_sram_bank_state(adata->acp_mmio,
>> +                                                               bank,
> false);
>> +                       }
>>                    }
>>            }
> 
>> @@ -1024,7 +1152,8 @@ static int acp_dma_close(struct snd_pcm_substream
> *substream)
>>             * Disable ACP irq, when the current stream is being closed and
>>             * another stream is also not active.
>>             */
>> -       if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
>> +       if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
>> +           !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
>>                    acp_reg_write(0, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
>>            kfree(rtd);
>>            return 0;
>> @@ -1078,6 +1207,8 @@ static int acp_audio_probe(struct platform_device
> *pdev)
> 
>>            audio_drv_data->play_i2ssp_stream = NULL;
>>            audio_drv_data->capture_i2ssp_stream = NULL;
>> +       audio_drv_data->play_i2sbt_stream = NULL;
>> +       audio_drv_data->capture_i2sbt_stream = NULL;
> 
>>            audio_drv_data->asic_type =  *pdata;
> 
>> @@ -1134,6 +1265,7 @@ static int acp_pcm_resume(struct device *dev)
>>     {
>>            u16 bank;
>>            int status;
>> +       struct audio_substream_data *rtd;
>>            struct audio_drv_data *adata = dev_get_drvdata(dev);
> 
>>            status = acp_init(adata->acp_mmio, adata->asic_type);
>> @@ -1153,9 +1285,8 @@ static int acp_pcm_resume(struct device *dev)
>>                                    acp_set_sram_bank_state(adata->acp_mmio,
> bank,
>>                                                            true);
>>                    }
>> -               config_acp_dma(adata->acp_mmio,
>> -
>     adata->play_i2ssp_stream->runtime->private_data,
>> -                              adata->asic_type);
>> +               rtd = adata->play_i2ssp_stream->runtime->private_data;
>> +               config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
>>            }
>>            if (adata->capture_i2ssp_stream &&
>>                adata->capture_i2ssp_stream->runtime) {
>> @@ -1164,9 +1295,20 @@ static int acp_pcm_resume(struct device *dev)
>>                                    acp_set_sram_bank_state(adata->acp_mmio,
> bank,
>>                                                            true);
>>                    }
>> -               config_acp_dma(adata->acp_mmio,
>> -
>     adata->capture_i2ssp_stream->runtime->private_data,
>> -                              adata->asic_type);
>> +               rtd =  adata->capture_i2ssp_stream->runtime->private_data;
>> +               config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
>> +       }
>> +       if (adata->asic_type != CHIP_CARRIZO) {
>> +               if (adata->play_i2sbt_stream &&
>> +                   adata->play_i2sbt_stream->runtime) {
>> +                       rtd =
> adata->play_i2sbt_stream->runtime->private_data;
>> +                       config_acp_dma(adata->acp_mmio, rtd,
> adata->asic_type);
>> +               }
>> +               if (adata->capture_i2sbt_stream &&
>> +                   adata->capture_i2sbt_stream->runtime) {
>> +                       rtd =
> adata->capture_i2sbt_stream->runtime->private_data;
> 
> WARNING: line over 80 characters
> 
> 
>> +                       config_acp_dma(adata->acp_mmio, rtd,
> adata->asic_type);
>> +               }
>>            }
>>            acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
>>            return 0;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 62695ed..9cd3e96 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -13,6 +13,8 @@
>>     /* Playback and Capture Offset for Stoney */
>>     #define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
>>     #define ACP_ST_CAPTURE_PTE_OFFSET      0x00
>> +#define ACP_ST_BT_PLAYBACK_PTE_OFFSET  0x08
>> +#define ACP_ST_BT_CAPTURE_PTE_OFFSET   0x0c
> 
>>     #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>>     #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4
>> @@ -46,8 +48,13 @@
> 
>>     #define TO_ACP_I2S_1   0x2
>>     #define TO_ACP_I2S_2   0x4
>> +#define TO_BLUETOOTH   0x3
>>     #define FROM_ACP_I2S_1 0xa
>>     #define FROM_ACP_I2S_2 0xb
>> +#define FROM_BLUETOOTH 0xb
>> +
>> +#define I2S_SP_INSTANCE                 0x01
>> +#define I2S_BT_INSTANCE                 0x02
> 
>>     #define ACP_TILE_ON_MASK                0x03
>>     #define ACP_TILE_OFF_MASK               0x02
>> @@ -68,6 +75,14 @@
>>     #define ACP_TO_SYSRAM_CH_NUM 14
>>     #define I2S_TO_ACP_DMA_CH_NUM 15
> 
>> +/* Playback DMA Channels for I2S BT instance */
>> +#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
>> +#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
>> +
>> +/* Capture DMA Channels for I2S BT Instance */
>> +#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
>> +#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
>> +
>>     #define NUM_DSCRS_PER_CHANNEL 2
> 
>>     #define PLAYBACK_START_DMA_DESCR_CH12 0
>> @@ -80,9 +95,23 @@
>>     #define CAPTURE_START_DMA_DESCR_CH15 6
>>     #define CAPTURE_END_DMA_DESCR_CH15 7
> 
>> +/* I2S BT Instance DMA Descriptors */
>> +#define PLAYBACK_START_DMA_DESCR_CH8 8
>> +#define PLAYBACK_END_DMA_DESCR_CH8 9
>> +#define PLAYBACK_START_DMA_DESCR_CH9 10
>> +#define PLAYBACK_END_DMA_DESCR_CH9 11
>> +
>> +#define CAPTURE_START_DMA_DESCR_CH10 12
>> +#define CAPTURE_END_DMA_DESCR_CH10 13
>> +#define CAPTURE_START_DMA_DESCR_CH11 14
>> +#define CAPTURE_END_DMA_DESCR_CH11 15
>> +
>>     #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
>>     #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
>>     #define ACP_I2S_SP_16BIT_RESOLUTION_EN 0x02
>> +#define ACP_I2S_BT_16BIT_RESOLUTION_EN 0x04
>> +#define ACP_BT_UART_PAD_SELECT_MASK    0x1
>> +
>>     enum acp_dma_priority_level {
>>            /* 0x0 Specifies the DMA channel is given normal priority */
>>            ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
>> @@ -95,6 +124,7 @@ struct audio_substream_data {
>>            struct page *pg;
>>            unsigned int order;
>>            u16 num_of_pages;
>> +       u16 i2s_instance;
>>            u16 direction;
>>            u16 ch1;
>>            u16 ch2;
>> @@ -113,10 +143,20 @@ struct audio_substream_data {
>>     struct audio_drv_data {
>>            struct snd_pcm_substream *play_i2ssp_stream;
>>            struct snd_pcm_substream *capture_i2ssp_stream;
>> +       struct snd_pcm_substream *play_i2sbt_stream;
>> +       struct snd_pcm_substream *capture_i2sbt_stream;
>>            void __iomem *acp_mmio;
>>            u32 asic_type;
>>     };
> 
>> +/*
>> + * this structure used for platform data transfer between machine driver
>> + * and dma driver
>> + */
>> +struct acp_platform_info {
>> +       u16 i2s_instance;
>> +};
>> +
>>     union acp_dma_count {
>>            struct {
>>            u32 low;
>> --
>> 2.7.4
