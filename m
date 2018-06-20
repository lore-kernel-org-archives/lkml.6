Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5835EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0726320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUlaYA5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0726320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeFTSKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:10:55 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36200 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbeFTSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:10:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so184696pgd.3;
        Wed, 20 Jun 2018 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Iz4GiX3evuAjsqQOH6pEItNnY6xJ/UvJALIu++BiZE=;
        b=hUlaYA5+3nFDM19SRrWME+On43SWYwm62zOHmE3IEQXs7c6s061FP2fIT43+PwsF0J
         AekDQn9dl1N3ngBDH9EqjSG+Ib5nX/RsCEUM8x9mgdo5T7x4hf8ytVVg+275KaeQuaOA
         YZ4uLeLc4mWo3ldyEwuQQwHgZnMutFzwQcp4F7JIDL7gMmORit1LRd18RGTMOMQcuQNO
         A9VDa8K49Ev6vgH4pNrLcfAcGvsuPmGuJZRo1tGwVM4sh0XAenzp58jgXGrp5ZqgXcqL
         FOs8frVCrqLK+iR+MBXY+1hlbN6KEy3fGwdqnusgrKwBAEtnwk2caTV+c3bQHWyNvt/j
         Bjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Iz4GiX3evuAjsqQOH6pEItNnY6xJ/UvJALIu++BiZE=;
        b=VpOs/0atPg2CF7Tl7C7odzwBGhD5EXr4CNOy77lh10iO4L+eN//mW6UiyiVAXPvIKr
         vgAnj5+TI+eaM0Fln7kPkSu/XLwA9tNmLDaM9lCj8T02rnDAoarEG1K9D8ixQ2aISH2x
         syEA9W0J+591rio0SAEDZ3kbp9QTFmuZiYmSCt9Jz6lAxIpc1x6HzfLTwSjDb2H4D76y
         UCUFud0w7QNPP6g0ngY+TNQo2vuJjmEd/DBKXuLV9RGtNmrjj5xQFzvdpVcWf3YvjScB
         Sme/wtBZr4LUyO4Dm61lgrPdBRRfpormfGfC5iS+0xNAz9GTU5dtPE2T0sEKlB3qGQ/p
         zDzg==
X-Gm-Message-State: APt69E1zW/1rwCX6FZdqnGPYCDx1Ei9od3EL5DQ2oKM3JVIW264miW8n
        ZzgzWT31qTW7824wfIM7mAXQ3f5R
X-Google-Smtp-Source: ADUXVKJeNpv+bvL56HsV+ZphcxmGG7Pem2Mvhm4kLnulOjtdT8v3xgOe2xfrEnFV/F+xAwUe9bT5qA==
X-Received: by 2002:a65:4e09:: with SMTP id r9-v6mr4332264pgt.369.1529518253492;
        Wed, 20 Jun 2018 11:10:53 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id a8-v6sm5845507pfe.72.2018.06.20.11.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:10:52 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:10:51 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180620181051.GC76265@gmail.com>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 07:57:14PM +0900, Juan Manuel Torres Palma wrote:
> Adds test vectors specified in skein v1.3
> specification. The main code is still in staging
> directory, but this is required to eventually be
> moved to the crypto directory.

Also, can you describe the users of Skein in the kernel?  If there are no users,
there's no need to move it out of staging, or even have it in the kernel at all
anymore.  I say that as someone who has had to volunteer to fix critical bugs
found by fuzzing in crypto algorithms for which it's unclear why they are in the
kernel at all, as there are no apparent users.

By the way, syzbot [1] doesn't have CONFIG_CRYPTO_SKEIN enabled, so the Skein
algorithms aren't being fuzzed currently.

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot.md

- Eric
