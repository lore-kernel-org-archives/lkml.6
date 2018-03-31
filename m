Return-Path: <wasim.nazir@pathpartnertech.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522517172; cv=none;
        d=google.com; s=arc-20160816;
        b=LjFzkw9DCehPr+LEgdwFI0ZRe+/Z/2Fh5HZA5RTqHNAH01NiX7EbvAWeb1w5VLTHww
         5twPf/4aFfC4Ei0w/L1Y2doAt0xeQnZ4j6bHLbscXXfC1rOA6UFBO7L/dMWhuky/l2kG
         AG5IX/9NYTV7cUsb/iHPE2Nkr5Xar+iIHXh3TkKUfRwyou1KdTRVimR9y5TrgXEzmtjT
         GXLvjwFjHNDxo02bcpf8nwvMHzOeScrIN36MXn8PgrZGdzgkdh6Slu5b34xiIyeGx2zz
         KpBxY/vwcZ0/zDCvsRNgmV2JJsn+/kZCfrNCupkpCiKMyCccq68n0+BSYO1l0o589Rce
         cykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XWDq9ks8f56hoJO2eujz7zFWmzCoagHebPSdzMNSI8Y=;
        b=TXaZdzYR/TgvSxv5G/xAnJWIXrOG0ig00SlKc2l5WEN++gngDpfTOEqYKIXexqnIBK
         9vaePRrPNwh4L6Cd2Wl0XhFG5LGslIegGO7+t3dQTvl5sR/Ce5bx9mMvkb7EXrJ29UbA
         94ZI8yID8nRtMYH9dmC1c8cXjFcrtkQWkJR0KRmDLqLW3e0TxV9WCqHlE5rEwemuUnzX
         ocpURGze88sEeZ/0LsRwnlouaRCZKDVCjvn099CethBwyEvvBTcIl8FPUfORhELQCURT
         t1sxjEIdv5oLLUI/YyvwNvi0AXxWkg/CSloorTyXwm8IGYxSaBBB5ymxK57ARwEcmojd
         VNTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@pathpartnertech.com header.s=google header.b=e+sMGmW0;
       spf=pass (google.com: domain of wasim.nazir@pathpartnertech.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wasim.nazir@pathpartnertech.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@pathpartnertech.com header.s=google header.b=e+sMGmW0;
       spf=pass (google.com: domain of wasim.nazir@pathpartnertech.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wasim.nazir@pathpartnertech.com
X-Google-Smtp-Source: AIpwx48YqZyu0NVWiCobafk4uFLGd7XD5JeNbUQF+Fnjl2WzFH6M75xDSHWBm5gzeleRQHvbCuIR7iFMYMiuaOe8HoI=
MIME-Version: 1.0
References: <CAAYn-eg8L=-2rX4ZcsA6r9J+6ESEvQFrWk1=f+k1ToP2f=6WHQ@mail.gmail.com>
 <20180331140832.GA1074@kroah.com>
In-Reply-To: <20180331140832.GA1074@kroah.com>
From: Wasim Nazir <wasim.nazir@pathpartnertech.com>
Date: Sat, 31 Mar 2018 17:26:00 +0000
Message-ID: <CAAYn-eg8dUMC056GMm8g2CPAhFTtdri_rn+U9fFtYiXSp6Sw+Q@mail.gmail.com>
Subject: Re: [PATCH] Patch to replace DEFINE_SEMAPHORE with DEFINE_BINARY_SEMAPHORE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: jhogan@kernel.org, kys@microsoft.com, linuxdrivers@attotech.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	linux-arm-kernel@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	David Daney <david.daney@cavium.com>, Mihaela Muraru <mihaela.muraru21@gmail.com>,
	Kishore KP <kishore.p@techveda.org>, Sidong Yang <realwakka@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Phil Elwell <phil@raspberrypi.org>,
	Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>, linux-mips@linux-mips.org,
	linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Content-Type: multipart/alternative; boundary="0000000000002c48be0568b8a736"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596460385840802808?=
X-GMAIL-MSGID: =?utf-8?q?1596474966871235440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000002c48be0568b8a736
Content-Type: text/plain; charset="UTF-8"

No worries, thanks for the update!

On Sat, Mar 31, 2018, 7:38 PM Greg Kroah-Hartman <gregkh@linuxfoundation.org>
wrote:

> On Sat, Mar 31, 2018 at 07:16:21PM +0530, Wasim Nazir wrote:
> > This message contains confidential information and is intended only for
> the
> > individual(s) named. If you are not the intended recipient, you are
> > notified that disclosing, copying, distributing or taking any action in
> > reliance on the contents of this mail and attached file/s is strictly
> > prohibited. Please notify the sender immediately and delete this e-mail
> > from your system. E-mail transmission cannot be guaranteed to be secured
> or
> > error-free as information could be intercepted, corrupted, lost,
> destroyed,
> > arrive late or incomplete, or contain viruses. The sender therefore does
> > not accept liability for any errors or omissions in the contents of this
> > message, which arise as a result of e-mail transmission.
>
>
> This footer is not compatible with patches submitted to the kernel,
> sorry.  email is now deleted.
>
> greg k-h
>

-- 
 

This message contains confidential information and is intended only for the 
individual(s) named. If you are not the intended recipient, you are 
notified that disclosing, copying, distributing or taking any action in 
reliance on the contents of this mail and attached file/s is strictly 
prohibited. Please notify the sender immediately and delete this e-mail 
from your system. E-mail transmission cannot be guaranteed to be secured or 
error-free as information could be intercepted, corrupted, lost, destroyed, 
arrive late or incomplete, or contain viruses. The sender therefore does 
not accept liability for any errors or omissions in the contents of this 
message, which arise as a result of e-mail transmission.

--0000000000002c48be0568b8a736
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">No worries, thanks for the update!=C2=A0</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr">On Sat, Mar 31, 2018, 7:38 PM Greg Kro=
ah-Hartman &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfo=
undation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sat,=
 Mar 31, 2018 at 07:16:21PM +0530, Wasim Nazir wrote:<br>
&gt; This message contains confidential information and is intended only fo=
r the<br>
&gt; individual(s) named. If you are not the intended recipient, you are<br=
>
&gt; notified that disclosing, copying, distributing or taking any action i=
n<br>
&gt; reliance on the contents of this mail and attached file/s is strictly<=
br>
&gt; prohibited. Please notify the sender immediately and delete this e-mai=
l<br>
&gt; from your system. E-mail transmission cannot be guaranteed to be secur=
ed or<br>
&gt; error-free as information could be intercepted, corrupted, lost, destr=
oyed,<br>
&gt; arrive late or incomplete, or contain viruses. The sender therefore do=
es<br>
&gt; not accept liability for any errors or omissions in the contents of th=
is<br>
&gt; message, which arise as a result of e-mail transmission.<br>
<br>
<br>
This footer is not compatible with patches submitted to the kernel,<br>
sorry.=C2=A0 email is now deleted.<br>
<br>
greg k-h<br>
</blockquote></div>

<br>




<p><span lang=3D"EN-IN">This
message contains confidential information and is intended only for the
individual(s) named.</span><span lang=3D"EN-IN"> </span>If you are not the =
intended
recipient, you are notified that disclosing, copying, distributing or takin=
g any
action in reliance on the contents of this mail and attached file/s is stri=
ctly
prohibited<span lang=3D"EN-IN">. Please notify the
sender immediately and delete this e-mail from your system. E-mail transmis=
sion
cannot be guaranteed to be secured or error-free as information could be
intercepted, corrupted, lost, destroyed, arrive late or incomplete, or cont=
ain
viruses. The sender therefore does not accept liability for any errors or
omissions in the contents of this message, which arise as a result of e-mai=
l
transmission.</span></p>
--0000000000002c48be0568b8a736--
