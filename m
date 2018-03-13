Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeCMRuN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:50:13 -0400
Received: from mail-ve1eur01on0101.outbound.protection.outlook.com ([104.47.1.101]:45287
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752150AbeCMRuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:50:09 -0400
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
 <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
 <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com>
Date: Tue, 13 Mar 2018 18:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(36756003)(53936002)(53546011)(8936002)(8676002)(2906002)(81166006)(81156014)(54906003)(22756006)(6246003)(4326008)(76176011)(58126008)(5660300001)(26826003)(68736007)(23676004)(2486003)(478600001)(65826007)(106002)(6916009)(2950100002)(316002)(558084003)(356003)(47776003)(336012)(229853002)(305945005)(230700001)(64126003)(86362001)(77096007)(186003)(26005)(65956001)(65806001)(106466001)(31696002)(50466002)(97736004)(31686004)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0701MB2388;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT050;1:h7rsO30YJ/RC6m2VQHcLDxVhagRjAqekqi0UUzDjQn10fkkcyKMcY5xDQreC5OJ1mBgWBhxNZb6uBkeCpOvOt78UbBTu6ai87YNgAblSV/Vy2c8MBXXG/iQybtAeeDBV
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd068c1-c351-4876-d3b8-08d5890adbbe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:AM5PR0701MB2388;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2388;3:jiGqMgeLpigL+LmkHmL0z3A4kzwOcjT0RV6XusTfyvOURvJyxSo50i1GhxdunxLXmLQgEoz6+9Qkaelrdig3xWDcB2KSFDGMX1pkQIUsS3k8EjexT1jF56ATrGrKxp7BwAa3fXFfVbnx8xNxr1KUPNgqU+2I+zlY581JEEQzJMe5sQoVAKWOBhIo6aHgAOX9El7UyBweg/cr0YZwWcrzJjL+n9KW5R+O3hunjouOO4DwJ9aSkvKBSu6uLh3KjRtbqDxeCkPoLQraaFA3MO5FRvyDTBjb9LLG6exqXZdi4RY/uwuS1uKbIY0+CgcSl7gUxjTOVQs3btvfW8pY2s0i30jo8TB5OUk9l+3GVEtpqy8=;25:DUBajTqRfmR1EYAK+uiJOFl89HOlcA4mq2w/uQ35hsfMUk+qkVXHGTTcoAajB8qPYNqxE+L2xHwsr+YVlkdua8wPliedHh7fc+fcz+QEBGfYUCHWfgd1t28FO1h6qKnzyAx3U6Yqf1N1QX/jHsuJ4VSYv34A5c5vmRdUK3svZqgwF+WCPSc1pgmmpM/i/wY88QNm34TmhLRZzmTHxj8rz/JYGS+02JM6wGr9lfbMme0UJIXkddptsNc/tkTubiJdQM3Vvrm0hXtBb9l0wwQTbq5J0UPPFuia3ZZw0bV7lb0K/5ttW33weA58BLZpJyXgzwSlTl7k293OxBXSc42u2w==
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2388:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2388;31:fbe/SEevLIPXUms1Lpk8g2rp5QBVplQCs/fF7eHK9mYJ8hwYq6Q8mWky9Ss5vLsjfxWc9bWC3k0Nf+AU51p4YK+HFRwlvAVb7cAxSs8jPdw1UbuKYmwpm/7p3quB7yRujs28QZbVjjjrFi/gP1BDOpvVjN6DKwTuqXc7mPl7ujj5cmc2+seux0dOggn6G6YlMSXUJgholyPt0xluUem9tP/0KSXjRNm8eAkdWnH9sD4=;20:z5Vas8Q6kH1BEyQdYg9K6TOKuTq2KdrKemCNmO46+QKyd4hP9JSmxTujHEnfgRKB8eHjeQsPH1uhzmkpsx9bAtf824v837WYAVZvxOrf9s+HMcgB7o0AXvYtfVGKVIJOpDyfsG9sxNVBdjvVVMkr/NgZ1uLJzhVIEzLtb0j1cNAEOmgR1VkH4Fj8qSErOa9qdhXbOclsaTHrZWuryaOisQmWb/M+42jsKj5jbLSToayXwdq0yHSr5T5EV2kKQ2aCwmqjrdEs4bB/RUyhjgUB55eqlmCLq18KwLzlTTtnpa4d9P+NKazW2hnipNLjeHXxXqbJp7s3iq/13PSlFRUE6C8/drbjkuA8Ass8U2aa7arQYxU/pVkedgvHbX2JLNv59nOqjSRFi4aYc0Q0aem+jAKJ6QPbWx182AvTK7eNJZL3m2cNduwq+m3jMqYQJhRSaMGGS6jyBeYHTP22BNNYPnjmkt4+nAORte7uDBhQarJmxpq9ooBjUzmvD7zd2OTsS+fbhgj9atbyL/JQBHgs0dPx4IkYXZeaLgJAMvxg3oZMmKyzho1cgRuzgaVAH2+tl44VKawqs0bKy2tEWxVloNp3ZVrxIEmUxhnaZr/QXmM=
X-Microsoft-Antispam-PRVS: <AM5PR0701MB2388E1269C3A8D2418C944A088D20@AM5PR0701MB2388.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(806099)(944501244)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0701MB2388;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0701MB2388;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2388;4:8CTevvixoP0mO+2WnAth3+LxXFvjvncH7/wLSr8bnneaTE4aRi8ETqTv4rYxFXGEHn4k0LqAkN0XpTsjcFqjUua+gHNG9yj2LsZ0lEzJTkVP+maSnoxZaEkhr70TOa0sCspm8bHaNlZlEqBJObZMBAIq6ZsB26T6hDGHX/XgPvEyUAB4glaUupkSOVH91BdSv6rZZS3KEXytBIhhV11N5SFNA2YrdQGIXGEQuG8JxFCuyFGVBzKb09jmNMUTURHiL34o6VETqwQcT0EzZ1VVsQ==
X-Forefront-PRVS: 0610D16BBE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA3MDFNQjIzODg7MjM6K0VCbGNQZFdpeEl4bHp5UFF1VnJyek1K?=
 =?utf-8?B?d1RlcVIvaVUyMUJQYTI1ZTM0a0dGdGIwelB0WlpsM2duVmg2ckhsL2l1Y0lR?=
 =?utf-8?B?YkVFV2VSN2dqajZPUU5JdEhVSUlXZlJUdyswUWtlL3B0b3FuYkJJRGpCbUJw?=
 =?utf-8?B?QkNvVE1WcXdnZ1ByWnNMZ1VOVzgxRjgzRzNCWFljc0xkTWpPVFlJYnlXT3BD?=
 =?utf-8?B?MFNWMzZEbk9CZmY5TmdQZU94N2hRT0MyS3JnVFd0SUYyWTFUU2N4aWRFVm03?=
 =?utf-8?B?U3VqZlJKVWgrdFZDbjN0T3BxTys2S21BMjQ3c2x4YkNEbi9PS1dXYURSKytT?=
 =?utf-8?B?QTVqWUFTL3NSN0t2RExWQzhCMFhSL3JsOW1oUC93em55K2JmVitLRUJyd3lj?=
 =?utf-8?B?MHBWWnAyMHNCdzZzY0NNZ1hyZS9hTy9nNm5Oc2pTSDhDT2hKakJUODE4Mzky?=
 =?utf-8?B?akRIeEt2UVlHUUpaaGR6bzk0Yy9PK0gyMmxPdTlDekRvQVpFbmFzNU1FWGZB?=
 =?utf-8?B?OXFodFEyOGovV2NLbG5NRUROcXFudDFqQklUQ1U0cG5sMG5KaXVudzFwZ1pa?=
 =?utf-8?B?UTM2SEIwSHJTRGlZUWM2Ky9KWXNhNjZxQndJZ1RpWWRrcXhYeHIrQVVwVDBG?=
 =?utf-8?B?aVVUSzVBM1Q4bG5RbGlsSWVIYkNPRmdYeU9jcnNFSlZwNEdwREtvLzYvSWVS?=
 =?utf-8?B?bXgwK2tEamxEVlBuRlhPYi9SdVU0NlJrV1FqcGtBMVh4TERCbVNLNHpzZU50?=
 =?utf-8?B?TjlLd2xGdE1lK1A0ZFBIamgxQVJpb3FoNEhQSG16S21DZjVsWXRkV0JPTFB1?=
 =?utf-8?B?SXpZOTU3QmhNQzB6SVJ3WWgrWlN5UWI1N1JQcTNBMGNPOUNBb2k3NC9CU0o2?=
 =?utf-8?B?NTZFT2pVVFAxSEZUV1RiMk1sNkZNTUxMVUFWZmpnRXhJYVU2SjQ2Lzg2UzQw?=
 =?utf-8?B?eGh5NFNUdWs1VUFjQklJTXpJbHBzTlU2SU5rcGUwY2Z6b3NQNndUTE1JemxO?=
 =?utf-8?B?NGxWTHNWMTUxdVk2S3JMTUlDakYxc3dVY2lJenFzS0ZtTXJqT0UrRE1wbUg4?=
 =?utf-8?B?M0gySDZKQ3dER1ZZTmkwMmw2SGsxL1hWeklpWGVDS2NNQXBnUFhESEVRZSsw?=
 =?utf-8?B?czQwQWJEa0l6K1dQZHphYU4yZFVUU0JJMEdFMW9SaXVNcVFlQVVDZ1JUeFhS?=
 =?utf-8?B?eXZsQ3NNWVVoSzVVaVBYd0hBKzdyWXVJNG5jZk1QUjZtWitpc2RLSXpZUHZH?=
 =?utf-8?B?Q2diRDgyQTBsbk1RMy8yYThNQm5xbUNUT1NIY1o4ZjFpdnRTWlV2UStqOUZt?=
 =?utf-8?B?UkpnZ0VXMjVIUlZyQmExTHlseFkvYUNkcS9oOWVWbzVKRnB5UVRTdjkyaTdQ?=
 =?utf-8?B?RkpsMXdNWlVpNis3M3cyUjVMdVBVV2FPQmZLZDVzUzVBQmNNdkZtandUZjM0?=
 =?utf-8?B?VFgydkk0VW5NMGNGWlIvdUlieHByVCt0MFBjNWE2ZnNITHptUlQ5M1E5bGpt?=
 =?utf-8?B?R3pmd0hqMHg1aWNYazI5QlhFdTdKV3N3bWRlcjkzMm9LaFVlNnpvampEOHZx?=
 =?utf-8?B?SE4ySE5ZUnEzbHJzZXdCQW1aemk4NnZqVFh3Ynk1M01SblJDUTduVm1qcWo5?=
 =?utf-8?B?UUNNNmM2NFZKQ1Y2MWdHcTdzaXpJTUhibjMrS2lYUmp4OGYveFJXWTZQY1VR?=
 =?utf-8?Q?rWRz1WP9Kcimn3OcBFmQ=3D?=
X-Microsoft-Antispam-Message-Info: fb3VOmciRMcGWzkAdiJNBvqTfh3ULb2CVpq285z0X0v98cx8nSiks8Z7SzJX8LoHPufk9/Fitc+l5tvVXnnb4BN9PqMMqWZx2QeVPlAnc81WxUKPd0V8oM40RYBr8jPKt6qMukrNsW2HSNEFXovja2WqFdBaWjZmZSxWBmcezIBX8Az0PlHigu698KA78jALBG2Fg1OfpUshB6CWTmhlg3d2xfwmxehSaTxtMRXiLfCcOzwGhZ9AQZl1bJJFXLlj20Q8GOukYCX63perxcEPSA3Apj7IWBnwSjI634uTbaIQmJ9shVSMGZS49jfIboB+wGNxLs6A7LgXOgBGuTjch/wxckcQmqYtZGISjjZQjmXCirPIuMXHuYf6mp2vIVV5
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2388;6:3gt1O00qqndFipMTLLO9lBQWTJ/kK2aKybUP6m4GBi2sgAtm29pgZpRqI1yRT+R+mzz++t/yiOeWFqhgp6CGt/UoF30elKlcVJm1toil/v9EfjtV7VLbz7AinlHNzRTiZi5la3AHd3syFsHH8D0FMXkAjzyEtnPVh1+QxEyX2wNG9UM31MSjTDab3aILc7ja24/8EuNtDfKvBwCCKDYK8sOzmG7ciH8LQBBLxyGd8j0DedIJ9A1z/ntWfQV71nlvANqHu6qFqvPpJMaSBIPUpMlVrVNV85kBSWVUGvBS5ZOuLWVfRX3taKb038BVvhg4WbbrICRl+PkfKmYKyGCBAsTxzCWhdw8J7zz/w/DY5MWKeGneB6DI87Qhu9b3/MpErqNb+BbwmARzDkA36spdkg==;5:MMaO6BDumboaEr2Z/S9H6mydijIYS9/K6Pzp0uHQZ61Sv1YNZOUY4zEFw5WRRZYiRYygDJe7IL2D6/XJFRjOP/IGMUpmFyLspZk9XkddbraXdMlFFehbn31R++tkzDMDetSAWQU1vE4viLkA9UJAqAxi9QSZQA4XjsdyJyz69vs=;24:SL/x+4siJK6AAlM6xUX4JOjIftru44Vn0KP3fK8OzbHr0DlU2YFU1tUn9/1+CDpVQFd1Dyrs95b7wJ5Z3HNW/7D1ROnK91yWw5A2QYsxRys=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2388;7:lZaqnwh9A1f0Af0ColFwfreGLT23OdhZtSn2X8IcSjAFXMFmq/bAd59RAzvG8zaPS3FzRJz6U9ceQdK8RLnSq2n+6jseiP+ZWhVVvCu+LFUh4kKFazlw7fbsvqFEEpsbdiJoXDHbp/RiwO/KPxPcP3Lcx8OmGNzeLgiVNV47zrzeY8Rvs77XL3aGjjIa4zC53UeV+eiEGFr1hxDuEukc+JEU/QsDkyiVljKkelQdV6VlvtiTdQpBHkI2CojDHJw8
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 17:50:06.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd068c1-c351-4876-d3b8-08d5890adbbe
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2388
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/18 18:39, Ard Biesheuvel wrote:
> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>     module_plt_alloc_fixed();

Do you consider this a legal C code if without module-plts.o the function would not exist at all?
That's too much relying on optimizer I think...

-- 
Best regards,
Alexander Sverdlin.
