Return-Path: <jwerner@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521062345; cv=none;
        d=google.com; s=arc-20160816;
        b=vr/4Bme6BY1QZjlMsoFR+n8NAd4jnBFJNBbzCaiH5MchUbZtTpsIvEFDKU+SJMRbX4
         DsLSCunjRRZbjwD2A/EkSmr5+csdQEZCxikeDHcIONZkkYelX+1ULgBq1x3q1o3OuoEq
         f85VdDSX6vSwV75S/NlBqFPqiCqXh/2ZXJEPf/7K0Fgsj4ieQljlwmxlZqNDYs/EFPUK
         P/Tl/gQ4Zwb68iR54LiwwkJcuZkvASBOD9pbNV5nhZrLK1jwkoRYtku5QjJEIcLFJowd
         HH64/k0Y3dCRKEbj1ywyrvHy29hQxNLgfYJ/Oyi4Qspd0HlrvyL93D8Y42pLkWVRkhQU
         kPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6Qo/I2QitbQf/EordvLvHD73PHx6p1fNE8dzDsqaFbI=;
        b=xU+uoAdxyykSmACesCsUeWJi4a4IlZ2G8ajci4D4uJogFJf5PHiwOHBf+aIrLXbli/
         48MJ57EfVT76wHcYOxeudTiFKPkg2m9CDNlNKSVJ0wEZ+rZyEHxCG9mN1r/4cPO2KzUO
         QMpu4dq23X3j9LW9dhCH5V4V2v0N1daf5hB24VE6Rf/2hAaCmc5E31aMgKMu7dbLY826
         1o7mY38FASMtJN9DZx4uceNPnfjh/qfBqGjHBOxuvBIvbwbqH9uLHZiy/GNEY5+fkKLO
         V2GtQez4/SIEJbNM1iEp69an5/MDJVqyAU0eB6Go3mjnqClTVr/8AirDMh0FrAT4juLa
         T6nA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=mJbBCFrq;
       spf=pass (google.com: domain of jwerner@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jwerner@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=mJbBCFrq;
       spf=pass (google.com: domain of jwerner@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jwerner@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELu/DfrFnYRaw/VtovbCtmYJ2/iN35Wvjt7rzI8JRjF4jF4W45yF8QwDMsyx0FUoLOMA429n6yxySB2hHI2/Lak=
MIME-Version: 1.0
References: <20180125014120.20851-1-samuel@sholland.org> <20180314180830.GA6311@kroah.com>
In-Reply-To: <20180314180830.GA6311@kroah.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 14 Mar 2018 21:18:53 +0000
Message-ID: <CAODwPW9gbZgFKs6_Lc_oD_pPgGa1nUSdM2p0k8o9Mygx9d+HJw@mail.gmail.com>
Subject: Re: [PATCH 0/5] coreboot table bus and framebuffer driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: samuel@sholland.org, LKML <linux-kernel@vger.kernel.org>,
	Coreboot <coreboot@coreboot.org>, Thierry Escande <thierry.escande@collabora.com>,
	Wei-Ning Huang <wnhuang@google.com>, Julius Werner <jwerner@chromium.org>
Content-Type: multipart/alternative; boundary="001a114e5112b6f63d056765ec8b"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590526722620328845?=
X-GMAIL-MSGID: =?utf-8?q?1594949469297953472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114e5112b6f63d056765ec8b
Content-Type: text/plain; charset="UTF-8"

>
> It would be great to get some of the google developers to ack these, as
> this touches their code...


>From the coreboot point of view I guess we're fine with it since it claims
to maintain all of the existing functionality. It's just changing the
kernel-level plumbing for these drivers and I don't really have the
expertise to comment on whether this is better or worse than the old code
(maybe Dmitry or Guenter will?). It seems a little odd to me to call this a
"bus", but if we think that's the most fitting abstraction the kernel has
for it, I'm okay with that. All I care about is that it will work (in all
combinations... e.g. regardless of probe order and even if some parts are
compiled as modules and loaded/unloaded at runtime).

--001a114e5112b6f63d056765ec8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
It would be great to get some of the google developers to ack these, as<br>
this touches their code...</blockquote><div><br></div><div>From the coreboo=
t point of view I guess we&#39;re fine with it since it claims to maintain =
all of the existing functionality. It&#39;s just changing the kernel-level =
plumbing for these drivers and I don&#39;t really have the expertise to com=
ment on whether this is better or worse than the old code (maybe Dmitry or =
Guenter will?). It seems a little odd to me to call this a &quot;bus&quot;,=
 but if we think that&#39;s the most fitting abstraction the kernel has for=
 it, I&#39;m okay with that. All I care about is that it will work (in all =
combinations... e.g. regardless of probe order and even if some parts are c=
ompiled as modules and loaded/unloaded at runtime).</div></div></div>

--001a114e5112b6f63d056765ec8b--
