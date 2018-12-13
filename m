Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF06C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE2220849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRPUIpaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE2220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeLMHdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:33:21 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:55848 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLMHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:33:20 -0500
Received: by mail-it1-f172.google.com with SMTP id o19so2294250itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emcFNrV6+KkTZaZVcCwgcZGyWbWDkVLcNf9DWoN24xM=;
        b=BRPUIpazGCf9/mdzFPsfhkQfs/6sEywzM5HlsRliUGjBd05e9YnXwX9iXy1OBXj39R
         AFyw8spyZSEN9/MuJf5OfCdHPX/5qUjfyqz0qyv1pUVZuotSYrnSn/ZsTiFs2caOJY61
         oA0b6stjDxEuzVQZqQzF84kNqX9oCxY9mpM9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emcFNrV6+KkTZaZVcCwgcZGyWbWDkVLcNf9DWoN24xM=;
        b=F6BjVaEh4yrbhRn73XB1te4tkIiFo+MRq+N7iHISSki6WEbCW0RSds/sUCbIEVxQdl
         y1hvhGxFC/5QipRad3Zf/dHwaxVVqKlfWCQLfn9W0tiJXT9nswPdEcD3iApVjXSZ5BsB
         bY1iSMQaJbasxxXSUTukUFpApI2svdDfVXgc+OLHTs0lRAkql5W0bXVHXAfnqiPfgF32
         7g8gAIKUp46sBPkGwIQR8TIKh8gu0mN7ZYoOUaaI/CxSfodmMXscqwfUBNY5XyHu1osy
         /Uv1BB/7MtT5HcLk2+9L7wpDRI5DzgXhqPJTLiA1mbAfuoKJb0pB76xj8xswsu2oekWm
         Ux0g==
X-Gm-Message-State: AA+aEWaEeYanTnLaNQClGy7wGUZsOZn62glY0mtswlFtr3s9HLo6BfbD
        BrKfJsgghTalFQZrJjhwnu/56H05QfcLlgfwue1wPA==
X-Google-Smtp-Source: AFSGD/XjcojXWWkBsD1pZBgWIqoW7dhfglF2tZb5eYtQ1oJ1/sTbtI7yNTvdXdOicTgSWF+AKLizHnIL7IHiNJt2BHs=
X-Received: by 2002:a24:874a:: with SMTP id f71mr8381112ite.120.1544686399869;
 Wed, 12 Dec 2018 23:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20181212123121.GB29450@jax.ideon.se> <20181212213833.nretkviqn66bnxtf@localhost>
In-Reply-To: <20181212213833.nretkviqn66bnxtf@localhost>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 13 Dec 2018 08:33:07 +0100
Message-ID: <CAHUa44HQkwt8D=e0KtWu6NGmuf5QoJhjsx=ASRUEXmAtErqQMQ@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys for v4.21
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Wed, Dec 12, 2018 at 11:16 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Dec 12, 2018 at 01:31:21PM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this small OP-TEE driver enhancement. A friendly log message
> > is added to inform that dynamic shared memory is used when initiazing
> > the OP-TEE driver.
>
> Hi Jens,
>
> We generally try to keep our branches based on quite early -rc releases (rc
> 1/2/3), to avoid having to merge-back into our tree from upstream too much.

Sorry, I'll keep that in mind from now on.

>
> Your branch is unfortunately based on -rc6. Would you prefer to respin it with
> an older base, or should I cherry-pick over the patch from it? Either is OK
> with me.

If you don't mind cherry-pick over please do so.

Thanks,
Jens
