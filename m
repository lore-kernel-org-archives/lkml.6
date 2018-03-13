Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520959341; cv=none;
        d=google.com; s=arc-20160816;
        b=Xq1ogdmPXCf9DKZ7kxh369XofTxaUiSz/KSEZVw04MCrZyfVhECYBg3tPhBFVfbSlg
         E6jAxYJOlST6Quow2zgMlOgS2cu89cryik6kNl0W8ve/BGgd5m1EnIlIjOfGdOOCRBRV
         rwWYir0MEt2xreYR9TG4YKs4woZxIpZ3mnvSfsJFyWa2n5xGPjUMcK3SAupH/9aIjK0l
         2E6NQ2n3dTIpP2bciDnbUybYvBV80FvBJS1hCONlvPR1p984IYfa2qT4S8CTr9DfgTRb
         kbdF5C4Gy8wmA6fK73isIImfeDjWUlHyj/Dq4mzfQWIi1qPGkCGinFwMHFUJmrvEZ2gA
         M5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/mSgDq9AmihG8Sl1ubP34YVeTiDIkVrkhlhtfHGljcA=;
        b=tmAgwc1CLHoVA4zv/wtdWwi4mbUZCHI7NEaUr4ecC2QrKy2yLpiYSKwIk4mbZBWOQQ
         TKHzApmBfSKH6qt3UDQpaOXRsDihQxSkJMW58HRMqFFY+3jfP8jwVSTDmIqui9NVWp/H
         VqeOvTfsLdcoarlJaWK4vAuJmwX3ZcXwVpXCI22lvdTvr9tRlXVTwUYq8vjHB+KKfMmb
         lPG/sDhM3K2VcxbfYQpH55IRpCbpXStMGGX3zUBNX3UtKxPEYdjplTJb073WepvdfO4e
         AzpC3fe2UP6ex0hQzV2G7wxPWulpSYFe11/IceGPJ7JmetyEiA23c6BRl5DXuYBvqPpm
         mAcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RFdwbS9A;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RFdwbS9A;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtLLR0l/QDSme66P2G9MZ2F5QXPzPQ12mdIy11LCBp1L/xLQ6TLQCoimWQC9IJzIpRcxphsUQ2tj3e/3TLLeIY=
MIME-Version: 1.0
In-Reply-To: <20180313164026.GG4449@wotan.suse.de>
References: <20180309221243.15489-2-andresx7@gmail.com> <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <87a7vcazf1.fsf@kamboji.qca.qualcomm.com> <20180313164026.GG4449@wotan.suse.de>
From: Andres Rodriguez <andresx7@gmail.com>
Date: Tue, 13 Mar 2018 12:42:21 -0400
Message-ID: <CAFQ_0eFoV_wt1n74DLNL8kCrB4CCX36aRKV9aSth6y-kt+T32w@mail.gmail.com>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>
Content-Type: multipart/alternative; boundary="f40304378fd846f6d605674df1fb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594841462871434393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f40304378fd846f6d605674df1fb
Content-Type: text/plain; charset="UTF-8"

Hi Luis,

On our side we would definitely want a return value to trigger a fallback
mechanism.

Also sorry for the multiple HTML emails which are not hitting the list.
Only have my phone.

Regards,.
Andres

On Mar 13, 2018 12:40 PM, "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> On Tue, Mar 13, 2018 at 03:16:34PM +0200, Kalle Valo wrote:
> > "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
> >
> > >> +/**
> > >> + * request_firmware_optional: - request for an optional fw module
> > >> + * @firmware_p: pointer to firmware image
> > >> + * @name: name of firmware file
> > >> + * @device: device for which firmware is being loaded
> > >> + *
> > >> + * This function is similar in behaviour to request_firmware(),
> except
> > >> + * it doesn't produce warning messages when the file is not found.
> > >> + **/
> > >> +int
> > >> +request_firmware_optional(const struct firmware **firmware_p, const
> char *name,
> > >> +                         struct device *device)
> > >> +{
> > >> +       int ret;
> > >> +
> > >> +       /* Need to pin this module until return */
> > >> +       __module_get(THIS_MODULE);
> > >> +               ret = _request_firmware(firmware_p, name, device,
> NULL, 0,
> > >> +                               FW_OPT_UEVENT | FW_OPT_NO_WARN );
> > >> +       module_put(THIS_MODULE);
> > >> +       return ret;
> > >> +}
> > >> +EXPORT_SYMBOL(request_firmware_optional);
> > >
> > > New exported symbols for the firmware API should be
> EXPORT_SYMBOL_GPL().
> >
> > To me the word optional feels weird to me. For example, in ath10k I
> > suspect we would be only calling request_firmware_optional() with all
> > firmware and not request_firmware() at all.
> >
> > How about request_firmware_nowarn()? That would even match the
> > documentation above.
>
> _nowarn() works with me. Do you at least want the return value to give
> an error value if no file was found? This way the driver can decide
> when to issue an error if it wants to.
>
>   Luis
>

--f40304378fd846f6d605674df1fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Luis,<div dir=3D"auto"><br></div><div dir=3D"auto">On =
our side we would definitely want a return value to trigger a fallback mech=
anism.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also sorry for th=
e multiple HTML emails which are not hitting the list. Only have my phone.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,.</div><div dir=
=3D"auto">Andres</div></div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Mar 13, 2018 12:40 PM, &quot;Luis R. Rodriguez&quot; &lt;<a h=
ref=3D"mailto:mcgrof@kernel.org">mcgrof@kernel.org</a>&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Mar 13, 2018 at 03:=
16:34PM +0200, Kalle Valo wrote:<br>
&gt; &quot;Luis R. Rodriguez&quot; &lt;<a href=3D"mailto:mcgrof@kernel.org"=
>mcgrof@kernel.org</a>&gt; writes:<br>
&gt;<br>
&gt; &gt;&gt; +/**<br>
&gt; &gt;&gt; + * request_firmware_optional: - request for an optional fw m=
odule<br>
&gt; &gt;&gt; + * @firmware_p: pointer to firmware image<br>
&gt; &gt;&gt; + * @name: name of firmware file<br>
&gt; &gt;&gt; + * @device: device for which firmware is being loaded<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + * This function is similar in behaviour to request_firmware=
(), except<br>
&gt; &gt;&gt; + * it doesn&#39;t produce warning messages when the file is =
not found.<br>
&gt; &gt;&gt; + **/<br>
&gt; &gt;&gt; +int<br>
&gt; &gt;&gt; +request_firmware_optional(<wbr>const struct firmware **firmw=
are_p, const char *name,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *device)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Need to pin this module until =
return */<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__module_get(THIS_MODULE);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D _request_firmware(firmware_p, name, device, NULL, 0,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_OPT_UEVENT | FW_OPT_=
NO_WARN );<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0module_put(THIS_MODULE);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +EXPORT_SYMBOL(request_<wbr>firmware_optional);<br>
&gt; &gt;<br>
&gt; &gt; New exported symbols for the firmware API should be EXPORT_SYMBOL=
_GPL().<br>
&gt;<br>
&gt; To me the word optional feels weird to me. For example, in ath10k I<br=
>
&gt; suspect we would be only calling request_firmware_optional() with all<=
br>
&gt; firmware and not request_firmware() at all.<br>
&gt;<br>
&gt; How about request_firmware_nowarn()? That would even match the<br>
&gt; documentation above.<br>
<br>
_nowarn() works with me. Do you at least want the return value to give<br>
an error value if no file was found? This way the driver can decide<br>
when to issue an error if it wants to.<br>
<br>
=C2=A0 Luis<br>
</blockquote></div></div>

--f40304378fd846f6d605674df1fb--
