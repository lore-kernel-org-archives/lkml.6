Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeFEHMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:12:23 -0400
Received: from mail-co1nam03on0072.outbound.protection.outlook.com ([104.47.40.72]:37920
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751459AbeFEHMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:12:22 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Topic: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Index: AQHT9nNowv/ltW4OykevBDGzU2j6naRP61UAgAADYQCAAA4IgIAAASGAgABlK4CAAOkfgA==
Date: Tue, 5 Jun 2018 07:12:18 +0000
Message-ID: <B1C611B8-2753-48CF-BF7E-74FD3A2D4CFD@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-19-mb@lightnvm.io>
 <54B2CCDB-B869-4087-8AE2-2AC73381B1FF@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E382351@IRSMSX109.ger.corp.intel.com>
 <3B216FC2-D5EB-4A36-8946-27307DA3D1B1@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E3833ED@IRSMSX109.ger.corp.intel.com>
 <3A87DF02-6471-4B92-9DDC-4E0FD98249A4@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E38365C@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <9FC4315EA6BEAA449828D92CF173A10D3E38365C@IRSMSX109.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB490;7:3iUIm9gCI6CEw+bsBL9/vPRvjFFJwWQGCA950MZbvM2OYX2EddbwgZ6hT4DVkrc60ynTJX/+zWlcKeCo3KnwXFNu5kHFR+X0cPO8qOkAKKh7vhghGfevqXOwzDpq/Ip85gMqPXuE8uBj5Gaxy9vhYbFlABAZVKM4zWfVyAllgb5eoOBN1yIGTUN4mrEkJLvbL+vrWuYFWiDI+1oLeITAfBT8rNg+4jNixzBTGLuGG1hXtfXFuCJSSqaBWvCC75ox
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB490;
x-ms-traffictypediagnostic: CO2PR06MB490:
x-microsoft-antispam-prvs: <CO2PR06MB490272E80C35E38F44AD79CBA660@CO2PR06MB490.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(67672495146484)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB490;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB490;
x-forefront-prvs: 0694C54398
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39840400004)(376002)(346002)(396003)(39380400002)(189003)(199004)(13464003)(7736002)(26005)(11346002)(102836004)(305945005)(8936002)(6246003)(229853002)(4326008)(6486002)(53546011)(8676002)(81166006)(81156014)(33656002)(93886005)(6506007)(2900100001)(14454004)(6116002)(476003)(478600001)(25786009)(2616005)(446003)(53936002)(6512007)(186003)(486006)(82746002)(5250100002)(3280700002)(54906003)(99286004)(68736007)(6916009)(5660300001)(106356001)(105586002)(3660700001)(2906002)(86362001)(97736004)(36756003)(76176011)(316002)(6436002)(83716003)(66066001)(3846002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB490;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eG/xRfUi+Gn40deoMiknximNQlu7/DXwYRCI1jeuShbi3MYzq7zO/+IJMIxXWnO/HXPFQOJjt6NL3gatTbO8npcev7CxgfthC7a4yIEl0LPAb2CFY+sKvz0Z5WIcgfSnmK5wUCJCIJHG9/p+OsgVCq1Xe7Jbto9faFTW/cmXBCNqrP0RGCBrK4OVPGqPree2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1692500B3702324D934FACE84CD30689@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 25ee7525-8962-4423-c6b2-08d5cab3ac78
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ee7525-8962-4423-c6b2-08d5cab3ac78
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 07:12:18.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB490
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w557CSQZ020900

> On 4 Jun 2018, at 19.17, Dziegielewski, Marcin <marcin.dziegielewski@intel.com> wrote:
> 
>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
>> Sent: Monday, June 4, 2018 1:16 PM
>> To: Dziegielewski, Marcin <marcin.dziegielewski@intel.com>
>> Cc: Matias Bjørling <mb@lightnvm.io>; Jens Axboe <axboe@fb.com>; linux-
>> block@vger.kernel.org; linux-kernel@vger.kernel.org; Konopko, Igor J
>> <igor.j.konopko@intel.com>
>> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
>> equals to 0
>> 
>> 
>>> On 4 Jun 2018, at 13.11, Dziegielewski, Marcin
>> <marcin.dziegielewski@intel.com> wrote:
>>>> -----Original Message-----
>>>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
>>>> Sent: Monday, June 4, 2018 12:22 PM
>>>> To: Dziegielewski, Marcin <marcin.dziegielewski@intel.com>
>>>> Cc: Matias Bjørling <mb@lightnvm.io>; Jens Axboe <axboe@fb.com>;
>>>> linux- block@vger.kernel.org; linux-kernel@vger.kernel.org; Konopko,
>>>> Igor J <igor.j.konopko@intel.com>
>>>> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when
>>>> mw_cunits equals to 0
>>>> 
>>>>> On 4 Jun 2018, at 12.09, Dziegielewski, Marcin
>>>> <marcin.dziegielewski@intel.com> wrote:
>>>>> Frist of all I want to say sorry for late response - I was on holiday.
>>>>> 
>>>>>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
>>>>>> Sent: Monday, May 28, 2018 1:03 PM
>>>>>> To: Matias Bjørling <mb@lightnvm.io>
>>>>>> Cc: Jens Axboe <axboe@fb.com>; linux-block@vger.kernel.org; linux-
>>>>>> kernel@vger.kernel.org; Dziegielewski, Marcin
>>>>>> <marcin.dziegielewski@intel.com>; Konopko, Igor J
>>>>>> <igor.j.konopko@intel.com>
>>>>>> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when
>>>>>> mw_cunits equals to 0
>>>>>> 
>>>>>>> On 28 May 2018, at 10.58, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>> 
>>>>>>> From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>>>>>>> 
>>>>>>> Some devices can expose mw_cunits equal to 0, it can cause
>>>>>>> creation of too small write buffer and cause performance to drop
>>>>>>> on write workloads.
>>>>>>> 
>>>>>>> To handle that, we use the default value for MLC and beacause it
>>>>>>> covers both 1.2 and 2.0 OC specification, setting up mw_cunits in
>>>>>>> nvme_nvm_setup_12 function isn't longer necessary.
>>>>>>> 
>>>>>>> Signed-off-by: Marcin Dziegielewski
>>>>>>> <marcin.dziegielewski@intel.com>
>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>>>>>> ---
>>>>>>> drivers/lightnvm/pblk-init.c | 10 +++++++++-
>>>>>>> drivers/nvme/host/lightnvm.c |  1 -
>>>>>>> 2 files changed, 9 insertions(+), 2 deletions(-)
>>>>>>> 
>>>>>>> diff --git a/drivers/lightnvm/pblk-init.c
>>>>>>> b/drivers/lightnvm/pblk-init.c index d65d2f972ccf..0f277744266b
>>>>>>> 100644
>>>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>>>> @@ -356,7 +356,15 @@ static int pblk_core_init(struct pblk *pblk)
>>>>>>> 	atomic64_set(&pblk->nr_flush, 0);
>>>>>>> 	pblk->nr_flush_rst = 0;
>>>>>>> 
>>>>>>> -	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
>>>>>>> +	if (geo->mw_cunits) {
>>>>>>> +		pblk->pgs_in_buffer = geo->mw_cunits * geo-
>>> all_luns;
>>>>>>> +	} else {
>>>>>>> +		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo-
>>> all_luns;
>>>>>>> +		/*
>>>>>>> +		 * Some devices can expose mw_cunits equal to 0, so
>> let's
>>>>>> use
>>>>>>> +		 * here default safe value for MLC.
>>>>>>> +		 */
>>>>>>> +	}
>>>>>>> 
>>>>>>> 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
>>>>>>> 	max_write_ppas = pblk->min_write_pgs * geo->all_luns; diff --git
>>>>>>> a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>>>>> index
>>>>>>> 41279da799ed..c747792da915 100644
>>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>>> @@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct
>>>>>> nvme_nvm_id12
>>>>>>> *id,
>>>>>>> 
>>>>>>> 	geo->ws_min = sec_per_pg;
>>>>>>> 	geo->ws_opt = sec_per_pg;
>>>>>>> -	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC
>> safe values
>>>>>> */
>>>>>>> /* Do not impose values for maximum number of open blocks as it is
>>>>>>> 	 * unspecified in 1.2. Users of 1.2 must be aware of this and
>>>>>>> eventually
>>>>>>> --
>>>>>>> 2.11.0
>>>>>> 
>>>>>> By doing this, 1.2 future users (beyond pblk), will fail to have a
>>>>>> valid mw_cunits value. It's ok to deal with the 0 case in pblk, but
>>>>>> I believe that we should have the default value for 1.2 either way.
>>>>> 
>>>>> I'm not sure. From my understanding, setting of default value was
>>>>> workaround for pblk case, am I right ?.
>>>> 
>>>> The default value covers the MLC case directly at the lightnvm layer,
>>>> as opposed to doing it directly in pblk. Since pblk is the only user
>>>> now, you can argue that all changes in the lightnvm layer are to
>>>> solve pblk issues, but the idea is that the geometry should be generic.
>>>> 
>>>>> In my opinion any user of 1.2
>>>>> spec should be aware that there is not mw_cunit value. From my point
>>>>> of view, leaving here 0 (and decision what do with it to lightnvm
>>>>> user) is more safer way, but maybe I'm wrong. I believe that it is
>>>>> topic to wider discussion with maintainers.
>>>> 
>>>> 1.2 and 2.0 have different geometries, but when we designed the
>>>> common nvm_geo structure, the idea was to abstract both specs and
>>>> allow the upper layers to use the geometry transparently.
>>>> 
>>>> Specifically in pblk, I would prefer to keep it in such a way that we
>>>> don't need to media specific policies (e.g., set default values for
>>>> MLC memories), as a general design principle. We already do some
>>>> geometry version checks to avoid dereferencing unnecessary pointers
>>>> on the fast path, which I would eventually like to remove.
>>> 
>>> Ok, now I understand your point of view and agree with that, I will
>>> prepare second version of this patch without this change.
>> 
>> Sounds good.
>> 
>>> Thanks for
>>> the clarification.
>> 
>> Sure :)
>> 
>>>>>> A more generic way of doing this would be to have a default value
>>>>>> for
>>>>>> 2.0 too, in case mw_cunits is reported as 0.
>>>>> 
>>>>> Since 0 is correct value and users can make different decisions
>>>>> based on it, I think we shouldn't overwrite it by default value. Is
>>>>> it make sense?
>>>> 
>>>> Here I meant at a pblk level - I should have specified it. At the
>>>> geometry level, we should not change it.
>>>> 
>>>> The case I am thinking is if mw_cuints repoints 0, but ws_min > 0. In
>>>> this case, we still need a host side buffer to serve < ws_min I/Os,
>>>> even though the device does not require the buffer to guarantee reads.
>>> 
>>> Oh, ok now we are on the same page. In this patch I was trying to
>>> address such case. Do you have other idea how to do it or here are you
>>> thinking only on value of default variable?
>> 
>> If doing this, I guess that something in the line of what you did with
>> increasing the size of the write buffer via a module parameter. For example,
>> checking if the size of the write buffer based on mw_cuints is enough to
>> cover ws_min, which normally would only be an issue when mw_cuints == 0
>> or when the number of PUs used for the pblk instance is very small and
>> mw_cuints < nr_luns * ws_min.
> 
> 
> I see here two cases:
> - when mw_cunits > 0 buffer size should have number of entries at
> least max(mw_cunits, ws_min) * nr_luns and here we are taking care of
> both cases mw_cunits > ws_min and mw_cunits < ws_min.
> - when mw_cunit == 0 buffer size should have number of entries at
> least ws_min * nr _luns and we can use the same puseudocode as above.
> 

Agree.

> Do you see any other case? Could you clarify second case mentioned by
> you or maybe did you mean opposite case? If yes, I believe that above
> pseudo code will handle such case too.
> 

Yes, it is the same case.

One thing to consider is whether the buffer should at least be ws_opt *
nr_luns for performance reasons. Since the write thread will always try
to send ws_opt, in the case that ws_opt > ws_min, then a buffer size of
ws_min * nr_luns will not make use of the whole parallelism exposed by
the device.

Therefore, I would probably go for ws_opt * nr_luns as the default value
when mw_cuints * nr_luns < ws_opt * nr_luns (which covers mw_cuints ==
0), and then keep ws_min * nr_luns as the minimum requirement when
setting the buffer size manually.

Does this cover your use case?

>>>>>> Javier
>>>>> 
>>>>> Thanks,
>>>>> Marcin
>>>> 
>>>> Javier
>>> Thanks,
>>> Marcin
> Thanks!,
> Marcin
