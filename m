Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B525CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D6B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="q9r9hBKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D6B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeIMUgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:36:07 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:37628 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIMUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:36:07 -0400
Received: by mail-pl1-f174.google.com with SMTP id f1-v6so2758004plt.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NTHnFBwg14lRtBKW3sBGqk4EHmFI9Zb5iy+jPaMk59U=;
        b=q9r9hBKLGzkbUnOT5hQ1CDrBHePFe0e/m0ENnteS98MziAUAf+W26DIRPUqsNsYpPq
         pfPQ8WbD33vKUjyFNcdI86eIVttPHBSWyRTHzCPvROvCEKdPZxByBQYo5EduyjxCHLqm
         nGNpF1nN4NFg/E8Fqyxl8jZ/eT1WMpVlBVbUtkMxkkkT/K+2qehyisR2+Fo1rEG5hZ3g
         OB6wkliDslwsWxx2W3JvluVeyn8ZnAMHlWfwObf6fSCk0a6NV8snN5KnqtQwDJOxdPvZ
         5XRud0wHk1R6Vff2GkDC+cT9rQYIizRKLBmJEl3i/hmN2bJaMAx6E9CMJQlMZrQ91gce
         3m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NTHnFBwg14lRtBKW3sBGqk4EHmFI9Zb5iy+jPaMk59U=;
        b=W7VsjJ1OxZdhIpCc5/Wn6JNSDdg71j04RZkGyF0YVh7hbth2fHV4cv9CU+ICzX7MLJ
         9zjK5Wjcx4o27E5wTgtqBaFZyd30OuwvA+HJmT/mTa2i5AVz2tF5iyLam9/+E+Ze5fKE
         pgJYjLET7nwDZtS7lnUjmPpoMdW3Tey9+IR+mcBBEueC7bAt0Lr3MXenAhmKG71FYzCY
         /Q/yOzIHYfq2UVSIFUeFVRwez4NDjpQ4fnkACbGyn3CeI8+9uOYOdd6hbQ1cmr0K/XNV
         GRgyDajRjOljSLp0gk2X/ozri2C0cOyn3JlBmOviQzDKzifSaXxJKTYVAAmz3CEIcsRh
         KnCw==
X-Gm-Message-State: APzg51DDLdD4LRNJvjQCiIAkAYC+X1y9vrxmfsdEF/v2BHfrd911fc16
        HkUSNP+LGgKPJEHVgpVMJCjmZw==
X-Google-Smtp-Source: ANB0VdYjbe/xFV/vy97WyXnozZtHbyDYcVmv+Ie7rc/dYaoN7EpD6qISAIG9Rsol79mWxh23sCjlIQ==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr7759805plk.196.1536852367513;
        Thu, 13 Sep 2018 08:26:07 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01e:351f:3993:453:ee20:ea06? ([2600:1010:b01e:351f:3993:453:ee20:ea06])
        by smtp.gmail.com with ESMTPSA id 185-v6sm7206145pge.82.2018.09.13.08.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 08:26:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <c5855aa4-1561-8387-aebb-0a7587ac6d4f@gmail.com>
Date:   Thu, 13 Sep 2018 08:26:05 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8D740A3-99F2-4AE7-8EF1-177F6534130B@amacapital.net>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com> <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com> <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com> <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com> <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com> <c5855aa4-1561-8387-aebb-0a7587ac6d4f@gmail.com>
To:     Milan Broz <gmazyland@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 12, 2018, at 11:39 PM, Milan Broz <gmazyland@gmail.com> wrote:
>=20
>> On 13/09/18 01:45, Andy Lutomirski wrote:
>> On Wed, Sep 12, 2018 at 3:56 PM, Ard Biesheuvel
> ...=20
>> b) Crypto that is used dynamically.  This includes dm-crypt
>> (aes-xts-plain64, aes-cbc-essiv, etc), all the ALG_IF interfaces, a
>> lot of IPSEC stuff, possibly KCM, and probably many more.  These will
>> get comparatively little benefit from being converted to a zinc-like
>> interface.  For some of these cases, it wouldn't make any sense at all
>> to convert them.  Certainly the ones that do async hardware crypto
>> using DMA engines will never look at all like zinc, even under the
>> hood.
>=20
> Please note, that dm-crypt now uses not only block ciphers and modes,
> but also authenticated encryption and hashes (for ESSIV and HMAC
> in authenticated composed modes) and RNG (for random IV).
> We use crypto API, including async variants (I hope correctly :)

Right. And all this is why I don=E2=80=99t think dm-crypt should use zinc, a=
t least not any time soon.
