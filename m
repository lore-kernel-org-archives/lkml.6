Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754911AbeE3FsV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:48:21 -0400
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:27829
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeE3FsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:48:17 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 3.18 093/185] microblaze: switch to NO_BOOTMEM
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100050.700971285@linuxfoundation.org>
 <20180528100058.705378203@linuxfoundation.org>
 <CAL_JsqJzkv3Vx_sjhY1fej7adVQZz578E4EGXZuOUWVoQzoJJw@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <5fc4c659-7308-08b3-aa2b-e8f95cb4054f@xilinx.com>
Date: Wed, 30 May 2018 07:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJzkv3Vx_sjhY1fej7adVQZz578E4EGXZuOUWVoQzoJJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(65956001)(50466002)(6246003)(8936002)(4326008)(65806001)(478600001)(9786002)(5660300001)(36756003)(65826007)(36386004)(77096007)(186003)(63266004)(31686004)(336012)(486006)(446003)(8666007)(2486003)(23676004)(64126003)(26005)(476003)(230700001)(2906002)(76176011)(126002)(44832011)(11346002)(426003)(2616005)(53546011)(356003)(8676002)(86362001)(81166006)(106002)(47776003)(316002)(229853002)(81156014)(110136005)(31696002)(58126008)(54906003)(305945005)(106466001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1804;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:wVJmvVGEQrjlQcwVvMT+p6zaFIzsifyYjJViNdT24wdFNzYjGViaoaXC+xBbrkplGwo6Jshn//76nkxROcGURsLv4L4JFVA7pbAWexMMyKuI7cWiWUiSuuj/Dvq5fRWO
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR0201MB1804;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1804;3:p7w4pZFaa68xeK2ga1akLhrSQ98AzN2f4f1CVx0XivGrWVYDmzdBUw3datNSBVk1eprBtfhhMxJ1R4o7e3EWTlXbhRjTA1BgugeBwSz2deV3gD7m01J+hb/JCxPxVE0o5rBXL2LVubF5AkmD8ZP5LUEV1zi8cpyTeJAtjuj5Un/V8Xl82uNob1RuY2z0SwDaO70ehvGsCs8G5X236jlX+fCeSe/xpw7KGVn53O7H0MIDt3nhjbXtpx7HxxnPm6GMMYJCf3Wh6LihRTZ+lqeXu25OwFmqkxtrT8hjLjKM9tUa9xFs97ey5WmDcMH9W7Jr5197wnyD3OlAo7tcI67Uwb99TrV8/5sB0HThVGeBTtk=;25:dWKyZbgk/jLQi3lFGrTDtO/84hQPVGp1wE2EkCkQtlvkGn0L7MzUa/llWUAhcmL+33iC3thvBPfkjtHaY/BjSCJDulvjd8OevVvcQIIiRkibDaZTnJkToFlAbg7NGhY8PD4zTL7a06KldKCKu2v7pmPZDtFGaNXOWecLonCoTQ3XUbeRL563A8S+aA8HnYDpyKCbH0oesoLmuJdQpCqV8mukmxTTf6BKMJ95tBccGqhDKEyTiFWJLkoz7UKJ2xDIxQpkiRFvt5XRj6ELrBCQd2CTUdbzAIossyZfmDW4ok/EiGd6mGwDBEOybIJQsu+0ZJ2ZLciN1etkJd+8azyWpQ==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1804:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1804;31:AObMWr7JORgPa39P1cv+br+nmpAMZstO+rwpfH4SL294q0t806pCb3H22cLDh4YJ+BcZmDhwjnHWDdNSKJ0t/ib7JvZosX5mZ1S/BXpAxuWI84rXJj9zRONt+uzFtfNQTmm0qgiQ5UVsd5f5mfyB5GB+pf28/IVxdmTfb/zrOk7KEqiUWFwT+Ph7M/cetXO+W2FtVJFwY0uD3Sa5Lg7uPQI9jC8KsXpax1oH7r2CSVw=;20:fjbwhsQo/+yF95kWHswTlGYDwYLEqFSOu69uj7KWlkNYrizUhTdxjiotdP/VOxVtXuGxMyPlPSKkwyK4GKld5rmr556OD2bCZ3x6cUNrIwES/7OTwU2L/g4lLxA7Utd1dhasAk3CeHoX/pQy021207fKb+tQIj/L6m5FEY1BMhyeJIskxzhM9XrSgP1WP+arlNXlevUdH9Lv/i5DTHGd2XCXnwYTqwPBovmqaomVi9jRFV765y29enZJINUZcy7pOqHeP6BRGm4RsBDcP1O4q8Wjk+0eNscq7RXNx5WvgjbklJP+QvVn78zpsUn7nKTGLQstTW7SIT5avqadiBN80CrXiFFjUtSu18DFA9xULmaEjxQ+cWtzThc65M97dM0UNZJ6aUpIpXDbr5PUAJq7vqJXq425u3fqukzkyafL9QzZwawSy1Ylm2LgxottNsuZCo7WPQ8PJUzum6WGs6WEZ19uLWaAYKGHNCK46olHd6H5mcUAJni0LTNnTqbIjkkQ
X-Microsoft-Antispam-PRVS: <CY1PR0201MB180441390E3F2AE1404D3CE5E26C0@CY1PR0201MB1804.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1804;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1804;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1804;4:bk3lwa2nwDd7/rcL4l9yEI4+nVjVVpr1Ii9PL/oapZsd/r24NVZyBZljW3JmmRGYsgoJ14AvDofib7B/PQEjO2O4dCPSSG4NX4dZPVUjpxa578rF2rr3sjj6a1IRG3gqXDLwv3ei41+BygDaCJee0/JO+/G7ucB3iF9ZE2Jg3a2Rl1XDlQAbzhJrDxqd9A8fqPshTsT3YCcswNj2CZLlthIcXCrbmMAJorJJ+o+5iygg+WXv1m9WBcmghipeimU+6etmbKDIvcIzY7bRTBwXnQ==
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjE4MDQ7MjM6UFlZRUdsRFJzeHBubk1JNTYydE1Zdmhz?=
 =?utf-8?B?VitQUE1Lc20zYnlSQk1BaWEyMCtmRFYxKzJCVitYWDVhdVFIL0dtNVJmQ0Zr?=
 =?utf-8?B?VWxmTWNKV2EwR05Pb2huQVh5djN6a1RPVHVtcitBS1RsTSs0amVmQjNxbG44?=
 =?utf-8?B?SGNiVjNYblN2MnZsRGplYlJ1SnVQbVBNUnBpWUNQYWdoRHJWWUR4Ymp3dXo3?=
 =?utf-8?B?Q1ZKRjg1ZVlyK0NIbEVpOVFZb0FkeWY1NUJuZnZ5Uk5MTG1rRncyOFJzanhz?=
 =?utf-8?B?M1oxQjdJOEtsRnBFY1FkT0dTRElGOHB0WGwwbDdLWklMSlM1Q3oveWg5cm9h?=
 =?utf-8?B?a09leVI0d1BKT05pMFdLS2hvekZuejUzVzd6cUVBcXlSMTdhNHZoOCtZcFdQ?=
 =?utf-8?B?WDlIYUJsbktGa2pCa2xRSDFlaHpiZjBZZitpNnZRbkwwRE1DYnd1UVIwUXVx?=
 =?utf-8?B?c1JrWUpPR29pUlhPMFFEdUpWVUwzb2EySnFXZFZYSXRMUFpIa0I1N3RMcVRF?=
 =?utf-8?B?dWxXcEZpU0V5UFI4OVdSTk0xUC9lVm5aeDNjSm1zekZ5MlNpbnRKeFhMN2U0?=
 =?utf-8?B?OFJwYVpaN2dpOWtETllmRnJ0d1J3aFc0MGxHSzNXbkVCenl1ZjczM3cyQmpO?=
 =?utf-8?B?TXhJZ2RXS0tOc3JGaitJQmhKMk5ZbUhNOE9ESzVxalZZekp1WUZNenFiZHpo?=
 =?utf-8?B?a1dGZUo5YzVpdDhTQVhHU2FwZ0wzZkFCbEdXQnlhR240NjhuNjZFSGN5aUU3?=
 =?utf-8?B?cG5RRFdtM1NIaDEzM0F6bk9EdTN2V3psQjA2ZUNnU0VtZlJLR1N1NFFNMm5k?=
 =?utf-8?B?NkxkQUQ5dXRaZW55NFFhdytKaFVVcE51TDhVdjU1VWlPVFpmODZlLzk2TXlQ?=
 =?utf-8?B?eDVUc0ZYK3JyM2RBczVXeWY0VFV6c05sS0dmK0RJdEhTcityblYxZkh5NlVG?=
 =?utf-8?B?VHg3VDg0NzFUeHhUOVNZakFJdE45TWY2SG9mR2lSM0pMQUpKay9iN2pwQzNJ?=
 =?utf-8?B?alRWUTRUTG5LRkdBNW4rWm43eDBFcEc0RDJ2S1FJSnVzVnZId0lWWExzMlBt?=
 =?utf-8?B?MXYxNHJ1Qm5pZzZMa3NoR2tCMUd1K1ZYaHF2N096dng0U1FsdkVxTk5RdHdP?=
 =?utf-8?B?Y1krc3hFMjVmTUhIME5SdFE2aDRWMnIyZzZCU01Ub1RKUG10bTFVTlZRNEV4?=
 =?utf-8?B?WTViTmk2Qnl1S1F1b1hTS1E0Wm9kSlRGSzAwaEwzbnh5WER4eHhiZ0tyQ2Ix?=
 =?utf-8?B?MXFPY1dCWFU5UklFa002SHhId0hzazFUQ3A3K3R5akVHa0ovWElnUHpLeXYw?=
 =?utf-8?B?MTRpZW5UUEVtcmdnSGUwWGxwUW9ZY0FUNzJrbnZETys1REo4RENEMHJMZHRD?=
 =?utf-8?B?UXljNWgvUG5lcnJYNHJJTnV2MHFZWFlwWVczQUhJeTVWK0FJQW9UV25jeXBV?=
 =?utf-8?B?aUVIWTZmUUdWYzRyTE5uZzNkZWxCaFlnRFdsRTRNa2puZEpvcjZQMmVySUht?=
 =?utf-8?B?U0lheFRqdTNYRWJiWDNZZ3dONy9BVmlNN2FldGRibU5JcFhNZ0lORjA4dlRr?=
 =?utf-8?B?Q2lYa1hFeWhJZUlpR1BCVDd3VE9jL2VuMUhwUHhBLy9HNWkwWXZKblI1SFE3?=
 =?utf-8?B?UzhlU0ljaWpySzdxMFhEaE9FR1Bpb1VrYmRFZ1Z2cHJ1K2x0NFZVUDdBZ0NN?=
 =?utf-8?B?VFNhTVA0TExYbGxvd0lmZlZKOE0zQUkxNjVmd3Q4alpDRm9GdmpmU1JEajc0?=
 =?utf-8?B?S1c4L1pFeFZiOFM2QmxxbmI4Q0czaTdYalFrV1FoZDFLOXFkbTNtTVRMUE41?=
 =?utf-8?Q?7YRvC55jKs4qx2K?=
X-Microsoft-Antispam-Message-Info: IL6leMXWdT/iyC6mfp0WhtJ/6w8DUt1n0hX0CQ0CH1QY9bN/VWbX6dxxBfEiAKK6XWC59X5G+msHxHL9odpz/FO5WE0BDHI3uKP1jdUVsWcFqd3VWbwIvUlVngkLaP2Av8+IPy/BMSC56ij5AbCcOkfwrwb2ATy8T8kIJqgjaZCF4RfHN+SBSY8eRYhCNd8a
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1804;6:sGwaCrRPjQ2YwnsJiyUToYko5T28fGX8bLok9MJYAkTM694YFWzTsPYMalhg+QaYZmDcRaGIvXfmoLAV4tLRXXSCatYsXXxeMYg+nrnp/je2i5hdfwNu94c0DXbBCPZtwCS0b6uZ73YOJulBh0K9gOw2B5Z5kQ7ErhjYt26PQTHyLxcoW7bcIPAutDuGJsy0ocz+KwyTzU+ZtCM4PU771s9WsVhifO6qIltTKAtsED3YiipuggnPnpN2o3Jrj3mvdTHo6nF3Ozeop9fIhcmZOLjNf07te5NAWuXuG/MzzHNUw4UxAJYRbgz8wK5Dlzr/iZ8a1eKKhO6zlfNg7Woky2fKoDW4LncoSrGnWj47rTlL3goEiIo/n+K0jk+5h2BXELt6Sbur5VlzKVnzPcBB44xiaXUiacI8kawrj1QaajtXQTPfIj7gevvMuU9hLGhzZaM7muCYEpm95VjFZ76wkQ==;5:ct0RqHDmOBp2k19kApu39/O/3qquw/c0EJLxQS4cK4reZiu/QCXSNwO/p43f6j7Kd5nwkfTqjSXxnE0gEfQJzqmZtwPEBZzw0m0vP/8A5mV4BY1AbGJEFAtZavL6Qa33vb786ZJprt1aiq1V8m+AkHNbe/FDWmKGhFoa1DxDziE=;24:dlo0Rbk6QIvpGmynv2+azlJ29DDAyxDf56qBGbSj7V5oYb+fjKzAibNsB4rK3aKXUNrjkTjKJorB0IRIoVi/C8ftBLVYNUAXqA+4zYh4amI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1804;7:KRT0YdVwtpXyBit2UwhBYwvl2Q2O8rFSSx7BE3ySdv/HAJEHGW/FtLmN5oZ9Iu7F+OAoFtkAly3r3yEHnMV8TzRxTGOnIK0aZJzEagYiqcOLbwjviTp/9lLkuR9HRYeG5zaT22MBYeUny2/2Ldk7E9zQaJRzYm5mACnkoz5kQZTs7WwCIuIvDelijAXTQterZQIRfbfrJqNrGg5nyZ33jfFmSAdao4WbB8xjHI7fG9/KJuzVijqUSC2XILNy1T/E
X-MS-Office365-Filtering-Correlation-Id: 9d88a219-8efb-4810-b996-08d5c5f0ef91
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 05:48:14.3045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d88a219-8efb-4810-b996-08d5c5f0ef91
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1804
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.5.2018 16:34, Rob Herring wrote:
> On Mon, May 28, 2018 at 5:02 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> 3.18-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Rob Herring <robh@kernel.org>
>>
>> [ Upstream commit 101646a24a2f9cdb61d7732459fbf068a7bbb542 ]
>>
>> Microblaze doesn't set CONFIG_NO_BOOTMEM and so memblock_virt_alloc()
>> doesn't work for CONFIG_HAVE_MEMBLOCK && !CONFIG_NO_BOOTMEM.
> 
> Unless Michal feels differently, I don't think this should go in
> stable. The DT change that broke microblaze is only in 4.16 .

yes. It is not needed.

Thanks,
Michal
