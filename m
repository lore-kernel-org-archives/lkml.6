Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtg1H22aEBAG+5epNEfuVNbTbqydBz/zDPJszMHIKRKWQ3JbVbAteEc/7WKbLTsLr95kYOP
ARC-Seal: i=1; a=rsa-sha256; t=1521123262; cv=none;
        d=google.com; s=arc-20160816;
        b=iExh56epBYp04sjK4smK2A+11qT6/uuwrP6Sl5bNzMC8XSOVHqRyElpLysyzyPazlJ
         B9H+Vwh5z95QUdIh5o6D1fTKhoEO67Ka7c73430G9lfxHfONbUfI+KN9LIyyy+9E5YPv
         amiYx9ad+6ZcoPZWWf6ZjE5a1W45KaLxuiLayaNQjY8gWna7EVpTt5VNIgOkzAM6dF2w
         vPThzqn6FejrVz0cU3wtBYb6JeNB/r3zHPXjJx44L1PBn6txK95RTbxECSzuNu16ToH4
         +ptL0ltW2YUXVfpdyDb/4vS35X8+ALQ0F5x8uSUN/AVCnb3rbBKnqr2YrUUQHwzO0Dpl
         lEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=TtUu1895mD+mBXOzuCzlXH/zJ6ssVjdb/KN/WPZzcPg=;
        b=etdN19UDDeCjbtL1BFAM2ubUXsmfu5+C8xctLVUhSqezBttXG/hYxM9mmo38LwWGQ9
         kGcb5jBKtAbZFeXrLIkEI4B+H5d63SkPGYPp+zrdL6/taEVtBuMi8ayWX7zvQ2XHkb0j
         fJguwm/KBCHoZB7la6TNtT0EsE+QuDt1x3mJB5/MK2FI4LKjfTLqrRCMj4XYybnMPUav
         IjLXVgyAfzFNdc8hMqDGKesZt1YUb4qoSZ62gHvkxDk4Ird4t7SZIX4rdshmel1J33Rz
         oGqsk2UR4QOt24C8mSnAN0YPZLeclhIEtmgSCx395Ge+W/RJ4y2GR8/8D7DhumdzZXiZ
         6DBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GImWYp3o;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.127 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GImWYp3o;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.127 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: netns: send uevent messages
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, serge@hallyn.com, avagin@virtuozzo.com
References: <20180315001214.19462-1-christian.brauner@ubuntu.com>
 <cff34509-16ff-f12c-cd8c-9bcd91645d58@virtuozzo.com>
 <20180315133920.GA25733@gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5779f3c6-7432-a3d5-1199-0b28df69ca90@virtuozzo.com>
Date: Thu, 15 Mar 2018 17:14:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315133920.GA25733@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::21)
 To VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e127751-4851-445e-278e-08d58a7f0a26
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:ba8Syz/nncmxd8QjAzIFUerTzNoImIIZyMTJt8bOxP4VuKXMG95ceAhnBajxqbANekcFQjzG+DFY/+AWbtuqZjy1pWyIIozZFEvrOfRFo/c9zp2R7UtXdT83aZCcExJ+CpRr9VtNkhJL2K0p2oaTNtO2qtfBb+BEjt6dspYIGQx8fxkJihjFb8WfKIrSTKCjGsxiTW8GlNRxQcFqd0R07Hr5GOOxPHJJtQYfMrdddRJozN+8Jd9tT5mPQGueDDIg;25:mXvu9F1bqbjzJep5davmTBXQpl11EvIQht89Zm/02nO510/MFpp8ClpTyoJCJiTKuXj9g1b5kE77pEWF3crg3kswjsrqJIsiQbdT3RnNPd1dwEt3gdrbWoHKWdRmlGhf/9kB+ePBpul5GlJKOaHe3vnbrk7nl0T1+LvtuK4bu3lJEdaZOSOSTexS7LhE/EcWnMNIa+5S6MaNq6MinB1Nfa1IIzD1ZnTrUE6K/4gYpuZED1/JYKlXUwlM8E6L6DKQy505QjOgxRsuK8fWxhIE2XmEAhT0W6uxo1KqTjSpz+anbrPx4RfOAp6bmZpPF1VJBlApYW6su+9wFCRFJ49XYg==;31:PAKvtOLwalWlDkNUIEztTZbOiap1YkzQ3HeLogC1bqTNrpu2uq6yCa/eVAI036t77fu5wR1AQNBKHWqohQgULwLRT4puMjhHxQeMOzrHwWyXFnaXOI10WIncGerYJQXbZyLP57hwMXzSGAqXBt/c5BaB0kZU1pba4xK3HAsWIylOMfAGbFcHpHR0Ucdx0aOu5T5sEDpcxtj1RviQ6dkcZD/WCtnrEPneZ3i0iBIvoDI=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:Qjd4oNpIEvEezkz1taUeGox4vL5YP8XaO+PkUte0dMk47pkVp2KEIqGXi3Z9RTwqITSViLuKlNC6JbCOIySxpZreceB4X+5Uj3KTQ/tE/0aKzSoe+SkW9n/eZ7obdIK2ONbPON38m3ar6Y52ismkOkv77YDLEtDdBXDe2moQApgmc/9ufyPW0+IHTr99KI0EnH/v9kNROItX1a14IFJHwl180Ww+sbTvtwW05CiOftatpJh9E0nwSQqG41grRf5CmPEWG4UBIA/0s1umaCGHZQdMe+KNNbCUeK7LSga6P5cpAarQaXA62J6ZdJj6v+vw56nkOiFY6WD/7qevRw4isBHwlo7vF/7Gx6fZnqz8AX5L3oHWsfqLqlcJhWFOBTQCOZArkjRaulXPtF4rr8mgLNcByeESaayy0m/uIh/YUv4RiJvN9XJfUxOtOgprqH0fr89vZWlvyLwLvh2f7/Icv5xwoXehTMBDtRQhwV+QoJigM82a3IdfbRTh80jfF6K8;4:F0q1Hdm098gCqeFhjpAIKJHeDRlkbn5d2bYvNdh+q5q7iDpjDtROjEAsBnv33C14S/6WjSCaQXPQo7E2CU/mP4DB2MuAo81xyUtL2NZywl1eqMCyDYnA3fLnlthOZwySQUh2np7tM+g9c1mZEMR5YO7X1A1uWxRms50nSnLfR21/xEp2PgzdntaD6q3dVmZ0raeeHN0WuWLZFpRFyfIxTNiwukJfaqPzFIWQvX/k6OXu5Yhmp9TtuzfuTb/7qBI0McpmXYMKq35/fTimZrp+2uHzYlVJxle3CkwLcI5pQYc9rHjcemp2DKFeLvZIaT47MqsXcub5nQiC9qpEKz2ks6b57PbMy7GEbCCVW0/tWSGrD1hFnH/lGGNxks/wMLmx
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341BA3C9DF574C37A03DF3BCDD00@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(788757137089)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(346002)(376002)(366004)(39850400004)(199004)(189003)(230700001)(386003)(97736004)(2950100002)(31686004)(36756003)(59450400001)(47776003)(53546011)(105586002)(66066001)(16526019)(65956001)(65826007)(53936002)(6916009)(6486002)(31696002)(6246003)(8936002)(7736002)(478600001)(4326008)(229853002)(316002)(3846002)(15650500001)(65806001)(58126008)(107886003)(8676002)(6666003)(52146003)(305945005)(16576012)(52116002)(6116002)(23676004)(77096007)(68736007)(5660300001)(64126003)(86362001)(26005)(81156014)(25786009)(2486003)(106356001)(2906002)(81166006)(76176011)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6TXJqSlpWb3dzd2dPL2cxLzBEWXMxZGs1?=
 =?utf-8?B?SjNOZ1RYZUJwc0VWRlVHeGtvZlFJSDYxdktxMFZRQXZ2bllMOHNnbXdNR05X?=
 =?utf-8?B?SXRCVDg0aTVGUFhNOVVMT0pjZktodjFaL1dSbHF2K0Y3cVVPSHdEaTBhKzUy?=
 =?utf-8?B?Nks4UElac3Y5bjl0UHdDLzY2eDI2VmtBajQ0dEJQd2JxY1pKWTJrbW9jblVP?=
 =?utf-8?B?bTh4My9lWlV0OUZpLy9KNnQ4TGhVTzJ4ZUFzNDNXS3BkNkhla3NlV2tsY0s4?=
 =?utf-8?B?VG8ybGhtTktFOUFYdU85dXptMTJMTHN1amdUYlZSdHduK2l1T292L1BXK1Iz?=
 =?utf-8?B?OThjR2lzUjNYRDFpL0FJWHhCVUc1SkpzZXlkNCtqdFB0WW12WjVFQy81SEcz?=
 =?utf-8?B?anoyMTdDV24rckJvUnplQ3VTczNkWXNaakVhTG9pMDlaV2xCb055VGYwOXpW?=
 =?utf-8?B?OEVXNWRYWU5XQzBBNkdBc2FKWDIyNkJIaGN2M0RzaXdiczNTVUJBQ29QWUN3?=
 =?utf-8?B?bCsyd29rOExQYzVwMUZvS1JoRVM5MzJ0WXFFQ3k0bEx1TjF1Z2xSN0FDRzUw?=
 =?utf-8?B?YWpDQStDVDViRWUremo0RHg3SkZscW41WURjbmNEeW1YaGZ2OUpKaWlmOXRr?=
 =?utf-8?B?MkRjdURoRWpUVWl0UHJaRXpMeTlrc0ROR2R2RFF1U2tWNWJQU1pxNHhtNzEv?=
 =?utf-8?B?YkFWZ3pkMXJOS1ZMTjlCTGtKTmQvNHVFWklhYjlUQzBVbEJzMjN4TDB4c0pS?=
 =?utf-8?B?aDlXb3BHYTNKTnY5cUVIVHEzaVFWRHZNNm4wdnBxMFhaNlUraWxHaldFaXVZ?=
 =?utf-8?B?L3h6akN5cUdUbzV5ajF5ZHZyMDNWajRVdUpCYjdBQk9HeVpUTVMvTVF3V2lY?=
 =?utf-8?B?djlwbXdmam02WVZLTzZXZG0wWmxmbkRnZUxMSGV1aDBGUmhibTNaeDlVUG9H?=
 =?utf-8?B?dkEzdUxLMzZkdGdsMjRCMWlKaVA3cFVJM1p5N3lpN2kweHFOelN2eGpTS1pE?=
 =?utf-8?B?K2pOaFp0MUxtV2pIZVRkYkJXTFdFTVFpWUdsSUhiNEZHUHQ0K0Yxb2QrblBF?=
 =?utf-8?B?QXpaa0RWNFFCYTB5cWpoZUJENDJmR0dIdWR0KzVJWnFydTJHbTZTR3BRUW1J?=
 =?utf-8?B?dkpNVkdRS1NOdzFhd1pmaFdTQlpOYmFCOS9DMlQvMkI3RVQrY01zdzhscXZE?=
 =?utf-8?B?VlpLbC9UcnJ3WkhsVHVmaHdDZzFiL3dmdXJjTlpPSWNBd2Zxb3EzWUsya0R0?=
 =?utf-8?B?ZFhGaHNhMzhZdmhSZTBBZzMwNXVzVU9xcnRETC9Nb0hqMjJTMFF5MkZpQVN0?=
 =?utf-8?B?cFFPU2d3YVhGNGlDdSs2NzFLZUlnYWdobGpRTlUvb2UxR0xMQ2JVOUljaUtz?=
 =?utf-8?B?UkdZbS9EUmIwVDFlRkltbEwzbXJ4TnNpV0N2dG82U2VUR3hjMC93bk9yWVFE?=
 =?utf-8?B?L2trcUZUSmMwd2Rsc1JzMFZOY1ZqaWNjNWRKTk9nSDdTb2xvSGVzUXVRL1pL?=
 =?utf-8?B?bzFuVk1rWjR2cVRQcVJVNksxQ0pkREN6YkVGRmNEY1RWK3kzYU1Ia25lZDhV?=
 =?utf-8?B?N0hvcWRETjdwLzd2WW9WQ2xrT2Y4eG1LNzdEZUYzYXc5VSsxUE0wZ3pOYjcw?=
 =?utf-8?B?eGNOWTVqYjNpTFR1VXJMcXB0N2NjLzJNTXB2aTh1aU9lWGZNZTRZN3Z1QmF3?=
 =?utf-8?B?Q0s3NG1aa3FDbUVNaUdiWU50UDYwV20wRzBtQ3ovMVUrQ3BEM0xrS3hSeC9H?=
 =?utf-8?B?SmFwa2ZHUzJlZnNnU1ZadUhrRENWbEtVZkxMZGFuVWQwTm0ySEhzMGMrQkE4?=
 =?utf-8?B?dE1zd3NvZCtJVkFhY3ZmTUtON3BlN0VRZ1hPS0xuNGhOb3JIbWtWUCtSWTRs?=
 =?utf-8?Q?qZg1tEqW4EqZJJ1iESf8nT41NWh9j56jjr?=
X-Microsoft-Antispam-Message-Info: ZSXszJo/8meB79qaTMFgP95jiL687R6nRacdFi6fSUDtxJhsjbK+ipEzbUfO8Z7NBIO6pDPyMQzWI2dr2uDUepJ6ArcDKfO0vXI/cbr+z8uZayw8tvYSgbSrsKJgXttH50u5BIGzFBufiVZjF5+efnnXOSl/l294oNHCYK0FPImbS6QIbGQo2/DFgyCbaClr
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:ocDBu0HegQt0Dtuqa5JWpMmLRcnU8dvG+t4ap21w3ZUOdsxo4SmT16i0sAITdIE3RA9mAvkK71KfhgI3P9Y9F6ZaQfZc4/mcxsUY7pwbuYWYYGD0FFIbSubGnuB0dIe1LXGTgZ0l57JXl7XBIu4Wrrxg0VQE/SPaYJPciFcPaSIBtilcYypaquK1F/9I/I8Hej+Ese4kax3wET/akotStfqqMQs6fJ8AZXyAuwiF40xNW+He2Y0emV4P1CLBvKFV2a6YYJB0YbZzOETv2lQhuqUjMacsU3YKke9qcU93T7drKkvo9lPS3ZlbAihN4JHw9ESawT41jaF2Adcd5JPf8DJZDwgjrTvDETfhpxcPH44=;5:9bKS01oQZiKEVIZcjF4vBjpTx4MtNAbN4l+ZTc6iKDCaq8Bc+uqiGRzZWEDdcxgZMi1f+kLA7Zvzx3BXtwUPMcXMvh2UTyd++p0qI7Li5yfs8a0cAi9EZrZI4JRtWZGMNffbZQ8y0D15fVtOA8Ffssa2GsY+1vCz7zzN3yM9Akg=;24:OMsdhJxHRGZRQtnLOLJi9//i0k7PQ9le8FGIUitd27UBaR8/r7qmrrWb3hxOIAjiuzBiKP8Nz1KqTxR5kMxiXPQg7bCjCd6SfAOgj4pp8NQ=;7:yjQ+2chCcZ4pyYKYbKwGA0kDGtLuJKOxfC+61G5vmEoc/hygEiL467elRXENcgqA+B9inZAa5Y3H8iEVSRLb13WAfT6KU+dspj+hTwQwRDE9OWz9SvsZYtxdaoEvxilVQ4JQMOgi7Bdheu1Kwp0rgzOlnR75zWU87XZj1C0zOG1vwb+byShvGAVgUa8Mr2EpWdTtTIdIVdvH+MHdbHTbqNxaEcsDdlAO14fuxwlt5H7Xh894o5CrQE8bItbVhxs9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:A4NoNG6l56QqWLvtGpR7t3noTj+72u6uuRZOPSpQcpDGE3qI45G+ulnQTHCVbk7OmzTgpXZUsQ72nWOlLCoi42VGypC92U9J9WeZC0QB5jIobh+4K/KeGmuqhDKS4jyyH5fURsfJaSO3CbpVWP6iZZ3mWhV5BhP7lZ+xTnkGCNw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 14:14:16.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e127751-4851-445e-278e-08d58a7f0a26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594960381230985208?=
X-GMAIL-MSGID: =?utf-8?q?1595013345811777329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.03.2018 16:39, Christian Brauner wrote:
> On Thu, Mar 15, 2018 at 12:47:30PM +0300, Kirill Tkhai wrote:
>> CC Andrey Vagin
> 
> Hey Kirill,
> 
> Thanks for CCing Andrey.
> 
>>
>> On 15.03.2018 03:12, Christian Brauner wrote:
>>> This patch adds a receive method to NETLINK_KOBJECT_UEVENT netlink sockets
>>> to allow sending uevent messages into the network namespace the socket
>>> belongs to.
>>>
>>> Currently non-initial network namespaces are already isolated and don't
>>> receive uevents. There are a number of cases where it is beneficial for a
>>> sufficiently privileged userspace process to send a uevent into a network
>>> namespace.
>>>
>>> One such use case would be debugging and fuzzing of a piece of software
>>> which listens and reacts to uevents. By running a copy of that software
>>> inside a network namespace, specific uevents could then be presented to it.
>>> More concretely, this would allow for easy testing of udevd/ueventd.
>>>
>>> This will also allow some piece of software to run components inside a
>>> separate network namespace and then effectively filter what that software
>>> can receive. Some examples of software that do directly listen to uevents
>>> and that we have in the past attempted to run inside a network namespace
>>> are rbd (CEPH client) or the X server.
>>>
>>> Implementation:
>>> The implementation has been kept as simple as possible from the kernel's
>>> perspective. Specifically, a simple input method uevent_net_rcv() is added
>>> to NETLINK_KOBJECT_UEVENT sockets which completely reuses existing
>>> af_netlink infrastructure and does neither add an additional netlink family
>>> nor requires any user-visible changes.
>>>
>>> For example, by using netlink_rcv_skb() we can make use of existing netlink
>>> infrastructure to report back informative error messages to userspace.
>>>
>>> Furthermore, this implementation does not introduce any overhead for
>>> existing uevent generating codepaths. The struct netns gets a new uevent
>>> socket member that records the uevent socket associated with that network
>>> namespace. Since we record the uevent socket for each network namespace in
>>> struct net we don't have to walk the whole uevent socket list.
>>> Instead we can directly retrieve the relevant uevent socket and send the
>>> message. This keeps the codepath very performant without introducing
>>> needless overhead.
>>>
>>> Uevent sequence numbers are kept global. When a uevent message is sent to
>>> another network namespace the implementation will simply increment the
>>> global uevent sequence number and append it to the received uevent. This
>>> has the advantage that the kernel will never need to parse the received
>>> uevent message to replace any existing uevent sequence numbers. Instead it
>>> is up to the userspace process to remove any existing uevent sequence
>>> numbers in case the uevent message to be sent contains any.
>>>
>>> Security:
>>> In order for a caller to send uevent messages to a target network namespace
>>> the caller must have CAP_SYS_ADMIN in the owning user namespace of the
>>> target network namespace. Additionally, any received uevent message is
>>> verified to not exceed size UEVENT_BUFFER_SIZE. This includes the space
>>> needed to append the uevent sequence number.
>>>
>>> Testing:
>>> This patch has been tested and verified to work with the following udev
>>> implementations:
>>> 1. CentOS 6 with udevd version 147
>>> 2. Debian Sid with systemd-udevd version 237
>>> 3. Android 7.1.1 with ueventd
>>>
>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>> ---
>>>  include/net/net_namespace.h |  1 +
>>>  lib/kobject_uevent.c        | 88 ++++++++++++++++++++++++++++++++++++++++++++-
>>>  2 files changed, 88 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>>> index f306b2aa15a4..467bde763a9b 100644
>>> --- a/include/net/net_namespace.h
>>> +++ b/include/net/net_namespace.h
>>> @@ -78,6 +78,7 @@ struct net {
>>>  
>>>  	struct sock 		*rtnl;			/* rtnetlink socket */
>>>  	struct sock		*genl_sock;
>>> +	struct sock		*uevent_sock;		/* uevent socket */
>>
>> Since you add this per-net uevent_sock pointer, currently existing iterations in uevent_net_exit()
>> become to look confusing. There are:
>>
>>         mutex_lock(&uevent_sock_mutex);
>>         list_for_each_entry(ue_sk, &uevent_sock_list, list) {
>>                 if (sock_net(ue_sk->sk) == net)
>>                         goto found;
>>         }
>>
>> Can't we make a small cleanup in lib/kobject_uevent.c after this change
>> and before the main part of the patch goes?
> 
> Hm, not sure. It seems it makes sense to maintain them in a separate
> list. Looks like this lets us keep the locking simpler. Otherwise we
> would have to do something like for_each_net() and it seems that this
> would force us to use rntl_{un}lock().

I'm about:

mutex_lock();
list_del(net->ue_sk->list);
mutex_unlock();
kfree();

Thus we avoid iterations in uevent_net_exit().

>>
>>>  
>>>  	struct list_head 	dev_base_head;
>>>  	struct hlist_head 	*dev_name_head;
>>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>>> index 9fe6ec8fda28..10b2144b9fc3 100644
>>> --- a/lib/kobject_uevent.c
>>> +++ b/lib/kobject_uevent.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/uuid.h>
>>>  #include <linux/ctype.h>
>>>  #include <net/sock.h>
>>> +#include <net/netlink.h>
>>>  #include <net/net_namespace.h>
>>>  
>>>  
>>> @@ -602,12 +603,94 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>>>  EXPORT_SYMBOL_GPL(add_uevent_var);
>>>  
>>>  #if defined(CONFIG_NET)
>>> +static int uevent_net_send(struct sock *usk, struct sk_buff *skb,
>>> +			   struct netlink_ext_ack *extack)
>>> +{
>>> +	int ret;
>>> +	u64 seqnum;
>>> +	/* u64 to chars: 2^64 - 1 = 21 chars */
>>
>> 18446744073709551615 -- 20 chars (+1 '\0'). Comment makes me think
>> we forgot +1 in buf declaration.
> 
> sizeof("SEQNUM=") will include the '\0' pointer in contrast to
> strlen("SEQNUM=") so this is correct if I'm not completely mistaken.

The code is OK, I'm worrying about comment. But I've missed this sizeof().
So, there is only 1 bytes excess allocated as 0xFFFFFFFFFFFFFFFF=18446744073709551615
Not so important...

>>
>>> +	char buf[sizeof("SEQNUM=") + 21];
>>> +	struct sk_buff *skbc;
>>> +
>>> +	/* bump sequence number */
>>> +	mutex_lock(&uevent_sock_mutex);
>>> +	seqnum = ++uevent_seqnum;
>>> +	mutex_unlock(&uevent_sock_mutex);
>>
>> Commit 7b60a18da393 from Andrew Vagin says:
>>
>>     uevent: send events in correct order according to seqnum (v3)
>>     
>>     The queue handling in the udev daemon assumes that the events are
>>     ordered.
>>     
>>     Before this patch uevent_seqnum is incremented under sequence_lock,
>>     than an event is send uner uevent_sock_mutex. I want to say that code
>>     contained a window between incrementing seqnum and sending an event.
>>     
>>     This patch locks uevent_sock_mutex before incrementing uevent_seqnum.
>>     Signed-off-by: Andrew Vagin <avagin@openvz.org>
>>
>> After this change the order will be lost. Also the rest of namespaces
>> will have holes in uevent numbers, as they won't receive a number sent
>> to specific namespace.
> 
> Afaict from looking into udevd when I wrote the patch it only cares
> about numbers being ordered (which is also what Andrey's patch states)
> not that they are sequential so holes should be fine. udevd will use
> the DEVPATH to determine whether the sequence number of the current
> uevent should be used as "even->delaying_seqnum" number. All that
> matters is that it is greater than the previous one. About the ordering,
> if that's an issue then we should simply do what Andrey has been doing
> for kobject_uevent_env() and extend the lock being held until after we
> sent out the uevent. Since we're not serving all listeners but only
> ever one this is also way more lightweight then kobject_uevent_env().

Yes, extending the lock to netlink_broadcast() should fix the problem.

>>
>> It seems we should made uevent_seqnum per-net to solve this problem.
> 
> Yes, Eric and I have been discussing this already. The idea was to do
> this in a follow-up patch to keep this patch as simple as possible. If
> we agree that it would make sense right away then I will dig out the
> corresponding patch.
> It would basically just involve giving each struct net a uevent_seqnum
> member.

pernet seqnum may have a sense if we introduce per-net locks to protect it.
If there is single mutex, it does not matter either they are pernet or not.
Per-net mutex may be useful only if we have many single-net messages like
you introduce in this patch, or if we are going to filter net in existing
kobject_uevent_net_broadcast() (by user_ns?!) in the future.

Kirill
