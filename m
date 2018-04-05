Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/WevG7rw2nZVc6KeaXX9fbzvmEClplOw71cqoP4UITQXWqChQetdlFk2d7kIAjIDC9p84m
ARC-Seal: i=1; a=rsa-sha256; t=1522933271; cv=none;
        d=google.com; s=arc-20160816;
        b=pj6Y/+433LQPb5W1z+M7tFmTjAk0x3jv3MJmqYAsNIwxu7TT5WsmjWeyNuebnb9XXt
         ljYxkZJUFaMEfzPLC2hnoRwc+oUSHM7j/f97ywJCt+V/Mk/0pgr0TrKO+FsJmUvjZmIs
         YpY7JZSqnH0eNFzyrd3DkRDhJf6EQk8jEBzNZxCQlC0lvMNO/LEqlFhsoVHt7LebPU2M
         Z/ULvtfws8q/YyEgSPGpUA7mVTJFqwcz/PvczF4rwv9cQw4K0J4d+3U6gl/5QsR5wwZM
         F+MoJFr3z4+BgW9ti+VHJ/SsUp2g2OxCqAT3r+BKoBTvkIhB636q2Q0Zlp4iJR8X2hzG
         O12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=f2usKk7vnl28aMzePg7RMyFzFHHvclk9T/cpa8e8wyA=;
        b=vt+CRyFPhsS6oR+nUeKfO0ak7epdiAWRn8Uj/zS6tGEOdJGkAgi5Znu71oVwDgv9sK
         dlMJ4AlyXvO7ssJzNtpX9F2Abvn9oON8QMsE/zYsNYeT5cxXTBmxlTaiJtaF1GbhjjWy
         XrzMZ2n2oqT6GH9nh9jq44t+BSYj3jegRowGHu1gAWN09ykJtEGN9JaBUCH0UBQ6FUhd
         d39kTUhja1fVM/GiiA23jP54EZrpZqJZtUmtfipnDeweGZeI0ybmsFKB9P49/T+8JClD
         zlqumZrfVdwjsCPJeB+bGr3bCHMjdF3SEuhLKmtuWM11DC2n438mwZqGpRxxfqYGULyc
         1bag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ibNEZxQE;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.138 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ibNEZxQE;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.138 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH net-next] netns: filter uevents correctly
To: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
 davem@davemloft.net, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: avagin@virtuozzo.com, serge@hallyn.com
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
Date: Thu, 5 Apr 2018 16:01:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404194857.29375-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::31) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed633d8-0a3d-42e2-8a36-08d59af54b72
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:lcAzH5i+UWPnn+srDhqLhwp1RVPSdXD+HtM0aVzI4ElDoWAAqs5jhmvx9k7Nd2ZJs0ZLcfUgHDSxE2TVfB6vQFOP206dnZxYEbVSj1jliCf0zhXkzr7qI6/26YkeH2h2sYtHrLiIWVGR3fn5cwfs2wqlzs+Gn/fUjEoNoXZWsO2G+kKdkgNaEow1avv+rp+t6NYjFTDFl2Fb4QOi1uW+7OxLGuLl9ah+BGbhOyAgajAw3oYvBqJkaqXRv+it2N9L;25:LzVCq3BXslPEVZZhktuvy9lKC3fFiQmd5M58zZEy28XpbSboiVBcmQBTs+6vGVzose2sByJCQTyipy+cVXWs/9COTXIaJNXrv1aeJ1Ak+o+4MUfhSqpByVEVDZJEVjT18uHdxerArO9MnTGMG7K12w59tDZFXZhQS59yNwtBPllb049JqZW17pXv2DWMwivWn2SJvIqTNpP/3SbHWg61Le95tbKepg1GhUdiIU+S0g8lPLWOkiISrulnMPDmBPlKWljsRVJkD+j8COKmvwY97OwzsFo4dmF2D0IWgTCuzeYVWDt87e1LZoNVq0O7ua3WECCEVLJ2yC4Zl/W7UMDGwQ==;31:xyOmCWqERGpUsG8DDM8nXWsV+tzXHe8+te9OOzAYCyF8jDI2AG24K9Rc6SEawjI1DCLc5/rlfp0CEZechS9xYIzz8TawlPPWGqHKCg20Jg4Mgba1rzF6ZzVdfw37lQCLt67Ao2V+apUKtfa1gmMlC3zCnwpSdevlfb3gvqTwiUHBBd59YgKzboD9G+xWg9VuIWMigUqEMhXxHn6If/goY+jz4Wr5T2sYnz5svTr1iTI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:zKwzssZ+6sZhNvAJZlUVBKCkq1YQeaONOHetCC9vajS3amrT9XVZimxRHx7JxHKXTMtILpUGGCibOaz1cS53vRJrzMEFATyorujI5Q/wWgju0HVvk8TA7XzRUo98hAcPFTL1Lm7P4PQx0d9AE6t9dsnywqw1vXq7pMQ/cM2j2RIOdMev6y3hqvm3YAiZd1Aoc8G3wFzRou8g+mGARHDgxW/pRtc3voG52r8PwbUw0p4rA43KiffiGEWU6XLS8Kj4ySntoSiXJ864TxvgvLUV/rqBr8wMERNmzy8/B1XXq/TD5pnMOqMtZAm8m3ahl3oa6JCnBBbo4km3jlr+s4IxzZZgaNOJ4nT11wnVwQRcnPk3W4BIdrFgOKxKXnfEAzmCRlL6udplrCT3QBF7boy3xHAFTuUL6aTWZJkNnvuPFNP0y+VqcZQm4xVh9eI8dHXMVEl7yuzWwJRU6ECdhj+I31jd1IYWqzOZkuaSkVkDvHs497m2LVR7IF0MwlTQGbdn;4:3HLDiGL5mS3m5Gy3t8cXkG5rovuQ7bz3JcypYH7OPNX7JAmrNIVevTPxKReLzTqwMP/Kd1M7qLbS0VmEMrYcpweDgTBIoqt4Egx63deyuqRtKoBuW3sTvBzR1dEjWRutP3PtMzyX/1JYJzghX6PpTckGzomPKTkg93qMPwDYbIbpc558cgbCFDp0JBz0ag+Pue6auNdwfoqoHHFlFhy4onRgA03EXXPUO3C26NHZS9okKNNghC1WWIBn37tec7cDmPPtif8DjaXWoPtf4VzZ9A==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340BDD30C9A09CBA34A14C7CDBB0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39380400002)(39850400004)(376002)(199004)(189003)(66066001)(31686004)(65826007)(6666003)(105586002)(16576012)(58126008)(316002)(106356001)(65806001)(76176011)(305945005)(6346003)(36756003)(23676004)(2486003)(52116002)(52146003)(65956001)(6246003)(81156014)(68736007)(55236004)(59450400001)(386003)(8676002)(53546011)(7736002)(81166006)(8936002)(2906002)(5660300001)(53936002)(47776003)(25786009)(77096007)(97736004)(16526019)(31696002)(6486002)(86362001)(64126003)(4326008)(229853002)(956004)(2616005)(230700001)(11346002)(50466002)(478600001)(186003)(446003)(6116002)(3846002)(26005)(486006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6cWpTaVpjcTlrTDdITHBuMHNLUkQxTUZV?=
 =?utf-8?B?dktzU0xmTmcrZnhmMVQrcWwycElhWHlWTFNicURCN2gzT0ZkQUdOYjVTdmV0?=
 =?utf-8?B?RTRublZqMG5uVzM3WExDN3orcU92NTJObTByZnpLeG5oMkZQMStaNFN3THpw?=
 =?utf-8?B?Qy9ndndNdVZHRXpLdUlVWmxYbmMwOFlkL0tXcGIrWHRyWnRlSHZ3VS94NVpx?=
 =?utf-8?B?emZyQXlobXJYVTRjTXZ1T0ZtTmVlUHR0TWVTK0FJeFM3ZXBuN3hxMVNNSWR6?=
 =?utf-8?B?QUNMVFRsdWpYbGJhQ1Ayd0dnZldRTkRJNWFUZlFadUtueXRuMnFqWnZxQ1Jx?=
 =?utf-8?B?Q3R3TTFXNFBJalFmRmpuY3N0WlRhUzN0eGZQTDFPeCs3WGY2VDNlSUpjeTFF?=
 =?utf-8?B?QTM0d05lSzZuVzJWeE1aemIxWjBoc0FKNmxHY3dweXMrU05oNmw0dzlIYjB0?=
 =?utf-8?B?QXJhWWhxRCsxcTJtN1p3YjhiTnZMc2t0THJUSXlmNDZxbG9VNnFrcTdJVERG?=
 =?utf-8?B?a3IwWUMrTUUweXRnRmFmUC8zYmhYdkpFY1M4MXJySmdXMm5KT0p3RldOS01I?=
 =?utf-8?B?dkcxbGc3eHVpcm1sSGhhWWp3TEdDZGpvT2Y4VnpLU2JpTkN3SlpGWS8zeFJG?=
 =?utf-8?B?TWQvektkWitsMTBWY3A1TzlFVlRsZkJmcDJ0M1IvS1p0NXp6Wks2c3c0RG1w?=
 =?utf-8?B?Wk5vNXZEOFZkVllCR1RSUDBCUUlFRzlRNlpERE00QnVYSlNuVGQ4RFpJQjNO?=
 =?utf-8?B?Ym13STRPMWcwWUh6OFVHMTY4V1FveDhqWXAxSFhKSEQyZktyV1kyUGEyNDU1?=
 =?utf-8?B?aUY2MHV1aUFDRlJmVlY1SVkvR2JwS3ozeWljeFpsTVE2SkxCbkR5ZWVxSlda?=
 =?utf-8?B?aEtWZUp3Qk9URHI2ajB1R0VBZWpweDYrRzlpNmtscU1RNVBGeHB4NFdRaDhh?=
 =?utf-8?B?UWhiVmd1V3dkcWd2YjhOdFY2TUpwS0xRazFQV0p0YXdTbndrSlBxWG5pbGtL?=
 =?utf-8?B?eDZ0SlRack1odjJDbGxhL2FjL3ZyM3lhdFVqdEcwVDJOemw4YUEwOHBpYnVl?=
 =?utf-8?B?bTM2bEY2VTh6RWZUaCt6UHg1RXRDVkFqWC9hcGRKRW1GTGVqSXVoRWplUktJ?=
 =?utf-8?B?N0RsNWdscHRQbSt3dkZ3M1ZGZU1yUWZHNm0vQVE4aFBjTUxDT3oxY1VCSGlF?=
 =?utf-8?B?dkdVbURjSzQ5RVpCRlYwSmUrWloycC8va3ZQUFBGTXdSZ0sveHdCdFl0c0Jo?=
 =?utf-8?B?bUtIV1g2V05HTTl0eUxOOGZoemhIeHh0VjBVcGtkL2hYUWxjazBaUXhSamVO?=
 =?utf-8?B?YXJrNmdJM0lFVDA2cWFqSXJXNEdlUnFYWExZd1doQXY1d0dyeTJzaGViV0tk?=
 =?utf-8?B?dng3ajlFdnpBdExaUi85RkZ4MWtHRnAwT2hIcGNmSW9mWjdiZHlGNU1ucS8r?=
 =?utf-8?B?Y0FON1lxVEd3TlFVem1NMlNrSWRPb2plcHBDTkNycTczbDlUQVFianc3VkhG?=
 =?utf-8?B?SVBDc2xUeHpzN2lJZUdFU0VjYUtCcktvekMwdmtMZld2YzM5ZmhsLzZsSlhz?=
 =?utf-8?B?clV1b28yT2pnTHp5NW90TnViZ2JMaUZPQUJaZkUwUk1pTnpubjdLWUhZa1Fp?=
 =?utf-8?B?UWZ3ZVk2anhMSlpnOXNUUUYvMy9EeFNGN004VUhmbG5aOCt1d1dHd1JXYzFC?=
 =?utf-8?B?ZlZZWnprWjFzVzRrOXZMNjNsdDZUZmlZdlV2WTZ5aUJEVmtMLzJGU3Y1alBG?=
 =?utf-8?B?TTlXMFBaYXFBek4xWXl3SnQxNlhJMFBWa3NzZCtxQUNLSENPVXlNL1Q3OVNZ?=
 =?utf-8?B?YjZzeUpJSXVjVmRRY0dTWFpJcWRJdTZOckJ3Rm1meUkzR1lyZS9NdHd3dGJV?=
 =?utf-8?B?czk4dVRtMTJkbFNtcWJFOXhoTlhla0szRTU0cUNvTnVSdTNxR3c1aGpNazBt?=
 =?utf-8?B?OFNDamxOS0t6UGJPbW9oVkZOclltZWw4Mk1jZVZlUU10RmtUb1Z2T1Z6WEln?=
 =?utf-8?Q?wZk6iCJI?=
X-Microsoft-Antispam-Message-Info: EfA78z3kkwj/ehZmWpj0JsFgqMMmY7e5DvJjYcGdKI6mU3Qcyl+bTgw9QDicXL7i+dTImxHATyJdl2iIWhsVMf1EV3LKoNNrhMOCpbLeeStc8xHNHzGdZdEQ3TEjccEJj78vvZE6TEU67SWxms6hBMYapP8qvEj93UmRMJ6vB3F+sWDMK3+DxElJL7BP1MvK
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:VxLwebLnCZeLgWQKgVE0eAszw8bnO0gODsNrzW9ut6eU9zcGihJVZrft7yP8FLFjG6ahxNjoRwO4nFYhCtn4wobE1VemipKPUUF5pIOJWIKztqJCMl2JhMnRqd60mXIC85W3MMqf8JLFeDE5jrZxwgcO/DYgDl0zp1HqHHJAL+t/OHeewECnj5zwatSTfWxcyhc6qw7mQiPBzVZGmoqLunXTYXKIvtfqXoTvtCrsVn/bOPuGFHuvti7i+fp1miMtEQFOA5EEloPEHftDyt1stf0c10dgs4zLJI8gDFtf9zEHPZOQh/GjxoxyOZ5x6LENEavwylD8aXytZl7TU5Pyi9HbBpM3x0kvcKl1LcMaT9zeZxbI70tEnh7ynV9BvOIrqFOBhx6idfHhAVYVOZSnn6nBFmwAhYMUt3x4mZ31gemY6CZ9M3d3Pdb4/MFgNyWCI5kB3n2MZCVG+67HuZSNxA==;5:0J1T0/MTTKAuHnU7Knljd8ewP1UWjUIg+W+v8Y8qyMrdP0/OSfVEPFJ05E5x/eJkLeoADWnr6TT+gtXjN3sgqOGIjBTaYaMhzr9fzEE27FIOUlHfdSYihUT2SkujyvVf/bM0QKQygaqtM9lbVV1XIDQEluOoelVKUl6GGn0JXkw=;24:FyD0xbbgXrIgAXLljKkclWIDLvRM6JhodWuLFOuKH7/0KkMBN2BieYsKgMJmYbFChzZPloIfbykUmpjKQK/LAB0r6Wopj+aof7MlmTBh/nk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:Z1kE4o2Gcfcvc/SwSLDUUKZ00xzOf3G+VPHvaXEC0ze5e6F4mI00KzgE06D94FyV1t2RB4Obj2zLH89WlDeaM7HRCjOQJtdRyNqEFs02UJ1pUfw1RB+EhkPxNRQedku+vMJCF5zQAcLA99Y34A8WhDW52a3r/THOBFCr/Y/RdG7sysptzPPOd60VzLfd6kHSuOu8jREoHEzNw/snRJ/kLqsqV/JL/vLhYY9qjA/p8GQ/hNqU+CLlmRnl7wK31sRa;20:oQxOzF4cF0KebRBDno8V3kc0RcleAcK6Rinmtwh/9tOgVBUA5xgmcmqUWxXUZ+yNrABOnGMv9kYgZbxMSSO8Drde71rijP2vtTSsXWlOKKXn3H6W4vmKEef1w8kthpcs2LLIqUgf0EQ+Gjr9BDny++1LeFeFFOtLzzrdI5t5UiM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 13:01:06.2974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed633d8-0a3d-42e2-8a36-08d59af54b72
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596911277993275360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04.04.2018 22:48, Christian Brauner wrote:
> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> 
> enabled sending hotplug events into all network namespaces back in 2010.
> Over time the set of uevents that get sent into all network namespaces has
> shrunk. We have now reached the point where hotplug events for all devices
> that carry a namespace tag are filtered according to that namespace.
> 
> Specifically, they are filtered whenever the namespace tag of the kobject
> does not match the namespace tag of the netlink socket. One example are
> network devices. Uevents for network devices only show up in the network
> namespaces these devices are moved to or created in.
> 
> However, any uevent for a kobject that does not have a namespace tag
> associated with it will not be filtered and we will *try* to broadcast it
> into all network namespaces.
> 
> The original patchset was written in 2010 before user namespaces were a
> thing. With the introduction of user namespaces sending out uevents became
> partially isolated as they were filtered by user namespaces:
> 
> net/netlink/af_netlink.c:do_one_broadcast()
> 
> if (!net_eq(sock_net(sk), p->net)) {
>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>                 return;
> 
>         if (!peernet_has_id(sock_net(sk), p->net))
>                 return;
> 
>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>                              CAP_NET_BROADCAST))
>         j       return;
> }
> 
> The file_ns_capable() check will check whether the caller had
> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
> namespace of interest. This check is fine in general but seems insufficient
> to me when paired with uevents. The reason is that devices always belong to
> the initial user namespace so uevents for kobjects that do not carry a
> namespace tag should never be sent into another user namespace. This has
> been the intention all along. But there's one case where this breaks,
> namely if a new user namespace is created by root on the host and an
> identity mapping is established between root on the host and root in the
> new user namespace. Here's a reproducer:
> 
>  sudo unshare -U --map-root
>  udevadm monitor -k
>  # Now change to initial user namespace and e.g. do
>  modprobe kvm
>  # or
>  rmmod kvm
> 
> will allow the non-initial user namespace to retrieve all uevents from the
> host. This seems very anecdotal given that in the general case user
> namespaces do not see any uevents and also can't really do anything useful
> with them.
> 
> Additionally, it is now possible to send uevents from userspace. As such we
> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
> namespace of the network namespace of the netlink socket) userspace process
> make a decision what uevents should be sent.
> 
> This makes me think that we should simply ensure that uevents for kobjects
> that do not carry a namespace tag are *always* filtered by user namespace
> in kobj_bcast_filter(). Specifically:
> - If the owning user namespace of the uevent socket is not init_user_ns the
>   event will always be filtered.
> - If the network namespace the uevent socket belongs to was created in the
>   initial user namespace but was opened from a non-initial user namespace
>   the event will be filtered as well.
> Put another way, uevents for kobjects not carrying a namespace tag are now
> always only sent to the initial user namespace. The regression potential
> for this is near to non-existent since user namespaces can't really do
> anything with interesting devices.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  lib/kobject_uevent.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 15ea216a67ce..cb98cddb6e3b 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  		return sock_ns != ns;
>  	}
>  
> -	return 0;
> +	/*
> +	 * The kobject does not carry a namespace tag so filter by user
> +	 * namespace below.
> +	 */
> +	if (sock_net(dsk)->user_ns != &init_user_ns)
> +		return 1;
> +
> +	/* Check if socket was opened from non-initial user namespace. */
> +	return sk_user_ns(dsk) != &init_user_ns;
>  }
>  #endif

So, this prohibits to listen events of all devices except network-related
in containers? If it's so, I don't think it's a good solution. Uevents is not
net-devices-only related interface and it's used for all devices in system.
People may want to delegate block devices to nested user_ns, for example.

Better we should think about something like "generic device <-> user_ns" connection,
and to filter events by this user_ns.

Thanks,
Kirill
