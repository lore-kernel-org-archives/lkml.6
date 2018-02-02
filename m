Return-Path: <lukas.bulwahn@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2060698-1517565421-2-5579865854713817281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.43', Host='mail-wm0-f43.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: cc='ISO-8859-15', plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: lukas.bulwahn@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517565420; b=Oq3Yq4f9Ma/hBN1HNGBHr9csDKPRN0xaNfa5FucrGv2Hb5p
    U7uLRJz7Ot50eCzRsEmXEGHaNs0q7/Eb26ajWGaWxJdVFNYgAaluRQga1Cdbl3wz
    vxGfLtET015vq4IVWuKF2ut+5NE7x+5caNS2B0alQZrZWcHXXMcIMLPQiEKqUX8Q
    NnGX2SC9UMBEjyhFdX5TfHdAKXascB5QtHLblFbT63KhfNuhcSC9gEYQz+96WVS7
    7MhB0qmjAt9SC+Njps0TksP8FIampyc6QhMMzmDBXu6jrK99zac7QowAhwlRGxMa
    9w/Q0YULCh+Yy1Xoh2EouS2unIG6aNrSWa8CL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type; s=arctest; t=
    1517565420; bh=4jH2WMOFIrpVz0XFRsgETdQdS201p1Ay8qJjGRvAbYU=; b=b
    4u055RwATEkGlmObKvimeQhLtikQ1zkMAXVFR8PGTryGLWzEEOpLrD8aiaX0M+Xc
    8TyddREJnJOBPFypUOiIXDiRoX8I/rIYwDHfMs3SnoGA1A/FI3Yx9vuaf7om6nCW
    uTN4xIcTMs0fhm4d4JSC/+2ydY2YVzVzU+6Sq9bbTDRKVjwccl4ISGpQgjZfxm5O
    s/4SxCcG9DOodLdVEaqiZ7hk0P3uJvjHhUkDEYIhcfK3fuQa5H5GEoD/DTNctF7D
    ukkJbxWSR8c3kNKeY0293NkuFJMYkvaTPFt1UorL+gLqtrRoUNMlAeXvn+V0lVVP
    9l2JkVMVxhjC9YZ4wqftg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OoBeqNj7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.82.43 (mail-wm0-f43.google.com);
    spf=pass smtp.mailfrom=lukas.bulwahn@gmail.com smtp.helo=mail-wm0-f43.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CKQa/cb+;
    x-ptr=pass x-ptr-helo=mail-wm0-f43.google.com x-ptr-lookup=mail-wm0-f43.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OoBeqNj7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.82.43 (mail-wm0-f43.google.com);
    spf=pass smtp.mailfrom=lukas.bulwahn@gmail.com smtp.helo=mail-wm0-f43.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CKQa/cb+;
    x-ptr=pass x-ptr-helo=mail-wm0-f43.google.com x-ptr-lookup=mail-wm0-f43.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226yNxflfooDWbEpObUUidVKc5FZkQ9Pq/z0ECnqPJeEe8lGDlMI7j2ovewzlDHGMBzgubeYbQ==
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@hsp>
Date: Fri, 2 Feb 2018 10:56:36 +0100 (CET)
To: Jani Nikula <jani.nikula@linux.intel.com>
cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Greg KH <greg@kroah.com>,
    Ozan Alpay <ozyalpy@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
    =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
    sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
    David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
    llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
    dri-devel@lists.freedesktop.org
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
In-Reply-To: <87372jkcu5.fsf@intel.com>
Message-ID: <alpine.DEB.2.20.1802021054500.13838@hsp>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca> <20180201180240.GA28042@kroah.com> <alpine.DEB.2.20.1802012045570.29994@hsp> <87372jkcu5.fsf@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Feb 2018, Jani Nikula wrote:

> Being brutally honest, please write shorter reports and shorter emails
> to the lists.
> 
> The static analysis reports are welcome, but only when 1) we didn't
> already fix it in linux-next, or 2) it reveals an actual bug, not just a
> warning, warranting a backport.

That will be our policy.

Lukas
