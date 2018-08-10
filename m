Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D814C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435E8223B9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuZ6MPOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435E8223B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHJFzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:55:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37942 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeHJFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:55:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so3838012pfh.5;
        Thu, 09 Aug 2018 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4wpwEyaUtF6zel0WNUFlsLAS/Q1EVq5rWWF+p8+z+g=;
        b=TuZ6MPOjb7mcmres75WC96xdUROZmYuLmPU+YVucQtsw65DDSfWbyG7N5xntYUhcWd
         3OOMEP0p5965jrJz+Z1V5ahxlqb6Gd32uaNhzXUYo/zU2A8lEHDUzXIC07C1U822Bd32
         gN++5zkYWeDe2v3RlLbNWr268Bt3v1nqkCars1sSHDnWrM1NgEdA7wPXS93mQWSq+LH7
         HFwbhIWexbGR3trokD62VMctWVkA0+OxCDZHbFdwxE3MW4hTErnDgqMfvE0DJ7O49wgA
         rH3pbZR+Lk9LnU2co+O9ULXGhKWct3u2oX3jEWjMudeq3OD7YugsS4/SnwZyC6OQ1kR0
         Dl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4wpwEyaUtF6zel0WNUFlsLAS/Q1EVq5rWWF+p8+z+g=;
        b=DpD077PWzvItwCfZemfTxxWkNBJ3N2lOaxhOcGviGCM156bkSB5NFZ4+kcNowAB1xM
         g2LBWkr8ExrC5vEeztRjp0p2kzD/6O8anU3O0cP71j4syWqWtTCWNQao+FPvS9uzI6vU
         8XvE6wTHKsrDxf/TOP1azus2WqoJZ9WZatYKL3XxU2WbdvwltQc57cXsZpcFqGb6q63y
         KjtxFLA8hnKr8FDtq8QYc2/NpbKskL4d5pkfhqSBy6tc/NcmLR3g5GbeI5urAASsynls
         /5ttN8iGzGeKmNyrRRx8qIvVw0P3p6up4U0EqLQGoNN5Buard49+5qQ7qpLBZ3KwwLdF
         41/A==
X-Gm-Message-State: AOUpUlGl/u31m3FwS/6gWfJYwt0b6dllUNz/xzYyzZSJPl7SqTrtp3mu
        Cj2UobM/FiSE1UX1f6oJfqs=
X-Google-Smtp-Source: AA+uWPyXgHPayhoCqaQUjgKfz0s1XcXUaW++Oim+y6iQKmK242tEsIgpPf++8jq8QpA6LI0OMSpUsw==
X-Received: by 2002:a63:5b51:: with SMTP id l17-v6mr4511200pgm.165.1533871672792;
        Thu, 09 Aug 2018 20:27:52 -0700 (PDT)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id h24-v6sm13968823pgj.10.2018.08.09.20.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 20:27:51 -0700 (PDT)
Date:   Thu, 9 Aug 2018 17:27:47 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 3/4] HID: multitouch: drop reports containing invalid
 values
Message-ID: <20180810032747.fawrnvyacl27ss6t@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJLPm2UgqYU7CgsqX1CNp5JjHu0mZJp-kZnPmZ2qhi1CxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6giaonrkbn22nqk"
Content-Disposition: inline
In-Reply-To: <CAO-hwJLPm2UgqYU7CgsqX1CNp5JjHu0mZJp-kZnPmZ2qhi1CxQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-169-191348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6giaonrkbn22nqk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:13:54AM +0200, Benjamin Tissoires wrote:
> Hi Joey,
> You can't really use plain values like that. There is a tiny chance
> these values are valid on an other device.
> IIRC, MS spec says that we should ignore out of band values if they
> are tagged as such. Such input are tagged with NULL values
> (http://www.usb.org/developers/hidpage/HID1_11.pdf page 31) and MS
> spec mentioned this.
>=20
> All in all, if you have this bit set, you need to compare the value
> with the logical_max/min for each field.
>=20
> I never encountered a device that required this, so you are probably
> the lucky one :)

Ah, you are completely right. After giving that pdf a read over
I will definitely be dropping this patch from the v2.

--=20
Cheers,
Joey Pabalinas

--p6giaonrkbn22nqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlttBjAACgkQruvLfWhy
VBmYBg//Tx0H6f8Hv8oFN1auCMamQLSw2L9HGoCbxXK/IR9zFMY2SMKAIzlEZLYo
9YXUBciotRybA2qasN+WETU7DMEG2wX+NXPGIPKST/3hxjBvt2w2+PND6xMiAJXo
0nEKNhtGbNMcDWullwxY/fOT8KKU/wtsXnG7V15V5TS/kxO7VKJruexefX6LxU4E
LB9JQyprhWYnfGNSCMqc7FeLTqN8Tbg04nCcnrchtMgYbsZ87XEkW4tSVZkK/Nor
JR/ugNRZUCI4FHlHhFPwggegZyc4A8bnHRE8xS+d1GJO6x0//AZC5qktaBE+tkDk
lOHTFufgMwTiPGc8TFOpPz1hJsRFPR0HgldK9YqD79RcLQK7WxJRjZ8Yt7T7xBa2
+MfMNnD8o8ONWs7TkdiNCloQE2B53ixR2L4fcXoAkznKS7xvoZp98f728OykUVUv
04TA5PwsLKwKh01CcqUYwu+UkREh1kOsMdUES7OpgCgUh0q/ljVL3l8Q/JGIFnGd
624LuMqtQM/Yghfl12Aqyl2JQs0HjHm6CfWVzx53DGov48Uc+TWD+EJLlnp+CtVs
Pi/mTVfuc+d8nfQap/K5ile1h1u9QyDxlcEvrfhKNNfyp6q+xCEEstK2oAauu+k5
4UyODDPVZvTYzXtDTYCkW4WFsXEfmnROfbM8naOPGZqy47Yemvk=
=ig1x
-----END PGP SIGNATURE-----

--p6giaonrkbn22nqk--
