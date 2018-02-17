Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeBQWXT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 17:23:19 -0500
Received: from mail-eopbgr40123.outbound.protection.outlook.com ([40.107.4.123]:15040
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751254AbeBQWXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 17:23:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (3)
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>, Ying Xue <ying.xue@windriver.com>
Cc: Andrei Vagin <avagin@virtuozzo.com>,
        David Miller <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, roman.kapl@sysgo.com,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
References: <001a1143e44e58485f05655fa8ae@google.com>
 <CACT4Y+bxubQ0yqi777mgQdT6paPS+wWQo79T+jPqztPJ=gTYhw@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b6b1e370-d3ba-4db7-228f-a3ccaf502992@virtuozzo.com>
Date: Sun, 18 Feb 2018 01:23:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bxubQ0yqi777mgQdT6paPS+wWQo79T+jPqztPJ=gTYhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: HE1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::33) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b30654-9efd-43e4-c46a-08d5765507d0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:V7CVQ6IFpHhzghmWJZCX9Ddm3byyapo5rULypfzZUs4ap883cp8jYy7vIrqd9MR8wgy4YYhyrQa5WJzH+HtonLJQS7CK56745PA04rTkwU5AnmXWDkz5LPSx+sjBnzpqeIzuY0ZDFaVFNUx64atN6l4M1p0Xu/TPb7sRbo28DCKQKQEqB7yL0XfEqSwjaXD9bFup1LUaM8EfXML03q+elQJ0nCLWG7ZMMESornWHBUhN+/8EBdmUXH5DolzEcJBo;25:OHrDUTcgqMO8qlONZjM5oz18GyxO4dJayM1IblZJj4UuzNJNehRMc7PPuFqrLGC9wRHbSD9RS3JfVsbx126+4R/S46a/kzhyFJv/m1PbMQbQVeFkwA4eDHPFss7FBAzKtRaDoPZGffwirD93mrr6lH7Jw6XQ2Tf4Z19/M0Dkq0G1X8lRrM0HeP7x4+ekDzaMP0DpUJX+l2TakBDP+ej3UFEckvxLg2g6ETd27IqHLkhY2yjTNCu3yCZ0Dewc4G9eiJ8af3/YjbcbO1IPMLAO7hk1nh7WsrWzv0Brt1zRQBCAxugNnHybi9aoDKzqr0JGjYi66+YkfVMfmUCpTC1Lew==;31:YG2T3K9GMVhhVXsVLzbKOTWpeTkrXqqAgBbORQ3iwErvKmmEgjhAC6msLxcOMJwEmJLqwVenJx8jTeL3oRl2gLbM6zF+4rkNNkarG64aXdxbl6DCMSIsdDfT4/CyS/QfEtDW6Y/FkFdMbljtB3xT/6JgjuljQ+5pYjQeiSR4IxRoJVJj/5876gE3i2NwazemI/L4OvdlpH42aN6Kvi/gs9m0Ku08vVfA/+q3iUOOBok=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:qjDcQkfEpr1N5gDtpg6AH0svXo+7avWgv7d//uXaU7rnFq3+yuzgNKATNT9Df5XIuXURqkbKIQuCkuQYsFKisQOyvN6Nde38ogH5MZ1fIPFNrui/wgF54G1d/5I9xFuL7QxIGcGAT6uYs+rGWvJS0GIGOT7Zc0YCuTdDG9aK+6vY6kiSgK67YlODEBYcNMZ++7iEhrxA/QrB01bPF+XgMNzz9R0IQ1PzvOIREbuVBAysTYBDadXWlOQDfx+aJKcqwo6tRyQx+ne/zVElLT2+sxfpphwp2oTcRYQe7lTLxQYPDUDEPBKi5mB7vbNfXKccW7+QPscEpBzOh/2seIhg5nhc8MV9duZpcOaFeW2b/MJ6qHTeqmhSDYe34WUqVlVnbjZvcAqAe+OVBrKTltNiX0Ity4c9LrmiN/W+LtwFeQA9L6lAHMzHuG/msYZMuZB5IWIdfUaF+z8X1kUcq7rD5Gt9a+1BJ219j03GM+62NczZOWPTq6yl3DxFj8WPi5WF;4:gpeiNOLu7WJ6H9sI9XKuLXF7xWxBAoI0frcvCavPuj+rGtVVMVHOz/lC5NP7As+FPgKEBYuYwU1EQoH6cLDAsi8t8uFKqpAyY+L9lsPXOfLzsQ8NkRxEmn4SyGt+PCJf+Dy4jfI+V6E52LSbYbIhgJrIk6BUrVTZPD59aBXQJJ+cFAplvlam22pXb5AUSp8ifgvq1iMYFDfwYrnSe8Tq8Z/ievvprWJusNuZISHEGJBpRIMFAc2O1qYlgi2iqqXUBpu0kyea1dEx4wakjP02sJ6fvL2BH3xSkSFYQO8RrAwvleLWF5oDX8LT9DtDYUng
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13413A65CB48004BC3CBC815CDCA0@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 058637CA05
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(366004)(39830400003)(39380400002)(346002)(376002)(396003)(199004)(189003)(6512007)(26005)(65826007)(5660300001)(16526019)(106356001)(31686004)(186003)(7416002)(53936002)(6486002)(65956001)(478600001)(2950100002)(316002)(105586002)(110136005)(68736007)(65806001)(58126008)(66066001)(6666003)(6246003)(54906003)(97736004)(7736002)(4326008)(305945005)(47776003)(50466002)(81156014)(81166006)(31696002)(52116002)(8676002)(36756003)(53546011)(86362001)(230700001)(25786009)(8936002)(386003)(2906002)(52146003)(23676004)(2486003)(6116002)(3846002)(76176011)(6506007)(64126003)(83506002)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6OFlocUJLdW9UVjVwZThBaDQzbmxEcDY1?=
 =?utf-8?B?b05TMUxaN2NZVDhxaENHaDhOR05nZ3dRelZZVGhtb003SnZzZ3oveVhJWXpE?=
 =?utf-8?B?MEJ3TlJqY2hWMTBjeWJEbGRLUGt5eVlmRUpCTFdUTU5MUkJDaWtJSnlMeFhW?=
 =?utf-8?B?NEFINDNlMVp0TTdGckNrYUplMEVIUjExWXZHand6Q0ljOGl5dTVlWHB1YmNq?=
 =?utf-8?B?OUJOQW5uNWNWMWg2eVZRNU9ySmtock8vb2VBVldZOVZ6cnF1NFBUWC9SZ3Rp?=
 =?utf-8?B?YnFsdVpnTVc1RVBNeEJDdEtsTkk4STNBZlJabnFGZ0pJRVI5Z2QvT3F3SHdh?=
 =?utf-8?B?NjF0bXhUK1pvaWRCdXRveGZGaWNLN2NMS2cwWUpDdG1HaVp0a0c2YXNTc0lC?=
 =?utf-8?B?Yk9GVmNaQkNIQlk0dmtLSkdiZ3pjOHRiK1VhZnhGV1NZaWVWNDJuTk4xM0Va?=
 =?utf-8?B?NzVEVkVYQUtGMGZBaERHWWhqcTRYd3FaS2t1RDlKQUxQcjZQTnVrMFU0MXBH?=
 =?utf-8?B?YjJpd3E5RUpEckZVNWlwY09MSHNIWGxCTmUwalJwbWlxR1hlQ0JablhYZGVr?=
 =?utf-8?B?Lzh1WEpkOFlJcCt2MGg0Wk01WkxNdDZMU1k4YS92M2RRWTVtZ0VvYTlkUDlh?=
 =?utf-8?B?MXdKY3VDV2NOR3ZteGJGT1gvSU01K0EzOFd6ZTR0UzF4OExCUmFNMDh0MUFZ?=
 =?utf-8?B?YnltdEdEdXhSS2tvUVhuVzVoUnozZzl0QUl1NDVKb001RWR4aEZ1ZGoxT3Iy?=
 =?utf-8?B?RUZKc0V1VUVEYzhveU4wOWFPNXJZTEJ1TFNrcUpJbTlISC9VUTR6allIKytq?=
 =?utf-8?B?WVpNUzNYVnJqakloRXdnME93RmpmTVE5RFlxWTJSMUtLVTltbXdmSDZDdysx?=
 =?utf-8?B?cGtUOU5VYkIzSlpyNE5VK1g1WEVaVXRlRncyd3FLeVU3ZEpTdzZXRTJiNzNW?=
 =?utf-8?B?TDZhd2VPNkVGYktUY0pmV0ZuN2xvNERSVVNLSnh2T3NQSVVEbFc2NUlCM2Nt?=
 =?utf-8?B?cmU1aERORGttTU1kZHBKM0pYMFgzYW1STXZka2NyNXJnZDRleE9uNUxBVlVL?=
 =?utf-8?B?andTaFlyTjlZVkR3TWtFTzlsdURPTnpraTNjWjhCN2hGZHhRRzBZODM0c0Zm?=
 =?utf-8?B?Z1ZFMlcvbGczNEpNbGFuazRpQVg5VkRZZkZ3eFNTZXJwZ0lza1BhelBxTHpj?=
 =?utf-8?B?ZHE2ZldOZmcwbWUzWG0vaDdVL0ZLeWNqbU5NU1V2MHJuRllESXg4bUloR2JY?=
 =?utf-8?B?SWpTVzJtVGNUK2lpVzZtNlo3VHgxYm9yVmdiVjVWTFhFd0lMeHViUmtHU2ti?=
 =?utf-8?B?anc1ckY3ZlU5ZTNtVEJoalA2YnFwKzFuQnZLOThkL3A0U3JWNGdncFJtWXlE?=
 =?utf-8?B?Mi9aWFc3dHdHSFBVWVBJWWFYMWIrb0lTUkdMUUVrSnlkRUFEREpIZVMzNStQ?=
 =?utf-8?B?RTNJeDIyOFFpTDNvYWEzTTR2enhCTWtMZ3BETEdVVVhzQU8yeG45bXY0c0RO?=
 =?utf-8?B?aVhjUzJmMnYzTzdBVFh2ODh4b1lCaTNabE1EVWExNlQ3cHVHRWNZTHdlWko2?=
 =?utf-8?B?WUJsbHVta1VDa1oxTG1reTFhTU4xaHhydThZR0d3cXZxcEEvbTdBV0k0amlM?=
 =?utf-8?B?WFhLUUhialNZOGtTb2dEVVlPT0NadDd2R0VOS1hqdkJkMUhFVFV6MnliSFky?=
 =?utf-8?B?UjBBaGZRRERxNFBEbkN6RUVGdmY0MEYrdWg0eXljeEhkdFBEUjJBbWxqTDRM?=
 =?utf-8?B?NFJqNEpRRVAydGZvZVpBZmYxVGk1MS9Ya0ROOHpENmtqOWxrb2R0dzZCcm51?=
 =?utf-8?B?emgxaTBmMWVRRWpwdmlNUEhzTGlRWXphUktmUTEzVlNoa2ZiTXZYb1B3Umtj?=
 =?utf-8?B?Vk9CdnRhbFNyNFFqeEdweG5Hc1dmOG5ORUxoaUs4R3VBUjNzQVo3VHltWjZM?=
 =?utf-8?B?ODRmeGIzclhZMm53TGYwYmxOOHlWMGZJSmhhWEZTTEU5QmU2ZVFOVHlqeDR3?=
 =?utf-8?B?S0s5YnBHb3JkNGlVemYwZnZIRTVJYUcxRCthQ3JBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:SkbA4ynjZ4RaBaN2BSKJizDXGFSqJjgwpGkPfFKyXix8dROM0agOaZqs+8LNtuWC7ErLhKLgiI8ctj0F41fDbOEvYkbDUBAlm8+0Gzu6ddMz7YSPCageSHA8/ydX15IVhlwBPORmElYf3v0VrpMasZGaIemXz0SlfgutCgwcJdhU1hczCWPYTaIXgL0vGVmrab+Mb0syfsXRJnyFRhcmWQkz1m+WYZ4/FaA+21ssONfRPoq6wuZ4zsQis0KlUGptrTY0DsvvVTSGeQXZUi65ZT407ncwxWuH0o3VrmGlYKRE1uMsZn3KoO3dcfjcSMkKOGIka+9sjIBiZDkRlXf3cYQwUywbZEMMklVKHeSBfY8=;5:/xxOLWA5wrb8hG0VSuDy07AvSKsyz0zJJIXZhTiUmEqhM3K1fR651pKT35oULIFRDjgSxO9Anf06yNLjvgJyaQkrFCfiTZ2ZzBSGRWLzWXt4csesR4oXIUorvflvosEHMAu+wE06mZcxk0oQriha2AqScEZtfu/YARqPD2OcVU0=;24:B5g8KuszP1cpGwi2KGzbp3YQ6oLwEXEmkEjfPrLJLcaqh/g0knftENsYOsp1ylDo7DUfNOAwUC7R2FW3GCY50uAPqitlHIKAK8IPCKwjDPU=;7:PP48UGxFgwMlj66m8KJ8NDQIv4+K+SWobxjN/R5v8Wvs+70XxaUf0AUrtyGgdttnFsvYNb87OplUBM2YA3Mm5tFlmhuPoxfuUYHCsVLKuB9iuaHimBuaS5GbFenDwa1FvbkzOpPbxq/l1+6n7golakvKW95Qr9rh6FM1qZuH1irNLuSfeZZpOt3koaaE3ADbH+GvKUZL8xdA0MK8646sUwEBDnnNUT1Qv+WqL1lV9rbufVKze2Smt+MbZ1957QW0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:XVMNWBiU5v6jDmkG5IiWL67CIy27GfBiuUjVjecmjR4dWQguZp/0esY+cQ4VQsErwwRphop5P0W5oG/fYFPCPiuyLUzRQEfeKY5FybPfA4k7huv1cUbIOoDUFRXQkH1iFWLVCmaIM1KeGONV/DZL7SNIPeBFqTNkvcAFTxgem7o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2018 22:23:10.6181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b30654-9efd-43e4-c46a-08d5765507d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.2018 11:15, Dmitry Vyukov wrote:
> On Sat, Feb 17, 2018 at 4:00 AM, syzbot
> <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on net-next commit
>> 65bd449c32c2745df61913ab54087e77f9d9b70d (Fri Feb 16 20:26:35 2018 +0000)
>> Merge branch 'tipc-de-generealize-topology-server'
> 
> +tipc maintainers

This looks to be caused by commit 0ef897be12b8
"tipc: separate topology server listener socket from subcsriber sockets"

Thanks,
Kirill
