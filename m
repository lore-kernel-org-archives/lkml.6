Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D41C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D4F2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BuFrdihC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D4F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeITAh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:37:57 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:56154
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732549AbeITAh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUzhsHtLe5e3Ixdm2FmnSWzydESkhywAsWLTuVHdoLY=;
 b=BuFrdihCnDtnMKNMtnu9NktXmnXCCp4y+oxAVCoTi9S/Ccfdww87uLmEsf0LhprmlobpAzVzRjDArPkUwwf34Ur+D7xXBBZ9D3lJiijqzl8JIia9Lih5WlTLFsNd0iAvLBJ4SbrFp470HHrWnJUT9iM6qazeBZsh+sZygK95AH4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0501.namprd21.prod.outlook.com (10.172.122.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Wed, 19 Sep 2018 18:58:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Wed, 19 Sep 2018
 18:58:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Thread-Topic: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Thread-Index: AQHUUErFdRcR/Rbme0KsaP7mPS15JA==
Date:   Wed, 19 Sep 2018 18:58:37 +0000
Message-ID: <CY4PR21MB07761FEA1CDDC87FBE5568B4FB1C0@CY4PR21MB0776.namprd21.prod.outlook.com>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
In-Reply-To: <20180918082422.13050-1-songqiang1304521@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0501;6:+rXlhkO9KSNrgmABijTDf3c9rr0ouT+zt8smwFNDrqoDvo86BT0p/tpJFp61uyTaYFRf+Ya4QzdSDv7i+k8htm5GY+iGBYFJ5QBzWMdzPWsC3jwfurxZjrbzgKoE1KNn7itACHtaQXsiKx0P6vnX0mFa9QQF8a8urUFNDBuGKa4DzIjWsjOECzrVXRD4FHrLx8/nF7WS8NAnt4j+fhgU+KiUAyDtlBkJm0UoCvDvvMGAaamr+1vDTlD8aWRTCQjjNqCLuoKTgpqcKBSxuTTNtvG8/b/SLdx58BlK+4L59nQbNFCkOJLU5jizXsYlP7Kjq47zLdK0OZz7JsVrzzo/ZUK7atj3XzEd/zGRogJOScI9jx7tt2M8X++EqIewRRH3FK+VWz8mO4bWAk17wJMbs3qZafCzbTeJG1KVSvl/uYCTNbnnatv3r+2wm9iAg+GO1exLIsSOcLeCo5lUW0m6IQ==;5:AVqDlSB0wVyOF7hbtlzbccLP+wMLPwLVf3cUk5PJwaATgL1rmo9DHBww+4zTJpYV31zpOnTJcWAzcjVBvyszfzrzS/ClBcMBqJvzL7/gdtwIOrhGEiOP5LL5uEqfSgHIvtvEZltleEZ3HAqa+j3GpdrGl12SFGcdcuKJC55wYtA=;7:52vzsFXjfMgGeOa1OOvRpWp9FerzXvnBsc0/dq6QT0cetpjTEbL2/9w2yDV6JZFyju/MJTU8j9vSPU6Swck9V8+fLvVJ2rFttuRgkqDq02ia2U7+07OoxqN0cHwGMlCys9hAkAC3wRAwhlyCF9EGVet/IuHCqtRUC7Omn4O+DlIEQk+7E4z0zJoOno5kcDs7C3lJHRmdA7R0HdJUXRsMSO7lBUasjkluyw1RrMp/zrkZEJcsBibtNcWEMDd9aKze
x-ms-office365-filtering-correlation-id: 0bea656d-b9ee-414b-98fc-08d61e61e851
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7193020);SRVR:CY4PR21MB0501;
x-ms-traffictypediagnostic: CY4PR21MB0501:
x-microsoft-antispam-prvs: <CY4PR21MB05017334DBF68D33D69613FAFB1C0@CY4PR21MB0501.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0501;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0501;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(54906003)(53936002)(110136005)(14454004)(22452003)(8936002)(68736007)(575784001)(86362001)(9686003)(5250100002)(478600001)(6436002)(2906002)(229853002)(55016002)(86612001)(72206003)(106356001)(10290500003)(2900100001)(102836004)(2201001)(105586002)(5660300001)(8676002)(81166006)(81156014)(476003)(256004)(76176011)(11346002)(39060400002)(316002)(66066001)(446003)(6506007)(305945005)(74316002)(99286004)(25786009)(26005)(7736002)(97736004)(2501003)(3846002)(8990500004)(6246003)(6116002)(1511001)(7696005)(33656002)(10090500001)(486006)(6346003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0501;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: GMDGBjVDZGy9fEATSo/6HFi54aoDHxoQse4MMmKgqfkwo3fRlY+ufSm56wKssHIVoZvCls1dRynXHIHqhDlqV/Sdk+KcrfI7Zx/9TRKMFEATqd/pmIhPHiDFKT0RPBuVAGJ5iSekI5hWGM6Wpp/cRz0B0d+0eSVHHB6ieFKbmRkH+hIS52x12pvE+ZuC6BEXTGXjgiGXHpyiPhBxF3YfGlynPeEiUvUkUYCUwdzDgtB6VESWx6QV8sJHFvmqfEB575kaTaC/5eUV8j8ia0Pv7RieBux4RdnMcr5r/Ddt3VZmwWuXXCbM+g8V2eKnXe3PKipAp76WHOV6NXM2OYoIl9T7FoK1zi4n4a1VA6D5KGM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bea656d-b9ee-414b-98fc-08d61e61e851
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 18:58:37.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.18.8, v4.14.70, v4.9.127, v4.4.1=
56, v3.18.122,=20

v4.18.8: Build OK!
v4.14.70: Failed to apply! Possible dependencies:
    22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")

v4.9.127: Failed to apply! Possible dependencies:
    22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
    78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")

v4.4.156: Failed to apply! Possible dependencies:
    22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
    78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")

v3.18.122: Failed to apply! Possible dependencies:
    22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
    4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
    78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")


Please let us know how to resolve this.

--
Thanks,
Sasha=
