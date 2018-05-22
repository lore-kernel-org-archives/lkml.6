Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527010324-2-6625831189207389564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527010323; b=eNXeYoo/kYvqUG6b8C6droSFS3wM09X9zo7SdmbeuhdeLm5csP
    RVaonYEJHPclHhIVpzMfR7j6QSmKhuXzyZ3LfnfjjQXB0PVBJI0lH9oNfyvyYWtx
    mXSGy2vOruvyCoNYabkwtXsp57PFU7jB+DUY6B0fa0fAaKnMai1bU/Ls8ocdf/vu
    OnnyyXuxinNTzkOLO6ci0myPY7CUrYCg6LJXqqC8CBE9QP6EI/N6/ogpHGVbA1+p
    JwCh7PrHVfEbZJrezGu3IOWbYgN1dp2TNeByal0Z/okiH32ebzqjUzlnAJjGutWa
    6NhlsnrEcRHsIucEwZIVsd8vX038EBEatJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1527010323; bh=jgIdu
    eRVxuGW9D/glJINLssS5Z4iCpaPY5/0WahJtio=; b=ErjR3qw4yBOllxqXpBz5w
    ezZLvTkLeC0YtbiQ7nwwNWAhBGezQwc07AVd62wndG+cDdACrALQBMMOegWc9DIK
    3eYlgRRSH77Sc5Iu00GyyFlhI73UO8oGvLeqo3e7tN20eN2h4CTkMwhd4gmxpLNl
    ggCFpSlaFLIbfut+5rqjmaTtwwmtHpdh1hprrh1OrOedCSyZ14vz8PSnvimWw+6Y
    49N6LUZUcMoRT4GmC2rQgjfN6Cm7CKcxe5j3i2Wmn0PNA1YRhnlbJz30OlIMjnNk
    YViKyLp4qksTR1gsG5oIJaWpblRcVfF/TFrVcyBO0AItffGgxdzNBjK/SMwDVMEb
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Oi10DZXx;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Oi10DZXx;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTN/qDX2EPzgsSmeZKWRYs5mJuH/kv00ax00hMzW5s92XNr7wST6AM4A6c4WHIdTY44UKRgoDuJKopnnG1hvgw8GW6Ek2NCfa4ws04aeUtbD6tLq+JI
    nBfPr0WsVnoMq0gt20Ko6OKfIfXFjGHkYvgS9JhbuhOHmZoEVw2SuH7QszXfzXslj5+T71jeedutRPqTsdRSDZE5ZgeejZwT/4MabOe0/OxzQTT4jehjnL2n
    MGC59RhEAMd3Houap3MKiw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=w5M-TH9aDrwcIgK7nEUA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqie4YO7cdwSOI/1OgOqxfbFZQnn5QHFjyzBiGmJ4X1m77Hge4xU1eqhRasBAkHHIBzbo7veA==
Date: Tue, 22 May 2018 12:31:55 -0500
From: Rob Herring <robh@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 11/11] docs: fix broken references with multiple hints
Message-ID: <20180522173155.GA11767@rob-hp-laptop>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
 <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>,
 dri-devel@lists.freedesktop.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, devel@driverdev.osuosl.org,
 Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
 Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org,
 Roy Pledge <Roy.Pledge@nxp.com>, devicetree@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jiri Kosina <jikos@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
 linux-kernel@zh-kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 10:18:54AM -0300, Mauro Carvalho Chehab wrote:
> The script:
> 	./scripts/documentation-file-ref-check --fix-rst
> 
> Gives multiple hints for broken references on some files.
> Manually use the one that applies for some files.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-gpio                     | 2 +-
>  .../devicetree/bindings/display/bridge/tda998x.txt        | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/trace/events.rst                            | 2 +-
>  Documentation/trace/tracepoint-analysis.rst               | 2 +-
>  Documentation/translations/zh_CN/SubmittingDrivers        | 2 +-
>  Documentation/translations/zh_CN/gpio.txt                 | 4 ++--
>  MAINTAINERS                                               | 2 +-
>  drivers/hid/usbhid/Kconfig                                | 2 +-
>  drivers/input/Kconfig                                     | 4 ++--
>  drivers/input/joystick/Kconfig                            | 4 ++--
>  drivers/input/joystick/iforce/Kconfig                     | 2 +-
>  drivers/input/serio/Kconfig                               | 4 ++--
>  drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt           | 2 +-
>  drivers/video/fbdev/skeletonfb.c                          | 8 ++++----
>  include/linux/tracepoint.h                                | 2 +-
>  security/device_cgroup.c                                  | 2 +-
>  16 files changed, 23 insertions(+), 23 deletions(-)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
