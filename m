Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpbosJBBhEqC0iK/zGr042ct7Gl+eQfXFDNhYCnAeJiGSJF9WM1N7VBlQQFn0PXfwgoNV5d
ARC-Seal: i=1; a=rsa-sha256; t=1526317022; cv=none;
        d=google.com; s=arc-20160816;
        b=MSeRgYCi5BjnE0NGoVqnLu1stxKZOfex8ulunpdsFJX5Tr7nCw0LjYqm5/UvlYEtz5
         DhKKgPmUL/4uexuhzFfixmY9zdmErx9EJAK3oYWjZBu+GpRROk4aOTZIUpUL+Gccq2Os
         FCLVbMEB/6GvTUHsLlapU6cfp+mLslHckR3vkfd004MzkogLm6EgkNRddY6pfxoQqxjn
         LJ0YVWGjVAArok7enMZ8xTM/5FTKMgGcgwSz2zpdXzyH7ZPlDXtHelyXQY76zAy5svya
         sojYmRQNBIi5EHnuuuPlJCaYVi86uEf9pTHdnB16AGL2nRTaaie2VVNhV0cBQMsxujJn
         NrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Cq9CMDezg3zP+kqBmIsgWXcsHbQvXQMlVnLfULGBeXY=;
        b=JwwsGN0L4JaFZTZCUsQYpUL8PsCEysQuKuHx+lItd2FBhkcwe15JDDeIDRjfy+l+YX
         kmUa++dg/CaVgwaCo/mYBzxZwRsQHF3eGCE268rJPgukhpvxoj2hCyXZRLoGidURrOcW
         67eZojzpiCqfH6CQRXs4yUPLSoCbxYbLU+cBMVDAb0twBvoALsZVX62ql9l1R4/j3lqv
         +zpQxMc4wXFIoO0pd6YDExfdAp13jCQNV7X4j5LHl2UZ7Q6So+hIfWm6ez9apKS2Vo0f
         kvp4l1lHyLSrcxUUl3ZoeqHuErCIY3ht/8ZUb2mZz58C8AArvWi5iAHKB9fVfM0gyIPw
         swzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Ccwv37C3;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.1.96 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Ccwv37C3;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.1.96 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v1 08/16] khwasan: add tag related helper functions
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
 <6a2a088b08c6f5e87c32892ec28b139a99d06070.1525798754.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a7ff4042-1bf6-6464-6f62-ec8783ae0c77@virtuozzo.com>
Date: Mon, 14 May 2018 19:58:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6a2a088b08c6f5e87c32892ec28b139a99d06070.1525798754.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0501CA0028.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::38) To AM0PR08MB3252.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:+8O5w4Sb7nTbbT+2yb0hL63ssmejkeXGuov6rzLMiS98kQpYm5atq2SbKGeH76HKL0wGO17JI+e7M6DvdePA4uV1V3nCcpED5qZTjZr50jv7kzUzLEr7twoFAGmw4ykVehyJYi6RH+DE64bgZeX4pZvqUYcJjKdvG9WGPZQqbmoep/aWQUEpXq4J3Fu9U1ZW5iJyrWqImIslacpC+IAAJl22VFf2VPNYgdZlnAvzNW4fwPH7vXYc9GVdAiYWenku;25:HXZyWAcj7ifQ5HpXcnHj3haalLdHQcu1XFbQavg2U7RmcK2vJWw/X/Twr4olhyZ9xV4/TplRT+dABuXvcEnNJs3t5vx1F0jFGP9cHiFAQRekD6Bb4a8j87rGFTROSQf6ZbLBvMQkjRk3otVgfGjdrQfNEv43BtsVx93tdOUCUkLsoxwNDg2my0iCOrDBcE1DtqBw4SHGTmOznUQYeapVvwrkaCT5WsBtPXZBr4k9F6/6pGtRWejXUe8c6dPeyIKJqYkO2jYcrzCieYYtByibgdz7bc9JaIPtgEPG4lT+zOWuo1U3fx+mAsyl8vbEFFSmD2V8+Sgpop0ABpbf00PQcQ==;31:Qs8pPIpBXpyc7SZTv4GM8vxn++gax6mdpgBJhOyB2vktVDyRQXGio2jJyWPrEAHSL/A9MeBASWCZmdjLLxe2yEM9WUuR7xBJhL37LDBJ6ITvQ2dZBBCP6Qk4RpopQXJV48w0KqT2TkMhS2gOjJjMzy95IcM8jzlDWvxo/6bYEXebR+4aNiuwSccYcNCGjGO+kk5MXEksF52H3rb8NPt5177bVIecrIo47DDPAjthDhI=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:NTwi0HXosfvTZrpgxdKTWl5zq9L51XcJEFigxnTk6kaH5fz0K2Dhv0QHY+GktZDnQ+KG6CaBWR8OU+oU9GuY8AwtlU5kYXmjIRKyeNVFBSzeCqjq3H6MpxJfmSWpegtQ/umtnek7gXmuWZFPVq4adKtoQksfHtHNbtQ4uOa7hLXnjIBH5cQdgRLboy8NdrDwKN3vqHrRmC/1eDS0cdqwp6Q4ZCESqz7U/zqeZlQyjHzq0TitqlsAmCzupmsr3cs3oplLeBN2i+Oxpm7SD7YLaqmqgeJ2zu45dn7617+sT50NBDUpReQpcBCv5CSnZDYW3W1Yxqp0J55ujhPpp58K6ulTdHMZ1wDO5CvbHkWLege5uydvamwQuOxmtzMwbAM8/93zlf/LT9K8YwRRlIPzsTRtaawCPUO32a3rz05cE67gjCT3GOi4J7LVybk1KgFdj3itn/e6kx5KVsF4+t+PCjIsBpB8v5RVw4qWp31RD10CqKmrd/zO2PXpuubQuqUH;4:+OL9K6NXENW3DnzyPZOHI08ZP+HJ21GTLEHw6QH1vxo0wgw1ojhAEeYaedRWQqgNr8XWz+u6ky0r93eJ7yAfWAittCUB2/l2f2IVRc8k4+tTlfI5I20ps+9T7ThkBqUwqK7nq2M/vCxgbeyfZRq96rvt1f1LIy0XOv0QyvwXKeLyS5rOd30cmdN7jjaz4N4uZ1tYSZM9BTBnMMiouM9r4m2BrXINozt1usrXSbJOmcc3M2W8htnWD4OPxPtxXHqJ1oRbKvPEIC4PD9YIRxYoOA==
X-Microsoft-Antispam-PRVS: <AM0PR08MB32524425733454E3C202FA67B09C0@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(39850400004)(376002)(366004)(346002)(189003)(199004)(53546011)(386003)(55236004)(16526019)(77096007)(50466002)(64126003)(6246003)(186003)(2906002)(110136005)(54906003)(36756003)(106356001)(53936002)(105586002)(6486002)(1191002)(230700001)(47776003)(76176011)(23676004)(26005)(97736004)(2486003)(52146003)(3846002)(6116002)(65806001)(65956001)(66066001)(1511001)(52116002)(8936002)(81156014)(4326008)(956004)(8676002)(39060400002)(476003)(81166006)(2616005)(486006)(7336002)(8666007)(65826007)(7416002)(446003)(86362001)(16576012)(6666003)(558084003)(25786009)(229853002)(58126008)(31696002)(31686004)(5660300001)(7736002)(305945005)(316002)(68736007)(478600001)(11346002)(7366002)(7406005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUyOzIzOnRzNm1mR3NZYUlYWjMrZkhxcFhpMmVqWmxp?=
 =?utf-8?B?aCt4V1NYRFRnREJoRGswakFNbzYxbWhHZXFNcWdTMGNLLzcvcHEzRzBRczJX?=
 =?utf-8?B?WldJQ1JPOGFIR2xOaGZ0M1p1MFNFNlYzTDIwNXAvbkFBYSthTEkzR1FOSWVo?=
 =?utf-8?B?b1hDQnNVSXdCTEw0VE9FY0lFaUxNa2FwMWpGZlE1bHdtOWF0U1dJQjRoK2U2?=
 =?utf-8?B?bW0yL3VzZ1pYRUlzRTBBek5oQnN0QTA3NkdXZXkyUlA5dXNhSTBSVG5tVDFO?=
 =?utf-8?B?MkxWMGRJSUEwRmpZbzZrRnJCTHFZVFVKN29ORVlKY21uaXZmZUh3bVRPQmRx?=
 =?utf-8?B?VXZoWmgvblVHOHRwOC9jK0dKTGNLSG5aNm9WUnFGRDZrNHdYTW9HUWhhOHU0?=
 =?utf-8?B?MjQ2SkRkSVFRYksxU0ZHbysvWHJMR0FXVzdwUXUwWlpLVXhsb3g5Y2M0YjdL?=
 =?utf-8?B?TFJkbVZwcFBEMUZiR0Z2VEgrZzgwQmtmRU1Rclp6RFN0RXNKNkM5eWxFYTc4?=
 =?utf-8?B?UnZGRElkTXRFbjVpcmFZZkROMWZXVnYzTWpaS3lTdTdXRktHYU5Pb3BiUXY1?=
 =?utf-8?B?ajhBdmJTVG5abHhCWWdJWmdJNWt1MEgvRDVRSjdWOG5NVEtrT3RqcE91cVNO?=
 =?utf-8?B?eEFEaGZTbFpselRHOFB4MG83akE3U0pwVThBM2pDVUxMSDd6Rk9IcDF2aUV5?=
 =?utf-8?B?WFBGVXlaVHhjdlJDSlp5QnFYZkJCdU4zVGRaamdPNW5iR3RqUjRLVzIwa29O?=
 =?utf-8?B?NStCRUZmcWNnSXpFdzFaOXZKbEhQaE54SkRrN3ljUWxzZjNQeUxEWHRURlF4?=
 =?utf-8?B?K1hnVFFvRWlZZWU0NTJGanYxU0dSeDlhaUJTenoxSDgzcExMeEFRZVdNSnc3?=
 =?utf-8?B?WWg4bDl2TS9Ua1ZkL0tmbDVPOWx6cnFUbXdjNjkzQkx4RG1iYlJwaTdmR2lG?=
 =?utf-8?B?N0NiK2VjSVhLM3p0Qk5tbklTVzBOdFl2UllRd3RQNVlZU1hEWGZzMlZtRGZC?=
 =?utf-8?B?MTZpbkdMY3RDbGxyeEZYTWs4UGlDaXhhT2xjM1E1VTJhdmFNbHY2RWp0czNz?=
 =?utf-8?B?OTFJelJ1QldEajc2bHhnREVHT0VNNGR3cDJRNk1kQUtrT00xdUk1L0ViTE40?=
 =?utf-8?B?bUwzbVFHVUtDdTJKTjN6TkJYVFYwT29sb21wYTQ3NDJGZTJzVmhPb0I3NEZt?=
 =?utf-8?B?VXd6Zkp1M0ZNaVJpVUR0cUlhVFZGeVNUVWN2RmxKVnBPL0psL25PWVFaOS9D?=
 =?utf-8?B?OE9pc3dndmxkaDZtRVhlSnJuNkFKMEw2c2IrbElTNk5sN1FuSUNvV3QvaG9z?=
 =?utf-8?B?aTlXOW9zTEMzMXEwNjl0OEN3eXNIdEhWVXpnODNsL01KWTJDK2Y2YXBubmJK?=
 =?utf-8?B?VG5kTWdZMml2ekw1eU5pOFdDNmlVazlnL01XZFFWMlVXdzNjNTc0dVpBZnZP?=
 =?utf-8?B?SWY0N2RlNjRucUtXaXlHL2FTWlhVejRHcCtvdlBDZkNHaXJYSEFmTzlDRjY5?=
 =?utf-8?B?bDRhRFJRMFZicVljbVh6ZzF4dFJFUDgxdkRRcTlDZWM5YzVjM3lUaHAvdC9N?=
 =?utf-8?B?djRpT241b3ppSFNDZnJMMXYrMThTOXlMMnluNFY1cHpKaVE5RzVwOXQ0ekV4?=
 =?utf-8?B?YUFWUE1QQUNST2FjNVVXSngyL1JPZDZ4dFdyalVuQldsR0dobjJyMTUra1Nk?=
 =?utf-8?B?ZUVSbm5kZXFKSU9udjZKNE1xYlAyVjU2ZUwrd1ZWZVRDYWZGOGN1V0hhS0xk?=
 =?utf-8?B?dW04MFY3NU9idmZwV1FWSHFkZ3RuU3JaU3I5bUpTd1pXajJ0OU1CbEE1TzY0?=
 =?utf-8?B?dkZIaHllLzltV3lUWkNiK29VckViOFRqc3FFQktLbWdLV0ZaYitRN1NXbkxH?=
 =?utf-8?B?RzVRdXppVVJjWG1YWU9icHZsdnh6RVdrSk13bjRKOE1qMm9nSFRENXRQU2ZX?=
 =?utf-8?B?TjY5bFFONThTT2RJNG1Hc3M2dW1tUlVKbVpKY09selg1azFFV3lPTDRkMkdH?=
 =?utf-8?B?YjExNEVkNTRMY1JGOXNDaDhYaGE1NU5UT1p5QTFyMHBZMDRvekFSeEZqMjNI?=
 =?utf-8?B?ZS9Ycjk3ZEFiSG5QaDdzQ0VsSllzaDhpL09OdXAvRGJWMm1lVVc2ZTFUSHI4?=
 =?utf-8?B?K3hCU1NYNFlWSndUcy9uckY4Nk5xQTRJSDBvYml1TW9sZ3NYbEZGZjdRKzJz?=
 =?utf-8?B?cFU4dkhsbEJ5MlA0NW5odW42NmFPaGlkZkVXOHFCNk9jOUpDM1VscnNXUVo2?=
 =?utf-8?B?QVE5SVdUYWZycE5Lc0NPOGIxV1JqYTNrdFJHemU4M0ZVZkNjYy83QT09?=
X-Microsoft-Antispam-Message-Info: p5c97mkpk+wzEIWJKv/8i4G8cAGJRfjJTLGjbBQMIzjkHeGmwcOdjfVnpxre17mg7intJUUIYppmgzhp0LF75c89i64qVyTL8G+DUUDMLBQ1ZdqFjstQJr/4siBh4La45H0fvEM1KMSh2BY45lPMZKdrjRnnl0cMF8Q4cI29lv39mkLc5G3sm0l/gF+wn/v1
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:3hpXDvXHIH3LfaQooxfKcD3WVdam3LtsO4lQ7dgxMua1mTlc4MOL6uexOU/V/8/f8HVYeqBqHCCKwl4w498M7CgVHRSgBtpIv8yWfv+NsMfTF9HOaHfUYHA8bJkiBgMU1TOLt1IDGNkET9Kih3TmM19DX7UO5wGdeoBbxjmB0nw/i//XQvTjGvysfz24sk6qao/nlFOKVCj2u8IIkviQQ4BUcBDl/FXSwsFluh5QnOSoxIQBckWhWS5ZYTqF4ROqPtiu+yF04iR70pUkaF8s80qLbXFyWFlH9PY/Zoe+Hy1NyvRAKKPimiIoB9IkJ7rDzJ+5MdHlYlmRiIi4v8a9Jj5BSBSPsz/nGxmF65Kwijj6+zOPQaB+7sQRlENfKgt+55eQ4YP3kQRbzt7GO9R+rATn82EbcWgzaUkGmohSZ34gzEMXd89B1ee4t/1b/spZnd2kq2Ea/TJaSmXB0q4Bvg==;5:mtFrqYimeiiLmHw39Ihr1+HIHPwSFfzTd6GBq47fXPOtRyBB1W9N+MPJHy7uMAWHE7y+YmTS657DmKWgUeBG9r+6d+ScGvmW79qzn/ug02A0VHjyERoEdu70RAQdqf8HmavZ4pmGCYHaeYvBUcuU3Sce9LFeNcD00EANZmzbavA=;24:+5g0CF7iSY27rKEC64CYMeAqSbYhXbOQWPc/3kjumUaTh/ocUXZ9ao96dc/bw802gE/SBmlLYJmnb15ECylgWVfSlRQuByr3L3OgLsYkFbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:nCfiEsohNrDVG8qWxK9BSRkut3YPi1Vu8mIBOuxKVon4SLasWNGG/pP3DCnHN50LeqNAbnWxzR2jxSjxiuJ4pwHPy2GO/nEZI+KTjKZJ0Wtbsaul2k3Ed3Z5+boEiOvSHdebp8mTdHO8x0HpzbgzaQk8gYrvhnf0lU+oX6/JlwyRzyQI1oU2UTWmOKML9OuxSSqI8uhjbbKjLV/28As0N0CBNnYBg5DLSmo/TFJTFakLn+8piWxrOX9mWotGwvb9;20:ZEqkmN24VKewVsQzMtjgiqk4hlPokJKmAUaCzgHZ3jtkadDSqJJ7TyaMcblYdIdYPksTkOAEmHOPp3/TSL6T2cJpB1sxrzfySnuD7uM0XAZ+PimWhpD+vLSO/XCFEwI87VqrIr2uiMOhGoV9pYLmhX6o2Ds7rz17Ysv7PagMpOo=
X-MS-Office365-Filtering-Correlation-Id: b1bfa278-4bc5-434b-fa2f-08d5b9bbb261
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 16:56:49.8081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bfa278-4bc5-434b-fa2f-08d5b9bbb261
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917352779792579?=
X-GMAIL-MSGID: =?utf-8?q?1600459397946653000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 08:20 PM, Andrey Konovalov wrote:

> +	for_each_possible_cpu(cpu) {
> +		per_cpu(prng_state, cpu) = get_random_u32();
> +	}


Use checkpatch please.
