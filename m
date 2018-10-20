Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D77C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE3214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="wWy1fmmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFE3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJTOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 10:04:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34610 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeJTOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 10:04:26 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so5727563ith.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 22:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=zifUMGR7m6ft00v7aRINI0YBu1OGpVmhsTRaaaO+4zE=;
        b=wWy1fmmTur08IInGTgiKhUeXf2gST1g4YmAtVzzYtAn5YOwGoAx+qL1y2o65ZMZFI8
         sDBdhOG7veCl9G8QGW/GR0YisgfeTHuXfkUt4VddeBdLuuy7BpE1fX3IizkSUCbKP20q
         PLTn84qEon1lSnglTsIv2Th3LfKkr6c+g16eoCtkCFChsCU+Bvf4iEP8E6G0AJVhVNSr
         tFuzTRTAhgyHb9sNWKFd1207bLUM5C4GhTTY9LwNmZ1kDC8hWv0AP/SgiEJ5wNWZL15P
         1i0ExyBhSoUtNXIMIUYRO/RZt3IBcvmSzvQbPCVDJi+idcenaJ67hSawXtfFUxIoEzEG
         bZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=zifUMGR7m6ft00v7aRINI0YBu1OGpVmhsTRaaaO+4zE=;
        b=cchAGPCJoJrWmijx7CsFcNuYn7ia4XVrj9E4yfBNknycp9kvAHVzwI0iPek6PTPOFO
         ki0uMuDI7fCMxq7wQj8QwFg/0ErrA0rZ7O0mlIs6x4+7IyJAH4ng9AZLB8GfCG/7vRTU
         NoD2FYRk4q49YjPuvjQuZ3a9QRo80TwxQlhHsoIHFFEvELNzEZ3a4jbGq/NyJzrxLeOY
         038mp44BV4lmm6EVSf6+6hkGTQ37beRYX2e2pkGtNVZ/Kgw1MDQgLG9ToocYOUp2mqnF
         FXysjQQHH1lMTzg9mf5XJgJAKFwo7dKbVXXYB9pY2DrmR0Ljk5smovfxI9FUEGLQnrI7
         xHkQ==
X-Gm-Message-State: ABuFfogC7kOQtFkp6grrb4M/iXjCQy0MASe8yrPbDiyt/zt4Btk7Qzsl
        92uLDOKMBSyVPhuue5xJFRqWcw==
X-Google-Smtp-Source: ACcGV62YtKBOZB95k1TAiwvtwJf8bywFeGk5SLMQVr/6DlxD6R3diYISnewhApRkfjCQL2s/dmOcwg==
X-Received: by 2002:a24:5e50:: with SMTP id h77-v6mr5053991itb.58.1540014910951;
        Fri, 19 Oct 2018 22:55:10 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id p185-v6sm2141537itg.34.2018.10.19.22.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 22:55:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <191D94B6-B91B-45C0-81A2-C6E7A3124731@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2AA2161F-DEAC-4A18-B584-431061FB00A9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 6/5] statx: add STATX_RESULT_MASK flag
Date:   Fri, 19 Oct 2018 23:55:04 -0600
In-Reply-To: <CAJfpegtPv4+QxzcqMAGwTt7QALjBaxQtt2Qet98pdmuT1MRUeA@mail.gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <20181019143932.6697-1-mszeredi@redhat.com>
 <18142.1539964788@warthog.procyon.org.uk>
 <CAJfpegtPv4+QxzcqMAGwTt7QALjBaxQtt2Qet98pdmuT1MRUeA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_2AA2161F-DEAC-4A18-B584-431061FB00A9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 19, 2018, at 11:42 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>> +#define STATX_RESULT_MASK STATX__RESERVED
>> 
>> Please don't use that bit.
> 
> Using it internally is perfectly harmless.   If we'll need to extend
> statx in the future and make use of this flag externally, then we can
> easily move the internal flag somewhere else (e.g. extend request_mask
> to 64bit, which we'll probably need to do anyway in that case).

I was thinking about this - what is the point of returning an error
if STATX__RESERVED is set?  If this is used to indicate the presence
of e.g. stx_mask2, then newer applications trying to request any of the
flags encoded into stx_mask2 will get an error, rather than the expected
behaviour of "ignore flags you don't understand, and don't set them in
the return stx_mask".

Essentially, this will make STATX__RESERVED useless in the future, since
no application will be able to use it without getting an error if they
are running on an old kernel.

Cheers, Andreas






--Apple-Mail=_2AA2161F-DEAC-4A18-B584-431061FB00A9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvKwzgACgkQcqXauRfM
H+ATqxAApNR2xdaiSRfe2Fgfo8reQlhc30NE6O1bmlWMKVdMR5/QZoJ33qvSD3YM
T01+drMlFx+L5Onoy9VF36bcvMm7LO3AN6ghINgQXVyPyitFXJiNn8DU/wwIwzNR
8evyURtDSgdw0+BNOx6zuuLcOsDcAhSS9HwCpf57upQWVsnKsqTs0ZOPQMM2Bz3f
/FcuVbe8UMyvyORUg+3AS+aX05MG12LXRClCGMyVnczbbfABtW+PJMtyZUvniqJd
AmXS0y41IV0PU7Fun5m0J2EEdtQvMkqcT3ULutB5VtcZGAitBuBIKBeQs7a5PBlK
lk0koGse1IR4sZi3NrCg+8UAUAQJG7Zvt6N4QFEN6pvilK3SflOydGEI7IQ7fQgJ
52xCWLSOXwQvm1/oOFOC3sTOmZHOEwVn+YeEpWIaNHb9xSMuNgdBDYnpsVoMDdec
w/2HECiWqi5+SkwRFzRjaeLkAHs5pnjVrDsV4i17gn4eJSIrg1wt0vDUbbPFBUJI
qgqenVwOdUkrmiJ2PGnKzUoh0/WIhy3jHVhs9TTFLeSFMORP0KOmzVDuLX9TrY7u
TTWKEj4bxU2NhAZCt2YmPcb+DZnpo/9hGziL1CF3zHqBgc9x/86si6lLnghZ40uA
r+s3TJzEj02WHO3DIHk4Fr4YrjGyPI5Ys+MyhLwObu7JSDhQrRw=
=X1q8
-----END PGP SIGNATURE-----

--Apple-Mail=_2AA2161F-DEAC-4A18-B584-431061FB00A9--
