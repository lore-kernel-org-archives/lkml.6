Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx491QxZyS9ewQBE9i4dnLEAm9du3/rPa8vhzlVuf8bKDDc6pom6NTVv8O06HXE6vifpSDQ7/
ARC-Seal: i=1; a=rsa-sha256; t=1524477678; cv=none;
        d=google.com; s=arc-20160816;
        b=halef6E6xo06dYcGy77MdLdOA8MLUsaQne9NXbd9Nq+kJvR+JdzBHkKm7E7WK9EArD
         rRYDrxTw+Xw4X202gXN1luJuN55aIQCNmyE4GL+DmQiQMJr5lpuS36NrDbr/S94FHyG1
         kzk2mGkYqG/6YVh6obkjbt50CXCW9bOafxFaUoo0zBKKbG1lypcIkeLe0s3W8yo0wuw1
         E+uRNuZsCRdHSqnrmDvCst2cfOEeOmjetr6kzDPitxdbj9nV2rFSrpRqzETZRA0pg627
         4wrb7rgzQPH9ctnt01rE+AtBzgyAQ5e3/cJX/KpYs7N+XcOmBYVi1nHoWaB6AmDwUXuR
         usvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=+foEvpa29H0R3IMhAgbQM6vZ0Xk5LPenwCefqE2SR+I=;
        b=vmsx5DgzTOiKiHzK3jv3k0NhBAmUyVDlzNadG70YJJm2bRhfQwtdWERDyFR5TU+Z7X
         2Q0HG4rAIwNA8c2DuewHqW6Vx8GSHct+0d1NuBqzL5TxXBTvX2cxwN6ASSOG4pZr9C7L
         Gop/oIhtznoW7mqsq6hx7yFwWQEnnguQb3jsXlum0GE4QDp8QPe+GsPYE9dSx/AOcsYs
         YLBpHaky8hlb8/56JbpcfYZatvANh9QmVLtjsOgk0x2mErXivSz8txuCH7ST40RfTeRo
         s6n4vVrMaP5g/aQ+xlgu/h+toBpNyVGsH3RZQhAf+AZuKBganr8Yhk1SczLudy7GchoV
         IILQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Nsi8Zv2M;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.104 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Nsi8Zv2M;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.104 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2 12/12] mm: Clear shrinker bit if there are no objects
 related to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399129187.3456.5685999465635300270.stgit@localhost.localdomain>
 <20180422182132.c4tqkyy4ojgi7l7q@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <17b76fd4-ce80-50cf-6149-1f3908081ae7@virtuozzo.com>
Date: Mon, 23 Apr 2018 13:01:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422182132.c4tqkyy4ojgi7l7q@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::11) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:UdquOIe5lYhGdjWb5weLyay4f3NLTmNQMmXRqtnGHmIOJExgyPumzyIlb7c+QLLNv3N9VnPzOi+eSHKX/v6fHyqY+9Z+Jo86h7+2Ky1Q+4uHeHYv/4IExu3lkGmLhpZ7eW2/8kte5ZvoYX5ySktj6BM9AlPi6YJCxQZs04nfDauMIDEIiAZYaoNPddha6s6/STk8sOWxSct3iQrZ+CHsnO+Z/3kRtQBhd/0MBBx5KTZ9uLwBVQTOFKswJZDjse0q;25:6jF/9qgXpCAiB3qGiaYMAg7ucyJyram3Dd6dEkO5WlSr85SZ6SDhGFYcDCJ4XB/LeT1sLy8BHvg1NYKL6zJyB70OvhEnhinRsJTj1TPPVOeBJqgrp+U+lN5vGJlM48WrJq6lEDhJyYrEAcok3iOWxzuhpJhZjvLLdniJzB1BVQEagGi1XmqA7DMWdJP9Y2sAwnhLN3raqqdsDEc0v1muBmbQD4w79om45BdJPrGBBgEnH+x9ws2om4DJ1UgSBbVy5OWVZaYaIh+agboYmHjzrBcHmX3V50QtUY59su5R43ER475yR/JTqFMrppbcwvH2VcQlLB+br1Rjl6ZNYNhp3A==;31:WtVNbW/NwR3jHuJsHV0j4b23Hfnj4wJoShZiAD/DEEXW+drtbiwsDwUT2f9soksawb1k7SBVHvZSSob433ddocJq5koiyCetijO9W9S7AjNwOAoc6YG1IDgQ3RPJCn6ndNoknzaai4uF6wyflnPnlFgdpzQk9y4fxoJsny3pI4kQycsQ6+e17IAObRrGzjfHRKurgOvxkkvviz0Ext+dZoytA02ynVrUW73eHHGnxxo=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:NmWTjvFU76XQp87/vC0qghHqJM+BYZG4WUQ55DZUtGQy06QZpPdDH4tFJdqfuSZb6aSZqI+xJtQfU5CzQZCGPSVa9NG2daBS0DKr+ANAgvPqQrgpBL4tPsB0dwNu668sDCQendaHW2avU9Nll3jfitbQDcTiaKXCZss6t/+t21SPIpIo+LdJk/s/9Wvgp8DHToIANjWbyv8i6R581nOjKh/0PmsiwDzREbezEpNOH3BwxRhtUJd8X12/0F+lnD2yUNMstHuMcXTzNaUkS8kLShSO356rs7Gr45xbFEJ4BPvYk8mJB8PpIYS/3j9SOBRatni6IQ+64BZM36z9rRn88ds7KVllGMp2Z6AZtsdhJxOzKymkvvjxAXvcUkA//EtgIZ8B8lwDTS3wD28mujjVohHeZ64rlCf1hAwvC25b1hymKlGM1lCmz24NcciEMr0kcoqBc5g/BIn0n3WVn9wmgTnSoZ8J8sUvMqjIhN+n7UzrYObLrytizbV2qXEW+ELd;4:q/paA/e7q7aKcIfAZNKKOViC84WYBEzEEvKYIDEHPzik+uW3bJR1/RWgQifobOaasGCZofT6SRqlNjOB+MKygdEe9woAsZ38R9GcyQKPcJAAlvc76Nv58KYjr9VFXXuhi3WRgYUPaJLNObNqkr4Rr+SOrLkdv5JekQcexCKX60znIDSyDJtEYPEsr7V8jcd3A4a2HaZFaQcRw31wVevLSdJ/c04K35N3FwfEP8hBUYeOhM2MksGDo/8IDfybJDBFhanensRlN4rl0XHH8445Tw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13305E660C9A5FB85B8C00D6CD890@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(396003)(376002)(366004)(39380400002)(346002)(25786009)(50466002)(59450400001)(26005)(386003)(52116002)(52146003)(23676004)(2486003)(6916009)(6666003)(76176011)(64126003)(3846002)(65826007)(2906002)(4326008)(36756003)(53546011)(86362001)(31696002)(5660300001)(230700001)(6116002)(53936002)(47776003)(77096007)(11346002)(446003)(305945005)(7736002)(956004)(2616005)(478600001)(229853002)(476003)(39060400002)(6486002)(31686004)(8936002)(8676002)(81166006)(107886003)(16526019)(65956001)(7416002)(66066001)(65806001)(6246003)(16576012)(58126008)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6YVpPNUtKZFFFa1BjMHN0QitlUkp5QmVB?=
 =?utf-8?B?UXMwZGErRmNEWi94K0xqaEdQMElFZjJid2d3bk56ZUxNaFMwVG1SaDl6Y1Er?=
 =?utf-8?B?Zmd2QVNwMTM2KzcyMFJLYzBEOUxQaWpTdk5lY0tWMUl1Sm9TL2t3eFNCMFcr?=
 =?utf-8?B?Vi91MFRPeFRQcXljUWRhL1lGa2Y5ZlVKc1dHeXhTV3BLbk1rbjNRMzBGdG9o?=
 =?utf-8?B?RlpmaDUzTGE4SlZkbVp4RUpXS1dTcUJub1BNV3ozKzVLN2IzTERkakw5L2JN?=
 =?utf-8?B?OFo0K3p0QnMzN00vWDAvOVU4UGd4MmdIOVFsK3RwUSsyTUJlL3VmRGFkUUtK?=
 =?utf-8?B?Rzl3Wkl5dUFiTkM5THFEZUhTOTdvY0dicVJFSFJwcTdEc3VlWWdhTEM4eHpF?=
 =?utf-8?B?K0hjaFhUcU9TWWVrQ1JkazRFT1lmd01OUkxCZ0kxSTloYzRRdDBtV2hwVkxE?=
 =?utf-8?B?NTgxYlVROU9LYUI2VWo0QUhXTEpVREJqS1U5bFVJK25mWWZTZG83aFYraFNr?=
 =?utf-8?B?eDkyU3prSFJRejlJakpPNG1LOWQ1NDdzYVZjclgwYXZFUEpRK2JDMzdFT0ZY?=
 =?utf-8?B?U0pybUFCQkpBcFE3SWJyUW44ZHZkZGtQaE8zSnl4d3luOVRHbHJGSUErb0E2?=
 =?utf-8?B?RXBiR3lRV3VYWnhoLzVQbmxMYnpYNGt1NFZQelpIZi9pK2hOaHBLYUhLLzg3?=
 =?utf-8?B?NEhJTGNnS2VZYXQ5TnZBT0FpcERPNnUwb0FTS0ltZzFHM21yMkg2WEE0U0xm?=
 =?utf-8?B?K3gzMUlya1FnNU05bEZ3WWJTQkZhNVBSMDVla01yRWZqSGVRcWJjTFhFd1lr?=
 =?utf-8?B?djYybmRuMWJRVU5mRDFWRHBVVFJkWUFmenBmR1QwWEJUVzAwcnAzRTNTdDh0?=
 =?utf-8?B?YjROcXQ3a2x1OUZNWTdWNXlNTzdkUWJSY1VMU0gwaURVUTRtRlZoSFYrY0FP?=
 =?utf-8?B?Nno3cHhrd3Y3N2c0QUNTNmwvWG1QYjZHZGxaVWFWZEtlcmVxVzM3cURsV3Fo?=
 =?utf-8?B?WEtFTjB3Njh6OTZ6ckczSURSL1FqRVNwWkhKSlVJeEtqUSs5QjNNOGhtYmUz?=
 =?utf-8?B?Y1h2SGs2dWZaMmp1NHpnR3pMWFU3aW82VmE4VTVHTGxxLzJJL0VrOWpvTjNJ?=
 =?utf-8?B?UUQ1MDcxaVV0ajRta1ZzbURZTExtZkpMQUJXUVY0Q1BFREh6bC9jaEdEMTFG?=
 =?utf-8?B?cE13UThHUHRPMkFiQ0w5Sm5FNHJSVUFkZDQxNjdFMFk5OVNsS3h6U0lldXZa?=
 =?utf-8?B?V1B6UXdvdmVvMGNLM1orL1pNTEZSQ1NyN25YbHZCRU44YzNHRm9lR2h0MjhT?=
 =?utf-8?B?UWEyamEvZkRLeHJlNUFvSnBRV3BPWmd3YklGTlErNEV3QmExUmhUNkV6cmxB?=
 =?utf-8?B?N2EwOXl2Qm5MaldkcExZZW1SbU52SDQ0TzM3WkNSWTNxd3U1YkhhNytZZXNy?=
 =?utf-8?B?MmFKUGIvT1NxQ1NYM3BjZ2pKU2NMT3NvNjl3V1VvVjdJV1JjRm9CblhhckJa?=
 =?utf-8?B?QkRsRHJUQ0xBVkNnT1UvdXBtL090TnBGQWVOa0JTRGZhMXFLMnVKODZBdmVN?=
 =?utf-8?B?NXRqc1dwOW8zUStVYUFndlBnT0dKeDVqVE5VUUs0NUU1MXI0MUVIM2VKbHlU?=
 =?utf-8?B?bjByaGVqR3NobjNub21JNEtPMlVBMGQ2Um9VaGVhTWxlVXZxM1U0d3dGeTFl?=
 =?utf-8?B?UENqQ3g0VVZtQnRjQ3RrSEV2dmdTZGJ1U1RpaGw2VXE2M3NJQ0RXcXRQakdl?=
 =?utf-8?B?UWR5NkZZWUVNTnFwU1ZRN1ZkbkUyUkF0RVlIS3JxdDA4bkpiWWZua3g4U0U5?=
 =?utf-8?Q?YN8lnVjz5R5siyi?=
X-Microsoft-Antispam-Message-Info: ICWDcDV074II2oMt2Itr9lGSN+Oo65GZ/XplipAAKUlwMXK70JYHM0SlIASg8u1FoDSlZ4hCwd+rU85O34cHZX34adns07EboBritwaPEO48n1aYg8XzRQ553mbo7x370Kdh4YVUeQJNteQj6Iqb6OhsEIiopUfKgC8IcpjH48dOJ6N0VZIv2pQFVy8p1qS0
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:2qxWVC44QrIDgHIA2sfPb3qF2e/bh4Fclf2wlBKq6Nn04sbduc4ao/SEiJZq+3Hdhkz9rXDhPDANHES2QZpDj21DSsgWeuOrbis8ntMwGDYKoKw+mDcN2wL4yI8EamC0Y1U81dlqSNu4JtTUY7O1St8W36QEFB9oD5Hg/Vq0+bHdt2FbhGdOIlLSLwcfFxoKDHTe0bOctGE7Py9vLIdnSrE7ChbTdkLPd/3bVgWno+RuMsmltncKjhl0DWFFhZWO+Pxd9plIpRdidY04nMv+4Q5tzQTTLoSIJvlS0jwtCFAk3g2pm/BmzarKN3m6xyxj3c2ZURGa3KioKfHcjhP5D78BttqhF5GVLrOkMIuWg4AtbpVP8ooBzKDxloQcPmig/BKCluoCnNiy4RulnnNO8PPMJwO0yfSEscKte5qT3s/VX+6xecv1hm6aH20jzC+xIyDQ1SYJbeLAfbaAxzXsaQ==;5:jqACJfWH2gBznaeak508ZEltL30oy7p1wA3xDCx93gHoK4mNvJ1OONUIi98cz8rPz1YNGU3vQc/wo/eHboc74rtCEpaUzeyfa+IJYqH6D6LG4MgeMQpd1fwN4hwtM5MoXTjWtD/0ttVPHg/Z+/bUFVYvHgz6DuyxFQwEHZgNZII=;24:PkW+4NWvJTus/W3SqIIVb1FhzvRqZGyRNd/dercU/XlGl+3zeJYBQu3ByT43n+6mymQle4W6dT/Tp5HFHqODCzBDQfiWOU+8skNwAmLXe2Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:aR1FCFo+WHSTGi27vVSYXPKa3Xz+PAjwIl96pTcFJWuNAHguwIz3oK6TiMebHsv8EB3p4PaUtg0aIAj4/03jfFOZ8mnha62NQrnPz0Z0jNduzEEgo8J4b8PAwDxtEvGxwxnG6im3umnpbxXfcztkmj8agRMQyTxjF08Izs22BNyXY4MsWu0YMphdSK0vl2UZhvrFacAGK7NJgGWlMTyaqEeeld1LvJYDFNPqnBSOxa5PqSUQaUa25cLbZ0LzO7Ld;20:hRiGcv1+69QrUDwgyZmHZnzEexzFFzDal4b++ro/JFQfoqL+vvO2x22CzJKHkEqDg2yw6Dcax89X+lzY6nIRRUT56+r9YS/pcrc9DsOw6uuxWiaYlReO0PW4Frt4QEuiXugbnPE7Que/oRIcB/Roza5i7Pn6EKa/p8VdShhFy60=
X-MS-Office365-Filtering-Correlation-Id: 4ff6b5af-f30a-4f53-2aab-08d5a9012593
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 10:01:11.5911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff6b5af-f30a-4f53-2aab-08d5a9012593
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009382637676470?=
X-GMAIL-MSGID: =?utf-8?q?1598530705879941980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22.04.2018 21:21, Vladimir Davydov wrote:
> On Tue, Apr 17, 2018 at 09:54:51PM +0300, Kirill Tkhai wrote:
>> To avoid further unneed calls of do_shrink_slab()
>> for shrinkers, which already do not have any charged
>> objects in a memcg, their bits have to be cleared.
>>
>> This patch introduces a lockless mechanism to do that
>> without races without parallel list lru add. After
>> do_shrink_slab() returns SHRINK_EMPTY the first time,
>> we clear the bit and call it once again. Then we restore
>> the bit, if the new return value is different.
>>
>> Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
>> covers two situations:
>>
>> 1)list_lru_add()     shrink_slab_memcg
>>     list_add_tail()    for_each_set_bit() <--- read bit
>>                          do_shrink_slab() <--- missed list update (no barrier)
>>     <MB>                 <MB>
>>     set_bit()            do_shrink_slab() <--- seen list update
>>
>> This situation, when the first do_shrink_slab() sees set bit,
>> but it doesn't see list update (i.e., race with the first element
>> queueing), is rare. So we don't add <MB> before the first call
>> of do_shrink_slab() instead of this to do not slow down generic
>> case. Also, it's need the second call as seen in below in (2).
>>
>> 2)list_lru_add()      shrink_slab_memcg()
>>     list_add_tail()     ...
>>     set_bit()           ...
>>   ...                   for_each_set_bit()
>>   do_shrink_slab()        do_shrink_slab()
>>     clear_bit()           ...
>>   ...                     ...
>>   list_lru_add()          ...
>>     list_add_tail()       clear_bit()
>>     <MB>                  <MB>
>>     set_bit()             do_shrink_slab()
>>
>> The barriers guarantees, the second do_shrink_slab()
>> in the right side task sees list update if really
>> cleared the bit. This case is drawn in the code comment.
>>
>> [Results/performance of the patchset]
>>
>> After the whole patchset applied the below test shows signify
>> increase of performance:
>>
>> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
>> $mkdir /sys/fs/cgroup/memory/ct
>> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
>>     $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done
>>
>> Then, 4 sequential calls of drop caches:
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> 1)Before:
>> 0.00user 8.99system 0:08.99elapsed 99%CPU
>> 0.00user 5.97system 0:05.97elapsed 100%CPU
>> 0.00user 5.97system 0:05.97elapsed 100%CPU
>> 0.00user 5.85system 0:05.85elapsed 100%CPU
>>
>> 2)After
>> 0.00user 1.11system 0:01.12elapsed 99%CPU
>> 0.00user 0.00system 0:00.00elapsed 100%CPU
>> 0.00user 0.00system 0:00.00elapsed 100%CPU
>> 0.00user 0.00system 0:00.00elapsed 100%CPU
>>
>> Even if we round 0:00.00 up to 0:00.01, the results shows
>> the performance increases at least in 585 times.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |    2 ++
>>  mm/vmscan.c                |   19 +++++++++++++++++--
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index e1c1fa8e417a..1c5c68550e2f 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1245,6 +1245,8 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
>>  
>>  		rcu_read_lock();
>>  		map = SHRINKERS_MAP(memcg, nid);
>> +		/* Pairs with smp mb in shrink_slab() */
>> +		smp_mb__before_atomic();
>>  		set_bit(nr, map->map);
>>  		rcu_read_unlock();
>>  	}
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 3be9b4d81c13..a8733bc5377b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -579,8 +579,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>  		}
>>  
>>  		ret = do_shrink_slab(&sc, shrinker, priority);
>> -		if (ret == SHRINK_EMPTY)
>> -			ret = 0;
>> +		if (ret == SHRINK_EMPTY) {
>> +			clear_bit(i, map->map);
>> +			/*
>> +			 * Pairs with mb in set_shrinker_bit():
>> +			 *
>> +			 * list_lru_add()     shrink_slab_memcg()
>> +			 *   list_add_tail()    clear_bit()
>> +			 *   <MB>               <MB>
>> +			 *   set_bit()          do_shrink_slab()
>> +			 */
>> +			smp_mb__after_atomic();
>> +			ret = do_shrink_slab(&sc, shrinker, priority);
>> +			if (ret == SHRINK_EMPTY)
>> +				ret = 0;
>> +			else
>> +				set_shrinker_bit(memcg, nid, i);
>> +		}
> 
> This is mind-boggling. Are there any alternatives? For instance, can't
> we clear the bit in list_lru_del, when we hold the list lock?

Since a single shrinker may iterate over several lru lists, we can't do that.
Otherwise, we would have to probe another shrinker's lru list from a lru list,
which became empty in list_lru_del().

The solution I suggested, is generic, and it does not depend on low-level
structure type, used by shrinker. This even doesn't have to be a lru list.

>>  		freed += ret;
>>  
>>  		if (rwsem_is_contended(&shrinker_rwsem)) {

Kirill
