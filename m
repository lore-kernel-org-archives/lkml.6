Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48F8sO/rFstwi4OsfOPOtSUHs+CQYaxqtcAv1tfmmza/WtsWjEVYByFL+DQVxsAgPf7gAM7
ARC-Seal: i=1; a=rsa-sha256; t=1522432006; cv=none;
        d=google.com; s=arc-20160816;
        b=kgp22jpIwaKGgo/QWcWsCapPW7y3YIuXb9pjJi58T3Q+REMXi70kZAZDs6pT9bT7pX
         2EcWriSPps7u0J8S2nPjJRytjXZu/ygs2luP+f5txYlHEWvsrlF5O7IDqmAv2rNY0iPo
         HnKDhGh3411VEoPYroQ6co83koiZpoj2J/+7EZN+rAXPyITeZJ+gIJHHMEGKtydREUhe
         RdUWWiL6YJe6mlwvTGRI4TOoQ11xUlDoHAvkmg8tZ0r/HQdUJ8Rp1wwKjeWvJVZ/+T3W
         gEWH4vpn3tPRmk4XbfPFfhHpyP+RdZROSjznScTa5LxcYHqMzRULbAUlmkOZWl0a5DgS
         sPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=+6BkehImaNopNtn0UAklN5hPYAijcxNY4FhMECwFn1E=;
        b=p4LOk7cH+FG4SuBoqDfeUQqsQBFFrnY45RKaDU5yQ+OdA94P2sUTHth3hOD01BllzS
         Wbnxr/FwAiGlszFjPRVQhsvs/YNCmZp/LFfwrnhgKifeVzCJeZkp6I6AP90/VwWkz9c8
         Iw4gqV/OxSjCQUaFvtDPa8TM2UakfMkT8Vol+qvFs5ZGyeCHxOX7GFixfBErgTvsL2YB
         u2+qOD7GJQxtu2UWeK1Klnlwnx88X6Yxzi5IG7GxMXfcgNFVVnDsGhBFA0EhDFnsdvY+
         WMws1Hu57OHD8nGW/ZdzwMu+ZblhmYMJthdzP5Q5a0uLVaH667GeCrXzJ8E/yoZQoVJd
         LsNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aUv0RpKp;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.2.134 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aUv0RpKp;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.2.134 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [RFC PATCH v2 13/15] khwasan: add hooks implementation
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Yury Norov <ynorov@caviumnetworks.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 Michael Weiser <michael.weiser@gmx.de>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Steve Capper
 <steve.capper@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Paul Lawrence <paullawrence@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov
 <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <805d1e85-2d3c-2327-6e6c-f14a56dc0b67@virtuozzo.com>
Date: Fri, 30 Mar 2018 20:47:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: CWLP265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::34) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e172c2-6e59-47c8-197c-08d596662f3a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:KL3ncjdP2ebvtZtuq49L+ope/uf6UM41e97JTeKTKJZwsM+cLkzo5CS+L8woJDbppQG2aa9P154CXfhFTwSKMh9bDo0H5BcFGIecIOTHsTAq5xsicHFRgfFXrSHBPa+NwYtXBq+BoThLASylMy2rrgRvT9ECLW8cdI8Kz0HcTqIEgipVKk7PFJmPasidKp0UXC3eNiGHzxr+igcWOD8OHfTTBatPE0LQZLpbN+niDgptMuNxpuESwpPWIOtpFp48;25:a0HwyaotaAXDpE6i3CBzIRFTXy0JRGvztlUiNRjP+1wHnwtS1PatHkK4oIgdzAUlZk2LerxoyXtAqcUMrIDpUuq3IxxzKZyh8M9l9QxqLcGi6+FpPUvudwiA5TbH91ubhsraGU8j3gBP5mvanUCZLeSPg6pAbnId1vxr+5AFrF74GZLXmL9pRIzdCzs5aK/nlbM6wfevH6y+sgIdDSiLNGBE14RltwVaqiv1DbPxmgRpEpRerfnGl8wN2oT+RPeF3yxJGCoXLQRbnHwhIxOJ/iShE0Qx4cH/N6MFMCPIQ6Gupyhd+t3oZFqFq3534h6FlYj5NuEGyHYo+Ii8mb+Teg==;31:L9+I8E1qUNeTKaCEqukDh4UM5tPg3LL8IckFodPyNONQ0R/XlYkNQThXw95H+QnwTHvN9TVLc4lVM0SZiO7SMKEV2B3GU15K3008NazWqYndRI80VMKrupg1OX7RO243B5qOArg73JpzWfsPg9jdBMseek5yjhVtYNsZVwPH5XVl6iI911G8jf3bPgYUh6T+nbNUJwefFq/70Kl23VqEQFQ/YikX2QAi7EVfs3gfj/I=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:EK9JGWEXwd1FW+/TmAFBZitpqIeYQCd80otrdnAWUXUR817VOALmKkN5Hw2+r7smJGeai2NbGjoCf1YeadG9zWYqFmrF/farfAx5+5pTdffnbhSZdEuB7eIRoEAGTxMSF+FTlkmCuUEspxnZNQ+CO16hqheSrfxRSEoNRuubyn5kDLg3qA2pFewILieRtCDB6BI/5R/ZrxxqeNN1hz5D+PFe9NmZLwkRhdFxC+f7vaNDUbhCsVNIKohnwnQ3ppKveix/x8+rfeOFbet15gGshHAMm+dlaDPIFkf2I2lFxDJeK8dKRYGRh2sl/zJfM9ANwOj1moPrDV8fD5ljIWUOxucSsFv9x/h1zVqKKJNLPDAUJ7MXkuTuEtTou1dpLTWY1otHcekHZ5SFgMqEsTDUD6ym5A2gMohX8qaLepRsAwve1oTWAfv9iRrDKbCTssF1m0FQsg8T6yqg2K/cFBeL4eXj/x480kNp/UNrw6j90t33ejaML4r0QJG1KgHBD5QX;4:XPBZZEeRVS7MzyuYtGoDSC/EIKX24Z83u5Af74c0YbTng8+jCZwuy/jU26/vAO16QBBpNeAGpYmbD1z6LzYgnrz8U0OZVCGARwZDjaDdOex6pzYNjWi4qJCnNU7JbimV3YGC8PnPDJsz0xovOWXpWwklOqkg+S9VkyEIbtCiWfSBUeAIr6C70WJe7VXBI2k9ZclsQpoFsuo13KE0a0RQIGbUybAMm0DCEYNMjMZ3fl6DtHdUsh+IH+ipwXJlbOQtQyIfnFvmAkkrS/PBKMLstWThD+EsaTiiN+78b6xL9pJslCTuVLqWm2llq9cUmsqyFSrbQ3h2PSb19bX4IPxTPc5iCSPZ6k+o8Jf+NXhrsIZVdWUcjYbWGEzWZzv4jGbQ
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258B4F3525FF4C0E6EED495B0A10@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39380400002)(396003)(346002)(39850400004)(189003)(199004)(58126008)(110136005)(16576012)(8676002)(7366002)(6666003)(4326008)(476003)(8936002)(2616005)(956004)(316002)(8666007)(229853002)(55236004)(65806001)(97736004)(31696002)(478600001)(36756003)(81166006)(186003)(7416002)(11346002)(16526019)(446003)(65826007)(47776003)(25786009)(53936002)(54906003)(5660300001)(68736007)(86362001)(81156014)(7406005)(6116002)(52146003)(3846002)(7736002)(386003)(65956001)(76176011)(23676004)(2171002)(53546011)(26005)(6246003)(105586002)(31686004)(50466002)(59450400001)(66066001)(77096007)(230700001)(305945005)(64126003)(52116002)(106356001)(6486002)(2906002)(486005)(2486003)(486005)(921003)(217873001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOmZ2c1BGVTVmR2VKTVF4eXczR3EyUE84dm5S?=
 =?utf-8?B?Z09wWDZsWnpwNDNjR1A3MGhFR3dUZHltOXhaUGlVQXVSclhRTGY0Zy8yM2Vn?=
 =?utf-8?B?VS81SXZoS2VsbXRsUEZTcTQ2SjI0R21BdjZ1dlkvR2hDNVRvVUxyeDE3VDJy?=
 =?utf-8?B?L29qMmRwSnVwNWdYcWt6RCtyTTUwd1BhbFg0NWhVSk01R1RNckk5eXMyczVQ?=
 =?utf-8?B?NWdlOEJMMlZxeE1xaEtqbUxZT09XRFlWUm55Q2xDV09UaHdXVTh4bENZK0gy?=
 =?utf-8?B?OEE0YzQ1L1VoUXorYjZHcDUzM3ZiQkxvNGJ2RGxzWDFFREl6U25hdDFyclFP?=
 =?utf-8?B?OThZbCtsa1orN0JqMGtrWk5MSCs2UFhTQjF1K015RWttVkxLUXZnR2ladWRj?=
 =?utf-8?B?OVlEK1ZSZ2NmMXM1dnVEeFJyT0IvWTk1T1I2b1REYkIxeWswZUdkdFZNSi93?=
 =?utf-8?B?SmtJek5ETVYzWG5Hb0JIQU5UcUIyQ3hEcXA3azh3QmdBazRQbTFUdFc1UW8y?=
 =?utf-8?B?MHdWRnFJSFYxNFNlcm9hTk5YMTVPQitudEphdnhzcHNxQU4zc1BBQ0lpWkJu?=
 =?utf-8?B?a1J2Sy9pT1BQeXcxdFJXY3RGMkc5VzI5ZHRYc2pDSGxUMGlqNmVhV29YZGg5?=
 =?utf-8?B?ZlNsaWNMVXVlYnZZWmExVTFJeU1Za01SRFJwRnVxQit5V2ZmRkpsdzRpOHBv?=
 =?utf-8?B?RGQzTWtPM1lqTDI5ZlJ0WFRWcytYSVdCOFNqTjFmUnhaMlJnMUFQY09lZ2FT?=
 =?utf-8?B?eHI1VUZZRjl3SEdiODFjdG56VlpUQmxIQ3FHakVPMCtRcmQ0YkFGR0V0VHJv?=
 =?utf-8?B?aVBSKzFQcG5lOTZqSGR2NEFIM1U1My9Iajh1endUMnBYS2dpaVpkL2k1clV4?=
 =?utf-8?B?Z1dQRXFTbWpYU3RNSldiVkFCSk9yR29WRENDMEJ1aWp0ZnBUY21KRXNRWGxL?=
 =?utf-8?B?MlJRelNqaVo1Z3ZTSDJESHU1bjcrREp1UEcyVUpVRjF5SS80Zy8rVE53OVpE?=
 =?utf-8?B?T0pTa0xoMmtmbzRUWHpWUm01U01SMWNhbSs4ZGtVcS9halVhZkU0Y3NDQklL?=
 =?utf-8?B?R3pPMWFLKzNDTjF6TXp4cm41WTYwamxWTnJQRmhETzR5M1FoK3h5VXdYWU9m?=
 =?utf-8?B?cHRsUUlpTTZSN1lMUkZqMkRNaUNRcTF1S1lTcUcrVHYxR2RsOWY4ck5TZitT?=
 =?utf-8?B?ZWYvTWNyeWZLWUJvUm5vays5bDdsOFY1NkpjZjZwdU9QbytuaDEveW9vQ3Rn?=
 =?utf-8?B?d0lVdVhJcksyZC9iUDJkTnJWY2ljSXZGVStIR1VvQ2lPNU5wZWlySXgyVFBJ?=
 =?utf-8?B?blNPYmFlczRScmpvaDczc21qMklPZWF3VEZsRU9mTFJyNi9qRnpQMkdxOXF2?=
 =?utf-8?B?NERhczBYdmh6MWlTOS9mYng3Z3BOUWgzY0xuR3lGTnRGUUdQWWluaDFMYkJY?=
 =?utf-8?B?YWJvdGpmeWt2cmp3ak1YMG1EN0xEalNPaHhnemhzRGV0cFRnNFdxNnVmQjV2?=
 =?utf-8?B?dzFvakljZVIwZVhHRUdnZ1dnNzdFRnRFNnpXczBTQjFkYXFLWnQxV0pBNzc4?=
 =?utf-8?B?ZnN6WFNoSi8rUDB4QnJjbUpra2ZSdUZ1VGZ4REhEaXppVlY1dEdnbHVZU2pa?=
 =?utf-8?B?VFlKQUovektRNjEwRmNRUVZNb21ZbU1nYWh4cUtUZXpuR1loMW9wemVhWm5F?=
 =?utf-8?B?T2Q3NXBWSmp1b3hycEpzRSs1TjN6NzdDU2VqQVVoOWo2SmUxS2FXOW4vbXFs?=
 =?utf-8?B?bmFpelFwNzg1b2pZdy9hZ1ZxM2pXRnB3ZzJMT0FHUDVNUHZPMjljSExoZUlo?=
 =?utf-8?B?MG5jRjE3eUdhNG9uS2JUb1pYWnZISTFEVSsrNzBKaGxjNm1iRXZzYU8ybTBF?=
 =?utf-8?B?L1ZDYW1MN1FhVnFKL0NQZ2tVSVdMVnZnVHJxMDdGa1NwZU9IREwybURHY0xi?=
 =?utf-8?B?cDA1VXhUWEpsMEpGNTM2QlByZm53L29VclBtdFNmQ2cwaWoxellrdjVlaUMx?=
 =?utf-8?B?Q0VKR2kwd0s4K0VIcEJCcGRsZUo4U2Z6YS9TSmo5VUthMTFQbEh0T0xnWi9D?=
 =?utf-8?B?NGFEYWVtMHRsNXh2TmZEdFJLbXdIYmFCMEhMQUJxZ2R3enUrUXRMc0MyUGxq?=
 =?utf-8?B?MFFDdVNacU5rMHoxK3JtT2xZcVllOW9JZ0UzRXFwZDdBWnVNSHA0bU00a28y?=
 =?utf-8?B?OWdxWDFUaVV6b2QvQVhRMnRVS2JwOU9kU2NjeEZtTGNQcTI5Q0t2ZVFkNmg0?=
 =?utf-8?Q?2T3fZ3VtVAMA4B0vZg?=
X-Microsoft-Antispam-Message-Info: 4SKjZAks0JLW3KT8DI++h0YEkEvndnW/y8hJ2Gx6IGzE870BdXWfvLJO4NRwUeuM00xrb/sZGB7WkJ7ACTwDfDoA3zPrvJGpY1WkdmEZdmb6HEQyuJ9BCUwoHXfj19od8BZR6vIHdvfNVQ/3THXoqNrQSpO89RrGdqE5Bs0I2ILsY6Q0aooBc1V/RWeaWfqA
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:Q8wNOhjlSUmCB6IMAMks4rb8wNJAY7ZAcJdwwIZFZGtmKFTH1g+k6F5nqNjL4ouKLodfuqYhapvuisp/YUbY74tZ9GPrtrys7UCWRCXySiJF8mO/8PwIFxTVY1zuYQi8FYdkOKUTsaxFsg0ovEINV6g/MQvPB/S2oZhYta/KzLFHrv4IelVzCbEUSOulIm4AWjT4mW6VhURi/kgqkoFlHhjAoc8kJXIglAy5ydbGk/fCBMZkWG593NFjdfMQtpMLrSMVsFZq+n/D3cKWUpmIdrmBCRhW3oZzUNufzlKX+tmbCqJpsKU5vm2m5ciEyTsoeDJG9Lob8yKzji78AhymiJQOmqEKmd3lt7Z+6cLZ6QQNN5arEnnuIb50QTATRycGDPjm8eAm9tALz2rYsKHrUsDMwh20dBQ0CMdaujsRk+RxZY1eO0yw6Qt91V2WTyPrajekeJESLvddWv3FxBLx7w==;5:H6oN0r9rQyixz/DtYe2EAjHSyuQsfD3+VQdm09KKffPOkE9GiGZjDdPV97g1CKl+RrwnfUrt8F5Cf//g8NO9wkaWmpdg+sXuu8/V8RRGhBSKzjPaIP/tmnC4tlzdwWgJq439x9yAZqzNXsOoF4HoEuh2yi7IGBoqtldyVzyDPmc=;24:MlSqgQPI3EkmXLR9BVHOc4jNxHo7bKYa93nW7pfxoX8KaTtog+LX5yvGUNZn1l9rRGOHFODoBF0yStH4WdKmHJsJgLSdGFQzzFbBqOGebS4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:qE/5ae6oYFdSN6Xjw7Ahr8dYoHhHYyF6a43vzTiriuAmR15FQcRNJeceOPzai7/Tds4O0pD4CSGPHt7x2nAm7G9sxMrajTK87RsChhlP+quZ59GEpfpsDvzG3pnIw2bgCZD/HTNSOZnW5KQT0o489h5X8YBrf5qGOlqQc4Q5WeNhlXTTtii7t5WH+8SmASrEtqHgchq5Ycs0qwaJVSuKD/RPA4FWlavJyNkb+xlpF3dpd2ow60orGTqf78PL/jPA;20:A+C0uNocSbszKfCdpNeCrTJvNtecZdLuqRRHnK1+cwLMOhHY67511iM8xksTUJBWiAPOXVLOZJryqce/jDpBeH6QW1nZ5Dco3mhDVMOLGi0QOKBhgGXVBJHoRN5Z2cub0Z3PzWzy9gYMPi0+uwg+UYtzekUrq75zNMSEnoWGWz0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 17:46:32.3148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e172c2-6e59-47c8-197c-08d596662f3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1596385663787483882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 09:05 PM, Andrey Konovalov wrote:
> This commit adds KHWASAN hooks implementation.
> 
> 1. When a new slab cache is created, KHWASAN rounds up the size of the
>    objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
> 
> 2. On each kmalloc KHWASAN generates a random tag, sets the shadow memory,
>    that corresponds to this object to this tag, and embeds this tag value
>    into the top byte of the returned pointer.
> 
> 3. On each kfree KHWASAN poisons the shadow memory with a random tag to
>    allow detection of use-after-free bugs.
> 
> The rest of the logic of the hook implementation is very much similar to
> the one provided by KASAN. KHWASAN saves allocation and free stack metadata
> to the slab object the same was KASAN does this.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/khwasan.c | 200 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 197 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
> index da4b17997c71..e8bed5a078c7 100644
> --- a/mm/kasan/khwasan.c
> +++ b/mm/kasan/khwasan.c
> @@ -90,69 +90,260 @@ void *khwasan_reset_tag(const void *addr)
>  	return reset_tag(addr);
>  }
>  
> +void kasan_poison_shadow(const void *address, size_t size, u8 value)
> +{
> +	void *shadow_start, *shadow_end;
> +
> +	/* Perform shadow offset calculation based on untagged address */
> +	address = reset_tag(address);
> +
> +	shadow_start = kasan_mem_to_shadow(address);
> +	shadow_end = kasan_mem_to_shadow(address + size);
> +
> +	memset(shadow_start, value, shadow_end - shadow_start);
> +}
> +
>  void kasan_unpoison_shadow(const void *address, size_t size)
>  {
> +	/* KHWASAN only allows 16-byte granularity */
> +	size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
> +	kasan_poison_shadow(address, size, get_tag(address));
>  }
>  


This is way too much of copy-paste/code duplication. Ideally, you should have only
check_memory_region() stuff separated, the rest (poisoning/unpoisoning, slabs management) should be
in common.c code.

So it should be something like this:

in kasan.h
...
#ifdef CONFIG_KASAN_CLASSIC
#define KASAN_FREE_PAGE         0xFF  /* page was freed */
#define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
#define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
#define KASAN_KMALLOC_FREE      0xFB  /* object was freed (kmem_cache_free/kfree) */
#else
#define KASAN_FREE_PAGE         0xFE
#define KASAN_PAGE_REDZONE      0xFE
#define KASAN_KMALLOC_REDZONE   0xFE
#define KASAN_KMALLOC_FREE      0xFE
#endif

...

#ifdef CONFIG_KASAN_CLASSIC
static inline void *reset_tag(const void *addr)
{
	return (void *)addr;
}
static inline u8 get_tag(const void *addr)
{
	return 0;
}
#else
static inline u8 get_tag(const void *addr)
{
	return (u8)((u64)addr >> KHWASAN_TAG_SHIFT);
}

static inline void *reset_tag(const void *addr)
{
	return set_tag(addr, KHWASAN_TAG_KERNEL);
}
#endif


in kasan/common.c:


void kasan_poison_shadow(const void *address, size_t size, u8 value)
{
	void *shadow_start, *shadow_end;

	address = reset_tag(address);

	shadow_start = kasan_mem_to_shadow(address);
	shadow_end = kasan_mem_to_shadow(address + size);

	memset(shadow_start, value, shadow_end - shadow_start);
}

void kasan_unpoison_shadow(const void *address, size_t size)
{

	kasan_poison_shadow(address, size, get_tag(address));

	if (size & KASAN_SHADOW_MASK) {
		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);

		if (IS_ENABLED(CONFIG_KASAN_TAGS)
			*shadow = get_tag(address);
		else
			*shadow = size & KASAN_SHADOW_MASK;
	}
}

void kasan_free_pages(struct page *page, unsigned int order)
{
	if (likely(!PageHighMem(page)))
		kasan_poison_shadow(page_address(page),
				PAGE_SIZE << order,
				KASAN_FREE_PAGE);
}

etc.



>  void check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip)
>  {
> +	u8 tag;
> +	u8 *shadow_first, *shadow_last, *shadow;
> +	void *untagged_addr;
> +
> +	tag = get_tag((const void *)addr);
> +
> +	/* Ignore accesses for pointers tagged with 0xff (native kernel
> +	 * pointer tag) to suppress false positives caused by kmap.
> +	 *
> +	 * Some kernel code was written to account for archs that don't keep
> +	 * high memory mapped all the time, but rather map and unmap particular
> +	 * pages when needed. Instead of storing a pointer to the kernel memory,
> +	 * this code saves the address of the page structure and offset within
> +	 * that page for later use. Those pages are then mapped and unmapped
> +	 * with kmap/kunmap when necessary and virt_to_page is used to get the
> +	 * virtual address of the page. For arm64 (that keeps the high memory
> +	 * mapped all the time), kmap is turned into a page_address call.
> +
> +	 * The issue is that with use of the page_address + virt_to_page
> +	 * sequence the top byte value of the original pointer gets lost (gets
> +	 * set to 0xff.
> +	 */
> +	if (tag == 0xff)
> +		return;

You can save tag somewhere in page struct and make page_address() return tagged address.

I'm not sure it might be even possible to squeeze the tag into page->flags on some configurations,
see include/linux/page-flags-layout.h


>  void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
> +	if (!READ_ONCE(khwasan_enabled))
> +		return object;

...

>  void *kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  			size_t size, gfp_t flags)
>  {

> +	if (!READ_ONCE(khwasan_enabled))
> +		return (void *)object;
> +

...

>  void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
>  {

...

> +
> +	if (!READ_ONCE(khwasan_enabled))
> +		return (void *)ptr;
> +

I don't see any possible way of khwasan_enabled being 0 here.
