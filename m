Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeC1IM7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:12:59 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:60732 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750753AbeC1IMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:12:55 -0400
X-IronPort-AV: E=Sophos;i="5.48,370,1517842800";
   d="scan'208";a="275096304"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: open list <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "buserror@gmail.com" <buserror@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: arm/arm64: smp_spin_table.c for arm32?
Thread-Topic: arm/arm64: smp_spin_table.c for arm32?
Thread-Index: AdPGa6oLXXCaTbmtSrmNswDvyh7pSA==
Date: Wed, 28 Mar 2018 08:12:50 +0000
Message-ID: <OSBPR01MB2054DFD1BEECD87186E29E51D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1493;7:kB+IdMckJvKe9pmeo3rTwHyG9WfyoIx3EKLUgTSaS7FQW+VWIH8/vpgfYl1q+HwK++G5CFVzIWgMYzB/B30L8ANoSH88DIFlZIlWbMDR1Jh0blrZLycz4OprFbbGCD9XmHGCBrLFmAue8KFRpqw7LoiQvxGgXJPZQstv2nG+rNCOOo+rRuuwBlwmCJRJHd2cx+sk/W/pL7uHHHVSPIy8l/qqj076trnxtDIFS0fGvj7HBRqp0mGn6vTUtYBBQPEC;20:bEGQ+NIgf9IyEVd1Qku1GUPDq7O0tcXYCA0NZmuzIpAwmUISJjAQraTzF+g7TUQQJCqbpEP/M/VgtUkPxsoDo3ov9CFzFUbZQROrjv4TPqolhyEIt2Tl3PikObeckc2JIRMRNXjQX4Pg6zAvEu+5JGpfNKY63tsesgHIvO9iw+0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faff1825-90e4-48ca-702e-08d59483b30d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1493;
x-ms-traffictypediagnostic: OSBPR01MB1493:
x-microsoft-antispam-prvs: <OSBPR01MB1493113A70F2F7F51A28CD0AD2A30@OSBPR01MB1493.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:OSBPR01MB1493;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1493;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(39380400002)(376002)(366004)(189003)(199004)(8676002)(107886003)(478600001)(102836004)(25786009)(7736002)(3660700001)(105586002)(476003)(97736004)(6506007)(4326008)(39060400002)(5660300001)(6916009)(33656002)(3280700002)(305945005)(2900100001)(6436002)(81156014)(8936002)(86362001)(99286004)(74316002)(26005)(53936002)(6116002)(55016002)(2906002)(14454004)(3846002)(7696005)(186003)(9686003)(316002)(66066001)(81166006)(106356001)(54906003)(68736007)(5250100002)(486005)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1493;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: tifUBH+VZaIQewrxf9XW0ehCct3msGButjuJ9/oO8I2yL8VvwGZFW3qUuv9fb8Zleqz0JvQFZTvfua8oOnZnVV/6ylcP4DBpGIDiSnbgqqOzih1pYk5Vdw++JD1AMssLJVr8T3SNjPH6el/iW8OyjuavxSJMq7kP6H58MjH2rd6eRS1UrUDBJdO/quOpzdIOOh9+43uv531Nqqq1dYnc49Dtr+pGd15k9pQ64+izKVUJbU+kzPBuCvkqN8NeWa7xVonG1ejnqjDXQbtdNfQM06PqoRwZfCTOyCAKINTg+IKDQBVKRNxurfUKKq0ieb35PxkDmS1u3aKLgeJw7tfg6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faff1825-90e4-48ca-702e-08d59483b30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 08:12:50.6390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1493
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2S8D69L031385

Hi guys,

I'm currently adapting a port from a machine-file based approach to driver based, and I
would have a need for arch/arm64/kernel/smp_spin_table.c -- it's *exactly* my use
case, but for arm32.
So what would be my options here?

1) Make myself a custom driver and ignore this one...
2) Fully duplicate smp_spin_table.c in arch/arm/kernel...
3) .... something else involving a shared bit of code?

I obviously would prefer 3), however, I don't see any obvious way of 'sharing' anything
between these two arch...
Any suggestion greatly appreciated!

Regards,
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
