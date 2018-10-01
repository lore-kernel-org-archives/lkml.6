Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B456206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="XwnmqFNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B456206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeJAMXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:23:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38115 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeJAMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:23:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so8358698pfh.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 22:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oub3t6UK/hXUbaNzlHXW0mdpmVCxoVTuxVMCOjtYxPM=;
        b=XwnmqFNW58WVDFh6U5VucsJIt+LoAWXqQOZc0ljct3QpE+aYcn81TvV3UlSNYDpwSE
         sgl4BFOs+Ojkvt2L9ScoiLDjPZZ/RcwKlJXqc1raZU3bEhdKC22Ou/bZemA6AwbEFsI+
         MACz28aqZR49eXB0UZi4JVTw64a5hdgQySTy3+XJGLlaUUXEwTnHSyXZy+Lp0epoP8ak
         x9TL1/aCtrPc74R/FNj1LqgYpoLrGBvM0k/c2FB0fzaqWmBrT1cIaJjpZ2bYpQKE1e86
         67naodYWuPjcdVe6q+KqMM3qtFgi5BG1q+6br5OK8rTLa8oCFTaIDTIufPKdzUX+Ii0+
         VkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oub3t6UK/hXUbaNzlHXW0mdpmVCxoVTuxVMCOjtYxPM=;
        b=B+wqN5QXsLlusyJ+eIKjE1szE7zSzzdScq68SZeZzWQIIGEsrnyV2kl9ets2lqzpiI
         9tMSxOED+gLWojPx49ihjBs6KfXay2xfkn20yMt4I3YH6fQ2OMUzvN2mAghnIWy6/B/+
         NYdeP14ryjiOlRMuViSslRAStW7Tsr91LoTu3kKjYMrrRog8RT9ABvysXB/m1OntEPRs
         ckGdC+GyszAhpTPZpvuE/j/39lKyTHSp+T5TMmyoXM82dRiTJOdSKFwg7WvnlqiZ4Eix
         Rs885kLCv4lbHW6A/GMO0PZOxCmOVpyzpnYsFD95iS3B9BaxKahR/QVWwGpJcxTQjTJC
         b2KA==
X-Gm-Message-State: ABuFfogwR6CL2APrx4n/UEZdc+jRyyDwg2CN40+S2+vpwsk1KBxyWu+X
        M1/r2fTOGg6pnAhgk+BaQWVS8w==
X-Google-Smtp-Source: ACcGV63i+AP83syi4h87bMc7i/rt4+e+yDxUPyWJkfhdLiU1U6JaLp5MqDK3isH0DXpUdebP27R48A==
X-Received: by 2002:a62:6948:: with SMTP id e69-v6mr9733696pfc.166.1538372853942;
        Sun, 30 Sep 2018 22:47:33 -0700 (PDT)
Received: from ryuk (pa49-199-140-183.pa.vic.optusnet.com.au. [49.199.140.183])
        by smtp.gmail.com with ESMTPSA id y19-v6sm22622694pff.14.2018.09.30.22.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 22:47:33 -0700 (PDT)
Date:   Mon, 1 Oct 2018 15:47:23 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20181001054723.lekp3nqgctdyly7m@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20181001040821.GP31060@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tnspunvdzgqmlf36"
Content-Disposition: inline
In-Reply-To: <20181001040821.GP31060@dastard>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tnspunvdzgqmlf36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-01, Dave Chinner <david@fromorbit.com> wrote:
> > I've added some selftests for this, but it's not clear to me whether
> > they should live here or in xfstests (as far as I can tell there are no
> > other VFS tests in selftests, while there are some tests that look like
> > generic VFS tests in xfstests). If you'd prefer them to be included in
> > xfstests, let me know.
>=20
> xfstests, please. That way the new functionality will get immediate
> coverage by all the main filesystem development and distro QA
> teams....

Sure, will do. Do you want me to submit them in parallel -- and what is
the correct ML to submit changes to xfstests? Sorry for the silly
questions. :P

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tnspunvdzgqmlf36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluxtOsACgkQnhiqJn3b
jbQqAg//WFcKNlV1tSPzHG9JTv//wyGl9FY6gqg86/RbsjUwLuAPhlMi+hSqSvgB
7WMN1zMF5fnW1wxMqsj8vkL6WkYpcWxDxrVp4OBIi7iN3g734edhe5UZEpGgHm5S
QJqOQEfPwaVTOSJZojNnxoU7mzJGT20BptjhgRSlPR0MpnvA5rYfnZClYgfY0+zr
kdo1DQ2KbRt9kes+PxbTMre+COcVfXQvtV37Ydsyx7+PR8x1sCBBIQgGrELIF87t
EOrWy84gOja/4YSMqdXfqcwBiTI+UxmP8ulpC3nNKSwuDvwPRXNUUnJy1RHYlfCt
Zb3c2WTRZU0RhHjttajJGyAzF/ZERRBOWpBxePFgtP5z2Q5djuQohDP6ugqV9XFu
SgSG1wOKM9ptJlm1/NdC4Y47JrUuBxuQ0BU8uIjVpJssuyPXj7NGW1DHbL4i0PNm
uD9KdpKzYGVEvNHcywFHKabG6AqNOriki8h/BUc5GR79xadeEjpr2SUXD+0NSw4O
YKl677M45mQcasqzNlJrz+ASGJO18xnXrGIeCO1NtvjOCDsYoCOdaygQ27J4rXxo
2UrvoUyiaAzC1FhQceqq+LaPl+kY1DBtfTvKxIc6pS/WHVS+ntUOJgRVrPpdqZ0B
//8nJAGOjETFHFRKkWz5jaOsXJL4gl2JhJId88X1FIW97C2fbf4=
=hNmN
-----END PGP SIGNATURE-----

--tnspunvdzgqmlf36--
