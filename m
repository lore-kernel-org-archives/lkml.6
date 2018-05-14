Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZosQSumz3DJp3xMKLgRcG29wKma+yL9ab0VCB4KFcDEF3kG6t03i61gfDDeOaxQUP2WeWTA
ARC-Seal: i=1; a=rsa-sha256; t=1526316920; cv=none;
        d=google.com; s=arc-20160816;
        b=hxGVZPWhFhxlBxWq0eFdqy+08dQgLFh8vvjOpEHy721JyTRQ/qKqPkt5bRAJk1PjL2
         5Fq+wBwo2DsBWX4e7oDZl95j8YYfYWS4XbGfr+vy+H2iaAWNzgEIqcdWQRdc/GkIKnqt
         QqVqOUGwjTmeGfbDEUzsfu+VFTvS0LXLpkOP63L0x6XgO0fGgO9H0Lro+72LHckW+A7T
         AFN4KwWyHxvwaM8qtdlHwc3uolk7wliqY5xIcakjp+sPXskj+9NjRH749LRltVje6xfe
         rUkzHXb3B3InVxHQIRGM1cmmQCuPtg4+roCt7hmRDjTBLVrBlG7Zfq+mr0ScJCV48xX4
         mDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=mE5+LMs30+RwWbrhndcgsq3U6TRj6WUTUOnA18Bfjuk=;
        b=WAR7+J5vziwcc8RkDgrQ3QBEaaJnZeQzO72G00Q59kKsJhLFjTY0VOyhCw59YnmhZU
         6iKOidwkJWYaorf/JVLbockuWLTPgTBsfx2gF5Ht1/oe9c1djHKoQN2SCtZKgAFTyZ6Z
         FxbXe0uMYZpAbt1A5eaVFYRFc43R2NcRe7A9efFH0CbZwOgSiJpSV+WvyjXg4d7vkS1k
         FCKYXvyHYz0klG9bF+mtHX3ED1XKp0nkaQaihysIQkYFywMKGJmdrbd07MoSLoX8cRzl
         HRvv8YfRotBoFM2NebVmydXt70oLTuH98vhmqQJa0ztX9NVrTB3yPELWamWCP/EA4TQt
         Ih7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=TNASVfPh;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.132 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=TNASVfPh;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.132 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v1 01/16] khwasan, mm: change kasan hooks signatures
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christopher Li <sparse@chrisli.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Yury Norov <ynorov@caviumnetworks.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morse
 <james.morse@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Tyler Baicar <tbaicar@codeaurora.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Sandipan Das
 <sandipan@linux.vnet.ibm.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Lawrence <paullawrence@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Ross Zwisler <ross.zwisler@linux.intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Matthew Wilcox <mawilcox@microsoft.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, Hugh Dickins <hughd@google.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Laura Abbott <labbott@redhat.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Vlastimil Babka <vbabka@suse.cz>, Pintu Agarwal <pintu.ping@gmail.com>,
 Doug Berger <opendmb@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sparse@vger.kernel.org, linux-mm@kvack.org,
 linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov
 <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>, Chintan Pandya <cpandya@codeaurora.org>
References: <cover.1525798753.git.andreyknvl@google.com>
 <427db6b29eaf61d77cb485e9e0a393d34741e498.1525798753.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a5c36c49-ee50-5298-424c-043a591f11e8@virtuozzo.com>
Date: Mon, 14 May 2018 19:56:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <427db6b29eaf61d77cb485e9e0a393d34741e498.1525798753.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0501CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::28) To VI1PR08MB3261.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3261;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;3:avlpLSX9fuecb3mQ5TZ5JYZLSW9buEf8BQUz2mnH5RySeYPpLSzbSjymjy1Bj8xKII1IBmOm6kGD1bO12/boAmA/2x2TUpn8lSzJNry1hlG4+69BUvK2hM23scWJNSq7r9lbpHJtERRw6gNxz+x9Mg9yg8mB7KSN0ONfIhkd4XECjAzdd1C27S/5d9+9bA0j41v/++td1sNBYFv9GeDrppGGUfcP7KXmLO4ZJgdzFabAU3C6MZnAOlw4FQilkApp;25:hF1cNt5GWq+EiVAOflX91negfIBnHNuZ19e+9kYx6H8v96pBofc3LcHW5efPbQps04jz0tHd4k5H8UgjpjxqIOpTM8HfZG78HPgSU/74yGToeH6eVNIv+kOcO6o/nxFvjLrfpGJdc0AmYIC6VBCKYUjiNDV3/a/+8uEj0CuJTKgWA3t6i0Kk/EWnXNqJfDOysps3XfnZZZMk/0ZxtjWtX9QnENOF3OeyiN24kWhqZ1Xf0NMmXvD4UzPhXgwgrvTDGQfz8xF0MUIy589HUIiMuOMQZ4/r74l2AOLnhXDO8FHzuI+8JbM9woq804dAA9sGL2GnVf6EYmO0hEQl/RDLMQ==;31:Kcs3ZNNdmiZ3t3cj5W/twbRqb5m3ysvyphmO143YoBx3u81c1MnsE04cPjwRcwuoxvJXXMYf7yRZAf+/jucQXwfomXzXjXNAbF1bdxNVpX7IOmKr5KmifQwnZVqHI/MK7gBv8ZwBpziYX1YQUbDKDAUAW8wALEEUkeyfJ8fuuwjviS/zteswTYViHx+8swlXkVfvQINV3nNQD4wFyY1tuRzDipenybOBqC36Izy9eak=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3261:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:4jgrE1ywXYAvqowm2gLjnacVKpqsroifXTgBZs18zyuAegbgJf28a94oiu36maDQHqIOIZrp63hG5Ps/Y6qb6Xvhb0L5QPo7fZq77qTNGEgTeH7heQOQhd53G0G59nb0P6TXXfV8g4B4+rx1xEdzl5uKWm5aM+fgB5wud7pI0dL+bu4RM9FKsiijLqI42Dt/VfvOwpneoRrj9UcCKvevjw7iZIboicZ6/MPzLgOVcmfP5jb+34ePqG13A8tiBBH70CvIydxrxkZpTMePErStjPOc8m396Ws3tehzP0o5l4MlsAW8K8ZHbeu+ygySrKrP407/dNOrtdqmzyAexKAwazQqD8d4zn7pimnBKVq35WmeOcoQ8L/G92TKjjZFm1xSCdVWiawNwI35/au95us8q6zn89zgnStmh6NGRtoEtY6AW64tfwriU04vv45gHFF4gVBbpuIdBSDmh6aok6ANeMNipGpybx66zs5nhWwWVHUTGobtZneEpdBRNN5tFBzF;4:oBnOD4dbfepW8F8Y8W7OkhGFnmYVPwa1NZ2XtW8NbgGEYpr3kJO4TjbvtrsxpRHxz4iXf++x5d3/UXTvHtQHGnLp0zL+LniYNyrA6BFwyUZTczDgQYaNddtS2FVcc/4FAFzdRoM8zGFrLsPj2mezd/ETp4FDCxz8qXLkThUPOFfhXAyjA81/pNQJ/P1ILvg+TCtyL0X0oUy6TAvvyuWH6vqHwMaDPbiKJuBDGu/YWuWHb+isnJSL6qa5qvU2UuFaGnQJF6/4aYphZ/r/aI65Jg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3261682635D18EB24AB2E430B09C0@VI1PR08MB3261.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3261;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(39380400002)(346002)(366004)(376002)(189003)(199004)(26005)(2616005)(77096007)(65826007)(478600001)(4326008)(6246003)(5660300001)(8666007)(39060400002)(25786009)(956004)(7406005)(7336002)(7416002)(64126003)(7366002)(486006)(446003)(16526019)(97736004)(11346002)(476003)(186003)(81156014)(8676002)(305945005)(6116002)(2906002)(81166006)(106356001)(105586002)(31686004)(23676004)(6666003)(55236004)(36756003)(76176011)(52116002)(316002)(53546011)(86362001)(58126008)(1191002)(52146003)(3846002)(54906003)(110136005)(2486003)(66066001)(65806001)(65956001)(7736002)(50466002)(53936002)(68736007)(386003)(31696002)(1511001)(8936002)(230700001)(47776003)(16576012)(6486002)(229853002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3261;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYxOzIzOkZ1NDJFb1JLNy9rT1E5Q1RabHI2ZEFsR2tl?=
 =?utf-8?B?SWp6Z1B1QytHV0dwdlBvV1dDSVRCd2lpd04vWUhXRXFJckhMUllzU2daYW5a?=
 =?utf-8?B?TzVrcmpGclVmWmdCdlRqM0hiYUhYK25EeFc2MkZYYi9yTkFOM3pQVkwyV3RN?=
 =?utf-8?B?a3MxL2tRTmxIVGlqSFZ5UFRCRVlaMndYQi9rZzc4SWpRZ3pITEREZWNiRlFw?=
 =?utf-8?B?U2RSdVF0dG1YWGdIa1B2RHIxamx6L25aK2Z4Zy80dnpFY0tLU09BdFgzTTE5?=
 =?utf-8?B?NG5wZ3NJNHlPSEN3MTJ4OFdIZUVyQnJEUkVKbGVTUkRQKzIvNG5NZUJKY1hn?=
 =?utf-8?B?WmNCNnFDa01ZNGplRnRHMFk3ZzMrMEtmaGdSOFVSVG5zdWpSOGtHMlZoMnRE?=
 =?utf-8?B?ZlpubEFocUY2R2hXVEQwV1l5T0ZhL3M5dlllS05KZjc1anBYdUtBRnFiY1F3?=
 =?utf-8?B?S3pXandrYm5LdUpWTnZSNDVFN01CdFFFK2hYRzF4OXFTd1VKUzJNd2RzOFFR?=
 =?utf-8?B?Q3RNSmdqSUhVckVPNHY4WDJiRGtxZXlRZURBaXNDUlB0YmVEcG9QNmFyT0l2?=
 =?utf-8?B?eE9ZajBnbnRXektRVVZRUW9zRmY1U3d5aFZwdUZYV2dMRGIyNU9oRURmNDV5?=
 =?utf-8?B?NEl4OXNnODRKQitFNVZvT2ZXOHdJUGxSQmpOSTBhdVoweFo1VE95VlQvY1VQ?=
 =?utf-8?B?WlRyQzU4aG9SclRzcnpoSldoY3pJKzg2TFc1V3VyQU1EblAxVHRxNFFwYWRM?=
 =?utf-8?B?TlpZR3o1ZTJhUzVjdlVTM2JhVnowNWUrdVpibFI1RndJSWZXQW9DY0VEMW9N?=
 =?utf-8?B?b25sZW1BSkZQTC9qN2tZYUxYVkJYNU01RTFabUtJRlVGSll4eHJlK09DUHJC?=
 =?utf-8?B?NTZXOUFjdFNmd2orcmF5dk1UZzc2Zk5CNEJDQnM5MURlemtYTDZMSGhBT3Rk?=
 =?utf-8?B?UXcvK3pGMmdYMDhETUkzdWRKOW0zQnB6S2h1TnZlakZwUll6WldSN3pZRm5G?=
 =?utf-8?B?K3Y3TDRxQm9BTk82dllwMlZQMzhwS1loWG43ZDI0VElZMnpXSFNENWt5c1E0?=
 =?utf-8?B?UzdnUEVMcFEzWkFOZC95SGJabThDaXEzN2pPNlpHRGZVRGxmVERWcFJ1elpl?=
 =?utf-8?B?bmQzWFpMMTN1ZGthYTNQTk5lMGlpckhuaWxkUnR1YUErSE9sdW1vV09meVNL?=
 =?utf-8?B?NVB5MGViNUt3Z3hUMTlsaUp0T0xST0FGU1I4MFBnTnVITXBNTkNJVzFhQW94?=
 =?utf-8?B?RFpqTDNOQldpRlZBWjdlbmVqcDR2Mml0REt2SXl6bFZ3L282UVBHSDlMWXo5?=
 =?utf-8?B?ZUNudWNPWHFQNmpsYnMzWXpKWTlWRnhqdis2VkVQOFJIc0tvQUNXTWNOMjVK?=
 =?utf-8?B?UjE1RndzWVlEQ01oQlU3end0a1E1cDZTbi9mMlpyK2J5Si8rYzQzL25pSXJX?=
 =?utf-8?B?OTdiMTlYR3U0UVMxTml6blF1TGt4Z1M0Q0wyYkw4VUdZSmNKTUNDWHVQUFFy?=
 =?utf-8?B?MWZ1ZnExdFNnclUvQkY3QkYwSVg5SE00c0RyWUdKOG5BUjVCbkRsbXIvaEd1?=
 =?utf-8?B?NkNEVWVCTGxCeTlFUG9mQ0hBNk44VFFIbnRncFhNTisvV0ZDTGNQVjhUOGpG?=
 =?utf-8?B?Smlxb2UxaFFYN2taejZLdGVmLzJVVFhISDNIZ3lwSFE2SWFZTGkwV3d3YUJx?=
 =?utf-8?B?bTJ0ZnNkcDRWcDdGdVZ2cU0wd0hidVUybUVsUUp0ZXRqUFdlN2Z0VDZrU2tp?=
 =?utf-8?B?Z2NPY2svSWpFY0piUmJxdndvL1Z2emdlVHJMdTl5OHE1aW1YMXBaV3lmODBB?=
 =?utf-8?B?Q0xheDR5bGwrOGVyeEVCN1JTUzlkaHczRTZDdkpzd3BMbUdTQUtLWjhGdFhn?=
 =?utf-8?B?R1A5TTdWOVIwNkVYSW9GSER2SngvVTJ2MjNVUVNUemFjbnJYYmJxSVYvcmY2?=
 =?utf-8?B?c3hQSFl1K2orQ0crRjNCSkVLMU9nVUxXR1lCOVVMUHpUQXpPODJpSmFLMHBQ?=
 =?utf-8?B?ZCtpV2x0Wis3cEsyaUUzbTAzVTduSVJjMmNHTGYrRm9mWDdXamN3elFhK3Vo?=
 =?utf-8?B?bmtJTjJWeWk3bTNTRkdDMGs5bTJVSDV6cmx3TGVncmppcDlCWnVmUG1adHJt?=
 =?utf-8?B?SGZZdy9hNHZHN0Y4QmtROHp0TEZmU24rbnp4dEhSeTI5STd6MHNIRWoweHhN?=
 =?utf-8?B?ZC9nbVpjY3kzU3dOWE1YbU9WTlNOSHN6RjFISm92aDJJb3J2TU50KzV3b0xL?=
 =?utf-8?Q?mM1hhn/QQ1Sp4KgMV0?=
X-Microsoft-Antispam-Message-Info: UuiPPRLe0C6ch+9/GOHn7S38ABDkj9PVYTVsxTLBH077+4hBUpetm1Qej0VdKAgFwP7CgLIVu+BbtVY7siuBeQ3e3fBiTsIC056P77uC2Zg0kHEJ+PcJ6+MeypGrZKJXbHcud1+sXGjRUJH4lIHcwYpwKEZNaHyRir5vsMJw4Ax/wHvSb0IJMXBr2Lo0o1cX
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;6:7wZ3oVGWeAi10Ri8O3I0DmNTHRDh1ZRPmX5mUtdpqtU9gsq4GTJWb7CwfRB3JdYc9fss6icEoGK+hz5q7VR/ebiPtvPNbzEMw6fmnbvKlv53LtnxZibEpaEN4kAoV0+Ul6g8lCKTj1tSMKdTi4D8kE5VWXI9OcqEmptuoud2JujGm0n6iX12UuqZ2O8BjCBlSucaeIFcLUOTfLWCAcblEzPagWXNSyd53LPoTgZZf1dNY9JrMpLueVokMTYkPG6mfqTuF8SzX6r+LzQ+F2XqNM/yB7hp3PdJELnCBaNci3EyVEGQ5VkggvN5/rEaARVQrkJT1JXggKdokhl3U/nyPI6LCPsTnvH1B/f5ts8VCPfzKfvIsDS1cJ+rzzUaJu//0TlHdAX16jYt+bhM5ErSOLnfm6zy8eZWorRwA2u1gHImfNq3d8+3oBQLXhvY7YjkVg7xbSprxoyxHdU/W3y8/g==;5:mSaXGWYCTa0qC/JwSSHR4Y/bC0fFkadZ9QUbBJ682oHx9/fh82ej2ELTVMe44YrylYSv4+IWvsNoIofkDEuZL0LmDiWVAm9aiEDJShwcHlZ4RBBa95hJHYIA8jqSxlxl1EF37u9Q6zWeUZ3mPFBe+J1fEJcTk2+5qQBu4UX4IbY=;24:VnjBVTvPV379HZpwAMfZg7YX/qVNW/gyeYUwF11R8Eh7YBD4w6buRotQhue3cSKvjWKliDHrEnXs1SmvlXbbzB3LwSgp6iA/73w7avmNEN8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;7:oOu2gucxvWiOQN5S1+/fa/8+ZGW8KOywpMPE4oLbnovtGtp9pADvScWqsjOYDDTkY96uiHZPawamPzjfPDFlHjcUfDTzN7TGGuM6H37jW59wRwq8eMGeMT2uR3IcYVAb8PZZFdFle73N6SLUS4xS42jNGZgY2asp0SgKmJM1ysyrr82JDaZSwdVc69SrF7XUvHqRcSgemi/ft7V/vmD2SJS9gxLHdArZ+8teeZMix122nTldQ8yOZnHA4MbOaNPa;20:Ouwgh/EQTNj0BSDEA9D0AoyFHA+V7cCWXZwmvzgW2csjVn+Yr0rntk5aImH+sj12R+CZpBdylhY1nadVOq2e/Xo+cMG4g/HX/pLzRTjsugVg1bQF4hsOJd/Ffj62KtAtkr5MlVhd9D2qH+WEORPALx6AoEpd1UeHkkH4Iy2xsvw=
X-MS-Office365-Filtering-Correlation-Id: 1e7848ab-0d82-4bcd-7cad-08d5b9bb761b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 16:55:07.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7848ab-0d82-4bcd-7cad-08d5b9bb761b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917337314595077?=
X-GMAIL-MSGID: =?utf-8?q?1600459291493279247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 08:20 PM, Andrey Konovalov wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 44aa7847324a..4fcd1442a761 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1351,10 +1351,10 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
>   * Hooks for other subsystems that check memory allocations. In a typical
>   * production configuration these hooks all should produce no code at all.
>   */
> -static inline void kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
> +static inline void kmalloc_large_node_hook(void **ptr, size_t size, gfp_t flags)
>  {
> -	kmemleak_alloc(ptr, size, 1, flags);
> -	kasan_kmalloc_large(ptr, size, flags);
> +	kmemleak_alloc(*ptr, size, 1, flags);
> +	*ptr = kasan_kmalloc_large(*ptr, size, flags);

Why not 'return ptr' like everywhere else?
