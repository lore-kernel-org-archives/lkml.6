Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBBQIU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:08:20 -0500
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:21640
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751655AbeBBQIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:08:12 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/amd/display: fix incompatible structure layouts
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20180202123232.477388-1-arnd@arndb.de>
 <5307dea1-61f6-2c7b-75db-4e1a0885de30@amd.com>
 <CAK8P3a3WN6VdJuEt=0nvC-8FCiOAVo8R=aRso4=C-jwM4rdQPQ@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <0e880a52-768e-c476-84a5-3e9638b62f1b@amd.com>
Date: Fri, 2 Feb 2018 11:08:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3WN6VdJuEt=0nvC-8FCiOAVo8R=aRso4=C-jwM4rdQPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: SN4PR0601CA0004.namprd06.prod.outlook.com (10.162.115.142)
 To MWHPR1201MB2477.namprd12.prod.outlook.com (10.172.95.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62a1d090-cfbc-469c-afe0-08d56a5727a3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2477;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;3:RMaCd2sz61kyrCcS9VNn/VqA7gR+tOHbLYAuamfWQ1hxeg3rJujnqBzie6ktQ9B7YbZFruf5L7IM1zoRPtNMkUBWxWbmtZzwVk1g96WxSPk4+cX/r9q/UACklFIPVsI0XwudkdoVRxi/qddMrm6GjQ8JlejV4znpXypLMG+srVCuWWHkAXXudEBTwF5iHHopTnUoNV0WB/noSSwiTQ+VeTbFqGMgPZwnh/Fx7Lc6BURhOPSxb2ihKd13la7APY/H;25:f7qzP4aXpoKtZhEhGjEj/NKz4uYuoZlFshq3q95dgHwRV4TrNNEKepL7dVPeQBtgXN9n4OblsYLKEij+Iu32mtr38CuRtaO9BqtT1aFL4LFVLPZHqsbcFmtEYGUnPtwr+psxLqV3JNr/XYbiKW9tGeTc801JsjCr0P2Bwro4JRe/us6A4I/R6l2jvpf891phdXXOhS0F2axiplB2YiqiTRzbVHgrcE6O773VPzDV0F5F3yOcJxhOgIRy2PwC4as0aSw9haBPBmgOfPLLxOaJwjaQLHyGz+lthozLoUHdSLUepjxiLIE2GjJm29IDZKxlfbSJY/0w9ZihRcDTZZ+MXQ==;31:+2756DzSw3BJuC3xthDcjXPPGyfHmDx32zT1rUjD75mj32COi5nJ4anVLQhvCFmpXK6J0b9avuJGs4yljZoX2ADGI+sDwlQL/wYQ43J3DsCMBc/5ct1YNkDI5/js6lyq5nxVjh4cTYK+IMIoXPsfhXm+DW/oTfwINlfrJz0Px0BPyo4aG+sNuSyRakxPgizzg8thhF9iPzVaqQE5iqpqI+B8eBdMVhwWblOZhI4niDk=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;20:ryBJpDb1QXgPbVaY6+q/JsoV6C+sEd9pOVQQ2LBd7Af/OxO+Gr1hxN3ZNJMXnbgjMItD+6+s7fbzOGULh+BpFV5Vk43O6ABnT379oNmt/sFxGqUvWs78wcVe9P/Ea/KlqGbXIgXbiF7pVk3fR07TZJzCQHWAJdkm5EMdfvX9IrkhRQZWqT/GRD2cmWqVMyk3eTTQ2HeWDfkVHnocOR2LY98Q3JLnBC32lyh+EcVeJbWBvpKIcJfAhzWcFSwvv9QrfUeItxMchRNaFYoTKYMA/8FXNAFv68JGKcWSqJSFv53qS/5I788AmOGedR3Y7YhRRDKUtTRnPk6NfxcWS7DtDRdHg7KqLGxBU0ebn05cEXjJdEew2d+KuipX1wiH7lbD1fIz9mU2IFpNqKq50N+locAIH64v+CEmTOpxaNZdEAaZr4JzpjD7N4vAxgV5PM/GjiX52kgIdfNlGKrC7+qEOQgwFTVXHhpVEDSy/HWmR+K/qUYJbl8TVNpfxdV9HzQC;4:JPE4HfQmD5vJj/wS4gGlXAwO2OrvWpcWapLZ5quqRl+q29na0dENvThR35N0wr97jD6n1oRmKC/Ly9SPi7PXYGiAyEDWKHMTGKkxJRtjEzm1s7qZ7czq8Ii4PAI9EJXcfH4ir9yMFGcyF3OzhPcNdA3BEJJ6n49kqiUWpqVq52WM7RYR12fvlymopb5nDF48ftLXHhJZnD1Ys6OT9dQUn9ISdGOOWoUzq8+OHk4JBt71VwPBIZBRbzmBFywzGRuoTUmKFQwlobndk/QztmeUSlX5c1J9wXI36cKP2kgh/JKZYy7coL1FFKZCppkf/RSn
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2477C64DCC37E85180E607838CF90@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR1201MB2477;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2477;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(199004)(189003)(11905935001)(377424004)(58126008)(68736007)(47776003)(86362001)(54906003)(316002)(52116002)(186003)(229853002)(230700001)(83506002)(106356001)(31696002)(25786009)(26005)(16576012)(105586002)(97736004)(77096007)(66066001)(36756003)(2486003)(52146003)(386003)(23676004)(53546011)(65956001)(76176011)(478600001)(16526019)(65806001)(64126003)(4326008)(6306002)(8936002)(6116002)(3846002)(6916009)(72206003)(50466002)(5660300001)(65826007)(53936002)(8676002)(6666003)(81156014)(81166006)(2950100002)(966005)(2906002)(31686004)(7736002)(90366009)(305945005)(6486002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2477;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjI0Nzc7MjM6SURNUjkxZ0pKWTFhenBFeXVRS0NSVXU5?=
 =?utf-8?B?ZkFOOGZWeW1BMERDZVBWVk91WkNjaTAxOU9SeUxWWEcwZ1lnUHYybzJYS0ZH?=
 =?utf-8?B?bmNxZnU4bjloM0xuTE95V0xkbWxqcFdzUjdkNU5hVkFTclVnZlY4a2lLc0RZ?=
 =?utf-8?B?eFQyQzR1eDdpRHR0bTBNNStKSlh4akJrK1RrVWlyQkFEc2JPMlVGQ1o4Q3k5?=
 =?utf-8?B?VmluQ2o0elFIb1J1c0krNUxmRC83OXBLOVpxL09pWGdoM0UvejRHMVJGTmNL?=
 =?utf-8?B?RFJCRU1ML2VzZGRrYnF1S0ZUR2NrK1J2b1kyeUF1cktRVmM0YjNQLzVXVjlC?=
 =?utf-8?B?aHNCWXEzWmN6cHMraXhxZXh0aTdGaVRyTTdCZkM2L0FTSyswWVFNVlh3a2F5?=
 =?utf-8?B?aHJ4WFlQSCsrbmdUTkp3Ym1WU21nZWo0QzFmUnhTTVdwellFYUJOQXpVSTB4?=
 =?utf-8?B?SnloRTdkeG1IbUZzRXYyZnVnMXgwOFo2ZzZrcVlwbzNiK2ZLUDRzY2NlZ0tV?=
 =?utf-8?B?WWlWd2pvZlNNM1dtclMrNU1CWStKUnpmdDNlQTZ1dENMeFYwNDByQ1hjRDl0?=
 =?utf-8?B?aVhjTTExMHpWRjEzYnRMdlhWcTBhTmp5NElOMHBUNHhTblQxdEdaU2UrbXpy?=
 =?utf-8?B?ODQxSnk3T29IcDBMSTBGeEZJOWZqVVV2Q2RGTGF0bzRLLzlZQ2xBRzBVQXJt?=
 =?utf-8?B?dFJ5Zi9yS052ZGVGbmE1WGF6WFN3L1dLc3FuMnI0TjhndDIrSWRlemRVMEgy?=
 =?utf-8?B?bE9RL3E2YVgyc0FzdzFPRlM0V3ljOFBzbUJNdUtEajFUTlVxTjgxOG9DODU5?=
 =?utf-8?B?SzlndHhkWjFVVXdaTE5rbHA5Uk1KNUtTVW9CTnJXTUNOZkNHVlhDRWU1T0Rj?=
 =?utf-8?B?MmcxVEtJK2RpcUF0dHJIbGRBYldRYzQ1YVY4cElwakR4VFFESnJnUzVLcDJQ?=
 =?utf-8?B?QkY3eU1lUGtFVWVRWmpyUzJLblVXRGNLTWs2OC9Dbzh5WHQ3bzNNYTVGVGkx?=
 =?utf-8?B?NXY3MjRjMExUa2NCc3F3YS94WEFkNzBVY01VWUE2NXZiTWNWMERXUzh4ZUFQ?=
 =?utf-8?B?cmlwUU8zbFoxRVptek5YbGJPNlZzcmpjVmNKZmxRR3FWTXIralF1OWtZcGdI?=
 =?utf-8?B?SEpiODEvT1Y1bEV0MWFYeExaTkgvY0N5bEZ0VDVtKzFzUG1kTlA1QnJFdUdZ?=
 =?utf-8?B?Yy9SNlB1Ykx4MXlBdk5HUjhaeUVFK2JiSmFFZHQxbWM5NmZKcTdFeFJXSWpq?=
 =?utf-8?B?ZFlBMU5PSWFnaVFhT1BKY3hkTm5JMmdObEl5Q3diQkZGL25HM3pHSEp6aTEx?=
 =?utf-8?B?YlIzQUZ3VUl1V2UrZmZqSUxiSStnSWZ1ZGNoVThOOXdDZlEvL1padG44R0VM?=
 =?utf-8?B?QUd2SVd0Q2hPMzk3UXRJK1pnTkIyMkIzbFcyejh2cmhmKzNKYlVCNEIweVEx?=
 =?utf-8?B?cmlmdFM1MmdablZxTlA1ZExVQS91OGs4MGdtczdnVVJ4a0YrcWU0a0tYdFZw?=
 =?utf-8?B?RGJCUjcvVmpmMWh3Sk85VWlQdSttU0Q2clh2ZHZJaUtqMnVVOWQzbDVDWU9Q?=
 =?utf-8?B?ZG9LYk1uOUgrcDIrSUZFU2lIRTk4S2s4THljU1dha1ZQanV1bXE0dGh2K0NI?=
 =?utf-8?B?MzQyOHlZazIvUXJURFVNVEFiZzEzbk1QSi9QWnp5TW5PWlZXbnV0a1B5QW5L?=
 =?utf-8?B?OHJKR1M2QU51MHBGNUxoSEN5UnJ3Qy9lNEVzdzIyZW92a0JEbEIrQ1pPSUtV?=
 =?utf-8?B?NVNjOFE4d3A1bFNkaVorWmN0L3ZPNEI4RUpYKzc1a09jeXY1NUlrMy9JdmJv?=
 =?utf-8?B?UUswR3BnZ3p4MHFjUWlRVVRuaG85Z21GM281bjAzYnl5QTBrdHJNZUhxb3JF?=
 =?utf-8?B?WkNzQUgrM1JFc1VVbVRjUkhwRkgvc1NiS2l6ZS9oV3I3ZitzZjN6QUM4M3F0?=
 =?utf-8?B?dnRIT0UyeWRnYnFpNkZlaFRKM1g5U2xlUlZlNGl4SWpsdW00L01XV0NYTVVk?=
 =?utf-8?B?bDRwSmczR01COUFKdlcxZEMzWG9Bc0hxdURtTlZVN25XdzM4L1kzcG83ZHVp?=
 =?utf-8?Q?nE4gIA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;6:+oQ5qQAA46w6wvLs+K7upQhQbsIq8AfQXUID67zPB4zAz7uBtJNRXOIO+n6BJef7S54cOJwo4p/WPI8uitdKwJjw/4H0wRjkxiHBsCxsOUmYYhHJg6Bg/HZqzIZ1+sDEgw2R7Ubx16dqm7yUQx+OOLM+ysOw9CnvzY+4MPk1xb/OMy0o+0arsFkSO2SVUujfbTOZ++RZSfEm2BRQrVhhR4QcWEjdDYtB5eB/N6Ok9L7LPumqmbDm3WOkD/GTaPQXCx76PMPOxGjrP7tnUm/5Zc24WARHUA5H++dcapODHzia81e4TLZzbPo8z5MVhQoYWo0oe68ap3f67EKiLtnmP7V3jQRXzRA5NjO2FGFM8kU=;5:say6vJBxjWD3AQfwy3sqpLgprmlp66VN/pq8e6L7xw4YNB5Yw+/PmO3cHna1QsW1E7J1V+hXrU0tWUNS4mrLjMcP0cez1b9RzzdK4B5uJ5nCgn8BtMhWDGtDITkNK0x3w0KRfhXt3V1sxyA25Sugayfo8ThO7IRJEvXBXOa4XQE=;24:LX9dKxmi6Y9SDTQhwd7tz1BAvf5gbN3A8lQ5XoXdrtjPnHgCkiScvzywnX/ws9OOa/EeCwkKNHnJm7LOgyNz9vmu4szwI6tiBDnZA0zEkAY=;7:+1oINAnyW+kL869Ip7UIjeuTOHE4VyOuOzTkSgbhM9i/+TkxXES/ssZJgjRpb8qtZumdaBXi2TVsQrOkOhphEvibvlh1dAoZDutuW1omUWM1P7HC/DJS5QB6PZvAvfa1qlOZ/WArI949EybXN6ZtHMmtLJ95AD+nK1p0KD+uRCSMLwN7WzU44xpDwwCx0oUuVPTW7E7Nb4m9fasM/uF8J19eQxwFLeVNdBbkZxCc9GZPvgo07262J60AhiqqVx1W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2477;20:6i/jfSNBdORSV3MrgOPoySfe+zK/Eef3ops/TvaqtSnJeuCgiaMJ5mXtzrs/EMX4pPiGBl9peDqfEefiHQEGD7r0svkVuLAdtDqpuWeVQ5/MjQeuw6QRFBUsioGryCTDSDxN5PX1vMrNBspCc0gmj0ixlzKqjytCkOR5/TOJjRL0ozjcdiehqSHlMBoRBIutj5fqccJpHIEKPGCrSXELEAPBQ3FaGyvyvg83SV1SIXtx5X5wxFkbz5jpK1kCbXZM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 16:08:09.0655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a1d090-cfbc-469c-afe0-08d56a5727a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-02 11:02 AM, Arnd Bergmann wrote:
> On Fri, Feb 2, 2018 at 4:39 PM, Harry Wentland <harry.wentland@amd.com> wrote:
>> On 2018-02-02 07:31 AM, Arnd Bergmann wrote:
>>> Building the amd display driver with link-time optimizations revealed a bug
>>
>> Curious how I'd go about building with link-time optimizations.
> 
> I got the idea from last week's LWN article on the topic, see
> https://lwn.net/Articles/744507/. I needed the latest gcc version to
> avoid some compiler bugs, and a few dozen kernel patches on top
> to get a clean build in random configurations (posted them all today).
> 
> Most normal configurations probably work out of the box, but I have
> not actually tried running any ;-)
> 

Thanks. Learn something new every day. I like this bit from the article:

> So it is basically just like if it concatenated all source files into a single one and made everything static.

Probably not a bad idea to think that way when doing kernel development. :)

Harry

>        Arnd
> 
