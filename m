Return-Path: <prvs=6391b331b=paf@cray.com>
X-Google-Smtp-Source: AIpwx4+66nrqEwSeb54uqSHQDoFUet019B9L4dTucrHTjpf7iAMcKGCNlwjwMzgWs+17wofbSRky
ARC-Seal: i=1; a=rsa-sha256; t=1524025421; cv=none;
        d=google.com; s=arc-20160816;
        b=koHAARFEA+LGbk2Prxm8iSIvg98s7wtV8ovZbJumvZ4QvbiKcRGH/CrPCJtNAUGSas
         GmmxcLmfAl0zpQNzNYHtJtxtVGqWAb0ouDX52awCLQiJiDn192/RQT9QwAK8RwvboJWk
         o8hdHFmqBP6B5JmxpLI6IznphjFEqRLjY745hxDyvAwFQl6lsxQSuZzHim7V8PVYSnYt
         1Esyz/Yy1shdygXaRaVt2oJa1jsBrxgbA+GU4gZdKXYImSEFTeJjt4AmaR755mBpelzP
         sGt8nqed1s7LU+RyaFQqDPLprHZNF04E7GVXflg/GJQ0S9iksxSbzUM6Rbkoz9RnRjBG
         27tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=J951uPxvKOmWsuxAfSTp3rV3h6Wt7yI+KLPnobDitUI=;
        b=0sYpWWoYRwjvyj4ol7Cue0CJYFOrX6kje4zwJ3QH6+HrnAuGRXf+28KtXBvuj03v7V
         W13r8vRF9NTlZcj7WYsTvRmWt6mgJMVy+66Go3th0dhFvCLqtLLVPlgk/GlQzqgEFsAw
         SD3OmUtQQwoVQzRfzY/GUiwjSpH6+yv+g8WdxPWww/CdSJejEDeBZi4+eJ1JsUHXyAo/
         pEoCrfhVtl0XVQnHbXn/AZpXfy+MLo+OFkhClCfcc+BWHztoRSWJX8yd2bB8ll+EZjdc
         ZOWZ+xdYG1/eACBAs6Bf1atrEjnVZ5RKD3R11t2n5whQd6A1MaQB3Zxr/WV3GnCOrgnr
         nv7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=lGZ6PW8m;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=D+piCppc;
       spf=pass (google.com: domain of prvs=6391b331b=paf@cray.com designates 68.232.142.33 as permitted sender) smtp.mailfrom=prvs=6391b331b=paf@cray.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=lGZ6PW8m;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=D+piCppc;
       spf=pass (google.com: domain of prvs=6391b331b=paf@cray.com designates 68.232.142.33 as permitted sender) smtp.mailfrom=prvs=6391b331b=paf@cray.com
X-IronPort-AV: E=Sophos;i="5.48,464,1517875200";
   d="scan'208,217";a="19348922"
X-Cray-OBMMKR: 1433258124 19348922
From: Patrick Farrell <paf@cray.com>
To: NeilBrown <neilb@suse.com>, James Simmons <jsimmons@infradead.org>
CC: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check
 macros to libcfs_debug.h
Thread-Topic: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check
 macros to libcfs_debug.h
Thread-Index: AQHT1RvznGTF9Mlw1kmpPf1j/I5gHqQCwVQAgABvoICAAM08gIAB0aYAgAAd6lU=
Date: Wed, 18 Apr 2018 04:23:34 +0000
Message-ID: <BN7PR11MB2674FEA0BF3CFD9F3EC469F6CBB60@BN7PR11MB2674.namprd11.prod.outlook.com>
References: <152383910760.23409.2327082725637657049.stgit@noble>
 <152383935730.23409.6748888065027051683.stgit@noble>
 <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org>
 <6D3C7935-E7ED-4826-B459-0C4888D6048E@cray.com>
 <alpine.LFD.2.21.1804162336220.14398@casper.infradead.org>,<877ep5s0wb.fsf@notabene.neil.brown.name>
In-Reply-To: <877ep5s0wb.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=cray.com;
x-originating-ip: [2607:fb90:997a:849f:49df:d265:e4b:f1b3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR11MB2673;7:A+Bu5ffYKv7Cs2AEuiQDZZLvi7RyWaJHSYGRdrcjpz5mMGLYqC7hBfi/hMG4xznZcHyJ3J2nMHgaNnlWD0rjE6d/l5wiHFIHpVFIEhsEqbDJ75MBwjbHZwSFVKFxt/JMefXoBcv0D+N9LxGlz+G0/JZVE/3/CQ86VPjcqS6Tyxqj7po6GvIdB1ehLY8Sst+g6jVChzHGAwMKYdfqZ8vdcTDSSxZNDPnSEqIZST2G9f3rb0YXt43fGFsriylKXKn+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR11MB2673;
x-ms-traffictypediagnostic: BN7PR11MB2673:
x-microsoft-antispam-prvs: <BN7PR11MB267357E9DCED56AAD8A177E9CBB60@BN7PR11MB2673.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN7PR11MB2673;BCL:0;PCL:0;RULEID:;SRVR:BN7PR11MB2673;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(346002)(376002)(366004)(39380400002)(54896002)(9686003)(6506007)(76176011)(229853002)(102836004)(53546011)(59450400001)(5660300001)(14454004)(476003)(74316002)(99286004)(446003)(11346002)(55016002)(81166006)(7736002)(2906002)(8676002)(46003)(4326008)(186003)(7696005)(6436002)(25786009)(86362001)(5250100002)(33656002)(8936002)(54906003)(316002)(6116002)(93886005)(2900100001)(478600001)(13693001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2673;H:BN7PR11MB2674.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: Rr5AgXXDyu0+HKmiTSjqc1tHvl72hZLlnIxGJAkBQZ/v48nFLTlcJ2cKbP7WbM8nZ0xzFSuM88f1KeZSD3BeOJUhBjwGrsZ+OFmAnKhMxBefL46terksE0kioAZT/X8bWX9G/VB/JcDW1RlGqzOuddsCJhu6cfewh3Chi3kTe4rKx2CkfsjbsGXEFRA4n43u
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/alternative;
	boundary="_000_BN7PR11MB2674FEA0BF3CFD9F3EC469F6CBB60BN7PR11MB2674namp_"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0dd9dab4-c8cc-4068-93aa-08d5a4e426ab
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd9dab4-c8cc-4068-93aa-08d5a4e426ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 04:23:34.9820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2673
X-OriginatorOrg: cray.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1598056479675631454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--_000_BN7PR11MB2674FEA0BF3CFD9F3EC469F6CBB60BN7PR11MB2674namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Of course - I=92m no fan of keeping the Lustre specific stuff long term.  I=
t has a few pretty powerful tricks embedded in it (others can describe them=
 better but, for example, it has per CPU debug buffers and if configured, i=
t can halt all CPUs but one and write out all the buffers before panicking)=
, but it=92s mostly just a set of messages controlled by a pair of message =
specific and file-level (subsystem_debug) masks.

And it should all use generic kernel infrastructure, absolutely.  There=92s=
 been interest in that for a long time but never the right combination of e=
xpertise and will.

________________________________
From: NeilBrown <neilb@suse.com>
Sent: Tuesday, April 17, 2018 9:29:08 PM
To: James Simmons; Patrick Farrell
Cc: Oleg Drokin; Greg Kroah-Hartman; Linux Kernel Mailing List; Lustre Deve=
lopment List
Subject: Re: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check m=
acros to libcfs_debug.h

On Mon, Apr 16 2018, James Simmons wrote:

>> James,
>>
>> If I understand correctly, you're saying you want to be able to build wi=
thout debug support...?  I'm not convinced that building a client without d=
ebug support is interesting or useful.  In fact, I think it would be harmfu=
l, and we shouldn't open up the possibility - this is switchable debug with=
 very low overhead when not actually "on".  It would be really awful to get=
 a problem on a running system and discover there's no debug support - that=
 you can't even enable debug without a reinstall.
>>
>> If I've understood you correctly, then I would want to see proof of a si=
gnificant performance cost when debug is built but *off* before agreeing to=
 even exposing this option.  (I know it's a choice they'd have to make, but=
 if it's not really useful with a side order of potentially harmful, we sho=
uldn't even give people the choice.)
>
> I'm not saying add the option today but this is more for the long game.
> While the Intel lustre developers deeply love lustre's debugging
> infrastructure I see a future where something better will come along to
> replace it. When that day comes we will have a period where both
> debugging infrastructurs will exist and some deployers of lustre will
> want to turn off the old debugging infrastructure and just use the new.
> That is what I have in mind. A switch to flip between options.

My position on this is that lustre's debugging infrastructure (in
mainline) *will* be changed to use something that the rest of the kernel
can and does use.  Quite possibly that "something" will first be
enhanced so that it is as powerful and useful as what lustre has.
I suspect this will partly be pr_debug(), partly WARN_ON(), partly trace
points.  But I'm not very familiar with tracepoints or with lustre
debugging yet so this is far from certain.
pr_debug() and tracepoints can be compiled out, but only kernel-wide.
There is no reason for lustre to be special there.  WARN_ON() and
BUG_ON() cannot be compiled out, but BUG_ON() must only be used when
proceeding is unarguably worse than crashing the machine.  In recent
years a lot of BUG_ON()s have been removed or changed to warnings.  We
need to maintain that attitude.

I don't like the idea of have two parallel debuging infrastructures that
you can choose between - it encourages confusion and brings no benefits.

Thanks,
NeilBrown

--_000_BN7PR11MB2674FEA0BF3CFD9F3EC469F6CBB60BN7PR11MB2674namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<br>
Of course - I=92m no fan of keeping the Lustre specific stuff long term.&nb=
sp; It has a few pretty powerful tricks embedded in it (others can describe=
 them better but, for example, it has per CPU debug buffers and if configur=
ed, it can halt all CPUs but one and write
 out all the buffers before panicking), but it=92s mostly just a set of mes=
sages controlled by a pair of message specific and file-level (subsystem_de=
bug) masks.<br>
<br>
And it should all use generic kernel infrastructure, absolutely.&nbsp; Ther=
e=92s been interest in that for a long time but never the right combination=
 of expertise and will.<br>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> NeilBrown &lt;neilb@s=
use.com&gt;<br>
<b>Sent:</b> Tuesday, April 17, 2018 9:29:08 PM<br>
<b>To:</b> James Simmons; Patrick Farrell<br>
<b>Cc:</b> Oleg Drokin; Greg Kroah-Hartman; Linux Kernel Mailing List; Lust=
re Development List<br>
<b>Subject:</b> Re: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-=
check macros to libcfs_debug.h</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Apr 16 2018, James Simmons wrote:<br>
<br>
&gt;&gt; James,<br>
&gt;&gt; <br>
&gt;&gt; If I understand correctly, you're saying you want to be able to bu=
ild without debug support...?&nbsp; I'm not convinced that building a clien=
t without debug support is interesting or useful.&nbsp; In fact, I think it=
 would be harmful, and we shouldn't open up the
 possibility - this is switchable debug with very low overhead when not act=
ually &quot;on&quot;.&nbsp; It would be really awful to get a problem on a =
running system and discover there's no debug support - that you can't even =
enable debug without a reinstall.<br>
&gt;&gt; <br>
&gt;&gt; If I've understood you correctly, then I would want to see proof o=
f a significant performance cost when debug is built but *off* before agree=
ing to even exposing this option.&nbsp; (I know it's a choice they'd have t=
o make, but if it's not really useful with
 a side order of potentially harmful, we shouldn't even give people the cho=
ice.)<br>
&gt;<br>
&gt; I'm not saying add the option today but this is more for the long game=
.<br>
&gt; While the Intel lustre developers deeply love lustre's debugging <br>
&gt; infrastructure I see a future where something better will come along t=
o<br>
&gt; replace it. When that day comes we will have a period where both<br>
&gt; debugging infrastructurs will exist and some deployers of lustre will<=
br>
&gt; want to turn off the old debugging infrastructure and just use the new=
.<br>
&gt; That is what I have in mind. A switch to flip between options.<br>
<br>
My position on this is that lustre's debugging infrastructure (in<br>
mainline) *will* be changed to use something that the rest of the kernel<br=
>
can and does use.&nbsp; Quite possibly that &quot;something&quot; will firs=
t be<br>
enhanced so that it is as powerful and useful as what lustre has.<br>
I suspect this will partly be pr_debug(), partly WARN_ON(), partly trace<br=
>
points.&nbsp; But I'm not very familiar with tracepoints or with lustre<br>
debugging yet so this is far from certain.<br>
pr_debug() and tracepoints can be compiled out, but only kernel-wide.<br>
There is no reason for lustre to be special there.&nbsp; WARN_ON() and<br>
BUG_ON() cannot be compiled out, but BUG_ON() must only be used when<br>
proceeding is unarguably worse than crashing the machine.&nbsp; In recent<b=
r>
years a lot of BUG_ON()s have been removed or changed to warnings.&nbsp; We=
<br>
need to maintain that attitude.<br>
<br>
I don't like the idea of have two parallel debuging infrastructures that<br=
>
you can choose between - it encourages confusion and brings no benefits.<br=
>
<br>
Thanks,<br>
NeilBrown<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN7PR11MB2674FEA0BF3CFD9F3EC469F6CBB60BN7PR11MB2674namp_--
