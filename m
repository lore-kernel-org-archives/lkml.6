Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD61C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E581E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="pOENqlg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E581E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeICNcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:32:10 -0400
Received: from mail-dm3nam03on0056.outbound.protection.outlook.com ([104.47.41.56]:5860
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeICNcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REjzg4An5Z0BTCksy+luYPkbt2/OJoVcL1MPzN/d9Xs=;
 b=pOENqlg8Smw4r4J28fh2aeDIJnVsH79tTfGYXP2UlkSVcMeqyQ1Z1bi3BBRfK+UFwfd8IL+AWzSixbukfctQMBYxX4ARTbQuf5r9aBpFNI1rDYFe0mXy7IE6HYFlHm+3MFAa8xiEtSPyD9sOJBaV3MDjNl56FPu/vqHDBtlN1Z4=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB460.namprd06.prod.outlook.com (10.141.196.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Mon, 3 Sep 2018 09:12:49 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 09:12:48 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Thread-Topic: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Thread-Index: AQHUP6HN+5S4mphJPEehcGEbp/in3aTZyFEAgAAkpACABGBTAA==
Date:   Mon, 3 Sep 2018 09:12:48 +0000
Message-ID: <D61CDC07-86BC-434A-AE01-135E7B09042C@cnexlabs.com>
References: <20180829140832.29341-1-mb@lightnvm.io>
 <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
 <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
In-Reply-To: <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [185.245.84.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB460;6:QVobMp9NVcEY4GO5Uxdr05XXkGGL0O7c1IDIeNzQZDf9yeCt/HHCprsnmSNjlfDgPwZJ73Oyp3PJCBfaLpfIqt5UIzERBVWMbFYHv0VQdYhgJPrkfVbQG4YlLGkyfMNUG/V19JdeIxFU9T289y36hoN2PE3/0lx9RoVzP/e5wx3LRcoi1MyEs5TEzEukVnfqt4Nf5Eve+ShQ/olCeKHUV9fdxFv6+yeHZ1rM23wPuXVaKH3b5R4igRDcy4MJcjG5IAQc8uU5R1QDFtuU1287VDzHeWKftwDqCGSmml4x1+lMTrlvu0G/rGZjmtB6SjbEFohJEJQ+aRer9RVnOZa1MDo7dEOh/AvtFQlgFA77o0N2IVmrPuINMq/3SBMQM8GETBiAm91Nma7BKddZ7RmySajBy4etU5gYNxo0uwc6yJxaI0LBF4StUBwPtYeBWFTL+oPmv+CY4Ra4iioAT/2LxA==;5:e0Pa7KMUDwZ62UKZXEy/xrWpYuAkUX4bEySeso4T9P3uPL+ztcmevG6pXGUaw/m3T8dID1LUu+w9TkqNKUqae8sazhdESIzsCH0CMCuDx42J/doRY+TD5okm7Yj3YeBm7/vn1vyAPs/d294cPmPcARLlKGIUJaLOgZ/+DDlYgJc=;7:NiuSoZMRR4FcIrde+QteeyaXLyyAAzHKdEY7bnF6Nqe+Kt1RMUrUaUAI2d4pMHyAWyBdgwb7WpHbDhziVDro5AQCcv7r9JOChofBDvH0QwfveCFSoo0rC1ZC1JiOBrq4dHBtOUp3AU7zj5kJjV6UdgScoqIrPwx+X22v1GV910YA4LqfqizEqgj58+hxUmIQHIqy/SN4qNhP6AagqkTJNlQlhOyj/XjnJP1tnfXq+G4KcK6eN31uv21A4X5y4O4v
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39830400003)(346002)(136003)(189003)(199004)(14454004)(68736007)(76176011)(8936002)(99286004)(2906002)(2616005)(6436002)(6512007)(229853002)(3846002)(53936002)(6116002)(486006)(476003)(99936001)(4326008)(11346002)(8676002)(33656002)(36756003)(446003)(6486002)(5250100002)(6916009)(66066001)(316002)(7736002)(83716003)(106356001)(6506007)(53546011)(26005)(102836004)(105586002)(54906003)(25786009)(305945005)(186003)(575784001)(86362001)(81156014)(6246003)(2900100001)(97736004)(14444005)(478600001)(82746002)(81166006)(256004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB460;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: dbf0359e-5754-483b-5ff8-08d6117d6b1d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB460;
x-ms-traffictypediagnostic: CO2PR06MB460:
x-microsoft-antispam-prvs: <CO2PR06MB4602132FAF988FC6D1B6758BA0C0@CO2PR06MB460.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB460;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB460;
x-forefront-prvs: 0784C803FD
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L+DxNBmlUSF7EFfPol45xC58Ffq2okij2ZCkSjDL5jloqMOyPcQLMqHolt8ASW0MTKakAWBH472NDngx5rSOCcuZhJwxR7s3ZTYf25xXPVzMH2J92MIlWGLDREULS/oJ5SicuaW4FPQq/t1FGEzWW6szbQV2WBxH5pPxTDIfzev0tUyERGgkwhB9Dyna37UEea0uer7nM8SovCsPPAsZ/rbqJycjkJWF1Piej1yiAZcE3dSoKXnpq45UHdnJeDOMF1KH3yRIa9wpGkGMKgJbpMcroAXC+GdmIj5JtB5bmNh8SpjnsPgr5M2NXJzBTb/KfdMEQr8uAea1Le+H0KUqLUyheqa9lXmFCdERo0E/9/Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf0359e-5754-483b-5ff8-08d6117d6b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 09:12:48.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Aug 2018, at 16.22, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/31/2018 02:11 PM, Javier Gonzalez wrote:
>>> On 29 Aug 2018, at 16.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> Remove the debug only iteration within __pblk_down_page, which
>>> then allows us to reduce the number of arguments down to pblk and
>>> the parallel unit from the functions that calls it. Simplifying the
>>> callers logic considerably.
>>>=20
>>> Also, rename the functions pblk_[down/up]_page to pblk_[down/up]_pu,
>>> to communicate that it takes a lock on the parallel unit.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-core.c     | 34 =
+++++++++-------------------------
>>> drivers/lightnvm/pblk-map.c      |  2 +-
>>> drivers/lightnvm/pblk-recovery.c |  6 +++---
>>> drivers/lightnvm/pblk-write.c    |  6 +++---
>>> drivers/lightnvm/pblk.h          |  6 +++---
>>> 5 files changed, 19 insertions(+), 35 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index bb1a7cc24cbb..08df6bcd2f81 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, struct =
pblk_line *line, void *priv,
>>> 	queue_work(wq, &line_ws->ws);
>>> }
>>>=20
>>> -static void __pblk_down_page(struct pblk *pblk, struct ppa_addr =
*ppa_list,
>>> -			     int nr_ppas, int pos)
>>> +static void __pblk_down_pu(struct pblk *pblk, int pos)
>>> {
>>> 	struct pblk_lun *rlun =3D &pblk->luns[pos];
>>> 	int ret;
>>> @@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>> 	 * Only send one inflight I/O per LUN. Since we map at a page
>>> 	 * granurality, all ppas in the I/O will map to the same LUN
>>> 	 */
>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>> -	int i;
>>> -
>>> -	for (i =3D 1; i < nr_ppas; i++)
>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>> -#endif
>>>=20
>>> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>>> 	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
>>> @@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>> 				-ret);
>>> }
>>>=20
>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>=20
>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>> +	__pblk_down_pu(pblk, pos);
>>> }
>>>=20
>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>> 		  unsigned long *lun_bitmap)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>=20
>>> 	/* If the LUN has been locked for this same request, do no =
attempt to
>>> 	 * lock it again
>>> @@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, struct =
ppa_addr *ppa_list, int nr_ppas,
>>> 	if (test_and_set_bit(pos, lun_bitmap))
>>> 		return;
>>>=20
>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>> +	__pblk_down_pu(pblk, pos);
>>> }
>>>=20
>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas)
>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct pblk_lun *rlun;
>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>> -
>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>> -	int i;
>>> -
>>> -	for (i =3D 1; i < nr_ppas; i++)
>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>> -#endif
>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>=20
>>> 	rlun =3D &pblk->luns[pos];
>>> 	up(&rlun->wr_sem);
>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>> index dc0efb852475..ff677ca6e4e1 100644
>>> --- a/drivers/lightnvm/pblk-map.c
>>> +++ b/drivers/lightnvm/pblk-map.c
>>> @@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
>>> 		}
>>> 	}
>>>=20
>>> -	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
>>> +	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
>>> 	return 0;
>>> }
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>> index eea901d7cebc..df624d504d24 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq =
*rqd)
>>> 	struct pblk_pad_rq *pad_rq =3D rqd->private;
>>> 	struct pblk *pblk =3D pad_rq->pblk;
>>>=20
>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>=20
>>> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>>>=20
>>> @@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	}
>>>=20
>>> 	kref_get(&pad_rq->ref);
>>> -	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>> +	pblk_down_pu(pblk, rqd->ppa_list[0]);
>>>=20
>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>> 	if (ret) {
>>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>> -		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>> +		pblk_up_pu(pblk, rqd->ppa_list[0]);
>>> 		goto fail_free_bio;
>>> 	}
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>>> index cd579b440b56..55d198edd70a 100644
>>> --- a/drivers/lightnvm/pblk-write.c
>>> +++ b/drivers/lightnvm/pblk-write.c
>>> @@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct nvm_rq =
*rqd)
>>> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>> 	int sync;
>>>=20
>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>=20
>>> 	if (rqd->error) {
>>> 		pblk_log_write_err(pblk, rqd);
>>> @@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>> 		list_del(&meta_line->list);
>>> 	spin_unlock(&l_mg->close_lock);
>>>=20
>>> -	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_down_pu(pblk, ppa_list[0]);
>>>=20
>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>> 	if (ret) {
>>> @@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>> 	return NVM_IO_OK;
>>>=20
>>> fail_rollback:
>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>> 	spin_lock(&l_mg->close_lock);
>>> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
>>> 	list_add(&meta_line->list, &meta_line->list);
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 2f61f4428fcb..390855375b1e 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs);
>>> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
>>> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
>>> 		   unsigned long secs_to_flush);
>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas);
>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>> 		  unsigned long *lun_bitmap);
>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas);
>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
>>> void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
>>> int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t =
flags,
>>> 		       int nr_pages);
>>> --
>>> 2.11.0
>> The patch looks good to me. The renaming to PU though is confusing. =
The
>> underlying reason to take the semaphore is to avoid write pointer
>> violations. At the moment, we only have an open line in pblk, which
>> makes that the semaphore effectively protects a PU, but when we have
>> several open lines this is no longer true.
>=20
> I don't understand this, how will it change when multiple lines are =
active?
>=20
> My guess is that one has to keep track of the number of outstanding
> I/Os for each PU.

The confusion comes from the current semaphore having 2 purposes: (i)
guaranteeing the write pointer at a chunk level, and (ii) being the
mechanism used by the scheduler to minimize internal write collisions.
When we have several open lines this semaphore will still be used for
(i), however, we will need a separate mechanism for (ii).

> Regarding naming, pblk_[down/up]_line doesn't quite cut it, and _page
> doesn't mean anything to me. Can we find a better name?

Give the above, what do you say pblk_[down/up]_chunk?

Javier


--Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluM+wwACgkQIX4xUKFR
nnTb7xAApQfZnUoRKCccbptqxfIcU04aXq4XPG4D/8nVuLBfhrsygngpoL+Ywb20
P5IqeIgLdBoj3tuWmCvAqZwCPM0oN5Eo1xsok0UHyDPVWdvegVMN3C/qSNE02Bud
2dFavgbQ+iP0XBl/Mo8ITAUaZYHSWWtGdqfBKH/NRmo/kyCIeIZjf3Yr2FeWQcAx
7K3W6qnzaymuE5pC14Kc9XqpWP8ING23w43nNFkGEJMZ8qUmjKOkZCVHqe/4mwU+
Nf5SYCu4jPDudVUwwcmx6+bJoXiVagWHGQzfkGv8i3goB3jxnlPDXl0c3wYaUvZH
vUaGofT9jiYLIpKqhqLn5yWMbK1zHbu7fP42Lu+IETKpcicdtA5ebwA6Ck7QEFFr
FYyhfsvQB5cXQfP/AdOWf+kLdUq/E+ZBHuMWWeb1llpvkJIsGtCMPBDNSMdkOsha
eqJDN66OwwAuMa5b4DbpDTZX6c8y/54T2Y4CyrOUVPqepbc1BxIm1QDP/vBU93G4
OfDhmG1batMe549CeNXdwg/OP2nTWf9dwsmcSqCTsjIVLOc5mBwm38bdmEPHUDQb
rDNM5XqGBFD/xr6J6/Wo59I003cYYobrPW3AmbqRI45MalbjkwAAMQgjWg054vP7
1D9lE35oSFlubM9iiF4uKw77j3678aLjV7qpU1HOhL0UHbcShk8=
=gWI5
-----END PGP SIGNATURE-----

--Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97--
