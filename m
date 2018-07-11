Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825B3C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3322320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="En6hg8wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3322320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbeGKUK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:10:57 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40155 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389371AbeGKUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:10:57 -0400
Received: by mail-qk0-f176.google.com with SMTP id c126-v6so5587701qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0D7jxSiOsas/kHOMVdv/hvfJyN+kOvJFoISnba7PNJA=;
        b=En6hg8wxnoyDMO7ziUurYUnuVQypvuRWWYoqM8wVYP1XG7osT7mC+0uyCdBJ3Kzhx5
         Oq9s1ipRsxoULXNJY/uOa4aiUB3ZIcOu4hVel2KAf02XhSi2NvbxRKItgpetEjx+i6NO
         eS9iJ81l34MuR9Rz4g3f3CGDqQs/0HLA5zWkl5HJvjz1kvD8ZQf7l3ZPtIlvkf6R/aJx
         40dR5iuonQCP+isBUTJEmaq20av+6ADho0IAyki4g5NUnFDRFNQpz3oxNdbm+B/HsKo2
         iqFR5Bj6mecu6pt1X5C4jIj8XI5ogvI7Pl0xx3n3/g553aWkPdLt0w2nQ8oAdMSxk7qM
         MXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0D7jxSiOsas/kHOMVdv/hvfJyN+kOvJFoISnba7PNJA=;
        b=Xy1GlXyH//d/IElMfOnHKXV8MXD4/gn4n4TqEwoGW82GWll8KLQ/2sn2dk+PYQbDw6
         DTLqSVIHuNknfgN93DoiNhwtcglcdHNrWZXT3iSqQRx2DUF5Kyll4+3hTsp4aCApu2Nq
         cyJV4KXD9FAKk90wfKV4DOZ8JwPy6Ezsv0H5PGKVoXicJVb5Y172L9azWXAiQTF70wZk
         /2fWpX7YWvh/kztCKL015PZA79oh625aoZE4AMmIWhBP6cd49Y0ln+isEVfID1ZLS5bM
         lDMrNtYWkY1YP3VPklEkLyko6tI32CFxPyHgC1/as4M7m5tLJvbUEPkKLRp4ckhjj1SV
         QbOA==
X-Gm-Message-State: AOUpUlHAz3pY3W73rFTYqzSaJlCCSCOx8nLt0TNjpMWiLZfeEKr/I7Fd
        2fCCx3+UTS36+cgJa1rg8xv/tg==
X-Google-Smtp-Source: AAOMgpdYO5dhBzaNBbLZSwcxmW/afcj1CIuH3Kd6ucMlUrxDg7C2Psaa/ZTe/r8gktET7mxW7J1Lmg==
X-Received: by 2002:a37:6544:: with SMTP id z65-v6mr38295qkb.307.1531339500619;
        Wed, 11 Jul 2018 13:05:00 -0700 (PDT)
Received: from cakuba.lan ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id c9-v6sm16974582qtc.34.2018.07.11.13.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:05:00 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:04:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 3/3] bpf: btf: print map dump and lookup
 with btf info
Message-ID: <20180711130456.5bbb8eb7@cakuba.lan>
In-Reply-To: <20180711032557.869819837@fb.com>
References: <20180711032108.631367556@fb.com>
        <20180711032557.869819837@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 20:21:11 -0700, Okash Khawaja wrote:
> +	if (err || btf_info.btf_size > last_size) {
> +		err = errno;

errno may not be set in case btf_info.btf_size > last_size

errno is positive, while other error return codes are negative.

> +		goto exit_free;
> +	}
