Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AB8JxZpqkTtTu2tZ6vZ1pWWaNgfaHwMGjOr8BgnqnkyEVT7SENuXxma9VW6+58U5UvX1tHFjhz30
ARC-Seal: i=1; a=rsa-sha256; t=1526301922; cv=none;
        d=google.com; s=arc-20160816;
        b=qckL9Ez5p4m9k/mBQ2gGfl/Wwxy6GUjPZs2eJ6l4ED94GFAMKMelstyz93QtyoLuOv
         Jo4KADZtZCG3x+4yBL28akwAISadIIOZQrtHuJz9T3fSL1Plv1BdAxApNBWpMm2/6U/h
         Mky+eHmJKw046POMuRzjiz0SgfMGBo97M+m1dbCr6PCF2RgOSTtgsi88FbxKs4yCmzna
         QKfeIe7D4IbL9APsfOiXUdLkjlOFUlhSDvhy5Vy/rwxocm71Ze5SirKVJX/Gxxh1VT9X
         9iAE8hf6a/fPMbnykrr4EfYXaYMDsDNmiLJ/Icqzcmxw5VSW7YnSH5wQSW85FXmvJTgH
         NY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LI6+ulshbA+awxJI3Lxc2F+S6YpV55ZIzFnCTJ824aw=;
        b=e55sCSSFFNhdOnJ4g9bWXiwbfhvYkhiKU3VZVVc3p8zF6u92WZrzsyKsCEYtt3c0sX
         u5J0pkaQKMPzBcbsIAxKDniXV1Ara6BwbmJ7/bP7FI/kv9JJaQg6AhAfl23Ne+g+bSXS
         lZ1vTARf89o81Vhv3gD/onj0tBtMbHwbLwIFQWsvgzP1y0zXEYztyyOs9exmbNtwnQvy
         zdnKNwiH+J1JcHxOuBgL4ifZzoDSojknxwCxAVaN4hSxAQz+z9APS8EjDq663s66wgc3
         HdZki4NiZxI/JXWH3x2PLlhotiwhmsqH3jzzwSe2aGp0JeMIpRZUGI/emCJ0iCLwLeB0
         uoqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VBIxw0rF;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VBIxw0rF;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
In-Reply-To: <4c61c422-a036-8fec-1153-d612fe5df878@samsung.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
 <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com> <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
 <4c61c422-a036-8fec-1153-d612fe5df878@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 May 2018 14:45:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc6Yj0+Z6zd-Gm-fYvfQB4rPPn0k6ED8bWScJ-tdZ=Ysw@mail.gmail.com>
Message-ID: <CAJKOXPc6Yj0+Z6zd-Gm-fYvfQB4rPPn0k6ED8bWScJ-tdZ=Ysw@mail.gmail.com>
Subject: Re: [FAIL bisect] Sound card probe error
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600443564668971982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 2:40 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 05/14/2018 02:29 PM, Krzysztof Kozlowski wrote:
>> Ah, I missed these messages because I was looking at err dmesg level
>> (and for some reason these are warn). Anyway do you have any thoughts
>> how is it connected with missing Odroid XU3 sound card and max98090
>> codec?
>
> One reason is that the DRM driver registers an ASoC codec object which
> is required for the sound card registration to complete. But I wonder
> why there is no any error messages related to this.

Thanks Marek and Sylwester. Another point is that probably OOPS later
should not happen...

Best regards,
Krzysztof
