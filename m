Return-Path: <kernel-hardening-return-12959-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48DoeX+AXqqbzocrIPTaJyoWCYTpDBBzl86u3trR/W8WRAdZIqsUhdL6uLHfBpcL27+9amA
ARC-Seal: i=1; a=rsa-sha256; t=1523386107; cv=none;
        d=google.com; s=arc-20160816;
        b=YNjWVGIc/+qUkpiXrN8YcnyxmvSSCxEeGzm0fe3FIohZGyk61X5C9vn0l5nSLV6WHD
         BOSykcnzhPdfjJtgOGoH9zEYxjIhCQNBdaL6QtbGHjnpAxP0aZ7xOTUfY0T4w598Kmht
         UZPAGZWbgYCVZ2h9cWxNfnIuoG1lBwC6PSNkKYx6t3C4IDFr6HZQzzsB0hPqJfB2R3dB
         hjsvA4eqgW92LY1gY5PoZ+pht1js48l/p4GMeqeA/wgFecapxYs3Ekae7T5eKB5r6e40
         WRkgrMt+jjQAWuz+G8fKEHP1VCnuG2RpnjyV0f8KWFUASDRsKkZI8jm6lmj3kFUir0Yh
         3Mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:organization:from:references:cc:to:subject
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=jeIFLSPxvZp5TzpfgQUMel3g04Bxh/vXBiknJUnxh2A=;
        b=Qt2xwM0JLe2T520c/8RgkF/QtWaB8pWl5zzykF8xw792/J5T00xqNyiJ1I8p6+zVy1
         NxuwRWHoheVa0hQwGnzWB5b8WbHIH+ErodKuXqXF8L3A/CDQZlTh7OUwSjuKbwiiPLOi
         dYBKamOWphNvB/nt3vdAq1pqfBrS8VZ7MEnX02e6poxDWbj4GPecPM7CfI6GZlACnMdp
         40tzoQuWHSiZA9KZsTulkIwmLVuWyRA6clxY/UTIEIKA4F9Zaw0MSFL12TexJ97T0uG1
         jiQWgwfaegEDDhUU9yWd7Yr395XCqVMJXLkILQiyAxIEMhKA4M3DfglSd2GZpXoMMbsF
         5G6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=igpNIkCR;
       spf=pass (google.com: domain of kernel-hardening-return-12959-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12959-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=igpNIkCR;
       spf=pass (google.com: domain of kernel-hardening-return-12959-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12959-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: [PATCH] drm/amdkfd: Remove vla
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Laura Abbott <labbott@redhat.com>, Oded Gabbay <oded.gabbay@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20180409210620.3647-1-labbott@redhat.com>
 <71ff5078-713c-ff8b-8c8d-6d24a7d84c02@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <ad009206-2202-ad01-c7ee-6ce296df56ba@amd.com>
Date: Tue, 10 Apr 2018 14:42:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <71ff5078-713c-ff8b-8c8d-6d24a7d84c02@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::36) To BN6PR12MB1697.namprd12.prod.outlook.com
 (2603:10b6:404:105::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1697;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1697;3:ZkCHldYbCidvzicHPLSYKt/6P4nxffIUEZHe3+ysea5sNcbJ6prYVaJXYOUZ8bbsZtmfC6UJBlLa6JWA/KjFkKVVthNvywwn9W77AEhN9KDo1dgUiltXHyfMZsT37jbEaLJC/wsJdXbuK0Dthwsb6XcqkpKj3YnV94CMHXu5tFN3FMj+dKTL52V/CdJSIzd3b9mWadE+aICaO6F1a3IYyDBcLcHUAEnV86LdEopgT8+LnzhlstfOGGAjdogPdvhq;25:Juz43GbgH4R/IfMXc4gxXIYvwH8P5+oKU1NP2H5deSZq1c4D3Cfg3kqOqrb4bhKMA/wWfeI5qsrNE37dxGSvu4PGiQ42sf95FK1czZogNmYDMz4lqdD3V5NJV3EyNxyaj9c+6hJiVuIJUw7SPUB8r9CfqPXI88KccibWLBKxY8C41Jf4E7kGDatOfT1vk2dOlno06oXpzVTdGEkzQfnbm3+yHZqIKUHLLHn9tqSQrdb8GlbpdrfLw2VZOmWGJPMsSCm2hGq7fPVhMuGLmYdTv5LwPARieoLDIdEq6+4oanbOjnu3R8xdgebW7pyORsrIoSJrPeI3orOv6NMZl/YnzQ==;31:VRTPG7iTZdUVYPesr9T6SDhhrJSXh/qdqac7dd8ywRrnoz8rSmWJoRJ6Z5yjblUd4N0wJe+GUvJyLxBC+abjwmYrLvqwmW4TNDixgf6SCZoMkgNv++irhYzi0BzG0hkfPdBpw/5wYD8IxnRH7ofettlmT5zbnRGoGDWNsLrfSl/7QHyuST/usZttDPmWN5cWxUtd6uBhhBOtTqLzUgY9eE5Q9U1qTC4MkOo3X/UiOX0=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1697:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1697;20:wK0K4pM53vQav/egs/2SuVs+hZH/ym065D3iduk5ZcM948PgDN9Xz/LEsDPWwL7dOpmZSWdsToRWe4MuOq0FPrJjGlKaL8e8/9TuENeixrPTduhimlFP4uKLljzmDaq7Q9Fiqw7JVB3e210eol0d+IGtpzSuoK6ptsmqb7reCkHTdAsaWeo26FWR51WH1X3AHKGLRs23l95adclHxcgeEwC9W8uiUsy0ErludjwYlin1SQUKyAOE8nEXTFZIrv6CYYfENfVo9egLtwAiOMxQVbCI2KnpGoR9ssYLmtODHpMI4QUoQrrrs6LjIB1VS26pfEixcwmgQB51y+RjIJ5Lpx+OtMYNdBBTOAmYlNfub7MLwycbsC2ObIXErS8JDqjRviyK0PvWjIAl7hOidiLt54WZsMWsS/K3p492zWGkkZZ+wLjAcR0NTEb6DUfEBSFN38+AReGK51ypPktfi6hMq1HalrUTEp4iLF970kC94MPZX/n0Q9KfVGdm75GvTLrs;4:1XI3DfDJT5gbfPVTwzZXpspa4q7PU46U77OBQ0P7zEJ9dHvOTm7nJffOw8e25KzmzjkB3ktQIICayIgehK2Fx3E5gEeKTFyXk66cLZ0Kx9U3g0tMQuLlveY3RiKTwAx1KNYq86E2GqzmHEjIiTrPTK/Miim6Al21fL6gTsQ5NCOlYF5rV2rvuB8RF+izxr+OX3VO/bLGLvfYIROEhTT2OAbuf9WmdtwSPJwlflbil6bGj0XI2sl7Lc3Vw1a+2vlyqC7h/8GQ0bbWRt+p6QeeNWT1su1++y3JJltWVqRQ8olyAGuJkeBHeItdWFxF2Hn2sfvqCOurLCpWf2YtP5z5duEny63gtlikxXamkziFHIQ=
X-Microsoft-Antispam-PRVS: <BN6PR12MB169783A5639D08ABA9A614F692BE0@BN6PR12MB1697.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1697;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1697;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(39860400002)(396003)(366004)(346002)(189003)(199004)(377424004)(6306002)(16576012)(58126008)(66066001)(229853002)(65956001)(65806001)(478600001)(2906002)(4326008)(25786009)(72206003)(54906003)(316002)(110136005)(68736007)(476003)(446003)(86362001)(956004)(50466002)(386003)(53546011)(31696002)(8676002)(81156014)(81166006)(486006)(6636002)(8936002)(6666003)(2616005)(64126003)(47776003)(11346002)(186003)(2486003)(52116002)(53936002)(59450400001)(26005)(16526019)(23676004)(105586002)(52146003)(966005)(7736002)(6246003)(36916002)(76176011)(31686004)(6116002)(3846002)(2870700001)(5660300001)(305945005)(36756003)(39060400002)(97736004)(65826007)(106356001)(77096007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1697;H:[172.27.225.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNjk3OzIzOnFiaEl0OXM2WTg5WUFHcUpLcHc3a2xodk1F?=
 =?utf-8?B?K3UzWUs4SGdRNVp6NDIrMHo5bTBMZlNYdktIUGI1UTdoVDUwODcvclB5NUM4?=
 =?utf-8?B?RlU5N29XNTBraW5RdWdqSjlzNVFtdUczR3J2QSs1ajVWRHBtVlZQRU94TXh0?=
 =?utf-8?B?TFFGaGJjRThtRnJhWGZzeVRpbHhDQkYrN2RZQ2dCbHVNOU9qb3l5NEdEd0pW?=
 =?utf-8?B?NHgrSTBYcmRiYVFwRmlCSGVmTTVEbFUzQ0NIUVJLWEF6dnBHWGNvMnBwb0Qv?=
 =?utf-8?B?UGo2em44NG5ZM3lydDdMM2lETWxiL0RORVRmWkp3Vmh1NW5SbGRjSlhKbHpr?=
 =?utf-8?B?N1htMkthVmFnblY3TUNBVlU3ejYrbW5UakhOajZLdDlnYWVRempRTEk5QjAy?=
 =?utf-8?B?OW9BMVI1dVJyVy9GSFVBT1R5MysyeFB6U3BCUW11dDNZQzJadTBGUG1adUNu?=
 =?utf-8?B?V3MzSy9GOFpHNDgzY2EvQ0Q0Z011c1VMRXRsN3Zzc1h1ak9hNjNEN1p0bmxM?=
 =?utf-8?B?bWFhTTAwbnN2Q1lSam1mM0g3WnZSZnFQc2NnVGhmNXBUaVFueHA2NGVHUW0r?=
 =?utf-8?B?elNVbVpmcXY3Z3BaVmF0Mm0zcVo1NkRXTS9EakhHbk9WV3hRQzVFT3VmdmNT?=
 =?utf-8?B?MlRIdXNmbGE5N3N6VFNvQTIvNHk2M0VpNDI4ZUNHWUg2eXBOYmIzVTdWMUcy?=
 =?utf-8?B?UHlwZUxPZ0FhTW5BbFVRTzhnVUdkQmk1RlRXWEFTME51cTRCWlhqWkw1TnlG?=
 =?utf-8?B?MUZMMTBaNHFMMW9wNkVoNFBkVG1qZE94UGg4cnNQUEp1eU53dlY5OFV3eFdu?=
 =?utf-8?B?NkRvMVduc2p6OWNyb2JMS0kvbXRmN0FNeHMzeEdGZGtaOXdRcEtoVFdlRTRq?=
 =?utf-8?B?U0VVT1ZkdVdxQStMZkZ2aTEydGlhVGk0bEFsVG9zVXJ2T2pjekY2dkpvcFRs?=
 =?utf-8?B?c2xYU0dQZk1DcDYzYmYxb3VRbjdOM2tqY2tsUGNXVkZNcWh4dStyNFFtWFVp?=
 =?utf-8?B?djEvVCsyeHRzVFdXT2tJSTVCVWFTTCtBNitjTG5wdUNxcHZCZm5WSHRmK3cw?=
 =?utf-8?B?NHVIRlU5WTRNSnFDelFvSzFib2N2eFB5eUNBUUcyNHQzZWt4Z0s3cWV0Sjk2?=
 =?utf-8?B?RzFSVjcySHNhWC8vVVQ5emhIMGd3NTJORm5NclkzNENLeDJSWUhQOW9YY29L?=
 =?utf-8?B?NUFXWFA3YzI3aENrWkc4T09QYnB3R0NGVGdaUG5ZMGdtMmt4dUFNTVVSQkt1?=
 =?utf-8?B?THhhUHE2Qkt0YlBtZU9TdFlYczJaQkJpM09HVU9ncnQ3bTlkRk90aE8zME1j?=
 =?utf-8?B?M3BPdmcyODI4RkNjYmRwYzN0QTF1UGJkL3dnbEZwbjB1K3RBMWdDbVBvNFd6?=
 =?utf-8?B?MlpIa2ozTzVkWFY2b2dSOWkxTzltbzFUVXE2dS9hN2piRzJTbWJ0RFJNSU1M?=
 =?utf-8?B?MUUwU3dQZllFUWZibGcwRUl5cEJKTWVVa2lUbzMrOGs0MklNUTlVNEdKd2ho?=
 =?utf-8?B?VDFOZkJ0OXBaYzBHYTlRM0FjRldGYnBkSWljQmREK1Zxcnd1Q25mSE1sUTlp?=
 =?utf-8?B?RmNPQXhtaDlMQS9VSUJBMHMzeEUvM2VYbGlyQnVyVm1tYm9Mb2dRa01lVnVY?=
 =?utf-8?B?RkRycWZOU1RiNTQwUUQyYVhMVzJlUVllREZ0NUorNkR0SjIvN3lGSWVCc1Bx?=
 =?utf-8?B?S2FFMTQwRG5POThUdHFFZE0xV0VHOUgxYTdkWllHSVNveExDWGhhVGRuVkFL?=
 =?utf-8?B?bTE4Z2dqWUlXN3hQSVhZSzQ5bEZ2MzFqMm5MNmUzNjhrZ3ZJWUNvcXZIYWdH?=
 =?utf-8?B?OEZyY1Z5Z0UrKzZ1N3lQS1FuaFY3Q1JXMXFkVm1pV0VzUGdCOURrem5HSUlR?=
 =?utf-8?B?SVdvZ25kbU41c1FJR1VSVThnZFg2WDBvOGxDKzFqeFhWdXEyZGJZZmFBWEtT?=
 =?utf-8?B?dWNEdGg0MmhneWZKU0FReHhhc0RkMlNGR2V5TTNJTEY1eGw0Sm5TbUhpTHg3?=
 =?utf-8?B?d0I1QnRFM1Zsd3pVU1l6bWlhTDBwZXZ4ZTFZS2tCTUxKQmhEb0pDdXNGVDJ4?=
 =?utf-8?B?bUd4NnB2MXZUcU1GKzQ3UDhZRnpZUmc1eEI3L2k4enBYdnFkTlJ2SGxEOUFM?=
 =?utf-8?B?clJJU0lxVjhiYVo2SlhWLy9FM0VaTGxHMk4vQkxvdWYwQmpVRTRSeGRWbTY4?=
 =?utf-8?B?QnRRNFh2MlpjOEtvNUZIZ1NkQVJ3PT0=?=
X-Microsoft-Antispam-Message-Info: +PCBDD2/Hx+wunj6UZDIbEnYMXjWyJ07sV9qIQGlQNxE4IhD7Rd6CSSCkgKYSM29igSugdDwz/dDooEwgYQfnx8RcQKrKglkipOQQNoN13YLph6Ssl2nMVzC9Gf2b8q9+IXDuTv0SIN23yR8NgTWwz5x1pGLC91MLn1Vqnq48oypnGByAXpB/bUpzxynJZzk
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1697;6:f343pXv4x8Ik7jKvMTdTlp+86OtxoMVgdIzFG4r/tE7WEoeE/waowDKGtrZTSA7qqXskjSmJ4ICnnDuThz/Hy1ZAgI3N1D2Ho+0Qk5RsMUQnfviId8aKCcKAJaR3qX7/TS714RtE/jmxaqol3OhBx46fDtkXscOqSV5yxFQYVcU2OOctZekAgk6tA/X4NsUIugfN2S2/pYK5VUnCXy6DwOzFjg2pzoUy5Z5fVKVaXw40AvAXmqNKe6itlKPZ5Trh5JN1ZXOzFIPihEWFCBYQQNU8ANgSeqYjmiQMP8Ed9vSIxFC5UTsokI4PhIOUC2cwWAzXUqXRVVwVZtyHVTlV5K0J1JL4EiVv1hXIX0T9cOsPZcTgXEVpzyHXfSXVaob3DpyerCrf7Ivn0SZbidd8amTzXLRumkfzP4k74h2VmjGDHMvyMEkATDGvK8JU0d2XR8ybSXRR9EVh4XOKzTuaZg==;5:3s1wg8fTjCUNKCIuNgAmGANdGfaDuvDH6JxLvlX4Fq3RgAZUCMOTEPJ5SawCTu/s2+w44R8uw5NYzNfQe2M0pOa2iPWk7m8LDZpZkzsSvDGAhly4HFhgirFUIapycQb+cuLxgkJwONgvgNCKWe0q0jkTGHpKPYWFSbIfN8UIeo4=;24:nmG8NMTFDM5lnt9+09zCCjfh+U8hG40h1e3sQ5/V8dVZj8tf404rEGkQsxTKqWksN2oI1BbRpNAQE6Bnx8EDrdGe9I31/2Nanqt4haL8RsQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1697;7:JKDGQflh//7AM21igFYBGemyNe5suNl3QDOrrtBRdzw9hg/Ow3x//oSFi5Y4xejKGgJGfCvJ64fRqREYGjd7TG221BjW6ryOdWghZdUkf3VNJAZ6zbf4/kpZujtV8zDiA91avUTv3Dtjf1bquPvziOaN51I8XBDtSiChU/79aozS5/3UFZdR0qlpzJkZgsv+bcIbzA45ufwafYizasTflJKCyhtnIDkDaAlh4yW16JGv/dNVx0MY1/eTEKH/LSDi;20:sNufJZhZutU5In6NUXM8I6+TTGMjFWOwo8VocKeTIg9tbKXsRZyGENQ4TcS78jFR8G/u8fpCAvMorHtc1XtjJhIwfgnXwQNy2RlRmdsS4nP+De9dvM42bqZfcWTKeQey3KtQJib9UieJ/j+3SdBhzl/razhzDU8NYXkQ1wMljMiQQ8245hB/jzzJXysCIr7L9mLS2Oz+JQj0vROxiHe2EYt4MA9lmGuBr53aLHAJq7zjThYXcUWFg7YOPKf6sia1
X-MS-Office365-Filtering-Correlation-Id: 6761b032-f73b-4dad-80cb-08d59f12e27f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 18:42:58.8417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6761b032-f73b-4dad-80cb-08d59f12e27f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1697
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597386110974334573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Christian for catching that. I'm working on a patch series to
upstream Vega10 support, about 95% done. It will add this ASIC info for
Vega10:

static const struct kfd_device_info vega10_device_info = {
	.asic_family = CHIP_VEGA10,
	.max_pasid_bits = 16,
	.max_no_of_hqd  = 24,
	.doorbell_size  = 8,
	.ih_ring_entry_size = 8 * sizeof(uint32_t), /* !!! IH ring entry size is bigger on Vega10 !!! */
	.event_interrupt_class = &event_interrupt_class_v9,
	.num_of_watch_points = 4,
	.mqd_size_aligned = MQD_SIZE_ALIGNED,
	.supports_cwsr = true,
	.needs_iommu_device = false,
	.needs_pci_atomics = false,
};

If you change it to uint32_t ih_ring_entry[8] and update the check, it
should be reasonably future proof.

Regards,
  Felix


On 2018-04-10 02:38 AM, Christian König wrote:
> Am 09.04.2018 um 23:06 schrieb Laura Abbott:
>> There's an ongoing effort to remove VLAs[1] from the kernel to
>> eventually
>> turn on -Wvla. The single VLA usage in the amdkfd driver is actually
>> constant across all current platforms.
>
> Actually that isn't correct.
>
> Could be that we haven't upstreamed KFD support for them, but Vega10
> have a different interrupt ring entry size and so would cause the
> error message here.
>
>> Switch to a constant size array
>> instead.
>
> I would say to just make make the array bigger.
>
> Regards,
> Christian.
>
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> index 035c351f47c5..c9863858f343 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> @@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
>>   {
>>       struct kfd_dev *dev = container_of(work, struct kfd_dev,
>>                           interrupt_work);
>> +    uint32_t ih_ring_entry[4];
>>   -    uint32_t ih_ring_entry[DIV_ROUND_UP(
>> -                dev->device_info->ih_ring_entry_size,
>> -                sizeof(uint32_t))];
>> +    if (dev->device_info->ih_ring_entry_size > (4 *
>> sizeof(uint32_t))) {
>> +        dev_err(kfd_chardev(), "Ring entry too small\n");
>> +        return;
>> +    }
>>         while (dequeue_ih_ring_entry(dev, ih_ring_entry))
>>           dev->device_info->event_interrupt_class->interrupt_wq(dev,
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
