Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtspI0KydFA5eFSTz5oT7LLvTgzzr+mOuq89v6MgVyJuJ37u2qrxwHVuz6I+/hwh4k+Yyw3
ARC-Seal: i=1; a=rsa-sha256; t=1521107258; cv=none;
        d=google.com; s=arc-20160816;
        b=AAKZmehw2o95qbxY+nLywYialUvR88eqbP02e/gjm/+fSIW9qyrRT5dJHyZOS0wYFM
         N2Eip9zLIfkIRy6ZhO1+R05s6q6TNhh/H5smNCMobFOABITXv2cH4VXx/Cg5mzWRfWp5
         QTOov4j1yejPnMpbrKj23qHcRCP2Li4rTV6s7cVz9HtF60dKUqN1hNxC0a1BQeto17OH
         +RCGAOwaxHiMOou5KBletYlNhHyKD3NRVFhW3RMWSAZ2OHjKm/4sjLjYQm61PMUiKFFG
         jlUJu/iKDFFFRuhYnWjxF0Hhg3swB8fhaFXDig70jaLcbDo6z83jxMAWGP0Co0lT0R3O
         /AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=P71FH2dHKrszCVxho7Qw7g0ca712eLyfaI+NjItsLs4=;
        b=o7tUy+TyyBsy44PT5RyHQoiKKmcaOV28kBxGgScu0dc7FRHCNEnkIWiyPUMEXXG25T
         o2kcFcwyk+JaVc/Z0323mLVjrXVWNSf6BOEytTgQjHO+2vWmy9zff2c6AphjDdZ0B5ib
         CwVABOB9p0BG8jcOzke7qw+g+CneCMgoUPjn4w3MuyoQ5U2Te3ScQV+EmawXwi1fAkUc
         SZNFmTlanx1DCKXu/0ccZbQ5N2siZMo/Ofujnr3tgLKnM9Rqjx7YVoFmEgwYaTcWMdaJ
         04j+wX0jYmnPPUIR9QqNFoZYukHFvTrerhEpkphk3npyajTZyBYIRDWcaQNhouDg6Iv0
         MLlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LCxvhSpp;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LCxvhSpp;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: netns: send uevent messages
To: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: serge@hallyn.com, avagin@virtuozzo.com
References: <20180315001214.19462-1-christian.brauner@ubuntu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <cff34509-16ff-f12c-cd8c-9bcd91645d58@virtuozzo.com>
Date: Thu, 15 Mar 2018 12:47:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315001214.19462-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0006.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::16) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdff33fc-7d7c-4290-aa6f-08d58a59c742
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:KqYcqD84+u46vpisO36phRSIPgiGjDgCn3eQqUiT7A/B8ikeNi3a16cmf1UIUmfXhiExav3+yiGhOif0/IM5E1XQ1M7nojhca3UaOPObBWeI3XHKSjZK5NuhZIo7tOPQOrrjVCRzUTbvjcnP5noYhxUlrpCATB5VfWbB0/vjV6B/gp2Re0Zbe0ci3pVGwSttKQMGDD0gpsrVvgsWbl7pNUid8DDfdkld2IROa6g+aGAzadMQLnRBjfP4pap9ZgbC;25:USrfFlqPAf2RjI8+cbTjAvf0FQxhr1kP8TxAPgPPB9LfjcL27bxAPB3FcLMcBB9RetNk+ZbAw1ESWfIYRyUyiqDp2OnPThF+z6E2M2rBINLkHSJXTkX6s9ySMg+fYu/AoiBeX9xsCo/u8yWt6SD9lxPGG321+vX4/3LC588YpoaXDjX5chV//otjwCPKXvC4xi198Sz3WV4IGFB/P8/oFBygB9IJT9g1YnVOn20mszF3KFI3PRBlT0cexfOdbTJyRXqW7yPe/Sdje1AMMdUQpcAwHMvqQ2RPaYH8MJRrUmgri2QPkqoymSbYhchghH4OtN1FzCzRWAGOmlzP+jnHXw==;31:6M9+Kx/l6Lt6LK1ZawisevxMAfmReInEQy3I7aqkBx5Irps7rDKubRY/dOHu+mOsuemIGUQ4A7jfNkw3uqei91UMSnaogYjsIF5/XsJEX9L658hrkpIgRALoFpsni76IZ+yACFIpubBPHCAM4yHgJoaIs60lASVQ37g08DT6YrjjidL5v9sqnjgOEEQmr7S20xL5bP416g/sGbzTqJSgz7Lcvhr26MJ6NokDBtrKqno=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:6uU1MqSQ8KgknQ4sts5NT48s1bwXpK3pop7O3LFHXb3c03bc5teaKhdZXPHjjoAGXba9rDqYuJ8OZdIa3Y8DV9A2qo0GsoifC2XJSwZOf0Id8Es8xF0ijNdMtLQZ3QaF+2ZlwM3GVkMAz9qiUXtfx+bMHsfXkGwyWTCPVqpkuPgkNGUypuRk9TlxKOGiK5MCCvoXXHPsvxvp6iAFNYlmF/8tbAQQ4NXfRn0KeHG61F0B/o1pINQC5+DiUUgWS6pW7hA1OmwSrFi+dtEHEoZykxMRYI7T5txbatGOnsEf5m8gFzFLPzg+PXx7PbMjp43WZrXIugFTWY8YFs/ZWe81TzDrpn9sWvNyuBur5y9G2xnpn/iV7Yf0wkSpA8v7PHwEoEqXVUfW3jb8im4fnN/sX55TNNu+yiA9NGVieeq1yWBjBWD3/Fif9D+9CTMRL+leMWTj73nVpVQyeWg16yRgWeJYCphfi/Y1U+GsPiZaHHXaGOosj6VDFOi//4OHgtKJ;4:ps9AYuqUqcv857qkSxHoWbSfLcclfbmui1Z+MMaF6J11s8uDAwjcQFk09rrepOReGVyHX8YZEc3rgpQsn/HXxRjpnFdWQZg6W+J8y7q+IYLjNA3r1hjdNz96ve7E6pawLiZU7cIZ0IDmRWDR9nYwB7nQaeLt4ea6aydkmXGEryUF3Hejcpb5nKvxIIyMoRIjrxTJB2fUYZ7Jb1SpZSuznuwLe8irbeqsWmntqR/yYbdhsNlu4pOsMh/Dh113n11cMfwCLjdzX/FlWonVwk6pHUv11zqL68EQD6t+Nr2Z1QZ5VSLmWgkcVOsS6L8aqJhXdZKICm1+yziKYb6MQN/PQEWTH8AAF99vlEvvWlMFYzKr90YIdQIQgbSRg0LYxZJ7
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1336AC446EA265DCEFCFFE06CDD00@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(788757137089)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39380400002)(346002)(39850400004)(376002)(199004)(189003)(31686004)(3846002)(64126003)(66066001)(65806001)(386003)(97736004)(47776003)(4326008)(53546011)(230700001)(50466002)(6486002)(25786009)(59450400001)(36756003)(106356001)(316002)(65956001)(16526019)(77096007)(6116002)(76176011)(2950100002)(68736007)(305945005)(58126008)(105586002)(16576012)(478600001)(2906002)(26005)(6246003)(65826007)(5660300001)(8676002)(52146003)(8936002)(53936002)(86362001)(7736002)(81156014)(81166006)(229853002)(23676004)(15650500001)(2486003)(107886003)(52116002)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6MUc5RFMzUDUxY2FOWncxaEtTTy90Qm03?=
 =?utf-8?B?WDZQZXR0eWJXdmtyWGNmd3MyRXBXUWJmdXVUcmhqcU1aSWpucFlvZDJpSE9R?=
 =?utf-8?B?dS9kNVU3VjZPajVRNWk4UVFRckd6L0wwMUtEbkpQd0ZEQ3o1RDhTNjc0R1c5?=
 =?utf-8?B?YmNZOVNtQ3Fvci8yNE1Id3NuWUJGbXJHSVREdlEzMDIyT0RuQ0FmRnhJcllm?=
 =?utf-8?B?WUFYYWVQQnRwVkVFZVNVY1J3YUlHV3JVWGhMbmNpZzRWbWRNRGhEaUFObWxs?=
 =?utf-8?B?aFRLRE5KRTRvbE1WdTMwWW0wYTZTUTU3SVNTajVVR096eG1WY1A3V0MzTFJQ?=
 =?utf-8?B?WFkwWU83TGY3UXhHTWQ1aUZxcGdYSHJHWllyYXAyak5jUkdQQ2paaStLQzZF?=
 =?utf-8?B?Mlo5WXdmVnFOTTdxVmt1K0lZRjhFK3FLRFJQUjhxYlFxbFZISVRGWjJBVWcx?=
 =?utf-8?B?Mk1maTFkZEcxTy9HTG9mVWYxbW93R3YxODhVTGVGNzVYb0hncGs4RElWclhm?=
 =?utf-8?B?MmI0MncvWHJyNVArc0dGTTNVdUdjSG5IZG16OHFtaDVLQTBONTFMZnV0MUc3?=
 =?utf-8?B?RitPMnArZTRqWGQrQ1lvN1RzUUVqMTdDVHJVcHBTSWhzMGh0WVQ1UjNyQ2tj?=
 =?utf-8?B?TjFXRlJCN3h4NjFNNDZRYm53anB1N0tFUEtQTGpUZGZYVkVZOHl6S1QwYlU5?=
 =?utf-8?B?WU1vVE55RnNaOUhrK0x2TzZzZWZiT082Wk1yRjBaTVVWVWt3WEk3bUdYRkVB?=
 =?utf-8?B?OERvU3h5U29tVWVMOE1qcUMzT2ZqL0Q1TmRzRkdnSy9TNnZhTlFlbVNJRURk?=
 =?utf-8?B?N1h3Z0kzb3VVTzI2dGI0NXBOQXhwSzc0eXdBYVNvUXUvL01VRXJhVVV5WlFZ?=
 =?utf-8?B?VS85Q2VJR2kwL24rM2xoeVhZSGN4M2g3UEZPdGtuMG1qU3pXVTF4U0hnVU5Z?=
 =?utf-8?B?ZEZGYUJxOE5UWHdkeTVNTjQ3RHRMMGFPYm0zOTN2bVJSQyt1VURMMFkvQmtH?=
 =?utf-8?B?cUVlQVFHOUZDTUpTRnYrNmUrKzNNR29JVkNUcnZUNUtGZnUrSGVvOHpDSHpX?=
 =?utf-8?B?TnVDMXcxQzNwRmRwK3ZTcEo2RWVEVDlscXdQQWViNHk5NUpyQ0RDdE42S25D?=
 =?utf-8?B?dmxJSzZzVGwxN3RBVXJsNzRkQnMxMm1CeWh0bjZmRHVoSURHeU1zRW0zU09O?=
 =?utf-8?B?aWVlM1Y2czZ0MTV4SFZOdUJFanl0b1M5Ykw0eGt3ZXBYTXVKTG8rdTZuMzZB?=
 =?utf-8?B?Qnpnd0QwQzRNd3BIcElCcm96cTNONWF1YjhvYzNodGVwTUVNWDlpTk5vVkpv?=
 =?utf-8?B?UklpVjVBT2NVcjFCOUErZ2MwWktMclVMVUNicW4waEkvTzVhWlkvcmJoZU0r?=
 =?utf-8?B?V3J4dDkvRXBsZm9QeTVFYWxuWTdsYXFXR25xUTRNUENtbG1kSysxQmNCY3Vz?=
 =?utf-8?B?a1RaeTFmNHo2UmVQTmdFejlZS3Nxd1hnelkzMFdoZXdiazVYVVFzZzJtd0VB?=
 =?utf-8?B?anNRa29Oams2cFpKY1hHVzRQSFhDZmhQUFBLUmx5cjZjTkdOUWc0cG5iUHYy?=
 =?utf-8?B?enFJaktiNkxoajdpbTVZSmM0TXhxWGROeDdSMWE0K1pNZXhJSEZ2TUlrREcx?=
 =?utf-8?B?ZnI0SVQrTkNDd1E5T1NMUjBWTXJyb2xoczcxL1J0ZWxMRjBxUHpDN3NpYmZU?=
 =?utf-8?B?d3JPRVNyOERIL1B5Nm84TktDRDJRb0VmYUZtSW1wVWFia0J5TU1aSi9wL3F3?=
 =?utf-8?B?QzdOZUlkL0V4aXBLTnFNUnJZMzZkVEtlOVJjWVJyOWtCeHVuWlFzTFBScllR?=
 =?utf-8?B?R0VTNWFqZ0V1dHZDanMvdGhkaXZZUHZPSmJ0cDVocG9LbjYwUT09?=
X-Microsoft-Antispam-Message-Info: 1XjfcQghmSMeLmfL6PSKM2V0bnewTEbyimFIHu+DiynIy9D2GS8LW+c7+JCgJNInRBJgtj2d3fkG0naiWQa4jrr+hdLkOnviCayAS/y0ybYi5LBul6n0Hzkgu0OuMtE1QAgg3Q0/LumSjsLRrTVXSfiHfn/30XqtAwQYwMDSi69cIYVQms7/+7kTxM/kSYbA
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:DB5D2mTbVbmzNPASj8pcYAhNcVzWIUdMqOGp97EsSgDtkj3wDRxoXVSL1A5+Kzl3XxBH6Ri6+Bz8nM5eWy7OjXlkUoHnXeH31Mwwq2dePh8ozoIbbgPNOoi5WWWuupA8c0RpsxaKgg9/TvlOJ0WyJwQZMaK3nJDWXd+qMoue+o9oUhFadQnuEYaB6196wE4iuEyjQenu/viVwX7O+fMZgnORPb3hn/vr9WXjzXeckC2l0BvDhfUH7CbSBqnNXiyk4eval7JUM1i8ykAH/ym/FTj+YB5cZgYbr+m3VMpC5rxhfYioWLtCZ+cVONHO+Yofo5RhGdWsUnz2JPOs15vW8qo+AAw9iCVcuqtI2Y1VHko=;5:B/VHDrqA8aD3xFkuubLpgp7XyRdDzYVbp69Xj6t0gAbRdECP0VHZiqXQHJYpN8VNlS36efJVm2X2+TuxuB984amydfbHRfbnCBB6mL+oOmHPfVFk0ei9cnekPOzJM9sQDYWYCtHNg+f4mp4hBr73+jzjB+932zCe3CWHuknS5G4=;24:Vudm6Gc4McxtsE+kaoFHea6pD19MPvgEMXm47KLrI8HCvY8yVU2NkX/x7m3/WfJ2vJlivlMUvVp4ff+CsrqZ/KxdySvaWS57Lu8dXFSr7wY=;7:4/ilAxfvWNQLlvq2mwqzGgAmUe0reU82SLtJd5vDBQhijeNLwC2GBU29A5NT2zLwpEv2OCsiNaE7xldNkQpwrAgctdPFo6WXtKcY/OgIkuFkLJEp50oC9dM7xV9oZS8NZVEI3tOfl6y8Xv4DoUuW+W/7F2aF0i72TuDh3iu7nSFfGQMdG55G7BDqdHmhroiSOib3dZFEiBwT8tMQQ6h6P406xT+l5hif7YEexwu7Wek/zjaydGiCr2+LDPoRXt9F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:mCWhNEXTZN0uttpqzUgH7PBz6EXK6Zq7M04mkJogiGsOc/2k1T9dBmiSMKtIh5+jFqA08waqNISLC3jE/Zv7YCHxN31SmdbS+r4ZAPo7vAVMseMXSI0jn5ZHHERNvsKLt/IlIbRpNYi9WY8hHqQiBBw+FFnmSAecdCIoxfOZCiw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 09:47:33.5675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdff33fc-7d7c-4290-aa6f-08d58a59c742
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594960381230985208?=
X-GMAIL-MSGID: =?utf-8?q?1594996564493031787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CC Andrey Vagin

On 15.03.2018 03:12, Christian Brauner wrote:
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
> namespace. Since we record the uevent socket for each network namespace in
> struct net we don't have to walk the whole uevent socket list.
> Instead we can directly retrieve the relevant uevent socket and send the
> message. This keeps the codepath very performant without introducing
> needless overhead.
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
>  include/net/net_namespace.h |  1 +
>  lib/kobject_uevent.c        | 88 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index f306b2aa15a4..467bde763a9b 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -78,6 +78,7 @@ struct net {
>  
>  	struct sock 		*rtnl;			/* rtnetlink socket */
>  	struct sock		*genl_sock;
> +	struct sock		*uevent_sock;		/* uevent socket */

Since you add this per-net uevent_sock pointer, currently existing iterations in uevent_net_exit()
become to look confusing. There are:

        mutex_lock(&uevent_sock_mutex);
        list_for_each_entry(ue_sk, &uevent_sock_list, list) {
                if (sock_net(ue_sk->sk) == net)
                        goto found;
        }

Can't we make a small cleanup in lib/kobject_uevent.c after this change
and before the main part of the patch goes?

>  
>  	struct list_head 	dev_base_head;
>  	struct hlist_head 	*dev_name_head;
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 9fe6ec8fda28..10b2144b9fc3 100644
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
> @@ -602,12 +603,94 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>  EXPORT_SYMBOL_GPL(add_uevent_var);
>  
>  #if defined(CONFIG_NET)
> +static int uevent_net_send(struct sock *usk, struct sk_buff *skb,
> +			   struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +	u64 seqnum;
> +	/* u64 to chars: 2^64 - 1 = 21 chars */

18446744073709551615 -- 20 chars (+1 '\0'). Comment makes me think
we forgot +1 in buf declaration.

> +	char buf[sizeof("SEQNUM=") + 21];
> +	struct sk_buff *skbc;
> +
> +	/* bump sequence number */
> +	mutex_lock(&uevent_sock_mutex);
> +	seqnum = ++uevent_seqnum;
> +	mutex_unlock(&uevent_sock_mutex);

Commit 7b60a18da393 from Andrew Vagin says:

    uevent: send events in correct order according to seqnum (v3)
    
    The queue handling in the udev daemon assumes that the events are
    ordered.
    
    Before this patch uevent_seqnum is incremented under sequence_lock,
    than an event is send uner uevent_sock_mutex. I want to say that code
    contained a window between incrementing seqnum and sending an event.
    
    This patch locks uevent_sock_mutex before incrementing uevent_seqnum.
    Signed-off-by: Andrew Vagin <avagin@openvz.org>

After this change the order will be lost. Also the rest of namespaces
will have holes in uevent numbers, as they won't receive a number sent
to specific namespace.

It seems we should made uevent_seqnum per-net to solve this problem.

> +	/* prepare sequence number */
> +	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu", seqnum);
> +	if (ret < 0 || (size_t)ret >= sizeof(buf))
> +		return -ENOMEM;> +	ret++;
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
> +static int uevent_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
> +			  struct netlink_ext_ack *extack)
> +{
> +	void *msg;
> +	struct net *target_net;
> +	struct sock *target_sk;
> +
> +	msg = nlmsg_data(nlh);
> +	if (!msg)
> +		return -EINVAL;
> +
> +	target_net = sock_net(NETLINK_CB(skb).sk);
> +	target_sk = target_net->uevent_sock;
> +
> +	/*
> +	 * Verify that we are allowed to send messages to the target network
> +	 * namespace. The caller must have CAP_SYS_ADMIN in the owning user
> +	 * namespace of the target network namespace.
> +	 */
> +	if (!netlink_ns_capable(skb, target_net->user_ns, CAP_SYS_ADMIN)) {
> +		NL_SET_ERR_MSG(extack, "missing CAP_SYS_ADMIN capability");
> +		return -EPERM;
> +	}
> +
> +	return uevent_net_send(target_sk, skb, extack);
> +}
> +
> +static void uevent_net_rcv(struct sk_buff *skb)
> +{
> +	netlink_rcv_skb(skb, &uevent_rcv_msg);
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
> @@ -621,6 +704,9 @@ static int uevent_net_init(struct net *net)
>  		kfree(ue_sk);
>  		return -ENODEV;
>  	}
> +
> +	net->uevent_sock = ue_sk->sk;
> +
>  	mutex_lock(&uevent_sock_mutex);
>  	list_add_tail(&ue_sk->list, &uevent_sock_list);
>  	mutex_unlock(&uevent_sock_mutex);

Kirill
