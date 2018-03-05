Return-Path: <arushisinghal19971997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520273505; cv=none;
        d=google.com; s=arc-20160816;
        b=um0bWj2HAHsGRx2eMAfLbw7WFx7J0e+iE5gb49aBY9hOiM3NpW4Gfz5bd2qEzYZ9Hp
         UDz+IXFW+UnXFLvX+/hBn+GCuWZOx2iYLz8vvW40u+M4g7S/bKhGXPEQLo6+LhSxMY9G
         JUzkHo1n8WJCL0E2ST1Bh5jubwPsxPhaYxcThyh/vU/iP7jxa4UG1klaJsUYIOy6T4dk
         ux3EaWSg1Vtf32azszR4V/m0zkWNXiR8pbwHxwckWH/nDG2fGL4+m9KkkefL0c63RFIl
         0+2F7G7rz6RYKJCwjIAmQootxAjYiPL4jWKY7M598ffOjKlr4D8xRnkI+AHlkPidHTd3
         timQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bR4y+OBxxFeBeJs/W1BYMdbha08kp6LngO3zLZkXvqA=;
        b=R/CrDvNnevxlT29CcJnGFH9KBgh1qqqfDn93dfZW+91uX4aCRNz2DOi7OJm1qTqu+3
         jTbDy6E8q/r0naYNIXQ/rvhaFVaKPS7+Dpf3PyYx1A44Ywz0NmOZNjC7nCDPrGv2Ylz0
         gD2YxeCRN5kGbH7KGbmxqSG5Zo1AgAVbyeEZOFQH2d+ifZFRRFWyzu14Ei0QDKH3Scjm
         hNbRNZtR7Im1LEN9sRR1i5kVZLZ9B8LEJCZkrU04qVtifLpMWOZA3AsdEgtzQKqb4Uup
         d+YvMwVQcv1zokzpQT3Bw+D6Q2x3qd61HXvWDuhxkiTMlU77OKjkv1nsNmHUpNAlKxtN
         L2Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tHSFUnvf;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tHSFUnvf;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsrlhPfiC8Wb2AUF92N5UFey2hJA9xGx46Ukiu8hsoPvO6U/CYdPI2Fiu6MdQuGJtll7Y2UZmtjvzXWazCLiN4=
MIME-Version: 1.0
In-Reply-To: <20180305100345.v6ajs7vdgzmwu5x4@mwanda>
References: <20180304223205.GA31416@seema-Inspiron-15-3567> <20180305100345.v6ajs7vdgzmwu5x4@mwanda>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Mon, 5 Mar 2018 23:41:43 +0530
Message-ID: <CA+XqjF9tBqpgp7ymQOAWeJHm1hPd6w01u3ZVS8ozq4JuoBNSEg@mail.gmail.com>
Subject: Re: [PATCH] staging: irda: Replace printk() with appropriate net_*macro_ratelimited()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, driverdevel <devel@driverdev.osuosl.org>,
	outreachy-kernel@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="001a113ad1a834581f0566ae42ab"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594048122717535833?=
X-GMAIL-MSGID: =?utf-8?q?1594122310909866484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113ad1a834581f0566ae42ab
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 5, 2018 at 3:33 PM, Dan Carpenter <dan.carpenter@oracle.com>
wrote:

> On Mon, Mar 05, 2018 at 04:02:06AM +0530, Arushi Singhal wrote:
> > Replace printk having a log level with the appropriate
> > net_*macro_ratelimited.
> > It's better to use actual device name as a prefix in error messages.
> > Indentation is also changed, to fix the  checkpatch issue if line is not
> > exceding 80 characters.
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22
> +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> > index e6648f7..200fe5f 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> > @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
> >
> >       priv->tfm = (void *)crypto_alloc_cipher("aes", 0,
> CRYPTO_ALG_ASYNC);
> >       if (IS_ERR(priv->tfm)) {
> > -             printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not
> allocate crypto API aes\n");
> > +             net_dbg_ratelimited("ieee80211_crypt_ccmp: could not
> allocate crypto API aes\n");
>
>
> This should probably just be deleted.
>
Hello Dan
Why we should make this change?
According to me it's use here to print debug message.
Wanted to know more about your thought on this.

>
> >               priv->tfm = NULL;
> >               goto fail;
> >       }
> > @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff
> *skb, int hdr_len, void *priv)
> >       keyidx = pos[3];
> >       if (!(keyidx & (1 << 5))) {
> >               if (net_ratelimit()) {
> > -                     printk(KERN_DEBUG "CCMP: received packet without
> ExtIV flag from %pM\n",
> > -                             hdr->addr2);
> > +                     net_dbg_ratelimited("CCMP: received packet without
> ExtIV flag from %pM\n",
> > +                                         hdr->addr2);
> >               }
>
> The "if (net_ratelimit()) " already means the message is ratelimited so
> it's net_dbg() ok?  I think so, but I've never looked at this before.
>

net_dbg() is an implicit declaration of a function. So we can't do this
change.

Thanks
Arushi


>
> regards,
> dan carpenter
>
>

--001a113ad1a834581f0566ae42ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Mar 5, 2018 at 3:33 PM, Dan Carpenter <span dir=3D"ltr">&lt;<a =
href=3D"mailto:dan.carpenter@oracle.com">dan.carpenter@oracle.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Mon, Mar=
 05, 2018 at 04:02:06AM +0530, Arushi Singhal wrote:<br>
</span><span class=3D"">&gt; Replace printk having a log level with the app=
ropriate<br>
&gt; net_*macro_ratelimited.<br>
&gt; It&#39;s better to use actual device name as a prefix in error message=
s.<br>
&gt; Indentation is also changed, to fix the=C2=A0 checkpatch issue if line=
 is not<br>
&gt; exceding 80 characters.<br>
&gt;<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../rtl8192u/ieee80211/<wbr>ieee80211_crypt_ccmp.c=C2=A0 =C2=A0 =
=C2=A0 | 22 +++++++++++-----------<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/rtl8192u/<wbr>ieee80211/ieee80211_crypt_<=
wbr>ccmp.c b/drivers/staging/rtl8192u/<wbr>ieee80211/ieee80211_crypt_<wbr>c=
cmp.c<br>
&gt; index e6648f7..200fe5f 100644<br>
&gt; --- a/drivers/staging/rtl8192u/<wbr>ieee80211/ieee80211_crypt_<wbr>ccm=
p.c<br>
&gt; +++ b/drivers/staging/rtl8192u/<wbr>ieee80211/ieee80211_crypt_<wbr>ccm=
p.c<br>
&gt; @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;tfm =3D (void *)crypto_alloc_cipher=
(&quot;aes&quot;, 0, CRYPTO_ALG_ASYNC);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(priv-&gt;tfm)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_DEBUG &qu=
ot;ieee80211_crypt_ccmp: could not allocate crypto API aes\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0net_dbg_ratelimited(&=
quot;<wbr>ieee80211_crypt_ccmp: could not allocate crypto API aes\n&quot;);=
<br>
<br>
<br>
</span>This should probably just be deleted.<br></blockquote><div>Hello Dan=
<br></div><div>Why we should make this change?<br></div><div>According to m=
e it&#39;s use here to print debug message.<br></div><div>Wanted to know mo=
re about your thought on this.<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;tfm =3D=
 NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff=
 *skb, int hdr_len, void *priv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0keyidx =3D pos[3];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(keyidx &amp; (1 &lt;&lt; 5))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (net_ratelimi=
t()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0printk(KERN_DEBUG &quot;CCMP: received packet without ExtIV flag fro=
m %pM\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;addr2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0net_dbg_ratelimited(&quot;CCMP: received packet without ExtIV flag f=
rom %pM\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0hdr-&gt;addr2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</span>The &quot;if (net_ratelimit()) &quot; already means the message is r=
atelimited so<br>
it&#39;s net_dbg() ok?=C2=A0 I think so, but I&#39;ve never looked at this =
before.<br></blockquote><div>=C2=A0</div><div>net_dbg() is an implicit decl=
aration of a function. So we can&#39;t do this change.<br><br></div><div>Th=
anks<br></div><div>Arushi<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
regards,<br>
dan carpenter<br>
<br>
</blockquote></div><br></div></div>

--001a113ad1a834581f0566ae42ab--
