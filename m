Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELuR8qoqNkkyiaYMDksRikBvNLwG3jz1z1Uldh924z+zW2xy21tliw1S8VaGdbNInRPxyMzF
ARC-Seal: i=1; a=rsa-sha256; t=1521804375; cv=none;
        d=google.com; s=arc-20160816;
        b=WQhnllCPZ/tt2tAMFLN999YayjgwyQoaG2/57GYf7WKm7+qx+MnabPiHKHhl1BNWq7
         VfGxU7BuHTpR0uwOtrMmnq6CLcPXOFKjn9QrFMdlgRep2uTcGR4bI88cT0pHvzOd+cac
         sL3mn0QSBU7NZeIcMpEqN1l9mPFcgledj3G9gzDlBjeQLYjA9GdYqPavIrQj/YclZIAo
         fOc2LwEbXXjvrJwMHIV+hkA9Xfc0BEr/By4ZuSHaQnfjo78j8W9a+p/luAfXHwLQsXiX
         p4iCi4X3dCY96m0KNN3HwQdoQQOs4efnVLe034D2Su00PcBkn3/yCACgS0JLTBoadUnU
         PTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ptqazjhwgqyBU1UaFklcpTuUl/kBvk28ves3k5kVo7E=;
        b=YbWn+nh50NWiO5mdLnEYwI22v9wfL1C7ZP+/mQqUnYRzLnhjA+hafLfQxqRdQ6nlIR
         7+CM1uYdiUO1dtydzQ4TkyHJSVMHyXWApxvUXY08vwVAbVb1/TvSzb4Zy70jUHaEYSHP
         qpOZc6AFZ6CXT+GlSL8luqSRHlqkil5lUVY6YKdGWZbFEub2Cc3aZNZhugdoLntOZMlY
         OPhotnXUi1Vl5Vhi6yzt5DC8Bp3RwpgeIxsVqhQoRsj34Xmn10LmgOU6YFe/vUJZWGHu
         hMmxj3a9TC4rbbS+f/3lU5UqWVHlFd6DaDRU3VHfwbRWdr/2j05QYIjTWG1mDUJ6O1ib
         cvqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Cx6ohFaM;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Cx6ohFaM;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
 mhocko@kernel.org, vdavydov.dev@gmail.com, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <201803231640.37BGHC6o%fengguang.wu@intel.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <17882dc4-3799-29f0-96ff-09a787f10bcd@virtuozzo.com>
Date: Fri, 23 Mar 2018 14:26:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803231640.37BGHC6o%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: CWXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::16) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f2c4ec-1d60-4433-5c89-08d590b0e078
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:pqnl8GN3vFSqxInRUdnt1BAJNkmN2yeaC1rD9TnsOgclXDw0BXqVkjBHW5JzMB3N/XSEeS04C6RIYHBIrVw45RhdIrRq1BDo/KlRzAkKoft292A9Lw2LUTb5h2dUEbrV0M1GrOIkmfNu9NRTR95dnB6q8XiljY8H7erHNe5+My5LHDvx0iCVqszkG0z05BZ+0aE/nwQ1aTasujZvjwIsmnXewRUKq12Ltimz+Q/O1Ec94sN0UUr4Gq8/Xyrufrhp;25:8io/legKI3BvY4Qo1wU5GjxyW0zDvzbFa7gR2JGqkaJ4lK6pNEhol8Iq9DdJqUO+TGyJpPUP958/n7XRdcGj6fxdYPh7iqQUpHbi5lNk10YSPjZ1zbTnKb8x7+Rc5SlQULaz0xxNXBElzX7LFpAe2ZTQMicFN5GymhcKePlmq7UxUtnTonAHX52dV3HLonvV8hcLHpCuMofj9iNj0ptTQv+BmTDWQtVVZ5SGlvQM4wfBK5nA9xjZqiPtZOTdS9u50BLiK8Hm0IQYGwMLoWI6ocjRlU8azqUGDZS5+JEqyreKLTMbEyo65JI+EXy0D89VV2rIxRJXAETplRGyVZOs0A==;31:yWSZ0sFzJvdGEJevNxBRahbKujRFHAwuXu/pYsexXs4hHMPzWeCcSafdvX0jCbC0woqsg/rGtq2xgbMtV8lToy1IihDuSEb7S4Nx6DS6yTjj4o2sHlrS9UTVCv6fViBXFs96749WtL4dNJ9W8NFzScwRanVP7/i8RO1F/Ygq9RwQDbRp3qhXbI/+ymI4hAOBxHrHL5+u2qJ5DhDDop4E0W3eEeV0ihk/hJ1X0TB4Et4=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:e2AbzYCHyMnEnSdhg8yWzR91o3a4T3qFMa+7/u1VvkOkevwK8uBKUuAsnpn6H/VKrqadi1rxh+XInPE757dglHYWwIDhHqo8NPSwuZ50feFhaLtW/AVX+v6r1YMsS2oa08X3NfZn0L9EzbefHQ2RN17uiwg2Xdt6cjYP38cvNV5/MSp5JbdsGdTQpgHeEkH+kx3I58t/QnXlIsMIiEXYCZf//NTj6UVSNRdgyPMKM4f1iXCXwpSpwiW1i8cSO+RbVI0Ulhjr+tcL0O/W/azcZXCp04EHkMe8x0kCQgSwS30/TNmCx6Nto7ptwpcveVQVFaHYSXjpIcsC0COPNU6auR90/y7pnpXPwwUeKylgLsjMVsFKu2JvFXkTgcHMWCBNWcbzLmidSHjv/SCkLI68Eo9g6ito3GxTooayLFNc0sfSxXr436DzvPNgYwNmgjjxSEhwkjXuxyPjhIGphwpBhbvgZ6zDgoseOVzI/JUoXN6Om/54qcTcXeOvORSlJFGg;4:n7LbpFksurOFiDS9aEOTFzHR8ZNXrsmIjjM3OJ/gezqY4AatqBCmaLyE6lS9hUTCocQ55xfn1NpsCsvOSH/m6WiR/cPSIoMIJtLBC0qaCHzKXyqVa0i1Q8c32n/a5G2hkHaHqpoI7HlX1hf8pZFxWPxtHXk0qiDhxQ+WjwwawCA3itzBZQjWEZMjKcXKQ7iJpdHCm0qRhbAqlHZc3GZr3KIQKNsq2ZQM7q5Vds0sSvxumWebq2fv1GEqVuJvPbmb/Gc3nE7Dz0cPlhVCWd0xrMmmoqq9YNXY3qRfO/FXGwynNEbq/VYx3GVFplx03Zk4JcyR9S///ZkW1PeUrg2eUqkA8F2Rvk3F0lS4Fr7g060=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333B9D26D77F8ECAA04A4CFCDA80@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(162533806227266);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(396003)(39850400004)(39380400002)(366004)(199004)(189003)(25786009)(39060400002)(3846002)(86362001)(7736002)(64126003)(52116002)(2486003)(23676004)(76176011)(52146003)(97736004)(59450400001)(305945005)(6486002)(2906002)(8936002)(53936002)(446003)(106356001)(5660300001)(8676002)(65806001)(81156014)(478600001)(65956001)(11346002)(6916009)(386003)(47776003)(53546011)(66066001)(7416002)(6246003)(65826007)(105586002)(31696002)(31686004)(68736007)(229853002)(58126008)(230700001)(6116002)(26005)(55236004)(6306002)(6666003)(50466002)(4326008)(16576012)(77096007)(81166006)(966005)(186003)(345774005)(16526019)(36756003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6MklnQ255blJvQStwZkptY0toZThYYTRT?=
 =?utf-8?B?cDUwckJ6Z2dnZzNZU1dxdWpxU3d1SEpha3VpSXhhU3JxRzhIdEJuWk9wNXF4?=
 =?utf-8?B?cngwdTZkam54bUtoNGlNMUFnR2ZTckdXU2x5d1J2ZlU2NjZ5Tk9rVE5ETWs1?=
 =?utf-8?B?MC94ZHBsWDNoeVhpc2xKRVlaZzZoZHJ4SXFTQ1RPZTVleXJNWi9hQ3IwaGpn?=
 =?utf-8?B?b2FWZW5zSkdZVjdMODQwcU5GbEFHV2pZRzliTktheHNNSTA4NGdDR1NFMFZa?=
 =?utf-8?B?OE9mdW5ycXNTb2QyZGhZeTdBclV2czBDdkVoVG5BbDBMQmQ3ck5NRWUwblF5?=
 =?utf-8?B?aTJRdm5xd1I1OHhSbHR3Y0NFS0Q2SHVsK0tJdGRwWlJrSjQ2QlV4WmdYMkxR?=
 =?utf-8?B?bmludzdsWVVTNXNRMlh2dkprY3RYMHRvcUNsVEFYb2dSSWduQWFuVnY1VGR4?=
 =?utf-8?B?THEyb2xIRW15ejRzbndtZkV1TC83czc3S2d0WHMwamR5Q0hhKzdvT0NHUklL?=
 =?utf-8?B?b2FrdzBSNVdlKzVjQkVUMUJ2YjJCZG9Td0Rpb3lNT2doV2NaZElXWU5vOUtq?=
 =?utf-8?B?bnVrSlJKVkJvSUpLd0xWRllyK1poTjBnYXJzOStUdzloZWJRZG9EWmpnRCtw?=
 =?utf-8?B?WGVRcHFkV3hJVVdMNEoveHR0UTFNMnRSZnNnUGx2OHUwQnB1SHg1NTVpbHV4?=
 =?utf-8?B?cTViVndNdi81QmpGVDdsbVUrbWhSSTN6T2hnL2k3dElyMFFieE8xditvc092?=
 =?utf-8?B?U1ZJc0RkS0hyN3dLblNPYTVVZlllYUFZV0djZUw2cTBXcklyb3NnTHRpR1pI?=
 =?utf-8?B?ZEtFVkdGbTVQYWtJekdRQnB6cGU0R3ppRHo3QlRWazdrNG9CRW1KdjhsTkNW?=
 =?utf-8?B?cld4NkUxL1dHcWR1alZoS09aWkJpR0VqM1NmbG45amJDVjkrcllIdm4xc3or?=
 =?utf-8?B?WmlCbmpkY0pIbTQyb3VBOUtsQ0NvZDBsTCt1WmJ3V05KYXVMVGRCUGtZZ3Rz?=
 =?utf-8?B?cW50WVJDdks3QStwWkZLN3Q2M2x6QWk0bmNZQnl5M1JneU92S29DdEE3Wjkx?=
 =?utf-8?B?YjNCVjJJVEFoNWFHckZjeEdEMXJoYnJZa2Q0Qmpkb1Z0M3dYYjMrYnZpUVJn?=
 =?utf-8?B?aDZKL1N3Y0lqM0tQTWRFbmtneEx3dndEV1k3SmtVNnZoTXRydkZtTjZOcUVC?=
 =?utf-8?B?UTF4MkQ2cDVXOE5GRzBFV25XeDdNeWs3VjFRRE90VlFYUjVtcFplVVRUYkhD?=
 =?utf-8?B?Z091QmZHOXR0QkMxaEl5MFloWFdJM1dFcDlyOHFINFExb25jR1pNU3RsQ0Rl?=
 =?utf-8?B?MTJXZVkvdE5iV0h4K0Nuak5mZi9tWWV2ZzlpNElhVEpmK0J6VGFCbWRGQUdE?=
 =?utf-8?B?UGRaaDJGeHNnY05VRGFlam9DZWI1Ry9xRi9Yb0V5ZlQ2akg5SWhxV3VXNWVt?=
 =?utf-8?B?M3phNUZ5N0Z4Q2I1dDQ5bFA0V1ZqZHdBTnY0aGxIRnYzVHFNQlgzcllHdXVp?=
 =?utf-8?B?U2xpUkNNblN3SVBJaWtRMTNOMEdSclVuK0pJRXVYS21KK1ZNbVpEQjZDYXZT?=
 =?utf-8?B?Z3dHTFJRSk02T0laM05QZFF1MTdMRmMzY1M2NndqeHpwTkhic29VaEFWb1Zs?=
 =?utf-8?B?Znl3Z0VPRno3Y3piM3BFdk5obEI0elhkeU5vQ0NwdWRmKzM1bTI0QmJRdTF0?=
 =?utf-8?B?czV6Vm1WaWN3YWY1YTM2WGpnRDlCZDJFbkk0cEhDMUFKQzJjc2xnNUxEc1J6?=
 =?utf-8?B?K0F2WFlMbzhzQmwvZVNDbnptMjRkT1FGQUNLckpSZ29DT0lPcFhCT3JvK004?=
 =?utf-8?B?cHFWbGxoakNwVW1acW5EMmVKUndLeFo0cFprNXRCMjVSano1UnhYWGVyVncy?=
 =?utf-8?B?SnZJZVVVWmtMOUZSUHhvSEszeEZBSkZ1VDgzSjlmdHJ4NjhSeXJTNjBad1pJ?=
 =?utf-8?B?Ujg5bnpoWFJ0VC9NRlB4VWlWUkJiQlFlM3hPRU1ENlJUKzVEVFp1bGd6N0J3?=
 =?utf-8?B?b1daa1p5TkRSdXdOejMxSTYvZjVwdnRnWkZmZjB1NWhEbzlRNm5NYkFoMkU0?=
 =?utf-8?Q?2EJTHU=3D?=
X-Microsoft-Antispam-Message-Info: CSdSYuTDLqQJ952Gh5IqbxCnetwstsRAcQC1/6cTo5Z2sAuCbMv2FXCOWt/7t5vFsQtQiIE8y+GBNkubtm987dnKjGzdQQIVDvMnoMWw85wx3cze5Cve/7DlbKSe6g5L8NoXiMzK1AmzAKrqbTXd1dHcl1QecAyjY7SlEB0VNRLdo3vd/AVqQm4px6CaI0px
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:za225xyPuheAYde/B+DGLQhi/DO2msX4v2XvsID+Amw+FCiPu72roXdOcqEBuPIJ2HdqCeYa8kkVwWYoCGuHeLU5GT8Ornbg5n9QPToYnHadS0VtJ1kjEMwBoFvZaa4YccC3+v/xe6iMgv5V4ON1lrVXUzoAu4ePktP0V/eM1VZDk+aRwXDyB9oSlTsJlrW0P/wb5R1MY/1bco0qaSdBfDA0kdiU+gBLFH2wz4WfZ+HldqoEaCVgFjbjbYn2EUqqzN4Ol9E8Zpk9abjpahu4x44r8K5+PrfbV0o+YZGZQEU9yciNSjEx/qOWwEehI9V8RmS8/HL5BFxnjVR8Nm/Aechva0LILHad2tRsFN9dM5ctfiR0rdEd9VMu2J9HPZb2OOystBWdttXdJJ/6fRa+lQFXXTqtfzWR60stPZtQ4MicHxecYfH8dohaVgNCRbePvL2eHDaqPGW1tFu4BzSy0w==;5:5NMwA4y3ZGumP+6bWrNDcXRUxFFVRjwzuF5S1PlaFZ5uwOQf7+3UVuc5AOQeOwvT+Yn8DyiwiycmHA9dlzDJwJb3LT6lpt0JrbPaOQqBNRY7CQb2RmoeCeYB+DHd68WLGTKQ/B/4lcyM7MQ9sh9QasH1wiJqU0UxvfmjZq/Mn+g=;24:1k32rdYC+BDPf+HLE0AMKVxyl/lXVkxmQ8bYyE2K4d565KfqfRVXYoCxLw2/fHPUoxEypQ+JIivlotYmDS5vrcdT6dCzEgDxyexf8wtVgrk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:EZbW8prOT6aJVbeL2KA6OFYY8R8J+txPGdWDnYuG4DEbVb/aWXcpnIr7UoxMmsO88JW+T+73nTMicHaIRNuWDb6y4+pfwjRGiysUnWYi2gRrMJnrd2ubAKc5MwW+5JzUDu3gZOguPELQdqyI1UDGYfS5gBeoowHpHcSE+gBsk1GvzYykOwvqoVg/GI+nAYGBv+YMg3bHF/rqJlYQLFuFOqsIQ7Gmtbsntgo/C9vS9unE2hmhK8/2cBud4nCGHdVq;20:ZAATjH8zkKD/sklJG20QVjX1KoYPa7stmrhyFbydc4K9Tb95RjTiFvO8x275qVIOwQVYeiMkO2Nj7Io/06cUWNXWhsu38XXiDAJI/E39Dnm1KSpAcN/sll53WVRS0Dhxkb+2iq+rKhbK9G3mYJAzRc1MIJw7+kunb8mF0qtfuLg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 11:26:07.6325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f2c4ec-1d60-4433-5c89-08d590b0e078
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595727544540731008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23.03.2018 12:06, kbuild test robot wrote:
> Hi Kirill,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mmotm/master]
> [also build test WARNING on v4.16-rc6 next-20180322]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Kirill-Tkhai/Improve-shrink_slab-scalability-old-complexity-was-O-n-2-new-is-O-n/20180323-052754
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:79:1: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned long [unsigned] flags @@    got resunsigned long [unsigned] flags @@
>    include/trace/events/vmscan.h:79:1:    expected unsigned long [unsigned] flags
>    include/trace/events/vmscan.h:79:1:    got restricted gfp_t [usertype] gfp_flags
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:106:1: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned long [unsigned] flags @@    got resunsigned long [unsigned] flags @@
>    include/trace/events/vmscan.h:106:1:    expected unsigned long [unsigned] flags
>    include/trace/events/vmscan.h:106:1:    got restricted gfp_t [usertype] gfp_flags
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
>    include/trace/events/vmscan.h:196:1: sparse: too many warnings
>>> mm/vmscan.c:231:15: sparse: incompatible types in conditional expression (different address spaces)
>>> mm/vmscan.c:231:15: sparse: cast from unknown type
>>> mm/vmscan.c:231:15: sparse: incompatible types in conditional expression (different address spaces)
>>> mm/vmscan.c:231:15: sparse: incompatible types in conditional expression (different address spaces)
>>> mm/vmscan.c:231:15: sparse: cast from unknown type
> 
> vim +231 mm/vmscan.c

Yeah, thanks for report.

> 
>    205	
>    206	static int memcg_expand_maps(struct mem_cgroup *memcg, int size, int old_size)
>    207	{
>    208		struct shrinkers_map *new, *old;
>    209		int i;
>    210	
>    211		new = kvmalloc(sizeof(*new) + nr_node_ids * sizeof(new->map[0]),
>    212				GFP_KERNEL);
>    213		if (!new)
>    214			return -ENOMEM;
>    215	
>    216		for (i = 0; i < nr_node_ids; i++) {
>    217			new->map[i] = kvmalloc_node(size, GFP_KERNEL, i);
>    218			if (!new->map[i]) {
>    219				while (--i >= 0)
>    220					kvfree(new->map[i]);
>    221				kvfree(new);
>    222				return -ENOMEM;
>    223			}
>    224	
>    225			/* Set all old bits, clear all new bits */
>    226			memset(new->map[i], (int)0xff, old_size);
>    227			memset((void *)new->map[i] + old_size, 0, size - old_size);
>    228		}
>    229	
>    230		lockdep_assert_held(&bitmap_rwsem);
>  > 231		old = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
>    232	
>    233		/*
>    234		 * We don't want to use rcu_read_lock() in shrink_slab().
>    235		 * Since expansion happens rare, we may just take the lock
>    236		 * here.
>    237		 */
>    238		if (old)
>    239			down_write(&shrinker_rwsem);
>    240	
>    241		if (memcg)
>    242			rcu_assign_pointer(memcg->shrinkers_map, new);
>    243		else
>    244			rcu_assign_pointer(root_shrinkers_map, new);
>    245	
>    246		if (old) {
>    247			up_write(&shrinker_rwsem);
>    248			call_rcu(&old->rcu, kvfree_map_rcu);
>    249		}
>    250	
>    251		return 0;
>    252	}
>    253	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
