Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523122841; cv=none;
        d=google.com; s=arc-20160816;
        b=tWfW7tAsX+Pm3eGRU+ljFY66R64ps+OskpxkBVbqMGRyNMaDyNemmRYkF66jOIJDmh
         Z5oMexl49FBu/tyv/S+Oj2J1jEUEZIUMCR2vKkB6qsL+YAmoT39XVtpWh2oFvAAIpxp1
         qK0splJdCWw1kKXixalP8ioHTJd9enila1YSGaGL2Wf66Bn+hSX8SskaG7CErXtypIcH
         nIPMDompA2N3AN9HXR9Hq71d7cFnm3voRbc0R318TfiaaKXGARTqHx2bpIIH/biRONNR
         6isbuOd/bTPyHDv4tb15NZYldKLtSTKvIosVElbwc5jMZbnX4b98aiS9z/ash5myXTJe
         I2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=f8m4GcCQFUnvC21XM7FHYENAGiJE+TAsIemjVr4pLN8=;
        b=fpKDxOs0ZIiTkNPPryW/351woxemqrbGQ1F7jowBsTPNtVYwx3Vvh4KB3gq643/WPH
         3sFQecMhblR1gZh5gBB0RuJEZEXTiDErYlFFcTQVnVgzqA43RPrBDs3vKjCEEpzKkVWF
         5qxEzuAWA6DbsqtQK+lYo3bTWlu6auIRDUHEqTSKuECdLQRvsrv1o6iGFbRnz/A9w8g/
         mMaOqILSHRcX8zmsZ4wpH82ipYpuRf3fP6l1Lm179ellnGNlG/YiR0RczBktb+c6nNwq
         iRr/YGnaEOnIXUld6ISf5rMBedFvXnTMeOS9ueavO15E6ZShJVRn1or93Q1so2dbw7HT
         WoMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GAcOoAsf;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GAcOoAsf;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49hIz/SCkMXsddrzbDniDbGSg40dM1lXXW5iUdooyBmsZaPCAnhpF29B0wdTZ4/djBVe7WhSPNlenH6AyZa7ok=
MIME-Version: 1.0
In-Reply-To: <d33902cb-65d8-9790-7950-e30134f68578@infradead.org>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <d33902cb-65d8-9790-7950-e30134f68578@infradead.org>
From: Craig Tatlor <ctatlor97@gmail.com>
Date: Sat, 7 Apr 2018 18:40:40 +0100
Message-ID: <CAALoacpb3EbM4d+kqAxemeVL=nJd05JiN7-qi2sJt_O9REYgCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] power: supply: Add support for the Qualcomm
 Battery Monitoring System
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000de902d056945ab0d"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1597110055686582586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000de902d056945ab0d
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 7, 2018 at 5:37 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> On 04/07/2018 06:59 AM, Craig Tatlor wrote:
> > This patch adds a driver for the BMS (Battery Monitoring System)
> > block of the PM8941 PMIC, it uses a lookup table defined in the
> > device tree to generate a capacity from the BMS supplied OCV, it
> > then ammends the coulomb counter to that to increase the accuracy
> > of the estimated capacity.
> >
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > ---
> >  drivers/power/supply/Kconfig    |   9 +
> >  drivers/power/supply/Makefile   |   1 +
> >  drivers/power/supply/qcom_bms.c | 500 ++++++++++++++++++++++++++++++++
> >  3 files changed, 510 insertions(+)
> >  create mode 100644 drivers/power/supply/qcom_bms.c
>
> > diff --git a/drivers/power/supply/qcom_bms.c
> b/drivers/power/supply/qcom_bms.c
> > new file mode 100644
> > index 000000000000..5aa6e906d1b9
> > --- /dev/null
> > +++ b/drivers/power/supply/qcom_bms.c
> > @@ -0,0 +1,500 @@
>
> Hi,
>
> > +static unsigned int between(int left, int right, int val)
> > +{
> > +     if (left <= val && val >= right)
>
> maybe double-check those if() conditions?
> [or I need my morning coffee]
>
> > +             return 1;
> > +
> > +     return 0;
> > +}
>
> thanks,
> --
> ~Randy
>

--000000000000de902d056945ab0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Sat, Apr 7, 2018 at 5:37 PM, Randy Dunlap <span dir=3D"ltr">&l=
t;<a href=3D"mailto:rdunlap@infradead.org" target=3D"_blank">rdunlap@infrad=
ead.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 04/07/2018 06:59 AM, Craig Tatlor wrote:<br>
&gt; This patch adds a driver for the BMS (Battery Monitoring System)<br>
&gt; block of the PM8941 PMIC, it uses a lookup table defined in the<br>
&gt; device tree to generate a capacity from the BMS supplied OCV, it<br>
&gt; then ammends the coulomb counter to that to increase the accuracy<br>
&gt; of the estimated capacity.<br>
&gt;<br>
&gt; Signed-off-by: Craig Tatlor &lt;<a href=3D"mailto:ctatlor97@gmail.com"=
>ctatlor97@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/power/supply/Kconfig=C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 drivers/power/supply/Makefile=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/power/supply/qcom_bms.<wbr>c | 500 +++++++++++++++++++++=
+++++++++<wbr>++<br>
&gt;=C2=A0 3 files changed, 510 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/power/supply/qcom_bms.<wbr>c<br>
<br>
</span><span class=3D"">&gt; diff --git a/drivers/power/supply/qcom_<wbr>bm=
s.c b/drivers/power/supply/qcom_<wbr>bms.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..5aa6e906d1b9<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/power/supply/qcom_<wbr>bms.c<br>
&gt; @@ -0,0 +1,500 @@<br>
<br>
</span>Hi,<br>
<span class=3D""><br>
&gt; +static unsigned int between(int left, int right, int val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (left &lt;=3D val &amp;&amp; val &gt;=3D right=
)<br>
<br>
</span>maybe double-check those if() conditions?<br>
[or I need my morning coffee]<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
<br>
</span>thanks,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
~Randy<br>
</font></span></blockquote></div><br></div>

--000000000000de902d056945ab0d--
