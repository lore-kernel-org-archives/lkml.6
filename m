Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeEVPdl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:33:41 -0400
Received: from mail-he1eur01on0040.outbound.protection.outlook.com ([104.47.0.40]:61296
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751525AbeEVPdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:33:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH v3] mlx4_core: allocate ICM memory in page size chunks
To: Qing Huang <qing.huang@oracle.com>,
        Eric Dumazet <eric.dumazet@gmail.com>, tariqt@mellanox.com,
        davem@davemloft.net, haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180517205343.8401-1-qing.huang@oracle.com>
 <e6c470f0-f2ae-5efd-09ed-0c9562a4a764@gmail.com>
 <19b7818e-16f6-2349-dc34-245c2f215f6f@oracle.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <35ba0f14-7b24-96ff-6b2d-610a4b2980c2@mellanox.com>
Date: Tue, 22 May 2018 18:33:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <19b7818e-16f6-2349-dc34-245c2f215f6f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWXP265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::25) To AM4PR05MB3252.eurprd05.prod.outlook.com
 (2603:10a6:205:4::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR05MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;3:QnvAu87o+maw6fLt8eWPD4IL/1U90ZQTZXOZcOO9Gz2ejhyFbaUUAm8veH9gZS+RbbYiOHCzBdsR8wzsPSeMA4ubO3VOjdeu5awjkP/3Pj+ZBRjkOY+jyiKuuaVgAwSQ2aFOpZeqR58+4jn//Oc5pwSf1m59rmo+mJITwQArGodesZuKLJy4od+wN71cJPY2kGrfxVWVfi/x4Vg/vxg1gOOs8B5eZNugsbAJHZ372a6gfd1CE+ayNCIDpoz0H3MF;25:3CtwR9k/gQN1uCM+hl5KvUUaVk6S7T2SW2zYGVS9fATIGJXsuMwRmLXKuD9YuPKXrmyJoTDU8eqUGy9SiQ5SEAdXuTmkG4XMpAxC9qUbtf7tY0Yyyp2fweOmsi1bDTmSozuLZXOYKi6xfQkXfHsRbrwjgzCMLs9CuqQc9e8GBKxohl+u7HmiSmtNf7Rm1lLs+L1TekwP82tfEgSc2KahfiLkl0dbBoSx3Vd428mUS6FQ0g6dV9iYl7EEuvsp0nWOgn+Vq0mfDt6P8N1GpaI0XBuDFIqUi6f4r+PfuCdwwypFGBO3CqiR0kvURVQRxqWikP6WOcSe2VVyCkldEZ1GCA==;31:Sa4UtJoSQxm+qhvWZhWM8Y9cChbt4DmABnElDivGSRwlnnwpLEv8BdAycqa1U8TzZxytZS8hvkhcJ+G9AgizskvsYUMbiWxg4w6lRk/4btPot/h6RtTCy7DKcrrzMZcFBS7XsiD4gbXbL3J3huEE0zGcUNqEyTFXeXuaIU6whdn5sy4Cob7lkvxO3Jpkn/26QV85RC2Qwo7vRWZdFNI8efgZzYMEwb+a31tu0mYuhLk=
X-MS-TrafficTypeDiagnostic: AM4PR05MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;20:Jz6/fipyryT8hRv6V/W4oPMmOvhJS6ME3wLgRsadM5V/aHSqp+mu8yy6nEndxvtiQAB1jpGXNwn8ZyIonWRgbbq2rpoq+ABKwu6H8y5FLrLlg5lACsV4Db0tuSV9TjF2aK356YS1jpFzbJllr/AvBGgTBBXdygGXjn9KF2BXsUWdaTS8Fz/xJdOnWwtNxBsIfr2GFjMqkn1P5JhBV/A6FtALT8dgoMkOj3OIlYttmZjyNrNUJRjr1L8gvEMOb0Arh3zs6fpmlq1MypXGdbpPh2X+7I7jKhrC3XHQxUpizNzmJuns7vtfUWDxhK0fgA46jNQbh1BBykYoPp8n6oXcVJwxZG+81kEevas74LMFmw5ua0q1RsqIhrCq/Bh8YrfLOXoYnS+RNEK459G38IsB0OihCSKS2SNOTztEesH3Hsv6H2+FWBsqocFaZFrV4H4Gulx0gmyuD5YYrTUe1VDmuhPBx5eX7hvb8C0Cba64S89QCrctKa+4mxveah9js2DT;4:mlO8m4U2JDqVgs7vrDSyZLKZf8skcGKx6g+QFJFVOuTvHAE1yLa+/DDEKIkvc0ERIJa3H2ENBtiRiFzPyluTyfkJsvwfJrT8jHgUqloseOxujM1kTRHkkblufUovMyd7w7hS7OXQKsKqcJNdyGVV2TAgSNZ/HzDDRe9/2WlLFCaEXUpu4Vnmue3YHaXxHNGJ70+0JmqqovPE5BZVO9Jjg/50cCb2/Q/vefCYRNaR0i60uniQNixs9RJWTEub/19ncpGKPXn0Ytvfk4gPgP+clyLFbt9xReIdPc+uNfFxLSsXR/S+N9hIVzzYAygUgE+7
X-Microsoft-Antispam-PRVS: <AM4PR05MB3252B0A69B9D2D492F5EC974AE940@AM4PR05MB3252.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM4PR05MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB3252;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(3846002)(105586002)(58126008)(110136005)(31686004)(2906002)(305945005)(47776003)(7736002)(64126003)(81156014)(25786009)(8676002)(86362001)(81166006)(65806001)(8936002)(31696002)(67846002)(65956001)(66066001)(446003)(59450400001)(53546011)(316002)(6116002)(52146003)(2486003)(23676004)(11346002)(486006)(76176011)(52116002)(386003)(956004)(16576012)(106356001)(26005)(186003)(230700001)(2616005)(77096007)(36756003)(16526019)(39060400002)(50466002)(476003)(5660300001)(6486002)(229853002)(478600001)(53936002)(6666003)(97736004)(65826007)(6246003)(4326008)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3252;H:[10.8.17.252];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA1TUIzMjUyOzIzOk1qSU5pM0pRQksvMkp1RmtxY3Q3d0xjSnVJ?=
 =?utf-8?B?bVppSGh4VDBZYWUxODJCelJZRGFaMG9KaUxkaUdUdlh5aFVwcWkxSGFoVGUx?=
 =?utf-8?B?WGFuSEMrWjNRRUl2aytxcktEczl4cU9sdExTcTJNNHJFNzZxVW5MWUU5TGxY?=
 =?utf-8?B?bWhTTmE0bkJBdDVEZnVPRE16bXU4N2MyNGJ6SHNySGk5WUVYV0FXSlI1QTJw?=
 =?utf-8?B?UXRXNDdMdytDNE0rZnRtb0k0MW1SZ1Q4WGxXQ3ZNQi9iajVIK0dJRkgzSkln?=
 =?utf-8?B?OWtUcXdMTDVneGRUY0NoYXl2MHdVN29iRHZSa1JpRHpPUG1OaGxCN3dCNC9O?=
 =?utf-8?B?VzNEbm9yZFhZbVRFS3Z0WVFaelg1Z1BRNWxBbUlkK05uU3ZKYktzSVExZmx3?=
 =?utf-8?B?VmplWVU0M0tyQ1gzbHljSFc0ZFNjeUFna0pyM1FRN0E0MlliTTJFWXpOSHU0?=
 =?utf-8?B?THhRZjdaSERmWnpBL1hPd3U5NTdrUW1peCtrQm9LTEYrTzNLZWtFY0d1cHBZ?=
 =?utf-8?B?d0RXZmF6MGlRWEdKcjF4dHRRZXFYZUk4U0tVdWN3VFBpMDBNOXB2TUNLZVJk?=
 =?utf-8?B?U0NxNG9DZWFxK0Z4SjltZEJybFArZjV4dkNoNTJNeXU2UjlKcTFxRjcxSnVo?=
 =?utf-8?B?YjA4cCs3YnFpVzUzNkZIZS9kRFpoK0s1dFpSbkpxSjFHbjRLNzc4RXVycm9h?=
 =?utf-8?B?SUcvR0J6RGZtYU9rWWxITHpOV2N5LzBTTWhFdjdHb0FqcGVqUjhVRkxFR09l?=
 =?utf-8?B?UHlEVkZTZW45QjlVM2lRUkZtMTdseFROVXRCeGxEclRiT0t2VXFDQ0k1UnJ4?=
 =?utf-8?B?MzBxcjhMMFN5WCthUWVoS0p6YVhBbXVMM0xvcXYvcHdaVU9JRldGRE5MVUx4?=
 =?utf-8?B?bW4ySFVmWlpLVUxvZ2wvVnA2QWR4UUY1WCtGL1Z6cFNLRVZOTnFVT2FZMkJr?=
 =?utf-8?B?S2VQR0JrTnkvR21qaWtjcEpJVGIxQ2x1WFM0bEhoaTFmNmVacXVUZzBmS2Nu?=
 =?utf-8?B?TVZnbHBHVmRQZmEzcGJzQlROSWUxemE1d3hCZnZPeVI0VXZCZWZySGxxMVFY?=
 =?utf-8?B?UDRSbG91ZExEY1Rwc3hlS3BvWiswRHdnVjN2cVQ2UEh6K3ZTejdwUXV4MzJX?=
 =?utf-8?B?dHJZeHRWZFZRM2RqYlhNUVpuMkxiRnVPeUJaMCtQSkpTUnU2QU4yc2gxVTAv?=
 =?utf-8?B?TlNESFRicVc4cUM1VUd6blRuY05SYnNXdS8xbWkzWmt2KzBTNEJ6VUZsdG1r?=
 =?utf-8?B?eWxPWFN3RFd3WHRSc0RHT2h0ODA0WWsrR3VFWkZkV25iQUt2SE5PNUt6UW5x?=
 =?utf-8?B?bnl4Nis4NlIwNjh5MDlYcEJtUjBSNXlyNW5nYnhRSG5RaXNzM3pLdTFMdzZK?=
 =?utf-8?B?b1VHakRpYlNSVnAxQ094Q0pyQTJ2RlpNUjdGSGJsKzdGSFAreXc4blhQbldH?=
 =?utf-8?B?KzU5TXFjZ0Fjc1ZEV3JkTWl2Vkt1ZFVsZFcvZ2tSd3ZZRENHSFh0WTFpYXJi?=
 =?utf-8?B?VXExOUptWmQ0Szh5ZVBoK1RYS3dYbFZ5UllGQjkvQ2V1TStXZVJaMTltS1g4?=
 =?utf-8?B?a0ZaTWZDNGorcW9GVkpxRnJkcUpTZ3BJM3MrdkU0ZnE4aXVsbElOZTR0Szdo?=
 =?utf-8?B?TytzRjdZNnZnRjYzTlJhTlZqMDZxdjk5akdCUUtmUXd1SGYwNldnK2FhREFk?=
 =?utf-8?B?MVFTK0hpN1phb3NjSTRTYmIrc1RWQ2dDVnNNSzlORGFtbzAyUGVUNFc3bnRM?=
 =?utf-8?B?TzVmVnF2ckZhKzFZcEFQanR5b2o2WGp2Y24wU21MUXFJM1FPa3RCSE1xSEIv?=
 =?utf-8?B?c1JNbmIrRUVzSHZSVS9TUWF2LzdCMGIwWXBsaUI5VU03cndZTUhuL2FHZDVN?=
 =?utf-8?B?ZzVRczQ3c2tFVkpZRlRpSnVPK01pTmdPRlUzcjkxSlpIYUJnSVVjeUhEZmZU?=
 =?utf-8?B?WG10VUp2OTF4d2pQcWlpZkFHZUVBMmplQXRtam91elhzRUtQcHhWbEo5V2x1?=
 =?utf-8?B?UEVOWDAvUGwzMElIMDkxVFNyY2diMVRlYXFFQT09?=
X-Microsoft-Antispam-Message-Info: aT48p30Bi3Z6ML2foNz1rzdWZDqKpWsGXS1JMCo/CoVXpaC7i3jOtuy+9tBZIiuNKKW/VpK2hkBz2bZlAfYPpXQt0lRCc2lpiVsvAOElHR8sOTBym/bgfdlFoaF0U9nU+e59KjACL48YqQ1ujQMe8geKvpYxWcXPZrplEYKgpyr5UHBEz/RtjyXTx3p1wWBJ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;6:DwbfnPnUcMOiUh+4k+YnYwuNQWILjaUOrH92+4FvS6VX3o7zNDk2TevU2u0dQP5y5gICBw8HErL4KuXKYd+OwsFKMsWNvmRAjX1yLDPqmswIY4+MqpBloBCfO70u5EWi9ExSHlz43dMX7FlbUp9fPmxP+CglcxVa9lpVmTJRGaqpffu3xZx+twwgkStJXxAY+CzxgLI1P3HBWpBbdLYcpYKWnlBVXkjx1I5W5m66vQqp3vvK/IFZ34AE1G+3KkRbS279rFCVu6UZYrbOn8Xrd8g4BulUcAIjwAw+bSXXtmafm+cXLZdnixqiSKVdhZGRuFT5G9cycIrDJCAaK6WW1KGOIFFqbtQTPjv3YRpUftnGVi9B1AcrToF7Lp+GCrTnY39Qw26qB3NI9c77RFgIYXkkjo0HGlG8m1kq6PB2Q5bnyGm354pi93wf+eHIwjT0tu/I30y71reWf0FcbTXQ6A==;5:s608Qjo4neEOUH4x8X5pPV4U4QVgDHFlV8nz4+kvsjTO55OC78yWmV+ivXTOncG1CqG3U8oCkBOK3qNHaMfByk/5XZUbSVp6AvFw2QEvhEqkhkIhyn5v6vWf3ZBhp1CB1cSNag9wBqLFY21xTUNGbn3PVspVElFAMhqMGKpVQtc=;24:PUrp2K9wkcaUQK9B1fxxftgfKMd6fyBiI6fHytlurQv3sens+0x/RcL/sqKA8b5I4Z/ot2ojS7bZDy2EJE//oEaDUtbsdy/e86ypD+SDanU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;7:04FQNSItDNM5PDocYWIpNcN9LoipY5yK12TOZFZ9GnO+Q0C4Ji3jJRRPtISnn4z0JENDMPnm7cmkQQqaGdpKJZ3iUWTqt7gJIrCn0HV5HfECYwY50xmFY3eFv0+nhXAHa4njAlItGmo4Vd0wdKTe3FuP7+TIfK8DzFmC6tsu/PH800ojb692xm7px8KnPzotw9ZkXry2iezAFLejjHpbKtiJ+2RUqw2lmRf1PHy5dKAL269/Ch357s+kX4ENCfc6
X-MS-Office365-Filtering-Correlation-Id: ba1ea7d8-6418-4681-8c65-08d5bff95dcf
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 15:33:27.4437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1ea7d8-6418-4681-8c65-08d5bff95dcf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2018 12:45 AM, Qing Huang wrote:
> 
> 
> On 5/17/2018 2:14 PM, Eric Dumazet wrote:
>> On 05/17/2018 01:53 PM, Qing Huang wrote:
>>> When a system is under memory presure (high usage with fragments),
>>> the original 256KB ICM chunk allocations will likely trigger kernel
>>> memory management to enter slow path doing memory compact/migration
>>> ops in order to complete high order memory allocations.
>>>
>>> When that happens, user processes calling uverb APIs may get stuck
>>> for more than 120s easily even though there are a lot of free pages
>>> in smaller chunks available in the system.
>>>
>>> Syslog:
>>> ...
>>> Dec 10 09:04:51 slcc03db02 kernel: [397078.572732] INFO: task
>>> oracle_205573_e:205573 blocked for more than 120 seconds.
>>> ...
>>>
>> NACK on this patch.
>>
>> You have been asked repeatedly to use kvmalloc()
>>
>> This is not a minor suggestion.
>>
>> Take a look 
>> athttps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8c13f2271ec5178c52fbde072ec7b562651ed9d 
>>
> 
> Would you please take a look at how table->icm is being used in the mlx4 
> driver? It's a meta data used for individual pointer variable referencing,
> not as data frag or in/out buffer. It has no need for contiguous phy. 
> memory.
> 
> Thanks.
> 

NACK.

This would cause a degradation when iterating the entries of table->icm.
For example, in mlx4_table_get_range.

Thanks,
Tariq

>> And you'll understand some people care about this.
>>
>> Strongly.
>>
>> Thanks.
>>
> 
