Return-Path: <dcb314@hotmail.com>
X-Google-Smtp-Source: AH8x227f2tVBYvYFE2Zc0Oh3JjVhYExIe4a29eIrrTG+Cw1/gq3RNZnw7HIP2OcdAP1w6rll7PnF
ARC-Seal: i=1; a=rsa-sha256; t=1518425893; cv=none;
        d=google.com; s=arc-20160816;
        b=T5jrXl0650JrIgTCjwYr5OOjoKuwsV/EG/mDHMdkcv1JOk5PCrDAK5yUOAtr5LP99/
         S+lQXyoQ20/pr6c9DydoYIGOMVB0338C+qtLQkd/3i0KwPUiV8FoWxU6BS9EWldZOO3s
         oRAC5ogHBg/m7ipY0klLDup4gg4bk77EOKFszZSgnMO8ey+dtG1mO95/gL/gXb6qFjHu
         OWfoFvFE9zDBd8jK8vDtwlf4xxFs0RZyz9317LZ1i2j5znUDTZyY1IIbxrHLlDfntn14
         w87blAPbJPZiUDBK0UGzZFtoMfqVjks1SoJ0p+WDrHn2kExT6EYjwvW0RghNBHLDhd2N
         nXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:accept-language:message-id:date:thread-index
         :thread-topic:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=MJSRBsXqncufCxeMU1jWoWYCnZT6f1L4Ah+yegzY53o=;
        b=dg4UFhJE32VL+2Hl529EBTZ8KEgHmCxroloudUKyVF4vlLI0Qgy6iJ5WLsqyqSNEct
         OaEgA/7+CAkWYci1ZiPTo9Kt/Z+/DjSKfSgUnLt8W5wxjIWyOXY6jIXDgerhsEe8Q1rG
         JC1puR0C4qbKtEUiwi0U9q8v3qi3zv4vj4DEU/YarDWuZ9cuXLHCjYlFGzqFSX7Gt6k6
         1mrIa+pq1v+Q+KRrXaywS5svC1KogCb1akGATASXQn8W0hDjbE07pFJYiDm5x7GNokoJ
         cKZzHmvUAgljr6daQkg6b8Is/8iJtcB7TnwzV0Ea/GnXglw9B7ESZQU2OeyFCzG3ZxkD
         885Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@hotmail.com header.s=selector1 header.b=bDRoTWGA;
       spf=pass (google.com: domain of dcb314@hotmail.com designates 40.92.68.46 as permitted sender) smtp.mailfrom=dcb314@hotmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=hotmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@hotmail.com header.s=selector1 header.b=bDRoTWGA;
       spf=pass (google.com: domain of dcb314@hotmail.com designates 40.92.68.46 as permitted sender) smtp.mailfrom=dcb314@hotmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=hotmail.com
From: David Binderman <dcb314@hotmail.com>
To: "fbarrat@linux.vnet.ibm.com" <fbarrat@linux.vnet.ibm.com>,
	"andrew.donnellan@au1.ibm.com" <andrew.donnellan@au1.ibm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: linux-4.16-rc1/drivers/misc/ocxl/file.c:320:broken error checking ?
Thread-Topic: linux-4.16-rc1/drivers/misc/ocxl/file.c:320:broken error
 checking ?
Thread-Index: AQHTo98nRDtSdzhcWU2uBiULTAMmWw==
Date: Mon, 12 Feb 2018 08:58:10 +0000
Message-ID: <HE1PR0802MB23312F7C9FFE65D802F9D0259CF70@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:782AA256940272223DC26F17CF1659D7A3B5E00E100E24D58D3218F266F90A9B;UpperCasedChecksum:D0D184A2F327616523249F75DB6A5DB4E5D0D6A1D2A7CD6D4ED894593A58158B;SizeAsReceived:7264;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [6jFnY4Ib/BXTVgvvJy0iT6NxZwH+iRVd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR02HT126;6:T73WF9HzOulFmQp8pFWtSEd3X5+57CCd932o1eWrSn015FBE8ouX58azz7CupxC/HBC4o3BoXdOBf0C4H3z3rKI/yxNmw2VE3EIpHRN1S7Rarc+GQPpqeeproTsHioHiB6VrkEWAvFkPgwFTi8DiBLQAS6TqqE8G/vfYoJ133JgFNoxKBIBo6IkDWv6YptlY56WVWdTkn53a9QxwcBVfyKSKorHqErdSEgXf6u8zr6kLjj+LCHr0hki40gsoSxa3RMZTzAm/w6if5uBJFZePpTxDwJlQcDfYYlkoG/xPkM0k2rIUir/qWDtVRo5FixuozFJeGc9fxzl2xt3JF30h8RzQN0iPfU7kOSJXVtv1Q9w=;5:0iuagdEL6pHMaPvMQDMSL4wqTdI2mIpCkmmmK7Bx72SCtf6WMadbZeInvHdQu4dgREH1U1vqPaA+tKxWHqueJA/ANvjHo0S9+JLJ+QdYoZOV1GdTUL/2NUeCDNnK6Ll9Zf/aIVHNu0f/phCyZoZzPsEhF2twsWqrZfFkFhsJxRA=;24:gEb7/alpQmNRNcyeVMjBqypYVmw3E+wyh0Pz9KNL7QtSkeAZLStPPG3RL8Sx45R6cg2DTMPr++fOGloq0cC5TxLpOjO6afrcEX5mOtXWGnU=;7:kq3ak1JIlk2mZl8Gx0SQRkFxrSl75pEGx6a48dRgyFUHY1K9MHQQx4TC2o/X3wwyT+7qu9tE7Ey5q7T6+5zGta/w1SWUvSs/uOYtn4y7o9QvxD4aGtmEqdYQkoOTZpWAXI1w6qCWnhgtIWTSjYxw+eg6Wg0hjBPBlQUTyKM6EdJvG8gAXdmZesd27keo1JzKixPUCb2yEAHivYzMrHPwtoYLEwDfcXwi8qLcb+ae/5DxA13ee9GV7+kxEapuD98F
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061074)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101448)(1601125374)(1701031045);SRVR:VE1EUR02HT126;
x-ms-traffictypediagnostic: VE1EUR02HT126:
x-ms-office365-filtering-correlation-id: 3a4377f0-8ab5-4350-b73c-08d571f6be39
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(444000031);SRVR:VE1EUR02HT126;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT126;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(98901004);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR02HT126;H:HE1PR0802MB2331.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/alternative;
	boundary="_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_"
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4377f0-8ab5-4350-b73c-08d571f6be39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 08:58:10.9358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT126
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592184949792413225?=
X-GMAIL-MSGID: =?utf-8?q?1592184949792413225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello there,


linux-4.16-rc1/drivers/misc/ocxl/file.c:320]: (style) Checking if unsigned =
variable 'used' is less than zero.

Source code is


       used =3D append_xsl_error(ctx, &header, buf + sizeof(header));
        if (used < 0)
            return used;

Suggest put return value from function into signed variable, sanity check i=
t,

then assign it to an unsigned variable.


Also, use of the gcc compiler flag -Wtype-limits will show up this kind of =
problem in future.


Regards


David Binderman


--_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hello there,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>linux-4.16-rc1/drivers/misc/ocxl/file.c:320]: (style) Checking if unsi=
gned variable 'used' is less than zero.<br>
<br>
</div>
Source code is
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used =3D append_xsl_error(ctx, &a=
mp;header, buf &#43; sizeof(header));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return u=
sed;<br>
<br>
</div>
Suggest put return value from function into signed variable, sanity check i=
t,
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">then assign it to an unsigned var=
iable.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Also, use of the gcc compiler fla=
g -Wtype-limits will show up this kind of problem in future.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">David Binderman</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
</body>
</html>

--_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_--
