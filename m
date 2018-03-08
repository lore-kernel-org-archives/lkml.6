Return-Path: <SRS0=mDyr=F6=google.com=keescook@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684992-1520538475-2-4476349322725163686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endanl, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=mDyr=F6=google.com=keescook@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520538475; b=QsNlOG+nHMD9Ax/k9L69GkbJC4Jt4Gd7ZgDU0A2gCvYsrGQ
    q1CkkEVj3yAxPtZG2UICS6tVcH6CwS54lNr2Ql/tn1yO/aL/kVnf7P053+k1ozHZ
    CtzhyeJJyj4csO9m/PqRD/QivsDFqFpxQkbNOTbOIpYqYJAjbqXxaVPLxrER6kQX
    sE7KtwsdfKdQV0GdVH+cXOZnwkP6qQyIGduDcpfEG5oja5oI4NUM9ikvxArpGugp
    h9NgsxBAeQpkLrRQisWGcjwTJDRYLdKW2Mx9geG780Lj2w1g/yaoBDNIFPY/oeQ7
    BDlVtaUvvp56ydq0Zl0LXsL2pZYo49Q17vBpngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1520538475; bh=HnMLKgHYmuXA/VyCwAZG7edEcKiLPLck5Fx04Y
    WRGy0=; b=L9q5I01/RSUDoX6EnE6+UANKkbbPgwbWFQ2/KNH0uZFcTD2/6AX/gD
    7aB+m0dyYLozaK9R/xuZIeRcZIHkjk5XFoHg0BoWccvjpad09F6tgztRVGdy0eXy
    /MlPYg5L3vMTTAHTgWHfcDvALBgQ7qUSY6TmsT1pkQDLDF5tDh4P/yWJpxmUMrKj
    BkqmGNDfDCGdjCJxY0NjhQSALkU09EslSjENDSQzH33pF9zGVia+WIsfoTgvrWkZ
    ZTxxFNtDVrRtX/LUuOZ71mXqsjumIb2e7KyerU2AP8tsipSEeL1HE8uP2SBQnKm5
    jyiGTwA1w6YL0IfqP0BF0IHwdWQdUO6Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Nl5n0DPL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=sfLCC9HX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mDyr=F6=google.com=keescook@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rkhxyYuk;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Nl5n0DPL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=sfLCC9HX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mDyr=F6=google.com=keescook@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rkhxyYuk;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7766B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=keescook@google.com
X-Google-Smtp-Source: AG47ELuYLIsyGuehK67x5OBRB4CFXXvODyS1XzmSvB4OD86Iopv3+a2SPglm+vgZQc0wsM+++J6PtoxDgDfbG6jI+ew=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180308151421.GA13160@amd>
References: <20180308151421.GA13160@amd>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 11:47:50 -0800
X-Google-Sender-Auth: FuBMPf4G7lXy9j0eo0kSLeeI508
Message-ID: <CAGXu5jK1cvTOCT_OZVwk20LCNt6QLEM5CoLBXpT9JaHpwEKeJg@mail.gmail.com>
Subject: Re: linux-next on n900: oops in codec_reg_show() when grepping sysfs
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com,
	"Serge E. Hallyn" <serge@hallyn.com>, abcloriens@gmail.com,
	Clayton Craft <clayton@craftyguy.net>, martijn@brixit.nl,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Mark Brown <broonie@kernel.org>, peter.ujfalusi@ti.com,
	moderated for non-subscribers <alsa-devel@alsa-project.org>, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 7:14 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> pavel@n900:/sys$ uname -a
> Linux n900 4.16.0-rc4-next-20180308 #71 Thu Mar 8 15:27:49 CET 2018
> armv7l GNU/Linux
> pavel@n900:/sys$ grep -ri fasdfasdf .
>
> leads to an oops:
>
> [ 2278.331878] DSS: context saved
> [ 2278.820343] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> [ 2278.828948] pgd = c36040a2
> [ 2278.831787] [00000004] *pgd=876c4831, *pte=00000000, *ppte=00000000
> [ 2278.838439] Internal error: Oops: 17 [#1] ARM
> [ 2278.843017] Modules linked in:
> [ 2278.846221] CPU: 0 PID: 16337 Comm: grep Tainted: G        W
> 4.16.0-rc4-next-20180308 #71
> [ 2278.855529] Hardware name: Nokia RX-51 board
> [ 2278.860015] PC is at soc_codec_reg_show+0x8/0x19c
> [ 2278.864959] LR is at codec_reg_show+0x28/0x30

Looks like a NULL codec (driver has offsetof of 0x4).

static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
                                  size_t count, loff_t pos)
{
...
        loff_t p = 0;

        wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
        regsize = codec->driver->reg_word_size * 2;
...

This would paper over it. I have no idea that the lifetime expectation
are for codec and driver...

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..78ad165ad424 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct
snd_soc_codec *codec, char *buf,
        size_t total = 0;
        loff_t p = 0;

+       if (!codec || !codec->driver)
+               return 0;
+
        wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
        regsize = codec->driver->reg_word_size * 2;


-Kees

-- 
Kees Cook
Pixel Security
