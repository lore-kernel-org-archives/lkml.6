Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756153AbeDYSlJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:41:09 -0400
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:41687
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756127AbeDYSlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:41:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
Date: Wed, 25 Apr 2018 14:40:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180425171757.GA10441@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::49) To DM5PR1201MB0123.namprd12.prod.outlook.com
 (2603:10b6:4:55::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0123;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;3:tJPD/o/kKPC6ae1gnAqqP8w0lag7GT+JLSvInA/35GkSFBfPrIH/MEzRPSAfRKk4KT38iGyrG+qt4C0v0mmtNgeFBfViz+D2LGKpTxTRLwG/PhOjEHnchqOY+5wOAeXLAWz3wxh9eEYvWnKrpoPVdyuQuczoF+bBxodZ4N3ZqA6d9VrZbvXq8obLOfpr1V7jVP7pJ6HGWQA38RyV3tMsY5j3rrwvxi2Gh5jNkJOXQWT2ag+sImaKVFn033X1e9nE;25:jkQHrcTzf/1qx2Su4l1g/CrvNqVXBSmx0gmhSY3wwsxnlwzcFn1Z9OYcxqkCGaGY9LsF3jYTPq62gimXId2LdTB46bzWhNPmFuMuBpnJsEsBWKnnio121148B9PjTmOiPzEJlKSWptfyD3MXZ147IFhEH2Xu2j/C0R2FfocTbAYonsUFpEByrsGEpNiC4euWC6wJN5TKhxbyimZ0AYx4z8rFpF1ntEok0JRGO9vKP4qX1NCHrrSeqxsSSTg7Xg4g9uRuXTLzK9e13RD/q0Q1VQpS9amkxIOg5cRv6DAEqM1VNYgKY0l1v9HX3IN6isvVXpYbKTpkxbGgmHOch77DdQ==;31:qudD20fDsYjNavRBwDhU/kBCAEKwh5xDAZAKqXWQHj39htqcmdjiEtAiGD8ofoi2UoNzQ3QcASwPMtiPINNuAmKRryQ3Vp8G+jKj2OsN16InJ2+sTHpOAW/IkTyr/d3TlgfHCwgvmDqsU6vaL8kfwLO5QbOmgI1CZIW8BJMvNxiNYoe+RkimEYxA/mPgiamTbpv+sU7ptyOhItTnaOchD/FukAW6gZYyEmguXMaXaSY=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;20:lvz2VQpYgubtc3uFKSyH+J6rPafT6G7hNRkYH+tt8h0SCTdtZ5PeOUjpxlCcLTvDGO6avgQtNyIh/Yd/guPHYWje5FTh3w0tikzNiE5sPWJ8HK0GX1xX6atGrRmfltTNp49aIKUEskfIl78g2/D/MR1kwAs10Tx9RKAqJprQdJC041Yem9TIWcS7IRv66V2fS8Ro9pGXcbcoCq2Rnh3ESjvccOEMdBRE9gY1Amva9UV7Ovr0gFXqAteGHfvApZrbvHcLJzHT08Ku/6bH0rPhYQbBUCM+yMBnNH+zQ5rW5YXaTGWVntNWyXlkmFs0C764b2f2GAu8HYGS/lLTzqROObmFi+NeZXOBGx29u5jdGz3x+T6VpNu2nqn75RGYSnV1n5bxByqgmzJzZuYCaaM6BDvpAAKHLM1W6nk686qCEHOK35FbDtYJe1zJ7BTLFht/zZfpX9a4pkxfK1Qgg6mtmAVpD05u7HcPuUszxz9NmjruqazZTyP9rRgql9AjwlC8;4:1o1i3ENjTl1CqjCIM577aunYPJrXUEwVY0HdjTMVdtcL96rhva4YrxehMOJAeZvMWz4j/BqLraOpKEX1h+0YC9PlqTeAR5rE4FUNHpzgjVTx6cZOIBLaR1gVwasayRkrt4oyIcxZnn3/kwc4T8A2OPd1AyZIHVBMKHLtiiMA8yps0ofteC9FbMoYetrEePmE1jzKPEUSpJElIJfL7kTc0bsMIiFLfPdXwIVTYHqZgJqbZEHu5yFn9c3BYeMy9jFEjkk7njFD3b+o0hPk2zZkxg==
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01239ACF593BC353C635C8CFEA8F0@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR1201MB0123;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0123;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(199004)(189003)(50466002)(64126003)(16576012)(486006)(93886005)(956004)(446003)(2616005)(72206003)(11346002)(31686004)(25786009)(476003)(3846002)(2906002)(229853002)(230700001)(97736004)(6116002)(8676002)(68736007)(86362001)(8936002)(478600001)(6486002)(65826007)(7736002)(4326008)(6666003)(65956001)(36756003)(6916009)(53936002)(81156014)(47776003)(305945005)(6246003)(31696002)(105586002)(106356001)(81166006)(53546011)(66066001)(58126008)(16526019)(2486003)(186003)(23676004)(52146003)(77096007)(67846002)(76176011)(52116002)(386003)(65806001)(316002)(5660300001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0123;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMjM7MjM6Y1pSR216QkFpZUVWa3pMQXRjU3NjUFMr?=
 =?utf-8?B?TkhkTVFzVDVzY2VBaFpMVnRMK05mOEZjUFRqQVNlRDBUaFRBUEErRENSTnA3?=
 =?utf-8?B?UGVIUnNhNVRPekJ3U2tYYi9ESGhTVjZYTXd4TGNtSlc3VmFhZk0xMFZYZmNs?=
 =?utf-8?B?VkFJNGV1TzczcWNWNGtUdDBBZXBzMmNUdGo1VTBjTTg3bFJjT0RyQjFlWUZR?=
 =?utf-8?B?eXZ5RnkzSExLaHlaS043a3ZzeHRCcnJNK3I0NmlNeE5TWldhaHNwZDFSazNx?=
 =?utf-8?B?M1VIVHlDNTF6RFRpY0h2TkJmVlJ3VUJjTlFvQS91RWdaWjhiRDh4UXBkS3Zs?=
 =?utf-8?B?WUZqTU9JdFV6cmRzSVJFYmxUMUlkSFJPZmIxSmhEQkFXbVh2ZjdrMHZnL2lS?=
 =?utf-8?B?Z2NJeWtxczdaSDBOb094K3YwWGMxTEJOazBDVHd3RTRHTTkzMldvSGladmha?=
 =?utf-8?B?ajUwcTBpTWdIOG9ZeEsyazl5ZFBLTVYyUk1LWVQ2WTdpeGd3cW02TExhc3Fj?=
 =?utf-8?B?bXZ5REdza2Q4OVhDdWJiZVh5b1pBenZoVGJCVzFRNlJsNGVZdTlkaHpjR2Jn?=
 =?utf-8?B?YkxRYTlmbXNERmFzYkc0QVJlS3YwUEZPMDNlNWpvZEg1cG95NnpDUmFmR2tR?=
 =?utf-8?B?c1QxNDlkWGp2YnRENFFld29YUEljbmozb05jSU5CVXJyK0ZBRk10NXJPQ0w5?=
 =?utf-8?B?VkhmbFhMcGRaOVVYMjVrTHJFdXJTNzVXVURJWlhHZ2wvS3c2Um1iVGlvMFMy?=
 =?utf-8?B?bkZLeTF1V1MxckNQLzc3MGF4VlBpMFZMLzRySHVIMkVqR0ROb2dpbXhXWkxa?=
 =?utf-8?B?T2lRMkptZVZqT1EzNFZzdDM0QUtvMFBlREl0UlozY0dqTUl5YmY4QURkZ2dM?=
 =?utf-8?B?SXV3MXAvOUdpVmlFUC93RFlmd1Q1aERUVEwrYWVudFVCUzIvWDB5c2F4S215?=
 =?utf-8?B?K2ZSNmJZSXdodVVJNVJJNXJoK2R4ZHVnOXRESVhURFcvR1F4OHl5WGtaODMr?=
 =?utf-8?B?RW56U2F0NWJkc2kvZjU5cXF3RFJkenRIUmVUeG9HRnhZL0w0b2Fnem1Pby9S?=
 =?utf-8?B?UVNIYlRJTEZ5d2dSN0c5RFpEUXdSYnEycUFVQ2dKK3pBZ3NDa1NkQ2VQb1Jj?=
 =?utf-8?B?cE9NR1J0RWJFY0RtM004VC8zYkZzYjlIVnpJd0NaN21zdG1LcER0akY4RWRa?=
 =?utf-8?B?Qkxjd3dKQ1hjeXpyTkpLOFFaRU9GT1ZwWEJZRURBeUFxUUJSa1RFR1J0UGtZ?=
 =?utf-8?B?VlEzS2VqZUlyL0h2OXBMbFZPTnZGazhBcTV4T0lISUdqR0djVkxIV3U0dVBT?=
 =?utf-8?B?UWJPZWdoWDA1N0tvZjNHUUw0Vlc1Q0hQaDZrQ2gvZElsMm0xRGxiOFNESCtS?=
 =?utf-8?B?MkxBTGJiTTJjSUJ1aHhLeUJrd0tueC9FdmN0SmMrSCtoSC9qZTg5dUZiZkU1?=
 =?utf-8?B?UEE0RjBTc0djMlUwYjJwbGZ1NFZSU3NQZGsrZmVhcGI0Rk9Bb0w1Q003OWEr?=
 =?utf-8?B?NzlUVG0yWVllbEhLUjVlRGUyeXk0bmI0aS9jTTJIS3dQcC8yM2J6TlhDQm5Q?=
 =?utf-8?B?cHVENWFMbUpZT1U4TityRG9wNFB1NEh0Z002UHpTWnNrcWt2RU5UK1JtOUpG?=
 =?utf-8?B?WXN0a3Y4ZFNzRVYySXBnY1FtaS9HaGh3SEExMlFZazZtVXM4ZG5BTGwvNmZT?=
 =?utf-8?B?VEJHb0JrYzZSdi9oUVZQbysxZ1dXdHpmYkM5MnoxbHVsM1JUOEt5T2w3MWE0?=
 =?utf-8?B?dUJpNmxmWFNjcmczeWpLci9BQm1FY01jYkRVeUovRTkvSVFHMUpOWjM4b0Ji?=
 =?utf-8?B?RXZlbDN5YzRJQzNjSlJOdjJMQ1hXNnVzWjdXUktrR3ExQktXVnMvN1BPU3Y2?=
 =?utf-8?B?bmZhZmFxWEdxdDJVT2VOZ3A0bHl4dFl6T1ZSN0pJY1oyUHJnNlNKa0V1dnE2?=
 =?utf-8?B?aCtUWSsvZTMydTBCZC9yYitvb1NrdThjbVg2ekpXMlJ1SUFXQkNFZU40cVVj?=
 =?utf-8?B?c2ljQVh1RTVETUhmcXhpVHZ5QTZzWXhHSHV5c2pRPT0=?=
X-Microsoft-Antispam-Message-Info: OFTBDsp9A/HDf8Xy/+ql/qmyllErteiiZBB8JhdpMFnB+BS5rf+GSY1ohHuXwyAq/hjXS6N4Izh1WsZTsP5Ff6BbT5FS1DfnikGTzn0d4p/SAZQ73JoJd++2XUKUCfOAZwydTQ2xD9nPshHmB22CNnSg32z44KPRSm23aNpfZQyek9Tk6D78A75ktZhr6aZX
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;6:XsZxQENVDBG3IiKkOyUc+1fmZSdhCCmVltNfy214GedA7ZsLMVzUU7osbcKveGrzYE/yIqlrnuAt+cvvQOMZaNnWnTVjWBw4jzVaYV5oacUE2o0tBRGAGWCAXp9n1/4KYbUayG3winbA6w8mQbqi7zQzKPJqW3KWhcvaiCCjQnYTQrxJrxT4samzpJ5xMKrPNlNENfKki1uhfGIrO1prCSaZnsOZF7h/3LJ4cuJbvZ5Eq9r8LEcRpy643gVADaGAkQlm5J5IJ5I1vSeKmYjGeL1e7h4Qq/ZqWK+UwyF3UM7q35E4LuBTYSMaEEbQx6BQq/xMPcwki2UPREhmf9CbHSLPT+GO4+bf+Wg9QWPAyny+DEZdRiZjU920shhhAt2tZvuaOKVQStdrMME26QZDkFz0lVcVuTbcBt82VepCO+5+SmCqdjvG9z4mAAbieyo/JCTueNL6TMPgnsj4ZMHLog==;5:auPSVjpYYUaCl+/veMGEFCwYy0HTiJx/udNdmyQaB2ah7GEd0FCxLlW5R9i2ex1ozKGfzgAZDzweKycERSCJxOwD0r4JrPO8RPQUJp7ycJXqTMJAJvDDv9R3NtypKu0vTMxACUFEAlM3S+7gpUqX9bFmYmlVPQUT8y8CvboSecU=;24:E8SkQzqRZz8b6PhvpH1+oozzkh2Qfc3KWIKrONif3RAR+G29n/TV4HqRlMkvOcqXIgnDd+XmYzUdmw9URe5TEu22ejSgakdpfq9QETFt3Xs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;7:C5+3rPIEFiKpc1diKoa17EIt8cVgsWRG0VuSwQP+6XhSI1MB2INOuuqZt7n+w7d9ZjgzlBg9pC3Aq963yWfoer35TfH+n3tu218iRDr/VaZEa7rU3bZeSyaNMuvCmOmhhmlxdyDysfbFDP+C9X6ib29uSXbs95uxszDrHfK1ciqsxajDGLuIs0kIDapHp5geWXXW8Hu2a5UzQKJmFhFvvvCdlNhB5gQnFiqYi9VCiUjnHIVJjz73fkSKe6a4Fdy9;20:0mM79q2eWirKGeFMc5fuvWsE6wJBDBhi9dEI4ZsdKyBYJ6ZyJAY4RzORZBgaPjw7Qg+jNftHtuK2O0gADaZ24/TTS5v43H/6I2X4ae8PGgKIRWFuQexb1WkjvG6M7qH/xjwRWKZ/bfRWBD26m8nIxEBEhtxkXNQRxeqrA97y0daLr0YKUNga+FJhfd27NaW2qJslS1zorthTdJrDg1fsyQ7J5mzn9mlzBd1LzXkiszCak7Y3+0+dnHPOnQu+KBPI
X-MS-Office365-Filtering-Correlation-Id: 1bfcab8d-5a15-489d-9861-08d5aadc169c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 18:40:58.5431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfcab8d-5a15-489d-9861-08d5aadc169c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
> On 04/25, Andrey Grodzovsky wrote:
>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>> able to exit immediately
>> and not wait for GPU jobs completion when the reason for reaching this code
>> is because of KILL
>> signal to the user process who opened the device file.
> Can you hook f_op->flush method?

But this one is called for each task releasing a reference to the the 
file, so not sure I see how this solves the problem.

Andrey

>
> Oleg.
>
