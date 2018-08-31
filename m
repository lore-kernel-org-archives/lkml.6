Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48462083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plantronics.onmicrosoft.com header.i=@plantronics.onmicrosoft.com header.b="vxiB02MT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48462083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plantronics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeHaV5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:57:21 -0400
Received: from mail-bl2nam02on0096.outbound.protection.outlook.com ([104.47.38.96]:60960
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbeHaV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plantronics.onmicrosoft.com; s=selector1-plantronics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVHwIHLel+GB9YUqzeaEKjNBSAb9dNTYJUPzpWIwOEY=;
 b=vxiB02MTZvPvqRnlJtvZhf+HTtjOcbsLk3sUbrT/lGsewgAcsSgPla2wKun/fsbOXwt54/Gd914929Lv1IjPI+WfiWfq2DpfQHjppdv5SIc0frwhoKdfYpax33ihBfVSOJf/qSsImU6bW7ZW+oaZSSsNRWtNKDPZJe/8LS/sHS8=
Received: from SN6PR02MB4864.namprd02.prod.outlook.com (52.135.116.26) by
 SN6PR02MB4477.namprd02.prod.outlook.com (52.135.121.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Fri, 31 Aug 2018 17:47:51 +0000
Received: from SN6PR02MB4864.namprd02.prod.outlook.com
 ([fe80::5029:7493:2581:b29f]) by SN6PR02MB4864.namprd02.prod.outlook.com
 ([fe80::5029:7493:2581:b29f%3]) with mapi id 15.20.1080.019; Fri, 31 Aug 2018
 17:47:51 +0000
From:   "Junge, Terry" <Terry.Junge@plantronics.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
Thread-Topic: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
Thread-Index: AQHUQQ4RXvS2C43i1EGEhAtLp5fyqqTaHVAw
Date:   Fri, 31 Aug 2018 17:47:50 +0000
Message-ID: <SN6PR02MB4864D83F3B3FD94CB4741732ED0F0@SN6PR02MB4864.namprd02.prod.outlook.com>
References: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Terry.Junge@plantronics.com; 
x-originating-ip: [198.231.9.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4477;6:sbhCdmBNft9Qh1hA2rSQ+VuYn8EaEIK9SINKq3gvrb/fjPXsa4mX/HLoWf1/dqGBHhFpxeTwwfiyiLtdAnm68/IQmx/XudUOIg9qZ0JFI5uR5qX/LQo12grSWtW/JTzPvcHt7A2NahFfVUWJqU4RSmmd6u3WaPK21aNqEh7Ijj7iCjOlyOrHtFnDPeXQZyjxb6XEfKSAlzyhEw8KgulOJUZU8wOMhWwAvpkd/SWuwVEqxR0B/2gr1ZmdQu9URgEx8fwZUWoRI7fN5taR8eKJ6DY4vP7yh398SRm4d+vOZVPN7bCQo4IkeqJFaRUN1OakUJJES3P7N3owJQ+qK9ytYTPqlh+rmo23Ihfo6N6kuVktOkOcNg0QPqGTTSIBgijb7NHXPWnAfBNqAL47cAO8cfe4R4DWTLYvsMFSjykCGjlWJngn7sYpaZRXPezkat37mIpEWGz1TU+sH99TrQ69lA==;5:aDyTxAocxg+0dGekKmrtXgxkeSkfrk69K6x7knWtV9431YdY3qfkva/IB4CAzAJAejNcoRTY3o4MUQThF023DWwFMnxq7Dcf2kVgmf1gZ2wpF2pqoQRvnFWklROm1Qnnq26YUa43nDi+pZYVwJn8kyXfrni0Yhj6dNHSkkDlK3Y=;7:rHa1RYRwJ+5HxSQ/wFjhNlVP9augakoqv0imWJQ+4xKDnUh+DUWwT1x/ZIb6BLKqC3rxaNiOs++AlFFwRWKM6tWRnJOrNIv8B1jhOBfRN9DkMtOqEcg2k3q56E0oeJfC5SafoMFs7jcVtW1XlCpMsKrcc8VN4sxVjs+qiGYS0l36yio1BEV4M5UTwLUTb5tKP/NsxqtWjnND89oNfewN9/wassFVev26Y4+vRcQkeAJgv/20F7r7tIUZyfXFTdRi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8a3c521b-8164-4db8-e818-08d60f69df45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4477;
x-ms-traffictypediagnostic: SN6PR02MB4477:
x-microsoft-antispam-prvs: <SN6PR02MB4477EB073477BDC853AC227CED0F0@SN6PR02MB4477.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:SN6PR02MB4477;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4477;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(366004)(136003)(13464003)(199004)(189003)(3846002)(55016002)(99286004)(97736004)(53936002)(7696005)(8936002)(68736007)(305945005)(81156014)(14454004)(81166006)(6246003)(9686003)(7736002)(76176011)(2906002)(6116002)(6306002)(5250100002)(8676002)(105586002)(486006)(14444005)(4326008)(5660300001)(86362001)(476003)(575784001)(6436002)(229853002)(110136005)(25786009)(11346002)(106356001)(33656002)(74316002)(316002)(446003)(102836004)(186003)(26005)(256004)(966005)(478600001)(6506007)(66066001)(72206003)(2900100001)(54906003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR02MB4477;H:SN6PR02MB4864.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: plantronics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4o7QxK02nDgBxAsK/+/xLxVvkRsfmxH5I2FgdrfUXKmoxnhYm9by2PLFO1q8nULBF5VQTcX0bVSf3Hkt+1TEgVuyTgd0IEH/ooReKBQ2C2sPy/fsFE2yrg4NDfwGAHRFHWd0l32BCSv4cJHUsoqHtEjNi/UHvR/LUR32LVWqc56PTXJrtHGoEyMrnn6Yad1jUTdxKqVrEFtUHuo5EiK/qZd4ex9AZGKknZDB+Y5PXk5nYjoKekAvmCsdWUWw8FUbkO4iUqy+yw4Z87dyNKRuIPrnS1yu2xM0kr1wP24K5sU9+IR4Zikeduw0n9RqQNX45ktRjyoIe/8UHxNjllKmRwVOQSnbSVtfL350UFb3rZU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plantronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3c521b-8164-4db8-e818-08d60f69df45
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 17:47:50.9976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc7c5f16-c55e-417d-aac0-ff6bbfc27f76
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth the Report Descriptor is a little questionable
which could be causing the collection to split in two

>-----Original Message-----
>From: linux-input-owner@vger.kernel.org [mailto:linux-input-
>owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
>Sent: Friday, August 31, 2018 2:36 AM
>To: Jiri Kosina <jikos@kernel.org>; Dmitry Torokhov
><dmitry.torokhov@gmail.com>
>Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin
>Tissoires <benjamin.tissoires@redhat.com>; stable@vger.kernel.org
>Subject: [PATCH] Partially revert "HID: generic: create one input report p=
er
>application type"
>
>This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.
>
>It looks like some mice are not correctly treated by
>HID_QUIRK_INPUT_PER_APP. Those mice have the following
>report descriptor:
>
>0x05, 0x01,                    // Usage Page (Generic Desktop)        0
>0x09, 0x02,                    // Usage (Mouse)                       2
>0xa1, 0x01,                    // Collection (Application)            4
>0x85, 0x01,                    //  Report ID (1)                      6
>0x09, 0x01,                    //  Usage (Pointer)                    8

This physical collection is associated with Generic Desktop:Pointer (0x0001=
:0x0001)

>0xa1, 0x00,                    //  Collection (Physical)              10
>0x95, 0x05,                    //   Report Count (5)                  12
>0x75, 0x01,                    //   Report Size (1)                   14
>0x05, 0x09,                    //   Usage Page (Button)               16

We are now in the Button page

>0x19, 0x01,                    //   Usage Minimum (1)                 18
>0x29, 0x05,                    //   Usage Maximum (5)                 20
>0x15, 0x00,                    //   Logical Minimum (0)               22
>0x25, 0x01,                    //   Logical Maximum (1)               24
>0x81, 0x02,                    //   Input (Data,Var,Abs)              26
>...
>0xc0,                          //  End Collection                     57
>0x85, 0x02,                    //  Report ID (2)                      58
>0x09, 0x01,                    //  Usage (Consumer Control)           60

This physical collection is associated with Button:Button 1 (0x0009:0x0001)
not Generic Desktop:Pointer (0x0001:0x0001)

>0xa1, 0x00,                    //  Collection (Physical)              62
>0x75, 0x0c,                    //   Report Size (12)                  64
>0x95, 0x02,                    //   Report Count (2)                  66
>0x05, 0x01,                    //   Usage Page (Generic Desktop)      68

Now we're back in the Generic Desktop page

>0x09, 0x30,                    //   Usage (X)                         70
>0x09, 0x31,                    //   Usage (Y)                         72
>0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
>0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
>0x81, 0x06,                    //   Input (Data,Var,Rel)              80
>0xc0,                          //  End Collection                     82
>0xc0,                          // End Collection                      83
>...
>
>Both the cursor position and the buttons are located in the
>same application collection (Mouse) and the kernel should
>only create one input device for those.
>
>However, for an undetermined reason, the kernel splits the
>device in 2, making systemd not tagging the second mouse
>with the coordinates only as a mouse. And then userspace
>ignores it which leads to a mouse where only the buttons
>are working.
>
>Until the quirk gets properly fixed, we should probably
>revert applying it to all of the generic devices and
>re-enable it when the root reason has been found.
>
>link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200847
>link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200849
>link: https://bugs.archlinux.org/task/59699
>link: https://github.com/NixOS/nixpkgs/issues/45165
>
>Cc: stable@vger.kernel.org # v4.18+
>Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>---
> drivers/hid/hid-generic.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
>diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
>index 3b6eccbc2519..c25b4718de44 100644
>--- a/drivers/hid/hid-generic.c
>+++ b/drivers/hid/hid-generic.c
>@@ -56,20 +56,6 @@ static bool hid_generic_match(struct hid_device *hdev,
>        return true;
> }
>
>-static int hid_generic_probe(struct hid_device *hdev,
>-                            const struct hid_device_id *id)
>-{
>-       int ret;
>-
>-       hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
>-
>-       ret =3D hid_parse(hdev);
>-       if (ret)
>-               return ret;
>-
>-       return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>-}
>-
> static const struct hid_device_id hid_table[] =3D {
>        { HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID,
>HID_ANY_ID) },
>        { }
>@@ -80,7 +66,6 @@ static struct hid_driver hid_generic =3D {
>        .name =3D "hid-generic",
>        .id_table =3D hid_table,
>        .match =3D hid_generic_match,
>-       .probe =3D hid_generic_probe,
> };
> module_hid_driver(hid_generic);
>
>--
>2.14.3
>
>________________________________
>NOTE: THIS EMAIL DID NOT COME FROM A PLANTRONICS ASSOCIATE.
>If the sender claims to be a Plantronics associate it may be fraudulent an=
d
>spoofing the associates address. Please report suspicious emails or phishi=
ng
>attempts to:
>phishalarm@Plantronics.com<mailto:phishalarm@Plantronics.com>.

