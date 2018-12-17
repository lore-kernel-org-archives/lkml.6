Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B642133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nfWhaI8M";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="C9y+HDs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbeLQL0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:26:11 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48162 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeLQL0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:26:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHBCMTu001643;
        Mon, 17 Dec 2018 03:26:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=hjZRGJVxWSH8KCYzvslXZ1ibTe/mfRKaEsdATRPORX0=;
 b=nfWhaI8Mmic84emzZOkDy6V+aJXzkDa+hXzdbY20juwOmSvXJmA16kLggUxuz3mAfmq9
 xnH9jfZFd7oqO8czn+4c8mLMvGFAAiPCdIf2z6oH44/YGNx4bOwE4ZP+vbzNFvDgeShq
 mj/6StrADJqZoA3ND38ub2SM7zvGr4qicqc3P1HFR6btWW62KXgxkYJO/VHEFg3UCWzB
 Rw9Vo46jgqOUMQi3ophUSQAb6bPo6QihgIWK0dZfNZ238PDN0kMYJsUL50PMJ7oc97Pw
 S27capk8GMfO/02ytsnjwFMstgNO7v1znKiBmWXatS60kjCTMO/cfJGOjOEjiJp1PtZb ww== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pdbx6e2gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Dec 2018 03:26:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjZRGJVxWSH8KCYzvslXZ1ibTe/mfRKaEsdATRPORX0=;
 b=C9y+HDs1oJld+Jz7vdRey/wY8J/7l4u0l++tALdGwZI2awmt52joGCNidhsN2U+sss4pSxUD/XMn49XaQX31ZOTV3Jpy8JCqIK7pDHdZWhybt1Nycg0q6RH9hQjvuwJ3Jikg//mZgyLU9ov2HZ2mETsGhwWtu3RFf/4cIzOt/iw=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4182.namprd07.prod.outlook.com (52.135.222.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 11:25:58 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 11:25:58 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWTYw8ZmuofoE+7Ba9cSOLyP6V5dPgAgAAFtpCAATKygIAIGJNA
Date:   Mon, 17 Dec 2018 11:25:58 +0000
Message-ID: <BYAPR07MB4709B102102DA96FE975264ADDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7lbme3m.fsf@linux.intel.com>
In-Reply-To: <87a7lbme3m.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODI3OGVmYjItMDFlZS0xMWU5LTg3MjgtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDgyNzhlZmIzLTAxZWUtMTFlOS04NzI4LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzY1OSIgdD0iMTMxODk1MTk1NTc2MjE0ODA4IiBoPSJXUmptNnRDaEtTK2pCMHRsS0lvLzYxVzBhSTg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4182;20:WYtAyD31OEADVh515jYDTPV/1LSUO27cR9rPDJB/Z/Tz2W7NNu+b3dRS04xp3xj5s8WdT140kRENJkymBC30rIfSjzsTNx3CnvMqhX1i868rdA45lOWDCECuuAvhoiKhE74WFxeJaJULyxuD1AdP35wkGihsMNIliQcrHam/8vD8o7TVQT+q6o7tQV8tvu8CbjaHY+mn3H5WFTWI+C39A73FkOLcOUni7rcxedqUgTBEjovJFYKCYhhsra7byrYz
x-ms-office365-filtering-correlation-id: 9d9d1c09-05af-49f7-1779-08d664126ada
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4182;
x-ms-traffictypediagnostic: BYAPR07MB4182:
x-microsoft-antispam-prvs: <BYAPR07MB418208244E9187D8FE12BAA8DDBC0@BYAPR07MB4182.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4182;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4182;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(51444003)(199004)(189003)(36092001)(305945005)(6506007)(6116002)(3846002)(25786009)(86362001)(8936002)(446003)(81166006)(81156014)(55016002)(5660300001)(106356001)(6436002)(2501003)(71200400001)(7416002)(71190400001)(74316002)(9686003)(229853002)(99286004)(66066001)(256004)(110136005)(54906003)(68736007)(4326008)(53936002)(486006)(478600001)(105586002)(33656002)(6246003)(107886003)(97736004)(316002)(11346002)(8676002)(93886005)(2906002)(14454004)(102836004)(26005)(7696005)(76176011)(476003)(186003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4182;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QRvTf3bNNKKKRPOngf0bhzl3YhWcuEiy8H9ryWEhajaLOdZd6eBZG23cMnbeULSZBDG1gH+b9NgqrkijraTgREni0EqRNCJ4JNXmkPbvIvj860RG/fHur5A8C0zuy0sDfb5wnXB0U4C4cFi1yLMqYt6X+b89d1nZceigHfQANwAdhhlV1yrUs7OuW5smdJPkbf32MJA/yJDmL/OVnhz6u8xMq3O+ve1iAQ8uuKig73nJMLGCNSY1ePrYAr2T/HPYJfXqMogytaPv/VoZaU1cJCvGkwfi6tons9VgSupPs7B6KdZVRNOaiFyKQF3Avn8X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d1c09-05af-49f7-1779-08d664126ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 11:25:58.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4182
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe
>
>Pawel Laszczak <pawell@cadence.com> writes:
><snip>
>
>>>> +	case USB_REQ_SET_ISOCH_DELAY:
>>>> +		sprintf(str, "Set Isochronous Delay Delay: %d ns", wValue);
>>>> +		break;
>>>> +	default:
>>>> +		sprintf(str,
>>>> +			"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
>>>> +			bRequestType, bRequest,
>>>> +			wValue, wIndex, wLength);
>>>> +	}
>>>> +
>>>> +	return str;
>>>> +}
>>>
>>>All of these are a flat out copy of dwc3's implementation. It's much,
>>>much better to turn dwc3's implementation into a generic, reusable
>>>library function then spinning your own as a duplicated effort.
>> I agree,
>> It would be nice to have a set of decoding function  in some generic lib=
rary. It could be used
>> also by other drivers.
>> Who should do this ?
>
>since you're the first to reuse it, then it should be you :-)

So I can prepare debug.h  in drivers/usb/gadget directory.=20

Function form drivers/usb/dwc3/debug.h that could be common are:=20

static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *s=
tr)
static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
						  __u16 i, __u16 l, char *str)
static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v, _=
_u16 i, char *str)											=09
static inline void dwc3_decode_set_address(__u16 v, char *str)
static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v, =
__u16 i, __u16 l, char *str)						 =20
static inline void dwc3_decode_get_configuration(__u16 l, char *str)
static inline void dwc3_decode_set_configuration(__u8 v, char *str)
static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str)
static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str)
static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str)
static inline const char *dwc3_decode_ctrl(char *str, __u8 bRequestType, __=
u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)

After changed it could looks like:=20
static inline void usb_decode_get_status(__u8 bRequestType, __u16 wIndex, _=
_u16 wLength, char *str)
static inline void usb _decode_get_set_descriptor(__u8 bRequestType, __u8 b=
Request, __u16 wValue,
						  __u16 wIndex, __u16 wLength, char *str)
static inline void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRe=
quest, __u16 wValue, __u16 wIndex, char *str)											=09
static inline void usb_decode_set_address(__u16 v, char *str)
static inline void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bR=
equest, __u16 wValue, __u16 wIndex, __u16 wLength, char *str)						 =20
static inline void usb_decode_get_configuration(__u16 wLength, char *str)
static inline void usb_decode_set_configuration(__u8 wValue, char *str)
static inline void usb_decode_get_intf(__u16 wIndex, __u16 wLength, char *s=
tr)
static inline void usb_decode_set_intf(__u8 wValue, __u16 wIndex, char *str=
)
static inline void usb_decode_synch_frame(__u16 wIndex, __u16 wLength, char=
 *str)
static inline const char * usb _decode_ctrl(char *str, __u8 bRequestType, _=
_u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)

Sorry but I prefer some more significant names :)

For me functions in drivers/usb/dwc3/debug.h looks ok, but I think that cou=
ld be better to
add additional usb_decode_test_mode and usb_decode_device_feature and littl=
e simplify usb_decode_get_set_descriptor.=20

What do you think about this?

One more question.=20
Can I add drivers/usb/gadget/debug.h file  as part of my  set patches, or t=
his should be done as separate, new patch ?=20

Cheers,
Pawel
