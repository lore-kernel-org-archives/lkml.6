Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4CEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BA8222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/xhiLiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfBLWlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:41:15 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45222 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfBLWlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:41:15 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so132114ywd.12;
        Tue, 12 Feb 2019 14:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=b/tw4UY191kA91aDbYP7jUEiJRfl2Q0e6qfJa7NOBX8=;
        b=K/xhiLiRsxA80I3cC/I++ukfJhm1oCkrUGq6GPuYvyREFMY6jOo5I+yP840XEvYvZZ
         l1tGFLckQNxMIhsn4L6uvX/pJpypbKPquENi+UbC7FtW5hqV1swoYLOS9uhU7iGZ0tA3
         7kcUmSevgxrjpG946SQeYa8L7s+KU6Kv9kgJQji+z4SLrnnjA16IXsaoMY+5mid4hGQT
         ia/6xXn5jnQetZ+o//QldKLQzWIb5uuUrnIFfjfsMcQJZx0mYf4I8F3qNqT2FGBJ9BiW
         hQy/bTmPg+2UHF5IUkaoe+LMAKrLJEG178TRHn8qNaEA+Ev8FCd7ucuipDLxEHU8pluZ
         Ekww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=b/tw4UY191kA91aDbYP7jUEiJRfl2Q0e6qfJa7NOBX8=;
        b=WD9psksjTiTfk5uN1j6MUTXXiK8cTAb6IDULzr9vqsxhCmNLcau5bOIb3lvopbF6zS
         GaDNtgMTN6Puo35OGBOhZQfua9FYYE5UiobGUPQgc2rsEJ3yGBCRXUxEYxOr2PETnhag
         QMYOmCHfPgI1J2AnDns4WRaxdRaYPwE2UzM19XQVoU+9HQoPbWalnySQp1MOw/jeXLgZ
         mD2Cz+bb7kTMbd1wvuZJnq6L7m2C2oXdAyjmHG+Kfr/3qjbtGs6rabIDoKoHZ2YYmv1p
         a5AU+MPwMPO7BEYfo2yj6tIyhWynxHOuAXdDAgm8+DS6vN6LSyBiIVEqaFKduCR8sBXz
         zV6A==
X-Gm-Message-State: AHQUAuavNFoNFxUBPBDdyR9ZGkQcBtOr7deuvzk5wWE+sk/iixOkJKNO
        fRuLMPQL4LO6Y8PYLPwvEE9GiysU43Q4EA==
X-Google-Smtp-Source: AHgI3IauhEwJ/KKkjsIjZisd9OF/JNjT3502WWg3C4Z4ajeJdnqZ3T5RgDpaynB7Fg2AHKhvWTlNeQ==
X-Received: by 2002:a81:1c12:: with SMTP id c18mr2162734ywc.487.1550011273683;
        Tue, 12 Feb 2019 14:41:13 -0800 (PST)
Received: from [127.0.0.1] (c-73-120-18-128.hsd1.tn.comcast.net. [73.120.18.128])
        by smtp.gmail.com with ESMTPSA id h3sm5278500ywb.91.2019.02.12.14.41.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:41:12 -0800 (PST)
Subject: Re: [PATCH 2/4] Expose O_PATHSTATIC to userspace
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-2-demiobenour@gmail.com>
 <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
From:   "Demi M. Obenour" <demiobenour@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <39662373-f333-a5e1-f734-1b003992a468@gmail.com>
Date:   Tue, 12 Feb 2019 17:41:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa
Content-Type: multipart/mixed; boundary="U98QdikU4hBjqnfGgi2wkgmNBgqxGWAbA";
 protected-headers="v1"
From: "Demi M. Obenour" <demiobenour@gmail.com>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields"
 <bfields@fieldses.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-arch@vger.kernel.org
Message-ID: <39662373-f333-a5e1-f734-1b003992a468@gmail.com>
Subject: Re: [PATCH 2/4] Expose O_PATHSTATIC to userspace
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-2-demiobenour@gmail.com>
 <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
In-Reply-To: <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>

--U98QdikU4hBjqnfGgi2wkgmNBgqxGWAbA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2/12/19 3:18 PM, Andreas Dilger wrote:
> On Feb 12, 2019, at 7:54 AM, demiobenour@gmail.com wrote:
>>
>> From: "Demi M. Obenour" <demiobenour@gmail.com>
>>
>> This adds the file open flag O_PATHSTATIC, which ensures that symbolic=

>> links are *never* followed, even in path components other than the las=
t.
>> This is distinct from O_NOFOLLOW, which only prevents symlinks in the
>> *last* component from being followed.
>>
>> This is useful for avoiding race conditions in userspace code that
>> should expose only a subset of the filesystem to clients.  This includ=
es
>> FTP and SFTP servers, QEMU, and others.
>>
>> Currently, O_NOFOLLOW must be set if O_PATHSTATIC is set.  Otherwise,
>> open() fails with -EINVAL.
>=20
> I don't want to bikeshed (discard suggestion if you disagree), but why =
not
> name the flag "O_NEVER_FOLLOW" so that users can see it is also related=
 to
> "O_NOFOLLOW"?  Otherwise it seems like they are two completely differen=
t
> things from looking at the names, when in fact they are closely related=
=2E
>=20
> Cheers, Andreas
>=20

Searching for O_PATHSTATIC gives two results:

* https://www.halfdog.net/Security/2010/FilesystemRecursionAndSymlinks
* https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg06225.html

O_DIRECTORY_NOFOLLOW would also be a good choice, since that is what the
flag actually does.  Ideally, we would rename O_NOFOLLOW, but we can=92t.=



--U98QdikU4hBjqnfGgi2wkgmNBgqxGWAbA--

--JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAlxjS4UACgkQsoi1X/+c
IsEEQw//eeuvOan9TmZ0gfFNNIc7ibAMoc9o8q0L/Sr0yqTpRithhFdLfr/APzcq
jlctL4m4Urhg9R2IgEvKJUIH5LXpNgF0px2usODACwXua7MXy9b8ziN5f/+1+GOo
CiUNtnaR9kMWzR5HhyOGIE3LAAIBZrLgRRAuznvYbKQhojFayhAC5MeIpVsI91so
T4osAwVw0HHF4hIEIYUWMT5a1CZJfdxDPLb//AbEAWf1fU21XcKQFPxgYHIFMilo
s+0kkC/AHk/ncewn4N84jSoqsxYMqcmjHVwglVs7/SzCFPKLJoAKOjlKAe9q1l71
r4zvFIu2xMQ/73qQHNLJN9yWo8U7nCvC1S4oQUWPJP37C0G/6To7qGWXo9rFYZfP
BEtlX7dWdIEeiL/yM8ZIKE6GoTMl5vrvELRdn5QH3V9qRLCJLewezVivLMG6GjVL
ilINB6cx9N4YaxShouvNPrJURmPj8SZVyJa/bD4zC8UtfMpaLbWoJg0BjUf51FAb
tpKhBQqe00ecg1NgGtP0/54lcBVb3QWCVf4zHNDs96DET+c+ttd/nLMZcziYEYZt
VGwwGEZvRzm0km5/yya6Q0PYtYwM+KW7UW4jAZ/ksDBrQKirNOshC3kyKkggszUq
N6KU9v4MjvqCcf0xB/2+3CdmOujMdOmjmt63MYSR48cWD+n3b9w=
=fVy/
-----END PGP SIGNATURE-----

--JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa--
