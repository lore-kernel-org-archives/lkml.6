Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA952C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEE1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZvO1I+Ph";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Hr23+57J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEE1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeK0W1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:27:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35672 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726622AbeK0W1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:27:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wARBSYCG015674;
        Tue, 27 Nov 2018 03:29:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=WdyGkRKzb/mGFteQge9rZQpgCbQS1k3o6FGzUp107kY=;
 b=ZvO1I+PhvvAw0wwqc36MWRinB61HgGAJc5M5rUwngj6+jVnHqjPvWjlxh/JbKWy520zJ
 NVOxigw8+dnV598BfX3vQfoXdqlj6S8YzXD68BiuI7CrCP7lhpfaiOCEAdS2maUnBSLm
 iceP43A75gqBGyg/N+aN0dkAb4fcUbfiSjIeEhMKawlU4uL/Tlrocm3Xu8k7L+lMee95
 GQow07KfYO0g+Y6uv7I3w7JH0YIslx2LTKKrKKJ/UH1/skecP+PBMgBfxcFTNj+/alOj
 rz2WGm3nhMsu1/ZFCVD3uPEcOXmFlPN2AIw5R5T/OqrCqztzQQpllPJwy1YOJ+xjqdWk eg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0015.outbound.protection.outlook.com [207.46.163.15])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p0n55cqfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Nov 2018 03:29:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdyGkRKzb/mGFteQge9rZQpgCbQS1k3o6FGzUp107kY=;
 b=Hr23+57Jb5OvFIFUV5ItS6V0JPXHa39L4bEbPsS7MnGk1tkz7fn+wxY5xRRyQ8rX0uQoCZ3LChNQDVxPJOoQFgGkUAwNPNE71qEnhwR1Mmmg8QoJgoLHcmJ5PXDHps5T6jiIeMQ/g3cb5pS3Rg2TbhldhDog3AyozxwjG6VVmfw=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4824.namprd07.prod.outlook.com (52.135.203.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 27 Nov 2018 11:29:46 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 11:29:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 05/15] usb:cdns3: Added DRD support
Thread-Topic: [RFC PATCH v2 05/15] usb:cdns3: Added DRD support
Thread-Index: AQHUfycWERNbYpUTLUKmTA3BhMz+TaVdedoAgAQTVDCAAfkVkA==
Date:   Tue, 27 Nov 2018 11:29:45 +0000
Message-ID: <BYAPR07MB470901107F1435424D8B0727DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-6-git-send-email-pawell@cadence.com>
 <5BF8140C.7000605@ti.com>
 <BYAPR07MB470991EB0AE200B6481AEE35DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB470991EB0AE200B6481AEE35DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmQ0YjRhYTMtZjIzNy0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGJkNGI0YWE0LWYyMzctMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQzOSIgdD0iMTMxODc3OTE3ODY1NDQ3NTYwIiBoPSJUbXpHemM3clJPMHF6Y0JqQ01mUW9rVFNBTkU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4824;20:bvLIl5P8MiXUP08sMeXyasaFx02QLCDR7AnE+qi/6/T5SD0ids9s3fjJt4r21ogIsTUu9GucuBQz+gxcaOPkY9slXxHsew5y9BRaX+ySA3AWijvt7XckLK/Gb2qCTdP29xYLw12F1+N3pGNBP4a8Rh6RuXLG+DzHy+BZ0tAUNpmpNslpUgzOyHowA5bTC+xNGboWanxX3/S4TEAqouiToW/JsTB5D2UX+eyy9ae5QsP2eMFZ5xfFILjveOU15XXz
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(346002)(396003)(36092001)(189003)(199004)(478600001)(2906002)(76176011)(6506007)(93886005)(7696005)(14454004)(74316002)(102836004)(97736004)(2501003)(81156014)(6116002)(8676002)(476003)(8936002)(446003)(55016002)(3846002)(11346002)(316002)(26005)(81166006)(99286004)(256004)(486006)(53936002)(186003)(217873002)(71200400001)(6246003)(7736002)(71190400001)(305945005)(105586002)(106356001)(33656002)(66066001)(25786009)(5660300001)(110136005)(6436002)(68736007)(86362001)(4326008)(9686003)(54906003)(107886003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4824;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e2ecb687-06c5-4dbe-746e-08d6545ba228
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4824;
x-ms-traffictypediagnostic: BYAPR07MB4824:
x-microsoft-antispam-prvs: <BYAPR07MB4824A08CE05E27BDDF6F0E96DDD00@BYAPR07MB4824.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4824;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4824;
x-forefront-prvs: 086943A159
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kQQ57mhqe07evjl1UnLaROTnD/E2DweLd6MM+D9e9cCG1nw+K2XqAxZJYHHeXMTrxbDVkB+RNE35D6FRMfQpwUGzsaVsIXUXv2dwRB4VOq7Ug7sSbePWINXx1QxuTspYaLH1pYmV24Le0hmxLtainRyjynnIEDxaiPJqREJb45c8UgcU7GnBvl7Wy5lC/KMw+OkAR6em0/14ai/VFPf/RQIwgg1ChcZCZPcTn5aeulPWYPdPXnpJqJk8k0TvYr2tT33PjhrHbU1/PeT+y9m+IAJyLaCKfQRDg8CUI/EH0vbvxLRU5A/hvKp579rabAZvy1Pf5h5b6VHhKQslKRFYBaXEIpyXtfd1lnsLSTvohC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ecb687-06c5-4dbe-746e-08d6545ba228
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 11:29:45.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4824
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=815 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger

>>> Patch adds supports for detecting Host/Device mode.
>>> +
>>> +static int cdns3_otg_get_id(struct cdns3 *cdns)
>>> +{
>>> +	int id;
>>> +
>>> +	id =3D readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
>>> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
>>> +	return id;
>>> +}
>>> +
>>> +int cdns3_is_host(struct cdns3 *cdns)
>>> +{
>>> +	if (cdns->current_dr_mode =3D=3D USB_DR_MODE_HOST)
>>> +		return 1;
>>
>>Why do you need this?
>
>I assumed that some SoC could have cut DRD /OTG and Device or Host part.
>In such case the driver cannot be based on ID pin.
>For only HOST it's not a problem because
>the standard XHCI driver will be used.  Probably I will remove this fragme=
nt.

I've removed this condition but it is necessary and I've  restored it again=
.=20
When driver works in only HOST mode then ID is always 0.=20
For current_dr_mode =3D=3D USB_DR_MODE_HOST driver has to just simple=20
returns 1. =20
current_dr_mode  can be changed from user space depending on dr_mode field.=
=20

I have the additional question. Because I have many changes in source code =
if I should=20
post the next RFC PATCH v3 or should I wait for comments for rest patches ?

>>
>>> +	else if (cdns->current_dr_mode =3D=3D USB_DR_MODE_OTG)
>>> +		if (!cdns3_otg_get_id(cdns))
>>> +			return 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
Thanks,
Cheers,
Pawel
