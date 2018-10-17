Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B22ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA3F214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujPq52DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA3F214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJQQks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:40:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50673 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeJQQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:40:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so1120727wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pzKM45rEHQrM4/dzJvKnJ9h7JWCcDwNPBoET0Jx8Og=;
        b=ujPq52DGbla0jR4w/mtewzWJZWtIelwZRDc2QxJColNWHf3sH4+mS+MfL90KYPKPWP
         +92045RH72Q8lHRqqSCZ39ouwlj4QLiN1P13j8/pMs4Ed/6XBNaVfeF8hN7kg3A+U4w+
         EynGVzRtXD3oHuMlrHPyL//l8JVUEgcT89hJI+b7DqAtljNRfcoy+DDVoi3KffohG0Sv
         YqkT7YnbOTOLVJuSYfOQAdV2LKtKUlkKTp9lYs+uTeJxD8Dm99/etHNhFonad0ZgY0te
         eFaBDmV9DPsU35JyimxK2s5iA+CwjFDZWX5VSr0f0Weto45FiMX0NH0gCYAu3E8a4L7Y
         +b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pzKM45rEHQrM4/dzJvKnJ9h7JWCcDwNPBoET0Jx8Og=;
        b=A1+113EjB4g/6UjhXvLW+1FjVmydzDSLswiPJDlx61S12WcufN982ZqRbOhqydRIgF
         5kr2cUrKv5NnIqXFxR6dHKIsoqaTButl4N1YVF6pQ7zNf5AO+Bt2SlJnT6xzsStpKarF
         7QoAmHVvqcSLNn+fGpLJCt60v1a9xPcZq7CbbkDu6OnsJS5bHZ5SYngqkCogMr6+xitt
         1CXwnxlnvUJBz26uzLDNHMXt2vEvMco35gj44+PdTpEabuQGoTxF8MvRwuIqU6jxJNGm
         sekIPROut1zBhdq7CbbdSXSPJ7W1eXN2uqgaJxnn0PwX3oA6FpquUSbDMNPQjV1ryXeB
         wsXA==
X-Gm-Message-State: ABuFfoi6SHhFitrxqmHXy8OD8YwCeU1pV5p/YeyDDdShG0YOPScl8flZ
        AT8a07ZQPcSFPOy1L53FGKfIIjk5Z8wcWWIJWCw=
X-Google-Smtp-Source: ACcGV60AgdqITQDH5HCXogOleUGGSp6wyBlsIPNQG/bRzeHlmNvxQu+dd2jh91p6mD2bcoxKHYYxHJv1uuNNUEL8vvA=
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr1759861wmd.17.1539765967464;
 Wed, 17 Oct 2018 01:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180928220507.31886-1-joe@perches.com>
In-Reply-To: <20180928220507.31886-1-joe@perches.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 17 Oct 2018 10:45:55 +0200
Message-ID: <CAFLxGvyevwwDbxFy_PAiwHh5Dh5znS-=3baoVKe9rPTGU1oCEw@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'USER-MODE LINUX (UML)'
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,

On Sat, Sep 29, 2018 at 12:06 AM Joe Perches <joe@perches.com> wrote:
>
> Please fix this defect appropriately.

Care to send a patch?

--
Thanks,
//richard
