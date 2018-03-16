Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELsNUZpTfOk1fkYlZn9nUjA95EEU7qgUaxwUqGuWY4Eo7RR3xHVVMwfIBqOdJsMHcSrW7RkO
ARC-Seal: i=1; a=rsa-sha256; t=1521231282; cv=none;
        d=google.com; s=arc-20160816;
        b=LqrLktWG7RyGJcTV9GM2SPPPYFPuRLnwi6FcRFRknlKSVS+THZZej5Fi/vtLvPlMhr
         K21NbLXMgPgbnhWDzcY0Ek91npxb/UqCnVUzshhbO/UzDpfW8e7Sy+funBRr1PNQkk9A
         rgpHD79H+2Yl819FPg0ZRs6lap75OoASKt7qiJWI9oKEyWnICeM5aTBOOeNXE+dGNlLv
         zoNf1vLy9aj1yrdJIrLO3WoC1JcGU+BZM4wlUO0BPrRtso1R/UYV0dhQlShjjz7LtzA3
         i890CWi81mWF5TSKmXxuotWSihYobLbX2+F4Eojl5srQ84+rqnZf8kHo4FkpF/kFAvA2
         KXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=DzpH3JrnoSnXbddTXPQE4EIJfaDsxKkLXKHvsht4qgY=;
        b=PZ+LbaN02JGVXxHesUBJqPTe24XUH2LI9zEKEPzuJ9ZvfiIcc11D6p+n/Pk1hIYQN2
         /njNcc2U8fyIyBmYZpOnqx+sqmOYHApqWUBDop+0IdrqkMOTzFRDIepmfbPktUG6aEZ1
         Lr43Uk3olewCB8Awt4t9ZEb7uwHiXOsZSzdSP1N8pG1siwpJQANnNQonkDwUlr4wFlyS
         FGj/QYXdakuXo2vAoynZH1yUZlKEQ0VsVaSiCDcMsJKZoYK9gBVAQCNpqQiC3h0yVYG7
         agxIfntLNQi/xB5IFaz49xBpmTkRfCkG0rSfdDTLxrB9Gg9JiOWoKVVb1Lmm+hxMUykO
         vmoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gJAAJVQn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gJAAJVQn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2] netns: send uevent messages
To: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: serge@hallyn.com, avagin@virtuozzo.com
References: <20180316125030.23624-1-christian.brauner@ubuntu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <dd58d637-bb05-ff82-9471-b4163340d472@virtuozzo.com>
Date: Fri, 16 Mar 2018 23:14:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180316125030.23624-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: VI1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::16) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ff5c92-4afb-4e25-7210-08d58b7a8bb5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:ucMQx+FpPvwncVMlUgb2NPOCnE1EJBwFlXwO59bwaJGvt5Dudnim+bAJN10SpNdr72ok1gK/TIRq4U5NJIV0/s9FtPuv64DsuHsiDdOMbdX3A5LhfXsrPCuZt2NSv63jDmMObFP6d1PUmQ4YV9Q8+6iyV5GdbR/3+kU5spn697i2dRggmgBCLSnqYNwEsKKNcgiRj8y/fs/srnADqVxvdBDxeD82RoCUDzJtqvapJTrdXCxer4DKznS1s0jtzoLu;25:620aGszzaLFIWfDK5pL+pjEGrk5kfleRa223fPB64RXaA9M91Ww3LbrtZEXsotDJaKQUoggPHXOCN4ifWIxWJ9m3J0k/pM5FDiBdVGc9YYYVMdoaNaV3R5zUg0jsrat5GdUZHuFpLg750I1dESfFdsIUUZkk8OSs1k3v5VaKYhKk9eYsa2hQ/XA9co2rnZm/DBa1MJoSh5hz9Adyzkt3S/H0aoHZAFqzfbZKAeS/cTmLx5tJP3aI6zKBeyK6E3nMHIdnH2+VMtDitudVQkAHDcayHzZdasMHePC7yM6BhLBoNfbW4vIrUfZYkoefTcY0fwSR7EXUTD2zw1SSpPgc8A==;31:wxfcvA1Ipyc5v59agZWKfrKexwptPiSUVVTUApj/U9fYt8pohsjxjFsNBu7VXTFT5iWjmAtc7HLf8VXNAYY/yVhZT1Nsaok0MujwjPRIKp3GGB1GWOv4je4aPVHcbGVavGaOY1GZW5WDhxIjXLgnGIR6AY/U7t9gCzyhMLvGAKMhBY4bqlK8ueecGqZvo1hIzJc0g8X3zM/yg1QSOdzpy6rLC14DfWbwrzq6OZVphA0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:mrJZOZ36AtRi9iMaO4PScN/tKk76HZ2f6fAm0s18d+boLibfHL4WwEb8ao/QPS233YaTNr6VZv96C8tvXZ0aapOhOC5lGygW8Z48kUk1zy6sjyOGXBxZOHp8EKoXnQ7dH8WuffpA3Y4Dl4F1Y73fKlK3nBi8L8spqsCiObajRtYl/0Q3qPFwlvNE4+eWpftFEM9Ho2AYX6SFKd0N/cIKM+q+e1xjHEJUE7uzb9fUL3yy2tbQJAH1bCCWR39BgulB5tNCNwl3coWNec8iEn55w2390/sDeYDeS3GvtTjHocN8j2Y9Fj9+0c3lib0NKJW9BYJe5i5z44WCi9Iupr1cRxVN3RkcaEhl6rX2/ZKiETcfDN1kzqsuGKQdNwAsdwrJWOhUcYqBncN6RuC4jzCa4D50zzqpk7kiJhAK84K1TKPYxtg9QQY5Ha2RteTtyTFi8/pT3DxgQ7BjYtFMPt+QSZEBNB7WdH/spPDLt67He9ZuKdphfggIWm3PLYBdMPq9;4:CFGEajLm1mxvClMyFXgKV1DF1n+PMqbs2V2OZKCCvL/T+KCoV+FOYR4A8wS3bJhW2amfSuTzfuKwqBAgJzGW15FMKoELju03ErLab3PB5daeSPde3gNT5oAUy7sKVPFTbu443zl8fpaALK2+9CJ4pzTIDW7STok1/KUs+3uEyFKpRmQ6cK5INQ+1zP/xNHfLsR/OwiPhW33UwC3WDJc9PK1EgZRKgyH+keAAIlfBAbqR6HQUW4Mz1NguKW8b1OQuwtwJs+H7Ldj2AOrYQFONh2jNug029lJQ9NAdnDRpyqwcToNieoEu9NAwDalCYlKgqSE71sDp0I2mkuAzkOmRGjzp08cNBwfhSB1iE3OcK+cEA58f2UnFQvaFCuwZ5550
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133867971455A6CA55BEB88BCDD70@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(788757137089)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(346002)(39380400002)(396003)(376002)(366004)(39850400004)(199004)(189003)(54534003)(43544003)(59450400001)(229853002)(8936002)(81156014)(86362001)(8676002)(305945005)(26005)(316002)(16526019)(7736002)(386003)(53936002)(53546011)(6506007)(6512007)(2950100002)(6666003)(107886003)(50466002)(4326008)(58126008)(6246003)(2906002)(6486002)(81166006)(105586002)(6116002)(25786009)(97736004)(3846002)(31686004)(65956001)(65806001)(66066001)(106356001)(31696002)(47776003)(5660300001)(64126003)(52116002)(478600001)(76176011)(23676004)(52146003)(2486003)(36756003)(68736007)(230700001)(15650500001)(65826007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6T1ZxSFgxUXdaL1E0WVkvMGs3YXZjcEpP?=
 =?utf-8?B?VHl3MGdjZDJrZmpWRzN2YWNzYm9vdEs3MmJ3VnUxZHlKZVJKYzI4TUVMNkkv?=
 =?utf-8?B?ZVE5SmFHdnFVbGlxN1FZU04xblB0QWdjbW5Ea092a3hMdHRJSFY0aWhZMUg5?=
 =?utf-8?B?QmFNMUZmMmwxSFFENFp4TVI1K1JwYkVtTE1hUTNCS3Q2TzdTMFBpWEhGdTdZ?=
 =?utf-8?B?eUxTY0N2cDZ0b2YzMmNvaGpYNHNRMStpZkQ2Y21SVnR0WURZMkQ4NGo4dFA5?=
 =?utf-8?B?ekhlaUYxZHlKV2F3WlVKZXVNaVIwY2VrSzFzUDJsTFYrRWUxbjYzQ21JalFM?=
 =?utf-8?B?QzdMdGkyaStxQWZEWGIrbUxEQzhpLzRZSk9WYUVKRmpTQm9yWG0vRy9ScnBp?=
 =?utf-8?B?SVNCN25Vc2dOcm1EUUEwQUZWeHdINFBhS1NReVJSYXc2YnRXUmtnS09hd0sw?=
 =?utf-8?B?dDBFby96S3RyeXJxMGxSWkMzTHNKUkkvOE5sdHE1eDRzR2g0TmFxYTJMQ3g0?=
 =?utf-8?B?Um9FK1FxcGNmUTNva29kT3hoMHlvZWl1NVc4eE1UaWd0bGFCMXZvY3JFcmZV?=
 =?utf-8?B?TzQzazExaEJoU0ZoUDNlK1B5Q09GNU40Q1VEMHRINjdMbzJHVm1RVHJCdVNM?=
 =?utf-8?B?SHBsNWF1aGNvcUdvc2ZtcjZ2NUVMMVNiQlhJM1FMMVl2UVVBdjVtTXY3Q1VG?=
 =?utf-8?B?MU0vcUprUkRiUXZsckorT2Q1ZEsyc1dQN1FuWTkzdE8rSzBoTWdoYi9ucTNF?=
 =?utf-8?B?a0lxUmRZYkFzLzlUczVGUThlc0NibnZrTU10MVFmbGw0RW5mbk41M1Iyams4?=
 =?utf-8?B?bmlJSXp5U2pha1E0ZHA1bVdZeS9KMTlqWkxha25yUCtmTTU3YXRjN0s5SEx4?=
 =?utf-8?B?YWszOFJNdW9rSDlzVkVYYWU2YUpRcWJ2OWEwSW9XRTVXQ0lJUnpjem9OVGNv?=
 =?utf-8?B?WHlMY2I0dGVsbjZnNDRadFQ2YXVNbTNxcDJ1cTA0ZThmempvOWo0RkdDdGlK?=
 =?utf-8?B?VDhXeE1yQXpBS0ZSTExpVWlBTTJaT2c5THp3WWdFOE44TGlzdFJqQU5ScWox?=
 =?utf-8?B?Uyt4SlRSdURFKzNCU1I1a3F5ekV5WU0yR1BiNVRmTVN2RlhOQWVSWGVkQU12?=
 =?utf-8?B?TEtmcEY1UnRWS0t2Zi9RVVNBL3FESDI2ai9GbUJJakliVUhiUEdsUmdMMjRq?=
 =?utf-8?B?L2ZMYmoyZFgxZHFhZHdTM05CV29BdjdtTkc0clBMbi9qdWtseC90aE90aFcx?=
 =?utf-8?B?SHNHRVFQZHZJbGlvenJHNHMwUTNuOENvWjNvV1NKWi95K0o3YnZjQlMrTGY0?=
 =?utf-8?B?Z1o3Z0JiVGY1UVBjZHhEOHJaaUVxdG5jOVIwZXlWT1F6UDU1V3c5cWkrZEFx?=
 =?utf-8?B?MGFXV2NGYmxSd1ptS05HV2NJdTN4Vkc0b0lVUjVDU0Y4c21aT3JWV2ZxKzEx?=
 =?utf-8?B?OUxGYVFBRW53d3M5dkhnQ1c0Vy84UHBuZ3cvbmV1VVZnRXJuckptQkRLMW1Z?=
 =?utf-8?B?a01oMDdTeUI0RDVMMUNTa2lSZWx4cmpKU3JJNVdPQXlvWmh0eXlDY3pNV3BV?=
 =?utf-8?B?U1BuWDI0UVFxcVpsKzhBeW94UU80MWxJYUJLRGNHS3Jrd2svWjk5NTMwazBD?=
 =?utf-8?B?blhqYU44N3d1cXMwM0k0S3JGNmxHOGZYMytTbm1wVXBEbkp0OEo4TU5NU2hF?=
 =?utf-8?B?eGhWT2ZTNCtzQWZ6MDhxaXBhaWxMU3hpNFlrY2o4YnZjcnFSQjJjeTI1NldJ?=
 =?utf-8?B?UW5IUXR3SHdSbUFuZG0wbGZOZDBBaktzNi85WEFXSm1uQlFrRmlQdGl3TmN0?=
 =?utf-8?B?MnhTc09MTzlwQkJYbW1TcnFJakRCR2ppZTB5VjkrbG1vQld6MHo2STFFZXNR?=
 =?utf-8?B?OFRwa3Z4cmNjcEdkV0x3ZVY5b0N4NE9tbUFHbWUzTS9VOHhEdXpqMlhkTTMy?=
 =?utf-8?B?N1BpYUFZeXRtS0w3Z29GZEdteloyQ0Z6QW9nQXJaaHRpQzd1SzAwNTJ5L0dM?=
 =?utf-8?B?WmpUNnVXQVZhUThydGl1M3UvSTJUNkpveElXZUY1MHBUZVRNR3lPVXFKdXZG?=
 =?utf-8?Q?ldwBY4=3D?=
X-Microsoft-Antispam-Message-Info: 4//F2rObwQQysoBdRMGVoSXXb3d37771Ln6PFoXox97TLj6KggMJhee9WsZ0uv365UpHxuwmIactwxEVl0OqWU4dJnPD1PpxQo9fodvITLfmkFaadhflcpNxI1ywiSuehJzPZnoE59IJ5DQg1d1W7g9Hx8afofZHmRDGxKeANp0VxY5LYrKI93g0mgtSoyOG
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:f9fqtWO4aSpmyM6Ruvgv1sGjvEHNYg0GsiZeGGawol1oyqmI1izI7DTFsCyQLt6APOWFGBfabyFp+IC6eBjqngnQJnAPZueGKJhXGn6bUeUpuFveFYorYqN8xekx6B87MYcRuLOc4lwlpz6gsXa7+8Z0/TgZpq1+BXniA6m75CXTkVtW5C4iGo5PiDb098JYGm3KdA9iX69P6d30LHJgv2VIMpUkkPuzfiIaRm+Bf6R+gvTuoXp6LTIu43bBvuDmshIgx8nXfimEJn9ez0sPhmHq6NFsd3lc/2cvi4F/imN63f6iWdvGm5/7Ygo59NoqD1v+E2i3ssGfpTpZQCOzr47DwjkEUtsDzSK93xGMLCM=;5:frDnbBq73VnuqJYvkLXghyQ5Mwyi54JaKnJKKjsv6Ps835Ij9llP2I21nSBCthfoLEzJiXCrTjbfYzBFNX9KnlnSIx24YlGawgMZZ9PRUsC/TFe+8y8XyiIK/9w46eX75yBzHDV9dLwndUKuebRpwDP5iemeUlNwq0MOZNhxNQ8=;24:fRUEn5VO4ksquCN1ubAgMurrbxlOd6aIABtyO6bbWEmtWlTI42kowOSS7fiXoXTPkKVT9UxEWMgP5K6yM9zuwr//dCoCgun1DmnzPeeh+7o=;7:N+xR0nu86Pi3N/fATAI4hbyloZnz5Q7n2ju2nhIxfQREERw6zjbKtgYUHb2147r9K135IDXfULKNKxcgsi143HzChUmo6ijDvv4tlt8+FP8Rabr0IsBRWRoL5hzBJfDxnMZYOxa7sZxzlhZlut7qv41Wkl6ufeh2XxMBo6LiGed1oQxKm5sWzljgMqGZCEuhNyWTn2nGP1tyOCWImOY0DFq2Xz/w0XI65Ty2AEe/SZmfwJa4EL3OSad2LIkNU52P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:5CRsow1Tw5CfbBFfjH8n5xHw26/mm5pf7nZJjX4WWxUXe6cc9JMzhcaEUJ1/ojUn+VgC501go59VPoAd4v4us250uzkR46mC94fM1lwk4FIV8oK+xA/NQqtklrwAJIBvM4z4fsQ74lCrcqrGm4uYWZBNwmBJBwYVFGH79bg6Udg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:14:38.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ff5c92-4afb-4e25-7210-08d58b7a8bb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595098694946431538?=
X-GMAIL-MSGID: =?utf-8?q?1595126612512007849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16.03.2018 15:50, Christian Brauner wrote:
> This patch adds a receive method to NETLINK_KOBJECT_UEVENT netlink sockets
> to allow sending uevent messages into the network namespace the socket
> belongs to.
> 
> Currently non-initial network namespaces are already isolated and don't
> receive uevents. There are a number of cases where it is beneficial for a
> sufficiently privileged userspace process to send a uevent into a network
> namespace.
> 
> One such use case would be debugging and fuzzing of a piece of software
> which listens and reacts to uevents. By running a copy of that software
> inside a network namespace, specific uevents could then be presented to it.
> More concretely, this would allow for easy testing of udevd/ueventd.
> 
> This will also allow some piece of software to run components inside a
> separate network namespace and then effectively filter what that software
> can receive. Some examples of software that do directly listen to uevents
> and that we have in the past attempted to run inside a network namespace
> are rbd (CEPH client) or the X server.
> 
> Implementation:
> The implementation has been kept as simple as possible from the kernel's
> perspective. Specifically, a simple input method uevent_net_rcv() is added
> to NETLINK_KOBJECT_UEVENT sockets which completely reuses existing
> af_netlink infrastructure and does neither add an additional netlink family
> nor requires any user-visible changes.
> 
> For example, by using netlink_rcv_skb() we can make use of existing netlink
> infrastructure to report back informative error messages to userspace.
> 
> Furthermore, this implementation does not introduce any overhead for
> existing uevent generating codepaths. The struct netns gets a new uevent
> socket member that records the uevent socket associated with that network
> namespace including its position in the uevent socket list. Since we record
> the uevent socket for each network namespace in struct net we don't have to
> walk the whole uevent socket list. Instead we can directly retrieve the
> relevant uevent socket and send the message. At exit time we can now also
> trivially remove the uevent socket from the uevent socket list. This keeps
> the codepath very performant without introducing needless overhead and even
> makes older codepaths faster.
> 
> Uevent sequence numbers are kept global. When a uevent message is sent to
> another network namespace the implementation will simply increment the
> global uevent sequence number and append it to the received uevent. This
> has the advantage that the kernel will never need to parse the received
> uevent message to replace any existing uevent sequence numbers. Instead it
> is up to the userspace process to remove any existing uevent sequence
> numbers in case the uevent message to be sent contains any.
> 
> Security:
> In order for a caller to send uevent messages to a target network namespace
> the caller must have CAP_SYS_ADMIN in the owning user namespace of the
> target network namespace. Additionally, any received uevent message is
> verified to not exceed size UEVENT_BUFFER_SIZE. This includes the space
> needed to append the uevent sequence number.
> 
> Testing:
> This patch has been tested and verified to work with the following udev
> implementations:
> 1. CentOS 6 with udevd version 147
> 2. Debian Sid with systemd-udevd version 237
> 3. Android 7.1.1 with ueventd
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> Changelog v1->v2:
> * Add the whole struct uevent_sock to struct net not just the socket
>   member. Since struct uevent_sock records the position of the uevent
>   socket in the uevent socket list we can trivially remove it from the
>   uevent socket list during cleanup. This speeds up the old removal
>   codepath. list_del() will hitl __list_del_entry_valid() in its call chain
>   which will validate that the element is a member of the list. If it isn't
>   it will take care that the list is not modified.
> Changelog v0->v1:
> * Hold mutex_lock() until uevent is sent to preserve uevent message
>   ordering. See udev and commit for reference:
> 
>   commit 7b60a18da393ed70db043a777fd9e6d5363077c4
>   Author: Andrew Vagin <avagin@openvz.org>
>   Date:   Wed Mar 7 14:49:56 2012 +0400
> 
>       uevent: send events in correct order according to seqnum (v3)
> 
>       The queue handling in the udev daemon assumes that the events are
>       ordered.
> ---
>  include/linux/kobject.h     |  6 +++
>  include/net/net_namespace.h |  4 +-
>  lib/kobject_uevent.c        | 98 ++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 93 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 7f6f93c3df9c..c572c7abc609 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -39,6 +39,12 @@ extern char uevent_helper[];
>  /* counter to tag the uevent, read only except for the kobject core */
>  extern u64 uevent_seqnum;
>  
> +/* uevent socket */
> +struct uevent_sock {
> +	struct list_head list;
> +	struct sock *sk;
> +};

I missed, why we do this external?

> +
>  /*
>   * The actions here must match the index to the string array
>   * in lib/kobject_uevent.c
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index f306b2aa15a4..abd7d91bffac 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -40,7 +40,7 @@ struct net_device;
>  struct sock;
>  struct ctl_table_header;
>  struct net_generic;
> -struct sock;
> +struct uevent_sock;
>  struct netns_ipvs;
>  
>  
> @@ -79,6 +79,8 @@ struct net {
>  	struct sock 		*rtnl;			/* rtnetlink socket */
>  	struct sock		*genl_sock;
>  
> +	struct uevent_sock	*uevent_sock;		/* uevent socket */

Since there will be one more version, could you please to move all preparation
related to the above change to a separate patch? Then we have series of two patches
with two logical changes.

> +
>  	struct list_head 	dev_base_head;
>  	struct hlist_head 	*dev_name_head;
>  	struct hlist_head	*dev_index_head;
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 9fe6ec8fda28..53e9123474c0 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -25,6 +25,7 @@
>  #include <linux/uuid.h>
>  #include <linux/ctype.h>
>  #include <net/sock.h>
> +#include <net/netlink.h>
>  #include <net/net_namespace.h>
>  
>  
> @@ -33,10 +34,6 @@ u64 uevent_seqnum;
>  char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
>  #endif
>  #ifdef CONFIG_NET
> -struct uevent_sock {
> -	struct list_head list;
> -	struct sock *sk;
> -};
>  static LIST_HEAD(uevent_sock_list);
>  #endif
>  
> @@ -602,12 +599,88 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>  EXPORT_SYMBOL_GPL(add_uevent_var);
>  
>  #if defined(CONFIG_NET)
> +static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
> +				struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +	/* u64 to chars: 2^64 - 1 = 21 chars */
> +	char buf[sizeof("SEQNUM=") + 21];
> +	struct sk_buff *skbc;
> +
> +	/* bump and prepare sequence number */
> +	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu", ++uevent_seqnum);
> +	if (ret < 0 || (size_t)ret >= sizeof(buf))
> +		return -ENOMEM;
> +	ret++;
> +
> +	/* verify message does not overflow */
> +	if ((skb->len + ret) > UEVENT_BUFFER_SIZE) {
> +		NL_SET_ERR_MSG(extack, "uevent message too big");
> +		return -EINVAL;
> +	}
> +
> +	/* copy skb and extend to accommodate sequence number */
> +	skbc = skb_copy_expand(skb, 0, ret, GFP_KERNEL);
> +	if (!skbc)
> +		return -ENOMEM;
> +
> +	/* append sequence number */
> +	skb_put_data(skbc, buf, ret);
> +
> +	/* remove msg header */
> +	skb_pull(skbc, NLMSG_HDRLEN);
> +
> +	/* set portid 0 to inform userspace message comes from kernel */
> +	NETLINK_CB(skbc).portid = 0;
> +	NETLINK_CB(skbc).dst_group = 1;
> +
> +	ret = netlink_broadcast(usk, skbc, 0, 1, GFP_KERNEL);
> +	/* ENOBUFS should be handled in userspace */
> +	if (ret == -ENOBUFS || ret == -ESRCH)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
> +			      struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +	struct net *net;
> +
> +	if (!nlmsg_data(nlh))
> +		return -EINVAL;
> +
> +	/*
> +	 * Verify that we are allowed to send messages to the target
> +	 * network namespace. The caller must have CAP_SYS_ADMIN in the
> +	 * owning user namespace of the target network namespace.
> +	 */
> +	net = sock_net(NETLINK_CB(skb).sk);
> +	if (!netlink_ns_capable(skb, net->user_ns, CAP_SYS_ADMIN)) {
> +		NL_SET_ERR_MSG(extack, "missing CAP_SYS_ADMIN capability");
> +		return -EPERM;
> +	}
> +
> +	mutex_lock(&uevent_sock_mutex);
> +	ret = uevent_net_broadcast(net->uevent_sock->sk, skb, extack);
> +	mutex_unlock(&uevent_sock_mutex);
> +
> +	return ret;
> +}
> +
> +static void uevent_net_rcv(struct sk_buff *skb)
> +{
> +	netlink_rcv_skb(skb, &uevent_net_rcv_skb);
> +}
> +
>  static int uevent_net_init(struct net *net)
>  {
>  	struct uevent_sock *ue_sk;
>  	struct netlink_kernel_cfg cfg = {
>  		.groups	= 1,
> -		.flags	= NL_CFG_F_NONROOT_RECV,
> +		.input = uevent_net_rcv,
> +		.flags	= NL_CFG_F_NONROOT_RECV
>  	};
>  
>  	ue_sk = kzalloc(sizeof(*ue_sk), GFP_KERNEL);
> @@ -621,6 +694,9 @@ static int uevent_net_init(struct net *net)
>  		kfree(ue_sk);
>  		return -ENODEV;
>  	}
> +
> +	net->uevent_sock = ue_sk;
> +
>  	mutex_lock(&uevent_sock_mutex);
>  	list_add_tail(&ue_sk->list, &uevent_sock_list);
>  	mutex_unlock(&uevent_sock_mutex);
> @@ -629,22 +705,16 @@ static int uevent_net_init(struct net *net)
>  
>  static void uevent_net_exit(struct net *net)
>  {
> -	struct uevent_sock *ue_sk;
> +	struct uevent_sock *ue_sk = net->uevent_sock;
>  
>  	mutex_lock(&uevent_sock_mutex);
> -	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
> -		if (sock_net(ue_sk->sk) == net)
> -			goto found;
> -	}
> -	mutex_unlock(&uevent_sock_mutex);
> -	return;
> -
> -found:
>  	list_del(&ue_sk->list);
>  	mutex_unlock(&uevent_sock_mutex);
>  
>  	netlink_kernel_release(ue_sk->sk);
>  	kfree(ue_sk);
> +
> +	return;
>  }
>  
>  static struct pernet_operations uevent_net_ops = {
 
Thanks,
Kirill
