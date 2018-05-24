Return-Path: <prvs=8682a3dd10=ast@fb.com>
X-Google-Smtp-Source: AB8JxZqe+UTUFGP74zEaPKk3n6lvlHKzH4pM7CMuCcrEO2Fw89gRk6P4xOWDOX1jOZDBm/GEiyqp
ARC-Seal: i=1; a=rsa-sha256; t=1527127788; cv=none;
        d=google.com; s=arc-20160816;
        b=tM3bbJfi6IwY0JKaUdkKo0gBCVDmL1S0KcTgmzmIKvI5w93J6aqqDFko64rmBvk30s
         3qsmXCMlSUVp5javZ23wyf5qBI+pLy5GKSdCoLdN+8msRsHCa7GC91rA+MWqBiqfiLO6
         TUF53A/kpMaB+7ebdn9S40Eald2VW3n9WeAmFe++LW2wievqObn3yB/xPYnD/RdG71ZX
         yBJzmGp0FOD9CFFenmHFfLlTJ/ymLzjs+v05QC9GQKS3pZ8GnGjQwbP5yILvofilVUfA
         vBlXeozIMB30eNVhnSyZfm4vXSVyO2zoOtzqG4eQqp6sYgtFE+QEKiCCWp0KoZ550Q/u
         GEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=nEUKeqQmNd6Ffcf7knFTcIaC9MnV5jjPQE7HTejv/jo=;
        b=a7pgq8vxYexjJ8b2WbNtXIccKXinnj6j0+8/CiJK1dYHqdKBpy9yzqg7/bghU8X0IN
         YSSrVSy53/2clpIGgmgRLFw95oS3gmO0ooyZ8eMaE7d34oSfVbKxM1gtsDCKt+BDCTTB
         QdTbDSqNsXh1eQ9Whbg4LbUb3Cj7heHXUUPhCAj/rbAAiXJMwG5xWIgfZHEBdTmaa3ET
         /Kkomai3W1gIG7veSHE/vWh3Oj2K3wa8ZSFlLUGqwRV3kIJeOti3oNc6m8Q1Lim0+2+l
         EfaSHEFbOM/kd1V8AIYoAwoVno/wZl+ymyLUkvreH122Xf/NZ/XN9sN71BG1Y/lGwqde
         Zhig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=OVcNm9wn;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=Ejz3wRSV;
       spf=pass (google.com: domain of prvs=8682a3dd10=ast@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=8682a3dd10=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=OVcNm9wn;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=Ejz3wRSV;
       spf=pass (google.com: domain of prvs=8682a3dd10=ast@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=8682a3dd10=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH v3 net-next 0/2] bpfilter
To: Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov
	<ast@kernel.org>
References: <20180522022230.2492505-1-ast@kernel.org>
 <20180523183352.7ccc3f5d@cakuba> <20180523185010.0490e7ec@cakuba>
CC: "David S . Miller" <davem@davemloft.net>, <daniel@iogearbox.net>,
        <torvalds@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <luto@amacapital.net>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <1e3dfb35-c092-f873-8279-6bf54ebe41ac@fb.com>
Date: Wed, 23 May 2018 19:09:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180523185010.0490e7ec@cakuba>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:180::1:727]
X-ClientProxiedBy: MWHPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:300:4b::25) To BN7PR15MB2500.namprd15.prod.outlook.com
 (2603:10b6:406:87::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2500;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;3:sg0aC5c+0ggy732l9Aza44L5WYEbqWivrG7G6NtFjeKYoIStXIoXlKXUeswVp8mWQQuItFlTnOTE8ZolSV8nneCvLNO5DWEtwghla3Zx3JCdQrbZPsSrUwQPNgCY6q58qpKWKHmMWr0AMZXxp33ltugaLjxMU3w1BreL5xJpz9PzN/omC7ehUM+dW4LbIX1JB8RYUAJKzPojDH1V86wP/dJboK+v/j/TkmfFOkdF9OFmLSpA6ivFIshMvv7XCJQB;25:PmFCTZ4w32vB9DyWCnuNfq9z+eyCXjsufvm04x9nT9dwfQSaz1qlKn4HRNbdntTXcA0PYSih+UFE02kPQxImdF85IMGQrXf3ywAtFhtMU8Cx3QrUOUwP0PPLjFgCMesCmulVY7pP6BYiQfwWuaH5c70G+RcHB+35c5XKhNFe3EiWmTrMKT/yab5QtpNqPaUomExzf8tLY0Jebi3aGTRH3R4ccWNpe5cu8eelkJkKg3qKltYLxL8iAkELVSnLwmBuV9cQ7MWLHVobwFkZvaL9vM7w7CPbRxOMUjSkqIxJ+6aZ1zIlIO56+ZkfMJNO/0o6M2wIeLu2tlNlh6GbpDHNJw==;31:zpvUG/b36QHbUXtcFnrMXHLWO2IO6WDB0EMMuVEiFfYoowRCGVcaNVq5rBUmSp3hmlXTWDo2LBBhDbYdDVWbyEOQHLb9HI2HT4tVrx7IDp29sZYVpQGivWb/uIRMimrg0plMNEcrT/DvRIVtpIg8m7wyPYbpYVkWUFq/QlwijsjIJM11n5EHYlW5HUOopwz/GvV5Z/uo38gHYpGu9MwduakfjSvKn6+eCVsgZNVVwXY=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2500:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;20:6nR50QUJBU0Sdei0F3065A+t1ld/55o6J2JPD4TxqQzrCCntHCRAM+YKStNVd4+pRrb3v0UNLuRmJldet7ldGPzsFg50qU5rEdf0iEewKQwvhpXa7jTbAYh+QzNCnS1wnudDFEF4aOtht3tlPmQyW/cTi420avn5WVWpJLtFYxymRbIgb+yUeiNqBJTlM/snaUCI+y2gNTxWA74eXGwk28SnCtd0GGe6hI+8r1tfb20c72FnKfuxQHHR4Vu1L1Qx5NHLjcaFuQPGpFqf0ziVn2m5DR9XPXxi/E3wcLWFhyrvP+IgQPBTR80OdlShkNkT5jUxV+kamzE2aWRbUR8XayovKhKct+6NRPAKkvy3Dbz+Q8jEyOYAWvOR/f9qyKtWEamwqV8tZ5CcP/O2PAp1LoP2yFaNRuOOwhd/uAbQjq5JI51pDWOa48+BNfDhXX0+IY/u4qbmu9XmmX4NgzKlvOkxZwqf064onCk8arlzSkkeUcYKSmhKDPenBfOCu4Xf;4:nJG4+y+tLZMAfykL4YAQATSDBh+Xpf5LAnAGRat0icygcXnlwlO1RkSihe3JnkaFVKaf1e6GU+iD07kIeZH/dNCcI0VNTtNAG0PzRa+gA/EiHWlnY5kRhhL4S7GyqvzIFH9+l9qO2WEH+xeWisNLsWj4NZAWIJ2t/7o2xTfl7L7AEOyZteqoTqRve+MP63hmLRY+7+qnofRn4fOmkOfqaNuuuZ42pWxrzGdDaIhsZ0xXCPBXiKpWA7Ze98CnWW5iLZPoh02kAkzND2a5Bbgnpw==
X-Microsoft-Antispam-PRVS: <BN7PR15MB25002CB877FDE88077C4BA44D76A0@BN7PR15MB2500.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2500;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2500;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(39380400002)(376002)(366004)(396003)(199004)(189003)(81156014)(76176011)(31696002)(65826007)(8936002)(52116002)(53936002)(106356001)(31686004)(229853002)(97736004)(36756003)(6486002)(2906002)(59450400001)(53546011)(6666003)(7736002)(7416002)(305945005)(11346002)(81166006)(486006)(23676004)(52396003)(2486003)(8676002)(386003)(2616005)(64126003)(1706002)(5660300001)(50466002)(52146003)(446003)(86362001)(6116002)(476003)(6246003)(65956001)(25786009)(47776003)(65806001)(46003)(2870700001)(58126008)(68736007)(67846002)(39060400002)(4326008)(105586002)(16526019)(316002)(110136005)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2500;H:[IPv6:2620:10d:c081:1132::10cf];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjE1TUIyNTAwOzIzOklOelVEMGozNkVPeldEdzVtbjFmMk52Umll?=
 =?utf-8?B?dDE1VG5CbGd1bWxjN1dDdXczUFNKVi91T1Z5bmZWcTVvRjFDZWdqM2J4OHhQ?=
 =?utf-8?B?UEhEREVrZlNCRkVBWmFMRUpCZEttN1IwVzZyam9yN3Y0ZkdFSmhZdTg4U0dv?=
 =?utf-8?B?dDFCaEY0M3BYWlBDMG02UlFDa2xXaTU2Y2ZiMmtPSUxmaWZJYnJuT0pEb0RZ?=
 =?utf-8?B?TVNqOFprOGNmU0FOSEFMTlVJV3pjNFpWeEI0K2hNaVNFOWUwS0VZVFlTYTBz?=
 =?utf-8?B?b1J3T0JpM2RQRkRCN3h1L1BCZzkxOUVEK3JDS0JQTW83SWRNMEV6TFpiaHNF?=
 =?utf-8?B?TkhNMTVucDR3NU5xQUlLWkxjem94M0RTazRMOXd5azNwbi9MTDN6aGRIWkh3?=
 =?utf-8?B?NW8yRy9OQWVCSi9xTEFNL0V3QXRseWQ4NWVVVFVLQ3YzM1NsS0lUTUY2d2lX?=
 =?utf-8?B?NnhBRDBXZUVBcFJaalFOY2gybWlMVUZTWjBHT0lnN1pCZTdpOUlPYis0TkQ2?=
 =?utf-8?B?UjhlMGlmbzIxQlZQWEp5VmNsMmtKL3R1Y2t4QjNCZ1kxM3REQ1VhajVLUmZl?=
 =?utf-8?B?eit6Y0xXU0NRM1h5QUhYNUhKeWFjeFBEL0kyOFdWSGxpdGRjWXpTanVkWTRr?=
 =?utf-8?B?b2duMmVFTnpQZjBMaEJoU3luTHRpS0c3Y3JvMytiY2J3aGZxeWhxcFZ6cE9k?=
 =?utf-8?B?V1JVVjRPWThob0lrdUNVVXBRcmZDa1pwSWVHODhkWjZqekpSbER0SEVjZ245?=
 =?utf-8?B?WldHK0hXYVZNM1NFcjhZV2RpWUpjeGVqL3Jwb3hqZ1pWSDdTcVJWdjluemFa?=
 =?utf-8?B?bGdUcnFhVWdzQkJ1eU5RR3MwNmUvc0E2RVR5Nm9TelUyMHJGSGtNSDg0RG00?=
 =?utf-8?B?eVk2NERVZHd2dFpmMVA3cDNrVys0Q1ZrUFRJM2MrK2hOVzNxV2pqeERqWTZh?=
 =?utf-8?B?aU9OcS9hSnRYR0VKUDF2UzRVYXhrOGltUUV2WXI4YW1ocUc3SExRZXJYblpV?=
 =?utf-8?B?WDF3WTVqMFVQK2VwNTZHWVh4UmJ1ZWV4eG9pS1FKWWxLK1ZId1ZGbnJ0cGc0?=
 =?utf-8?B?a210TWEzTG1jeTU5ejRKaXB0c3NyY0t3TWF4N1JnUGd1MjVwNmtEeXRaL2Zh?=
 =?utf-8?B?cE1pRSt3NEhxeXdDazFnUnBBT2lIeEFSTkloWk1hOElMeXNGcTl1Y3VGSjlX?=
 =?utf-8?B?Z3ovNlBOZFN6WkxSbVllOUFsZGZhWFEzc2ZheUFPVk1MU1Zyd1pHR0dFaG9H?=
 =?utf-8?B?SW4rKzBsWkpYRUJBcVI3amhBVzRDUFZoN215SzVVc0huZFNnc0JrY0YzNXkw?=
 =?utf-8?B?dE1Yc0xoVEkvRWdudHdKRnYvVlZuUkcwbHdhUzhaKzRYak81RXhqc3RBRWE3?=
 =?utf-8?B?TkdWcCs5UEpoNWpUNHJjNktaZmZ3ZW8vZXQwOWVrdkljcUk3REpUUGp6cjlR?=
 =?utf-8?B?MDJiajFrZlFQaTJRTWpPUHl1NUZDN2hSK2pnK3BOY1pxb0NLVkt4bC9WVnk3?=
 =?utf-8?B?aGxwQitLYWVSTExhN0ZxZWpQR3hEcGh1eDZ2RDVVNCtmQzAza0RJSTk1WmRw?=
 =?utf-8?B?ajVBU3JXV2Vvc3ptQWJ2ekk3azlZWGhJelg2WGhTRU1YTHhsUkZWWnNJMnJO?=
 =?utf-8?B?My9tL3ptZGNiRUdCbWpVUkEyeS85UjliMUxwYTFmL0U2OEw5ZzNtS1BxYlFm?=
 =?utf-8?B?Y05Ec1ZOK3VGa3piZEhBTFZkcGNJOUNwcFZoRVJNdUVWY20rMG5ibGEwU2Er?=
 =?utf-8?B?V2hmSEpTeThCSXNOOHY1d05FQWt2TGthVEY4YUE1U2VUcmlmNGtiVkVqMHpW?=
 =?utf-8?B?c0dycFljMm5uZ29RM0tSSWZwL3ByUWdKcXl5SzhwU1F4dWUvNzA5c1ZtbHFF?=
 =?utf-8?B?ZUh6NTh6U3BFS0NpcjJvcHJWNkxtZ1htanFybDNKTVNyVnVKdHNlSTJ1VWxl?=
 =?utf-8?Q?GQdTBkv+F2b9j59Tns5W1CuHVwfaLI=3D?=
X-Microsoft-Antispam-Message-Info: LDrwS9HCV3hGGaZxWiwnoTOsfA8CAv6q5cIq7hzS7mCW9IQWXIq4aBJsJvLPYJmxminaK4pzmWgzDMTB6alN8tBHv5B2O62Uur0GQbJKWwvfRWQ+GHFEzDtf6kRjr0Yu3l6eaAVJgCWMTxP5Qfplg7w9xHX7aL4umKImQhJBZ6YFVJiYFUnFEwJMiIQtW2VI
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;6:bHZzkpu1s3s4GSaKaYlzVIbJ6CVIVDX8e9RstmqUxnNEYKd4eQrCE5pars/jMSPI37hq5ptdwg1I8F3VO7r1J+Gb0zs66H0ro0nhBhIWx1wy5MyYRs7fXGGhV8LSmMO4CC8ZNttS8JG2p1M9KhUB/fjqbh//epYYsIuBGBgM/XAfVESb3nBohi9if3LQJqW68/QBK9aa+bg/26Gosc2P0kzQKJ/VkdKigKCKtzIRjFpaUnkouLMO9wBVRlS8DwJ6jzNcjXTsBenUz4sBxdyliG7pdgUuYuCQn6lMuoMfvcXa+qg+odLcENg77CKPzCIZjQrXyacfZWQvCJm3dAkWcBnKorvYteGhbEr1jt/pBBbjYAxB07R/pc3Qt3IkUf23KhAH37lD6VigtLESZhs6N3TB+WzPlDOLRj6hIkw5JZLJk78PxCDLyds+EayeVDVrOvdXBOUgSGfjDDlHucrPlQ==;5:pMQEbmwoNh8nEaUGuoIgWdN8+6h3aXibfYzP23aWCXHE6EiCFdxEkA4XU1X8DJ72/VxIB29XLOqFnHb4as1twJTnH7nUUxS3OwnlM20F1f0fCIiP3kn9T7rvKTvotKn7dlKV2z0ambkNosPRKdJv5dEZpvwheiMx95u1t5G/40A=;24:ZZbdyHKyx4PVI3D6tlqtHbwicuyqGN/LxWyuG6B38DEXe2HuWcN/Oj9NsOWfQv+ICCtAZeYUkgF81O4jJDhTDjYZjQ4HUQ2v9AGJMxoajDo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;7:2BLeQoSzy2G3aSodF7tCq0sdQntg1BhxJe4kQiTGNGi4rsiGZlBtT6Kdf/fwgwvV/ytX627AkvKYhGTwptn/ooOoleLwDBlkegFm7lh8vDhVRakIF14EQ1eeQL1UM6G6kh6OhBkKMLU4yAZTCMZh0pom/1/bNPLHTJbUjZ1TSLD4HTJvouOVS9Vu5/uGNCle83X/XI0X8kfPsgY8zX/hS8/6X3JAH7ksehZJB2T/DoIdFm4cznD3rVKZgdhK88rX;20:acwKJ7Vhao56VuRmfslNFiOzqrk2NHBTrbNPcg+Y+avMA17YIcU4JN1BvKik7xtChj5NfeIOwiFQ5A2jrOnt2gOsV1HfG7bUfVxZR1DVpWOqFp+/PCe7DkrqvfNosrpQT2vP+HlHx6f8dkJsJ82fntSw4n9PF47r5RtdFvOeHAg=
X-MS-Office365-Filtering-Correlation-Id: e3d8c44e-1669-407e-6dac-08d5c11b59d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 02:09:14.0377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d8c44e-1669-407e-6dac-08d5c11b59d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2500
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601129157450149170?=
X-GMAIL-MSGID: =?utf-8?q?1601309548488772192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/23/18 6:50 PM, Jakub Kicinski wrote:
> On Wed, 23 May 2018 18:33:52 -0700, Jakub Kicinski wrote:
>> Minor glitch with Ubuntu 18.04:
>>
>> $ gcc --version
>> gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>>
>> In file included from /usr/include/fcntl.h:290:0,
>>                  from ../net/bpfilter/main.c:7:
>> In function ‘open’,
>>     inlined from ‘main’ at ../net/bpfilter/main.c:58:13:
>> /usr/include/x86_64-linux-gnu/bits/fcntl2.h:50:4: error: call to ‘__open_missing_mode’ declared with attribute error: open with O_CREAT or O_TMPFILE in second argument needs 3 arguments
>>     __open_missing_mode ();
>>     ^~~~~~~~~~~~~~~~~~~~~~
>> scripts/Makefile.host:107: recipe for target 'net/bpfilter/main.o' failed
>> make[3]: *** [net/bpfilter/main.o] Error 1
>>
>> I can't repro on Fedora 27 gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5),
>> perhaps the GCC is broken on that Ubuntu 18.04 box of mine.  The warning/
>> /error, however, looks potentially legit?
>
> More?
>
> Kernel: arch/x86/boot/bzImage is ready  (#9)
>   Building modules, stage 2.
>   MODPOST 1620 modules
> ERROR: "bpfilter_process_sockopt" [net/bpfilter/bpfilter.ko] undefined!
> ../scripts/Makefile.modpost:92: recipe for target '__modpost' failed

hmm. how come buildbot didn't yell at me for any of these things.
will take a look soon.
