Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFCC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187F620851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="foMsZY2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187F620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeLMBVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:21:37 -0500
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:40394
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbeLMBVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8EW9n4WiNGdoDAAGNfzRsx/652/qEx/EiRYr0/VOGg=;
 b=foMsZY2cOgNz4o8m9Xx01sH38bHT5sq4Lo8MIoJNsdl+QovY0VG6NY7iKYgdQJW/Rp4S+PXFT9u6NkAMYoQFLboisRqoQhupCZORA+mb/5P8BeriqaV17TZ/KnY8QimqU0AeXKSMnOZJYD/4HZup7jtuS1lHdWyDqY7Kg++xQZ0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4126.eurprd04.prod.outlook.com (52.133.14.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 13 Dec 2018 01:21:30 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 01:21:30 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Bin Liu <b-liu@ti.com>, Peter Chen <hzpeterchen@gmail.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "pjez@cadence.com" <pjez@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWPYiPxiKamv0Kw/89WiQfMk6V5dPgAgABym4CAAHVkgIAA55GAgACbpFA=
Date:   Thu, 13 Dec 2018 01:21:29 +0000
Message-ID: <VI1PR04MB53277D6C8BAFD2ABCD76DB9D8BA00@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
 <20181212155313.GA6502@uda0271908>
In-Reply-To: <20181212155313.GA6502@uda0271908>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4126;6:c+ukgjYbRAFl6/BnIr0wN2onxJccOX25dDW0Dy8mhMDR30JnAN7Cukvz6xhAqiFtE62FgK7yGLmdH54OQbAPn6TVMSON5BIzbF01INW8jhPXsbfRvVhQqwy5REeXu2WRgYv4APJOak1yuMEYjTr/yEiedTlmC5QiUhgxApANvC0GWf9yygOzPEGQIZ7P9PmeToUa0MZpi8Olcm9KrHTCLFF1UElpcdFdH8sTJQhZLWDAJguWf8C9E5voeTQBekd8eKa4jmAflkaH+Q1CuU2oqzrI3NkmSADG2A7GenMyat6ASvZFLdGX/DlnWVFzde9xu+nQb7WCOUIv1BGXgtjH9QvHR/kQP+B4oLUAlWOPcxS/PE3WSlIwWZO59+Hwoq6/pPPUVF3NT+T+rqnyN72JHbIjIlz20JUKFAv0SKJH2J9gDDRGMSIITUI80q/nOPuNGv8faMMeBufEjSq6pCNpOg==;5:mhBtdIOJ4dQQjyr9s95+d1AM8NXOSI1AZ4LvYQ/S0R6vIWwf8slgMdFg1Tvhh5wWm4HcRDzB2hntgUwCmohz9BIRUxbnQfJ8pUCWRG9s7zbNYXfmCYiY3VLODHXPI7Vxy8WQjl4TiZgRafRCzioHedx9pSxnRRmfObHs2M7xUMA=;7:tEVb31NtL6B8KsBvB3qcPvgxzDKelYRpFGupBAxqM3UgNK52wzBLmeUtoNwklSoEeGPK2eSa8zJwytFWyfZN6HvqJ5ZUY3Za7b6rWMYNWM+e6MlEo62WCCPPfymjLhi/yGipkEbJ6wKjL1mz9Gpacg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ee47ee5c-dc10-4f82-83fa-08d660994f96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4126;
x-ms-traffictypediagnostic: VI1PR04MB4126:
x-microsoft-antispam-prvs: <VI1PR04MB4126B518B4FD601D0738C6348BA00@VI1PR04MB4126.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4126;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4126;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(199004)(189003)(25786009)(68736007)(7736002)(26005)(106356001)(55016002)(9686003)(39060400002)(6306002)(478600001)(186003)(105586002)(102836004)(97736004)(966005)(66066001)(99286004)(74316002)(53936002)(7416002)(7696005)(6246003)(76176011)(305945005)(4326008)(54906003)(5660300001)(8676002)(316002)(81156014)(8936002)(110136005)(81166006)(86362001)(14454004)(256004)(71200400001)(3846002)(6506007)(71190400001)(93886005)(229853002)(446003)(33656002)(476003)(6436002)(6116002)(2906002)(11346002)(44832011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4126;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JVFwBzKryhn7pr8P62c1Er0PgpEKTGI1UoauVNgL4q5tT4ZHUgWTYm4ft4PdArHlWs6tJfGrvxvXHoycZatuwYUcxjmzOkFDl5rySZqnrL7mD6w/D7NT4TP2DjSBCmE6S9Hc4wI5GB2zPN7MAIZwSiB3/Kse0EYS1t/Po+NC9vgfXGiREOU6gQA+JbBI0mZx05UaN6A+7TnnBH6pqPw/0A5rBZMsBGQ/FQZ2OUUnWiYaRcuYtc6yJRDqRUjGWSc6p3gJZzOINDQ2m+m5iF6fnki6rOQcuy5yE7JxRDl3AB4S81+W+q4mz00Xk4jku6df
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee47ee5c-dc10-4f82-83fa-08d660994f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:21:29.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >
> > Felipe, I use Dynamic Debug for debugging, and show debug messages
> > with "dmesg" after testing/debugging. I see dwc3 using trace,  any
> > benefits for switching to trace?
>=20
> The benefits I see are
>=20

Thanks, bin.

> - *by default*, the debug log doesn't have to go through uart console,
>   which is slow.
>=20
>   I typically 'cat trace_pipe' from a telnet which is much faster then
>   uart. But Dynamic Debug log by default got printed on uart, I have to
>   set printk level to not print them, which is an extra step.
>=20

It depends on the rootfs's setting. By default, the debug message level sho=
uld be off (
console level =3D 7)

> - tracepoint uses one place to decode the message vs DD has to repeat
>   the similar print statement in the code; and tracepoint decodes it
>   offline which reduce the kernel runtime overhead too.
>=20

offline? You mean when you run "cat trace_pipe"?

> - with tracepoint, it is easier to turn on debug for a specific group of
>   messages.
>=20

The DD can, but we don't do it often.

https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html=
?highlight=3Ddynamic%20debug

> - you can adjust the ftrace buffer size at runtime. can we do that for
>   printk? I don't remember.

It may can't. The log buf can only be changed by bootargs: log_buf_len

Peter
