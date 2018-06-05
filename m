Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeFEN7y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:59:54 -0400
Received: from mail-he1eur01on0109.outbound.protection.outlook.com ([104.47.0.109]:54213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751532AbeFEN7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:59:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: KASAN vs ZONE_DEVICE (was: Re: [PATCH v2 2/7] dax: change
 bdev_dax_supported()...)
To: Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
References: <CAPcyv4hJOzRBR0hg=xBZkd_oLtQRZeTXShYChdu8VA+GgTqUvg@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <71c55f5c-deed-b307-9022-8a41dd898822@virtuozzo.com>
Date: Tue, 5 Jun 2018 17:01:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hJOzRBR0hg=xBZkd_oLtQRZeTXShYChdu8VA+GgTqUvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::11) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:ke1PaRVtjrYP0X3igFzGEUXoFQJXTB07ZBK77Ibi4WPvzpKi5mylayME3wFZlJn/6RpUTHrPI5b4ZQEilTRthLX1qJxNLrfui7w4ua+25H2AQ4wWSbB6qcQl4r3w2V95+ZxbBvJ6i4IA8xbY93LeC9RDhm6vUehS4HLZi1yJyS/HQ2Lf8sJtT6DR9xQSwsFVhHi+7cQf3hR63b5PpFjdwkRea2pDko4m5JW8tJltemoPQC9xcz4y1UNpfyuw7qFQ;25:BGENZdqn+Vnsno2Nk6hI6XxfzerpURpuEeH8pfZR+K0cXP51RHuKZOZRYiKjKWdw3QrBoQqV8gCcZYYT3+QnO8DyF9vANJbEWySpOQYQuHV5QnzDH3fv9nm8AnCH3WwE98oKlx2Dve7PBvElXq34D6rsgmg6j6PX0BxWSW+guUAiNyEacYsbcoK7nWkvPBTccz3R+94s+mP37H1U820PdufIuvba9kt5ijLBlXf4PiDkBVu1ebdMvcm+gArVp7RQA3hFXXzlnGOFa1gmxy0hDxKm0hQdCNDzCtb1VIPlZUqJrjiPueshHJWacZGKrr3shmobAGnmJrqZbhj8GPVXKQ==;31:Y0+eBf6pz+4yDtUXNS12d1zEx7YQs8wALnIPejAB1UPy4L2/GAtFqUTvd2BPJDuFIH4oF349gkcCgehlfbRsLWCCexay83sMA5L4e9nAX3eWaQleJ5b4TlEhTGepd9yhQIjOpabTsOmMWpxib0/sPraUPMQFyySCJ0/DzWAc1e3+bpyQZcEZBepVb1GiHaFXwP7b1wh7oMcXvdj+8LbnLwcL+lA4V8HsA4FHqyYfWx4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:KbPsLoDbbCbfJWzYU6iZ4VTTppIyS8/8DPhxHMJQN/fwv9fJ3xHZmK6NTT6txUbylaI0JjJi3hkv6vw9IJEkRaJ7zfZF0Y3TfVGhzkwbEgH2HszCe1icCmwWkdWKwoSBIt3vL6GUTGlVuXSri2ohXZxljDcWA2OzoQtAt5dvEogEJ8HUZw1e6Ns3hT9fI4SlZ2i+rpJBgJBGPphTgINuNNEwsBPcnpGu5kLVmRkQpmxaGbvmZKcOl5Gkq1g4d7f9gfaLlt6iYh7HLHM9XGkgg1lpGTdo53BsPbzF0ksM77ga4NOCwLjkRbgpDZnOBtgRL8WUJboPThzOB12FXI3/mXV/jFTKNiVP4+C69X17/5Jv7PaW0v6TYhS1DXudoXmDcJUnWYkhmqebyOEkSmhauD8Bi8XnZEgWYvtu8Bxz9SKYl8at2EHVr/+Sl4iiRtYNFWWZ5VlPjtxEmC5BJOWMb3aF3ByO7nwHPupCypVXYSJmk1d6/aOiZ5A/a8eQtWlZ;4:L4P3akkF6afH83OOiLnUt5RtuJtugbcJOgVBBZha0RW9xG3c4zT3hu5tzlOy+ZSUalUL7/kXvsNCOCN85qzVT3oppGINbYemGJ5rCwe3ifjjRv5ItfhmPdciiupDTc5DT0COXUt0yI0WmACMx3TZkz4p5s0f+C8NEvYCcTHuPZxx/JwWfcztUYfqehF6v62rhtu+Vmkal4nvD0gqSQsi9I8yxoYYfZSsEZd8ciClSPgl+VgB8IIQo4Rn0TtVa2wilZp0uSm4trnyFRqxo6aN1W5Tg//kc+vKI49h/8oPB7QKuXxOCtVXVd8+O4IjqoeM
X-Microsoft-Antispam-PRVS: <AM6PR08MB3254AB3D4647B1EDA2AE8C86B0660@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39840400004)(396003)(366004)(346002)(376002)(189003)(199004)(54906003)(956004)(11346002)(476003)(25786009)(2616005)(486006)(8676002)(58126008)(110136005)(81156014)(7736002)(305945005)(64126003)(50466002)(316002)(36756003)(16576012)(8936002)(53936002)(81166006)(4326008)(6246003)(31686004)(6666003)(446003)(105586002)(106356001)(2906002)(97736004)(5660300001)(65826007)(5890100001)(7416002)(229853002)(66066001)(47776003)(65806001)(65956001)(6486002)(3846002)(6116002)(478600001)(230700001)(52116002)(77096007)(16526019)(26005)(86362001)(386003)(2486003)(186003)(52146003)(23676004)(68736007)(55236004)(76176011)(53546011)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOkszY3h2S3M5RmpWNllXZjk3VEM5cDBrZVR0?=
 =?utf-8?B?TXgxN3FhSkRDUlh5R0dnR2s0djk5N20vcjJHd21xTUNQbmlxTWcyWUZUQnJx?=
 =?utf-8?B?d05MYXcybFNRV1dMYmlHdjdtaXNhZDVPbUN4VEIzR3E5am9GTklPQ3I4cEZM?=
 =?utf-8?B?SnhiUjJScVNRVGlZd2FTcElyWE9kV2k0UVpQSi9HT3k0U2IyM2dwSmVRU0ZM?=
 =?utf-8?B?bkhvYUd5cmVPWHc3OTIyZ0sxY25PdnFkcnBGUEpUQ25mVVVBMEcxd2lzMTNu?=
 =?utf-8?B?eHRNUUlwVmZnbktPTmVOclV1UjZBOE91aFJwZEZEVFZ6bndRaDErQTdzUW56?=
 =?utf-8?B?UUxPNGIxR0ZRajA1V25CeG5NQTRmUm9OMzEyNkJmWTA1RmZUU0JzMlV3VHBk?=
 =?utf-8?B?T2JPdDJKRzdsMGpVZCtMZWNYNmorQS8zb1NxcjlvZm0xNzYyNjljQ3JIM2lU?=
 =?utf-8?B?UDVMeUVVeno3U0h2a3B4UHBGcHpTY05DZVFkN2ZpRi9SZ0ZITnd3dzdreVB1?=
 =?utf-8?B?Ri9LWkx3QUlDWlBnOTBFMHZLKzh6TXZua0JzdUhYQ3p0ZkNKZE9HTWw2aXRx?=
 =?utf-8?B?aHdyTUNGYUk0NG56S0gzUFIxb1lSaGNoZXpoeEhyS1cvbFdFdzFyQmR6TStR?=
 =?utf-8?B?ajRvV0tuM2hZVWR6WHJHUml0QjJoODBhbFAyeXBJR1ZMSjFRanJKVmxmeU5O?=
 =?utf-8?B?ZDhtb2RHSUkxSVZFclVMeFRRYzkxZ0ZwQ0NGYlBVWGFpaTFDR3ZwT0RWYzFu?=
 =?utf-8?B?bjI2Um54Nk55dUw2U0I0NnJtNkI3b2gxNjJobUtlMUgxbll1R29wYXAvMENH?=
 =?utf-8?B?bXhkUkZvOWhxOFlNL25zRUhudUVPbmE0V1U2WEh6bzRQdzZMM2ZCMTRWSTNU?=
 =?utf-8?B?UkppVG5TL2RuTGlZeHc4Tk1YbUdERXlBaEJTWEg1b1hEdTVIcVVIUHpxRzRj?=
 =?utf-8?B?bGhlakNPbkFZY2tkUjBUWkJudzh1VDZRbEJtWDdtamZ4b1M3T2YyUHhjODZ5?=
 =?utf-8?B?MlF2VE44QWJISHZvU2k3Y3FRbkVrOFp5N3pkL3gxcTdQU1J3QXJUS200Uk5X?=
 =?utf-8?B?N0ZtUDByNUNmVVJVelJsYmFlRytRSnEwTGlteUwvSkIvWnpxWDNyYzdHODdk?=
 =?utf-8?B?UGdXaDY4Nk94cyt4SVlrS1pMTk9IaU8wRk1ub1pNVlpVcjFyN0tEOWdSSG5H?=
 =?utf-8?B?LzhKdWJ4L0RZUzE0WUZLWUR6U0NFSFBLK0E5N2FMNVNKVVpYRTlmNzZDcDE2?=
 =?utf-8?B?UXRTQjJxWVdpbVcyTFFBTllxWXFtNk9pVWRXd08wRk1ySTdNS3BmMnplVjVk?=
 =?utf-8?B?LzJqK1JmeGRFWWV2aTB3QUM0ZHdDRGFxUStNZkd2bVR4Y0kyRDhKZkxUc0hh?=
 =?utf-8?B?ZldqN1lhSTdTeHZWL2J2QzMxVzZxT2pCMFcrWGtLY1N1T1JUK0pmd1loRmtP?=
 =?utf-8?B?bzBMWlVEYWI0aUxWTTZzcGFnVnBVVkJHSTUzMk5DWllSNVpRb1RmZjArejho?=
 =?utf-8?B?anZQeXZKa1QraERxb0FPa2hWWlBLQXR2b1M3UjM3L3huVXhaZnRqU29qazAr?=
 =?utf-8?B?ZXVKczZGK2N0SldFSWlQNDdPUWVZd0xNZytoMmZ3NVdpR3B0TS9WZTNmd0VR?=
 =?utf-8?B?cFZnQ2ZZWG84eWswVE9ncmMrTHdLTmJKbHZzTkM2T29NOVNRaUhPQUFlaDlo?=
 =?utf-8?B?Q1JBelk0UmVZUXlNSU1nb1NkN2k2Vnh6UEdjRnpnL3o2RGQrTGhTbERrWUQy?=
 =?utf-8?B?N3VBenlTYm94QVhMelcyYUhXS3RtT1hPR1hmK2VJVkRrdGIrVStnKzdQbWln?=
 =?utf-8?B?aUdMcE1Vam9SOWUyejJnT29RYUNyU3RjVlduaVhKQ0dUb1VIeGlod3YzSGJa?=
 =?utf-8?B?OUpWbGhiR3dyMlNqeENJU1I2WFNiVE0vZFl0Q1p1MXlwY3hMYTVUZkxET1F3?=
 =?utf-8?B?M3FpK3lyclpZUlpERjJORUZlMlNaUHZreFNidlVzTjViTm5xR2Q5ZWF3Sk91?=
 =?utf-8?B?MHE1MWxPdkg3Y0tJUlUvYUE2dVl6S0tObUxyeFkzcmsrWUlWbTJCQ1Yrd0hj?=
 =?utf-8?Q?rUzk=3D?=
X-Microsoft-Antispam-Message-Info: kDe3pYt0I2Sf/70iqlFp51rDGvV/e1ugCezg0LMmx452zZTyd2D/QyAwmKiGZMyw+Owr93PwMSJTmntSp+x+quYpy/9mSe2kQz/JulXzpqiA33d4eZsTwMuyrGX3pdskhm1J15neCYBlzoExwotAwzDPVvmOpTQlVenvFXzBWaHbSYBS7RPYKF1nqGINWJi+
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:P30m12EAaIvD2JC4SOXyHOT3vLvo3SUm3/JVesXHD4e78QWLe+PytT3nvai+D/aLSb7RkQ07Hb1CpIv92yh7pfb5FUTsRSx6tbv2ye0mw5MwSawUCjeXwBlOCpIGiBmhXF60xYPu2vx2RS4+cL0vf5IJiptxCp+clXT4eOPni4IjCtWT6ujXW77yvOgZ8+8RTHZogduTJzYM7eQZBWKOMDSl8bJiSKo500JI99yi710l1J9br2fqLzdG9qfNPt47a0njfDvh0eRZAkQVCyWIAtfW7qNxg+5xqIsQcRiM8O5ntQrl4tguAGl9d9/FGRUm0fI72gjSD2UR/2O3QmDZdFPWCH/pxOXxKuvKVwZTrAD2hi2BdsyCf88nN0oVJNL5wjTAADSMAbv6S9NcTnnGpHeHe7d/Ve2Vdl2DSZmgJKG7g/1MkFgwgFTur49knC9SzPiyl4x8YzfZhhSlCkAmPg==;5:o/wqxMvyqZJLgMkOlheqrhilnKB6cOJkjx1HmE/BSlIZo+rqP02mxbX/QCYs8zAFhZ0fXnBKBgWKhDW4ZIDFtGTt8ZoFzCVIdWTqoyYrg38PnkWVXUfzQhpYRLmOBr963FHguu77MX8X37CCJBjjkivl/Hb8t1r62/wxrG+xH9Q=;24:iHMKaglfsMQ5WtnvIHWFKQQ48jN5sOqKyqe/RSx4BLz4TeJkyR3F2oQWlqdCBcA1hVTgn2a3SYIXH9A5J+4QJ/4JQ9w3JxwJ7bnTx1eRRSo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;7:hitAh4hjFTxXs48VY1IQIgRaI11SDXkUw4AGSj0COTZR/DQEflSploJRpdhjdIsePyR0ZJncPx5PUpnU/Y4xYcHRY57ea6kQQaeuqBis1SB0h2pjghRIEPkpYzVdrBOZg4vmzFYAr6hufVZrRE7O5xeouaVNQvKMXwt0MHzsCIRh87O6DvRMjU+zO58R9eoZ0wto70sk6pgCNwS3vBjJ0tzL6DNYR8jNCngp5286tQr6xIsk57W53w0PeB1NES3W;20:dOXGIp8oTcUOX5y3feCj/JJ12vvl3PVHhIcKXYi7QJ3Hx/DaUhjQ4voDdxm33oEzqKecCY54Raa6Sdv3YqkBhPTJuBPDdwU0xWIlkT36QhunFAF7P8FPkhMYyWbtUyaflzmqe+X69Aqgrog3NW5KU8939JTggT6mrpIPrxcb5vo=
X-MS-Office365-Filtering-Correlation-Id: 3034514f-a0b8-4b76-3fee-08d5caec9929
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 13:59:46.4456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3034514f-a0b8-4b76-3fee-08d5caec9929
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/05/2018 07:22 AM, Dan Williams wrote:
> On Mon, Jun 4, 2018 at 8:32 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> [ adding KASAN devs...]
>>
>> On Mon, Jun 4, 2018 at 4:40 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>> On Sun, Jun 3, 2018 at 6:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>>> On Sun, Jun 3, 2018 at 5:25 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>>> On Mon, Jun 04, 2018 at 08:20:38AM +1000, Dave Chinner wrote:
>>>>>> On Thu, May 31, 2018 at 09:02:52PM -0700, Dan Williams wrote:
>>>>>>> On Thu, May 31, 2018 at 7:24 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>>>>>> On Thu, May 31, 2018 at 06:57:33PM -0700, Dan Williams wrote:
>>>>>>>>>> FWIW, XFS+DAX used to just work on this setup (I hadn't even
>>>>>>>>>> installed ndctl until this morning!) but after changing the kernel
>>>>>>>>>> it no longer works. That would make it a regression, yes?
>>>>>>
>>>>>> [....]
>>>>>>
>>>>>>>>> I suspect your kernel does not have CONFIG_ZONE_DEVICE enabled which
>>>>>>>>> has the following dependencies:
>>>>>>>>>
>>>>>>>>>         depends on MEMORY_HOTPLUG
>>>>>>>>>         depends on MEMORY_HOTREMOVE
>>>>>>>>>         depends on SPARSEMEM_VMEMMAP
>>>>>>>>
>>>>>>>> Filesystem DAX now has a dependency on memory hotplug?
>>>>>>
>>>>>> [....]
>>>>>>
>>>>>>>> OK, works now I've found the magic config incantantions to turn
>>>>>>>> everything I now need on.
>>>>>>
>>>>>> By enabling these options, my test VM now has a ~30s pause in the
>>>>>> boot very soon after the nvdimm subsystem is initialised.
>>>>>>
>>>>>> [    1.523718] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>>>>>> [    1.550353] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>>>>>> [    1.552175] Non-volatile memory driver v1.3
>>>>>> [    2.332045] tsc: Refined TSC clocksource calibration: 2199.909 MHz
>>>>>> [    2.333280] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb5dcd4620, max_idle_ns: 440795264143 ns
>>>>>> [   37.217453] brd: module loaded
>>>>>> [   37.225423] loop: module loaded
>>>>>> [   37.228441] virtio_blk virtio2: [vda] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
>>>>>> [   37.245418] virtio_blk virtio3: [vdb] 146800640 512-byte logical blocks (75.2 GB/70.0 GiB)
>>>>>> [   37.255794] virtio_blk virtio4: [vdc] 1073741824000 512-byte logical blocks (550 TB/500 TiB)
>>>>>> [   37.265403] nd_pmem namespace1.0: unable to guarantee persistence of writes
>>>>>> [   37.265618] nd_pmem namespace0.0: unable to guarantee persistence of writes
>>>>>>
>>>>>> The system does not appear to be consuming CPU, but it is blocking
>>>>>> NMIs so I can't get a CPU trace. For a VM that I rely on booting in
>>>>>> a few seconds because I reboot it tens of times a day, this is a
>>>>>> problem....
>>>>>
>>>>> And when I turn on KASAN, the kernel fails to boot to a login prompt
>>>>> because:
>>>>
>>>> What's your qemu and kernel command line? I'll take look at this first
>>>> thing tomorrow.
>>>
>>> I was able to reproduce this crash by just turning on KASAN...
>>> investigating. It would still help to have your config for our own
>>> regression testing purposes it makes sense for us to prioritize
>>> "Dave's test config", similar to the priority of not breaking Linus'
>>> laptop.
>>
>> I believe this is a bug in KASAN, or a bug in devm_memremap_pages(),
>> depends on your point of view. At the very least it is a mismatch of
>> assumptions. KASAN learns of hot added memory via the memory hotplug
>> notifier. However, the devm_memremap_pages() implementation is
>> intentionally limited to the "first half" of the memory hotplug
>> procedure. I.e. it does just enough to setup the linear map for
>> pfn_to_page() and initialize the "struct page" memmap, but then stops
>> short of onlining the pages. This is why we are getting a NULL ptr
>> deref and not a KASAN report, because KASAN has no shadow area setup
>> for the linearly mapped pmem range.
>>
>> In terms of solving it we could refactor kasan_mem_notifier() so that
>> devm_memremap_pages() can call it outside of the notifier... I'll give
>> this a shot.
> 
> Well, the attached patch got me slightly further, but only slightly...
> 
> [   14.998394] BUG: KASAN: unknown-crash in pmem_do_bvec+0x19e/0x790 [nd_pmem]
> [   15.000006] Read of size 4096 at addr ffff880200000000 by task
> systemd-udevd/915
> [   15.001991]
> [   15.002590] CPU: 15 PID: 915 Comm: systemd-udevd Tainted: G
>   OE     4.17.0-rc5+ #1
> 982
> [   15.004783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.11.1-0-g0551a
> 4be2c-prebuilt.qemu-project.org 04/01/2014
> [   15.007652] Call Trace:
> [   15.008339]  dump_stack+0x9a/0xeb
> [   15.009344]  print_address_description+0x73/0x280
> [   15.010524]  kasan_report+0x258/0x380
> [   15.011528]  ? pmem_do_bvec+0x19e/0x790 [nd_pmem]
> [   15.012747]  memcpy+0x1f/0x50
> [   15.013659]  pmem_do_bvec+0x19e/0x790 [nd_pmem]
> 
> ...I've exhausted my limited kasan internals knowledge, any ideas what
> it's missing?
> 

Initialization is missing. kasan_mem_notifier() doesn't initialize shadow because
it expects kasan_free_pages()/kasan_alloc_pages() will do that when page allocated/freed.

So adding memset(shadow_start, 0, shadow_size); will make this work.
But we shouldn't use kasan_mem_notifier here, as that would mean wasting a lot of memory only
to store zeroes.

A better solution would be mapping kasan_zero_page in shadow.
The draft patch bellow demonstrates the idea (build tested only).


---
 include/linux/kasan.h | 14 ++++++++++++++
 kernel/memremap.c     | 10 ++++++++++
 mm/kasan/kasan_init.c | 46 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index de784fd11d12..b5f5d2d9e46f 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -71,6 +71,10 @@ struct kasan_cache {
 int kasan_module_alloc(void *addr, size_t size);
 void kasan_free_shadow(const struct vm_struct *vm);
 
+int kasan_add_zero_shadow(unsigned long start, unsigned long size);
+void kasan_remove_zero_shadow(unsigned long start, unsigned long size);
+
+
 size_t ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr) { ksize(ptr); }
 size_t kasan_metadata_size(struct kmem_cache *cache);
@@ -124,6 +128,16 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
 static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
+static inline int kasan_add_zero_shadow(unsigned long start, unsigned long size)
+{
+	return 0;
+}
+static inline int kasan_remove_zero_shadow(unsigned long start,
+					unsigned long size)
+{
+	return 0;
+}
+
 static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 895e6b76b25e..1524dda52667 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/pfn_t.h>
 #include <linux/io.h>
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/memory_hotplug.h>
 #include <linux/swap.h>
@@ -309,6 +310,7 @@ static void devm_memremap_pages_release(void *data)
 	mem_hotplug_begin();
 	arch_remove_memory(align_start, align_size, pgmap->altmap_valid ?
 			&pgmap->altmap : NULL);
+	kasan_remove_zero_shadow((unsigned long)__va(align_start), align_size);
 	mem_hotplug_done();
 
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
@@ -395,6 +397,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_pfn_remap;
 
 	mem_hotplug_begin();
+	error = kasan_add_zero_shadow((unsigned long)__va(align_start), align_size);
+	if (error) {
+		mem_hotplug_done();
+		goto err_kasan;
+	}
+
 	error = arch_add_memory(nid, align_start, align_size, altmap, false);
 	if (!error)
 		move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
@@ -423,6 +431,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	return __va(res->start);
 
  err_add_memory:
+	kasan_remove_zero_shadow((unsigned long)__va(align_start), align_size);
+ err_kasan:
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
  err_pfn_remap:
  err_radix:
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index f436246ccc79..160d35d28e62 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -21,6 +21,8 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#include "kasan.h"
+
 /*
  * This page serves two purposes:
  *   - It used as early shadow memory. The entire shadow region populated
@@ -41,13 +43,16 @@ pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
 pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
 
-static __init void *early_alloc(size_t size, int node)
+static void *kasan_alloc(size_t size, int node)
 {
+	if (slab_is_available())
+		return (void *)get_zeroed_page(GFP_KERNEL | __GFP_NOFAIL);
+
 	return memblock_virt_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
 					BOOTMEM_ALLOC_ACCESSIBLE, node);
 }
 
-static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
+static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
 				unsigned long end)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
@@ -63,7 +68,7 @@ static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
 	}
 }
 
-static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
+static void __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 				unsigned long end)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
@@ -79,13 +84,13 @@ static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
 
 		if (pmd_none(*pmd)) {
 			pmd_populate_kernel(&init_mm, pmd,
-					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+					kasan_alloc(PAGE_SIZE, NUMA_NO_NODE));
 		}
 		zero_pte_populate(pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void __init zero_pud_populate(p4d_t *p4d, unsigned long addr,
+static void __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 				unsigned long end)
 {
 	pud_t *pud = pud_offset(p4d, addr);
@@ -104,13 +109,13 @@ static void __init zero_pud_populate(p4d_t *p4d, unsigned long addr,
 
 		if (pud_none(*pud)) {
 			pud_populate(&init_mm, pud,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+				kasan_alloc(PAGE_SIZE, NUMA_NO_NODE));
 		}
 		zero_pmd_populate(pud, addr, next);
 	} while (pud++, addr = next, addr != end);
 }
 
-static void __init zero_p4d_populate(pgd_t *pgd, unsigned long addr,
+static void __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				unsigned long end)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
@@ -133,7 +138,7 @@ static void __init zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 
 		if (p4d_none(*p4d)) {
 			p4d_populate(&init_mm, p4d,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+				kasan_alloc(PAGE_SIZE, NUMA_NO_NODE));
 		}
 		zero_pud_populate(p4d, addr, next);
 	} while (p4d++, addr = next, addr != end);
@@ -145,7 +150,7 @@ static void __init zero_p4d_populate(pgd_t *pgd, unsigned long addr,
  * @shadow_start - start of the memory range to populate
  * @shadow_end   - end of the memory range to populate
  */
-void __init kasan_populate_zero_shadow(const void *shadow_start,
+void __ref kasan_populate_zero_shadow(const void *shadow_start,
 				const void *shadow_end)
 {
 	unsigned long addr = (unsigned long)shadow_start;
@@ -192,8 +197,29 @@ void __init kasan_populate_zero_shadow(const void *shadow_start,
 
 		if (pgd_none(*pgd)) {
 			pgd_populate(&init_mm, pgd,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+				kasan_alloc(PAGE_SIZE, NUMA_NO_NODE));
 		}
 		zero_p4d_populate(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
+
+int kasan_add_zero_shadow(unsigned long start, unsigned long size)
+{
+	unsigned long shadow_start, shadow_end;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)start);
+	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
+
+	if (WARN_ON(start % (KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)) ||
+	    WARN_ON(size % (KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)))
+		return -EINVAL;
+
+	kasan_populate_zero_shadow((void *)shadow_start,
+				(void *)shadow_end);
+	return 0;
+}
+
+void kasan_remove_zero_shadow(unsigned long start, unsigned long size)
+{
+	/* TODO */
+}
-- 
