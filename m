Return-Path: <rohit.athavale89@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521929572; cv=none;
        d=google.com; s=arc-20160816;
        b=0pFEBHOu1AnlUfBoC0ZLJtvRku1ML700OV0tB3rQ25TPWtFRwbHyaMCby18h9NEmfu
         9DXdUgcSjUgZVql0G6YM725rm/GNDn0iBS+RxT9SlwrBX74R1dGzvh89sQnkgHLVUMyq
         m/yNGcqTpDz27SXai9vSmGbJ/8XiHEqOAlecJyJ54hKCzLwQapBHlyZiuXWJyBUQug3z
         CnKAlu7/9mtZZCsDqBA9HvE5ZBmlNXd9uYh6RsIlpaIiKdjcAFTp7m/D10tNP6xInIlO
         CW7X9g+UMh95bmKwgZJtC7kgeEJkMOE0u6wxk5v88IThiXbAmDwF992gzCsSnijCIfBk
         OUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=SE9xhx9xOm7zCgOtNaBYVs3IMjfVtx71KP1+0Tlj4nM=;
        b=SfYbypx/Hy6a2kb3TYAWQ50Jfy0bmtZ48fGxDlvzTdsX+29jhZA3DbLKvrvlWIyNcr
         c5wSs2DhqOnPpE+KOpAdGoEUMucj8oZgmXBf4dXSYNUlW/VhV6vv9rzzEX/iia6oMWtU
         N+kv0be4hdeBL/kLqijjyli5AZUirZLIqzqJW3kv+fwcydVgmK/RIl4OmZSOL4wivNYy
         Ef0RG9QRCK6oOTxryUgzBWJTF+vl8sbTU4S1cyTjDHAr8Wm1roLosL6yluujZ6VaUW37
         vKEcLB7fGl2HGAV1bNhHxilBbabx4K7HUPK1Cmp0uTqCoT0DSsrmTwsn2LncPAUGK01H
         kmMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JXAAWAVk;
       spf=pass (google.com: domain of rohit.athavale89@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rohit.athavale89@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JXAAWAVk;
       spf=pass (google.com: domain of rohit.athavale89@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rohit.athavale89@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsm2hY0SzB30aFw5l6rBgruUD6heHltkxxtJ9e+OQubRnTjmAoyfn8GKlELXusufSALupnPUQn+rWl3/lQFcVk=
MIME-Version: 1.0
References: <20180323180018.21737-1-colin.king@canonical.com> <d6247593-edd2-c6c4-64d5-c0a7d6879d6d@lwfinger.net>
In-Reply-To: <d6247593-edd2-c6c4-64d5-c0a7d6879d6d@lwfinger.net>
From: Rohit Athavale <rohit.athavale89@gmail.com>
Date: Sat, 24 Mar 2018 22:12:41 +0000
Message-ID: <CAN5OPsg-34tqY-+YtYWpjdkQT3wLJXiAtoSG5p3CgZrJcjBBYQ@mail.gmail.com>
Subject: Re: [PATCH][next][V2] staging: r8822be: fix typos in header guard macros
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Colin King <colin.king@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ping-Ke Shih <pkshih@realtek.com>,
	devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a113d351881e61905682fd7ba"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752336649881033?=
X-GMAIL-MSGID: =?utf-8?q?1595858823520690322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113d351881e61905682fd7ba
Content-Type: text/plain; charset="UTF-8"

Hi Ian,
Does this look okay to you ?
-Rohit
>   #ifndef __PHYDMKFREE_H__
> -#define __PHYDKFREE_H__
> +#define __PHYDKKFREE_H__
>

Doesn't clang complain about the proposed fix here. Shouldn't it look more
like below ?
 #ifndef __PHYDMKFREE_H__
-#define __PHYDKFREE_H__
+#define __PHYDMKFREE_H__

On Sat, Mar 24, 2018 at 2:24 PM Larry Finger <Larry.Finger@lwfinger.net>
wrote:

> On 03/23/2018 01:00 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The macros for __PHYDMKFREE_H__ and __PHYDM_FEATURES_H__ contain
> > typos and don't match the #if guard check. Defined them correctly.
> >
> > Cleans up clang warnings:
> > warning: '__PHYDMKFREE_H__' is used as a header guard here, followed
> > by #define of a different macro [-Wheader-guard]
> > warning: '__PHYDM_FEATURES_H__' is used as a header guard here, followed
> > by #define of a different macro [-Wheader-guard]
> >
> > Fixes: 9ce99b04b5b8 ("staging: r8822be: Add phydm mini driver")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
>
> > ---
> >   drivers/staging/rtlwifi/phydm/phydm_features.h | 2 +-
> >   drivers/staging/rtlwifi/phydm/phydm_kfree.h    | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtlwifi/phydm/phydm_features.h
> b/drivers/staging/rtlwifi/phydm/phydm_features.h
> > index 37f6f0cd7235..a12361c6a1a0 100644
> > --- a/drivers/staging/rtlwifi/phydm/phydm_features.h
> > +++ b/drivers/staging/rtlwifi/phydm/phydm_features.h
> > @@ -24,7 +24,7 @@
> >
> *****************************************************************************/
> >
> >   #ifndef __PHYDM_FEATURES_H__
> > -#define __PHYDM_FEATURES
> > +#define __PHYDM_FEATURES_H__
> >
> >   /*phydm debyg report & tools*/
> >
> > diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> > index 1ee60059afc1..2c6b0a48e76e 100644
> > --- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> > +++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> > @@ -24,7 +24,7 @@
> >
> *****************************************************************************/
> >
> >   #ifndef __PHYDMKFREE_H__
> > -#define __PHYDKFREE_H__
> > +#define __PHYDKKFREE_H__
> >
> >   #define KFREE_VERSION "1.0"
> >
> >
>
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
>
-- 
Best Regards, Rohit Athavale

--001a113d351881e61905682fd7ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Ian,</div><div dir=3D"auto">Does this look okay to you=
 ?</div><div dir=3D"auto">-Rohit=C2=A0</div><div><span style=3D"color:rgb(1=
17,117,117);word-spacing:1px;background-color:rgb(255,255,255)">&gt;=C2=A0 =
=C2=A0#ifndef __PHYDMKFREE_H__</span><br style=3D"color:rgb(117,117,117);wo=
rd-spacing:1px"><span style=3D"color:rgb(117,117,117);word-spacing:1px;back=
ground-color:rgb(255,255,255)">&gt; -#define __PHYDKFREE_H__</span><br styl=
e=3D"color:rgb(117,117,117);word-spacing:1px"><span style=3D"color:rgb(117,=
117,117);word-spacing:1px;background-color:rgb(255,255,255)">&gt; +#define =
__PHYDKKFREE_H__</span><br style=3D"color:rgb(117,117,117);word-spacing:1px=
"><span style=3D"color:rgb(117,117,117);word-spacing:1px;background-color:r=
gb(255,255,255)">&gt;</span></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><font color=3D"#757575"><span style=3D"font-size:25px;word-spacing:1px=
;background-color:rgb(255,255,255)">Doesn&#39;t clang complain about the pr=
oposed fix here. Shouldn&#39;t it look more like below ?</span></font></div=
><div dir=3D"auto"><span style=3D"color:rgb(117,117,117);font-size:25px;wor=
d-spacing:1px;background-color:rgb(255,255,255)">=C2=A0#ifndef __PHYDMKFREE=
_H__</span><font color=3D"#757575"><span style=3D"font-size:25px;word-spaci=
ng:1px;background-color:rgb(255,255,255)"><br></span></font></div><div dir=
=3D"auto"><span style=3D"color:rgb(117,117,117);word-spacing:1px;background=
-color:rgb(255,255,255)">-#define __PHYDKFREE_H__</span><br style=3D"color:=
rgb(117,117,117);word-spacing:1px"><span style=3D"color:rgb(117,117,117);wo=
rd-spacing:1px;background-color:rgb(255,255,255)">+#define __PHYDMKFREE_H__=
</span><font color=3D"#757575"><span style=3D"font-size:25px;word-spacing:1=
px;background-color:rgb(255,255,255)"><br></span></font></div><div dir=3D"a=
uto"><font color=3D"#757575"><span style=3D"font-size:25px;word-spacing:1px=
;background-color:rgb(255,255,255)"><br></span></font><div class=3D"gmail_q=
uote" dir=3D"auto"><div>On Sat, Mar 24, 2018 at 2:24 PM Larry Finger &lt;<a=
 href=3D"mailto:Larry.Finger@lwfinger.net">Larry.Finger@lwfinger.net</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On 03/23/2018 01:00 PM, Co=
lin King wrote:<br>
&gt; From: Colin Ian King &lt;<a href=3D"mailto:colin.king@canonical.com" t=
arget=3D"_blank">colin.king@canonical.com</a>&gt;<br>
&gt;<br>
&gt; The macros for __PHYDMKFREE_H__ and __PHYDM_FEATURES_H__ contain<br>
&gt; typos and don&#39;t match the #if guard check. Defined them correctly.=
<br>
&gt;<br>
&gt; Cleans up clang warnings:<br>
&gt; warning: &#39;__PHYDMKFREE_H__&#39; is used as a header guard here, fo=
llowed<br>
&gt; by #define of a different macro [-Wheader-guard]<br>
&gt; warning: &#39;__PHYDM_FEATURES_H__&#39; is used as a header guard here=
, followed<br>
&gt; by #define of a different macro [-Wheader-guard]<br>
&gt;<br>
&gt; Fixes: 9ce99b04b5b8 (&quot;staging: r8822be: Add phydm mini driver&quo=
t;)<br>
&gt; Signed-off-by: Colin Ian King &lt;<a href=3D"mailto:colin.king@canonic=
al.com" target=3D"_blank">colin.king@canonical.com</a>&gt;<br>
<br>
Acked-by: Larry Finger &lt;<a href=3D"mailto:Larry.Finger@lwfinger.net" tar=
get=3D"_blank">Larry.Finger@lwfinger.net</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/staging/rtlwifi/phydm/phydm_features.h | 2 +-<br>
&gt;=C2=A0 =C2=A0drivers/staging/rtlwifi/phydm/phydm_kfree.h=C2=A0 =C2=A0 |=
 2 +-<br>
&gt;=C2=A0 =C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/rtlwifi/phydm/phydm_features.h b/drivers/=
staging/rtlwifi/phydm/phydm_features.h<br>
&gt; index 37f6f0cd7235..a12361c6a1a0 100644<br>
&gt; --- a/drivers/staging/rtlwifi/phydm/phydm_features.h<br>
&gt; +++ b/drivers/staging/rtlwifi/phydm/phydm_features.h<br>
&gt; @@ -24,7 +24,7 @@<br>
&gt;=C2=A0 =C2=A0 *********************************************************=
********************/<br>
&gt;<br>
&gt;=C2=A0 =C2=A0#ifndef __PHYDM_FEATURES_H__<br>
&gt; -#define __PHYDM_FEATURES<br>
&gt; +#define __PHYDM_FEATURES_H__<br>
&gt;<br>
&gt;=C2=A0 =C2=A0/*phydm debyg report &amp; tools*/<br>
&gt;<br>
&gt; diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h b/drivers/sta=
ging/rtlwifi/phydm/phydm_kfree.h<br>
&gt; index 1ee60059afc1..2c6b0a48e76e 100644<br>
&gt; --- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h<br>
&gt; +++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h<br>
&gt; @@ -24,7 +24,7 @@<br>
&gt;=C2=A0 =C2=A0 *********************************************************=
********************/<br>
&gt;<br>
&gt;=C2=A0 =C2=A0#ifndef __PHYDMKFREE_H__<br>
&gt; -#define __PHYDKFREE_H__<br>
&gt; +#define __PHYDKKFREE_H__<br>
&gt;<br>
&gt;=C2=A0 =C2=A0#define KFREE_VERSION &quot;1.0&quot;<br>
&gt;<br>
&gt;<br>
<br>
_______________________________________________<br>
devel mailing list<br>
<a href=3D"mailto:devel@linuxdriverproject.org" target=3D"_blank">devel@lin=
uxdriverproject.org</a><br>
<a href=3D"http://driverdev.linuxdriverproject.org/mailman/listinfo/driverd=
ev-devel" rel=3D"noreferrer" target=3D"_blank">http://driverdev.linuxdriver=
project.org/mailman/listinfo/driverdev-devel</a><br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature">Best Regards,
Rohit Athavale</div>

--001a113d351881e61905682fd7ba--
