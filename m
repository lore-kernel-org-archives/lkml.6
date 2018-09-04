Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8199C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537D220659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="d/so4X8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537D220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIDViv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:38:51 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:41824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbeIDViv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As3v5f4VHusLsbnj4F2OyOOLY0TW0zYgAKjCp/5LuI8=;
 b=d/so4X8Sy7JEqO+KWiANvE5++boj2HyJCoBxGrX3jINcZPaJIXQkzINu0B2u8VbX3y5/aaNKkvOa/gWKanM70YSwcPvueY298pugO0IQB1v1hoESVBPsg7hxF7KgXK1OkJ2EtLwcINdVFZ+eBKLYC1qnFpq6r8QFL3TzlZorseM=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB634.namprd06.prod.outlook.com (10.141.228.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Tue, 4 Sep 2018 17:12:40 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 17:12:36 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Thread-Topic: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Thread-Index: AQHUP6HN+5S4mphJPEehcGEbp/in3aTZyFEAgAAkpACABGBTAIABnIAAgAB75QA=
Date:   Tue, 4 Sep 2018 17:12:36 +0000
Message-ID: <0E11AFCC-AE0F-4DF4-A6DA-E57CCD423231@cnexlabs.com>
References: <20180829140832.29341-1-mb@lightnvm.io>
 <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
 <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
 <D61CDC07-86BC-434A-AE01-135E7B09042C@cnexlabs.com>
 <ba7202f4-b3d4-4d33-d64e-075dca4545e1@lightnvm.io>
In-Reply-To: <ba7202f4-b3d4-4d33-d64e-075dca4545e1@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [50.207.153.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB634;6:jkY7/2OXQPHm7Ta4ab5g2L3dwY7AASWRa5v2qr7ewBI4jAfUfqKQN3jwfuBKd3PJaihG7SKoKbDBMEhO8gAbPuqQVJRi4+qgciJYyq+ECKF7HhdD18fPaQztqNiMEHm8uHnw+C2g2MpNn8kFA1503IfU1mF7SXI+d9yQnnDDoWJbCaIhW42aDiTJnUI7hVYSQv0rFm/BjUVQEIoBnCp/3uoE84w+HHHRt8zbI9Nhf/GwI3D4Ga5ArRJT1Csv0LWDcZBfNdbjN80OpdhtvTNI8ZjZFZj9ujG5UAobtulzQzS8UG0EA3aFNN5E5PP1Aq6gJSwkb6+j4wODRr/MBmPskz4pTqfw4pG4VnkrclWZAQcscVkCW8AfSmwg4MG5XPDhJ0cjT8mf+szq7f11UnYlcaElSORsQMK4t3L/YTkRnuMvb+kq2pXDMHDbAU28G8h8E5F2HkirKqXmENBbS4LUlQ==;5:LwYnSXQpGa7gd3BmVATVkt0Q+hNhWt+bckvS8KGc39onMV4R2suhM8FaFmLheM8adhhwNK4TPwxg9genYF76ManKzlmyjGWlgs/sGwJ6+hF65fzdSfRQK68KUbx2zwQVWRluQr7mGKruSdrm4yMCFiRL6YgWAYoGxMMmIgYRzgY=;7:LCq9BajNqxK/w45vwfd+1ePmOLdF/fiXnYAfnRBIRWQqeeKiA7gJgbk7CJIcK6+ZWZVTvQ5pjd9Nhs/AzPLHC8rCFHpTofNgbLp5rGZF1RFcxg3qKJQ5fQAFguXcN3qEYheigV4g5CthP16RnFOphfbtxn/HBjk6wcM43N8TK9UH2NmL/PiLJo12YiNpXIfg8nFf0VWsseY/dgmlM89j8dMsjdnxHT5xPX6Wykv1xY6rS5vZdspKLxjgl/F9SPJ5
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39830400003)(189003)(199004)(6246003)(53546011)(81166006)(5660300001)(86362001)(76176011)(575784001)(8936002)(3846002)(99286004)(6116002)(6486002)(6506007)(93886005)(5250100002)(82746002)(25786009)(446003)(68736007)(4326008)(2906002)(186003)(106356001)(105586002)(36756003)(102836004)(26005)(81156014)(8676002)(486006)(316002)(53936002)(54906003)(6436002)(99936001)(83716003)(2616005)(6916009)(33656002)(11346002)(229853002)(97736004)(6512007)(7736002)(305945005)(66066001)(2900100001)(476003)(14454004)(256004)(14444005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB634;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 684420da-a49b-494d-455e-08d612899cc0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB634;
x-ms-traffictypediagnostic: CO2PR06MB634:
x-microsoft-antispam-prvs: <CO2PR06MB6342A96E6025DE866C8430ABA030@CO2PR06MB634.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:CO2PR06MB634;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB634;
x-forefront-prvs: 0785459C39
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nPk0s4xUH6dcpPCEI/Na+FRPCkR328hAZFWqinRK4TaOc3+RWt4OmypqyDiAk+l9GNBrqmrOcu2uDYgOzsFhehfvhET02c4m1q6yj+//jtMmHBaxlyDHh8cYPoI4CH8CF/Evhc7ik3VbCxdPrZ7P9imkvzXnf4GxzYyS202sas8N7pAmXLmY3ZAJlhOfdFbm1fhMSBT5CMeuyWMGhoF5g6O+zxfwtUGZfvcssQTa4/VFlNccfPHEDy2SVF7ssA9unY30V1yBWHxEjXeJQoHnTAjbQAN/Tr06e0QWnq4oKuzrsHTM8hMgUS7w8v08pGj4WW1KyZIEtTve8bnynC+M/DqmFT1cQQXPcWx/J6HXHPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684420da-a49b-494d-455e-08d612899cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 17:12:36.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Sep 2018, at 02.49, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/03/2018 11:12 AM, Javier Gonzalez wrote:
>>> On 31 Aug 2018, at 16.22, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/31/2018 02:11 PM, Javier Gonzalez wrote:
>>>>> On 29 Aug 2018, at 16.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> Remove the debug only iteration within __pblk_down_page, which
>>>>> then allows us to reduce the number of arguments down to pblk and
>>>>> the parallel unit from the functions that calls it. Simplifying =
the
>>>>> callers logic considerably.
>>>>>=20
>>>>> Also, rename the functions pblk_[down/up]_page to =
pblk_[down/up]_pu,
>>>>> to communicate that it takes a lock on the parallel unit.
>>>>>=20
>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>>> ---
>>>>> drivers/lightnvm/pblk-core.c     | 34 =
+++++++++-------------------------
>>>>> drivers/lightnvm/pblk-map.c      |  2 +-
>>>>> drivers/lightnvm/pblk-recovery.c |  6 +++---
>>>>> drivers/lightnvm/pblk-write.c    |  6 +++---
>>>>> drivers/lightnvm/pblk.h          |  6 +++---
>>>>> 5 files changed, 19 insertions(+), 35 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>>> index bb1a7cc24cbb..08df6bcd2f81 100644
>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>> @@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, =
struct pblk_line *line, void *priv,
>>>>> 	queue_work(wq, &line_ws->ws);
>>>>> }
>>>>>=20
>>>>> -static void __pblk_down_page(struct pblk *pblk, struct ppa_addr =
*ppa_list,
>>>>> -			     int nr_ppas, int pos)
>>>>> +static void __pblk_down_pu(struct pblk *pblk, int pos)
>>>>> {
>>>>> 	struct pblk_lun *rlun =3D &pblk->luns[pos];
>>>>> 	int ret;
>>>>> @@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>>>> 	 * Only send one inflight I/O per LUN. Since we map at a page
>>>>> 	 * granurality, all ppas in the I/O will map to the same LUN
>>>>> 	 */
>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	int i;
>>>>> -
>>>>> -	for (i =3D 1; i < nr_ppas; i++)
>>>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>>>> -#endif
>>>>>=20
>>>>> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>>>>> 	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
>>>>> @@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>>>> 				-ret);
>>>>> }
>>>>>=20
>>>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
>>>>> {
>>>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 	struct nvm_geo *geo =3D &dev->geo;
>>>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>=20
>>>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>>>> +	__pblk_down_pu(pblk, pos);
>>>>> }
>>>>>=20
>>>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas,
>>>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>>>> 		  unsigned long *lun_bitmap)
>>>>> {
>>>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 	struct nvm_geo *geo =3D &dev->geo;
>>>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>=20
>>>>> 	/* If the LUN has been locked for this same request, do no =
attempt to
>>>>> 	 * lock it again
>>>>> @@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, =
struct ppa_addr *ppa_list, int nr_ppas,
>>>>> 	if (test_and_set_bit(pos, lun_bitmap))
>>>>> 		return;
>>>>>=20
>>>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>>>> +	__pblk_down_pu(pblk, pos);
>>>>> }
>>>>>=20
>>>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
>>>>> {
>>>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 	struct nvm_geo *geo =3D &dev->geo;
>>>>> 	struct pblk_lun *rlun;
>>>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>>> -
>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	int i;
>>>>> -
>>>>> -	for (i =3D 1; i < nr_ppas; i++)
>>>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>>>> -#endif
>>>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>=20
>>>>> 	rlun =3D &pblk->luns[pos];
>>>>> 	up(&rlun->wr_sem);
>>>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>>>> index dc0efb852475..ff677ca6e4e1 100644
>>>>> --- a/drivers/lightnvm/pblk-map.c
>>>>> +++ b/drivers/lightnvm/pblk-map.c
>>>>> @@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
>>>>> 		}
>>>>> 	}
>>>>>=20
>>>>> -	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
>>>>> +	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
>>>>> 	return 0;
>>>>> }
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>>>> index eea901d7cebc..df624d504d24 100644
>>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>>> @@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq =
*rqd)
>>>>> 	struct pblk_pad_rq *pad_rq =3D rqd->private;
>>>>> 	struct pblk *pblk =3D pad_rq->pblk;
>>>>>=20
>>>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>>>=20
>>>>> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>>>>>=20
>>>>> @@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk =
*pblk, struct pblk_line *line,
>>>>> 	}
>>>>>=20
>>>>> 	kref_get(&pad_rq->ref);
>>>>> -	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>>>> +	pblk_down_pu(pblk, rqd->ppa_list[0]);
>>>>>=20
>>>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>>>> 	if (ret) {
>>>>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>>>> -		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>>>> +		pblk_up_pu(pblk, rqd->ppa_list[0]);
>>>>> 		goto fail_free_bio;
>>>>> 	}
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>>>>> index cd579b440b56..55d198edd70a 100644
>>>>> --- a/drivers/lightnvm/pblk-write.c
>>>>> +++ b/drivers/lightnvm/pblk-write.c
>>>>> @@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct =
nvm_rq *rqd)
>>>>> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>>> 	int sync;
>>>>>=20
>>>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>>>=20
>>>>> 	if (rqd->error) {
>>>>> 		pblk_log_write_err(pblk, rqd);
>>>>> @@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>>>> 		list_del(&meta_line->list);
>>>>> 	spin_unlock(&l_mg->close_lock);
>>>>>=20
>>>>> -	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_down_pu(pblk, ppa_list[0]);
>>>>>=20
>>>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>>>> 	if (ret) {
>>>>> @@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>>>> 	return NVM_IO_OK;
>>>>>=20
>>>>> fail_rollback:
>>>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>>> 	spin_lock(&l_mg->close_lock);
>>>>> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
>>>>> 	list_add(&meta_line->list, &meta_line->list);
>>>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>>>> index 2f61f4428fcb..390855375b1e 100644
>>>>> --- a/drivers/lightnvm/pblk.h
>>>>> +++ b/drivers/lightnvm/pblk.h
>>>>> @@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, =
struct pblk_line *line, int nr_secs);
>>>>> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, =
int nr_secs);
>>>>> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
>>>>> 		   unsigned long secs_to_flush);
>>>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas);
>>>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas,
>>>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
>>>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>>>> 		  unsigned long *lun_bitmap);
>>>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas);
>>>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
>>>>> void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
>>>>> int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t =
flags,
>>>>> 		       int nr_pages);
>>>>> --
>>>>> 2.11.0
>>>> The patch looks good to me. The renaming to PU though is confusing. =
The
>>>> underlying reason to take the semaphore is to avoid write pointer
>>>> violations. At the moment, we only have an open line in pblk, which
>>>> makes that the semaphore effectively protects a PU, but when we =
have
>>>> several open lines this is no longer true.
>>>=20
>>> I don't understand this, how will it change when multiple lines are =
active?
>>>=20
>>> My guess is that one has to keep track of the number of outstanding
>>> I/Os for each PU.
>> The confusion comes from the current semaphore having 2 purposes: (i)
>> guaranteeing the write pointer at a chunk level, and (ii) being the
>> mechanism used by the scheduler to minimize internal write =
collisions.
>> When we have several open lines this semaphore will still be used for
>> (i), however, we will need a separate mechanism for (ii).
>>> Regarding naming, pblk_[down/up]_line doesn't quite cut it, and =
_page
>>> doesn't mean anything to me. Can we find a better name?
>> Give the above, what do you say pblk_[down/up]_chunk?
>=20
> Ok, works for me. I'll update the patch and push. If getting to
> multiple chunks per PU, then this can be flushed out to remove the
> rest of the confusion.
>=20
> Thanks.

Great. Thanks!


--Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluOvQIACgkQIX4xUKFR
nnSsJQ/+JHYLP3xmyPXErNtF+y6ZlRVNJ6eRvkSteRz5ZiqGBY/m5MhjqU/t3UCA
uPS2E8pWRwGg1t+WRSl9QP4fqkCCH6oKNYVGmCNkOoyDaDLlH5dL5JCrrmquQNaK
a2PV19fbLWPMcJDdhiHCL08XKllFHd1dANKVRVK05BmW8YFAurILDtNOw2+B9zb0
PwM4ib0e7ittlJNgQ8KR2AriuVYy3+m8LHvCc3RcioW84Zcg7S+8IQhscT48J/kl
fAhaA1nwsoUwHa9ctm7pZKvyb+04IaXrA1mA181Sp7BxFKf7gUyFyl19b4fovCmA
dFuX1NtrsS/Qj6Ynh7uYHV2V6fvyTznOGyfX+GtlJofo/dd2PPimjqPcAiTP45ru
7W5Ftno8x+nwvesgrdm/bzsHKyigvnIltoYVDVgDfywYkdfEgTrTGn15bKUti7NE
RmLdDS9qe9AEg8m8Ix5oJfJC9qrneHB3Gt3Gyw2WEKrtIVkIRcEpLJUD8PNi6WF2
P8EZyV/4qvlNFXM3KkpgT0dcuHt4dqthHNMrnxOc3/VPmflgjZQcQfP7j6Tpb4Gg
KcZgh6GunzLtMaruT6jZrS2ARhNnvgxaAZXzZJ6BOLzecjcT0pRIRlGWAAEp557L
UabgKLD3TfMarzGAGELs7Ev0en/n1THCFkki+RO3FkauRJ4q82I=
=3MHg
-----END PGP SIGNATURE-----

--Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04--
