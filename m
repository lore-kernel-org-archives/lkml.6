Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeFEJDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:03:35 -0400
Received: from mail-db5eur01on0134.outbound.protection.outlook.com ([104.47.2.134]:28864
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751442AbeFEJDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:03:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: INFO: task hung in ip6gre_exit_batch_net
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
References: <0000000000006e4595056dd23c16@google.com>
 <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com>
Date: Tue, 5 Jun 2018 12:03:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::20) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:d00V8Rlhoqmu3Bg3FZZn8H1VfoLnMqavgSRyrJYomGOVTpqS5LqtI5ArBGXAgpFBtVo574PqbtrN2l4Qv58O/bxXw2G7hBzJx0KNhX953Fd14a79IE4bPlLvkx4p1rlMJKq2JhuUA/JvvCP9VKPRSiSHrwqQ59wYVBCyE9WmmwuvZKKE1HtkrME8jN5uB+rRwGmSRwmyzikw7BKRo/rG+9RugLcVeRiRnGvDMzI6I5ki79zTJEuWf0d50lwMFhJ7;25:HYGZPxz3qUuQW6GdQgI8P89UgwbabKbbgTUmr9vLATnDOrUVhsAkma6j3dbseXFTff2YuAkmWK+MJEpQYcxlGczevN3/xSjL2kRlfwIEbsJyYT8VtWo6eJHmvAN0iveO7+dYZB317zv4AbAD+EYRA7KkLrtK1UoOWEHTxKXhitvF+2Ohie8fQKY4z4mDNahc/RVUxErgfywycyHm2CtW6ebIVpV7MiJNvScpsFb89Q9RJFJLhX0pxYoe0sDLBY+uReoUu09zsrAeadlESfsDcqmeVrRGTMeenyJogHoN68zFsUoDL65ZjkNRKx25qat/HMkZQfLLORS4pdx/nLq+2A==;31:LvM26rj8l4Z2Zs6PLlGgNrEWAF8+DLAM5jhoIglVnD64QCNHH3j2LKXlFBApXH90jNDmu/AM/L0nw8Deh8M59fHJd60Qe9LINx6BcAteQMthkWgYzv/HY8sqId5SjyPlxApdUm5y6HN8iVw9DgGRJ8Pt8NZThV1qxu/2AwKPXeljTqTrcjYJRcBwErKuKW6VwAmMpiRyFH5y9v6jYnUVSNgw0euQfNHBKwr4LkFYZMA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:UqK2IJXGGcYpguWGTvgsV/yleVhwNUmvVp09SZOO7cjNZLP+setBS6c6FJle3NE4MdCTS/DxQIbCowtc/eIi9MKTKj5U4UAP6StxRL5Nv9ZZ//6fEfsF0nYxsGBiSM7/1eY/56rdqmTIT256PMwwlyYQeyiK6/n4+W3388oGK0Otj0xYrwExiGD02auY82aro1LM4p5a8ObJUo1GfWMnF1XfCNFgsYCpndiOy66SsogGluZRTFr1V7X1dXXniWJREGcIgTkmUwzb7EWVI4eS9klZC/0QcQjAMREK63VxufVttZ8fSR9PCgWMGlsTU2OmRvx3zpQXUP0JIGwgBbzhaYzyQpVIQNzkahaXQMJ2YMBlwdNuWpU5oV4uF/OOhfh2gLY3xQPHtZxXPdJZo3k/bQAZkUqWKhrs6/WO+Sm6QPNAqC+obbTB8YvaAMnICJQ+MuL6l7XFKJT3oRgbLmFqwXsnJwoIdYQwrO3rp1sRGEwgq2Qf9ySz8QxOcGIDm2dO;4:3Ltn4T46TPtUqPAa88aXE+UiE1Q/LAD+tr3dTWgQLqCPpJCLn72Ql91qYJlf2U1xAUIxA6f7ScUIY1uSD9T8MYcCB6B2KmCTGofwUdYP78dcL5PFcwREZth2Q4FO8HddiYW+bZbux1Kw0zRurFTvBK/5mHcTFCJ/1co8I00szXvabCMqFCDI0kUpRtw0myEh5Jj2UOPzXi2J0yIHKanxEE1VatXrgAp9naFUSWSZmkupchbiKrD8KpOn6NRtrDvn360HwW6D2OYPB0UGSyHZTA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329D8D13AD2BFE00C532397CD660@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39840400004)(376002)(366004)(39380400002)(189003)(199004)(110136005)(39060400002)(8936002)(8676002)(54906003)(81166006)(65826007)(4326008)(5660300001)(316002)(15760500003)(81156014)(16576012)(58126008)(68736007)(966005)(106356001)(386003)(478600001)(7416002)(105586002)(97736004)(53546011)(31686004)(25786009)(55236004)(11346002)(59450400001)(446003)(486006)(65806001)(7736002)(65956001)(2906002)(305945005)(2616005)(956004)(476003)(16526019)(36756003)(64126003)(76176011)(52116002)(6116002)(6246003)(3846002)(66066001)(53936002)(52146003)(2486003)(23676004)(6306002)(6486002)(50466002)(86362001)(26005)(186003)(31696002)(77096007)(230700001)(47776003)(229853002)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6NkZZMVJHc2FsbmxXVTZuL1JNTWd4cGVm?=
 =?utf-8?B?a2VjcHpJR1Vrei94Mnl2UEtlc3ZpNkdUTzFxZ2NFN2UrZ205cTNQMTQybVpK?=
 =?utf-8?B?eVNPZFNtUEo4eldIWitURzdZUHRhSnFtU2duak4rVS9PTkFSblR1V0pjSnFE?=
 =?utf-8?B?VFpKbEQ5cVhEckdSY0VMSkxyaVExMStoQU53OXZ3SVlZdjc3UWViQ2w2M0hT?=
 =?utf-8?B?WlVEQUFSY05mZDB2eFdGL2cxaGR0eGNQNVZKdGVMNUM4VFRlUmsrU2ZyZ0V3?=
 =?utf-8?B?T2Q1a1JQWHFXVUZnVGdlZTFVUUpmWTBHWlFOVTNzdWNza09veFpLUlhNTWc2?=
 =?utf-8?B?WTcxcm9YVUU4cHlnMUJ6ZmowdzhvbjlOdHFYSGRHMTNoMDd5bWU0b2VPcjNE?=
 =?utf-8?B?YmFRVit0bVBWS1Z2VkdVUmRJd0F1dXZ1dzNNcXdwN0VIS3JjK0VzK3E1ekJX?=
 =?utf-8?B?ZWw5WEJsYmU3YmRoNnlFZnpaNEFETlBtUkUyVGJpSlJBVUlnZmMvSU9sMlRN?=
 =?utf-8?B?YTEvY01PWGJ6dWt2aHpLWDRUOFI1NmF5ZkMwNlJYM2ZzeWhOd2lrNVhKRjd0?=
 =?utf-8?B?QkNvd2FJcHc0NDRSVFRJN3Z1dWpUWHIxZzRyKzBaVlJ0cXFRc01UdnhPREdm?=
 =?utf-8?B?Y2pFWXMzbWdxMHBFZXkrNzNoWitpVjBUaDJKZ3BsdkxYTXhhNEtJZW9ZcCsw?=
 =?utf-8?B?MEQrenpqeHo2RGF4SkV0L2dqVUlnUnc1YnQ4WkJ3bUtmNUp0OVh0eVRNMzlE?=
 =?utf-8?B?dkhnYjZNMmI4bFFCMlAzYWxacHNBaDlCanRXOStXc1Avd1RYZkVDYTFxWmt4?=
 =?utf-8?B?OUY5ZGZhTGhTY1BaTGo3cnJUVE5KR1dxdGtkUk1meU1pQTgrV3F5TVp5RkQv?=
 =?utf-8?B?SGhmdUFpN1RpMXdvQXNHakZ6OUFVcmRuTEZXWVFWdVdodmp4cGpDelVNMEo2?=
 =?utf-8?B?a1UvUEc1V0tic3RQRm84Q2h3c1dIR2RWL3VyN1d5a2hkM0FEckYxYk1xbVdt?=
 =?utf-8?B?R0R2eDJFR1I0bWR1d2ZadmI4RTJFMExOamZ4bjI2aU5lUDE3UEFyb3lkSlBL?=
 =?utf-8?B?eVppVVVKL0M1WWYyK2pSZkpZTTZISmc3TTlmbmRWMTdXeUdCdkZDMThKVEN6?=
 =?utf-8?B?WWwxRU9pc003M0MzbkxPOWwzMU1hVE5ZaThvWFpMVTlsZjZxYnpXVnlnV2RU?=
 =?utf-8?B?UFFsczhwdWkxdk1MY2wzeEY0RXBPdGNncW5ZOUJCK2hRWnFUYkVEdmp4K1h2?=
 =?utf-8?B?VDZSaGlya0E4T29oS2hXS0NHM2tJVDdQVDRqekh4czFwT0hqdWpJWERCNlpo?=
 =?utf-8?B?d0krK2VwRC9Bc1NobWV0Skh2WnZ3TzVhK2ZLbzlRQ0lRcWJybGE3amIzNStH?=
 =?utf-8?B?SW93Smd2cmlIeTlJZmJHdjZNSDNLUytPd2RDNXdSSldHK1l6bWU5WU1JV0E4?=
 =?utf-8?B?OXBvWEJ1cjJaRERHQlp2M3V3MXpSeVVKT3BLUXkrQzJQcDFzQzNGSFBQdU8w?=
 =?utf-8?B?T21YS1NSdkZJdjdzRTY0RmxQaTNhREZZZ05XSTUrWUFicnNyMjRBa3FDblV5?=
 =?utf-8?B?RjFHMDV2TFlWazlpbnFRWjh2cUllMm5qWXNHaEhKbmdWKzg5NVdESXpYRkJ0?=
 =?utf-8?B?TzFYUXF4dUk1ZmEvZHBnWnh0VDBSRUpuTHhaRVBmNnBydXl3MEVydGs1cXUz?=
 =?utf-8?B?Tnhab2lNR2FmWGNXekZXOFFSUUZHOTJzSWl2eVluOU80bEJySGFRK0xHd0tl?=
 =?utf-8?B?NFIyU1JrWUI1ZW5XZ081Q29wbnZFN1JGL0ZTblcwTFBIRVpkaitGeU5jYzV3?=
 =?utf-8?B?aTJ6N0hHRlphSmhQMG5GTEViTDhZdDdSZDYwcHFVV2dWOTNmOVJETUpuS05z?=
 =?utf-8?B?RG5lbzg5NDhxekNGMjZyblVlRWQvTURMK0Jsb1lmQkJuME5va2RDbkQxN2lG?=
 =?utf-8?B?cnp6VWpmK21PU29VanBLWWdIY3Zhb1EzdjJrekZHK2JNRjBNMUh2dmQrOHZj?=
 =?utf-8?B?SFRlRll4WUlSbEUwanBWTElHakZmcHlKNm1sN01Ba3prZmtmMWlYRDcxVlh4?=
 =?utf-8?B?OUtTazlYeXZDZmFMSGkyYlZCTFBscTFGZjJiNDQ0OXZ4NHVMb3BwWmJnZ25r?=
 =?utf-8?Q?hCxkH4Az2+cGrmsp+qSlHtIAkTad7yEoTEzhu8FEecAkox?=
X-Microsoft-Antispam-Message-Info: l0j8XujcjHE2pCImHBJ89/g8zd6Nya+4apv1tHfqHLAfDqFod/rMyUnHzOV4upxSXCEX1+2pPt970AfIHUavJcA4INMwzA9P9A/j0d920ho54hELD7bvxf5YdX33s1JfQjR5roXbenwabSW7JoCXyG/hSaQdCb5l34VeoHHaekSIV5zKppYaFhdpIM2BjzCI
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:o3yDcfS6hte1G0O05VPJNWNm/a2IahDguVlpZI7Z/x9SoLgTpUEOd9yof9zwIxj+ziE1n0d0tbeD7LDYeDoy1d1rgDWn+uf68Fw5lamMmhhReeArOtpGEutOkpMxwX8Do0Bp1hbzo9aSUu3CVoHs3wFg+2kVJPUytBzhZSHfpV56Kf3f24Ml8XvZlLKoMEo5AEF+qw43O0ON8noFwoAQstXtqSsWb4eA5tL+UmKsCRtmhZroy3eIoz4PuS+q8VU7E6zK2iYpk2i5eMtELrRk4iLobfF539BM7FGAn5+qsMz0IeZixI+zac+ExlW5givIIlQ2ezQlIj56oSoiGoEFK30GY+aKjBz0OFX9+lFd6DR/7CE3H8OySBQwCXFLWbOVZSNIQ7ZeFBxjPtw1FeGOkJddlgv0L+isdWzProtMJWbQmb5Q4Q5fyJO3FietFzQQK3THlrXUJxfVFPWiD2Whiw==;5:+193+2PMUc9YEVgVxz0qjBnnDYp6kzg5bmg+2JbVaCfjpnm+TDSPd0hzFfraDSdKw5MJHOi0j+quX7lblYGPa6CjkAzLL3h5jvc2/qFMRXX9pELE3uMX0/osceaRPxQK6U3VSf/USoSwzLD/9YtrXE/xIOVet8B9sZsOVaUXm90=;24:D/99b0dt8tXfor20kOQavCXDRG9Ltxfyn+GfEhh5a7OfXFGZ10H1tOUeNjqu/6d7Xa6UBlp7SvVTlXMmQEFSGexN2FihUUC55FsJoWxZNkk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:5DgBy6ml/MjOoGPFy/iaTdQNuR7xfKum6khWQfnnyttBAXDtN2o3N8TyAC3/w2rEJTwB64z6KczZVRPMsm+62FeUjZlSRUrRvouooSv2x9ErIuiP4XBL8u21/tgj3ESwbCXjb+MW3DA/TjZY5mJ2gmqq2XWdqoHBXMpZBVj+po8RmBeiFuHCvkTSG2b2u/fD8mHI0op23kQeqrzI0Ipfua4CW7IWHbOw3v56RFFkH2StwkJisVY83dpa35ZtHRn1;20:sc/MkF5heML1tc92PQp45uFlkh0HA6waeM1igCtJCYuVN/sAv586D5itM9ZuiMkXEaOBPG2VJGAcDx7bCTFWYTDSy69REh/vRwD7LeBFWx0ZpBQjO2GfN4W0+J9XQPPF1tN5BlPQZiQl+1UFFzAR7zt8+XEYReP41Ev+RlBczc0=
X-MS-Office365-Filtering-Correlation-Id: c207c6dd-d9cd-498f-2423-08d5cac3345b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 09:03:27.9396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c207c6dd-d9cd-498f-2423-08d5cac3345b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmirty!

On 04.06.2018 18:22, Dmitry Vyukov wrote:
> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
> 
> Another hang on rtnl lock:
> 
> #syz dup: INFO: task hung in netdev_run_todo
> 
> May be related to "unregister_netdevice: waiting for DEV to become free":
> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
> 
> Any other explanations for massive hangs on rtnl lock for minutes?

To exclude the situation, when a task exists with rtnl_mutex held:

would the pr_warn() from print_held_locks_bug() be included in the console output
if they appear?

Kirill
