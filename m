Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999EFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE48208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE48208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeFQXXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 19:23:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57548 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752919AbeFQXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 19:23:32 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5HNNWg0008349
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 19:23:32 -0400
Received: from mail-qt0-f198.google.com (mail-qt0-f198.google.com [209.85.216.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5HNNRZG007746
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 19:23:32 -0400
Received: by mail-qt0-f198.google.com with SMTP id f8-v6so12703119qth.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 16:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=BxATfzqFKmGEq2qwbSneWzHiBTbXJNitojQH/T89Ek0=;
        b=F6gvxOSReEHANY0iBg2b/e7Vh0q+8H6yJLG9Rzi3npw2kT7MGIeFktGPITn3qiT9iv
         sgi4qcHqKCu/w0+Rby3DfO2HukWP2mNgSdnhKNc+8LNWIkUac1K3yc0bXYt16QwybXlh
         +uGvapMA1FBRzI2wslt70IA7AfeZgZhYs6u6o0LdKFcCztO2bISPUYJkkWeXFtqEojgE
         XRbhOcB3+awSrAVhT5dsfahz4fi3kSIFScJk7X0ocStUPgxQC9/I62RoZIaehlNY3ZMq
         ciISI0aKkyj2vz+SuPDddqqo8r7C6qKQ508eN0SxDevqgS+RdXM0doJYNPaz3ugqOpN6
         UcUg==
X-Gm-Message-State: APt69E2qN84Mlow5JkZFXM3Sy+TqkO9ay9N3/kk5Dekaa99hkQSUsZaj
        A+lz7zQRH7YGZ1fNPy+qm8KClcuJQ4Na8eRUucaO/gpUW0LJ3N29IZussvb29+1dMDpULSx9XGE
        Lrp8xky4k9FvAItg5SpE6OIwvri1lWgVxHHM=
X-Received: by 2002:a0c:90e1:: with SMTP id p88-v6mr8781175qvp.145.1529277807217;
        Sun, 17 Jun 2018 16:23:27 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKJEHZ8RvTksQAuu7YN29pCxjgogmbz1lpvgumGAa40T32wicAm9PobBrc0CACdzgNr7xGsTNQ==
X-Received: by 2002:a0c:90e1:: with SMTP id p88-v6mr8781163qvp.145.1529277806995;
        Sun, 17 Jun 2018 16:23:26 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:2116:22ff:b17b:7cd6])
        by smtp.gmail.com with ESMTPSA id p51-v6sm11471937qtc.43.2018.06.17.16.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 16:23:25 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] vt: preserve unicode values corresponding to screen characters
In-Reply-To: <nycvar.YSQ.7.76.1806171909250.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180617190706.14614-2-nicolas.pitre@linaro.org> <117799.1529276384@turing-police.cc.vt.edu>
 <nycvar.YSQ.7.76.1806171909250.16670@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529277815_2593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Jun 2018 19:23:35 -0400
Message-ID: <204888.1529277815@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529277815_2593P
Content-Type: text/plain; charset=us-ascii

On Sun, 17 Jun 2018 19:17:51 -0400, Nicolas Pitre said:
> On Sun, 17 Jun 2018, valdis.kletnieks@vt.edu wrote:

> > This preprocessor variable seems to be dangling in the breeze, with
> > no way for it to get set?  As a result, we pick up the #else define by
> > default.
>
> That's actually what's intended here.
>
> If vc_screen.c ever becomes configurable then this could be used to
> compile out this code. Or if someone wants to disable it for some
> debugging reasons. For now it is just a self-explanatory placeholder
> with very little chance of being set by mistake for any other purpose.

Oh, OK.  It's code that makes sense if it's intentional - but could just as
easily been an unintended debugging/whatever leftover...

--==_Exmh_1529277815_2593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWybtd40DS38y7CIcAQIQFQf9HXDPSvciReAmSJmv1yDb1Z5NEvELgzHO
fsYkumb/fRffwTt3aKQYXSw6ijwd6TqonpUVpdpWAgfSKtjaJQNlBbLQubu5j0zJ
FK0cIbFSLf0ABcOtafFqaLIVSIrfbjrKyCBCTGllxlocZxE60zYWdTnhnzwFYN66
32+qGShB/y6x9X8irJMEiZWya5iLutlrUTbsOBGXVg1dxzTv3LtcmnMZX/308qwD
iGZMqXFWeg16hNAAADCbTh4UlNBZ7P3xJVGQZKO0sn5sCMvDxNHyqc1FAitQeadf
/+Dgv5ZHF8SXRlzjUzBbhq2VQuZ+cXhFd8XiiNz2xzhsWiAIZKchwA==
=k3xZ
-----END PGP SIGNATURE-----

--==_Exmh_1529277815_2593P--
