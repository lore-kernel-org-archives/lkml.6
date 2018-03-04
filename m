Return-Path: <arushisinghal19971997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520200135; cv=none;
        d=google.com; s=arc-20160816;
        b=bPTmV68G54iqHKOscQyy5/GiJ3/JnVKo4o8pNLwXAAJRAMoUr40L3lrTDuYrhvscZe
         SvHTpbqV+cYsozE3tKxwEKB6FozPU436PPo0lFDFYV9XjhUrRZcouTwTp0gDa+vzTjhh
         wfrlHsNaCXnwDA3oTLQiZZ0PLzDclSgYo/N3iKQXpksFN5B4884QUT3KD6peY+RkR32s
         tIBRNuL27aTdQgIIo9CzdQtp0guYU7ynMA2mUroHD4ylx9+4/zQ6Q8Lgc5+orBlZ3IAk
         eXxNw4dq8Rk4zrYAiYHU+0RcoZ3pxo0D27infhzLvVssENFJ/vOWl71Q28IECMWjkazI
         lqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0JZmxw8CXYrc0QSfOPutMJjB8EbQ3ps+19a1kBiiegI=;
        b=Iz4tHUJ71+xxDBO7ABRfSP7InKV9yeHXA9RAicdxUqd/10VoWYVqnxJg+kclI9iP1R
         EXGZSbMP9jW3M6lPQxvPqDRxEpNvLGm2vNm3hFTUJNYja5O2DgGLa4+S4/0tEPUcBx6n
         QGn4jqMkhWGKfsrd8merjknv4F4Uk2N7B8kIN6dZLmHaDQkL/QIciLBsMTEf7AOr3ZZv
         A5Il1uQ9nb1N05CleDu5tuJb6YjAnCnPviGatpCl824rkq1fbNusM8HiYAK3UJPwk661
         UoHyniyhmIMvYiwOu07wen7Tv/Gd5VG6uGBI3G0U9m9kLd0K2/ugemiu3Rpl7qlpcH/2
         t/bA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jlx4QfrM;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jlx4QfrM;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELumv/JBMpveeKjItNF67FoXeCbF0VAjpPYCqom9TwcmRifaqxov33ewzSA6J9H6fAHS5LzLW9Dc37aTHR0XiB0=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803042153160.2182@hadrien>
References: <20180304204910.GA4840@seema-Inspiron-15-3567> <alpine.DEB.2.20.1803042153160.2182@hadrien>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Mon, 5 Mar 2018 03:18:54 +0530
Message-ID: <CA+XqjF_DhC162jJQbU6jjA+d+WAM=0iVd+Gdui665ofG6MNefw@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: Replace printk() with
 appropriate net_*macro_ratelimited()
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>,
	LKML <linux-kernel@vger.kernel.org>, outreachy-kernel@googlegroups.com
Content-Type: multipart/alternative; boundary="001a1140336c0fec7105669d2dcb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594041647864597387?=
X-GMAIL-MSGID: =?utf-8?q?1594045377937646056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1140336c0fec7105669d2dcb
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 5, 2018 at 2:24 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Mon, 5 Mar 2018, Arushi Singhal wrote:
>
> > Replace printk having a log level with the appropriate
> > net_*macro_ratelimited.
>
> Why did you choose this function?
>
> > It's better to use actual device name as a prefix in error messages.
>
> What does this message relate to.
>
> > Indentation is also changed, to fix the  checkpatch issue.
>
> It would be better to no exceed 80 characters than to follow the
> suggestion abotu the argument being to the right of the (.
>

Thanks for the suggestion. Will send the new version.

>
> julia
>
>
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> > changes in v2
> > *In previous version printk was changed to pr_*macro(), which is used
> > in kernel instead of calling printk() directly. And for drivers,
> > dev_*macro() or net_*macro_ratelimited() should be used for calling
> > printk() directly.
> >
> >  drivers/staging/ipx/af_ipx.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
> > index d21a9d1..9a96962 100644
> > --- a/drivers/staging/ipx/af_ipx.c
> > +++ b/drivers/staging/ipx/af_ipx.c
> > @@ -744,13 +744,13 @@ static void ipxitf_discover_netnum(struct
> ipx_interface *intrfc,
> >                       intrfc->if_netnum = cb->ipx_source_net;
> >                       ipxitf_add_local_route(intrfc);
> >               } else {
> > -                     printk(KERN_WARNING "IPX: Network number collision
> "
> > -                             "%lx\n        %s %s and %s %s\n",
> > -                             (unsigned long) ntohl(cb->ipx_source_net),
> > -                             ipx_device_name(i),
> > -                             ipx_frame_name(i->if_dlink_type),
> > -                             ipx_device_name(intrfc),
> > -                             ipx_frame_name(intrfc->if_dlink_type));
> > +                     net_warn_ratelimited("IPX: Network number
> collision "
> > +                                          "%lx\n        %s %s and %s
> %s\n",
> > +                                          (unsigned long)
> ntohl(cb->ipx_source_net),
> > +                                          ipx_device_name(i),
> > +                                          ipx_frame_name(i->if_dlink_
> type),
> > +                                          ipx_device_name(intrfc),
> > +                                          ipx_frame_name(intrfc->if_
> dlink_type));
> >                       ipxitf_put(i);
> >               }
> >       }
> > --
> > 2.7.4
> >
> > --
> > You received this message because you are subscribed to the Google
> Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send
> an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/
> msgid/outreachy-kernel/20180304204910.GA4840%40seema-Inspiron-15-3567.
> > For more options, visit https://groups.google.com/d/optout.
> >
>

--001a1140336c0fec7105669d2dcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Mar 5, 2018 at 2:24 AM, Julia Lawall <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:julia.lawall@lip6.fr">julia.lawall@lip6.fr</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On Mon, 5 Mar 2018, Arushi Singhal wrote:<br>
<br>
&gt; Replace printk having a log level with the appropriate<br>
&gt; net_*macro_ratelimited.<br>
<br>
</span>Why did you choose this function?<br>
<span class=3D""><br>
&gt; It&#39;s better to use actual device name as a prefix in error message=
s.<br>
<br>
</span>What does this message relate to.<br>
<span class=3D""><br>
&gt; Indentation is also changed, to fix the=C2=A0 checkpatch issue.<br>
<br>
</span>It would be better to no exceed 80 characters than to follow the<br>
suggestion abotu the argument being to the right of the (.<br></blockquote>=
<div><br></div><div>Thanks for the suggestion. Will send the new version. <=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
julia<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt; changes in v2<br>
&gt; *In previous version printk was changed to pr_*macro(), which is used<=
br>
&gt; in kernel instead of calling printk() directly. And for drivers,<br>
&gt; dev_*macro() or net_*macro_ratelimited() should be used for calling<br=
>
&gt; printk() directly.<br>
&gt;<br>
&gt;=C2=A0 drivers/staging/ipx/af_ipx.c | 14 +++++++-------<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx=
.c<br>
&gt; index d21a9d1..9a96962 100644<br>
&gt; --- a/drivers/staging/ipx/af_ipx.c<br>
&gt; +++ b/drivers/staging/ipx/af_ipx.c<br>
&gt; @@ -744,13 +744,13 @@ static void ipxitf_discover_netnum(struct ipx_in=
terface *intrfc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0intrfc-&gt;if_netnum =3D cb-&gt;ipx_source_net;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ipxitf_add_local_route(intrfc)<wbr>;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0printk(KERN_WARNING &quot;IPX: Network number collision &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%lx\n=C2=A0 =C2=A0 =C2=A0 =C2=A0 %=
s %s and %s %s\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigned long) ntohl(cb-&gt;ipx_source_=
net),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipx_device_name(i),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipx_frame_name(i-&gt;if_dlink_<wbr>type)=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipx_device_name(intrfc),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipx_frame_name(intrfc-&gt;if_<wbr>dlink_=
type));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0net_warn_ratelimited(&quot;IPX: Network number collision &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;%lx\n=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s %s and %s %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned long) ntohl(cb-&gt;ipx_source_net),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ipx_device_name(i),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ipx_frame_name(i-&gt;if_dlink_<wbr>type),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ipx_device_name(intrfc),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ipx_frame_name(intrfc-&gt;if_<wbr>dlink_type));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ipxitf_put(i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; You received this message because you are subscribed to the Google Gro=
ups &quot;outreachy-kernel&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an email to <a href=3D"mailto:outreachy-kernel%2Bunsubscribe@googlegroups.=
com">outreachy-kernel+unsubscribe@<wbr>googlegroups.com</a>.<br>
&gt; To post to this group, send email to <a href=3D"mailto:outreachy-kerne=
l@googlegroups.com">outreachy-kernel@googlegroups.<wbr>com</a>.<br>
&gt; To view this discussion on the web visit <a href=3D"https://groups.goo=
gle.com/d/msgid/outreachy-kernel/20180304204910.GA4840%40seema-Inspiron-15-=
3567" rel=3D"noreferrer">https://groups.google.com/d/<wbr>msgid/outreachy-k=
ernel/<wbr>20180304204910.GA4840%40seema-<wbr>Inspiron-15-3567</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer">https://groups.google.com/d/<wbr>optout</a>.<br>
&gt;<br>
</font></span></blockquote></div><br></div></div>

--001a1140336c0fec7105669d2dcb--
