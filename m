Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeDEHWX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:22:23 -0400
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:38496 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDEHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:22:20 -0400
X-Iguazu-Qid: 34tMe9Tnp4ADxbP7Mf
X-Iguazu-QSIG: v=1; s=0; t=1522910439; q=34tMe9Tnp4ADxbP7Mf; m=3sZHinJnENv9eD4T2jTzoMa/fHTxJWBAeEd35+pE67g=
From: <shinya1.takumi@toshiba.co.jp>
To: <serge@hallyn.com>, <jmorris@namei.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v3 0/2] WhiteEgret LSM module
Thread-Topic: [RFC v3 0/2] WhiteEgret LSM module
Thread-Index: AQHTyAJOnQ+9r2edhk+NYvbIB0nAd6PsWl+AgAVlmJA=
Date: Thu, 5 Apr 2018 06:40:36 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
 <20180401200827.GA28101@mail.hallyn.com>
In-Reply-To: <20180401200827.GA28101@mail.hallyn.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinya1.takumi@toshiba.co.jp;
x-originating-ip: [103.91.184.160]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1783;7:N31ltt3CfCwifRJnRsWdj07mvBRAJ8EG4ggk0h9iFuCGQHbUnFaJPs9EJcMgkunzNLYc/f/LYZviZBSJxISzmg3x0n51tmu4FveHDH43Pshm8iaUKNVRBfsVNoW0MAZBfu/WfmUbX60HWOJhEgLY1H1xZggRTH6tHt4VExXqNQr6zszQrLrxC3ixyaxTRfc2vHkZLUaMyCjPiRjcGChvdGcXVwWtTWMoVg7H+l1qmUvGl4BLgGnor4YJK0Yw/2Mm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ceb3ecd5-cb50-4267-8d23-08d59ac02376
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1783;
x-ms-traffictypediagnostic: OSBPR01MB1783:
x-microsoft-antispam-prvs: <OSBPR01MB17835B3DB9E08011412CD40E92BB0@OSBPR01MB1783.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB1783;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1783;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39850400004)(376002)(366004)(346002)(199004)(189003)(13464003)(476003)(2900100001)(3280700002)(2906002)(3846002)(186003)(26005)(55016002)(9686003)(6116002)(478600001)(33656002)(25786009)(68736007)(76176011)(5250100002)(305945005)(7736002)(486006)(97736004)(3660700001)(2501003)(110136005)(316002)(966005)(8936002)(7696005)(6306002)(102836004)(14454004)(81166006)(86362001)(53936002)(53546011)(11346002)(99286004)(6246003)(105586002)(446003)(74316002)(59450400001)(106356001)(66066001)(74482002)(81156014)(2201001)(6506007)(6436002)(5660300001)(229853002)(8676002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB1783;H:OSBPR01MB2184.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gPB7zXChjhbuMGeeuE7ESgAZ64UeHgcesluIoz6ag+W4Ilt3TqCM+eCq3kYhX7DJ2MeL3qW5dJfgWbUocSMVHp3D5qlHFO1wQwmeYz/xUBFhIcUS5C53ZCPhSOFEGof1m58z6OIQ0ldH1Omz/zb5Bg0aB4EQj8Gai+g5/36GWqpCWKU8ZhZ5Rm76LdV8m2SLWrAiAALKN51hvw+TUtuMOFrlPvRX1Bgnj3xgvYEiYNwy6mi1UiyydoZC6V8pvFXmlM2rLGq2OWUOumzAwiiJ1VMYUiuPxfT/HiY1SqYSAVe2Ylea3X8emjwyWDz5wsKfyQjoGlg2xCuh+5vMYC4ZTP5by43m8s532nL2JSr664KeIE88YxHmQ052mR1TpxWK+wZLqBE/tPR3E3/PGLSiCQCpGDhMcHIYVu67cfpb6lA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb3ecd5-cb50-4267-8d23-08d59ac02376
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 06:40:36.1694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1783
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w357MTfB032162

I am one of developers of WhiteEgret.

> regardling the last one, do you have a plan for handling it?
Yes, we have a plan to release WhiteEgret v4 patch with a WEUA sample of access control for script programs.

The latest WhiteEgret cannot control script programs since script files read by an interpreter are not hooked by the execve system call.
We consider that script programs can be controlled by controlling the files inputted by interpreters, accordingly. 
We consider that the control can be realized using the read system call hooking.

Now, we are developing WhiteEgret with the read system call hooking and WEUA which controls the script files to be read to interpreters using information from the read system call hooking and white list.

-----Original Message-----
From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-security-module@vger.kernel.org] On Behalf Of Serge E. Hallyn
Sent: Monday, April 2, 2018 5:08 AM
To: koike masanobu(小池 正修 ＴＤＳＬ （ＩＳＥＣ）［ＳＥＣ運］) <masanobu2.koike@toshiba.co.jp>
Cc: jmorris@namei.org; serge@hallyn.com; linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 0/2] WhiteEgret LSM module

Quoting Masanobu Koike (masanobu2.koike@toshiba.co.jp):
...
> Assumptions and ToDos
> 
> At this stage, WhiteEgret assumes the following.
> Relaxing these assumptions are future works.
> - Root is not compromised. And using a whitelist and a WEUA requires 
> root privilege.
> - WEUA is reliable.
> - It is allowed for scripting languages, e.g., Perl or Python, to read 
> arbitrary scripts and to execute them.

Hi,

regardling the last one, do you have a plan for handling it?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
