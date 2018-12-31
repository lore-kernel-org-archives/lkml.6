Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A992173C
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jZ5rxEru";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fk9oHKBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeLaJnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:43:21 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37438 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726457AbeLaJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 04:43:20 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBV9dNc5016806;
        Mon, 31 Dec 2018 01:43:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=/BSMV/bfcgNm4pHlZ7/dU1kq3MwvnGXQKr3oObgKw+g=;
 b=jZ5rxEruX9KjTw+/UbPDZr9eIaX3EbXTRBsav/zgB+x8Cz1jMhrrgjktcKh0Lz68PgRB
 UG972oOYws9sBXMHNCYwlksuf7763mcAGLbxQymPsh6mQM8xRM/2PkPMUAywWGcgFdt8
 53+UW99MV24mbgR6vD2mm/Kw9/v/qcxbZla+d3Nc3gwFCIPQt8WOiEu1sACmjbRP1DGs
 gHsYCUzQcTy0CsOGD7mByW/TK27GvpD4VmnIrAmE8cRqBKLeG36yY6vbzc+k/SXeCtAc
 /YG3RIOIIK7gm/snMcvVvky5FLmLsJLMAI+RGURF+y9mkYMHJ7NKSO6QVqGlkVHZXkbR Ng== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pp5d1fvcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Dec 2018 01:42:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BSMV/bfcgNm4pHlZ7/dU1kq3MwvnGXQKr3oObgKw+g=;
 b=fk9oHKBTfYBa1Peim0Sjiz9ehbbkR8BjezOsY+lFbYwUkeWh9tnndpriiZ0hSKfWRRmAUQjwsfw3X0Y3L4WR5sWe4gUVrs9ipUiIUkmrUOrrnxh7CzTPv7g5okkhIrVljUz0IDJMafgxPLjObBYuWIsUllf2VQKRdCmpTphaAjQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4965.namprd07.prod.outlook.com (52.135.238.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Mon, 31 Dec 2018 09:42:55 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%3]) with mapi id 15.20.1471.019; Mon, 31 Dec 2018
 09:42:55 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUmtItEP31Hrx74EuIb6kD4d3L1KWMs42AgAvqBiA=
Date:   Mon, 31 Dec 2018 09:42:55 +0000
Message-ID: <BYAPR07MB4709D1D286EAD3A794987E51DDB20@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1545577992-4013-6-git-send-email-pawell@cadence.com>
 <201812240317.VglTVDie%fengguang.wu@intel.com>
In-Reply-To: <201812240317.VglTVDie%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzA2NDcyZWUtMGNlMC0xMWU5LTg3MjktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDcwNjQ3MmVmLTBjZTAtMTFlOS04NzI5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODA1MSIgdD0iMTMxOTA3MjI5NzMyMTQ5NDMxIiBoPSJtT2xWa3k4SXRvRVdzQi9WOFNNc0FJYk9SYmc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4965;20:RuXS+x6Vxgur+4s6/NWLfCywVx9NKZHN7+/RiTRFG8RclSFjgxWt7MXmSX59oPQ2yz/GBkRyiuvhTYiN3NFBS/ASiiohd1amLPflCjDQK4gmkznDSNLG8E1IE4YSmiEouOYV4NNqqVCnL0xc1HgMxwz8DTNycfXYb4MiAYfwBoM3OlxNGno8kbzKcgguwArFqFRvw7HEpnfg9V55mgBorok6Cy1RC5ROeWWMgWCyIF4xLRsEwF84cYDK3KCwTfKJ
x-ms-office365-filtering-correlation-id: 83277671-7e1f-4726-bb5d-08d66f04577e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4965;
x-ms-traffictypediagnostic: BYAPR07MB4965:
x-microsoft-antispam-prvs: <BYAPR07MB49653360AF951E36EAC70E26DDB20@BYAPR07MB4965.namprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4965;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4965;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39850400004)(366004)(346002)(189003)(199004)(36092001)(186003)(7416002)(26005)(4001150100001)(7736002)(2906002)(6916009)(486006)(316002)(74316002)(54906003)(76176011)(7696005)(6506007)(476003)(97736004)(25786009)(105586002)(446003)(106356001)(102836004)(6436002)(8936002)(229853002)(81156014)(4326008)(81166006)(6346003)(8676002)(305945005)(11346002)(3846002)(6116002)(53936002)(33656002)(71190400001)(71200400001)(55016002)(6306002)(9686003)(575784001)(39060400002)(478600001)(5024004)(966005)(5660300001)(256004)(99286004)(14454004)(14444005)(68736007)(345774005)(66066001)(86362001)(6246003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4965;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: INADhZ3oKkEcxhbVP5LzgTfGEUpGfDUF1LWDpb0OMvdXJb/GDKOq6oYsLyhukrbA9ppttCnN4SemGqSb5GoYzLERSIj6fOm1W1nsw2LSOIVt7wZjtJjSS0Mx56oyYquPTMA91+9XTmXY3PtS3737YypfP8mO9hbZ3B/XItmycDUO9qywVT2z/zvNjoYIwTIqzAVxtynenMwSud62r0gTK83/DtMpZgQJPmq2f0tsrSd06vYboy8VYf03PB9PhCAhAr0MXG+m7X+7RY42lRPtWrFwl/kEKOcLhxHK2vGz/s72M8i9VKadXX7zF76igUuH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83277671-7e1f-4726-bb5d-08d66f04577e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 09:42:55.6778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4965
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I can't recreate these issue on my environment. I use  gcc (Ubuntu 7.3.0-27=
ubuntu1~18.04) 7.3.0.  Maybe there are some differenct between these two co=
mpilers.=20

Do you have any idea how I should change this fragment of code:
		sprintf(str, "%02x %02x %02x %02x %02x %02x %02x %02x",
			bRequestType, bRequest,
			cpu_to_le16(wValue) & 0xff,
			cpu_to_le16(wValue) >> 8,
			cpu_to_le16(wIndex) & 0xff,
			cpu_to_le16(wIndex) >> 8,
			cpu_to_le16(wLength) & 0xff,
			cpu_to_le16(wLength) >> 8);

to remove "restricted __le16 degrades to integer" warnings ?

Maybe I should cast all to u8. Then this code will look like:
		sprintf(str, "%02x %02x %02x %02x %02x %02x %02x %02x",
			bRequestType, bRequest,
			(u8)(cpu_to_le16(wValue) & 0xff),
			(u8)(cpu_to_le16(wValue) >> 8),
			(u8)(cpu_to_le16(wIndex) & 0xff),
			(u8)(cpu_to_le16(wIndex) >> 8),
			(u8)(cpu_to_le16(wLength) & 0xff),
			(u8)(cpu_to_le16(wLength) >> 8));

Should it Fix these warnings ?

Cheers,
Pawel

>Thank you for the patch! Perhaps something to improve:
>
>
>
>[auto build test WARNING on usb/usb-testing]
>
>[also build test WARNING on v4.20-rc7 next-20181221]
>
>[if your patch is applied to the wrong git tree, please drop us a note to =
help improve the system]
>
>
>
>url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_=
0day-2Dci_linux_commits_Pawel-2DLaszczak_Introduced-
>2Dnew-2DCadence-2DUSBSS-2DDRD-2DDriver_20181223-2D231813&d=3DDwIBAg&c=3DaU=
q983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-
>_haXqY&r=3De1OgxfvkL0qo9XO6fX1gscva-w03uSYC1nIyxl89-rI&m=3DJS8MUBEUPN46-me=
57xUY-
>7hoBbSrlgd2SCB9ahNjK4s&s=3DbhpHqRyEtMdMbWdGoBqQ9Pz9wq7pRA7-OohrGik3BpM&e=
=3D
>
>base:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>3A__git.kernel.org_pub_scm_linux_kernel_git_gregkh_usb.git&d=3DDwIBAg&c=3D=
aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-
>_haXqY&r=3De1OgxfvkL0qo9XO6fX1gscva-w03uSYC1nIyxl89-rI&m=3DJS8MUBEUPN46-me=
57xUY-
>7hoBbSrlgd2SCB9ahNjK4s&s=3DVf__lGpV27zdf1egowm9p8YBJjz9aMmgbi8nW_Z_DLk&e=
=3D usb-testing
>
>config: x86_64-allmodconfig (attached as .config)
>
>compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>
>reproduce:
>
>        # save the attached .config to linux build tree
>
>        make ARCH=3Dx86_64
>
>
>
>All warnings (new ones prefixed by >>):
>
>
>
>>> drivers/usb/common/debug.c:253:25: warning: restricted __le16 degrades =
to integer
>
>   drivers/usb/common/debug.c:254:25: warning: restricted __le16 degrades =
to integer
>
>   drivers/usb/common/debug.c:255:25: warning: restricted __le16 degrades =
to integer
>
>   drivers/usb/common/debug.c:256:25: warning: restricted __le16 degrades =
to integer
>
>   drivers/usb/common/debug.c:257:25: warning: restricted __le16 degrades =
to integer
>
>   drivers/usb/common/debug.c:258:25: warning: restricted __le16 degrades =
to integer
>
>
>
>vim +253 drivers/usb/common/debug.c
>
>
>
>cefb8b21 Pawel Laszczak 2018-12-23  205
>
>cefb8b21 Pawel Laszczak 2018-12-23  206  /**
>
>cefb8b21 Pawel Laszczak 2018-12-23  207   * usb_decode_ctrl - returns a st=
ring representation of ctrl request
>
>cefb8b21 Pawel Laszczak 2018-12-23  208   */
>
>cefb8b21 Pawel Laszczak 2018-12-23  209  const char *usb_decode_ctrl(char =
*str, __u8 bRequestType, __u8 bRequest,
>
>cefb8b21 Pawel Laszczak 2018-12-23  210  			    __u16 wValue,  __u16 wInde=
x, __u16 wLength)
>
>cefb8b21 Pawel Laszczak 2018-12-23  211  {
>
>cefb8b21 Pawel Laszczak 2018-12-23  212  	switch (bRequest) {
>
>cefb8b21 Pawel Laszczak 2018-12-23  213  	case USB_REQ_GET_STATUS:
>
>cefb8b21 Pawel Laszczak 2018-12-23  214  		usb_decode_get_status(bRequestT=
ype, wIndex, wLength, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  215  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  216  	case USB_REQ_CLEAR_FEATURE:
>
>cefb8b21 Pawel Laszczak 2018-12-23  217  	case USB_REQ_SET_FEATURE:
>
>cefb8b21 Pawel Laszczak 2018-12-23  218  		usb_decode_set_clear_feature(bR=
equestType, bRequest, wValue,
>
>cefb8b21 Pawel Laszczak 2018-12-23  219  					     wIndex, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  220  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  221  	case USB_REQ_SET_ADDRESS:
>
>cefb8b21 Pawel Laszczak 2018-12-23  222  		usb_decode_set_address(wValue, =
str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  223  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  224  	case USB_REQ_GET_DESCRIPTOR:
>
>cefb8b21 Pawel Laszczak 2018-12-23  225  	case USB_REQ_SET_DESCRIPTOR:
>
>cefb8b21 Pawel Laszczak 2018-12-23  226  		usb_decode_get_set_descriptor(b=
RequestType, bRequest, wValue,
>
>cefb8b21 Pawel Laszczak 2018-12-23  227  					      wIndex, wLength, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  228  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  229  	case USB_REQ_GET_CONFIGURATION:
>
>cefb8b21 Pawel Laszczak 2018-12-23  230  		usb_decode_get_configuration(wL=
ength, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  231  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  232  	case USB_REQ_SET_CONFIGURATION:
>
>cefb8b21 Pawel Laszczak 2018-12-23  233  		usb_decode_set_configuration(wV=
alue, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  234  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  235  	case USB_REQ_GET_INTERFACE:
>
>cefb8b21 Pawel Laszczak 2018-12-23  236  		usb_decode_get_intf(wIndex, wLe=
ngth, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  237  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  238  	case USB_REQ_SET_INTERFACE:
>
>cefb8b21 Pawel Laszczak 2018-12-23  239  		usb_decode_set_intf(wValue, wIn=
dex, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  240  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  241  	case USB_REQ_SYNCH_FRAME:
>
>cefb8b21 Pawel Laszczak 2018-12-23  242  		usb_decode_synch_frame(wIndex, =
wLength, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  243  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  244  	case USB_REQ_SET_SEL:
>
>cefb8b21 Pawel Laszczak 2018-12-23  245  		usb_decode_set_sel(wLength, str=
);
>
>cefb8b21 Pawel Laszczak 2018-12-23  246  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  247  	case USB_REQ_SET_ISOCH_DELAY:
>
>cefb8b21 Pawel Laszczak 2018-12-23  248  		usb_decode_set_isoch_delay(wVal=
ue, str);
>
>cefb8b21 Pawel Laszczak 2018-12-23  249  		break;
>
>cefb8b21 Pawel Laszczak 2018-12-23  250  	default:
>
>cefb8b21 Pawel Laszczak 2018-12-23  251  		sprintf(str, "%02x %02x %02x %0=
2x %02x %02x %02x %02x",
>
>cefb8b21 Pawel Laszczak 2018-12-23  252  			bRequestType, bRequest,
>
>cefb8b21 Pawel Laszczak 2018-12-23 @253  			cpu_to_le16(wValue) & 0xff,
>
>cefb8b21 Pawel Laszczak 2018-12-23  254  			cpu_to_le16(wValue) >> 8,
>
>cefb8b21 Pawel Laszczak 2018-12-23  255  			cpu_to_le16(wIndex) & 0xff,
>
>cefb8b21 Pawel Laszczak 2018-12-23  256  			cpu_to_le16(wIndex) >> 8,
>
>cefb8b21 Pawel Laszczak 2018-12-23  257  			cpu_to_le16(wLength) & 0xff,
>
>cefb8b21 Pawel Laszczak 2018-12-23  258  			cpu_to_le16(wLength) >> 8);
>
>cefb8b21 Pawel Laszczak 2018-12-23  259  	}
>
>cefb8b21 Pawel Laszczak 2018-12-23  260
>
>cefb8b21 Pawel Laszczak 2018-12-23  261  	return str;
>
>cefb8b21 Pawel Laszczak 2018-12-23  262  }
>
>cefb8b21 Pawel Laszczak 2018-12-23  263  EXPORT_SYMBOL_GPL(usb_decode_ctrl=
);
>
>cefb8b21 Pawel Laszczak 2018-12-23  264
>
>
>
>:::::: The code at line 253 was first introduced by commit
>
>:::::: cefb8b2176410ef0aacc22411a64f8a157612f14 usb:common Separated decod=
ing functions from dwc3 driver.
>
>
>
>:::::: TO: Pawel Laszczak <pawell@cadence.com>
>
>:::::: CC: 0day robot <lkp@intel.com>
>
>
>
>---
>
>0-DAY kernel test infrastructure                Open Source Technology Cen=
ter
>
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.01.org_piperm=
ail_kbuild-
>2Dall&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=3De1Ogx=
fvkL0qo9XO6fX1gscva-w03uSYC1nIyxl89-
>rI&m=3DJS8MUBEUPN46-me57xUY-7hoBbSrlgd2SCB9ahNjK4s&s=3D7vN3rhLkFNcUQ6jriRP=
_jESizA-Wm6VxtiGb8qhTKqU&e=3D                   Intel
>Corporation

