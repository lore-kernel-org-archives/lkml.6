Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755397AbeCSIl2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:41:28 -0400
Received: from mail-os2jpn01on0056.outbound.protection.outlook.com ([104.47.92.56]:57824
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754531AbeCSIlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:41:22 -0400
From: Masaki Ota <masaki.ota@jp.alps.com>
To: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Thread-Topic: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Thread-Index: AQHTulczxYRRXz5ZhkiZvWQ64EtCN6PNOs+AgAJK6BCAANV6AIAACmHQgAJRGICABI5KUA==
Date: Mon, 19 Mar 2018 08:41:19 +0000
Message-ID: <TYXPR01MB0719CA528857480EC046DEF6C7D40@TYXPR01MB0719.jpnprd01.prod.outlook.com>
References: <20180312230915.26050-1-pali.rohar@gmail.com>
 <20180312231335.fnfxgenu22utr3z6@pali>
 <TYXPR01MB0719092EDE164BA6C576A1C7C7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180314225816.634w64kggycj67ec@pali>
 <TYXPR01MB07191C487C66BA03E5D9AB3DC7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180316105811.t2nkwowqs66f6ji6@pali>
In-Reply-To: <20180316105811.t2nkwowqs66f6ji6@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.184.109.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1886;20:vd8DJsqpi3lBN/7SCdo9Gyd33GOPzb/War7VC39nJrQsoxF4F54oTkOgNHRgNv09SqPZqhO//GwAnTB9wEy/g7YHperOEfTw+uOB0NROsW9zmH32HYqtL4ZgHbZrwXAEYKFhokpBwIl6cRABkDmTm8ANQ2y09OEDBQNa3bgC6iU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ca5d2c9-f73c-4053-4b74-08d58d75300d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1886;
x-ms-traffictypediagnostic: TYXPR01MB1886:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masaki.ota@jp.alps.com;
x-microsoft-antispam-prvs: <TYXPR01MB1886358D632221189D2AF2CEC7D40@TYXPR01MB1886.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(9452136761055)(85827821059158)(211171220733660)(9931346810618);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TYXPR01MB1886;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB1886;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(39380400002)(189003)(13464003)(199004)(316002)(53936002)(9686003)(2950100002)(54906003)(97736004)(3846002)(6916009)(305945005)(85182001)(105586002)(93886005)(6436002)(6116002)(33656002)(2900100001)(7736002)(229853002)(86362001)(74316002)(66066001)(55016002)(3660700001)(106356001)(68736007)(6246003)(8936002)(2906002)(14454004)(3280700002)(77096007)(5660300001)(478600001)(26005)(76176011)(7696005)(102836004)(99286004)(8676002)(6506007)(53546011)(345774005)(4326008)(186003)(81156014)(81166006)(59450400001)(25786009)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:TYXPR01MB1886;H:TYXPR01MB0719.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: IZW7T6kyAHP8IMJlisEV8vNPYpZbBUmpOZ5U6FYhmry02PWxP41BdsvHm2zMbkozsrQtpe7vLF8v2CSgwe/cpC7RwE5+YM52IRjy9DrvGjIV4xHLopKEKwrHL13OIaRsB1NRlvr/6/SPlIUBmUr9DlBTLFH/lkzWcfrO69pCO2iGF60obdcrm/UqxhVXVgio7Vb+8nZ21q4JNlZH23rikhqXKHWHpW7Nai2jxnQMSKro45y7hJhPGDbnAHU827jmOKjQ4/aQL4peAZFVXwT1VOQwVCa0lU7aiy7RAQZ+QeFARLt++jyqlrFMIo4j0jv4guSckhIl/53ASTxnr5Pewg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: jp.alps.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca5d2c9-f73c-4053-4b74-08d58d75300d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 08:41:19.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1886
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J8fYHM005744

Hi, Pali,

v3/v6 devices are T3 type, and it can use only Method 2.
P36 (At this time GLIDEPOINT_T3 uses the Method 2 ....)
T3 has the potential that uses Method2, but I think it needs to change Firmware.

Best Regards,
Masaki Ota
-----Original Message-----
From: Pali Rohár [mailto:pali.rohar@gmail.com] 
Sent: Friday, March 16, 2018 7:58 PM
To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3 and v6 protocols

Great, thank you. Enabling that RAW/extended/SP4 mode is done by sequence E6, E6, E6, F3, C8, F3, 14 (written in page 35) and it matches what function alps_trackstick_enter_extended_mode_v3_v6() in my patch is doing. So is correct.

On page 36 I see that there is described Method 1 for reporting stick data which prevents cursor jumps. Seems that kernel uses Method 2.
Method 1 depends on some prioritization.

Do you have some information how to activate Method 1? Sometimes I observe that problem with "cursor jumps" and from Method 1 could prevent it. So I would like to try experimenting...

On Wednesday 14 March 2018 23:56:46 Masaki Ota wrote:
> Hi, Pali,
> 
> I have added Appendix.
> According to this spec documents, SP raw mode is SP 4 byte mode.
> I think Extended mode meaning is almost all the same as Raw mode.
> The description of how to set is written in Page 35.
> 
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Rohár [mailto:pali.rohar@gmail.com]
> Sent: Thursday, March 15, 2018 7:58 AM
> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; 
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization 
> for v3 and v6 protocols
> 
> Hi! Thank you for information.
> 
> Your PS/2 Aux Port Control description seems to really matches. Just there is reverse order of bits. Bit 0 in description is highest, therefore matches BIT(7) macro.
> 
> Bit 6 in description (BIT(1) in code) describes SP Extended Mode which alps.c enabled. And in that description is written:
> 
> "If 1 SP is extended packet format (driver must set SP raw mode and GP absolute mode)."
> 
> Do you have any idea what "SP raw mode" is? How to set it? For me it looks like it could be that extended mode of trackstick itself.
> 
> "GP absolute mode" I guess is GlidePoint absolute mode, therefore 
> enable
> 6 byte absolute mode for touchpad.
> 
> And for Bit 7 (BIT(0)) is written:
> 
> This bit is used with the PS/2 Aux port to use the Pass-Thru mode ( see appendix A ). Do you have some information about this appendix A?
> 
> On Wednesday 14 March 2018 10:21:43 Masaki Ota wrote:
> > Hi, Pali,
> > 
> > I just picked up the spec which relates with trackstic.
> > 
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > Sent: Tuesday, March 13, 2018 8:14 AM
> > To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Dmitry Torokhov 
> > <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Input: alps - Demystify trackstick 
> > initialization for v3 and v6 protocols
> > 
> > Masaki, if you have access to the internal ALPS v3 / Rushmore 
> > documentation, I would like to have a review of this patch or 
> > confirmation of those information :-)
> 
> --
> Pali Rohár
> pali.rohar@gmail.com

--
Pali Rohár
pali.rohar@gmail.com
