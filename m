Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C0CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013ED20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DGj+yWiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013ED20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeICTOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:14:01 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com ([40.107.7.122]:52396
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeICTOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylmQN3HDIUiaYXXBpDbwfUlrudst/flGrkXKNOkcRUU=;
 b=DGj+yWiD2fWDlA68SVcy0FetmUJ2H/MDxvdfCWNFk74erujYpcpRSQeD2F6uQt6Wq0Q08fIcrh2BEX8MTm06/SRFDbqEn3sPxVR1+VN7E8rZnPiuOwan6DI27DMqmFLk5+Yhjk9SORT2YXh/OMVQKcL+snFiw26ibZfrQpALvDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2017.eurprd08.prod.outlook.com (2603:10a6:203:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Mon, 3 Sep
 2018 14:53:22 +0000
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
To:     Jiri Benc <jbenc@redhat.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        nicolas.dichtel@6wind.com
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
 <20180829181303.4sacopk7y3p5xyou@gmail.com>
 <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
 <20180901013427.tj3t2mlik4t7hlt5@gmail.com>
 <2319a029-7aca-b7aa-2e8f-4dfdeedcb6df@virtuozzo.com>
 <20180903155020.6112f773@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5e6ff247-e6c0-a5ce-e9a2-4c0bb2daf790@virtuozzo.com>
Date:   Mon, 3 Sep 2018 17:53:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903155020.6112f773@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::27) To AM5PR0801MB2017.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e030e7d-b5b7-4259-1fbe-08d611acff76
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2017;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;3:L6coXxvyP7WeyW5zfHieia6Qb+tMIqOg4LXfDwR1T3Of+fwIOPjXt9ytKQ/mH0ydHbWBhKUDTfcoqmAYL0PwucPG8X4wwAOMgsGKgFrHJAckaYvfq560vmeLIPE48yapT3X5nHSlolAcCY+x+GjcZCq+IbrcNjIVDp78u1/vhdihyLB/Fb3bxU7Nf2esxuzs51GP4xYaVPbz2Dgwgq4pgoJelgy573Kuo0kEyDMSFO829333qzSrjD8XKLRHaC9t;25:cHtF7jNETnW16qcGMiOZQjJr3VUX9rUCLlL/MQnwe2iIrFYvfh1MLYNWEu1ScAFLRpEPNhbW80Y3VI4UCuUyOaenpiYw21mOFcQslyu2DYzF7wbJp029PyeLBcBZ9F9KJrLijNofaSu+yiklJ9n0pPmHnMkqYNfRgr+C1345BaMMVPvBqiw8Ih7de/LjW3nYlt1rjiDrFgAOiuFkObO1ePQPx+qUZ3Icc4bZkamQIyfWglY+jT8CSDF4P4GYjPPy2pXi6tl2ldaqWn75Ehe0CxFVPUxjkQR+D/OhzuobyOu+T4g4gM9jpILfZGOc7VyDL4SDQcK/tHjtNEjwVg6ZvA==;31:rV5fmTRbccPY/R7NqgN278UUYRvIrOwEMFZ4jVQTX9Q3OYouD2byD5QrQHgNi7TLylcPxVO3F4dwi9UwLFygVorTGLmq+rajI3aOXW3Kx/K2iuGnQeEYc+l3EW4Myj/H/UBjgDoTemkuOr0rRzpvKEn0Fs6iU71R7OCLF31liTt8pertd0KVlhjNkbsCatgAkaoNYH7l+EchjThT+N4LNFzL6mov9kLt4At56lHg+hE=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2017:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:eZYoy5hU1iNLb2Z/TEI+BRj/uMWzC2TUD0TIR9V7YjiRr4tnidSu39GmO2OwmjWgaNjOhKbQgcQNEsKW7EObNW8ZoKa9oSv9o+I2KoQVRWqSMyT2WF8LarqpngVZinXTb7EQ92u40W5/7niWgQPitsqs5kOfeANPTWPgnwNVxL/l9w9Jsqd/NKh7cBfyQrb3+OyAujjhcW5wFrmuUNMpex9CFxaZotiP+lk+fe3XXwkmNkJpXvMuLNk5w3gOQ82ri5HtecvbOE5jAIR5fexpq1MtoQ3d6odNaFQLSeirQsDY077Mtkcd2e6IwvQXjlZCjJ+8N1wjBj5jqmRFBaKuqMdtgqwEfWV7KzHo/euodhLT3v5jbnZBcWjy5mQ5lteBMlKvEB0mXQbBA8m9UeSHSCfX9xp4PGSAXGl5NwA6y6kkq38YMIqURfhDQ/oZ46j5nvaA519n9X/hnlKVlGk57KbXO5jcYe+8WwzNblXLS/Bbv9NtzvYYPronTJq3kmME;4:pee8eDKAf/FPdV+TTMLNE3SPUXdfJBJXtsodkuAk29W9brBG117qUhvx5xKE465vrdYqw4cMRLYIh2aI+4Qv0y68+aQmbrICTIsxXkKeU3b6x25zSzDJLwvusE69Xl7NMI4G8zXRaPmjxEWAM2jsgPVe9fouN9an/6mJzaMj11R1iIe61vPrYJ+5FTfpGNomBSabtKiabWq/JjvSBf1ZOPWypZvOKCtftv5iB5GOBOwCj7YjMfnXFmlHfydH+hQqJ5wl4mxALTxf7fZK/wnFaQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2017F56612CD88DB3B6AC3EFCD0C0@AM5PR0801MB2017.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:AM5PR0801MB2017;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2017;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39840400004)(376002)(366004)(136003)(396003)(189003)(199004)(478600001)(8936002)(4326008)(81166006)(36756003)(486006)(97736004)(64126003)(106356001)(7416002)(25786009)(229853002)(6666003)(6246003)(6916009)(68736007)(105586002)(16576012)(5660300001)(39060400002)(58126008)(65826007)(93886005)(6486002)(316002)(8676002)(47776003)(52116002)(52146003)(23676004)(2486003)(76176011)(65806001)(230700001)(31686004)(2906002)(66066001)(81156014)(7736002)(65956001)(305945005)(3846002)(6116002)(53546011)(476003)(16526019)(77096007)(2616005)(11346002)(186003)(86362001)(31696002)(26005)(446003)(50466002)(956004)(53936002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2017;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTc7MjM6Tnp1V2prNnQ1d25JaC9XVURDTkliQ0hE?=
 =?utf-8?B?bDVXcEhoRHFzUnR2cU1YUXg5a1RhVXdXOTEzR1o5WWNHbyt4TmFLaC9hYTIw?=
 =?utf-8?B?SGQrZlY4RlY5TDh5dm8xbFFDQ21QZHo2QWV4YS92NVllT1k5aFduYXpjRTBx?=
 =?utf-8?B?dnphV3RIQXFpUWF5dElwV25ERWtlbDB6SC9mYmxVY0lNM2RwTXJZWmREZmln?=
 =?utf-8?B?WTVEUlJPVHVrbytDMVhFZ0o0RXNhYzhaQlVQTFNIdGZlc1dCMHpMR25uZ2pO?=
 =?utf-8?B?WHFLY2hKakY0LzQxRkJuVnQwNGdGcDlBU1NrR0VPbFQ2cjFaU3hGT2J1YnM0?=
 =?utf-8?B?akpWTGQ2THlTSjNBd2lxOGdOUGV4eitsVVNVTTlGQm9zaWdldjR1WTRCOWx5?=
 =?utf-8?B?NW9xaGFxcS80bVpzSnVIM0p2a0xTL1dwNlRvR1hFWHNjOUlxNHBLSDh2dWww?=
 =?utf-8?B?SkQ0eXZKQ3RJaks5RlAxcmxxcGVVQ08vUFJwYWpmWjRKVzJHbE03NjkybGdo?=
 =?utf-8?B?c21uSHFRUzlYTjdOOGVDMC9WU1pwNWJSUnRDUUkyUnM1TFRwcm10c0tOZmlF?=
 =?utf-8?B?UjEzenpmUURjNmkzNjVJSkdoWll3TUlvbkZMbzFhTTZ4dUdWcmZJY2hZTURn?=
 =?utf-8?B?ZzcxRlZOc2Q2RlpmWm5JbmNtbUlnQUVQa1lDZ2Z6cTFhS1VHaDdRUTEzSzNw?=
 =?utf-8?B?TXFPeXljR0lJbGV4Mk1UZlh1dFAxaGdENklDOWxYTVdIYnFCWGFiekl5RG56?=
 =?utf-8?B?WGJ1QkxtVlJqalhnV05ERGVEWnNybjhhQm00cU1JUVR5R0o4aEYrQklEVlBC?=
 =?utf-8?B?Vkk1UDU5SkRqQjhHWTltdDJNaHcrY2pvTDNTVDMzNThiQXVQbDc3a3BsL2tw?=
 =?utf-8?B?Rnh4RTB3UnMxUUVXZDB4MHo3MnNsYWErM3dZQlRrakhHRmlwUzdtd1A1empT?=
 =?utf-8?B?SGd0RER3YWRRcHBDYlNWUWNyWjN3RVZTZE9VQXhXTjRmbWtkVDRhSEJ5eUJN?=
 =?utf-8?B?WXhRY3EzY3dUSjBvN3JwdHRVSHl5RGdmOVRZNE5IUUtOWGFDams2d3VsNXJD?=
 =?utf-8?B?Szcvck1hSCtPbFovd1RhYWVoUFRDWWFPeTI0TzVPMXpqNXVjNWtxZTNKblNa?=
 =?utf-8?B?SFFNVmxhV0FjSWJPZ2xNWG5scEpYdEUwdmNaaUpydHRsYWN2RG5veERIczFL?=
 =?utf-8?B?M2xjRjVlNEpRVTZIc0s5dDEyUXU0ZE8zVitjUWZKcXpNUzUzbU5nWS9sYk5j?=
 =?utf-8?B?UHVvYTVFZXF2Rkc5ZE41S3B2bEk1Znp0YlM4dGdLeUgzSkVLQzZBSGg0OUNK?=
 =?utf-8?B?eC80cFVPd0szeGplbkExZ2kwTjVDR2FyL2o1MnFNOHpLSThJYVI1d1psMEtz?=
 =?utf-8?B?MUJrMDdUUUp0cm1mRHZib1NpbFZFZWtzT1BnTGpsZkJTaHh6a0o1VTg1ME5Y?=
 =?utf-8?B?MXR0ZFAxSHU4dFNZWk5yVmtXVEZjbFErOHhIMnYva3hFUjR6MU1EM1AwZ292?=
 =?utf-8?B?RGg3d0NmcVRORmM2MEMvOElnbFBHNTFkRk1WcWRCaUhVODZWRStyUW0xR3Za?=
 =?utf-8?B?ajFLM1Y3bjhPV2pxOHVvQ3N5MFVxbXNuRlEwNzV5MGhwdXZOazBkRnZOWjRU?=
 =?utf-8?B?bmdjMlgvcDlZekhmMUxOd3h2UkhDcXgxRDdlMVkyQUlTQUVwencxQ3NSRitx?=
 =?utf-8?B?aEt0M0dsVTcwNkYzRFJac3J2Z0lsdXdoZmVGVm1MNC9zK3lLZHpUMXFBK0gv?=
 =?utf-8?B?SXZ0cWpnYjBSZEU0ckxHdlFYU05ZNGlCT0dvNUFkRThnVERnamhFdllOSVhR?=
 =?utf-8?B?Y1dRK0ZKcUZ4bEtnRUtyU3YwaDJDRC9hZGJhbWdCb3JxY2x3UW5pWEx3Vkpw?=
 =?utf-8?B?ajJYekRXeUkyNjFrUmVIZWRaQTE0MVNuUms4cktxQ2N5SjZpR2Y0WnQrcDV1?=
 =?utf-8?B?OU9sMzdYVmtib3QrbnV2eExzNzZYQUdjYkd5MlVWTE1wbU1xUUVjNWFHYW5P?=
 =?utf-8?Q?Jfgtniyu?=
X-Microsoft-Antispam-Message-Info: BOa50FixzjhP96w/kLvMlHOONbmqBKfmrzqp/GUXBNXyaCNixYXUruIJbUdl5crM4yzQZO4nz4HEpu1ySd2UOFxxJk6YqNXmt0rj6s3VI8xIwv4bHIZLsuqIBKF14HHfyPWLrbm8EzoiJM/W6Hy7CFhNoa/oBCEb7ky2hRCkKwY8POVYKtptN8by7wkLFm//PC5aWVeCALSk0fkgUiv+CzBpiLm/9HZIslTK26D7F+LuSmHdkchA/ucWpjbXhOMlzIuIuU74t+aegFj5/QlQQU7n6XE7sFm8QOdQA4RmOwuhFpClAkXYy4w+rPY27eugAVWLrGWqDT64F+nBmsSJ7vhlrUeXe93ZX9DIfsHRoM0=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;6:G67hyJBZ7WI81lMohZjESz2iki7FvlcsZ6Griio1Ep/18xSoHN3ycK8lsqtnjY2VlK0TK7g87FJe9AkM7vYpGAdmAYi3M5Q1kR4ZD4GjGNnPxwWD/nHpv1AFmRE5cbI+TU2vRAwmZW2H8FJLXGWFIG/fzxkCJtLPPQEHs8eWTcvAIVi4+Ve7oItZ8IXXUNgriDIbxkS5tbOEkQOZSOINMlhPn7Hp2HGQjrLY5mT2e4HkewgScVDFw255tzjpx6++Am1PEil9Guo1t4GtarK9qjrucF3fMZXoCohsI7qH54m9ru5cqh00C+eBsfdWRjHu/4TRzCe6y1OfpWBkr76/i/tzgLbJtDyu+WU8Jku2uITDomBWMrpvx7L+cUCq+l0AH1Bv0NV6bhaUZu0TWVqew1G21cRKUFkiWmYhqZMSYSLfO8TW/fP1ROhmk7qO/A6nf9Y4S+ROPJvg5fqCFh1Bhg==;5:UpW+4ZUN4tN4xzIj3o1hl960aCkrJjvrmRsVdzpyPLVI/Jj3qVEmmt0iFyXHzVVbiUJmBnLrsLk7Hw1JzW2ioAv7lLeUeBcbeLtZraJCgGyBYhY0GpOZ1rEau3I7SpCbstBj8vRz3oXwc2rsluY6odYpm/xXDrC8QS9oyyNwZS8=;7:mjOthOXq5+BEV4l9XyENR6sTN+65rJZjcQm+t8eMw+8LCiu8JfRhhGOMyri1hyW7uZBYhsNE1bbP9Odvm/wunxBOj0hYqmsl9CIPsMpVJ6TncDv1DRwp6ShQLMr+iJyvGc1Qs1OuNp3S8R/06njx26l2XxnPSxkaAzZ6Yo+VFjagFGhHTnlXlzJOVUd5GlGQRFa5wFSKZUdAnrcekHUEvTWpCMcfjgq44dZnqQ2ulqjNUaFX0iu1aK3ahBDt2Wxb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:qJgmYeWMSlcUCer02ridQx/ypXa1yoz/gDXB/QKI5ahWwMI4RNUHyO9L682qqZg2hiFbdeMXGCjopcN3XIyglDpC6tTaKCbveinq8AO5exM+aFqLwd6rBn5W8RXBKuoXAy9719LMyKRa/QVHrJWQPJ7hqrBZmX1+lsXJn1CN83E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 14:53:22.3889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e030e7d-b5b7-4259-1fbe-08d611acff76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.2018 16:50, Jiri Benc wrote:
> On Mon, 3 Sep 2018 16:41:45 +0300, Kirill Tkhai wrote:
>> But this is a synthetic test, while I asked about real workflow.
>> Is this real problem for lxd, and there is observed performance
>> decrease?
> 
> It's actually not as much a performance problem but rather the only way
> to get the data in some situations. Namely, when you have only netnsid.
> This happens e.g. when you want to query a veth peer in another netns.
> 
> setns() requires a file descriptor which you don't have. Nor there is
> a way to convert netnsid to a fd.
> 
> While developing the IFLA_IF_NETNSID patch, I was first thinking about
> implementing an API doing the conversion. The problem is there's no
> good place to put this into. It can't be done over netlink: netlink is
> unreliable and you can't have the kernel open a fd for you and lose it.
> There's no ioctl to use. So we'd be left with a procfs/sysfs or a
> syscall.
> 
> Using netnsid to refer to the target netns seems to be a nice solution -
> after all, netnsid is the identifier to use in netlink.

Ok, I have no objections, just mentioning that generic problem.

Thanks,
Kirill
