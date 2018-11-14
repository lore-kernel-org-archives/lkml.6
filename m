Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC566C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1EB22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti+DwB/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1EB22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeKNWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:51:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43681 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKNWvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:51:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so820618edq.10;
        Wed, 14 Nov 2018 04:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ccvnNiAYigfgn+knpAcPXDzTAbiZ6km2g5+5D0INKA=;
        b=Ti+DwB/tsWgEEVZf8VlhpbMaeJGQUCM00HzKo0L7Ht7BW1y9lCJW2RaxGVAZJLLo9m
         Cphx5c74kDsQn9GmIqP4sO3H8kwIIRMe8K+lrRwI8fM8fBgCl+JtdhJ9g3U5QEC2lnGP
         iHPUpHIzC593AkgGxmWG36nyuQaCzTg+H5s3Ub05v+miCUrX0UJ2yc3SC7J9o0vgMuU6
         38QDo6UY5v1bNZCtz/R+p7Yb8yKYE5IpcW+MFrhaKKiE/tNs9UiymoaDfHtB3anNezf5
         jCjrQZsZIClRaNi1YjMYFurqHpU53CYuK9ah0FCgijDCEZqNNSwCiVnwTDweikx5/mjh
         1Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ccvnNiAYigfgn+knpAcPXDzTAbiZ6km2g5+5D0INKA=;
        b=BPehQ17uGpzM/IlKPuYpnfBCu1u5S8zHlas4hwOUu7YWCx3RkMPvJOXUmHKVGVrp3E
         /CLAkvmfQUC00lCoeQExyi2ZmByTLb4l4oAKmtvNjUhphZ/UYQEScc97NDOv/TwcgW6e
         oggf/wBymGtHHMtSB/OrcHcfHKdDpT+a+tmw5qxWGrRxyje0q22C9Mm73yscMUguXxm0
         U02Uv3keUadVSnyfngiXNkGpB8J1UDDHbZl4I5SfdJhBWq1fsmgYhzyGEqvklmh+WQYk
         jcor9bNWagq3I9dDw0kozVFKhM9/0G4JR2HeszhwDVFV7zYsNaEXOOMRGJbiX7sP10N9
         uyyg==
X-Gm-Message-State: AGRZ1gIZSapH53zbOWJMWyEtwKLAoUQgAJGiXxaPlhxFaqHr9w+1m6+i
        V9dGYMIJxB5DKv2BUkmM0Bk=
X-Google-Smtp-Source: AJdET5feaQTYQnmh4usgXkfJY3lZZE3cwkw5wK+qssHNDra2SNpNpyF7ihknhgwNAJwTqCeFclgZKA==
X-Received: by 2002:a50:86b7:: with SMTP id r52mr1979231eda.227.1542199675684;
        Wed, 14 Nov 2018 04:47:55 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id a27sm2656581eda.65.2018.11.14.04.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 04:47:53 -0800 (PST)
Date:   Wed, 14 Nov 2018 13:47:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Message-ID: <20181114124752.GI2620@ulmo>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Content-Disposition: inline
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> The flag 'has_clks' and related checks are superfluous as the CCF
> subsystem does this for you.

Both of these mechanisms aren't equivalent. While CCF can deal with
optional clocks, what the has_clks flag actually means is that the
device doesn't need a clock (or doesn't have a clock input) on the
devices where it is cleared.

So I'd actually be in favor of keeping the has_clks property because it
serves as an additional sanity check. For example if you run this driver
on an SoC that "has clocks" but if you don't list them in DT, then after
this patch the driver will happily continue without clocks, even though
it may break completely without those clocks. I've seen SoCs respond to
disabled clocks for a hardware block in different ways, in many cases an
access to any of the registers will completely hang the CPU. In other
cases it may just crash in some other way or give you some sort of
machine exception. None of those are good, and make the tiny bit of
additional code required to support the has_clks flag very attractive.

But that's just my opinion. If you prefer to throw away that safety
barrier, be my guest. But if you do, please move this functionality into
the clock framework first and then make the driver use it.

Thierry

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsGXUACgkQ3SOs138+
s6EhKhAAnU52kPmOfIbVhaDxXLLAR5p0eNkpLB7VYzDDiizJGgdGfnpjgjwqPHb0
6pJf12Bo+bibjOzR/kHwv6du6ylwESC73/ZyZnFlrvGJkF2CVXgJny5vfbBxPb9X
VsRkrRjCNK4Gi4jSOieGGH3k6BpUc/xnWzlF4wkSMTl7ualJ09gct2YgrnQSgvD5
Ku1CsxGsHACXWi78uPUEjavXSkeHFHwevpRzkekeAQCzNZe12kSHbPmnHUI6lXQo
XcXvKvD6pPwPHXnMV40pKi8kldWhT6CBX/1MgukimbkxDMtUbhCLhOT1WIxn4DW8
lM1MndqkdF/CzHpop/eMQS0OTOaFI5/6NlROEjz8dOG0/RKrkgH0CxnjgeCIaDqI
jmNf0/iEVSyqsA7RbNiz4AneOfNLMlkhTTdRDU+XZukWiOKqCgStQHqfUsbeRcyV
L/ERoC/y33co9MAVYs+NVawNLu+a1344Z58d3BIR7GNO6P+DtV6W9Z5eC03rW+MP
swVsPUkMZZblcM2oE3nFEa3OoTO82aIIfrjqC13mx5iHTa6/USWRlBIwXqEZgpd+
6gOEk3pdlR5QMRgs0ijBL85IR0PWusV2SX0eZk9ndCX2abRaBA88ZJbZacBeIilZ
9KYjAopAuEg6RKeweYL93hYktnxvJJ+DLxzpaf9Lz1HheOn52nQ=
=dqiR
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
