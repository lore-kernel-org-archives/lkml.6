Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88503C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C8021470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W57qaXK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C8021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJMC1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:27:39 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:37270 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJMC1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:27:38 -0400
Received: by mail-pl1-f169.google.com with SMTP id u6-v6so3600305plz.4;
        Fri, 12 Oct 2018 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MC9Q2Mi1oj5+chJ9eaISw4TjzTzeM1Pt8XXVjQ4WlWQ=;
        b=W57qaXK7iE4tBZ2+cGhb2gvmWQcncPjoQeRQ9F2NQgKBkxxqDyI0PCAdklZ3CPFGLL
         xs4aZor3Yj4yD00EirdASaROHgXqEjfcE0ahi1ldPBw5HWKGUgs0kRJEBGcLH4mBPIsV
         DmyDRVepZCgbp/WADFpWuUSlCEXR4mIPqBeE+dW5Z0n1AZGABJTGlQCLvS3X70cW3QFI
         4eb6sSbfnNWQXS7b7jnP97SQRpekS9LmG9DUmfWysljbEj7/F/VvFko/Pe8K1Q4z2Pq4
         9hKbKywo9Rb0+hdw3pPOp+qAluGDsh8nDZ+1W3U5Vk25UJDS/J0kII5zcsk6yN+Hka9a
         sfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MC9Q2Mi1oj5+chJ9eaISw4TjzTzeM1Pt8XXVjQ4WlWQ=;
        b=Nd5KX5lOuOPUVz0HgLmM5zEk5eD3S5i+u4nvEU6mRoLFzqPTEAXd7RzsabrQ7t5u55
         FGTINoGQpgoaBZnpEL9GGs60DbikrUuPsdy8Oaj3VDQ9S8GvRqeCNvru94YR+vbVBE31
         Owf3jYbEJOR61nKNEUezTr1wHTEPcuaub81Da3JnoJkGGVJI/w4vEh+JUkrGy5vzmG+f
         sTCFgRpXV/OL5bM5UZtc5P1xC2fJBf4Gk73PvZ16KryJvIPgd5t/R5z79ZUpuiL2j/uy
         +Iq44CbmEdXod956Ncl9eWunwNEHHBDApSgKpYIidGjUVhWZKw5UNjetnd3v2Rl06QBe
         E1vA==
X-Gm-Message-State: ABuFfoijj7e696cjVmlI+ZIWsexsw/XDLXKVFY3QiLUPU0p/V+M8yTLB
        IIZDDwknNd8E+plavmweltw=
X-Google-Smtp-Source: ACcGV60KjpAuk9kMdHJdGPSEFp03Mu0XlVcj+x2zGUbTgcXDUnfzfPK3zhuvoLSmRLJEtc0UNwanPw==
X-Received: by 2002:a17:902:76cb:: with SMTP id j11-v6mr6946661plt.258.1539370425452;
        Fri, 12 Oct 2018 11:53:45 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y185-v6sm3079210pgd.8.2018.10.12.11.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 11:53:44 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:53:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix Elan I2C touchpads in latest generation from
 Lenovo
Message-ID: <20181012185342.GA35430@dtor-ws>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 04:24:08PM +0200, Benjamin Tissoires wrote:
> Since v4.18, we unconditionally switch the I2C capable touchpads over I2C.
> In the model I had (a pre-prod t480s I guess), the touchpad was behaving
> fine.
> However, it occurs that later production models don't expose the clickpad
> information from I2C. The Windows driver gets all the information from PS/2
> so we should do the same.
> 
> The situation is even worse for the P52. Once of the query parameter function
> fails, which means the touchpad doesn't even probe. This effectively kills
> the touchpad, which is less than ideal.
> 
> Dmitry, I am not sure if we should take those for stable in v4.18+.
> I'd like to, but given the series is 5 patches, I don't know if this
> will be acceptable.
> We could revert in stable df077237cf55928f5 but that would mean
> distributions will have to revert the revert if they want to provide
> the I2C behavior.
> 
> So, regarding stable: your call :)

Heh ;) I think we have to fix it at least in 4.19 stable train. How
about we merge it normally into 4.20, and let it cook there for a while.
If there is no issues, then we can send it to 4.19 stable manually. How
does this sound?

Thanks.

-- 
Dmitry
