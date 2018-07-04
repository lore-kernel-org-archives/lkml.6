Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EA521570
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFpsOlbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EA521570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGDTzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:55:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51674 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:55:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so7743128wmc.1;
        Wed, 04 Jul 2018 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:cc:from:message-id;
        bh=9nNqspe0aLE0zVJ0b/kmbbb+8oTLRUZpaaiAnF5Q5Vc=;
        b=VFpsOlbijybgS/GkhxchVsz3xMU/QeFYGaUJj5ioE1iKVeChEr4kFV03yme2+aIQhc
         Ql9hPkvrQ1GwKeBzKghWaNXHgsahru2SRVhmJC54NpjpNL83I+O30MEr/pvGRu1Tar2k
         Uj4cYbsOVMZvRY6ek2DAA8Lt/pgl7PfAdYzHk0rqc7J3SAGiTi0m2wvZEdqx66Rg7eY0
         iV6gm3YT3EjQ/hhRkL9kQjAA2hSNd502HofWsaqAsy1VGPXREYpVNJh3ULJZnDdd5XNX
         0qk3pQ8sD7mQkI3NtyHJQ32/kpQq2TSSlw+EdXnKUQKFiWcamPkJu8M2uwmfWEjH73pk
         slNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=9nNqspe0aLE0zVJ0b/kmbbb+8oTLRUZpaaiAnF5Q5Vc=;
        b=EoPl+g8jEDVb7sd5bCxysELnH8vygOT1m5GkaUXGv5kIDqYiOXPCZ9KjYVA3SlXSaw
         NZL42hfhqy6PBFayz2ThfBq60+ahbmczNQyJ2PIkU2clD/mbmmtx+E5Fmp/P8W9inxC7
         83h3ZKWilGEZoKt4yt8/9IWt5g9Fdf5rFCazxX7ROBTsZ5fu5x+gnTrsgyhY/Jh4hcTF
         8WK4gl15Hf9wfOiR4m/RtHo8z1HhojHkiCwGtMc668mQlj3aUH+3ab7/9sEu16lRRbA1
         es2Li1tGaCac1+LrTOOk5cyZ6gkF9zkFETmZelDPhMgN2OJEDQAJPZBvPa1DRhjC/ZCS
         U+WQ==
X-Gm-Message-State: APt69E0+fmeKZPlWLPUJgoW8d6yqVbecTG19hGXFezJMZrLdUVg07NH1
        N0RTU50WJmgCjV1w/GeSK6g=
X-Google-Smtp-Source: AAOMgpcx3o7PF/x5fDPfSqXeVe9U2dsdR6v53nmgitVIzs3iianStZkgDoHx6m518n5udOw9PNci9Q==
X-Received: by 2002:a1c:b94c:: with SMTP id j73-v6mr2532151wmf.104.1530734133107;
        Wed, 04 Jul 2018 12:55:33 -0700 (PDT)
Received: from pc-18.home (ARennes-658-1-257-227.w92-135.abo.wanadoo.fr. [92.135.240.227])
        by smtp.gmail.com with ESMTPSA id u7-v6sm9647493wmd.3.2018.07.04.12.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 12:55:32 -0700 (PDT)
Date:   Wed, 04 Jul 2018 21:55:28 +0200
In-Reply-To: <20180704142520.GD12405@lunn.ch>
References: <20180704065436.13719-1-colin.king@canonical.com> <20180704142520.GD12405@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=mQGiBEjPuBIRBACW9MxSJU9fvEOCTn
 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
 uUuzv+GKZ6nsysJw==
Subject: Re: [PATCH] net: dsa: bcm_sf2: remove redundant variable off
To:     Andrew Lunn <andrew@lunn.ch>, Colin King <colin.king@canonical.com>
CC:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <A8CC1885-AA89-4A72-92B6-AF4578559984@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 4, 2018 4:25:20 PM GMT+02:00, Andrew Lunn <andrew@lunn=2Ech> wrote:
>Hi Florian
>
>I this a bug? It seems to be a result of moving to
>b53_disable_port() in f86ad77faf=2E
>
>Before you would handle the CPU port differently than a normal
>port=2E After this change, there is no difference?

This looks like a big indeed, I will check that next week=2E

--=20
Florian
