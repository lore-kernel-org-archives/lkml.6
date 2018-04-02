Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/j16E0kHFpIOnb5tc5EUZ7YKXOapcNu99wO2odR3cbVuBouOYe43zw9ym6Argl3rO4bXfq
ARC-Seal: i=1; a=rsa-sha256; t=1522659116; cv=none;
        d=google.com; s=arc-20160816;
        b=nJHDivebXCUF+RXvsD960JqApoGDhjUW5nQl2xQtkf9H+zmSG0H/v9NkGxroZ9cnrc
         cMPqFm51w+LY4Yq5DYCZkojBFhKaY2AWrRJCcH4oVtjxSIVrfGSMXRyMlzhfAwGNUWa+
         t8VsWbUynuiOiPI1bL4sO94cxF/i/2g3viLzNh8WvoBoj0Q3w4Zu34/SHCXftg9cGImk
         2T/UdxC6p9ET3nZraW8sRVwA1S9agdADH/WQ0/JQBBQG6Uzxs08g0BAKau5V9Cpejzdm
         rg/ppdc7lzUjeAtmLY/ykCH+rLUCf5AVCGMlThZNhiXYNtRFgJiRkuWVlTg9K9VSmoVa
         EFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=WkTdrIiF+Y04JpLpEKuV6/sQRLw2wCjP8cZgpMrLV8o=;
        b=gJrjYLu8XtSF3OgyUAJY1RZsNDA0XJWk7+S54/ww7bz5g4/IN7t3hNNnGyz6+TU39O
         7C1VnlBxlzgBxfsBLaa8GaHeC5xpsVEaEjwfmtO5MfXGn7aNfzDRjdrnZVmoOdrq90ut
         mn5/L7BB/oyG6S1cbxAmRe5N/m/o7Npbtnh/VZ+vNFU8BvDMV7PMo+Ftvk0aQAV0n6MF
         BRrFKkAtnGz5EchZ5T+C8iOuOO1xTcN4L4GchV0VZXEfB55BxiLPi9v2q5A37Nm62FWV
         ANJj9TcVYysR1DHhDZLH15jwqRog8oO2qmA6scJWQj7MCbjWslXxJmORT2+oZsHjL5DK
         0XVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VxSRxCiU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.126 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VxSRxCiU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.126 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [lkp-robot] [list_lru] 42658d54ce: BUG:unable_to_handle_kernel
To: kernel test robot <xiaolong.ye@intel.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, akpm@linux-foundation.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lkp@01.org
References: <20180402031739.GC3101@yexl-desktop>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <235cb8c6-1f19-0573-4dc5-1da9d9063200@virtuozzo.com>
Date: Mon, 2 Apr 2018 11:51:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402031739.GC3101@yexl-desktop>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::14) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5398ddd-f66f-4917-ab11-08d59876fb9d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:oRhNDV5EtUflbpu5ad0xPqRglMguSVQqsGdtdRmyThOetbfg/d2IUgituJYffOv3I/5zUSd07WY8niFgq6nPQKdcNCwiO9dKsUyqps3SfwYC+ncRPAUqunN3xaz0dnN+ub9aHDn6ngv7M+Im2fnEX5d3z80d0OsQfYsRgROPH3IGgBm6PqTy8IVoW7tkr0LU+ww30gSwrNRc+Bg1Rob19evduhjeO6lhkDTOsTFpk81ShfaD3LxcFEGgWK7AP0HF;25:gr49h5altkSywPF/jyZcGVt3rQlJRqu+LZjWhu5aGy1PN/+v/TwXfIBKldbG5nQaOa2KEwrc/99sAG/eGfBNuAcKl3kEvo//OHhrWggJXJSS2dA9b2SUITU+XREwjmNPrfLLqyJZxakeK9N0WA2P3R+zxer1cqRB7IKrRmdQDghWuMTn+QTxvAacvCZ7VUawNj1YKRg+/hpUxoaJcNm3BLE+fsCjatTbdskAEbS+SQXvkbcpUBWcGnyG4e5s0lxlAMfwARLVb+Sbma9Nh/6pytHApXzvpd2naAzsmnJWvqTST4XiaJB8cqiUuiEZCr0g3u9LsOaI7mgdsJZ0XOBSUA==;31:jK7Qcr+VI6sKtXeFmRBLNqYI+d7HnFOt6xA8S1T8XB2jcsltFNB4xaeEVpc/YQz0M139F6SLIwtZlSiSCKbxgQNKe04fKvhC47pTQoQnjkWMebtIWyVgWcnNVMAVRd58ZMqsrvjke5sunklz6/GJ+WzXHRiwnOkReixhrpmvJIZyyLYmChj+C/pu+i6sMt6UBxEbuyBF6VhE/JJagr2jCEBdf3qcG0sgRDOc00CPGEc=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:pPScP7wE0jVJLqTF0dTrIhAd5BHcHWPU1zPUxO+Ltxy/f2e4eP5bX4Ex1CULJRjm/T03Se8UpSLMmfOfR9iahg/DV2xSlK/ucvWWdpBABWUpNrqU7by2Q4uV2FLdxJ+EjBT2kPx5PElva8+tb7r+XVuWRrJIufqhET6bcGK0zutn7v+8d3cYlmvY01tOGIypiIphknQap33eEWqxBtHotfEbzKwOwZGPD5xqdaisMKdYbBjLTLQYLPA6o0O1hQ2+BARvX+x1VSSwWbjfXD48I3XtA2OV2LnDn2sb4I2QcZb0tkXTefj2eJsmFpc1Rh5yp6Mmwj9SbOC4XN17MatijzitZ48c5+LUy9BTqj0tYrKbARbA49djKpHpqvZiBbEq8HOYds3/JbJGffdLgx3CSpvWdzajd/z8Uc0McF1O2v1LS59Jcup7nm3OazWyxuwipaAnZUx7KZaNY0+nNo5znCg4rqkI70vv+lN6OeyTbGN4U4rXYYWC7vcPQjFS3cMC;4:nxlKiFcOPeJdxFwQ94sogwVBNEkGlHyX3HfOk6dowuiI81S3vu9yI39VKz6nlSZqMj3dsrvpCDEjWaa+V44K9xVrAVo5LrZFqq6ykzBTLP5V9ZN21biCOT4GPFJYzipx3KDPt7IwA5E7yL7EFHrlLdZxtJMfY8sh5ZhG3Zqlv8jRB0/GWGtAOEt4hvdx134E+3kv8KUPnIPnW2F1atliBLgz7QDU+8IkKZH+C2LJyR9Nj8ash+KrzVhwHJerb5IillO18KntovEI2mVoYtwqt9spR3oCU1EcDguhl0EQVm3kTZEcstiM9r0bbD9P79wiGk27SfsgUXCd9Ekcg/y5LrzbbYQ3C1mRAAIcii12pyI=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343709B80C5A268E782140BCDA60@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(39380400002)(39830400003)(366004)(69234005)(189003)(199004)(36756003)(11346002)(446003)(956004)(6486002)(486005)(476003)(486005)(6916009)(2616005)(5890100001)(7416002)(53936002)(478600001)(6306002)(106356001)(105586002)(966005)(4326008)(64126003)(6246003)(6666003)(50466002)(39060400002)(25786009)(81156014)(52116002)(86362001)(7736002)(2906002)(66066001)(16576012)(53546011)(23746002)(5660300001)(65956001)(65806001)(316002)(77096007)(31686004)(47776003)(229853002)(186003)(55236004)(58126008)(8936002)(8676002)(81166006)(68736007)(305945005)(31696002)(76176011)(16526019)(65826007)(97736004)(6116002)(3846002)(575784001)(230700001)(26005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR0801MB1343;23:uJ0EKIAafP2Swb4dbWWA8r4pZujQBy9vfx4?=
 =?Windows-1252?Q?Iqau1F4M04LllN3tAm/Rs7QU7+VTclKyuidnIvTc/NKUt7JH9k+lh5mn?=
 =?Windows-1252?Q?FL1msa5kICwDJnPjXbH42cypiNWvMbrvPvg8aBWOPUva6zEojostbja9?=
 =?Windows-1252?Q?1oiNB8Sf5pQeL5JXSzLb6zoLwJIz+AJe7hiEcgqKAXfD8xK3RlkWg16N?=
 =?Windows-1252?Q?+HMxH3Dy/lGcTMT5k4vnqYzfGyy8+H8YqsVAbmF+kFzd/6R7+TW0m6LO?=
 =?Windows-1252?Q?Zj/cjGVuZFECVaq4hMyuE22+EXEDYLOf+bDDsF/pDBNAz6F5Z6+MQhmX?=
 =?Windows-1252?Q?LY5/58D4wh2s7JRplG0HM5jy6UT9yWp0IUcdOG+yiuukhlY3L+9SD+ed?=
 =?Windows-1252?Q?WoXk4FUSvGPddULB+jhKTyC2+h0OLnQuCDOjeyGbHtfez1jUxFUIrOPF?=
 =?Windows-1252?Q?xVtDHBiHK5V1qTjNiIgrd9K0Otih+XTGSOxaBo/gNMJGfK4XNPJsT68G?=
 =?Windows-1252?Q?DSGY63XNBJBrmENHpYIgUEfBn/u5DgqvRRMYsqt7jOjLZQhY76qmLXsm?=
 =?Windows-1252?Q?SrveHUle6kCbYwsVvY0J2LGihGdGRt8/tCTByd3i2mrme1kGy4N69C3j?=
 =?Windows-1252?Q?+kmI+hgAjtAtvtEAZafu9Q4hy8t78HDO6h6VBgMGNPbfqGZ6mrqy7+aJ?=
 =?Windows-1252?Q?0773szjMhgULpUIRqlBZDNwPZEP18cVltbhLLHT4ZX8csRnNgkK2Tp/n?=
 =?Windows-1252?Q?6sSMSyNbecDKIHVFMdF8tmVwWyINa8SB/NVxkyKnE5aswAIshs48Rjht?=
 =?Windows-1252?Q?ov2iQT4/x1TNDaskhL834rWzs6AnlsvIRpMJOHksLWOHplZ1V3S5lpmT?=
 =?Windows-1252?Q?9Dz9e2umy5aw36DgHzQNJmMHatX9kszG+7QF3+rV5AzmONQGDx1b/MwG?=
 =?Windows-1252?Q?esILzedDA0AWsEtN56Ff7mEvscZB8hgRsS4cDLZDaNp3dKU5DnxM1WJh?=
 =?Windows-1252?Q?BvFKMH7Qag1Tj98SLYq4xOtYIEPleOCcjJQoZFvL6Har/X7/z091oWGJ?=
 =?Windows-1252?Q?Y34Bvq5iT3YVZoNU3Zoc17DNnIbTZrx0ON7fc4MkQqvfh/6IAvzZy3Dp?=
 =?Windows-1252?Q?IzZ2RxtzuzALVTc7uIKV8gnx1I5KcJgLvcVT/YVm5MLtG6P5lzGax1Cn?=
 =?Windows-1252?Q?zRxhKuT8GXk5s/vIyxvGXNZ3nzkg5LTsbEhy38b/zUDDIxH+/edxxhiQ?=
 =?Windows-1252?Q?hlL2/oIFarNpA86WM+wWb/Ibf+Z1un3tidjdmC9BcZUixvf+O1TCjbG2?=
 =?Windows-1252?Q?P81Cdw5+05PRuEJ59zVhLLy4s9l6K3TesAHrpmixfDLMMFyGuxxc+tid?=
 =?Windows-1252?Q?7ihtzWC7CrQBrFJ66HRJ0a/9d4LnNx6/do5vSF3x4aePKVj8Q8DlIHfj?=
 =?Windows-1252?Q?XNYx3JNlsx4VyJePVeRYaVE3qzK6/9Bs8Ty71w57hrDiykDkiBj9Lmnd?=
 =?Windows-1252?Q?JAW7LWyWWfLjZdUD5LlUaRCQcbSclxb9B6YuQetWebTqJWKfswwnfXDC?=
 =?Windows-1252?Q?naU4IjgOXYLvj8qsQKp67txCYib3UgMVVkmNw/BGjJ9mbzhHhf/ltSKb?=
 =?Windows-1252?Q?kIQPZMp/ZDJSG+2OZbgT0CoUROI60iWTmD9vaBg6ECwI7zc2URTtXI3J?=
 =?Windows-1252?Q?3y47BmtdZ995vjgJ1+TATi1IPDpDp600=3D?=
X-Microsoft-Antispam-Message-Info: yrsa0yaaUpgbHxR+XCwDvJaZqB8vJiSwt51NCzwuQNiG4cvGmW6CKQsUX+5DtRvm4fwzMUSkfyId8gOEc6qjzcXNqp9P+hc58ljvaw9eGKoZX63MRs6utXor4efPpsw/SrYWMRXmEXAN2goEJhz1ai+9+VfFV7v8JRSYGJZS9+lafUiIAdnWHsERzaoF1/uy
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:hv7WcHBVL2Fw53m60j509T5hoNRJeTR86Tpc8YxDEJiB659+p0PsCGORwnga/Ho6/q9BgbHxco3PPXUvmJTvltrS/xkWfJwHmWfd6CrtJ+1ztmWhdGSGR+BBgkBROfaUc7G91T6Fn7AQdoIBS6N9h22Ax5RDIUPl5xIQ8WB5riQp7PjpOOZM+GhVmrMOAjWpVwAlnfkHR5y6vwkVVmnh8qI2CPGp0svALODdFErYcn3xafbDum1K+c9qJ0BGiNpN9Wi4wCX1xT0HDkfKsPUcuP7ARfZi+pCea6YYfRmcTDimqcHn+uW6DUju48ZWJNDxm15ihpob+nhJCZM8o5giRlPa8oyVhzhUSuSWtM940Cfvwk6iKgTofbbKIn5pVj5KQshAE9vosY7OM7x4P8LOPQeotkFHUeXjwog39EuySGlvkeIlCvb96MKc8SxDAkbCbS6OY4wrMCD2Ai4vQoZbBQ==;5:3OZgCi7raWBvnjd5m3eURzfqkO6oqzFNZevT985Eqs7EDRh4O10grWKLqKVPdrNZuNsJywAISZPPec/aGGm3h/EsO3MM863A4meSj+Mwq3vV/x/fZawwie8QeelJOYB3n+3XjtosUgbzF8es6FbcYZZWqq1USHVf/KpQzPlrLhI=;24:bsGOoB+SWaNJuVjxK3DHq+mMWuYE2oDZ7I2arub4KxD0tKhw7z2C0d09J4vXzHBYYG4tJN/0WECYX953eOto7+k+rwuyes4S423RTOoplJY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:4dsqVBo1AU4EK6FF8DBjzV3+aR89L1aOd41SW7+0INMOiTXWYOI1jc5aEMQc4X7UwZnV4qK0Gg9qOcdR0hL1yqiiWL0pyGnPxqGhg/drEwpS8JAvKkxtxvw/sakblHdFqiamkzLNcJu4U31Q0ad++WyKNviAYsKxnnrSj9JLfzmjG+S0obTUkQme1K1EXBmSr74k5GxLPR0u4ETH87P1DJ/ZNHKXEzddZO4sbwjJZlgBSMqfEAkK1Bu2lhdq9uCY;20:vBF2wUFTM55oqHsRPb3dKpLWbOotLCGgQsCAG8K8sDNavU4xUrywFxhjoGaCWSlxnrVwXWMgTuQYEmHWGoE48X954ZgGazdnIsDzHvQSMpEp473lU1+zlIMUQM8tttKN+1NCB9w/ahOlSo7bStL9PTiv9SCg3poFhgNOrcu6Kp4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 08:51:51.6832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5398ddd-f66f-4917-ab11-08d59876fb9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596602969164981992?=
X-GMAIL-MSGID: =?utf-8?q?1596623806248150801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Xiaolong,

thanks for reporting this.

I'll make needed changes in v2.

Kirill

On 02.04.2018 06:17, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 42658d54ce4d9c25c8a286651c60cbc869f2f91e ("list_lru: Add memcg argument to list_lru_from_kmem()")
> url: https://github.com/0day-ci/linux/commits/Kirill-Tkhai/Improve-shrink_slab-scalability-old-complexity-was-O-n-2-new-is-O-n/20180323-052754
> base: git://git.cmpxchg.org/linux-mmotm.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu Haswell,+smep,+smap -smp 2 -m 512M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------+------------+------------+
> |                                          | 7f23acedf7 | 42658d54ce |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 10         | 0          |
> | boot_failures                            | 0          | 19         |
> | BUG:unable_to_handle_kernel              | 0          | 19         |
> | Oops:#[##]                               | 0          | 19         |
> | RIP:list_lru_add                         | 0          | 19         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 19         |
> +------------------------------------------+------------+------------+
> 
> 
> 
> [  465.702558] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [  465.721123] PGD 800000001740e067 P4D 800000001740e067 PUD 1740f067 PMD 0 
> [  465.737033] Oops: 0002 [#1] PTI
> [  465.744456] CPU: 0 PID: 163 Comm: rc.local Not tainted 4.16.0-rc5-mm1-00298-g42658d5 #1
> [  465.760374] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  465.773920] RIP: 0010:list_lru_add+0x1e/0x70
> [  465.780850] RSP: 0018:ffffc90001f0fe18 EFLAGS: 00010246
> [  465.791551] RAX: ffff88001a1f16f0 RBX: ffff88000001a508 RCX: 0000000000000001
> [  465.806362] RDX: 0000000000000000 RSI: ffff88000001a520 RDI: 0000000000000246
> [  465.821265] RBP: ffffc90001f0fe28 R08: 0000000000000000 R09: 0000000000000001
> [  465.836206] R10: ffffc90001f0fd88 R11: 0000000000000001 R12: ffff88001a1f16f0
> [  465.850706] R13: ffffffff82c213d8 R14: ffffffff811aa4d5 R15: ffff88001a1f15f0
> [  465.865285] FS:  00007fccddf45700(0000) GS:ffffffff82e3f000(0000) knlGS:0000000000000000
> [  465.881839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  465.893412] CR2: 0000000000000000 CR3: 0000000017868004 CR4: 00000000000206f0
> [  465.907019] Call Trace:
> [  465.911369]  d_lru_add+0x37/0x40
> [  465.917037]  dput+0x181/0x1d0
> [  465.922225]  __fput+0x1a7/0x1c0
> [  465.928052]  ____fput+0x9/0x10
> [  465.933601]  task_work_run+0x84/0xc0
> [  465.940404]  exit_to_usermode_loop+0x4e/0x80
> [  465.948013]  do_syscall_64+0x179/0x190
> [  465.954817]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [  465.963476] RIP: 0033:0x7fccdd625040
> [  465.969435] RSP: 002b:00007fff689ff258 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [  465.981362] RAX: 0000000000000000 RBX: 00000000006f1c08 RCX: 00007fccdd625040
> [  465.993162] RDX: 00000000fbada408 RSI: 0000000000000001 RDI: 0000000000000003
> [  466.005567] RBP: 0000000000000000 R08: 0000000000000078 R09: 0000000001000000
> [  466.018316] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
> [  466.030899] R13: 000000000046e150 R14: 00000000000004f0 R15: 0000000000000001
> [  466.043602] Code: c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 53 48 8b 1f 49 89 f4 48 89 df e8 db f6 f5 00 49 8b 04 24 49 39 c4 75 3d <48> c7 04 25 00 00 00 00 00 00 00 00 48 8b 43 50 48 8d 53 48 4c 
> [  466.077316] RIP: list_lru_add+0x1e/0x70 RSP: ffffc90001f0fe18
> [  466.087943] CR2: 0000000000000000
> [  466.094137] ---[ end trace aeec590ab6dccbb2 ]---
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script  # job-script is attached in this email
> 
> 
> 
> Thanks,
> Xiaolong
> 
