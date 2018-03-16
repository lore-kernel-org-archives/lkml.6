Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELs4YH61+ooPRmsclfB7ipF1pS1nVgerL7vqBy8fG066NvWJ2lt8PnLANQ+FeWR5hLVYVnaA
ARC-Seal: i=1; a=rsa-sha256; t=1521188594; cv=none;
        d=google.com; s=arc-20160816;
        b=i/tDOlNxq5niMQbgKJ2gz0IHiubWqcqrZCa59ocQ7zaVFqi+x0HnJfsUgzThTeY41T
         veSfsA/FKgY7MKlBLakAEYiZForeJJzRV0lq6fj39t2wBZbIXWptGJT5xo5ndlre/rBG
         +HOdfOillA6e4j7J/O+apeqS377h0HZV/EFEgr8HBYeLKlkmmK3Kf6EoPZ6B0fCEbtjL
         gnhOCcKetSHPf8Kn4JFPcEIPI748zGl1f9hKWo9VPkr85Hc5Kh7D1Zn7jaarxupnaEvx
         ia70g9Y9300eX4J64OTNDVTwSr1re2TPIPDs8xQ7EYAc4gJdFZFSzB2Kg01UXDZ5qAUz
         Kt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=+ZRyRBwreinn9cLz63ux0BmDKcg9gC4fCuo4+Cw2B/w=;
        b=Vrw9KQSh1daWXU1ePJXBob2gWBnV0ogUoHLtwfzU+KPkJrgHJDZuLuWisAIdDg6ldd
         ceEeoGIWBep3SVIO8vRaS6y9Imf5E5VfP6hEnwoJWLS29iGUKPac58F2+aa44+tdpXFR
         0A4xWcQwbgr6dTNU05kzBUeJdo7/xbShAeShDpQhs2R0qVwzEc4tA9VGws+T8NgoGprk
         RLNm5d3CB3MypJ9DNYDM5OgKqA++WgWKRl4EN8XzCXxlNlTd00h9yMBMq6IJz1P3zp2M
         jnU+zyRJbxGZnUAHCpxIg/55LejRIyNeQyVGJp7TNpthpSN+onwPHDxnpd304pmG1rsy
         oNUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PxuAv2D4;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.97 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PxuAv2D4;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.97 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
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
 <5779f3c6-7432-a3d5-1199-0b28df69ca90@virtuozzo.com>
 <20180315234634.GA520@gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5a2041d8-046a-bcee-b125-5e2aef8e3fae@virtuozzo.com>
Date: Fri, 16 Mar 2018 11:23:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315234634.GA520@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0172.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::20) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b88c5d-3c36-4710-18fa-08d58b172791
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:MN0CXX4uhZOLL7E2AhG1JCapJXIDHDetG86yFppyjlV1iQ52vSgNVgaELplkEV5iGpqKHqDvvB2tXnESybzderWKCiRx4OAtaoMF+svRULSgPE7HVf373eCCq5IaZKNHzHTSR0yWPGTUSmYw+5Yaj6KJIFD7b+3CHmYb9dkaUKXVAVZcredXxlVq9JOzMb5vcyNd3AaTYLpJg4xA2g6Z8JMu9FTXS6t1RvixtOKK8Daf3fhMaAErv7XtD/K15auX;25:2pXWhYUKBVv1D3GQ6LCmTo82ycuePRSG1I9LTuNh4M5PoY/OqMh8PQJdjq2KTxq7hKCfBDpfTkRJSx4VVXzTHzCgXOiE7pps3MDV/topZxb/nBQ0XwJga6g3YPJu3ofGcp4G5NbpHvpeHfKpmz9ONxjeBs9A5JDtLUrYlDCPoWmheNQLdWCeS4orHMAdeGyjRYTMqNK3wfPYRNrKJXMm36OhBh67hsfdN9bgcefoPlo5dpNHNAUfvxPCPi9Uxq5pKQ3B9ImEo3PdjgmA2bXM8zy4Sf9jeSmka1I/bkronHD2T7l25VgL+3meCtbk60p1CViGFr2EQM8SaaqzWTxZHw==;31:+B65zePWZt5DUiU00qAvurmoA4p7TWwkqb2JrMwSZrIHxssFK21K2wYJGoUtYXkLRuQ5KmdUDuuFLeFiy7yo1gxZLONz7pWpDzJpRa7UWkBVxrhBPsTPCqUPYHmp5Z4VWbxWUa6VQrZXQLXDWWxraKMls8bD6BQll3e1E3wFhlnoqYClRVFhY036mi+2r3ZQVqx83a+EdPQhO2Dt71jzbHhXu2r9ZrzK2dDuL/amgtg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:/7wKz23IM7UvUgok8POvDKz8EcbRD7ynIIfUWzCwmr+Uw8hTZ2hNJVkTmUbAW4RrwDHOd6W8mu9JhnSXtTCGbVD/olphVDHN6wa/f7YEj0Vb3/c/f5CvMYRhig+xWxraMidsg8U4G4AkS2diTEtHaBMvcRbfpj1rg63svJxQhX81A9PVIKnf88wVmVDcbV/CXkzmrAPo5+qtli4IZzxLEWx3dvHq1J2uUrF0JzioGYG+a0pW26tpYLhc4Dj1dzruyC3UCU3naKDNGM8BEA+C6Xd/sWCGvhrIT6Fn1IO60yZRXBfVoGr7FTEf6MKZ3G5IW1z0XgZ8vVoA4jLvaHOI298BdJ5qV3KoyDCn5wssZHZsIXOjfnp7OcQVRQU1w2Nl6fqFJ9uTCkfziLaSWGU/pB9HtO3mR84Y4SzQTLX6IK5STnLBUsEPmmH7pUuI0cA1p5uuKm4+BV3ZZxorN1NDcjQUOB+9SmPp2hSuhndk/anS7evlSKRlbtWO8B+cUr/O;4:ZBfMh4HU1qq+182dzGpDHNC+LvnD3IJvtB2w5zLUtxZMWXIzzf0bh1xnJwI+gySP1L9DM2R7mBaW6F4X9MlZ63+nAM6EN61FdRRse143o3mPZpSynMR/FXnk6Jvxrq4aj0kWGU1SzQxl+ojTYhtKLeA4s0GCbRTmzEbhzjSC2L5YjA+MNvlYsbHaEd0S2WU7g3KANm+e9ISps2N9VomfgxsbYDvB9YNJlR94lpT1QF+NFg/hAuHwL6+H47M88Vee1LlQevAvTwo6T3ctKNlhd6GGOwMdHqZHgsj8TEYnU2tVtose/zMwt97Mg+Fgye70GfTB5XpCBo0hJYZHnQBb2abgjTZpNmUhuA+1fiZG2x3PcYz1OJJOFsQmOo7FrJ5L
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13427CB5C80F1C63F3527AC7CDD70@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(788757137089)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(366004)(376002)(39380400002)(346002)(396003)(39850400004)(199004)(189003)(65826007)(478600001)(50466002)(86362001)(68736007)(53546011)(106356001)(16526019)(6246003)(31696002)(64126003)(305945005)(229853002)(5660300001)(6486002)(6306002)(8936002)(7736002)(77096007)(6916009)(2950100002)(53936002)(31686004)(15650500001)(26005)(6666003)(966005)(97736004)(2486003)(76176011)(4326008)(52116002)(52146003)(16576012)(316002)(105586002)(58126008)(23676004)(25786009)(8676002)(47776003)(65806001)(65956001)(66066001)(230700001)(6116002)(36756003)(107886003)(386003)(81156014)(81166006)(59450400001)(2906002)(93886005)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6c2xvZGltMG0wMS9MY0F6Q3ZhV3N1Y2g2?=
 =?utf-8?B?cmdsZDFYQlZEUTdMYUFVdk0rbHU5cklXalY4TUs1YStvem1JSkRTSnZsd0F5?=
 =?utf-8?B?eTJvK0ZyRFdPNmpNR0lBNk9NaTlhMlAxSS9tZmszL0p3UTRYU0NSWmMyanhw?=
 =?utf-8?B?QmsvYUo3RkFsUXNsZEZRdHM0Y25uUjVRdlNQVzhrY2VMdVI3aVcyck9BQms1?=
 =?utf-8?B?NmRjcGo3aVorUW9EdmpWMnVFMWRYMkZiZkZNTDVlaVorMFNCUjdHY0FzS1Ry?=
 =?utf-8?B?QnVTMVViWGpNd01XdHJnWXBnVkxkalorTWZHblIrRHh0R1JwVnFCSWo1Q1cx?=
 =?utf-8?B?WFZDQnFlaVl2K0FMWkc0ZEhMaWsrU0VaWE1rWU56OFhPY1hWRDJXSGkvUnNZ?=
 =?utf-8?B?cjNqMTZZQS8waEU3dVRueDZNaTNkZEFrdWRRV0FjZUR1eG1CSDd5UlNkSDdW?=
 =?utf-8?B?Nm50NmY2ZXg2eWN0TU8yS0xOcWZldWJRMTVYNDZtZFUvS0Q3dWdOZXR6blBa?=
 =?utf-8?B?LzYraHBJUWdmbitpelRJY0xoQ0Qwai8zaWM5bVhxWk0wdzFXeXhvaWRXYjNk?=
 =?utf-8?B?L3VxMkRobEJjam81bVlGTThFb2tPRGkxaWpqM2hNR045Q1IzYlZHVHBrOGty?=
 =?utf-8?B?SFlhL1RtMW1vZUw3MFBYWVU1ckZtY3VzR0ZuaWRsWHZIdkVIdDMwRzZNZEFP?=
 =?utf-8?B?eUovdGFkS3dDdWk0a1MzbDZCdXNHb3VYZjNGWWhqM1cza2lRTklNL1NWaE5P?=
 =?utf-8?B?Q1BxZDVFWXdWOG9Tcm9NblZSRVlGMkRxcHZYQkNQTlpOU2hMWE9hTldOSkU2?=
 =?utf-8?B?dW5iK2tiMlFNTHNxZVRDVlgvNTYwWXd5OThIWnByNTZOVzlQdVFXWnNoOXZn?=
 =?utf-8?B?ZnJPYWNOWkdnSG9UNjB4L08wVDZJYWh6aWJzR0IvYXY4eFIvNmVCcjd3Z0J6?=
 =?utf-8?B?TEFieHdBeS9mTlRqR1phUXZVN1NHeDVrZXIzSTN0Mjl2MWNHeGpta3llVHph?=
 =?utf-8?B?ck51NUhzWDBxUUFXNjhhZkhhYUtMVG9KOUZwVDUxdThwdGZkbXJZTHF0RVBV?=
 =?utf-8?B?bU9Ja2YwejE5UDZQalduUHNBZ01ScGt4WEFiZklFa3Q3TFlGZXBpMXVtMzkr?=
 =?utf-8?B?QUdBN1BEejlvVCtJclRtYUs3VU9Db2RjbVRiZDZGZU41Kys5ZVkwU3JIelY0?=
 =?utf-8?B?dkJpNkpmTlNmeENENWdqR1lNbU1LRUhObXdoTVY4RzJ5N1lHb1pDdG5CTWJT?=
 =?utf-8?B?eG1ickppNjV3dmFhejZTRE81OXNyTythaHAyWm9QRkRDZEhMQUwrZ1NNbXZr?=
 =?utf-8?B?YUdGQ1pVcjlQUUxuZW1oRTZGQWVmSjlkeWhWMjlMVTRCdm9XanorUmtkZnp1?=
 =?utf-8?B?Mmd4ck90MEtWZStNSkR3T1lENTA1NDVERWxHa0JXYWkxaUJyTUtmVmorSUlq?=
 =?utf-8?B?ZGQ3MDAzOGNMZTBxMTkxdWRmamVIejhRVEtCRWdJa3FNRDhtclE0YUFFN2VS?=
 =?utf-8?B?aks0U01PbGxnN2pxalIwc3UxSG50TElFNzQ1MzdKSTd5MGdlQTVld3RDUWNu?=
 =?utf-8?B?N3c3RWFIN2FSWFZ5YTFkMkFqY1pRWVB6ZVVkR3R5U0ZEQzRSYzhIWUl4UUlG?=
 =?utf-8?B?MCs5bjg5bGFrOENMVFFKNHZKV2d4SHptaDZxMXV5Z1FnZjkxUVIxcXVKQzBT?=
 =?utf-8?B?T1laWXA3eEVBYXhiZGhsOGpFS3Q4ci95S0FCaVJtNU92RmI0elQzOTlISnhD?=
 =?utf-8?B?SDVESzBzVnk3cjE2YVhqY2RBYzRqeSszRmg0dGVGTCs5bFpmd3JqWUJHS091?=
 =?utf-8?B?UmlBWWNqTXAvM0FENHRJcE4wdE5ja0xGR3RKc1g1VDJsOG82dEQrZXBaZllM?=
 =?utf-8?B?UGJTMStWTWpEc3lGT1Z1Vk9neGRRVnptcmozTkxUWGZPMGZvSzllRVhtN1JO?=
 =?utf-8?B?T2M3RUZPS2VHQXFpTHk1aTEvWjdxQjhSazQ0TW1XdVJDdXNsbXVKalRWdVpq?=
 =?utf-8?B?VGtCV0RmWFlSMW9DS1hVZmlrc3U1dWJJSklHSjc5S2JrMGEyM2dwZkhjMjBD?=
 =?utf-8?B?OEJST0QxUStTOG9nUXdWWlRQUTBwZUExRVd5SExERHRjT1lhQmNiaFp5OXpR?=
 =?utf-8?B?QnNUdz09?=
X-Microsoft-Antispam-Message-Info: StORIQTWq7d2DnH8OgyPWgU5fRrZbUfDlBbChaauyN75238LKibYFfydtWKQ2VXrQ1HwF6VcPBwzF5eHuqyX+UtK0yRGk0JXwmZskoUjNdzsJP7cB78+tiZH//c1ojgmLS6qpeO6faApRKbpDj3aLPDcejcbPPA4locHZkhbb8ntbfZkhvuEM4HcLuMpKHkp
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:Tt/pBxYOS7Vv28bAQD/e6ozwHiS77nv9SrcL0pT2gJ+cf9QuuTL2Yj7MWBimZhhVnML1kulrUPjqxwE1B2yk8/G7IgdPKiGuF2Rr9IkwgHSQ1KxzjbGk0hGVec2ymjXt9ia7AhVv+nnXVJEazbSO0onTY0vwUgamvDFsYylKtJ1EHw9JgNDt8zSylDQNXLbBEHM+f1xZEr/zKriGQRA1LItKQbiTjWQAONP1hdkMjr5wx+3P3KFxFIdXxIJiTNAqao6ARm4LQUGCGXiXV4GNvKJD6tA130pEPy+/M3exdVkVS/Mrfu4HwaXt4NgFuPwsmuAJw3B9avU2pQzewCwzbwgpXXTmb7pZIctlAXc4dDg=;5:1YY1L05tyrU4wlf15v0doTBQiNkz3ZI7BpZ1Y/Etah3meGtWPPTwzvOJFTeWy7AzNOznyrfHlnqAHkHE1CUpS1yPLSIZJPN/02mQfzsSdyWayq4F23gb3H5xQ6j7kmcL3Sz4bNCHPKEw/WKh/BYrRT5qCDZuWvKpmmGWz964Elw=;24:zcfxoAJZa2XatmQ4EjvPF/l1tqHmMXqOn2hm9g9dIP9RFRSvGUpwmcAGvRQHyI3bwoSyIDicxOlswrvPdr/xjds5t38tMwmGYOdf+hF6sFo=;7:oCLfnI5IQ6kWxjHdb+qvos4/VQ4fyNNuBBz1vEEScwdA+7yXaP5aUoa1j33aRnqKHkPLyQOJ0l6vKbg7uoOkArVoMmXxcAA3CnmBeTsB+zSsNEu2PrDShS9bKZuj/d3ss28Y9hcIzNys2ojkBpIVZ6BF8a1QJrRrddU09HmFCCahVnWfeItI5kJHH2MucySukXZfs6Gkb/Ryy8vLYxTE+fuN7qKrE3DN+Db0SsIT3FoG8yt2kltyjoz9EMTV9fYz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:Owj06vFMWZq8FnXZihiwX0jPaSBfvFa4M9wF5FnpMs8vghkHxCXm2Sdvg9OJxhmlO3shUlqTTfJ41L4hKWhiDUdxIk50wTY5ppX0wjEq7OC4P1ajpKqGKAZCI5mJrg+my9UBN56eYsR4Aox14o1nKatwKZItGmEleiwN6aK20xk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 08:23:10.0247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b88c5d-3c36-4710-18fa-08d58b172791
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594960381230985208?=
X-GMAIL-MSGID: =?utf-8?q?1595081851768059598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16.03.2018 02:46, Christian Brauner wrote:
> On Thu, Mar 15, 2018 at 05:14:13PM +0300, Kirill Tkhai wrote:
>> On 15.03.2018 16:39, Christian Brauner wrote:
>>> On Thu, Mar 15, 2018 at 12:47:30PM +0300, Kirill Tkhai wrote:
>>>> CC Andrey Vagin
>>>
>>> Hey Kirill,
>>>
>>> Thanks for CCing Andrey.
>>>
>>>>
>>>> On 15.03.2018 03:12, Christian Brauner wrote:
>>>>> This patch adds a receive method to NETLINK_KOBJECT_UEVENT netlink sockets
>>>>> to allow sending uevent messages into the network namespace the socket
>>>>> belongs to.
>>>>>
>>>>> Currently non-initial network namespaces are already isolated and don't
>>>>> receive uevents. There are a number of cases where it is beneficial for a
>>>>> sufficiently privileged userspace process to send a uevent into a network
>>>>> namespace.
>>>>>
>>>>> One such use case would be debugging and fuzzing of a piece of software
>>>>> which listens and reacts to uevents. By running a copy of that software
>>>>> inside a network namespace, specific uevents could then be presented to it.
>>>>> More concretely, this would allow for easy testing of udevd/ueventd.
>>>>>
>>>>> This will also allow some piece of software to run components inside a
>>>>> separate network namespace and then effectively filter what that software
>>>>> can receive. Some examples of software that do directly listen to uevents
>>>>> and that we have in the past attempted to run inside a network namespace
>>>>> are rbd (CEPH client) or the X server.
>>>>>
>>>>> Implementation:
>>>>> The implementation has been kept as simple as possible from the kernel's
>>>>> perspective. Specifically, a simple input method uevent_net_rcv() is added
>>>>> to NETLINK_KOBJECT_UEVENT sockets which completely reuses existing
>>>>> af_netlink infrastructure and does neither add an additional netlink family
>>>>> nor requires any user-visible changes.
>>>>>
>>>>> For example, by using netlink_rcv_skb() we can make use of existing netlink
>>>>> infrastructure to report back informative error messages to userspace.
>>>>>
>>>>> Furthermore, this implementation does not introduce any overhead for
>>>>> existing uevent generating codepaths. The struct netns gets a new uevent
>>>>> socket member that records the uevent socket associated with that network
>>>>> namespace. Since we record the uevent socket for each network namespace in
>>>>> struct net we don't have to walk the whole uevent socket list.
>>>>> Instead we can directly retrieve the relevant uevent socket and send the
>>>>> message. This keeps the codepath very performant without introducing
>>>>> needless overhead.
>>>>>
>>>>> Uevent sequence numbers are kept global. When a uevent message is sent to
>>>>> another network namespace the implementation will simply increment the
>>>>> global uevent sequence number and append it to the received uevent. This
>>>>> has the advantage that the kernel will never need to parse the received
>>>>> uevent message to replace any existing uevent sequence numbers. Instead it
>>>>> is up to the userspace process to remove any existing uevent sequence
>>>>> numbers in case the uevent message to be sent contains any.
>>>>>
>>>>> Security:
>>>>> In order for a caller to send uevent messages to a target network namespace
>>>>> the caller must have CAP_SYS_ADMIN in the owning user namespace of the
>>>>> target network namespace. Additionally, any received uevent message is
>>>>> verified to not exceed size UEVENT_BUFFER_SIZE. This includes the space
>>>>> needed to append the uevent sequence number.
>>>>>
>>>>> Testing:
>>>>> This patch has been tested and verified to work with the following udev
>>>>> implementations:
>>>>> 1. CentOS 6 with udevd version 147
>>>>> 2. Debian Sid with systemd-udevd version 237
>>>>> 3. Android 7.1.1 with ueventd
>>>>>
>>>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>>>> ---
>>>>>  include/net/net_namespace.h |  1 +
>>>>>  lib/kobject_uevent.c        | 88 ++++++++++++++++++++++++++++++++++++++++++++-
>>>>>  2 files changed, 88 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>>>>> index f306b2aa15a4..467bde763a9b 100644
>>>>> --- a/include/net/net_namespace.h
>>>>> +++ b/include/net/net_namespace.h
>>>>> @@ -78,6 +78,7 @@ struct net {
>>>>>  
>>>>>  	struct sock 		*rtnl;			/* rtnetlink socket */
>>>>>  	struct sock		*genl_sock;
>>>>> +	struct sock		*uevent_sock;		/* uevent socket */
>>>>
>>>> Since you add this per-net uevent_sock pointer, currently existing iterations in uevent_net_exit()
>>>> become to look confusing. There are:
>>>>
>>>>         mutex_lock(&uevent_sock_mutex);
>>>>         list_for_each_entry(ue_sk, &uevent_sock_list, list) {
>>>>                 if (sock_net(ue_sk->sk) == net)
>>>>                         goto found;
>>>>         }
>>>>
>>>> Can't we make a small cleanup in lib/kobject_uevent.c after this change
>>>> and before the main part of the patch goes?
>>>
>>> Hm, not sure. It seems it makes sense to maintain them in a separate
>>> list. Looks like this lets us keep the locking simpler. Otherwise we
>>> would have to do something like for_each_net() and it seems that this
>>> would force us to use rntl_{un}lock().
>>
>> I'm about:
>>
>> mutex_lock();
>> list_del(net->ue_sk->list);
>> mutex_unlock();
>> kfree();
>>
>> Thus we avoid iterations in uevent_net_exit().
> 
> Ah right, but I only added struct sock *uevent_sock to struct net, not
> struct uevent_sock. Thus there's no list member in there. I mainly only
> added struct sock to keep it clean an aligned with the other sock
> member. We can revisit this later though.

In my opinion, we shouldn't leave the code in inconsistent state just because
of it's not interesting for this patch. There are two logical changes:
1)add fast-access pointer to struct net
2)implement single-net uevent

It's easy to do 1), and this may help further reader not to be confused
by the inconsistency, so I don't see a reason why we shouldn't do that.
 
>>
>>>>
>>>>>  
>>>>>  	struct list_head 	dev_base_head;
>>>>>  	struct hlist_head 	*dev_name_head;
>>>>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>>>>> index 9fe6ec8fda28..10b2144b9fc3 100644
>>>>> --- a/lib/kobject_uevent.c
>>>>> +++ b/lib/kobject_uevent.c
>>>>> @@ -25,6 +25,7 @@
>>>>>  #include <linux/uuid.h>
>>>>>  #include <linux/ctype.h>
>>>>>  #include <net/sock.h>
>>>>> +#include <net/netlink.h>
>>>>>  #include <net/net_namespace.h>
>>>>>  
>>>>>  
>>>>> @@ -602,12 +603,94 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>>>>>  EXPORT_SYMBOL_GPL(add_uevent_var);
>>>>>  
>>>>>  #if defined(CONFIG_NET)
>>>>> +static int uevent_net_send(struct sock *usk, struct sk_buff *skb,
>>>>> +			   struct netlink_ext_ack *extack)
>>>>> +{
>>>>> +	int ret;
>>>>> +	u64 seqnum;
>>>>> +	/* u64 to chars: 2^64 - 1 = 21 chars */
>>>>
>>>> 18446744073709551615 -- 20 chars (+1 '\0'). Comment makes me think
>>>> we forgot +1 in buf declaration.
>>>
>>> sizeof("SEQNUM=") will include the '\0' pointer in contrast to
>>> strlen("SEQNUM=") so this is correct if I'm not completely mistaken.
>>
>> The code is OK, I'm worrying about comment. But I've missed this sizeof().
>> So, there is only 1 bytes excess allocated as 0xFFFFFFFFFFFFFFFF=18446744073709551615
>> Not so important...
>>
>>>>
>>>>> +	char buf[sizeof("SEQNUM=") + 21];
>>>>> +	struct sk_buff *skbc;
>>>>> +
>>>>> +	/* bump sequence number */
>>>>> +	mutex_lock(&uevent_sock_mutex);
>>>>> +	seqnum = ++uevent_seqnum;
>>>>> +	mutex_unlock(&uevent_sock_mutex);
>>>>
>>>> Commit 7b60a18da393 from Andrew Vagin says:
>>>>
>>>>     uevent: send events in correct order according to seqnum (v3)
>>>>     
>>>>     The queue handling in the udev daemon assumes that the events are
>>>>     ordered.
>>>>     
>>>>     Before this patch uevent_seqnum is incremented under sequence_lock,
>>>>     than an event is send uner uevent_sock_mutex. I want to say that code
>>>>     contained a window between incrementing seqnum and sending an event.
>>>>     
>>>>     This patch locks uevent_sock_mutex before incrementing uevent_seqnum.
>>>>     Signed-off-by: Andrew Vagin <avagin@openvz.org>
>>>>
>>>> After this change the order will be lost. Also the rest of namespaces
>>>> will have holes in uevent numbers, as they won't receive a number sent
>>>> to specific namespace.
>>>
>>> Afaict from looking into udevd when I wrote the patch it only cares
>>> about numbers being ordered (which is also what Andrey's patch states)
>>> not that they are sequential so holes should be fine. udevd will use
>>> the DEVPATH to determine whether the sequence number of the current
>>> uevent should be used as "even->delaying_seqnum" number. All that
>>> matters is that it is greater than the previous one. About the ordering,
>>> if that's an issue then we should simply do what Andrey has been doing
>>> for kobject_uevent_env() and extend the lock being held until after we
>>> sent out the uevent. Since we're not serving all listeners but only
>>> ever one this is also way more lightweight then kobject_uevent_env().
>>
>> Yes, extending the lock to netlink_broadcast() should fix the problem.
> 
> Yep, send another version of the patch but forgot to CC you, sorry:
> https://lkml.org/lkml/2018/3/15/1098
> 
> Thanks!
> Christian
> 
>>
>>>>
>>>> It seems we should made uevent_seqnum per-net to solve this problem.
>>>
>>> Yes, Eric and I have been discussing this already. The idea was to do
>>> this in a follow-up patch to keep this patch as simple as possible. If
>>> we agree that it would make sense right away then I will dig out the
>>> corresponding patch.
>>> It would basically just involve giving each struct net a uevent_seqnum
>>> member.
>>
>> pernet seqnum may have a sense if we introduce per-net locks to protect it.
>> If there is single mutex, it does not matter either they are pernet or not.
>> Per-net mutex may be useful only if we have many single-net messages like
>> you introduce in this patch, or if we are going to filter net in existing
>> kobject_uevent_net_broadcast() (by user_ns?!) in the future.
>>
>> Kirill
