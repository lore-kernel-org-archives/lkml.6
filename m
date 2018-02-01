Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754969AbeBAUPh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:15:37 -0500
Received: from mail-eopbgr20115.outbound.protection.outlook.com ([40.107.2.115]:21015
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754926AbeBAUP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:15:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 1/5] compiler.h, kasan: Avoid duplicating
 __read_once_size_nocheck()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, Kees Cook <keescook@chromium.org>,
        Eryu Guan <eguan@redhat.com>, Alexander Potapenko <glider@google.com>,
        Chris Metcalf <metcalf@alum.mit.edu>,
        David Laight <David.Laight@aculab.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20180201180052.32643-1-aryabinin@virtuozzo.com>
 <CA+55aFyLb6utrR_bCRj1JXteuvVchiWrsNNkjM3HetLHNxHx9A@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f5868212-8e79-e7f8-658b-063b8d774db9@virtuozzo.com>
Date: Thu, 1 Feb 2018 23:14:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyLb6utrR_bCRj1JXteuvVchiWrsNNkjM3HetLHNxHx9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.47.128.244]
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To DB6PR08MB2824.eurprd08.prod.outlook.com
 (2603:10a6:6:1d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26205e7c-f352-44ec-f0b1-08d569b0873b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR08MB2824;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2824;3:v5pcuuaZ7sgWSCcIvK0NefPkjtJUTsf/y90mAIixSvXrgfMiOeSWFonb3Q0Vik7J3epgdOE12B9Fmm6KQGNpf3NgQX0tHXM4k+L62afY5O9frXK1Fkr9ZUDboPI9k6StBRH9Fk3DEvKd9xUulOLwpbRT7fNRTkXRFqm8oGxFvacuNEnNj57srtLhGDCPxVQesd8jcNYSIc71qjf/tGczpPdbxf98sJpCRd9Db/QHTlGDHGs3LjK/1XpELdA1mCyl;25:jN5p27BqyMLBqrToL/pVWXb7V10u7Cqf1Z5CS7cxezRhsQ51hbJeNctSWo6XRzXFZr0W2ZpbqTgRSgBdSJ7WB38/JHUKY1PI0q+bVDJqQANTjMIcM+OFtqD31iinRXBzuQAIJ600jIKmVLV64CY/U7+Sn0yuBMFL7XCtCzDPRl8PwClEnItU5rMLVOVAWTrA/fVGL2ER0vqhEFG/JE7SBHb1jX7OzHVnDxR+BKSQq2G9Hehx0flONZfepSFNV7v0WHz30JjBsCtg/3fWmZo7xWw3maoWHp4DU/H10NguX74oP0maQ1MjjGpKC7brVis/lsDvQY6vBwBCrNHeM8uf6w==;31:T3NUad8oVLv/wEjyjst0ykuT/J5S+0itjWYcWVayTy7bXV1Xt4CutkjOdubRvDNBTM6fMlr/D3UZ0EYxekDcTz/l3BqXfapuNC72pj3FcvUatJaFe8AZ05dAggnIZDxB0xITyjnP9tsPdkTkJM1cyWjbnqJrmG0QRYHkfPpn+IkDgbJwRyH8SkXooTFbznUcpFfB1A3FbCXUFwRelznOJWhWCu/rKBciR5eFm5El4YA=
X-MS-TrafficTypeDiagnostic: DB6PR08MB2824:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2824;20:t9BfSVSw7WVHtBTQ5Q+CXVJp431ciIisSx/7JkoIf09es9Oeqv3wLN57MYvzF79O4rnhC0aJohoSYLijGk1jgJeI3BYumVeLM4BcB5eleixMeSUEzJdpJ7fOhyn5TycY56fhPqEfqLvAdWShaTDHIW/eGq6+64WGxi4zsatPOp13LxB5JyhdD8JIsWJPzPYfy4UAillJZxAtv7iNorYYvCBEWbKXSi8tAUKmxi83ilS5WeUhiIbOZzw/S4iAEadJcYD+RVLj27++R/7NcOqduLnRgwLM2dawxTOAbBhGYqq23M036nVHHx5uzZy54tnrZqJUGkYzezPX4/HoT/vxPPX6/49SM05lchZw7wgl3xRsmW3f3xbJWGhBLmhs0bRTFT8LSNIsTR7oUNOmoqav5a/TbYOMTqVHwfSUKt5PxX8=;4:+s0dCw55yIJbkO4BzEsN1vlq8s0b6xxry50NyWAaAqrIJyjYhQWy6Bhs56mKdgRRFSZD6a0+nc5AU6xTNcQUDr4o1qm1Uvq8SkiAVruVLEPWgOnUXJguTbS339kW7IrjGlKGcUGg8tTA39orpiTLgRvBnErLsxTkW4/HOyA7DUMNyE8oKkjq1vB+amZNLlY0M3ptY3cfWhUMwg3cowVJBgdJ381juno5B8tiygFVoveX8r91oVV6vUgm+2Xp2Z5+rlJRI0VTXOdpd5rRrI/gvw==
X-Microsoft-Antispam-PRVS: <DB6PR08MB2824F83C9C91F3198D27756FB0FA0@DB6PR08MB2824.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR08MB2824;BCL:0;PCL:0;RULEID:;SRVR:DB6PR08MB2824;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(346002)(39850400004)(366004)(376002)(199004)(189003)(478600001)(26005)(3846002)(6116002)(25786009)(8936002)(7736002)(305945005)(77096007)(386003)(53546011)(65826007)(5660300001)(66066001)(65956001)(186003)(36756003)(31696002)(230700001)(53936002)(16526019)(50466002)(97736004)(65806001)(558084003)(76176011)(68736007)(47776003)(81156014)(6246003)(86362001)(64126003)(81166006)(4326008)(31686004)(229853002)(6666003)(106356001)(6916009)(2950100002)(8676002)(2906002)(83506002)(52116002)(316002)(16576012)(6486002)(2486003)(23676004)(58126008)(105586002)(7416002)(52146003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR08MB2824;H:[10.52.82.104];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4TUIyODI0OzIzOlRlZmQ0djQrNUNHTzJQUVRYaStnLzlOUHNS?=
 =?utf-8?B?d0s5NldqaGpFbFIzc01iYm5xZVRHd1QwNmx6TzE1bDlHM01ROWh1NUdyTEpG?=
 =?utf-8?B?T0t0dG91Nmk2RUlvdldBYVRoL1dZSDJhSHdUUkJPRy83UDB4eEVOYXFpZEx2?=
 =?utf-8?B?SzJjSGdFTlZHWmMrSDF2NVJ5NisrK1hNTjMvS2c0QkVRamFPNzNqSnk2ekhC?=
 =?utf-8?B?RTlNVEEwUnIzdXJPZ2h2bXpCTzZhRWJTMHBjaEpGeXlLOFpjclA0Y0JhSEtj?=
 =?utf-8?B?MXhnelVqUVNHdllQVXZqWkZYR25qSjBqQmYwdkdLc2FKTElVYVRSMy9ZS1dH?=
 =?utf-8?B?MXVWdlRnTEZhb1lOOURRM092WGJKai83c2dsNTFMNVczNWJHUTBQSjBkL2R0?=
 =?utf-8?B?RU1XODlsZDNLelI4R2FZN1Z1V3l2bHpkNEZVNllwQnpxOHJaQnNuSkQwUmZw?=
 =?utf-8?B?cS9UcFo0M1RZbkh6UlU4VUFwL3hoQzZuVzVVWkxhS3pqMXcyVGtXVXZSRTFH?=
 =?utf-8?B?amcvTjIxT0xZRDFBME9kYmVxMFo5ZnhJSEdtdHRQWndLbjNzY2pZZWh4T2ha?=
 =?utf-8?B?ZE1pS2pERHFuUVQybFcyYk15ZVY0SnRpUjdlSjlpMHRJV3AvV3NjUGxxcE03?=
 =?utf-8?B?RC91NFRxa0hpTldGVkhQdU1vc0lNTUZTbkR5Sll3Tk43UDd2dVlneFowZ2FW?=
 =?utf-8?B?VUQzZEduREgzY0NPTFZSaDhFV2dmbUp2OURzRTI5N0piaG5UbjdmMkxaWkM3?=
 =?utf-8?B?RzQrSmk3azhkMG5iNjduVTFlZWhJaTZxZEpPUDVpUGhHTnplYmtVQUZaZWJv?=
 =?utf-8?B?d2VHdHdWYk9kZTZPSStsR0dwMTJnUGN4Zmh4RVZSam5HN0pxU0Q1ZHFzVkJZ?=
 =?utf-8?B?K21RQ09YZXpiR1JZQjZxdnVyOVRqb2FGajB5WW5Nd3BiTUJ6Z0NiaDBFUnBK?=
 =?utf-8?B?MnE5T0R3aUJxQjFIZzFGZ1E0d0pxU3VrRCtUU2FKK3F5QkNlRXJqMWFlUFo3?=
 =?utf-8?B?ZTBDa0xHNzZieTc1dFMrbU92LzdyQVdjaXpSWjFCclVnS2l3ckV3c0xkbmxX?=
 =?utf-8?B?ZS81SlVoTTBSS0Iwd2EzQUlaK1g4d05CVk0xTFZlYkVSYWR6MHRPTnR2WlI4?=
 =?utf-8?B?Y3U3MmVSUlNGb0xGRmNhcUU2SnlaSlNKQzlQL3FtaTMrVTJSSW5wRmNwTGRl?=
 =?utf-8?B?UEd4SFJheDhOdmJiY2owQ3gyMmRrYUJVRjhVZkhvaWJIU3dHUzNMQitlSlpZ?=
 =?utf-8?B?dGVzNGdBelFqSVRUR2pmRGtaZ1pHZnZJaElVM3hRanRTb0thK3JJTXAydlNt?=
 =?utf-8?B?dzI5V2tvZDVNMFZhS1RQRjV5Qmt5ZGMyOWtaWHMzTTlOZUo5U0g2eGxpOUE1?=
 =?utf-8?B?ZFhsc3NYei96ZWI0VU9WM2YzcnBhd2laUGgzSW5MM1h5aTcrQmErb1R2Q3li?=
 =?utf-8?B?allNUkF3UlkvZmpnUHUwUUJjN2pLVk8rWm9CNUFZQmVHSGJlZ1pFM3p4Qk5h?=
 =?utf-8?B?b0RVQkQxdGlwVnFocUlETTdDNkw4ZWFEQ2RrS3dNdU01NlNBTGFVbDI5V3do?=
 =?utf-8?B?NUV1MjRUNEJHTWJ2T2xUM3ZIMFRCaFVlN3BRZG41Q1MwSklPRCtWRnplSXlH?=
 =?utf-8?B?ZGdIVEtxVzArVUxWblY3Q2svOHdWekJVbFk1d0dnRHZyb2RKQTltNlByZGEz?=
 =?utf-8?B?ZFUxQ1liRWRWU2xjRjJ0QXBmOFIxS2ZPSHZqaE82KysxbCtoQ1lxQ3M0REMw?=
 =?utf-8?B?YTBUUGpsVmVXc00xNlR3TEp4L0h5VnN3Q0pyVXJDNVhaemRoL1FBVCtQV1dW?=
 =?utf-8?B?RjF6M2N6dzA0OE9VdzQ5N0dTYm9aWElRckR6QnhjaUFpZEtrelJHcjBVdzFi?=
 =?utf-8?B?dUNEcytFb0d5UDVGa0RKSmNKb3J6aG4zWnQvUjJuS2M0bkxJdU1hb2FKdUlq?=
 =?utf-8?B?VTZkdzI5cEp3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2824;6:l4azEQDb7SSHXPgNTgh+AvYxN0dPVUmSomASiT3GYrl3XjQ3MVyFcsHRo8RIoCLsfRFa7jXIwWrOPkYMMSCMYl+RFJf9whuWikLhoKzk2kH16HOaA55W3dYMPNl34xyTAa/AvcAqYL3h7/I2Xo4wraox+6pWmqUrZAxXOIS236JBoa1fJeICVrz2c9esorA+duHIHNX4zgX4iurznwu87qJj26jvr6hSseqERrr4cYvHeKGUmdlWUwCjIXcdJ/9kTum2swAuZBBkiDUq5/PpSI8bqiMtOhEfJa/5yiUfA1zCkol/oHLmxVa4Z9ldVEfRTgVjciSLt8DsCsXshptPorpTfDTUFabgsTPWwOBdF00=;5:HNjj9i4hWvhfJmnt66ZhtojNOWUrKblF/e85IFNn8B9jDcvu3gyv37qvkKqpyVLhK0+8su+9U7Mh/ogA2uAnYtFhb3CQjAo/KFFz0YcnJk7MRIb9vI5njQjBU5EG/nUh0zEbbcdQ649oKouDT9dabmeXuxErw4uq6huCqqX7sek=;24:urUiXEYMum5faqJoMQSNIArDlJBCfdlZcNi3lv1te/ak7PtVDbzuvUqT8bgGt7sUQzV5/pcaYS3wf8OxJQ9tHN73W6Hkxs8f9whJYj89/1U=;7:tam40Usx4dlzY035iw0rADMtuRzYS4jLI4YckyycSkmi9FY9qZN6f7yps/z1pqaC2vDr+9tnmIgzWG0b5EFTgbgJ/mIVtrptqeJ2AlBD1OvKL1p6NlBvRrEQhqi8rhKqoPjNASNni2BF8oRs9+KrX4uMdrs6waL1Su4d3i1LnyjysC7Xr24DWn/bJYfXBdW+dmDqGlAPViKriU1vu8W9rcnZUWGgUiHMNcAg0taIXgTZRA+N+fm0keOmBQBy2Wqo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2824;20:U/ndBavfIvj5tEP06KD/wp+bxqbnZmeIOkk8b5nSaQElDdCrUh01xp83cz6HXYaymDkhQQDq3cMt4qruOLbMuKIC3S1kyMnRH7BFGA4iPflRN8b+MSx2+FLYD1MMVO3vPkyzb0S7IUgs10eZXSKdAzYGAzCozni8FM+7vZdWzbY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 20:15:23.6806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26205e7c-f352-44ec-f0b1-08d569b0873b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2824
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/01/2018 09:28 PM, Linus Torvalds wrote:
> Ack for the whole series.
> 
> Will this go through Andrew's mm tree or what? I can pick it up directly too.
> 

Whatever you'd prefer.
