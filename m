Return-Path: <prvs=6620279be=doucharek@cray.com>
X-Google-Smtp-Source: AB8JxZqAtcOIlrs5mbJnRdpn0+PXsYMd+KW5h+CK1yrb8CS3+hr5M8vxMxcVRB2EedbLkOmSlQ5D
ARC-Seal: i=1; a=rsa-sha256; t=1526005831; cv=none;
        d=google.com; s=arc-20160816;
        b=B6yCDQXPy82z1BKuUtL1a2C/v554S+LlGOmzdsC8wBfJp46ijruxWPrvIKfnNvZ5fF
         2q2sFLAqiAbtbc3HZ5JnZN0U7+e3L2DRlvYjtMjIPOHP/crke456ojI/cJ0hNwH9LaKv
         giAcb2DWqeQnVoinkJUU5oIvoljKKTiv2pp0WKWAdD34IqeMDikYdICgF+cLgIQcJ/x2
         eAuCijU6ekF4gp9DefUEDcJynWy6XA1KKZ11uNikIw+jMgABuZy8wrY8pJrVo4KU/Foe
         +UhUtrG8Wx6qVp2gG5THeZiJk2LRIudYGGrwb79QjxvD9647RaY/O1VDXtOtWCfWIQMR
         6Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=V7C4CgYAeptZ6LhrGdeakeKK7SSUZggaraZy0ISzx34=;
        b=kZNqas0kFrsowcql/0eaB4MkChLrrlu0rf2ioniW8L24E+3iENls5y1GkoMCYHPSzM
         BkKZVcjZx76fJlKrN0bhoAaW/uDCC+0hZNOZwYSb70DvQpJ84NE+3CNWvOmAsae8oeGP
         uJdETEckuKIC/wtf4uKq4ivqZMo0olGYAJMBuW+S/HoqF14AzOF0YFztduN+8AtspbtU
         6a5I5jqLvWyiTf8qkIFZZVA1YofKnU+1ao++vgIVrjGp5vgCG97HVCmycrAYRn+uAfE7
         vftRnWitItjMBhfMvMuGbulB9wnRhoD9udw22N5G2xcknQWZJ8Byn4vmYJjGfvXKyYC2
         36ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=BEpFkeoe;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=gnLmfKAF;
       spf=pass (google.com: domain of prvs=6620279be=doucharek@cray.com designates 68.232.142.33 as permitted sender) smtp.mailfrom=prvs=6620279be=doucharek@cray.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=BEpFkeoe;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=gnLmfKAF;
       spf=pass (google.com: domain of prvs=6620279be=doucharek@cray.com designates 68.232.142.33 as permitted sender) smtp.mailfrom=prvs=6620279be=doucharek@cray.com
X-IronPort-AV: E=Sophos;i="5.49,387,1520899200";
   d="scan'208,217";a="19832601"
X-Cray-OBMMKR: 1433258124 19832601
From: Doug Oucharek <doucharek@cray.com>
To: NeilBrown <neilb@suse.com>
CC: Doug Oucharek <dougso@me.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "devel@driverdev.osuosl.org"
	<devel@driverdev.osuosl.org>, Oleg Drokin <oleg.drokin@intel.com>, "Andreas
 Dilger" <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Lustre
 Development List" <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
Thread-Topic: [lustre-devel] [PATCH] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
Thread-Index: AQHT6CE7hbk4d2rE70WArAG4r5q8b6QptKWAgAAbHQA=
Date: Fri, 11 May 2018 02:30:25 +0000
Message-ID: <43C26C25-BF67-4CDA-90FA-65F3208FD274@cray.com>
References: <1525930679-15227-1-git-send-email-dougso@me.com>
 <87a7t79fnk.fsf@notabene.neil.brown.name>
In-Reply-To: <87a7t79fnk.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=doucharek@cray.com;
x-originating-ip: [136.162.66.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1278;7:INIIBADV3DW1mpkF1uCyZ8rp4k9dmrWUdPX1E2vbazHuSJNcgtRXFQoFAoGMk3nxCtdOI5uPilktk7lzvBlDKJNKYra+zHTcO/A5mRg7lILapd/lCMDuoYFO7VKtt6QeFEAvhEGywidMzI7swbe6kojiLpRIUpIsuIZpmVXrHl5Dx8GqwvUgTwGtcEG62dSdNeKRvPJYV6+hTOQ4ieoS4NCSOoreWwqgXTAWreexrPW2MgUf2Mdb102qXdj18iL5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1278;
x-ms-traffictypediagnostic: MWHPR11MB1278:
x-microsoft-antispam-prvs: <MWHPR11MB1278A0945EE2323EBDB9E996D49F0@MWHPR11MB1278.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(188474585043545)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR11MB1278;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1278;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(376002)(396003)(39850400004)(189003)(199004)(446003)(76176011)(229853002)(97736004)(2616005)(99286004)(105586002)(606006)(86362001)(54896002)(82746002)(186003)(478600001)(2906002)(26005)(106356001)(11346002)(6486002)(14454004)(25786009)(6512007)(59450400001)(3846002)(6506007)(486006)(6306002)(4326008)(83716003)(6116002)(6916009)(53546011)(39060400002)(476003)(6436002)(8656006)(68736007)(102836004)(33656002)(6246003)(2900100001)(7736002)(236005)(66066001)(8676002)(36756003)(8936002)(5660300001)(966005)(81156014)(81166006)(5250100002)(316002)(54906003)(3280700002)(53936002)(3660700001)(13693001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1278;H:MWHPR11MB2029.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y566OpCTgzGI34u89MQz3ADHVHS2DMSMNgWdpWu+pI8j5Q0nzxlQlU+kTjAyQm6klSe9TKXGTXlEs4eD8JS9H7iY4alw8NP2lHAV2jynMF/IjgxXUwbwZCCJruO5MGNiMM+5AwThZX2aEvxk0LY4dpggkVY4HXJkcl98c0I5+SmvxTifBOKajKY66uVP7oZe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/alternative;
	boundary="_000_43C26C25BF674CDA90FA65F3208FD274craycom_"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 721a5650-3a7a-4b48-e886-08d5b6e7279b
X-MS-Exchange-CrossTenant-Network-Message-Id: 721a5650-3a7a-4b48-e886-08d5b6e7279b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 02:30:26.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1278
X-OriginatorOrg: cray.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600054330533284968?=
X-GMAIL-MSGID: =?utf-8?q?1600133091434397511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--_000_43C26C25BF674CDA90FA65F3208FD274craycom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I did a v2 of this patch already.

Changing to the safe version of the list macros is a mixed bag.

Doug

On May 10, 2018, at 5:53 PM, NeilBrown <neilb@suse.com<mailto:neilb@suse.co=
m>> wrote:

On Wed, May 09 2018, Doug Oucharek wrote:

Under upstream staging commit 5a2ca43fa54f561c252c2, the list handling
code in kiblnd_handle_early_rxs() got changed to list_for_each_safe().
That protects against the current thread from deleting the current entry
it is looking at. It does not protect against another thread from deleting
the next item in the list (which the tmp variable points to). The way this
routine holds then releases a lock opens the door to other threads doing
just that.

This patch reverts this commit on this routine.

Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9886
Signed-off-by: Doug Oucharek <dougso@me.com<mailto:dougso@me.com>>
---
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 5 +++--
1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drive=
rs/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 32fa8ca..6148fbb 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1965,13 +1965,14 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *c=
mid,
{
unsigned long flags;
struct kib_rx *rx;
- struct kib_rx *tmp;

LASSERT(!in_interrupt());
LASSERT(conn->ibc_state >=3D IBLND_CONN_ESTABLISHED);

write_lock_irqsave(&kiblnd_data.kib_global_lock, flags);
- list_for_each_entry_safe(rx, tmp, &conn->ibc_early_rxs, rx_list) {
+ while (!list_empty(&conn->ibc_early_rxs)) {
+ rx =3D list_entry(conn->ibc_early_rxs.next,
+ kib_rx_t, rx_list);
Should be:
                        struct kib_tx

Otherwise,
Reviewed-by: NeilBrown <neilb@suse.com<mailto:neilb@suse.com>>

Those "convert lots of list_for_each" things really do need
careful review, don't they :-(

Thanks,
NeilBrown

list_del(&rx->rx_list);
write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);

--
1.8.3.1

_______________________________________________
lustre-devel mailing list
lustre-devel@lists.lustre.org<mailto:lustre-devel@lists.lustre.org>
http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
_______________________________________________
lustre-devel mailing list
lustre-devel@lists.lustre.org<mailto:lustre-devel@lists.lustre.org>
http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org


--_000_43C26C25BF674CDA90FA65F3208FD274craycom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <7E6B1C4770307E4C92E2E92040D7E7B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
I did a v2 of this patch already.&nbsp;
<div class=3D""><br class=3D"">
</div>
<div class=3D"">Changing to the safe version of the list macros is a mixed =
bag.&nbsp;</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">Doug</div>
<div class=3D""><br class=3D"">
<div>
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On May 10, 2018, at 5:53 PM, NeilBrown &lt;<a href=3D"mailt=
o:neilb@suse.com" class=3D"">neilb@suse.com</a>&gt; wrote:</div>
<br class=3D"Apple-interchange-newline">
<div class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float=
: none; display: inline !important;" class=3D"">On
 Wed, May 09 2018, Doug Oucharek wrote:</span><br style=3D"font-family: Hel=
vetica; font-size: 12px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px;" class=3D"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: normal; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" class=3D"">
Under upstream staging commit 5a2ca43fa54f561c252c2, the list handling<br c=
lass=3D"">
code in kiblnd_handle_early_rxs() got changed to list_for_each_safe().<br c=
lass=3D"">
That protects against the current thread from deleting the current entry<br=
 class=3D"">
it is looking at. It does not protect against another thread from deleting<=
br class=3D"">
the next item in the list (which the tmp variable points to). The way this<=
br class=3D"">
routine holds then releases a lock opens the door to other threads doing<br=
 class=3D"">
just that.<br class=3D"">
<br class=3D"">
This patch reverts this commit on this routine.<br class=3D"">
<br class=3D"">
Intel-bug-id: <a href=3D"https://jira.hpdd.intel.com/browse/LU-9886" class=
=3D"">https://jira.hpdd.intel.com/browse/LU-9886</a><br class=3D"">
Signed-off-by: Doug Oucharek &lt;<a href=3D"mailto:dougso@me.com" class=3D"=
">dougso@me.com</a>&gt;<br class=3D"">
---<br class=3D"">
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 5 &#43;&#43;&#43;-=
-<br class=3D"">
1 file changed, 3 insertions(&#43;), 2 deletions(-)<br class=3D"">
<br class=3D"">
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drive=
rs/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c<br class=3D"">
index 32fa8ca..6148fbb 100644<br class=3D"">
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c<br class=3D"">
&#43;&#43;&#43; b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c<br=
 class=3D"">
@@ -1965,13 &#43;1965,14 @@ static int kiblnd_resolve_addr(struct rdma_cm_i=
d *cmid,<br class=3D"">
{<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>unsigned =
long flags;<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>struct ki=
b_rx *rx;<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>struct =
kib_rx *tmp;<br class=3D"">
<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>LASSERT(!=
in_interrupt());<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>LASSERT(c=
onn-&gt;ibc_state &gt;=3D IBLND_CONN_ESTABLISHED);<br class=3D"">
<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>write_loc=
k_irqsave(&amp;kiblnd_data.kib_global_lock, flags);<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>list_fo=
r_each_entry_safe(rx, tmp, &amp;conn-&gt;ibc_early_rxs, rx_list) {<br class=
=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>whi=
le (!list_empty(&amp;conn-&gt;ibc_early_rxs)) {<br class=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>rx =3D list_=
entry(conn-&gt;ibc_early_rxs.next,<br class=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span>kib_rx_t,
 rx_list);<br class=3D"">
</blockquote>
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">Should
 be:</span><br style=3D"font-family: Helvetica; font-size: 12px; font-style=
: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: n=
ormal; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;struct
 kib_tx</span><br style=3D"font-family: Helvetica; font-size: 12px; font-st=
yle: normal; font-variant-caps: normal; font-weight: normal; letter-spacing=
: normal; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D=
"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: normal; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">Otherwise,</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">Reviewed-by:
 NeilBrown &lt;</span><a href=3D"mailto:neilb@suse.com" style=3D"font-famil=
y: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: norma=
l; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; widows:=
 auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stro=
ke-width: 0px;" class=3D"">neilb@suse.com</a><span style=3D"font-family: He=
lvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">&gt;</span><br style=3D"font-family: Helvetica; font-size: 12px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"=
">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: normal; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">Those
 &quot;convert lots of list_for_each&quot; things really do need</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">careful
 review, don't they :-(</span><br style=3D"font-family: Helvetica; font-siz=
e: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width=
: 0px;" class=3D"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: normal; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">Thanks,</span><br style=3D"font-family: Hel=
vetica; font-size: 12px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">NeilBrown</span><br style=3D"font-family: H=
elvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; f=
ont-weight: normal; letter-spacing: normal; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit=
-text-stroke-width: 0px;" class=3D"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant-caps: normal; font-weight: normal; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>list_del(&amp;rx-&=
gt;rx_list);<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>write_unlock_irqre=
store(&amp;kiblnd_data.kib_global_lock, flags);<br class=3D"">
<br class=3D"">
--<span class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">
1.8.3.1<br class=3D"">
<br class=3D"">
_______________________________________________<br class=3D"">
lustre-devel mailing list<br class=3D"">
<a href=3D"mailto:lustre-devel@lists.lustre.org" class=3D"">lustre-devel@li=
sts.lustre.org</a><br class=3D"">
<a href=3D"http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org" cl=
ass=3D"">http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org</a><b=
r class=3D"">
</blockquote>
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">___________________________________________=
____</span><br style=3D"font-family: Helvetica; font-size: 12px; font-style=
: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: n=
ormal; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display:=
 inline !important;" class=3D"">lustre-devel
 mailing list</span><br style=3D"font-family: Helvetica; font-size: 12px; f=
ont-style: normal; font-variant-caps: normal; font-weight: normal; letter-s=
pacing: normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" cl=
ass=3D"">
<a href=3D"mailto:lustre-devel@lists.lustre.org" style=3D"font-family: Helv=
etica; font-size: 12px; font-style: normal; font-variant-caps: normal; font=
-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-widt=
h: 0px;" class=3D"">lustre-devel@lists.lustre.org</a><br style=3D"font-fami=
ly: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: norm=
al; font-weight: normal; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px;" class=3D"">
<a href=3D"http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org" st=
yle=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: a=
uto; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">http://lists.lustre.org/listinf=
o.cgi/lustre-devel-lustre.org</a></div>
</blockquote>
</div>
<br class=3D"">
</div>
</body>
</html>

--_000_43C26C25BF674CDA90FA65F3208FD274craycom_--
