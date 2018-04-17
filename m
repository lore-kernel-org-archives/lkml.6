Return-Path: <Christian.Koenig@amd.com>
X-Google-Smtp-Source: AIpwx48e7SzkbmrP8K+KFKVS0eHLSbUV051Eh+i7D4kH36AOUYUerZtbLeNpM7mwd8+2+jBMmcLn
ARC-Seal: i=1; a=rsa-sha256; t=1523954902; cv=none;
        d=google.com; s=arc-20160816;
        b=Uh1ig6uRxBu0QLss/oliq03o1F3T5Feur4zZOdClvsEvmsLURYYAEsb67FaYwcHXze
         NiCRdgw16HjU9PbeKkWua9UNU4YjNKqTTuW0xV78NGFZj+eQnypwQoHRM4gLdva6RrzZ
         gnIl/OS6fZH4C/irnoLySJ9NIJdYxl3H5ob22T+g2C4mFMxPbOmilvnhweWuBbmK3lSr
         6sr5YBRIuW4yUm3+yhuRfpvqiGrdf9/h7Sez4UuZs51Z3mEDE0HeBz5e4YxUIc2zToyg
         zOq90Gp2rTWi1g+m1QFjPYWOSmOfoKGHSJTKu+GhisD3m5uXNHoVKdvw8WgSIDuN00kP
         P50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=kunT2N2Y6JpPP6uLBEnlqG/pEVLV4VvCM16NOO7AsMk=;
        b=HWZp2f5Fwp7fn+2CkPIKtDwapHTrrIr2aFvlF0NG2wBomwslso+8hisuYgt3jPoXta
         stV4LR8kLwHVmqL9+TCXa3GX763QDWmUgzafjUrNnPkhR6P5BFe6RQacGLP+2OWbmrYb
         7Mx6Gh/Onu6usldGQLp0vzUN2s4B8/JwWzXOc0A8Ry0oh5MGF1Zi/MbkUT8AzsiKdE7j
         Z3QuJMppcXn2Np2qxcNmYbFVFHiuImGrk954zcBki/Isuk2ZiA5ybUxIHP/BSznmWeC0
         2iNGMJyg53V3JX8HQArGPWzDNP1VebUUkjECY1UsLKjxgAnY+HC9egIUtlDPYwng+35X
         MDAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Yr1hiRRq;
       spf=neutral (google.com: 104.47.33.54 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Yr1hiRRq;
       spf=neutral (google.com: 104.47.33.54 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 6/8] drm/amdgpu: use firmware_request_nowarn to load
 firmware
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 kvalo@codeaurora.org, arend.vanspriel@broadcom.com
References: <20180416222427.29683-1-andresx7@gmail.com>
 <20180416222427.29683-7-andresx7@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2c27b97a-5cb7-92c3-d4d8-a9d274a2f1cf@amd.com>
Date: Tue, 17 Apr 2018 10:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416222427.29683-7-andresx7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR02CA0105.eurprd02.prod.outlook.com
 (2603:10a6:7:29::34) To BN6PR12MB1716.namprd12.prod.outlook.com
 (2603:10b6:404:106::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1716;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;3:BeADlt2D6OWkcK3eeTVYczR8eeELY5QC8hynPf8hPl4W4dujD3FkoQefnP9JLcyXhbfjtCrJL6BacJlGftVkNqJQL7JqCebHP8vq1HYxwe9oedVoioLdGR3lanOcJZsi0+27ZcCabERdyZ/C3a9N2qseyjC3m803BknZKgREcqWQKcOqaWA5AN1tKEgyIqO7fONAgk/MTdbqqmWZ/oPn6l+MVVRC0b41dsyS4sBz23Fda/xB466b7qcue3MRba8d;25:0GFmHiMfSkq0glF5kjpDobE3NKTN8+AihJZWFPoyyPCSyh8h/buGkOmE+9YAJMtPmCn2jlbarX/O2L/k97WXbSbsz6OR+LvkzJfIBw1aad3VBSY5c5VhwQuXky02sRT3bUgzm66rRnozgRBN46ir9G+V6OnhCJp2IIjYMhUGR4r4GUw9MASbEtz4BI3jkJFvS5jFgIq62ycAxm0V5bDHl5MNWUEIrJet0mpxSPlVu/4TRb+1P2APOqMwsvKCCD5vUI4CvBkaiK5muIdz0ppXjhzbx3DqbOXZ6nN8I1sS1gUTN46p07OIN4z8bn44OVNavT87Dc8xFlrvfzo9gPFGEg==;31:lsKYnlkCvnbN9Prju9qyHONKz0gATsjSEaJlr0meJ6m3KaZnIMIpXAHxErQKHJ/GTcD75IEp77cR246OcCJQy8W0f7EkGzpwWSVZM7R9nVc0d67ZgQ1FliMox0dfXLyHNBEXgFXPw5nWkej/XO8ih2TS17VlpJ4PXMvaDmhua81SfMnmy5gH4tPRI9IOwxGzfzxSKeiloc1neKTHmOpVE+ZIBG+KxaGJ7ClMmUZPHAM=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1716:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;20:h7/Yc8E6LAlhRs6ueoAC64e2jaVAmWMaUy4jl3ZfrNlWQA65QNYpRn234Q+Xr6CIx4PfZlfxUEhl57MHPMTn55fS2jMTMvuqW9EO8H3Rh1E9jZ7PVB0nUa88edhRRsqDyrZttzFOTUxy5etysZ8PrArnpFqqDYDf7BtVqJVvhXY2cWQXYO0OvOe8NE1ES/kPmsS3eez80XEx5XZcfApAHEY2bPEIqxaoezLP8I9Vnm+DHoKN/HFrfuBI9U42b3yHVM+BABHdWBbm6hZZDwkkSSQemf5aUf7Kw6WEBTMWL8klffqY4Lg97JxcsqM2brwEOs85ULFSC8vCcK74D6WAMTI/vE333T15uJRsiMQd2N2H3M0ShhW3EgWPNAK7B5MwDa941OXK0vx/ZS+sHFJdzlfw54PSW+OIVjR8/l+7CXV9HKSm5lfW1JAzv16mAQaI1rRRKiiL3NHzP5O+fQ9Irs1ZmAH/VGk/VtMHkjT/s+XpNFLGRMhN1iyfEzGBeIwp;4:cRwewN3XqlXsNMKpmS3fUiUHzXEA2NvGirQ0pZSyx8u9HH+KujxEP2N8sVzZfIph2rxs/vesYhKPat5m28YWHxXwyB2cO2A4Q4qnT2og077wgl+n9zH3wnJb2gIS821oxO99RH1PKol4w0fBOCBHDhTZyq1598OEQTL2fDqTafoznm/EXvm2WuHBk5GKjE4Jrrlpi+0Wgtdp9oNPacClsvKvqIFKbeuXWhoyezTsSvfnkwj28XA7k30scft5gX1PpvMsAoc/FMiLLa+CjSL7KnQn7PodOtI52ib6pOX74BqbeB7OHeIaVZBgmQZyeAXg
X-Microsoft-Antispam-PRVS: <BN6PR12MB1716A0C35B85FE3D842850A083B70@BN6PR12MB1716.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR12MB1716;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1716;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(189003)(199004)(50466002)(46003)(64126003)(68736007)(4326008)(305945005)(106356001)(7736002)(316002)(58126008)(11346002)(65826007)(446003)(6666003)(6486002)(229853002)(105586002)(486006)(2616005)(476003)(5660300001)(31686004)(2486003)(8676002)(65806001)(65956001)(47776003)(52116002)(81166006)(52396003)(52146003)(23676004)(86362001)(575784001)(81156014)(2906002)(76176011)(478600001)(230700001)(186003)(67846002)(72206003)(8936002)(97736004)(25786009)(53936002)(6246003)(36756003)(16526019)(39060400002)(6116002)(386003)(1706002)(59450400001)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1716;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE2OzIzOkcvNWtiTzJ2bTltRDA2VDFVWEw3RFpNYVZr?=
 =?utf-8?B?bkE0ZjRyTFNiRjNBaDd6SFBsVXIvSmx3bWhQQzlkcUpsL2dYNmtqRFB0VzMy?=
 =?utf-8?B?N2pacDlPYUNqTUVVZGJ2SXFadEtJcEZHNWkzcDhKazYvalpnZnR5SUlPcERa?=
 =?utf-8?B?RVNFVlVBK3U3ZXpTZkVMQXZBaXJoVFE1ODd0OVVrcFdhaFdmcFlBMlZvVXdu?=
 =?utf-8?B?UjY3ZWFsM0ZvTW42NThlTVJML3g1YXBmb3VSVzhod1JNMytyL1NMRm4yc253?=
 =?utf-8?B?WFljS0Z1R3BqeEdyZXNvSlR6b2orRHFHdW1tdTNHOFJ3ZlZNeEwzSmhnaENQ?=
 =?utf-8?B?ckcwQy9vSUlySXlEekp2d29lUWFYUkNBWXk5SWRBbkEzQVBrNGcwb2RaODNL?=
 =?utf-8?B?eFdCRWpMd1NGMEs0enVvbzZsd3NnVjZpMmZad3JkZkNwY20vd0xDOGd1aGs2?=
 =?utf-8?B?dXpkRDJBWTRPekNxZ05TZ1BnaDFpdXErM0QwcDYxNUZ1L3hZclBmYWtybWor?=
 =?utf-8?B?Rk92RXFvSk14N2VUVnUzT0tidmZLMHV6VVA2bzBRaUV2eFNiSVpnZ1YvSjdK?=
 =?utf-8?B?MnE4am9LRkwzU1MvNFVhV1lIcml1LzFSSnlhOWVPNWw3dzg0UkNqZU1tS2U1?=
 =?utf-8?B?MDNYazVyYTBURWVOd291QXYzTlN0YmNEWnVLeGNuRlpnd01CUUV6UEI4T25l?=
 =?utf-8?B?dWhhcW1CNDBrU1ZRaDBYOXJnRHRDQ3Q2cTd1YVB5L3VCSC83R1ZJT1k3Q0J6?=
 =?utf-8?B?UlhqWlZjeW5yUGVMdVJuSlZwanBGdkZwY1VTeE1yaEtKcDd2MEhyVTJwLzVh?=
 =?utf-8?B?M1FJcWIyUU5keUhXYjdtdW1tNDRqM1VEWGlrU0dkQVJpaXBvSktQSmNYNnE5?=
 =?utf-8?B?NmtjWG4xWU9CbjBGc0pEMm5vNEVHbnRzczlxdkNqZWNPMkM2MzVjVlpZZG0x?=
 =?utf-8?B?WmpJOTZKVFF2R005V1NqZDRnSHFuZVgxYjBRUm9IMTFyOGxPUXJKRmxqdER2?=
 =?utf-8?B?OEZwUjQ4bWhUejJkaDN0ZU1PV3FBQUdjdTltelRPaVBQZU9kR0dGRTAyTGU2?=
 =?utf-8?B?VzNNaTB6V0VvVWhyaThBSzhRYkQwNnFIb3Y3SDNtU2pPNHVYNWpHOGNCY3JR?=
 =?utf-8?B?UU5nTDBqc2g5MEtHcjFlQk05TlR2eUtUaldMcUt3cWdJeHlubCtXNWtiTjND?=
 =?utf-8?B?NXNJQlkwTEljSjBuL1JzcGQ1WHVtcy9uUGNsejFKcE1UTVMvbmZDWVcxZXRF?=
 =?utf-8?B?R29iK1huZFpxR0RuRVB3WXdsaFh0QXJHT0FMZHhYMldqOGtOc0w1UWJlNXlJ?=
 =?utf-8?B?VGNCeHpLcyt3aDcwS1R4VDdKekF3cW5Xa3Zza2luUUJiUVRPT1hOd05qL29P?=
 =?utf-8?B?SHRpRjRUdEVsemllQndDNEFkcWZzSjF3V0dFME4rdkp1MWpQN2l1Uk5ad3p5?=
 =?utf-8?B?N1FsSVFLWHB4UVo1YXYwUStvNHphcnkyNE4vM1JSU0o5OC83QTFRcTROaWQ5?=
 =?utf-8?B?Y0Y5Y3o2RkNPUzdmaVJkcEZZQkdDVllvOFZjVFEyeVZQUU1jNkt3UytweGhk?=
 =?utf-8?B?Nm9aNmIyaHNDdEhQZThUVjZQdjNoc1dUYmliTjRwM2tkbzYyWDNoNU51NDFq?=
 =?utf-8?B?bG9nOEhhdGtBclBhVDFxUUJiL2NybG01SmRMYlFQR294aWhYYW0zWmU5U29m?=
 =?utf-8?B?VVcxNXZuK2NhUGZ4QUtHN3FJTHlRYnBTY1lJcWRXRTUvNkZLcENJZWg2U1o3?=
 =?utf-8?B?RTVJeUtpQmE3S2ZzeVZHK1dzZUFZcW9LZWsxVHZZaWpHNnR0a3NKK1RVc0tK?=
 =?utf-8?B?UzFnYldCMHhtdDZxRHR4QTFBUUQzbUlvY1JaQ0VTSG5ETTdvN3hLUnJmM1R3?=
 =?utf-8?B?T0V0VXdMSVl3MTBiMDJIaVFpQi9Bb2ZWR0phblZmT0NtRTdmbUo0dkV3Vmxh?=
 =?utf-8?B?Mi9UOGJCKy9nPT0=?=
X-Microsoft-Antispam-Message-Info: 52whO0lVq3GvNKf2Grg/tsZJgoLQzxKbvbUuJsG3JKGgIuHrxkGYWGoIvCInUOXCfKpcIlrC5uJybf5KV7TvFaDaxU71IKmPpU3j5Fil1k8aWZJXsD30x56dV7G6HdJg+FjvtPLgEXDFWzI1Yzgz6WIsqJk3JhfH6NXXZK2BqNqVObmoFP52RA4pM7As8pVH
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;6:ba68zKCiA8+M+dghl+MFV1tgSBSuqL18ijZMqqQkAG3r83jbjbypVOYQAOcgY7Rb7UgXlzqO8ddq1JwLxeHqJS4/LBh0Fs4Aw8NowN6/aj5a7HoY8wx0ZJLr2Ch9y2HyY0zs2oq9RuO7TeYilc4XneoFhvTyUH2Nz0+/41acgsoloXHsQJJxWmnaRvFrvJ1LgMinsOCF9BgrzoezeaE87M/8FuWvzq5WFrsYgmPrSrTnRy9wM9yHlWVZoqLNeJX1XjM5P+j9ZEf3JCtH8f8gCLpYKi4dSHra0F7lbuJKlPlkTVJX1ddg1UE7gTvkCF7gTYOKj5j5354Kr2gxPARFWf3kiLjbqGzi5KHqrT5e67aeGxM3cCTKekIJ12trFKp+DNYFDTPYYGMGTV9Sc0gvIen+Cr/6dnNpqAET0FqVMscB5M5cc5aQKtD04WQ3RELdvBkzjkx3aSvtrPO4w0wI4g==;5:OVGlBzO0l/P4G/vnLRjteSgPjxDPP0BKvQpHq61UuU9LbryfKRXemOl/Rf1AOk1d5yr+WPvZ+IWKCGOaQeqVUbbRomWPPhpy3eZRpuqLmZJRYvgPlmJkyqhUSW1gvKMOKDPIcjYUyLKaV9ZZ6nGAQbOOy2HDTqsBy3IZ4L7O5N4=;24:OQHJiMrAoJ28F+nZuHUhSl95Ax7/o0e1qtjYZvcNTOtg/5lJY+auecBIIIUOXEKSvc/UswG2Of0u2pNkBzo3XFKNB++Bm3vQbPrAddKOOn4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;7:sDB1VKWTCiN9P0Oa3zkZ0fdGNrTNAzvVYqUJVbQMq9ssLEouhX4ahWIQzD2qctoXSBEzQfJD65N5gwnmMgRMvKkwIj1/Zpdzd+9FO681xMJ6eGf1tjb8eaDiSwMV4pASbZOTalgXW3yyT/spYSU3SR++9JAczflGR0TqUXHRCvlThe6fomAyN6qjZgiDni6RdNKa59EfObh2ytvGf/q87MHsMazG1v6Bgxh48UB+yTg/ZjSdQ30IahGs4k0kw2Q8;20:M48BOVafUduVKZu3hv7ohVCZfU9Wa/IQXj+zkbe2o1eTM/Kk3Rp3ZRHry8BVXPfHZAVGiY6UHyW3xWSz3ACWcL8dzWA/DpKgSKOk5cqyYVkQCOPkXrgPxno259+bMP9UwNak0ifmhyeaS4uj1FFG+eBioLs6uyAHEFDllFDsFvzGLTBr7iTG+owEVYK5S3QQGUFm8t65YU5LSxtFJDqYVeCYcfR15fMM62oCyaCIaenDLw0zE6thn9YvbH/vaKmR
X-MS-Office365-Filtering-Correlation-Id: 2c094da1-7ee2-4354-70b6-08d5a43ff81f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 08:48:17.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c094da1-7ee2-4354-70b6-08d5a43ff81f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943307609478014?=
X-GMAIL-MSGID: =?utf-8?q?1597982535597635414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Well this is a rather big NAK for this patch.

Only a small fraction of the firmware files amdgpu uses are actually 
optional (the ones with the *_2.bin name). All other files are mandatory 
for correct driver operation.

There is a fallback when actually no firmware files at all are found, in 
this case we at least try to get a picture on the screen so that the 
user gets a hint on what is wrong. But this path isn't tested well and 
breaks from time to time.

So when you get a message like "Direct firmware load for * failed with 
error -2" even if it's one of the "*_2.bin" files that is a clear hint 
that you should update your firmware package.

Regards,
Christian.

Am 17.04.2018 um 00:24 schrieb Andres Rodriguez:
> Currently, during the normal boot process the amdgpu driver will produce
> spew like the following in dmesg:
> Direct firmware load for amdgpu/polaris10_mec_2.bin failed with error -2
>
> This happens when amdgpu tries to load optional firmware files. So the
> error does not affect the startup sequence.
>
> This patch switches the amdgpu to use firmware_request_nowarn(), which
> will not produce the warnings mentioned above. Hopefully resulting in a
> cleaner bootup log.
>
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 12 +++++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 32 +++++++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 12 +++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  2 +-
>   21 files changed, 51 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> index 4466f3535e2d..6c950811c0a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -811,7 +811,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
>   				return -EINVAL;
>   			}
>   
> -			err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>   			if (err) {
>   				DRM_ERROR("Failed to request firmware\n");
>   				return err;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index af1b879a9ee9..d6225619e69f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -696,7 +696,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   		if (adev->asic_type == CHIP_FIJI) {
>   			int err;
>   			uint32_t fw_ver;
> -			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
> +			err = firmware_request_nowarn(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
>   			/* force vPost if error occured */
>   			if (err)
>   				return true;
> @@ -1133,7 +1133,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
> -	err = request_firmware(&adev->firmware.gpu_info_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->firmware.gpu_info_fw, fw_name, adev->dev);
>   	if (err) {
>   		dev_err(adev->dev,
>   			"Failed to load gpu_info firmware \"%s\"\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 30b5500dc152..0acd1f3d14c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -196,7 +196,7 @@ enum AMDGPU_UCODE_STATUS {
>   struct amdgpu_firmware_info {
>   	/* ucode ID */
>   	enum AMDGPU_UCODE_ID ucode_id;
> -	/* request_firmware */
> +	/* firmware_request */
>   	const struct firmware *fw;
>   	/* starting mc address */
>   	uint64_t mc_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index b2eae86bf906..4de018d45081 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -171,7 +171,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	r = request_firmware(&adev->uvd.fw, fw_name, adev->dev);
> +	r = firmware_request_nowarn(&adev->uvd.fw, fw_name, adev->dev);
>   	if (r) {
>   		dev_err(adev->dev, "amdgpu_uvd: Can't load firmware \"%s\"\n",
>   			fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index d274ae535530..b6af824a2f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -138,7 +138,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>   		return -EINVAL;
>   	}
>   
> -	r = request_firmware(&adev->vce.fw, fw_name, adev->dev);
> +	r = firmware_request_nowarn(&adev->vce.fw, fw_name, adev->dev);
>   	if (r) {
>   		dev_err(adev->dev, "amdgpu_vce: Can't load firmware \"%s\"\n",
>   			fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 837962118dbc..bd650b87e281 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -67,7 +67,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	r = request_firmware(&adev->vcn.fw, fw_name, adev->dev);
> +	r = firmware_request_nowarn(&adev->vcn.fw, fw_name, adev->dev);
>   	if (r) {
>   		dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"\n",
>   			fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> index a0943aa8d1d3..95e1edc1311d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> @@ -5849,7 +5849,7 @@ static int ci_dpm_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", chip_name);
> -	err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->pm.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 6e8278e689b1..93c8acca0360 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -135,7 +135,7 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
>   			snprintf(fw_name, sizeof(fw_name), "radeon/%s_sdma.bin", chip_name);
>   		else
>   			snprintf(fw_name, sizeof(fw_name), "radeon/%s_sdma1.bin", chip_name);
> -		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
>   		if (err)
>   			goto out;
>   		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 9870d83b68c1..8aebab5edf15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -335,7 +335,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", chip_name);
> -	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
> @@ -346,7 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", chip_name);
> -	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.me_fw);
> @@ -357,7 +357,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", chip_name);
> -	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
> @@ -368,7 +368,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", chip_name);
> -	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index a066c5eda135..35a0e46464a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -926,7 +926,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", chip_name);
> -	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
> @@ -934,7 +934,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>   		goto out;
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", chip_name);
> -	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.me_fw);
> @@ -942,7 +942,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>   		goto out;
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", chip_name);
> -	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
> @@ -950,7 +950,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>   		goto out;
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec.bin", chip_name);
> -	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.mec_fw);
> @@ -959,7 +959,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>   
>   	if (adev->asic_type == CHIP_KAVERI) {
>   		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec2.bin", chip_name);
> -		err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
>   		if (err)
>   			goto out;
>   		err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
> @@ -968,7 +968,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", chip_name);
> -	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 4e694ae9f308..c16cd96a1557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -936,14 +936,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>   
>   	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp_2.bin", chip_name);
> -		err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
>   		if (err == -ENOENT) {
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
> -			err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
>   		}
>   	} else {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
> -		err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
>   	}
>   	if (err)
>   		goto out;
> @@ -956,14 +956,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>   
>   	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", chip_name);
> -		err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
>   		if (err == -ENOENT) {
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
> -			err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
>   		}
>   	} else {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
> -		err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
>   	}
>   	if (err)
>   		goto out;
> @@ -977,14 +977,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>   
>   	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", chip_name);
> -		err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
>   		if (err == -ENOENT) {
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
> -			err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
>   		}
>   	} else {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
> -		err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
>   	}
>   	if (err)
>   		goto out;
> @@ -1007,7 +1007,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>   		adev->virt.chained_ib_support = false;
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
> -	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
> @@ -1057,14 +1057,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>   
>   	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", chip_name);
> -		err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
>   		if (err == -ENOENT) {
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
> -			err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
>   		}
>   	} else {
>   		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
> -		err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
>   	}
>   	if (err)
>   		goto out;
> @@ -1079,14 +1079,14 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>   	    (adev->asic_type != CHIP_TOPAZ)) {
>   		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2_2.bin", chip_name);
> -			err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
>   			if (err == -ENOENT) {
>   				snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
> -				err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
> +				err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
>   			}
>   		} else {
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
> -			err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
> +			err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
>   		}
>   		if (!err) {
>   			err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index c06479615e8a..9f70012c81ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -370,7 +370,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
> -	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
> @@ -381,7 +381,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
> -	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.me_fw);
> @@ -392,7 +392,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
> -	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
> @@ -403,7 +403,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
> -	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
> @@ -449,7 +449,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
> -	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->gfx.mec_fw);
> @@ -461,7 +461,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
> -	err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, adev->dev);
>   	if (!err) {
>   		err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>   		if (err)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 8e28270d1ea9..4192a5a0c444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -136,7 +136,7 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
>   		snprintf(fw_name, sizeof(fw_name), "radeon/si58_mc.bin");
>   	else
>   		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", chip_name);
> -	err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 86e9d682c59e..06deba7f707d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -151,7 +151,7 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
>   	else
>   		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", chip_name);
>   
> -	err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->mc.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a813d834f1a..cbce96198dbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -235,7 +235,7 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
> -	err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->mc.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> index 5a9fe24697f9..718722ef1835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -105,7 +105,7 @@ int psp_v10_0_init_microcode(struct psp_context *psp)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
> -	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> index 19bd1934e63d..dd5261577d9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -111,7 +111,7 @@ int psp_v3_1_init_microcode(struct psp_context *psp)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
> -	err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->psp.sos_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   
> @@ -131,7 +131,7 @@ int psp_v3_1_init_microcode(struct psp_context *psp)
>   				le32_to_cpu(hdr->sos_offset_bytes);
>   
>   	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
> -	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index d4787ad4d346..a2afbaacc7e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -146,7 +146,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
>   		else
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
> -		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
>   		if (err)
>   			goto out;
>   		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 521978c40537..75d2a9cc9268 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -298,7 +298,7 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
>   		else
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
> -		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
>   		if (err)
>   			goto out;
>   		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 91cf95a8c39c..e1ebfb9e2650 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -176,7 +176,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
>   		else
>   			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
> -		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
> +		err = firmware_request_nowarn(&adev->sdma.instance[i].fw, fw_name, adev->dev);
>   		if (err)
>   			goto out;
>   		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index ce675a7f179a..5538a5269417 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -7687,7 +7687,7 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", chip_name);
> -	err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
> +	err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>   	if (err)
>   		goto out;
>   	err = amdgpu_ucode_validate(adev->pm.fw);
