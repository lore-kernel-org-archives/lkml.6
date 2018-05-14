Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoUpBza0KyNYXNjdyosCT1U55WtpT31UoE+IcCLntoRnyfoRLGPc/il2ZjNmxShLEXw5+cQ
ARC-Seal: i=1; a=rsa-sha256; t=1526288631; cv=none;
        d=google.com; s=arc-20160816;
        b=qCR0SlwtK8u6ewhP4qM3aqRtwNy7EdWsap7K1e0t0PvxoeZd6/V2ZYadR0TJ6Uxt58
         Pjia6hjBBEjz65tCGkjAx16xcyNJCDh9QvDvhIu3eaktD5NIdMVYs1vRFid3kWG3FSZ/
         mECXm08KLvv3MHBZbMY7lirZ0a/dyW/WbanmO93Of7Uh8NYrNzu1KG9Zv0ntMk2EpWIU
         lImiedeo7BTdf6zpQCYxmftwpEI5hvhnHkPTUaaXwKekaxSC94v+xjqBzfkKPIEoKfLE
         u5JacozSoghYlL3apLBwRdtFqKf2uWYZ49Sh66BdBLcjYlsbfhYlSu0Zg5xr8nA3ngvy
         BUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Gdm9UaDuPdO1qqJK/kOhmylCZPOh2TBCdKe/JvBd46A=;
        b=Xo9tomijOzDaYPQuPamHqBnhrdP0ZXd9OaKyOWz0XEbCKA0TTkirTvAvBiHnSSCeL4
         a/I6iZ2UgVupPVpSBOSKdImdreqC1nH6HP5ZxFnPt66pVFgKwrhnmF7AjOgcpqQuK/Cl
         3/lvY7MAKlzdg6x9VxzTig64dx8RYjw1xFHn2d7/3AmLJAFz71tKvPycCh8NdRGonyFY
         lDU4iY+QAnhet+dYHshuBIdFKg2Y5To1/Pe+XAtYzDfTZtxwcznrK4e8tCCbZXNLoT+T
         wHz9rGMV3LLTeiHXlxrkkYHoNgUxEbyj8TMUvEuiAbdD1qn7JEO27e6KXTzryobunMs8
         x1uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OKSzYitL;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.94 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OKSzYitL;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.94 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v5 01/13] mm: Assign id to every memcg-aware shrinker
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594593798.22949.6730606876057040426.stgit@localhost.localdomain>
 <20180513051509.df2tcmbhxn3q2fp7@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e4889603-c337-c389-a819-17f8d4fd03ad@virtuozzo.com>
Date: Mon, 14 May 2018 12:03:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513051509.df2tcmbhxn3q2fp7@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:1::45) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:C+/fGed/IBBsQBadnMQGU6o2ZMxlSg2LHn9bjAKdWh6bglwTzJKTbUCjgQgGqV1njvd4kS8hDmU7RhTCYRhFZc8lDKnwmdNjV94Why2dM4GOGDoyacK5nCK8xMq8Ae8CIlCYBQZa1142VdF2uKLnIyH8qaHgVWBJu4iLLZyjNyyuwMn26yZ2JTkU13f8NzlD1PG6FQYmTyKGkvyM6YmsiUKhfb5vGxBfEkd0+OCnSzRGEuostc47Zd86xtvQgyTO;25:0p/BIe6Nrw1VcRUzVy8LK/c9zaoqxGsmPPZHksaMk+5ntQmJ3m0SVtkmkb1c0WxxNzUl2+6EunBqClf9PZt4fzVs+Iu5vyxC64yqWQWc+FW3ifTEnMeoNks0NWqLY4rTuZvRxC7/DcT2Klt46MEiC2GVxkHQyS+ZbNsujUmteBXF7KPRqExaWLMpMwhTOQ01D24To0c/h3mvuwz7aGqlWFxr0dgRy073IuCdcvR22CyAvvzgAZ6y7kHV2GqkIHXOFjrxOx3FiSZdQKUEHskl7mg+yW+Gyz6sbc4DP1snTIocgy/w0v4D1Q6H1WuSZ4zk6+URmxDcRYeDEplt4vG1tQ==;31:ZXxR1OFrgtmi822z0gKsiOEgvlIj7Emp8NVItPq7r/2Gwj6d8+tcYxcc92mrgcymrUDjku8K0pw13RexdJRRP/BWUtnx49+kwpneIvwNcfDyoqjdiMd/ZbyCqoDB0DJYbs+4gVMjZAGzhRyalnXQbs8dUMp9hyHRnBxBwnpre9bLfXv1RogT4lx8I1UVhSdvcX2SZmjHh1FwXsH1V/blu+vl+1B2IxFHq6snAjFcnys=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:7XJPOuvSGwZ3ESY8PCGh1/q6jWSTEsbz7RGLAsu7Nd7qNnn/buKT979Ay2FCLXD7iAbeWxdgY836elsmnFTGY5KQmJc8uIMMxW1AxwJOCdNsL1yG2cdQPtBG2T6G5jw1KF8SfyTzVFggwZ/HYQtr+B1U5gMgBses0NINTA46N7l42b4wl0IJci0a08Kpt8nYrbd3li2ElLdReNfGP8fmw1TE9s0t7yvo9uLYKlGvSRScwAl7PleGDOOfr7kRnQlLEtBVfJl5AUuZ0OFwftl3MyovjHzPPPyCGZF+a389dTGtyAWsGIPhz+6RJ5xZ0KpViBD45tXY5hz6dnXQhRpXOOzhQyY2/7htBiwkZyFGaiBCKZWm37FH051jYZkGA++M++4Mh32b7TLG5JDAVjJvhNygl315+w98x1pw4oliprv8xkxuiIFV6qqu7XOOM88A/QCKeDPwxndo6O4SuHuZcgQsJppOpH4bvCYg66/jHp26rctbveFEQyJhB9wEC7pu;4:xmLI63Su4bC93sj1zLaNf31CvSIEwDiBHq7rbBWCJ2XDqKnjmb4nBX29OXhx3bJIaQY7sUjr+EXyNavRybPH2uGP/XdvIyWauoOHUQUbqC8faxQ3M3RWtsx3xGVZTSJYv8QS2ngOivYWVFxvGQAXl8AIg6cj75oKUn3GqlzVbPaZLYJnCybWw0b+vSepZlHbdD9JrBFGVy2+SSlG/SCBQ8dh3RvNvyJO6VqwstCuHYaQkRRmYynEkzZFoBYUaL0hm1g9dl+FjWt7I2T8o0S4a+Ua/O1mOIbgvQZ1ByVYTUlNa0PPVE0GaN6uS17raUHbgYoQPKQnvn9J9rLJuxZ5+JrZfaervlVJa1kVpObEm2E=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13441D100C53D2A67854D6B8CD9C0@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(106356001)(105586002)(6916009)(64126003)(2906002)(81156014)(81166006)(4326008)(53546011)(6246003)(107886003)(52146003)(305945005)(966005)(8936002)(386003)(23676004)(2486003)(230700001)(6306002)(478600001)(486006)(446003)(52116002)(476003)(36756003)(53936002)(2616005)(956004)(31686004)(11346002)(76176011)(50466002)(6666003)(39060400002)(5660300001)(7416002)(65826007)(16526019)(6486002)(8676002)(25786009)(316002)(77096007)(58126008)(97736004)(16576012)(229853002)(68736007)(47776003)(65956001)(31696002)(26005)(7736002)(3846002)(66066001)(6116002)(65806001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6U1BLV1ZENzRYeHRoL3lEYjNoZ2krYTRL?=
 =?utf-8?B?RTNDQi8rYnZ1TkJackhTTHI0NGNiOWhGMXYrWnpQSlNGMHU5VWd1WFBLYWM3?=
 =?utf-8?B?MDYzTTNPc3NDUkhQKzk4eDV0NUZIeW1RZzBPV0FIR05LS1BRUEFyMGMvU3Iz?=
 =?utf-8?B?VVRNSGRzcnAzaVVDSVZpM3E4ME1FUVRhaDMzcVpLRnlhTHhLcHVCOGg3bnZl?=
 =?utf-8?B?TVdKNk1NcU1VNTU4OFBxRWdqbFJvTWNCN1p0MkFob2VMZFhha3FpUSs3M21l?=
 =?utf-8?B?ei95aEVyVEIwTzlJTXh3VUE1OUFUaWJzR2tiay9yRUp0YlludmpFNGFsL1FE?=
 =?utf-8?B?UUwvREVzZHNzTkZsUFZMZS9KMEZvZzJ5aWF0cjJYR2xpRlNHeXdHamV1NkRn?=
 =?utf-8?B?Vk9oWCtPU1BMMHdkRTFkTDZ2QnkzOGM2NFZmZUYxejhmUjhmTkJ0eEdpTU9v?=
 =?utf-8?B?QmFUM2RQRDB1b0xGa2l6SU5kZmYycmpacVl3Znh1aE9VaXo4b29GU0JWN1Ry?=
 =?utf-8?B?cS9ISjZtVnFsMDIxMEtidFc1NUlFQ01FNUJyOWliVERxNDB4U0kxYmdtbUtD?=
 =?utf-8?B?RWxWOTlyOW1LYTd2L3J5OEhGQmxUTlpRSDZ3TkliVG1Bazllc3BMNFJEU3Nl?=
 =?utf-8?B?QXYvOWRPaC9pU1hlcW91MEZod0dia1JXMktxVmVGMm44dEFYWS9XbE1jQXI2?=
 =?utf-8?B?RFdwZmY2dDIvZEt0SW44Y25iWUZCUUExa0Fhd094OStrNDlKUDJ0TlU4SXRa?=
 =?utf-8?B?eVh0Z2Y3QW8yWEdScEROK3NCTlI0b1NMSGIzR0dHZm1SMU03VmZIN2RDWjll?=
 =?utf-8?B?M05PV1pIU0djR25KYW9nL0hPZGt1R0dwVndZLyt6eitKU1JSMHgvODlvNWVj?=
 =?utf-8?B?Z25KMTNNMjJIVVV5ZW1CZksvNmFSZjFKYzl1cFFuMlhTS2hYTDdLSzllWm1x?=
 =?utf-8?B?cjZ2cUtzRjNGV3hXRk1LOXhDTzNQNklxZDJWY0RKblMzTFJNdXRCWG14ZTF1?=
 =?utf-8?B?Y1dWUENLWlFwTU5XeHpTOFZGdzY2RENQRUNKZ04zcll4Um93NWNQdVlUM0hr?=
 =?utf-8?B?Qzl5a2RKU25zeXE1NzFWMEpObnBjN2U2YWZaMU1BVVNzRG9FUFhFNVp6NTB5?=
 =?utf-8?B?UHdvVmRyamZHYnlESjgreWpRZjNWTmlicWhaYTdVQmQwZnF4aDdaTnZITDBI?=
 =?utf-8?B?ZVM5OEI2Tzh4UnBmYVZPdXd5ekR3bUpZU3VZOHlDR2d4TjhpcE5jMUFaZlIv?=
 =?utf-8?B?eUR1K0pQYWp4cHRwNkxkVjNlbzFhdnlZRm1odVBBRzdGbGR4NVo0UDZwMlZk?=
 =?utf-8?B?U1R5VWVCcDVKWTc3aDZ3WTVVQURvWkhENE5BMG10NTRYbGtEeENDb2NEYjFz?=
 =?utf-8?B?ekwxdVhpRHQ4SXRjY2RGNWFiSEptOGV6ZEQrQXVKL2tQa3hRVTNERHJwWW5u?=
 =?utf-8?B?Tmg5RUx6VngxcHg1bnZmOE5WenFPUlZYQUVYWnNtV2txY3R6UFVKYVBKVXZW?=
 =?utf-8?B?MmFOdFRybnVKYjdpb2FVSFk4bStRWkdBeVk0Vk5PVmhDeWpNMm1scmRIRjlO?=
 =?utf-8?B?dzFQbFhGci9RRFlmdnRTczZPT1lVNE1NSTZSaWVaTmVMbCsxSnQxYzd6N0NR?=
 =?utf-8?B?OUwyaDJIdldEU3hISWt1WE1FUTl6QysreDlrYnR5S3BtVHd0QUlzKzEzbWMr?=
 =?utf-8?B?L3BmYUV2MlhXWDBrR3MxOU1GUlplMmhRQzhWb0ZnbGZzeVlFVUd5WlpUeU5P?=
 =?utf-8?B?eWdtTExTeENRcGlDVDZlbnFURStZbEZGRDdUYVdrZGxSVHg0RWFOeDRFbFlx?=
 =?utf-8?B?WDdCcEs5OVQvcWxwVy9VcnpvbFFaTlAvOHlhRGsyb1BCTXdiNlpqdUJkSERj?=
 =?utf-8?B?c1NvZktTcFdXcHN4V05pRWZPUUZTaFdONG53WVlWTnBCOG9TMkZxa2pBNzd5?=
 =?utf-8?B?ekxTWVA3czhLV0NWZXRyUWJieE5IdDZHRXMzRGQ5ajQ3R295RHAzMmMvUlRK?=
 =?utf-8?B?Yk91OXk1dU5BY0xKSFRmSE9wSS92NTRNNFo0NFFyRU9LZ3Ayd0hQbmIrOGZW?=
 =?utf-8?Q?EuduPE=3D?=
X-Microsoft-Antispam-Message-Info: 7QJiC4pL+pUvz8uB4x8ACY3I/imCH/VU09yKq0Fwtbeg4t+wK0EpvLhJYgtA2rHdj4B/WI/JDVhze+CYty5X9ikjJyIEJX61U6M01RtQdQ6MiBKMOweAvSOZmFdXkDYRGxBwob2RJ0oGS/nyhY7M48C30V/1rRwNFiprsKXZ7cMaxp4EQr6uRQmAUdJPPw9v
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:Cp3IWLMrUlhdqUoQO8sg0vB8JWZ72L0tQAI3hDRV/a550GqvxTw4H/cKIY2PvxfI16S7kHVt69P0IuAW0E7hjn62ebf3ZF345KPyonN/zwRSlbWfSkDGzZXXlbL6fnEAggCQo01Ce/W/a1ZUhfqZXtY9Cv6ckdvIs3CreaQH9ZuG2SLmwMlsavPzcuXJgujnFYZBmW6+rFJw626r4Db1hrLFuKjFPYTaazRVOTiMKjT4NNJniwP+lIW6UM2GKfrugJcYtXV42xzMtQq0bDPFbvqOqMFHxdqkELqsQtVEbJq8zF2tjdBqRPN32bduLzMQjgkWC5vwBNz472kH4+c+s/UJ5o7mnz/UY5dOudsQA8q8LnGQBG3UJLbedEw6jiR7sBBo98Sgxrpm67F79Wj1NbfXN6OYnDVzA2Y10VtoruKjLv7jLdJoL+MQU1wF8pxyMLg5RHzxqNLp/RxXhJ+lbw==;5:MQq0rTXhmvez4MGISR2QSS0qorZJ2xFhbcoqTNzplDuyHogx0ZxQ0NUtXykyNVheo31D9p3S30CeT+2zGrWJZcSjNDF4rt0/9M2zRjgfgXiimrr0inEKURxIZt4DdW1zWyqxeCZrkGEFOwEbxVo3ipmsth1WRKSiknj5G4AS4HQ=;24:byfRQqJRvB7y0XIQCm2FpQ6v5Xm7Eg5x4eouPMspzz8GimLOheE9M+tYTwp9G+LGGhQSl6zcwxRR/NbcHXLQu16T75pQXVZKtDRXGT7AYik=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:pKSCtEg5w3mX1Qdir0ro8oD/++qKWggd+hiyX+uJY8RkStBzlgoEQDvRXqWCQ+cV8O9kIWxSHOEW6HpYF3azsx2JDotGrfI4tbR9bTAyhrqrVMBE51V82PjwwtFAxU/GUg2tkNrfa9v1dJuF5u3zupx+MDoJIJBxtnSwPjU1bTwYXxbPC7sOZvTu0md+9uxeYLa+ISz5ud+q69mkR8o6p+8rvWh/6EDthyGoNDpksXdbcbVn4LNj9HD0uCQYQKct;20:R/Yklaks86Kz7vxsiat604EomKgv0Tv41jgxDSAb4WbZsZ2qABvElQlxJBqppVBKrxwyG1aquZIJxj44geMZ4QgTO91xd+vqLY7fokzTwdwCBOOSRDFqYc0eLDa/y0jMqYSpaMbjzGPhUbSLqjBORNBpsvU6hNxu6zWoRtxG1I8=
X-MS-Office365-Filtering-Correlation-Id: fc45eec7-37c5-4d04-ab52-08d5b97997bb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 09:03:41.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc45eec7-37c5-4d04-ab52-08d5b97997bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600429627483763946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13.05.2018 08:15, Vladimir Davydov wrote:
> On Thu, May 10, 2018 at 12:52:18PM +0300, Kirill Tkhai wrote:
>> The patch introduces shrinker::id number, which is used to enumerate
>> memcg-aware shrinkers. The number start from 0, and the code tries
>> to maintain it as small as possible.
>>
>> This will be used as to represent a memcg-aware shrinkers in memcg
>> shrinkers map.
>>
>> Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
>> in case of !SLOB only, the new functionality will be under MEMCG && !SLOB
>> ifdef (symlinked to CONFIG_MEMCG_SHRINKER).
> 
> Using MEMCG && !SLOB instead of introducing a new config option was done
> deliberately, see:
> 
>   http://lkml.kernel.org/r/20151210202244.GA4809@cmpxchg.org
> 
> I guess, this doesn't work well any more, as there are more and more
> parts depending on kmem accounting, like shrinkers. If you really want
> to introduce a new option, I think you should call it CONFIG_MEMCG_KMEM
> and use it consistently throughout the code instead of MEMCG && !SLOB.
> And this should be done in a separate patch.

What do you mean under "consistently throughout the code"? Should I replace
all MEMCG && !SLOB with CONFIG_MEMCG_KMEM over existing code?

>> diff --git a/fs/super.c b/fs/super.c
>> index 122c402049a2..16c153d2f4f1 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>  	s->s_time_gran = 1000000000;
>>  	s->cleancache_poolid = CLEANCACHE_NO_POOL;
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +	s->s_shrink.id = -1;
>> +#endif
> 
> No point doing that - you are going to overwrite the id anyway in
> prealloc_shrinker().

Not so, this is done deliberately. alloc_super() has the only "fail" label,
and it handles all the allocation errors there. The patch just behaves in
the same style. It sets "-1" to make destroy_unused_super() able to differ
the cases, when shrinker is really initialized, and when it's not.
If you don't like this, I can move "s->s_shrink.id = -1;" into
prealloc_memcg_shrinker() instead of this.
 
>>  	s->s_shrink.seeks = DEFAULT_SEEKS;
>>  	s->s_shrink.scan_objects = super_cache_scan;
>>  	s->s_shrink.count_objects = super_cache_count;
> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 10c8a38c5eef..d691beac1048 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -169,6 +169,47 @@ unsigned long vm_total_pages;
>>  static LIST_HEAD(shrinker_list);
>>  static DECLARE_RWSEM(shrinker_rwsem);
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +static DEFINE_IDR(shrinker_idr);
>> +
>> +static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>> +{
>> +	int id, ret;
>> +
>> +	down_write(&shrinker_rwsem);
>> +	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>> +	if (ret < 0)
>> +		goto unlock;
>> +	shrinker->id = id;
>> +	ret = 0;
>> +unlock:
>> +	up_write(&shrinker_rwsem);
>> +	return ret;
>> +}
>> +
>> +static void del_memcg_shrinker(struct shrinker *shrinker)
> 
> Nit: IMO unregister_memcg_shrinker() would be a better name as it
> matches unregister_shrinker(), just like prealloc_memcg_shrinker()
> matches prealloc_shrinker().
> 
>> +{
>> +	int id = shrinker->id;
>> +
> 
>> +	if (id < 0)
>> +		return;
> 
> Nit: I think this should be BUG_ON(id >= 0) as this function is only
> called for memcg-aware shrinkers AFAICS.

See comment to alloc_super().

>> +
>> +	down_write(&shrinker_rwsem);
>> +	idr_remove(&shrinker_idr, id);
>> +	up_write(&shrinker_rwsem);
>> +	shrinker->id = -1;
>> +}

Kirill
