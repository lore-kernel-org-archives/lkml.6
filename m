Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5144DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 18:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1519520851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 18:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ2po9/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1519520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbeLBSu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 13:50:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbeLBSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 13:50:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so5286598plz.1;
        Sun, 02 Dec 2018 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNf34st5RBbwEPNAPoI4UJmDcemSs3UsebquzSehCHE=;
        b=JZ2po9/jYqCgMpi90gk3oQsT+myeVou7XcgPDjNaMgQpsm13U9LlmED9pPM2dIAjU6
         wrydUn13rj2ZIcojRMF7tLRlwQZdtmKDnifKDG//Uau6oOg/Umg6OTpJD9EdeEb/LZlR
         5FD+LmOQ2eiaEtt+In24AfiQ5l+Kj4oZ5P3NrPDzJxb8+jg0e7LlsPmHzx37E3GI7qym
         JgJSzV5KsOYGHg/Pul30b3rSnKqfeUKT92Z2PRpzmL2dzWJ2q4MdhgWJFiy54YzTffsW
         AFoOxCbjWXJ07qEsVxbshAl8479YGLjqgVphb64BYtffRchmeVtlgZq9jZuWYUkRbzUB
         qoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNf34st5RBbwEPNAPoI4UJmDcemSs3UsebquzSehCHE=;
        b=VtMrLF9iyuLwS3lhlqVGRwrNgb0hK1wmINYIhdYsgSc1Pc6sAksxICKAubMWRaCCkW
         aAB2xIJBLr6uHLTvtP7wWDR5UGoC3vfDvkIVu4nO8Mr0ten5CZS0vLnyE/r5PC72sLWw
         6MAB5NFBY+0N2zy7k7XMs+n2Qw2NrXRxI3sQ5t33chUVT0F2ErngzUVDV0JcgMT1vlij
         jcmL3Ggxx3se7+CKnQuZPtR8VQToDM5RIttRvgmDE+pmFCd67UvZWPpI5noFp52rJ6Sj
         gMSqkWKpJ8ieGS1Y5/qsp18ui6WH/VE7TsbznBsQ+5M84P6rWE1h9F/rhf/KObi3Lr/1
         jQvQ==
X-Gm-Message-State: AA+aEWb+301lYpk1b0IJcyf5i8iwlnC0cFAZ4huPr+QzRfdnbcOWayIo
        Uu74aU4sqERAwUsmmJd04sA=
X-Google-Smtp-Source: AFSGD/V0odeX3hLg8lKxcPneXIFvWL2FW2v1nvAIitJo+cOAT6EEbiox2C6qnw/YXmoCe+s5mLcc5Q==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr13489562plp.180.1543776652462;
        Sun, 02 Dec 2018 10:50:52 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id v12sm18978926pgg.41.2018.12.02.10.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 10:50:51 -0800 (PST)
Date:   Mon, 3 Dec 2018 00:20:44 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, joe@perches.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <20181202185043.GA2007@himanshu-Vostro-3559>
References: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 02:57:12PM -0200, Marcelo Schmitt wrote:
> Add a devicetree documentation for the ad5933 and ad5934 impedance
> converter, network analyzer.
> 
> Co-Developed-by: Gabriel Capella <gabriel@capella.pro>

checkpatch spits out:

WARNING: Non-standard signature: Co-Developed-by:

Co-developed-by Vs Co-Developed-by ?

Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:

Confusing! Don't know which one is correct.

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---

Use `./scripts/get_maintainer.pl <your_patch>` to list the DT
maintainers and the relevant mailing list.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
