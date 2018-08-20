Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A46C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A1B20C0B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A1B20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeHTKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:17:14 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32788 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbeHTKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:17:14 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7K6xww1032286;
        Mon, 20 Aug 2018 00:02:16 -0700
Received: from il-exch02.marvell.com ([199.203.130.102])
        by mx0b-0016f401.pphosted.com with ESMTP id 2kxjyhd3pm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 Aug 2018 00:02:15 -0700
Received: from IL-EXCH01.marvell.com (10.4.102.220) by IL-EXCH02.marvell.com
 (10.4.102.221) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 20 Aug
 2018 10:02:13 +0300
Received: from IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36]) by
 IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36%20]) with mapi id
 15.00.1210.000; Mon, 20 Aug 2018 10:02:12 +0300
From:   Yan Markman <ymarkman@marvell.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>
CC:     "brian.brooks@linaro.org" <brian.brooks@linaro.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "Stefan Chulski" <stefanc@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.topel@intel.com" <bjorn.topel@intel.com>,
        "brian.brooks@arm.com" <brian.brooks@arm.com>
Subject: RE: [PATCH] net: mvpp2: avoid bouncing buffers
Thread-Topic: [PATCH] net: mvpp2: avoid bouncing buffers
Thread-Index: AQHUODE62236Kn8eQ0iIUx1wbhA8MqTH+e4AgAA79OA=
Date:   Mon, 20 Aug 2018 07:02:12 +0000
Message-ID: <88db0c1b20fc466f815d0e8382a156dc@IL-EXCH01.marvell.com>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
 <20180820062326.GA22222@infradead.org>
In-Reply-To: <20180820062326.GA22222@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: multipart/mixed;
        boundary="_002_88db0c1b20fc466f815d0e8382a156dcILEXCH01marvellcom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_02:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=1 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=1
 clxscore=1011 lowpriorityscore=0 mlxscore=1 impostorscore=0
 mlxlogscore=209 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808200076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_88db0c1b20fc466f815d0e8382a156dcILEXCH01marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everybody
The MVPP2 code already has DMA's patch taken from OLD Backport and placed b=
y Antoine Tenart.
Please refer the attached=20
Best regards
Yan Markman


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]=20
Sent: Monday, August 20, 2018 9:23 AM
To: David Miller <davem@davemloft.net>
Cc: brian.brooks@linaro.org; antoine.tenart@bootlin.com; maxime.chevallier@=
bootlin.com; Yan Markman <ymarkman@marvell.com>; Stefan Chulski <stefanc@ma=
rvell.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; bjorn.top=
el@intel.com; brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers

On Sun, Aug 19, 2018 at 07:55:05PM -0700, David Miller wrote:
> From: Brian Brooks <brian.brooks@linaro.org>
> Date: Sun, 19 Aug 2018 21:47:30 -0500
>=20
> > @@ -5126,6 +5126,12 @@ static int mvpp2_probe(struct platform_device *p=
dev)
> >  	}
> > =20
> >  	if (priv->hw_version =3D=3D MVPP22) {
> > +		/* Platform code may have set dev->dma_mask to point
> > +		 * to dev->coherent_dma_mask, but we want to ensure
> > +		 * they take different values due to comment below.
> > +		 */
> > +		pdev->dev.dma_mask =3D &priv->dma_mask;
>=20
> The platform code might be doing this exactly because it cannot=20
> support different coherent and streaming DMA masks.
>=20
> Well, in any case, the platform code is doing it for a reason and=20
> overriding this in a "driver" of all places seems totally=20
> inappropriate and at best a layering violation.
>=20
> I would rather you fix this in a way that involves well defined APIs=20
> that set the DMA masks or whatever to the values that you need, rather=20
> than going behind the platform code's back and changing the DMA mask=20
> pointer like this.

Agreed.  What platform do you see this issue on?

--_002_88db0c1b20fc466f815d0e8382a156dcILEXCH01marvellcom_
Content-Type: application/octet-stream;
	name="0009-net-mvpp2-fix-the-dma_mask-and-coherent_dma_mask-set.patch"
Content-Description: 0009-net-mvpp2-fix-the-dma_mask-and-coherent_dma_mask-set.patch
Content-Disposition: attachment;
	filename="0009-net-mvpp2-fix-the-dma_mask-and-coherent_dma_mask-set.patch";
	size=3572; creation-date="Mon, 20 Aug 2018 06:56:56 GMT";
	modification-date="Thu, 09 Aug 2018 22:08:13 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4MTBmYWY0NTMzZDM0M2ZlMWRmODQ4NTNiN2UyMmZjMjczM2E4ZWE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbnRvaW5lIFRlbmFydCA8YW50b2luZS50ZW5hcnRAYm9vdGxp
bi5jb20+CkRhdGU6IFdlZCwgOCBBdWcgMjAxOCAxNDozMDo1OCArMDMwMApTdWJqZWN0OiBbUEFU
Q0ggMDkvNDBdIG5ldDogbXZwcDI6IGZpeCB0aGUgZG1hX21hc2sgYW5kIGNvaGVyZW50X2RtYV9t
YXNrCiBzZXR0aW5ncwoKVGhlIGRldi0+ZG1hX21hc2sgdXN1YWxseSBwb2ludHMgdG8gZGV2LT5j
b2hlcmVudF9kbWFfbWFzay4gVGhpcyBpcyBhbgppc3N1ZSBhcyBzZXR0aW5nIGJvdGggb2YgdGhl
bSB3aWxsIG92ZXJyaWRlIHRoZSBvdGhlci4gVGhpcyBpcwpwcm9ibGVtYXRpYyBoZXJlIGFzIHRo
ZSBQUHYyIGRyaXZlciB1c2VzIGEgMzItYml0LW1hc2sgZm9yIGNvaGVyZW50CmFjY2Vzc2VzICh0
eHEsIHJ4cSwgYm0pIGFuZCBhIDQwLWJpdCBtYXNrIGZvciBhbGwgb3RoZXIgYWNjZXNzZXMgZHVl
IHRvCmFuIGhhcmR3YXJlIGxpbWl0YXRpb24uCgpUaGlzIGNhbiBsZWFkIHRvIGEgbWVtb3J5IHJl
bWFwIGZvciBhbGwgZG1hX21hcF9zaW5nbGUoKSBjYWxscyB3aGVuCmRlYWxpbmcgd2l0aCBtZW1v
cnkgYWJvdmUgNEdCLgoKQ2hhbmdlLUlkOiBJYjhhMDRhMDZhMWYzMGJmYTQzYjYyMjUwZjIxY2Zl
MDk0NjRkOTFlZApTaWduZWQtb2ZmLWJ5OiBBbnRvaW5lIFRlbmFydCA8YW50b2luZS50ZW5hcnRA
Ym9vdGxpbi5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggWmVtdHpvdiA8YXplbXR6b3ZAbWFydmVs
bC5jb20+ClNpZ25lZC1vZmYtYnk6IFlhbiBNYXJrbWFuIDx5bWFya21hbkBtYXJ2ZWxsLmNvbT4K
LS0tCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212cHAyL212cHAyLmggICAgICB8ICAy
ICsrCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212cHAyL212cHAyX21haW4uYyB8IDMz
ICsrKysrKysrKysrKysrKysrKysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL212cHAyL212cHAyLmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212cHAy
L212cHAyLmgKaW5kZXggZjJkOTBlMy4uNTJhOGUxZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9tdnBwMi9tdnBwMi5oCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvbXZwcDIvbXZwcDIuaApAQCAtNzA4LDYgKzcwOCw4IEBAIHN0cnVjdCBtdnBwMiB7
CiAJLyogV29ya3F1ZXVlIHRvIGdhdGhlciBoYXJkd2FyZSBzdGF0aXN0aWNzICovCiAJY2hhciBx
dWV1ZV9uYW1lWzMwXTsKIAlzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqc3RhdHNfcXVldWU7CisK
Kwlib29sIGN1c3RvbV9kbWFfbWFzazsKIH07CiAKIHN0cnVjdCBtdnBwMl9wY3B1X3N0YXRzIHsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvbXZwcDIvbXZwcDJfbWFp
bi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9tdnBwMi9tdnBwMl9tYWluLmMKaW5k
ZXggZjEwN2MwOC4uYTgwNzI3ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9tdnBwMi9tdnBwMl9tYWluLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9tdnBwMi9tdnBwMl9tYWluLmMKQEAgLTUxMzAsMTAgKzUxMzAsMjkgQEAgc3RhdGljIGludCBt
dnBwMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlyZXR1cm4gLUVJTlZB
TDsKIAl9CiAKKwlwcml2LT5jdXN0b21fZG1hX21hc2sgPSBmYWxzZTsKIAlpZiAocHJpdi0+aHdf
dmVyc2lvbiAhPSBNVlBQMjEpIHsKKwkJLyogSWYgZG1hX21hc2sgcG9pbnRzIHRvIGNvaGVyZW50
X2RtYV9tYXNrLCBzZXR0aW5nIGJvdGggd2lsbAorCQkgKiBvdmVycmlkZSB0aGUgdmFsdWUgb2Yg
dGhlIG90aGVyLiBUaGlzIGlzIHByb2JsZW1hdGljIGFzIHRoZQorCQkgKiBQUHYyIGRyaXZlciB1
c2VzIGEgMzItYml0LW1hc2sgZm9yIGNvaGVyZW50IGFjY2Vzc2VzICh0eHEsCisJCSAqIHJ4cSwg
Ym0pIGFuZCBhIDQwLWJpdCBtYXNrIGZvciBhbGwgb3RoZXIgYWNjZXNzZXMuCisJCSAqLworCQlp
ZiAocGRldi0+ZGV2LmRtYV9tYXNrID09ICZwZGV2LT5kZXYuY29oZXJlbnRfZG1hX21hc2spIHsK
KwkJCXBkZXYtPmRldi5kbWFfbWFzayA9CisJCQkJa3phbGxvYyhzaXplb2YoKnBkZXYtPmRldi5k
bWFfbWFzayksCisJCQkJCUdGUF9LRVJORUwpOworCQkJaWYgKCFwZGV2LT5kZXYuZG1hX21hc2sp
IHsKKwkJCQllcnIgPSAtRU5PTUVNOworCQkJCWdvdG8gZXJyX21nX2NsazsKKwkJCX0KKworCQkJ
cHJpdi0+Y3VzdG9tX2RtYV9tYXNrID0gdHJ1ZTsKKwkJfQorCiAJCWVyciA9IGRtYV9zZXRfbWFz
aygmcGRldi0+ZGV2LCBNVlBQMl9ERVNDX0RNQV9NQVNLKTsKIAkJaWYgKGVycikKLQkJCWdvdG8g
ZXJyX2F4aV9jbGs7CisJCQlnb3RvIGVycl9kbWFfbWFzazsKKwogCQkvKiBTYWRseSwgdGhlIEJN
IHBvb2xzIGFsbCBzaGFyZSB0aGUgc2FtZSByZWdpc3RlciB0bwogCQkgKiBzdG9yZSB0aGUgaGln
aCAzMiBiaXRzIG9mIHRoZWlyIGFkZHJlc3MuIFNvIHRoZXkKIAkJICogbXVzdCBhbGwgaGF2ZSB0
aGUgc2FtZSBoaWdoIDMyIGJpdHMsIHdoaWNoIGZvcmNlcwpAQCAtNTE0MSw3ICs1MTYwLDcgQEAg
c3RhdGljIGludCBtdnBwMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkg
Ki8KIAkJZXJyID0gZG1hX3NldF9jb2hlcmVudF9tYXNrKCZwZGV2LT5kZXYsIERNQV9CSVRfTUFT
SygzMikpOwogCQlpZiAoZXJyKQotCQkJZ290byBlcnJfYXhpX2NsazsKKwkJCWdvdG8gZXJyX2Rt
YV9tYXNrOwogCX0KIAogCS8qIEluaXRpYWxpemUgbmV0d29yayBjb250cm9sbGVyICovCkBAIC01
MTg5LDYgKzUyMDgsMTEgQEAgc3RhdGljIGludCBtdnBwMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQogCQkJbXZwcDJfcG9ydF9yZW1vdmUocHJpdi0+cG9ydF9saXN0W2ldKTsK
IAkJaSsrOwogCX0KK2Vycl9kbWFfbWFzazoKKwlpZiAocHJpdi0+Y3VzdG9tX2RtYV9tYXNrKSB7
CisJCWtmcmVlKHBkZXYtPmRldi5kbWFfbWFzayk7CisJCXBkZXYtPmRldi5kbWFfbWFzayA9ICZw
ZGV2LT5kZXYuY29oZXJlbnRfZG1hX21hc2s7CisJfQogZXJyX2F4aV9jbGs6CiAJY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKHByaXYtPmF4aV9jbGspOwogCkBAIC01MjM4LDYgKzUyNjIsMTEgQEAgc3Rh
dGljIGludCBtdnBwMl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJCQkg
IGFnZ3JfdHhxLT5kZXNjc19kbWEpOwogCX0KIAorCWlmIChwcml2LT5jdXN0b21fZG1hX21hc2sp
IHsKKwkJa2ZyZWUocGRldi0+ZGV2LmRtYV9tYXNrKTsKKwkJcGRldi0+ZGV2LmRtYV9tYXNrID0g
JnBkZXYtPmRldi5jb2hlcmVudF9kbWFfbWFzazsKKwl9CisKIAlpZiAoaXNfYWNwaV9ub2RlKHBv
cnRfZndub2RlKSkKIAkJcmV0dXJuIDA7CiAKLS0gCjIuMC40Cgo=

--_002_88db0c1b20fc466f815d0e8382a156dcILEXCH01marvellcom_--
