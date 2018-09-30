Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B69C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD20C20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="P0XGn8FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD20C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeI3LKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 07:10:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42071 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeI3LKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 07:10:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so6557958pgq.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BIMIkuHhJ6vjFuAx7L2VXdB1pUbJkiH9sG6CykjtbPc=;
        b=P0XGn8FGcF2KLJ6YFFf1gPjvXZ7pFIKrIYdmJeNx5oTMYxiKb3fAo6z5ZeXGG39fJ2
         z7RKC495Eya6Fk5Tcg8b03naNCzg6xr+522aN9zWqNECYkcHt+++G3FTwGZR9SBX4dX2
         8wbStJdj51ZqrhP+uuNNplBeBxwQqwJZ5IbemlqM0O5/+J65unLek6MqX+g7cfsz2i6D
         cKEeDXL9BjNsFNJW7NBqaFEVHG7RrrDa6TYo8VPySM6XLyhKUjP4c+8ds8b1ROy3hIHo
         tp17yQL75O7jMNyM4GoLAgMLUb0W1fdbIhhlXIOYQ1QS/gl4elmxMmyKowtUugTf/Vji
         w6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BIMIkuHhJ6vjFuAx7L2VXdB1pUbJkiH9sG6CykjtbPc=;
        b=T+KEdG9M0AQVvoS4kXEnq6mrFWmt5ktMcsR902cGfSvWAke5yMj58RjSZyNYb8fQdY
         Vy66m6joJ3Y5AioWyhmROtmDS+maXYcSsBoCBbBMqxoge7zh2YrrVg1z5PpvnTJWaiD6
         M1nfPPWvZyj3NCQj7JSyrehrvSE1Awkm9HUD/PPxYEvkAIQ0cbCT02jmR33h3OkuP2F+
         1fEzwYZADMgt+wHUO4/NAJkMctn1dDfqo2RVFxPsmRLRNJMq3BIQvQIy/cj2KgtwGda9
         mzuZ0sRWtuYr0N2AtxRv5uAM3dha4hn6YEZjy8rP1qU/C8EMgbn9nLV2E125FqoPk6uZ
         FRfw==
X-Gm-Message-State: ABuFfoi3qOsq+MaAwdzDRSorQbf7x3SCx59H4+6x4Zn4ErA2BfkmEHM8
        Wg4pjcCry3j0Hu7zpP7U8Wrkqg==
X-Google-Smtp-Source: ACcGV630ue/nUpUNUj5tPhwaxszfU8kt6rJEkMaxW/3KWlT6dWfKx4wVzLkda/3RRSZXgqas8Tkwkw==
X-Received: by 2002:a62:1219:: with SMTP id a25-v6mr5549446pfj.104.1538282320643;
        Sat, 29 Sep 2018 21:38:40 -0700 (PDT)
Received: from ryuk (pa49-199-129-238.pa.vic.optusnet.com.au. [49.199.129.238])
        by smtp.gmail.com with ESMTPSA id j188-v6sm2870112pfg.132.2018.09.29.21.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 21:38:39 -0700 (PDT)
Date:   Sun, 30 Sep 2018 14:38:23 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20180930043823.2pgzrtgcziaou7ov@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6lzrlms3sezh4bg"
Content-Disposition: inline
In-Reply-To: <20180929103453.12025-2-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r6lzrlms3sezh4bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Aleksa Sarai <cyphar@cyphar.com> wrote:
> * AT_XDEV: Disallow mount-point crossing (both *down* into one, or *up*
>   from one). The primary "scoping" use is to blocking resolution that
>   crosses a bind-mount, which has a similar property to a symlink (in
>   the way that it allows for escape from the starting-point). Since it
>   is not possible to differentiate bind-mounts However since
>   bind-mounting requires privileges (in ways symlinks don't) this has
>   been split from LOOKUP_BENEATH. The naming is based on "find -xdev"
>   (though find(1) doesn't walk upwards, the semantics seem obvious).

I've just noticed that the mountpoint-crossing code for AT_XDEV doesn't
detect things like:

   % ln -s / /tmp/jumpup
   % vfs_helper -o open -F xdev -d /tmp jumpup
   /

I will fix that in v2.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--r6lzrlms3sezh4bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluwUz4ACgkQnhiqJn3b
jbS7URAAsh090oENRqj3EHW+hMMyrQ8ZjdRvylkNYtvhnGchEihDVXj4/NTprb9L
q1HdUQUW+v0CE7ow1H05L2F9RtMexztYwQvohdDNjgsaXFA5TYPB9cmkC6gaZoyE
On907Yd6LD1AzK+UDaq9ZYxTOgVVFi12xc5lY84jp3EFgSLQ4NB6hD6K8g4eGKym
1lkClzi8seX4o6FziHQC/3al+e3hIRzYF0HTLUbh9+bfuzpKI1tE14Bk1ijLa0Ow
jJdAuXcUfvYhznSjFUL0zbgXsUKQps9d/RnqVTb8gAI5Xa1r+Ht2ZpTdi3yt6LO6
SqQWCy/aIjc6dOu58xc6UeBW45iAzUFiD4VsH0qZtpHkbrvpUQ+K0rJ6fnEzdLr9
tN4X/cAY/q4DvuRwz69VgqjYXftgiilNwBKPMJewGl31ruGlywzrqgsYimuQFRXt
qbhTQcKWht09S4IPKAXS2dBlhLG94/aUijjYg8HwXAtHUj+dOjExpvtaPkmAL3kU
bgmB2kXlgcmLBLUSi8es5ILTD4N6wqgtwbcugCDHoiXwitprT9VHyIl/Tmm8G9nI
SIXVe5P+AwvRVL+Bq/vWceyPYH8T9bCObdI3NvB9jdO4nU2xfEqLAFzICOKsdFow
obiD/n0Cl60vdnJS6miCV7kzEkcnT4aPe5ycdkPI5y4dYEgWzOQ=
=jwmS
-----END PGP SIGNATURE-----

--r6lzrlms3sezh4bg--
