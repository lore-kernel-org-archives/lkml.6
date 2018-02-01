Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeBAIP4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:15:56 -0500
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:58159
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751836AbeBAIPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:15:51 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com;
Subject: Re: PATCH v6 6/6] livepatch: Add atomic replace
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, jikos@kernel.org, mbenes@suse.cz,
        Jason Baron <jbaron@akamai.com>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
References: <20180125160203.28959-1-pmladek@suse.com>
 <20180125160203.28959-7-pmladek@suse.com>
 <3e93e7b5-3077-9f03-ae89-55394e70da39@virtuozzo.com>
 <20180131215518.cwcxs2atfuzimyxt@treble>
From: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <e7c51e65-e961-1df3-6d63-93dc94fe5acb@virtuozzo.com>
Date: Thu, 1 Feb 2018 11:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131215518.cwcxs2atfuzimyxt@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.25.160.64]
X-ClientProxiedBy: HE1PR0401CA0045.eurprd04.prod.outlook.com
 (2603:10a6:3:19::13) To DB6PR0802MB2438.eurprd08.prod.outlook.com
 (2603:10a6:4:a0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e7fbc08-ceed-4ee1-6966-08d5694bff95
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0802MB2438;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2438;3:JXai3T5Wg1NVt09DVyjZX5/4O18a0jvq3N038SvFK1jgT0r+EfmOH5eBoUrXzBrb1g2z/laJp3Z+dz6/Yy0saouOrpL0CmLiIzk8Uavy1FM9H3zk9kDt6Em6ohL/AZl6WudqJNOr/f7lnpdB07PM5JUKMSv52ObrdzVjlMB8hKgkSdeO3xuXxwCuuwkJEs1vyVkLsK9OGpSJEDCuquCvLe7OSAJHSdMbUArhr7nmihoFmCaxdQ8YyqokSG1cCO+2;25:S2pmtdsktxD8vjMD7fsbGvsrGKuPbz2RzCDQyHLDyGReV/qHvvJbuBYy7VBzScNPed5ukrxP2twDBRpMdbAQ89Cw/W8oU2gjHTVaI7qFKA1PZ4FgMyA0DLWFbwULF9I1i4osjZ3MLV4CLYkKHpSl0sNBS21RT02LTEg4pY83pTJmrQAbpjWIaaESYP+P4bqIZtzqY64MoCXhHamYOvE3J1m0VlJO6gsIh+sxCbXn1k1a6edkwJa9WpzINCwOz3azQYyWrYTjn3GUBFUEk5xT3KuDJnxzH7ZhitHFZqoyM31H2vfQ8o2AinGCfZ0IXUNiFoPq1MyDCMiHyPX2Yb+fRQ==;31:X11elANk21XuSdCf2+ZToWHYmCXvJN27rEnltu/wr8fk2SVJkEC2AlFSE5IaVN1RvLL/vj3up9nJa+U3zcZbUkywGlSBNw8fGxV9b2D3NxCZqTcr5KD/7Tu7p/3bw0lCc6naXyTQiSO3S5DobGeMBITfpa5fGR2ulfsRDae3GNwjNj0CnOr9AMVHAhmInNg+8ksK8oVdJJlmo58vxQjEkX2zRhZHkb3anopoDpuIOFo=
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2438:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2438;20:Xn8q4lUSDXacdfwjz6+ofOhi00cXFe9NbOHdrXa5swkcD+d8Eskjz01aHpEB1pBCt+vDSUPmGcxxVGw0ksRctwRg0hkmtOJC8QiAjTqsNjyYVPo/LwOu926zTE8xPgovyO8bH6Z9xkZ77fNsXXfOIeL+5fXxU7qyHYLwNB7zOj+oeK6NXZnPvAJjve69fDVmfjKLimM78TvkpHr4nZGl4+GvzP9zkA2zBOLcrZW22g9UkeyNw7vn1gi2kOx8rIdxzfCm9SIKUTBcAmme1YQ4s0dUwmulVrZrJJVYNq2gNHIncKuNtBlfl80mnZVorFJwzuY3MKScGCEB2jW/GAxegKors8IUTP1zWHgIgSo9+8StK6PlZ/d6kvvggzGl8EP9ENz9Pe9Mu+exeDh9Dotv7vOWgsffZtcPD/lZiM6q/B0=;4:RV+Idz/3t4NywmuWKncrKh3r1+3on8VCx+IF47y64PH67NpDfKXiNKxfv39+apavlY602uqhrxnTHTG5b7+RHG1Ci8r2efOtk1pi7ApIZfJ0Jz4C2yVk7vS74nRIdPORp3Bo3wIam7eLUbUBX3AV5UvdKQcGy1s5ZTQ4CxtmnnWymzUiOziB5jJVbA15e5vCurvHq8z3JPaAUdzMfAiLpCOYNKQrxNGkLsyNRwm1WYiW6J9nuJe/yvQzWma6GRlff7dIerk+lA2HizuB63MwDxkP1Ni9Eqk7LJ/9lYcXnWqnQuYnvpPC4f8HraIziq6x
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2438BBD9B4DC166285E42778D9FA0@DB6PR0802MB2438.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6041288)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0802MB2438;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0802MB2438;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(52314003)(97736004)(6116002)(65826007)(230700001)(76176011)(52146003)(7736002)(478600001)(31696002)(229853002)(53936002)(23676004)(65806001)(5660300001)(66066001)(52116002)(305945005)(2486003)(93886005)(54906003)(6486002)(4326008)(47776003)(77096007)(65956001)(316002)(25786009)(6916009)(81166006)(53546011)(16576012)(16526019)(8936002)(83506002)(2950100002)(86362001)(81156014)(2906002)(106356001)(8676002)(68736007)(6666003)(36756003)(186003)(105586002)(64126003)(67846002)(117156002)(6246003)(50466002)(58126008)(3846002)(386003)(26005)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0802MB2438;H:[192.168.0.101];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDJNQjI0Mzg7MjM6dFk5Q3NYdGQvRkZncVBSYm5IalU0dTF6?=
 =?utf-8?B?cFpqeDZCeHRQODBBV2NXUHlXcERVM3ZvUXVNem1OVGN5bWlVQTRCTGxCL2pF?=
 =?utf-8?B?VDdzZTJMaUVRb21JR0Z5WlVrcERHWkV4ZWNZbjYrazB3Ym9scXhHUXZ1NFpN?=
 =?utf-8?B?OCsvZE1XVmNKOFNLQkN5Z3BJcmVhOUpjM0pKM1F6TGoweUlVWWpGd3Y1TWIv?=
 =?utf-8?B?OGFPK003VHNDYnV2UmJhbFRYa3htRUhSdnV6N3dQK0FYYzcyQ0QxMGFJalBR?=
 =?utf-8?B?UGpRVTlJME1lL0YrN1dIVk1GTnhuUGdqZVcyQjRNODdhdnFMZzlwUDlPSEZv?=
 =?utf-8?B?QnlqNUpMUWlyNXBXTTJnWjdkQTNKeURJS21lR2kxT2wvVlFnNjlaMFdHcHJn?=
 =?utf-8?B?MnlDMzEvbzZKd05BNXNON0k0clRJWWFuSUNYajBNckV2ZUw4RFFIbDIvU2c4?=
 =?utf-8?B?ZTNaR2tpaVdWZ1RubmNRaXFEM2ZKdjJIM21QSndqUEZLN1I1Z1I0eTVEY2hq?=
 =?utf-8?B?ZUVPdEJvblRxajNkS041Vm94alQvdkgyaTdNVFY1UVB4TEp3V2d2ZUQ3ZlM1?=
 =?utf-8?B?MHhNb2hNRWJjYk90eE54NWgyRlRRZEtRdjQzQlNXdkhwaFd0VFRCYXlrRE54?=
 =?utf-8?B?ZGtYYXhYMXdRWFluWDFxMWNGeVpmM0V4WkVPNmRaakpualhvSEd4QTZCZGdi?=
 =?utf-8?B?bWUrM0pmQTYyeFFPVUxsTkVLeXFabFZVL0tMZWx6K1NyZ2hKN05MTE5BUUlQ?=
 =?utf-8?B?S0RFMG5HaVdiaCtVU1Y0OURYQXFRL3NnTzVRVGVDWTh0RU1ES1o1WU9CNlVh?=
 =?utf-8?B?MGRoVmhnTUhsVVRvcVdnc1BUMFRwZEk0VmxOdTE0UkIzS2pqNm1xL216bWJB?=
 =?utf-8?B?cTNIQWxFZ3ZMYldEWGdwNnhCc1RxNHlRMUx4U0dsc0hzWW1TZFRhcjNjdnp5?=
 =?utf-8?B?aWxUSW53bzZQeUhhbnJXbTdabENjQndiVXZUYm0rQ1YxS1dDdW1NbG9RVzZG?=
 =?utf-8?B?cXJ0cDEwdTZxQzhFWmx5NzZRQk9Td1ljNE9HaEFXZWpEWHJ3anE0c0tYTHhV?=
 =?utf-8?B?cTNaS3IzZVJQMXhIcDRhT0JkaUhuZDVWUmxYSlRpblRqQUR5NlpzUzdiYXBz?=
 =?utf-8?B?djNxQ1h0cXZGREF6R1BGa2JzY2tWWUFLWnZoTXpHUHJqNFNrRHZPc1BMeXF3?=
 =?utf-8?B?VWdMempxWkRmMGd3Q2VXUk56VGtNRW55UzRiSEdoUFhzTFE5cEZDU1J5VXRI?=
 =?utf-8?B?U2QwN3F2TUsrZ2czTjhLZjJibnl2eWlnaXZmMDlzQWw3ejIzdjNJa2Q3WWRR?=
 =?utf-8?B?M05XZUVXRTVia2gydnFxbms5Wm9nOFFlcHUwdzM1d2daU2phOFloMkMzMU90?=
 =?utf-8?B?K01GUGl2ek85c3NqL3dSdFFEQktUbWo0RXBqbVZTaE11b1VwbzVMOVJrZ0xM?=
 =?utf-8?B?aWxOTDdOcWRPZjJVb0UrMVZRcWZvUlJDbEF4d0xCUllNZ1pOQy9NSnorNHQy?=
 =?utf-8?B?OTFLNWFIaWIrbGladU9nbFA4VWYwN3I4UmJzbmpMYW9oaFdkalJDRkZoU1NG?=
 =?utf-8?B?SEJUdHJVV2dycmVMZHVXeXFycjd6eXoxTjRPMW1BRTZ4dkRNdThKUjF4R1ov?=
 =?utf-8?B?b1VmbTV2dnh4aFpKZlBwS3ZRTXN1UHpxbG5KQmZ1clR2dGtKOG0rVWxISUZQ?=
 =?utf-8?B?VWNLcjhiSXFXM3lrWkx2YUtPZC9nV1VVSVVFUDNmL1A1NUY5Nmg0cm5zNEFv?=
 =?utf-8?B?L3hCWVQ0Zy92VnhabWRVWUlYV1Y4RXZSNjI0VmFHNWszR284cDBnendBYUp1?=
 =?utf-8?B?SHRHSzh5MHFld3NMUXd6WVo4OVNDU2ZMQ29VOXBUam9MWGJ6SFgvRURhSXFR?=
 =?utf-8?B?OUJZMjJZWWFzY1NEMjZBZGtET25HQm1tVSt1M1Nhd3ZHRkFab0VPNU5Fc0xm?=
 =?utf-8?B?eDBBeG1vcnpiTjdCWEg0bUx5ZHJQdEpWdTZWZ1pycEVKQzd3SCt0N1IweUF0?=
 =?utf-8?Q?0BGRQr7B?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2438;6:+QXPhxWgOhy211soxeHmSXocxs4rS5N+QkSD4nDQtqTj19FkXenu9H3dw+XMBn0PrJAuspws8Jlwdf2n6jDsqCVOmbi5ooGFp3Wtkv4yQxMJuPggmBy9LQtayPJIzKPA2nLlXHSUtHgnOajGL6BQrJ2JcgxIFg6lDnesdKXvvqMZLSiu5PCShqqCteVzQyvkO19ktGcFlVEu7l1id3nb80HwQddrB+pkkWhUUza9kjTQtn5KbY1zNghiM9GwffS6El3SUyBv17Cyx+jYPdPRsGym8/afj3pkQCaEFe/n3Ubs3lZWoO9DchAWor8iq6hVqM/9lKARYAwMwgKw8rw/T3iotPtyGShEjg0MOFt/U8Y=;5:n+PbLDyqdWL0euLjBEURhapWI1hitxXOvCpvfKIFm+bzH/8fSdcEON+j6kfBWlfgN9NxfnQ4C9Tt+5Ubc7ZtnWTpl9eYqkN1LaruK2pWPNtYGMPo5ML7MlOsF7uTlCq6aQhDsldnannNU2gxYBZFLTyJZ0K24Pr1SuYRCZa5uAo=;24:O68VAlIxYHaeoQwNUzMEykSXFrlcxM5puc+AJclX5Uwk3+FyMiNxnqL4u4BS/vGAHsCkz+He10Q+ccWC1nMttaJ+lOc1Yfovu7O2rFceVdo=;7:8M9Hi1DzeSU3q2PDD8eVEevS+ocuSxMJKo42/pf0I46dZKWdhxiHtG5WqdcObmwBgHdy8Xb3Vux+4U33LvPPsG70wdxD7ryQd5eWMvXb32IXkMuKeUniJ/+luzBfxLTSH1VqG9TNxr1r9sjL8ibQI/B2L8p0rmTPB3VlBV0sNJf4E6sforYLbKXBgDxZeMJ9YYW6lwJow8D/RTV5ihihC6woIx+NAb21wFrzR5BdRWJ96hdzodJbLQe9Vs9Q0jlU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2438;20:aNMUw0NefGjpgdF32mzVVf4OCKDr19kFGh9vrThYnl34KtHMYljR/qkrkFt49HxxPdcy2ls/kDcl4RxidI8TL7nVydGdBtxXTeMDHXkEMIWjsr/Ztx/lEHOMxLP9HULARF7vvUxd32F7flgqE/ME4Zj3IXVKJXVSNo/ST4t4m/o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 08:15:46.5957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7fbc08-ceed-4ee1-6966-08d5694bff95
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2438
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2018 00:55, Josh Poimboeuf wrote:
> On Fri, Jan 26, 2018 at 01:33:04PM +0300, Evgenii Shatokhin wrote:
>>>     + The callbacks from the replaced patches are not called. It would be
>>>       pretty hard to define a reasonable semantic and implement it.
>>
>> At least, it surely simplifies error handling, if these callbacks are not
>> called.
>>
>> Anyway, I guess, this restriction should be mentioned explicitly in the
>> docs. I think this is not obvious for the patch developers (esp. those
>> familiar with RPM spec files and such ;-) ).
>>
>> What concerns me is that downgrading of the cumulative patches with
>> callbacks becomes much more difficult this way.
>>
>> I mean, suppose a user has v1 of a cumulative patch installed. Then a newer
>> version, v2, is released. They install it and find that it is buggy (very
>> unfortunate but might still happen). Now they cannot atomically replace v2
>> back with v1, because the callbacks from v1 cannot clean up after v2.
>>
>> It will be needed to unload v2 explicitly and then load v1 back, which is
>> more fragile. The loading failures are much more unlikely with livepatch
>> than with the old kpatch, but they are still possible.
>>
>> I have no good solution to this though.
> 
> I think the solution is to build a v3, which is basically identical to
> v1, except it also has callbacks for cleaning up after v2, if necessary.
> 
> It should also be smart enough to deal with the case that v2 was not
> installed beforehand.
> 

I thought about this, but such patches would be very difficult to 
maintain. It seems better to explicitly unload v2 and then load v1 back 
in such cases.

In addition, releasing v3 takes some time (build + appropriate QA 
procedures) while the users may want to do something about the faulty 
patch "right here, right now". This is what "downgrade" option is for.

Anyway, livepatch is much more likely to apply the patches successfully 
than the old kpatch core. So it should be OK to simply unload v2 and 
then load v1 in such (hopefully rare) scenarios.

As I said, the current behaviour is acceptable, esp. when it is 
documented. Implementation of livepatch is already complex enough.

Regards,
Evgenii
