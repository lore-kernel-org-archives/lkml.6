Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE38BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950682168C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="QsiZFFpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950682168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbeHCPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:01:28 -0400
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:50000
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729924AbeHCPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt7NDIXoZ7qMiQUJlcNWELHH3djodC5QKBCJvFiJw40=;
 b=QsiZFFptC4AP9TX1pWrA/zLXSV5J2xsKqgkqVFVKoJMSckU0S8/MYVqJKlVs+IRwcvleG2p/aovy+udAzTcqW2dJjpw9lhPgCDSIe7g1cl9U5rI28H1ytx7JZCcH0ijv04Sg8JttLCptRUxw0xY3/ZXPO5WUki4DbplpamIFCCI=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB587.namprd06.prod.outlook.com (10.141.229.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 13:05:09 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 13:05:08 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Thread-Topic: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Thread-Index: AQHUKqOqJvYCHWb7506nHMv0DcNCh6St8uCAgAAF+wCAAARhAIAAAq2A
Date:   Fri, 3 Aug 2018 13:05:08 +0000
Message-ID: <E3EFEEB3-8B6A-4743-B383-B29482081CC7@cnexlabs.com>
References: <20180802205841.22039-1-mb@lightnvm.io>
 <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
 <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
 <ef8cd1ac-623b-96ed-1a7f-3e390fcc51d5@lightnvm.io>
In-Reply-To: <ef8cd1ac-623b-96ed-1a7f-3e390fcc51d5@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB587;6:3ncI/ybgOLx6hHyIZwZQqov/tEIqJLmdo6f49wlzAXdPAT9bsWnLnj9zAb8vaFqzKWoIuAX7gGLnFTHoAXQX2amKCsd+fGWL7Mxrey4Om7ymUf6k6Vw7xE6f+GtARs0Xrd5J58eYuvDUs52Lq9z1xqjOFek5Y5xGCmnENyiirzj19QpnV9lMGp5MVmguam8Np74w1u2oe5ap/vzriA12RkwlJp3T+caThHvJT+Bgbz8tVNbgrhyIpzjTlBjZA8YMP/5UVXuSylaa7rcgw+zMjvWeTp4Fg26YgNSY+rxs1gvjtdHYtpSDi9XUrIcLFdPtCOvML66g59j24FSwjgVfYqTTeFdAUpeS8ovkRebd/Wc8jlKmHJ1NJzaAAXZ9oC1iWrSASZcMg6YIQZR5BfanQVYci7YH4FsOHyZ6Vxm7m3Wm55XXW5ig9W0/jvTkRxHE8TBNMamW/h/TyQcNN6SZuw==;5:2K+HDyqWAMXda74QEyXeg2VIUxQjkRgJlTfk78Sa5RDa6slPUnfyuFTnZ7tus7a2sbFcUa65PH5EKNMQVQH1FX61+KvkCHAkteOYnH5Q7weBWoOfmdQD9dkW1ZGbIbEoIQGuhlmFRDBcfZfSCvG9ctU5grxSOgd++c8cEj74TZk=;7:jsrg0iQ0M43hBQ6bYxJurH1Nk1jP6lHMCqpMBuGmIdAWFQxY+k8klg7gLXrdxj16La8rEj04lx4rJqK9JuRH5JO+tHJuZaHM/qWX4X3k8Va+3GXNlo62W2DwGu/UPRnbouBFt5NXGbngi30+ZLsnwFFQ7E8SpiA26J025MPVSODBkx0joXAAQkOOLPMo4gK2YTao4sDPM3sMV70eJ2Sm93YcKMe9sMintJbx6aKQDHm6r2oTEBFeKtKdM050fxhw
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(51444003)(199004)(189003)(86362001)(25786009)(83716003)(99286004)(33656002)(11346002)(476003)(66066001)(2900100001)(54906003)(99936001)(76176011)(14454004)(105586002)(8936002)(2616005)(229853002)(106356001)(82746002)(53936002)(36756003)(486006)(81156014)(81166006)(6246003)(6916009)(6486002)(8676002)(186003)(53546011)(6436002)(5660300001)(5250100002)(256004)(6116002)(4326008)(3846002)(446003)(508600001)(6506007)(68736007)(6512007)(97736004)(2906002)(26005)(7736002)(305945005)(102836004)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB587;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: f7b8325a-12ec-4de2-2b67-08d5f941bd49
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB587;
x-ms-traffictypediagnostic: CO2PR06MB587:
x-microsoft-antispam-prvs: <CO2PR06MB58733AAB133CBA553D654CDBA230@CO2PR06MB587.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(20161123555045)(201703061421075)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB587;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB587;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vvsZRwKWQi0MtyMJ2aZnIlvZifKzsasR6GaPGLx6cIU30CFfMwpG2QQQp04jN1bvn5yYqhUzXQoMxpmmH5WYWxpWKkGv1JNJ3PZ35Rh5QkP+HCDHjF4KF5NENBxfMfd007TWpDlIF4we3adTPqXiZPn/m+2/O619WhY0DBse8QcXdZ//YpWLBJxKhr5yOOTRHSdlVsQI4Q6O09s63PoN+EbrUL78noWcY5GMsUUwHNchwJDlAiJCYDfOhXRjZvFKN342zNMmVLFqY6SwIzqYRK3Mm+hyx8RldNrhgBoSZQROMMiW88Pm5mROEBuZehBCo26iqYvm6/CxlQd563TciWl+ZHyc9+SpmZhwrA6vKCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b8325a-12ec-4de2-2b67-08d5f941bd49
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 13:05:08.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB587
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 3 Aug 2018, at 14.55, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:39 PM, Matias Bj=C3=B8rling wrote:
>> On 08/03/2018 02:18 PM, Javier Gonzalez wrote:
>>>> On 2 Aug 2018, at 22.58, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>=20
>>>> The nvme driver checks for 1.2 and 2.0 compatibility. If an =
unsupported
>>>> version is reported, the device will not be initialized.
>>>>=20
>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>> ---
>>>> drivers/lightnvm/pblk-init.c | 8 --------
>>>> 1 file changed, 8 deletions(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>> index 537e98f2b24a..e9e2fedff387 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>     pblk->state =3D PBLK_STATE_RUNNING;
>>>>     pblk->gc.gc_enabled =3D 0;
>>>>=20
>>>> -    if (!(geo->version =3D=3D NVM_OCSSD_SPEC_12 ||
>>>> -                    geo->version =3D=3D NVM_OCSSD_SPEC_20)) {
>>>> -        pblk_err(pblk, "OCSSD version not supported (%u)\n",
>>>> -                            geo->version);
>>>> -        kfree(pblk);
>>>> -        return ERR_PTR(-EINVAL);
>>>> -    }
>>>> -
>>>>     if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && geo->dom & =
NVM_RSP_L2P) {
>>>>         pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
>>>>                             geo->dom);
>>>> --
>>>> 2.11.0
>>>=20
>>> The same comment goes for this patch. pblk does support 2.0 and 1.2
>>> today, but it is not guaranteed it will support a new revision =
straight
>>> away. So I think that a check wither here or through the =
.capabilities I
>>> proposed on the other patch is necessary.
>> Works for me. I'll send another patch that enables pblk target to =
tell which version it supports.
>=20
> On second thought. The idea is that pblk will not have to think about
> 1.2/2.0. The core will expose a general address format, etc., such
> that pblk doesn't have to be complicated by that.
>=20

Yes! This was the main motivation for me starting looking into moving
things down.

An issue you might hit is that some conversions are very tightly couple
with pblk (e.g., 32/64 bit L2P conversions). In the code I have on my
end, I ended up having helpers for it, but it does not feel right.

i'm happy to share some thoughts if you want...

> I am working on the various pieces and moving them to core. The patch
> may have gone out a bit early. I will send this again when the 1.2/2.0
> conversions have been applied.

Cool.

Thanks!
Javier



--Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkUwEACgkQIX4xUKFR
nnQ2YA/9G1/+YAEznhbuy0dA5rLQV74CDXYsN5AV7809aKxjSPpl7K8J4BPELETL
GOxtYpJTw5PlrWyM6n8yzrxcM0f0MJBW7+P/lkFZwyaPQR95R5LKX1YSODUNq0Om
yKofS8CxQxVIkFoero62mtTO5MNXB1hKs6WJdo6z0zwYZlzYw95upWpv5jyAimUx
EwHbIk+sEgbyyB6pmK3j158fuAMpWw2JtytvnKCGtMvK2Z8pbUAgcOy4XTfB5llT
fuAHwJ9M/P5I1+bmz4JybZy3PlDsEgjqqlmG9hFVeUiKBL6wwrfE6ZNt2DLGGonS
VpWxjr8HWlK/Hw0bbhVrLbsip/wEi6hImcV6SeISr0oLnPp9DmacAl7WzBtstdMQ
trc5WXmyvl11pRkX/g3TitjqtfXU1y7Hx5DwJCr47pSwFMGq0FSYJm4Xdbp371M1
Gj/bjRpgIF5WbKar9KMbsHhozQoJBusXOiEOxpzFcwcmAEFAtYPOB7JM3gyQuymx
AnOFNrbzYc7bypWa5oUrf6gbPZG8lBrGs4QnF4ivK/L75h0lrBeEkGLwWxr2C7XX
DnIXvkncU6zs51C1d39R/7/6ZfOHKeZldSYacLME72GMDvv7m1ajqjwf6dPrZrW8
7Y8uRlZLA7M4ob0fWrQ9FAeqFdxDEhdijMFVFCxpHvwU723kjPY=
=F1ar
-----END PGP SIGNATURE-----

--Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA--
