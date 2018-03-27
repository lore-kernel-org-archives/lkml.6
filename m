Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+vuY7jT/ATNSRS7hPf9cwgYcVoPwO34C4p5tjbHT/Wd+2zUr+D/KxWXmtuW4scoh/KrEOl
ARC-Seal: i=1; a=rsa-sha256; t=1522163367; cv=none;
        d=google.com; s=arc-20160816;
        b=rFeSTlyhQhVB+b8pDgNGQfF3FbIHtXCHGK5DhNoBzaUhZWmkhFhgStgnYbHZU+pBU6
         /AoE2ai99I93lVVgTEKFkNZoSTt3uStfPMffZ4ZSHlOBQrj5qQfb6VLMyeLxbj+TjpSB
         1G9Bsp+cTpyYZqzuLgr8TixBBLHFxNg3x414Uzm+4uSSS0OZ+FZcxGGHN56JfW4bWFNf
         SmnnVnB3IBuE8cmfTE7wLaJFyptXsS6AmIv6XXVDbnLtkP1c3ipFxYMiF8uII8f/vMvG
         RFpH/L5Xfjoli3VpZg2g5JLnd/GRsKlnC31cX4zQYtBmd3imtklu8ZAKUlDxb8fUxu7q
         BInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=FqgWzd6CeF973YPxdJ91mu6PS9Fd+STfvROEahU/aG4=;
        b=MhOiENJIIGBgkiCkW6ZIwkL6/k05dGxwycJRTvr9zDHTrN3alm1PUOGtH928iEI32V
         eaeKoM/o0ck76bfS2kx2tYeuUwfHzJ94kTnNv6Dv8SGnN1gQVOxlHzHC9IpU5tjO3BSO
         1oGtGMBt1X4kgLGKjwB8SoJ8Kq5NJyPsjtxZrMJRtgNv1+MYwjhAqJD0S5fiDc2odkNO
         2Q5V+LLGB4an0b0rPq7SAKqFfg1uaMcPWBT5GvYGeWBPHh2Oa5Pa7bgYwb7Hqz2iDyfy
         m8NOVjx8WuDfjM89iC57t0bPv/J5aVXBoORJCCb4xMcIKLP/pSt7pWQKIr62G1IpUTcb
         84Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fcsNZHcw;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.108 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fcsNZHcw;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.108 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
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
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
 <20180327091504.zcqvr3mkuznlgwux@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5828e99c-74d2-6208-5ec2-3361899dd36a@virtuozzo.com>
Date: Tue, 27 Mar 2018 18:09:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327091504.zcqvr3mkuznlgwux@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::23) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 482818c5-0f27-4c0f-a689-08d593f4b98d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:v4mMuoU2q6X+1XLrKYi1IkgZKllGhjNbpmcbuQH1pxXn0Dak26AknKnf/BYFH7IQ4h5j9eIkWHry8ZXCk8xnOKLGqTiPZYVvilyyuMYLaGWBgUGDIEgdoF5DeKTiTmt/bMqKuBMDirnfEaJWcc6uKw5raORUciQu8ik0bVcylyuyO40j/Ica2vzLBkhx8c2rJ6Cta03r+z/pJljg38pFT/KDFe7UialuQyl2xJk9I80hxEAc9opBsWrFP7XWZ1G4;25:sjdBVIzxmb+8aec7jjwudsh0lwF6dAIovu7YBtiRHKsIhJQ7F9ZhfwbK4Mvch7SOijQJKme75leGh9RelJIHFCVhXDzqGVHQKlUui95bSU/ebA/JSNzRsDBsU7kl9pvsa/kNtPF2LeU8zt530baG5RiP+dudvdrpLBw6QT7uLi2c9v1yoFC1iGeGmedjJAH8Y0xWwllrLEG98Gy4MoLxUSd3UGYXx1jyEp14OhfSDfKbrLF+evlFSobZhGPpM2UI/GTTcVa6790YxZEPxLKLxCXghgcnb2hiV4HOvvcuY9S7yq5Oc+3l3aaV+2DIK7jbkK5e6BSgUQtkN4viiQQElQ==;31:30j4emvuFTT4fkilgvmuOuUumb4IeGC62E5BUqUGFgVs9/Jj7PqhAi8uPt/h3Z7dUcnL6K63IV1PD/2eQ/vOdhDX8bVzYJlWl3THJG+L9AEW2IaRbaRJ25XXlwRkuBNnAPFvmFZ2CPzkFscnmJyhh2RPjSqwtXpQyx/WclkTZaCpfBdnsEMAww3oO4WMKLqXNAt+E5JNNz/Fp0D60b237nvnTK4KgAnb7t0iXImgcKI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:ZKMfbdg1hReQu3DDEDiQPMainckKC4USagWYBHjrQ2xMmtAsX1AblLJ9AeNHPCAatPZNzM2QW6XSd8xpzWhDfrkFEiUKAHuUUBNyADiPlXAaC6ICNuxmen1xPVDHd0+hYZdxEYsJsuNpVFuBmTRGeZ2Ht3aHWbTOKyi/2ugAwmoc4ImoxgfuRH4fJ2gWeLmoJ8pNmD4TofFXowySsDuqBobV78Iuon6A63/HiWv0Z1/6oKOQhUDl+OItZ0yFLHbTx5HRgS5/4HsBwP51swWdJwC1i8XtjZnzYx9cRJSKOf00MKtMKWuchbKYT7RBXd2Xr1JJgc3hT8sKkruFJQVdIAun7uqMw8DrF4yPhoMNbQr/07SzV3m6futM+K+e4k5LW0y6i3P9EtP6X3i5anSUnmu+13YnMT/LZgX1fKehhE3pfilHivg5N66FETAkl9LGEX7U9DcTXCdSJ6d3g/YOCpXrn/o519grvkVEYesU634DkWhKtdmO4hi4r2xZ5dj8;4:j9mQ5XSc+UI7GE9IRnMhmth95rsKfIhWKOzuqFTUp/hKz2KAGb3maFtHWGpqOLjIAx4TOpDSfi1ryOm+Dml95fBqRqsj0dZZVZiYP/T8s6xG2f8lNKzLBRIExzz3qjue8yUi3Yf/oECqsnlX7aojv5S5iGXgKZnBguHAFVJ+D05I9EDZZaXg7jCISYMULHQfKMV/6ePIqkuBHc2T28/qjzINjUT79gIdZ/DgFxboXfxsbw3necQdsoN6C1aRbmerLwUXnclmbD3Gp4c+fIVgsCZ48OPyc61QTKZbyEuZee+qFulAm0xmiatyEZnOLrfY
X-Microsoft-Antispam-PRVS: <HE1PR0801MB134027086265B7FBC78B4D0DCDAC0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(39380400002)(39850400004)(366004)(189003)(199004)(52314003)(76176011)(52146003)(52116002)(230700001)(478600001)(6246003)(86362001)(2486003)(23676004)(2906002)(7416002)(31696002)(58126008)(7736002)(65826007)(6116002)(3846002)(59450400001)(47776003)(5660300001)(36756003)(65806001)(53936002)(65956001)(66066001)(6486002)(305945005)(4326008)(25786009)(93886005)(16526019)(97736004)(186003)(77096007)(446003)(229853002)(50466002)(39060400002)(11346002)(956004)(68736007)(2616005)(16576012)(105586002)(55236004)(64126003)(8936002)(81166006)(26005)(53546011)(106356001)(486005)(6916009)(486005)(81156014)(8676002)(476003)(31686004)(6346003)(316002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6MjJ0bUNqazhSbWI3SDA0RHk3UFBGUmF4?=
 =?utf-8?B?SEtKMGR1TlUvMWJjY1FNSmpSZmpJSkdSTmNOU2hzakVBdTZqRElzU3BiMW54?=
 =?utf-8?B?Qm9YV0pEd1NCOThWazZIZVJHSU5RbDlxeFFQTGx3aGhSRUJTUEtPWW5WdmxT?=
 =?utf-8?B?MFk4Vi8yNldGVWQ0aXlXUW9Wa2dGeFMxSWJJRDROcnRFeEdmWDJnL0VoOEdk?=
 =?utf-8?B?TzN4Tnkra1UyTFRZbm03YVpYRWJBZFZuSTdIVlpPcEozUFJUemg2UGtsWmJE?=
 =?utf-8?B?eHptR0Q0ZENGTWJTRjJ6dnRxbmRSWUV6Z0lYMzU4U3RZT052QVJReUMvMzBp?=
 =?utf-8?B?WEFqRkhYaVMzZFY3L0ZjV1JjRmxpbWRKZUFGalpLK2ZhMVNoekluYXJaV3Q1?=
 =?utf-8?B?Z2ZLRm1mZUJxNTg3bFRiTGpDVFdXeUY2YTg2eFE1UUgySFAwbVJuVGgwOUV5?=
 =?utf-8?B?a0d2Z2tKWEhpd2NGKzRwMDA5MWRhN2V2ZlhBMmdKTi8vZFhZM3JqNG9PQStk?=
 =?utf-8?B?SE9WVmcrWW9EeUo1ZHFKaDQwVDNPU3hiRmNEZkExQVEyRng0aTZ6UVFOMnNG?=
 =?utf-8?B?VFhVMnY3a1dMWGlUV2VIODNKWWhidEFrS204THZ6RXltR3VIek93eW1wQVZm?=
 =?utf-8?B?ZTNsYTR0K1VFWUUxZm9RaUZTMmY4Y050U2V6UDAxcTgzNkZUZ2k1bmN1d202?=
 =?utf-8?B?bXZsaVlXdEM2bXZSa2YwZWpRZkVSd1AzVkRjUUZUQU91a3pSWkZtVllrLzJo?=
 =?utf-8?B?NHh1WktlMFVibWZZRWlXSXZKaFNEZngvZU9XNFF4SUxtOFo0SHNIbXR1ZFBR?=
 =?utf-8?B?OTlDaWtxN0EyWVhXZ1ZpMGdXSUhxVGFidWZHYXZxa0VLaTZ2M1lDczJvZTFx?=
 =?utf-8?B?TUl2Y2ZoZU1QQmpZNm40dWZ2aklpNG1aOVF6ekIzYWpKYWJrSFN4cnBOR2Ja?=
 =?utf-8?B?MWxjbU5ObVZBWnJDdVJMcXpGYmhEYWpRVDYxakxaakhQcEdoaVh4bVh5RVAx?=
 =?utf-8?B?aU9sRXdEUkp5SlNTZW9tTVZYL0dtMEtGN01RSXgzZXdzRm5pNHEzWE0wSzRW?=
 =?utf-8?B?Mnd5RlQzSXlERVRHTmx5dUhSN0lnaGFWWkVUZnpZbGora3lueEtPanlZMUs0?=
 =?utf-8?B?Y3NFMk02TEVvZzIzRCswSWNVUjZWNFNuL1ZPZnlOUDFGNW9rSm1CaVV5cWdu?=
 =?utf-8?B?Qi9hcSt1OHBhd3F3ak1Va1NtN2djR2ZzOXVQY3FDampJTGNiTkYzeDBOd1Ny?=
 =?utf-8?B?TitZZnBNUllyWnlielBrM0d2L3BLem93OEl2RzZQSUFCYThVL3ZKWmNWa3Fk?=
 =?utf-8?B?TEoxUFA3bFFBY2xzWm9TZ09qU3h4Z0VBYlJKcTFpenViTk9iZVJjbS9QZUVp?=
 =?utf-8?B?K0RoNzVyOEZNVkRlejd4VFM5TmpyRnVOQXZUUGRsYnN2TEF5SUplTFNOclhj?=
 =?utf-8?B?VFd0dlpSVmlGYTRCZzFjSjFDcmF2WlJ1ampIY25mWWJjS0lWT0FlT3VkaTFT?=
 =?utf-8?B?WEIyK2tGMkNrSDFZT2MyVm1PK2l5SXh6b1pUQ01GeHNvL3BhY0VhVjY5aFlE?=
 =?utf-8?B?UnJ1MUNqbVE3VXAyRlZ4NXl3OVZMTk9UV0h0Nmc5ZlpjZmgrREUyaGRXcGgy?=
 =?utf-8?B?QXo5SDNFUURTVU5XQ2lISUhMMTQwM2Fzc3Vyc1NxNElJbkhhdlVWSkZSNlJR?=
 =?utf-8?B?aTNQbVRUUnNvN0xnWTF5c1QzOG0zQXE5VUtnVkZuS0NPcW9IZ3VjT3Y3NVpO?=
 =?utf-8?B?WkNIL0ZXdU9EZzRpbi9FZ2tEZHBQU2E1aUVaVkZxWUVhaWVRaDdkNmt6SG1L?=
 =?utf-8?B?WHZxa2xybXVJVkxaM2c3WFIvTTNhQjMrWTQwRmh0QUZXTXdVZHpGb3FnMHV1?=
 =?utf-8?B?aVVrcEV5NzBBYnYwSy9WUDg4NERNeUxjZkZ4RHdNMEZNMUUvajBZbDZDOWFD?=
 =?utf-8?B?SEdBRFJ1bGlCZ0hERFRaWkIvaTNoeXBCcHk1MDZDOFhjek1DTFdUVnl5ZEpU?=
 =?utf-8?B?OW5nWjhodHNWV1JDZGFUekw1L0srZm1aU3l1VGFSNTRpQ0p6RGRIc21mMkRK?=
 =?utf-8?B?akZTcnRRTmNlQmpPMm9MWlFmenNqMGtSOGh6eDhXOVFsajV0TDIyWjBkNThB?=
 =?utf-8?Q?hkE59pxvwVXUQtIXQbdSTAT+8=3D?=
X-Microsoft-Antispam-Message-Info: uqI3KDKFTRpFTrxKwZ9QNC5Nq/IOyXB+g/O3tPCDh//8ErJXRNwi0cb+IoDiXtSudixmrPh2dYuYL/yP5O91yM9OE+BOjh0wrn0gyz/GTHPXScG0JDQdUunoXP1n6sZyrLLzCRoAx1GXnpAs0Ct/GNDQ2WLxer9CrMigBFg5qouZENEjooRxDTcKLC0yGTGi
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:BfisT55KvHGlSDlVFBdjZ3XMk6eroNQPCRWRXYkxvf/KwqwvPjbkB0Taa+chWgEg1Se8sZHM8FoEP/QfOrvIyThfgIs/YsFdxKLNhvifp6IAhY54qvwlTGp3Rh9uSd9Wbd8L0v7Mgf20QMGtyfUFlkLmvg2fBCuT51vBZ4QHxWjfkY0x6Yle+6wpsXlbp9cq5diPtkLOMvRUI15ICmjsAMsbStTthlr0aSqFJZqI3MmarCN25iu9jqNj0C1jDEbjrUzysh63sOuRkqRokp0zeSoRBa13HgBADu5RNKG9LxURvUbegwmAU3fuwknxlGjLFJzoFS6akPiSHXjbWwTW4kSvPDvc+Q4Oz6qPHVZFTGAd+KGlW562CA7ui/eDbtx5U66ndyLvvD89kOdcQfEZ1IUQn5W8yxjISr7C48ElK+gDe3owkZ7iBwNLCoQc/m2AtUBqR7929vyfPuKo8Z4Y/Q==;5:KLZ9HFq2RkkYnIzIOZo6t9IxMCi31CUnpv0x6JNgKgDW3e9rTpWPU6hIPvrFwfrdmtG1irBNPXSmgyQT60r3vo+8pmBLNn9SAhecB24KKo1Sw6EgNa2VeeOgfTl8JnmyCpeXB9czsJmF9mbii+IaXPGN5Zf/+i3jYhy4Re8ogok=;24:lhrqyNVeQ2QPTSKZ6mPUSMQ8cA3bT1yZrZRR7E/FOU2nViMYfspn1tatkem0vG4GW2b6OGn9YXU2Mvav+RRTfjKtpCmR5OcxB598djtefXY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:e544gVMOwlH7Vbj5iNttu5qNeZtsZNRzgNM8lmBIBBjLstHMfmbXH5MMto7A1ROnVoiQH10RhlJC//EbKyZaxAPnIAzwdQy1q80FwtMl8vzgXk6aywKgb6T5xQVvqVZ//SNsCmYhQgKjXKjIe/DWpiPIFE8Rk3v48chqTtTSju4B4iYu5hmhIqSSUT8pJWglOvv7cFKDwb5hG5fKXFNgEdDK5Q6YKdIx4/QFyWbynyrtMqgBUw/w5FfxqcaNXtYz;20:9TIVIY7dOxnEJHXDZ0sp3akXZx/2MR7RyZrj0B1iVgObC75bt18J7qfYf90MDfB04ODZk/nVug4kU861bWA0IB7M5W+4SDX5P5TtwlYH1uHG2hneAlq01Zes3AkTDVkrZK+2TinlXXYUy9SR8S/m6aMJ8GBnW1SI7h9hbNJ0q1w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:09:22.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482818c5-0f27-4c0f-a689-08d593f4b98d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596103974626633426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.03.2018 12:15, Vladimir Davydov wrote:
> On Mon, Mar 26, 2018 at 06:09:35PM +0300, Kirill Tkhai wrote:
>> Hi, Vladimir,
>>
>> thanks for your review!
>>
>> On 24.03.2018 21:40, Vladimir Davydov wrote:
>>> Hello Kirill,
>>>
>>> I don't have any objections to the idea behind this patch set.
>>> Well, at least I don't know how to better tackle the problem you
>>> describe in the cover letter. Please, see below for my comments
>>> regarding implementation details.
>>>
>>> On Wed, Mar 21, 2018 at 04:21:17PM +0300, Kirill Tkhai wrote:
>>>> The patch introduces shrinker::id number, which is used to enumerate
>>>> memcg-aware shrinkers. The number start from 0, and the code tries
>>>> to maintain it as small as possible.
>>>>
>>>> This will be used as to represent a memcg-aware shrinkers in memcg
>>>> shrinkers map.
>>>>
>>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>>> ---
>>>>  include/linux/shrinker.h |    1 +
>>>>  mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>>>> index a3894918a436..738de8ef5246 100644
>>>> --- a/include/linux/shrinker.h
>>>> +++ b/include/linux/shrinker.h
>>>> @@ -66,6 +66,7 @@ struct shrinker {
>>>>  
>>>>  	/* These are for internal use */
>>>>  	struct list_head list;
>>>> +	int id;
>>>
>>> This definition could definitely use a comment.
>>>
>>> BTW shouldn't we ifdef it?
>>
>> Ok
>>
>>>>  	/* objs pending delete, per node */
>>>>  	atomic_long_t *nr_deferred;
>>>>  };
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 8fcd9f8d7390..91b5120b924f 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
>>>>  static LIST_HEAD(shrinker_list);
>>>>  static DECLARE_RWSEM(shrinker_rwsem);
>>>>  
>>>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>>>> +static DEFINE_IDA(bitmap_id_ida);
>>>> +static DECLARE_RWSEM(bitmap_rwsem);
>>>
>>> Can't we reuse shrinker_rwsem for protecting the ida?
>>
>> I think it won't be better, since we allocate memory under this semaphore.
>> After we use shrinker_rwsem, we'll have to allocate the memory with GFP_ATOMIC,
>> which does not seems good. Currently, the patchset makes shrinker_rwsem be taken
>> for a small time, just to assign already allocated memory to maps.
> 
> AFAIR it's OK to sleep under an rwsem so GFP_ATOMIC wouldn't be
> necessary. Anyway, we only need to allocate memory when we extend
> shrinker bitmaps, which is rare. In fact, there can only be a limited
> number of such calls, as we never shrink these bitmaps (which is fine
> by me).

We take bitmap_rwsem for writing to expand shrinkers maps. If we replace
it with shrinker_rwsem and the memory allocation get into reclaim, there
will be deadlock.

>>
>>>> +static int bitmap_id_start;
>>>> +
>>>> +static int alloc_shrinker_id(struct shrinker *shrinker)
>>>> +{
>>>> +	int id, ret;
>>>> +
>>>> +	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>>> +		return 0;
>>>> +retry:
>>>> +	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
>>>> +	down_write(&bitmap_rwsem);
>>>> +	ret = ida_get_new_above(&bitmap_id_ida, bitmap_id_start, &id);
>>>
>>> AFAIK ida always allocates the smallest available id so you don't need
>>> to keep track of bitmap_id_start.
>>
>> I saw mnt_alloc_group_id() does the same, so this was the reason, the additional
>> variable was used. Doesn't this gives a good advise to ida and makes it find
>> a free id faster?
> 
> As Matthew pointed out, this is rather pointless.

Kirill
