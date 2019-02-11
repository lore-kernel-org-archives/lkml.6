Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D28C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698AB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Nci+O1Mj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qkgTNLEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBKNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:31:01 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:35680 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbfBKNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:31:00 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BDM1DA012629;
        Mon, 11 Feb 2019 05:30:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9AGyX0G9Npnp3fGQdpBWc4mErzF4Uu3zb/oOttDGMNo=;
 b=Nci+O1MjPTZ932KRsCYkWUKmzmVD28VttU2E5TAUx2tLOUKNQo0cS2PZyVHoLcC7IPbU
 nfsui3jzc1C7ITdIhhHtmJh1ozXszMhklsnwN6yw3TjsDt9yMN3ydUc5o2ZMZgZ8PCUJ
 kPJa3CTPLdGUEMJTncst+GhuueBW9t+2fdxyvprmWlDLEyBDHBO8BWSZrtJ74H61oM7J
 sh8SxvaIAo+ntXPJmUDJm5gUy2LA/9IbskXTsso/e1gvYN3ZH/S+bXx1foLuB7RhhPOv
 iKBKNVBdrmu+2Ltc4W9Nfr593xDNywCILTaYvZfkcpIfmAqTNhZed5r9YpHRm2uU/5gh Zg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qk4mu9447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 05:30:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AGyX0G9Npnp3fGQdpBWc4mErzF4Uu3zb/oOttDGMNo=;
 b=qkgTNLEfhGEbuxqNeXQ8oC5/PFUNHC8OGsSgigthXLzyH+jtvYTaTkVsHnYR3ENqht8XUhqquComU56VYPeIvEIfT+qEJ8DmCD77yJlotDFHnp/ZVC2vBeqGkCqqQd+7h+pB/FAiTIc7GQ4p3xNbRw8mUAJdaU6LOoEZeR3l8RU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5494.namprd07.prod.outlook.com (20.177.231.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 13:30:41 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 13:30:41 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Index: AQHUuVupTx0ci+BG90KsaLISdJHpa6XPi2kAgAAqdQCACuQvoIAADDsAgAAClPA=
Date:   Mon, 11 Feb 2019 13:30:41 +0000
Message-ID: <BYAPR07MB4709469C2D0EBC2D3D7DDF1ADD640@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-3-git-send-email-pawell@cadence.com>
 <20190204114502.GA28608@kroah.com> <87y36vmyeb.fsf@linux.intel.com>
 <BYAPR07MB4709A40204EF528F8A04E1EDDD640@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87sgwu5unv.fsf@linux.intel.com>
In-Reply-To: <87sgwu5unv.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzgxNjA5NGQtMmUwMS0xMWU5LTg3MmUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDM4MTYwOTRmLTJlMDEtMTFlOS04NzJlLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNzM4IiB0PSIxMzE5NDM2NTQzOTM2ODI1NjEiIGg9InBrbXJkS3AwbzVndURGUVJoUFVjR3lVeCtiUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5494;20:C/w5zSha8LVb0VtsKsmTeHgZAaHpoleK22hpCDYT5rMUbqehA0POCmRErhmWmeXkdqpTwHCFg0Nilr8vjQNv3V1UlQ8HWSItBPDxQNav9eex1ldrckbbgDP6onBd2VvblP1MvDVfvOTbovAl54dgqzWTKRGrWn9KpHve1K5ll24mD/UdsC35s9jIlUMvxfNYB6am3E9QshmgJijG9VcskQbcXtRA0VpZonZw6IcJOt++joyu/4SCTgdiKJxh+iFf
x-ms-office365-filtering-correlation-id: 55122b49-01c1-446d-3384-08d690251e71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5494;
x-ms-traffictypediagnostic: BYAPR07MB5494:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR07MB5494373F721145E0C6F9508EDD640@BYAPR07MB5494.namprd07.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(36092001)(199004)(189003)(8936002)(476003)(2906002)(7416002)(11346002)(106356001)(446003)(33656002)(8676002)(81166006)(7736002)(4744005)(6246003)(105586002)(97736004)(81156014)(66066001)(107886003)(6116002)(316002)(3846002)(54906003)(110136005)(74316002)(99286004)(9686003)(76176011)(6306002)(229853002)(93886005)(68736007)(25786009)(4326008)(55016002)(14444005)(6506007)(486006)(53936002)(14454004)(478600001)(186003)(256004)(86362001)(102836004)(71190400001)(26005)(71200400001)(6436002)(7696005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5494;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G57xfUgOUCyd72QO4ANj8Fii0lHXqwZUvqay73d7YP2IR3JPCL9jVsnpAHZpwpVAeQelC64u+WkZDvq+9PJ+CPJUcS4P8cRldUTK3aU9U04iSC1mpvm5dPNeamRABDOLWEXsX+jtHEMFfUD6yOgOpZ1CnY/EmYcNH2xdabc9ut093skVzVoTaT6GsPzQO0N5FccK4XDYlDdqCDjjG2Fanfhy4pmrysrKia9roP1KmiefCev+uOEKNObqHidJvLaCd48I5dTqk6uTjWJqeJa9C0Q2+xp/o+B1movYM5A+M6oJEzDREybhEBENlc8Uzqxi1X2ToSfYlgrhwQVHq9Ug6gpd1iIj7juKA6IcDiipiE2Pz8wOvPnhSPaDPskszh2NMLtP3myYPmY37h+aVimy/RtsMXOdg8rEpIsKcfaBZQA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55122b49-01c1-446d-3384-08d690251e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 13:30:41.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5494
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=777 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>>> +/**
>>>>> + * usb_decode_ctrl - Returns human readable representation of contro=
l request.
>>>>> + * @str: buffer to return a human-readable representation of control=
 request.
>>>>> + *       This buffer should have about 200 bytes.
>>>>
>>>> "about 200 bytes" is not very specific.
>>>>
>>>> Pass in the length so we know we don't overflow it.
>>>
>>>agree.
>> I also agree and I will add such parameter.
>
>https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=3D=
next&id=3D7790b3556fccc555ae422f1576e97bf34c8ab8b6

Cool :). Thanks.=20

--
Pawel
