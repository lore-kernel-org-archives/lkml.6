Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939C9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA01208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="FVplMyY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA01208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeH0Irb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 04:47:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:14586 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbeH0Irb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 04:47:31 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id E5/14-32478-3E5838B5; Mon, 27 Aug 2018 05:02:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHe885O+cYW71NY4+mfhh0M8/YFtS
  oiD4EjSCoPgRlYUc7bYNdZGeaRsHIVk0zRhcqKaeVZWoZlmVX01aWkV0krWSQOrpMKuyORLWz
  M7ucT//3/f2f//O8h4cl1T10GisUewS3k7dr6fGUxuJ7yg35SnP0z9ummIKhboXp1rE3yPT84
  1eFqefKEdpU2/eYMIW7btMm3/UQs4gxN1Y1IvPlyjBjbq730+a6hm+M+VNz5nLFGoXNmecqXq
  +wXgr7iYJIanFfRQXhRZ0pZWg8S+EmEnpHGxnpoMYBAg4ODNPyIYzgUcMoUYaSWBpnw+Dhprh
  OwUugZfAVKZlI/JqAqpZaJIFkvAJqLvSSsmklRIb9lKznQfhiS1xTeCq8u7knHqTC6+DDqV8K
  uVsNgv73UVoCSXgm3Ah/jxWwLMIZ8LQ3XbomsQZeRILxWsAYTlx7SMp6Mrwd+qmQNMK54I0eS
  dxnw4O+CJK1Fm6XPqNknQFPguVI6gu4jYGjTedpGSyDQMcAI4O7CK40hxLVWXDrV22iswlOlP
  sSSQug++Wl+KCA7bD3deqYfVeoMmHPhPqKAUrObCdhdKQnAdLB/+AzHUC6yn8eJ+tsqL76kZb
  1LDhZM0xWxn/YJLh3OEJVI6oezc1z2yxWj4O32TmDXs8ZDEbOqDdyhjk6fjOXrxMKuU2C6OEM
  On6TqBNLHPn2DTqn4GlGsQUbF/ta0bOv+R0olSW0k1WD87blqCfkuTaUWHnRmusutAtiB0pnW
  S2oTm4vzVFPcgsWoXijzR7b0jEMrFKboqqSsEos4B2izSKjLsSxPz4c2EuqKafLKaRpVOclE5
  ZM1kLnn4ixXX+CMtKSVSg2lFpZILgdNs//PIo0LNImq85KKUqb0/OnUzQ2BBEb4lDUKw3h4f+
  iNC+a471fVFe1qjqz6PTqh8YQ0dk7fYK+vT8lGNBtWftGsKPWrn3l3fu/aDgGJa26EFWuY84t
  2fd5+TZfUV0gq3/x/Nn2G2dygxHlTr3REliaviNSv7XWdXxwtye3zL8+e/O0GcmRioWOLF0nV
  fLzraF1RDMy6to18c5QoK20PcDnaSnRyhuySLfI/wbH27cp5gMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-16.tower-302.messagelabs.com!1535346146!6088046!1
X-Originating-IP: [23.103.133.213]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20477 invoked from network); 27 Aug 2018 05:02:27 -0000
Received: from mail-vi1eur04lp0213.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (23.103.133.213)
  by server-16.tower-302.messagelabs.com with AES256-SHA256 encrypted SMTP; 27 Aug 2018 05:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpHEvsa1b7vshaEpDYi91ocpBdqDZBmV11PxFylffWo=;
 b=FVplMyY53GmayAJ4vdi0/m2aYZsyG9y7+h2/JFncHqFDJgrC9uBiqfjLVV7nV9sUcRGz8b0qHA7tuXWDuVRfjAl3r1dKC9hJ5+LCqssvNZPoUaUUSQHS5QnCxpw8UHvTG1qnKpCu3mSEhI94wNgyCBC/FIi+TNjO8mV4XzaT2Ls=
Received: from DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM (20.176.239.91) by
 DB7PR10MB2028.EURPRD10.PROD.OUTLOOK.COM (52.134.102.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Mon, 27 Aug 2018 05:02:25 +0000
Received: from DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::440b:d23:b994:eb63]) by DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::440b:d23:b994:eb63%2]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 05:02:25 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Pavel Machek <pavel@ucw.cz>, Roy Im <roy.im.opensource@diasemi.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 2/3] dt-bindings: input: Add document bindings for
 DA7280
Thread-Topic: [PATCH V4 2/3] dt-bindings: input: Add document bindings for
 DA7280
Thread-Index: AQHUOsHJ249n2Dkmv0mD9SC2PVBxf6TRnQyAgAFvbPA=
Date:   Mon, 27 Aug 2018 05:02:24 +0000
Message-ID: <DB7PR10MB2169FA41DB1196ACCDFEE333850B0@DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
 <0d2a3c034a567d3a3ccd2e965f40e9af28f7e4d3.1534830272.git.Roy.Im@diasemi.com>
 <20180826065157.GA25309@amd>
In-Reply-To: <20180826065157.GA25309@amd>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.100.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR10MB2028;6:KEzGAjk3ADzlZGf/ruIzDVy0cAh24iz2nUPg4+/GJS2DG9Q8hZ7ll6X1pSUtOsAsrrgJ52l8vQJ2skmZtbdwOe/1eoJ7HbNOV/IecP8YRiX+yiwxTWRARJo1EfU5S18gcytYBfeeNnBsyAni1MKLSW22p7GUpf4jHLHwYm6Lya7e05ba76UUibOOVubc58etdB/3U3mJDopRlov62hdHsq1t6xT7VOk0O/J8sWzeZGDwN8Rk9LY7sQp2j7s3eaOrJFtI6xw9oI5gU5jJjai7mYiOI5/fYMUETOrUpi6t33pgu8MkPFwiN8guCCS9ai+R+bOPe4hJKEihO5Jg6G89nQyt1KM9UHx8SGpCBOUypFyJ2Sy/B8dkVrzbYOxpCzRdGR+1TFzrPSRzwwQhgMV7v3QEHbjjRSJkLENqATVZEus+5XPPTL2KmAU5zMn+WUW+UZ5yfO3ANs6jQKlMaG8bjw==;5:GLzebxLd5I+i4ZcpsB8gi0wfHeB7FGTD8LO4B0R2humNghEI7a4QvSkpAxvgX9NO53WgnjQmcyUTgmuuSsQbiK6eSHVMNt5ChL1oCV1E/H9dZ9Vpeyk0SU+Cg9TjyKezNX0eTFo2CcovQBe2g598zaZVTGbZeevbOZzjd5fSQeY=;7:Fv1zLgFHqji0L3G9NXwhKhhO7vLXbmHmKe5Tv4Cn8j3WZMPD8Ed2VPDkx2ID8l3KBu6D/8wk55epGryvNrgPmBEWlbS87lPbPksj9CPrs04zgZe2QUO/UItb4Lq62ie6zUAzJDYmA1blDECeaH9mWw/aRR87g8yBMepo8sYaaD5ei13TfXDIE9P1KPzUh7ATM5lj0IzhkE3c3unc35HPuIaLLeMMNk8i5S9qAc/5jidAFg7Mw2hO/52OeV2Yw+BX
x-ms-office365-filtering-correlation-id: 5ebc6018-a6a3-42a5-a6a7-08d60bda47a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR10MB2028;
x-ms-traffictypediagnostic: DB7PR10MB2028:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <DB7PR10MB2028D2B6352D8CF7BDC11190A20B0@DB7PR10MB2028.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR10MB2028;BCL:0;PCL:0;RULEID:;SRVR:DB7PR10MB2028;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39850400004)(136003)(376002)(199004)(189003)(39060400002)(6246003)(4326008)(68736007)(86362001)(575784001)(229853002)(2906002)(8936002)(81156014)(8676002)(81166006)(7736002)(74316002)(14454004)(106356001)(105586002)(305945005)(66066001)(102836004)(486006)(476003)(53546011)(3556765002)(25786009)(186003)(33656002)(14444005)(6506007)(11346002)(26005)(6306002)(9686003)(5660300001)(97736004)(55016002)(966005)(6436002)(478600001)(256004)(446003)(6116002)(99286004)(3846002)(53936002)(2900100001)(5250100002)(54906003)(110136005)(316002)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2028;H:DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 58deA292pSKcWNZ5I0Nln4TdwQcF3GQv8rP9Q9Usep1oR/VnwMdNFNnJMvpSfeCdxwCB/4Jrkfq4zzDmc+m4BaPM33qYCssUBQqWQPHRNZRJBbE/689y4nTVbL9BY32sSv2ylfkOXWCwA8+T/ZT55I5BqS5HPusD/AnWKC7/j4kCoNs2iMrsmB6gfjiPWlgczdbrGdX7GCK4uzFKShJg9WejrNTWkEHf8NZ1rWcdbGL4lLuKOj7JMlEPiV3uHM5KI8Kb6P16irO0PfvLPljzQ3yWns1zG+16YM9bGe1af4my9vFk5su9w5VSGr1oaBKoVSJZJSk+yn5NB2xWV6gfljSf9lP0wjrMboelzab8FY4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc6018-a6a3-42a5-a6a7-08d60bda47a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 05:02:24.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sunday, August 26, 2018 3:52 PM, Pavel Machek wrote:
>
> > +++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
> > @@ -0,0 +1,101 @@
> > +Dialog Semiconductor DA7280 Haptics bindings
> > +
> > +Required properties:
> > +- compatible: Should be "dlg,da7280".
> > +- reg: Specifies the I2C slave address.
> > +
> > +- interrupt-parent : Specifies the phandle of the interrupt
> > +controller to
> > +  which the IRQs from DA7280 are delivered to.
> > +
> > +- dlg,vib-mode:
> > +  "LRA-MODE" - Linear Resonance Actuator mode.
> > +  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
> > +  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.
>=20
> So this is some kind of "vibration motor" on steroids)?

I will add some descriptions more here in v5.

> > +- dlg,op-mode: Haptic operation mode.
> > +  Possible values:
> > +	1 - Direct register override mode triggered by i2c(default),
> > +	2 - PWM data source mode setting duty to 0 - 0xffff(0% - 100%),
>=20
> Space after 0xffff?

I will remove this in v5.

>=20
> > +	3 - Register triggered waveform memory mode, the pattern assigned
> > +	    to the PS_SEQ_ID played as much times as PS_SEQ_LOOP,
> > +	4 - Edge triggered waveform memory mode, external GPI(N) condtrol
>=20
> "control"

I will fix this in v5

>
> > +	    are required to enable/disable and it needs to keep
> > +	    device enabled by sending magnitude (X > 0),
> > +	    the pattern is assigned to the GPI(N)_SEQUENCE_ID below
>=20
> "below."

I will fix this in v5

>=20
> > +- dlg,imax-microamp: Actuator max current rating.
> > +  Valid values: 0 - 252000.
> > +  Default: 130000.
> > +- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,
>=20
> "ohms"

I will fix this in v5.

>=20
> > +  as read from its datasheet.
>=20
> "as read" does not sound english.

I will correct this in v5.

>=20
> > +- dlg,mem-array: use in case that memory registers should be updated,
> > +  Please fill the whole buffers(100 bytes) to avoid any error in drive=
r.
> > +  For example,
> > +	dlg,mem-array =3D <
> > +		0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A
> > +		...
> > +		0x71 0x72 0x73 0x74 0x75 0x76 0x77 0x78 0x79 0x7A
> > +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> > +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> > +	>;
>=20
> I'd not understand what this is from this description. (And I'd put
> example below... in the exampls section).

I will improve and update the description including the example section in =
v5.

Regards,
Roy

>=20
> > +For further information, see device datasheet.
> > +
> > +=3D=3D=3D=3D=3D=3D
> > +
> > +Example:
> > +
> > +	haptics: da7280-haptics@4a {
> > +		compatible =3D "dlg,da7280";
> > +		reg =3D <0x4a>;
> > +		interrupt-parent =3D <&gpio6>;
> > +		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> > +		dlg,vib-mode =3D "LRA-MODE";
> > +		dlg,op-mode =3D <1>;
> > +		dlg,nom-microvolt =3D <2000000>;
> > +		dlg,abs-max-microvolt =3D <2000000>;
> > +		dlg,imax-microamp =3D <170000>;
> > +		dlg,resonant-freq-hz =3D <180>;
> > +		dlg,impd-micro-ohms =3D <10500000>;
> > +		dlg,freq-track-enable;
> > +		dlg,rapid-stop-enable;
> > +	};
>=20
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
