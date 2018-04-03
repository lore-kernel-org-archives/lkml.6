Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeDCPMo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:12:44 -0400
Received: from mail-he1eur01on0072.outbound.protection.outlook.com ([104.47.0.72]:42718
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751561AbeDCPMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:12:42 -0400
Subject: Re: [PATCH v3] nvmet: fix nvmet_execute_write_zeroes function
To: Keith Busch <keith.busch@intel.com>,
        "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
CC: <rodrigorosattig@gmail.com>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
References: <1522686699-26894-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180402173839.GG28945@localhost.localdomain>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3b2c2fb6-c856-56f1-53fe-cc5e29bdffbc@mellanox.com>
Date: Tue, 3 Apr 2018 18:11:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402173839.GG28945@localhost.localdomain>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(396003)(2970300002)(189003)(54534003)(199004)(2906002)(106466001)(8676002)(6306002)(6246003)(4326008)(39060400002)(336012)(65806001)(81166006)(2616005)(446003)(65956001)(81156014)(305945005)(36756003)(1720100001)(7736002)(11346002)(86362001)(76176011)(229853002)(106002)(47776003)(110136005)(486005)(486005)(8936002)(67846002)(31686004)(53546011)(5660300001)(966005)(476003)(3846002)(230700001)(16576012)(50466002)(478600001)(316002)(186003)(16526019)(31696002)(64126003)(58126008)(6346003)(126002)(77096007)(65826007)(6116002)(356003)(26005)(54906003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3119;H:mtlcas13.mtl.com;FPR:;SPF:TempError;LANG:en;PTR:mail13.mellanox.com;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT055;1:r/8vY+x1HsCHPquRRZU+YTLOSixV0OWvbviuYgpeDeuw6LPA8XKu3wmrMDWAFPJoDswDJhQ14OAkWF0qpZKx8IMyuY7U+UbruJD/0n8lvoeFdQ3Yj4rpKbwIWpnAn7DX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb5aee6f-8a7f-474c-7058-08d5997555a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3119;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3119;3:gmkupe0z2zrK4Z/c6iTp+KZloz5uiv0UqhZNWvm+2Azc954a29S2QwQO7mqZGLcXNeMA7qqvxi+YKLG5s6X7EhMRS3c77cGD6lNSMb2r6fsjrsK4nrPFSEuZp1irqa4irc+DEUxZABacw/Rd4vrJEZT4ljB5+dDfS2/teKujuX4mSplVwPBFxHQwnht6oFfAI9xiLM3oVZxQgVQYJBn5abyvxuVjAC2wPgZrP0doyyiAKUqNuyC4cZ4eytuC15p0hYJDbUPJfnCFK200KnNvw/KW9A6z9tXAHiQiy6tZu4KKjsYX1Mjn8EFeYsO8DwY3IXGTjYtda3FiSwWac8Ma8Ntq0xW5TW2WzKrFgO/SR28=;25:VBF6tqlVz7jrrtvEI8wBkVKEmQoXuMmav9n0EHomAtYsjuuM+LznT6B7404JMgzxUpjILwMYri+dA/vg+EPU0EtEqe4rSGy4gwtf/Spp4Xmmr97xE0kglDcvsHu4/kKlpxh1FBHG+tGG7ImLpNEDsZSp814gqb7Xzczz1PzZBOwUcNTUQPpYLE4xRB3SZNrFqZgEWsSfuhhimpONV6xLAzRnslfYbVJcBYf161pbTV0qByb2b2iGb0xtJEP9CxvQY/N0TLIOoJpJiUb/fqWXqPkUnzbMwWuHXV0HGfe/uSSMDGfCAWve3grWKU1bqjVBJMQdfSSM+OPgBImHNbW28A==
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3119:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3119;31:ANkOybDWzypiz9PMP/Eh/Y1dd+gavl1e1/H8DEb2fk+zXPyVWDGT1At8C882K2sLceFKD8YkiCy1x5yfqeXgpJJqx0pHYRFy+/DGjyOYt3LODBav65cQpIDZwi0jDRhCLPW0E4p7wts1Sb/wRF6ChlDStoWLqxjYb7sp42QgldUuT+COfIVUBP9C4hue8gYOTUwMFjfpCZrCDy2XTF8Nhlqvqx6HE4r1y+AYvOtvth8=;20:UzFWi73qQR7ha3vpMjy8yYc5mtAN2t/Wyxwn20NnmUSB+PtFdYhLBtQUokOOWOFrN9xjryIUVeUfc9o/FFfyFVJogkiODzw7Bn+kuqLG8tdIpiirPSnopGkj2U/4QqtYXv044onUub5rTmdlWrks1ZfVLHuz9REFJOo2sBebNbVDzfcsCFCP/liGhk07PNhyp9hf6laR88j+FRdfdj8vgCTaVHQk6eZ/TC1OUXRW7C0RrtbSsqUxtaHnLN5FDNeR3eyzz4FmADjURUstUq2pe+7NA0odYh6x6t1w/qLBFnbSi/yDvFqOk7rv95LXyV0MIyNSjtHj3KNYUh3eEDdkD/16Nvvs7jpu3R1THUyqeJkbulbj0W7XbymS2fMgHshWrP11/F49zJ3IAGdjrJsb2zZsEfwcB1OMvLFuvM9gPe+jcuG3HYv8hcKayLKASOc9f3hkctCe5z2K3IX+PEkmqe7Rt7pjkrW8kGSFH9krx5OeScRLJtiUs3HoR4tIs2hs
X-Microsoft-Antispam-PRVS: <VI1PR0502MB3119249BC836ED222568BAE3B6A50@VI1PR0502MB3119.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93003095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0502MB3119;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3119;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3119;4:q1Najc0tUC++Y2or28qpPcycvYofM6vmjGXt/rfUXjE/XDH/OxXwReMtBco7tDUov7r7JjhhMX40ozfu8rRcvBZBpMAu9SieT2bigkfSUzSCdNz/DayHca4lfclwWw1oHT342J/+GqtavqJY2yNXWLdj7pDhjxoYq4kNg4q4vNnCIapmgjaZSNzdV/TzatnplyoUam/AgFWKAVjQ9HlqhAvaGZCC5W54dlEaNiLe1bbBFqr1bxoW7Rpgu/58hMs0ptoWjbax77UoxoJafOS6b6jIvWjAPIDjjyqhpF6A+Fb1/iSU+Y7b/q1hrSnowXu5
X-Forefront-PRVS: 0631F0BC3D
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;VI1PR0502MB3119;23:3pMJu0Dm0hVEE74pggIiC8GpuqKsNYEQCmE?=
 =?windows-1255?Q?ry3x/cUG30zwviywXafa36hwfZXo4OaVnncdOV/5x2PpYtycFx5FBKx3?=
 =?windows-1255?Q?W2twHZNg1z8ZVorii0L1hzJirxQJ/ycdbFRyaxgvc6U8qqAorMSl5ZY3?=
 =?windows-1255?Q?8gk9Pi/kOOYUBTAIGKJni9id/nmEc/FFq+IO46ooDoqANIswK6ojFQm2?=
 =?windows-1255?Q?Evhc1VDdE+eRCyG4K83vgXmDKkOUzCxht3iGWGsQKepHctTujJDT9200?=
 =?windows-1255?Q?xY9pW3qa8P+FVBs1HYvYnlJ3zOP+Yrneti99glwDiPag6uM7LkJVR5TB?=
 =?windows-1255?Q?4Crszy7340aPuU24fA6yo93F0CKEdru0fM7w+ufwPeP1MRW8sfZ0djsZ?=
 =?windows-1255?Q?1TMLmSG/mWFkyBeMcViFil5PSCots556bzaHn9ytaT4mpqa4aK4q9MvV?=
 =?windows-1255?Q?cLjRAiLEBF9afcqZGDkJKYARjlxNQLUkjfaM8B/EUbuRiblq73OEgbwZ?=
 =?windows-1255?Q?yGMMHZwlJvWAmuSRDqzhY8h85jRfpEQ4ze/GCI+xA9ceeEDlJh+TGsdp?=
 =?windows-1255?Q?J42x12oarfx0M0Ugf+GSKaZ380+g611oMs4HWY8Gc9lBSAKgxdvVp9J+?=
 =?windows-1255?Q?eay6waeWDkpE5gT+ACkjcDGyTMlKC7mrj4HsfFYAzkV3vzi4iAN2ZbGk?=
 =?windows-1255?Q?0Mu2UfhtSYVy1aD1dmeLePjt05ZwSwMHJ30LxV5kjF+8CZr9hj3UeC3J?=
 =?windows-1255?Q?WL00VEgJ7eHTqA/kM6U8xxCT32/HqWubv56OCvUdn1KyvwoqFcpOKA8T?=
 =?windows-1255?Q?iaXCKEcblirXtjkh7H5oOk7+D+IYxa0NpgRKYwwUvtEt3OPB0PK16U3d?=
 =?windows-1255?Q?tPJ1U4aK8TYz9kl6uZd6gwaUo0dNv/zirgp4O9drg7h1aO90dg8SQQl2?=
 =?windows-1255?Q?fFoG+dV9e3IuVmRMqXNGYTylC37G++CLzBfATyV685jW9jbqgWnF2O6x?=
 =?windows-1255?Q?hHay4svkXwwvKYzx6GcFFxPG5S9r5nzbMLbhIKA38Q5AqhxoteGWwc40?=
 =?windows-1255?Q?OKIaxzQz+lBbxQIC7X1yLPXFJT444w4By9lAAh5lEO+ZQ7F2Z8wfXbbg?=
 =?windows-1255?Q?/IOUuRb8srtTxFvGZiAVFMdWFaRSsTePSb/N6Sqc71KRBsdR55KubF1s?=
 =?windows-1255?Q?ta3wMI+7HCjOeiNDgmQFTA1RJZwV/INT9fQW+2OrustFl+ygMSsu1Zm7?=
 =?windows-1255?Q?BUlzy1cSnvg1PuaUMdEQrpP+bm6gMTQcWcLvrb5cDlQbOeMPJWFX2Smv?=
 =?windows-1255?Q?+RDeYDzo0NU+g75OK0sqY0hD+HaLHgMbfmziwRAOmVVjSvHBSwYatcgf?=
 =?windows-1255?Q?3OLkzrkgQz2ZiJV2s28PTyUF5JeDNq4T+KbNnvXIlz7jaZnawBQEPwQz?=
 =?windows-1255?Q?ov8nyzI5ASPLPxQDnAq9s+xU6yvxvN+syp90+xuSQGRCtVdEgYCaHB+l?=
 =?windows-1255?Q?2fkzRpRffD+Wj70r3Nj4baUsVVoel?=
X-Microsoft-Antispam-Message-Info: bFak1TWG4pB0VrGPrAsJBSCULI4zVkGnE4becMZBv9AmJefIW5HEuu2ydBd456yo4M4bzSJSp0TpTuv0SNJkUrcbSMnj+c6Y15rna9Xk109WTzAdYRDxDDhJSJEydATUarnz8pppt9LWQS15CqAxCac9rkszvS+BPGrxgrxWXUan0eZi4XJB10lmwNnnF/At
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3119;6:jsyDwHFtfgxxQNZOaPtwZ4XtszUFppEW6G220tb5MbRlSopvEsfvNcIOFmnUILWT+2fRq+F+OTlfNeQI+4CUtiyTNyJMeNsaQx7afaToEjRFMVq2MDQvwmOoFLipSM7hN+e8jUhhS7HjTAHvFvXYyDXA3H+zXUSVzSNQuvHJ5hBQabxer5HGuQM8RVZPRr19aFLQmvPxNpP2nOFAPic0CPLbjkZ7rfiJP8ZoZ+ji1mpS4jIScYZ7o/FLgpDe6N1c/9Dk7DVRchGgMSUTi6CZaFYIFk1tAjKXuBNA/lGD3uD4WD3Hizv+DEnZaHCRB8OqdLYi0rNczK0sHIE0F33OJw6K+jgirNcwfvJqbdQb2989SSy7Et+ZyLQ227E9CUlKJZu3FUvi5Zv1Bm/1SmrUQUpv7NjD+gwxZkBKYnrieZD4jkCJEnahsN1fRLgdehlaR/DmiwWENe8dtCx79olEuQ==;5:RmuBHDAT5/ScA+L/oVM6Cg8XU8QLXABNF+TPSkgIEsDHMKqux02myLdNv/NUUfOF8NrYDomUYyvCK3GU2SiGG5d6pghuuZ9BsIGdisrEfQDvgGpEZ1Jkl03i/Ye6T3Fb0+Ia+6bff5vCOe7iOvxdmi+zBv5unfAoo62m5LmAIJA=;24:4/cwX4tSdyZyU+El62f46XOi4zGwk4ATXCCZJtJluyFsZZv1pZs7zUtZoUX6nAe4PIaSwQvTmiTeJryX+VYGKp1EAiqUmjp+iDW6frjpiM0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3119;7:hlEmAUpJiZz51GOcLOUu4D7Hp73IhwrskvKcEQ4YIHRctGWWWlJ4BWmKBKQie2qqc3stWmm8L+TqVfhjgbeGx2SpUwhhZHF0K0RVMrcLMgZZvjChzqszbybV5/Mb4MJAtRT6bQLKtW4WwNESfKCxijQiKpB9f/cZQO+tiXx+rnT5i2Vw9XV9yBdnuVFD3EYLH3W9ZnL2XzPNnncTUVphqkW1K1aTrtQX8NB0IOY+XMUNovr8CXpn3+neBJclH5tq
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 15:12:36.5925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5aee6f-8a7f-474c-7058-08d5997555a6
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/2018 8:38 PM, Keith Busch wrote:
> Thanks, I've applied the patch with a simpler changelog explaining
> the bug.

Thanks Rodrigo and Keith, I've tested with/w.o the patch and it works 
well (with the fix only).

-Max.

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
