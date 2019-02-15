Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD10BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA32F222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTSl4Ggq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbfBOUiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:38:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34698 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBOUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:38:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so6557217qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VKDTq32tHQd8+HaOp4Alna3elHrfcsH7L4bE3HH+oS8=;
        b=TTSl4GgqBMPMmNmTgOsjeptcSr/SRPhZzsMMIyuhuHLA+uhnFWqCc9iz/dRytozt+J
         8Qw+AJAVx4PG4pa28v86a/GWQrLfa6CtI4irNuVab6kQIed7km4bCyQubaz8MlXu1xDy
         Y6HAAml3Gv7VW6A+rYcrCegJXJ8UdMYN6qxB745JJLEj9r5U6pvT+pZ7KPESvtD3q4pk
         dg1NCHwHytvEUHiU7t1+xRF/P2COFxbuubXNe0h0uPcqCiUZBjqvNA0nxnBc4OyQeZhc
         G+vsaRVfRZceYaNC0d7KtMZaMhADEs76NhQckMJV8gEVl/T0j6dDvG7cnO5ybjxcwdCz
         JDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VKDTq32tHQd8+HaOp4Alna3elHrfcsH7L4bE3HH+oS8=;
        b=M6ZnP4ajLlJAXrcycXHWvALrk1gZAMvZjBqrnbv18N501IB/kDwNRmrhFtprZutOLs
         bNwOf3eGrdG9PqmghdByY3JtGtT5RoC/gL6npoXo3nEng45QOBJGDXDvNDor0hdhosFC
         J8W0N6dbbEobijOGB9Lh/pXLXOValKSzIKJfUANllkEDdeLSPRlZd1Z2xHeXuOXZfw3j
         qDB/oZrZXSJCVnVhBFLIBUWWBu+cAVTrTSb336czhjhJ+P70ZhNi/R5ii8Z3Yj7vsa9f
         smb39DBytd+pODj/F2D6x49FDqtN7YE5ssEoxIOXOF4sWb+3MVx5DBfoQv2zgXkgJ4wQ
         4Bmw==
X-Gm-Message-State: AHQUAuYHqCPjzNe+M3zEMKDMhTtI/9IK3AGnbCSa3Qbh8Y4u+4+6PO78
        /p73FNHCs9AArfG/p5x0q+M=
X-Google-Smtp-Source: AHgI3Ibifu8WVM2y/+d93PbPuAKpJEnkZDS/GstIlnar8ZAJUoNz2Gdtk7B0AIDVOzjx5Y6YVudlpQ==
X-Received: by 2002:a37:457:: with SMTP id 84mr8228000qke.303.1550263130202;
        Fri, 15 Feb 2019 12:38:50 -0800 (PST)
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net. [100.15.144.194])
        by smtp.gmail.com with ESMTPSA id d50sm5612686qta.31.2019.02.15.12.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 12:38:49 -0800 (PST)
Date:   Fri, 15 Feb 2019 20:30:07 +0000
From:   Dan Robertson <danlrobertson89@gmail.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, felipe.balbi@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/gdb: fix linux constants
Message-ID: <20190215203006.GA593@nessie>
References: <20190215191713.GA28287@nessie>
 <07923abd-117d-2a33-2700-7db0840eacad@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <07923abd-117d-2a33-2700-7db0840eacad@ideasonboard.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kieran,

> This commit was pipped to the post by a similar patch [0] from Felipe Balbi

No problem! I probably should watch the LKML closer.

Go with the patch from Felipe, but like you men there is definitely no need
for the `include linux/fs.h` now.

Thanks for the tip on the Fixes tag. As a kernel newbie tips like this are
appreciated.

Cheers,

Dan

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAlxnIU4ACgkQRcSmUsR+
QqXflA//WsccYUFAps0ZHCBw+dozFcl46fopHC4AhuMJ+ZsDBLhldcVgL9Ru2A3B
tmanWN3mgMkdy+Ll17KJQzqugdAGEdIPicrkH+wN00PQu0Tt+Vc8VPYzk+3eq06h
AAAjGJlFGzqThdVVBWQHb2UeiPw0LhkZrRu8h/xNWPYYa2au9CLw3RQl4Tk9iblh
wLL2KKn80PKe4hIXQz1NM4EVTc85MFsQZ5gJjZIFblLQzmqxHJ4a/aY/F08ivLiQ
+2UYQKZzW7k1lgLvzbCQGCQ2RkF9XTCzJZ7qRTLDYdbavsNfBZHvhm/XZV0KZVtP
yFAnD4AgfddLwj+CARL4YN5PeSfwRA4B5oTNaDmSJ8k5PLjXPtbtYTGxeIB0puXG
1eDXIdFyJk3iNdtl4mHN3F+ZA6UGn+wGvE+ML8Z/yviTI1pZgIGNX42RNQ4h1Md/
RC+2faDD1QHyFlw8fJ4xkkRgjN8aKiyD4morS5GSIOzlt3+bYIRkJO8ayMD58C1B
SOy7VZ86AP5VutchGu02U3NEBmjaXqYLTzSzuRIzKE6gRA6CBYlCmqdMNVARGfEm
o6MRHauI89wuh7oJhOS75M+I1Z4Vh7WetsFQvXIscN64uZMu+njmD7v0lnF/tf4K
ldsVm+y3fq7eYaJJoB8FNLzvNjcvhix5RsrUIBREz+tkGlXkwxs=
=x3iU
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
