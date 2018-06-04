Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeFDKVl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:21:41 -0400
Received: from mail-cys01nam02on0063.outbound.protection.outlook.com ([104.47.37.63]:6278
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750868AbeFDKVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:21:39 -0400
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
Thread-Index: AQHT9nNowv/ltW4OykevBDGzU2j6naRP61UAgAADYQA=
Date: Mon, 4 Jun 2018 10:21:34 +0000
Message-ID: <3B216FC2-D5EB-4A36-8946-27307DA3D1B1@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-19-mb@lightnvm.io>
 <54B2CCDB-B869-4087-8AE2-2AC73381B1FF@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E382351@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <9FC4315EA6BEAA449828D92CF173A10D3E382351@IRSMSX109.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB572;7:sF0CEe9M1/nC9TNlQArQ1wkgIWGYhkyaBX6Yjmq9AV1d4S4TqYkRAku3IMiV0PWFjMPAIkotDVJEfaGXlTDHTAkxNSjP9X4OdCUFflDT342JUhU1/22FIrEXZ/t8rCDTqolE9wicO6iyu8RmNRKuFea9Tb6DP0lziLxn8mBMs1wjqeuqJGMbVwXM7Z/42GHZi6PyZcgVDepsIV8VJD2bjrpYxHOH9kUi2dSLUCcYtVxk/2CQlpSsh6fyTnbLjQ3I
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB572;
x-ms-traffictypediagnostic: CO2PR06MB572:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-microsoft-antispam-prvs: <CO2PR06MB572F91EFDAF627AC37F1B99BA670@CO2PR06MB572.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(67672495146484)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB572;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB572;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39830400003)(396003)(376002)(366004)(189003)(199004)(68736007)(81156014)(476003)(81166006)(2906002)(6916009)(6436002)(99286004)(2900100001)(5660300001)(6486002)(486006)(102836004)(33656002)(186003)(316002)(2616005)(26005)(446003)(6506007)(229853002)(5250100002)(53546011)(54906003)(8936002)(3280700002)(93886005)(53936002)(82746002)(6512007)(76176011)(25786009)(106356001)(478600001)(3660700001)(7736002)(305945005)(8676002)(11346002)(36756003)(3846002)(97736004)(83716003)(6116002)(66066001)(6246003)(105586002)(86362001)(4326008)(14454004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB572;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: L3TyMarZDI40Pefanl48ATVWXG10+x1bLbw2VdH4pIjDtlDbvx4fNJdgp+h+NbxSF+amkwNlzUirdzEYaMUsUcCzmxi7XE858aN2YPimfJ3kcVUEcVookZ80GpKErnGdHOKFiX745yzquAQV3o7dpMVXWLtGRGWavpp+hAX0ceeWQlxIWZhV5yU5rQFNV+Qq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A422B7705D2D504FA7305A68A153EF66@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 038c8fec-6a3b-452e-68e8-08d5ca04f34a
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038c8fec-6a3b-452e-68e8-08d5ca04f34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 10:21:35.0088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB572
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w54ALmp3004091

> On 4 Jun 2018, at 12.09, Dziegielewski, Marcin <marcin.dziegielewski@intel.com> wrote:
> 
> 
> Frist of all I want to say sorry for late response - I was on holiday.
> 
>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
>> Sent: Monday, May 28, 2018 1:03 PM
>> To: Matias Bjørling <mb@lightnvm.io>
>> Cc: Jens Axboe <axboe@fb.com>; linux-block@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Dziegielewski, Marcin
>> <marcin.dziegielewski@intel.com>; Konopko, Igor J
>> <igor.j.konopko@intel.com>
>> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
>> equals to 0
>> 
>>> On 28 May 2018, at 10.58, Matias Bjørling <mb@lightnvm.io> wrote:
>>> 
>>> From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>>> 
>>> Some devices can expose mw_cunits equal to 0, it can cause creation of
>>> too small write buffer and cause performance to drop on write
>>> workloads.
>>> 
>>> To handle that, we use the default value for MLC and beacause it
>>> covers both 1.2 and 2.0 OC specification, setting up mw_cunits in
>>> nvme_nvm_setup_12 function isn't longer necessary.
>>> 
>>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 10 +++++++++-
>>> drivers/nvme/host/lightnvm.c |  1 -
>>> 2 files changed, 9 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/lightnvm/pblk-init.c
>>> b/drivers/lightnvm/pblk-init.c index d65d2f972ccf..0f277744266b 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -356,7 +356,15 @@ static int pblk_core_init(struct pblk *pblk)
>>> 	atomic64_set(&pblk->nr_flush, 0);
>>> 	pblk->nr_flush_rst = 0;
>>> 
>>> -	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
>>> +	if (geo->mw_cunits) {
>>> +		pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
>>> +	} else {
>>> +		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo->all_luns;
>>> +		/*
>>> +		 * Some devices can expose mw_cunits equal to 0, so let's
>> use
>>> +		 * here default safe value for MLC.
>>> +		 */
>>> +	}
>>> 
>>> 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
>>> 	max_write_ppas = pblk->min_write_pgs * geo->all_luns; diff --git
>>> a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c index
>>> 41279da799ed..c747792da915 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct
>> nvme_nvm_id12
>>> *id,
>>> 
>>> 	geo->ws_min = sec_per_pg;
>>> 	geo->ws_opt = sec_per_pg;
>>> -	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values
>> */
>>> /* Do not impose values for maximum number of open blocks as it is
>>> 	 * unspecified in 1.2. Users of 1.2 must be aware of this and
>>> eventually
>>> --
>>> 2.11.0
>> 
>> By doing this, 1.2 future users (beyond pblk), will fail to have a valid
>> mw_cunits value. It's ok to deal with the 0 case in pblk, but I believe that we
>> should have the default value for 1.2 either way.
> 
> I'm not sure. From my understanding, setting of default value was
> workaround for pblk case, am I right ?.

The default value covers the MLC case directly at the lightnvm layer, as
opposed to doing it directly in pblk. Since pblk is the only user now,
you can argue that all changes in the lightnvm layer are to solve pblk
issues, but the idea is that the geometry should be generic.

> In my opinion any user of 1.2
> spec should be aware that there is not mw_cunit value. From my point
> of view, leaving here 0 (and decision what do with it to lightnvm
> user) is more safer way, but maybe I'm wrong. I believe that it is
> topic to wider discussion with maintainers.
> 

1.2 and 2.0 have different geometries, but when we designed the common
nvm_geo structure, the idea was to abstract both specs and allow the
upper layers to use the geometry transparently. 

Specifically in pblk, I would prefer to keep it in such a way that we don't
need to media specific policies (e.g., set default values for MLC
memories), as a general design principle. We already do some geometry
version checks to avoid dereferencing unnecessary pointers on the fast
path, which I would eventually like to remove.

>> A more generic way of doing this would be to have a default value for
>> 2.0 too, in case mw_cunits is reported as 0.
> 
> Since 0 is correct value and users can make different decisions based
> on it, I think we shouldn't overwrite it by default value. Is it make
> sense?

Here I meant at a pblk level - I should have specified it. At the
geometry level, we should not change it. 

The case I am thinking is if mw_cuints repoints 0, but ws_min > 0. In
this case, we still need a host side buffer to serve < ws_min I/Os, even
though the device does not require the buffer to guarantee reads.

>> Javier
> 
> Thanks,
> Marcin 

Javier
