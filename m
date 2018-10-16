Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544EEC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B20208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en/+OqV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B20208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJPLBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:01:16 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:41887 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeJPLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:01:15 -0400
Received: by mail-pl1-f171.google.com with SMTP id q17-v6so10254254plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TeoXwEjmoqoUD4Y3LHnnFfMwqDm3UWlr+gCKaEwecwk=;
        b=en/+OqV9xnIr6snQBvZ4cYCNdKkJKD+0ztrEHjCuVcOA0SJSDacccMHnWiaUT6CsIc
         esSk5bysV7Y1hv+VCNli9ad6Mwjnp3EGOiGqF9/iliUkSM8Yrp3XMs9tuGzgwghhfBGC
         OHvKjsZNUsglLU18YNa1wExZXiIA2B1g9FmC8d3xYoZg12ReFihPa9uJuTTFZooW644b
         q0QnpGRpwNOd6fgzosdZd1fffAYtP3OYq2uLMqmUozqnkOPXDEqUC2H766jhpeuj7VNz
         PKcEC/rIhutu1exR1q9FhF3TYzF0JoIv2+nIM87QVkSeRstjxtQxPK+BapSz6uvCNkiL
         Ilxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TeoXwEjmoqoUD4Y3LHnnFfMwqDm3UWlr+gCKaEwecwk=;
        b=FOEUHKoOBoWGosNnb5i13VyeJYfCOPljrBQ6EU332NT3Atni6XY0BgqVhyX7n5Yw3w
         cQPrYJhen5Vhm7lw5Frw8xiVptji63NEKf3MGOnotQ4vUp4702/QOWM4HMcKgbZCXLuy
         Id3Xd/20fsFpLiPYpm1q9xE5UlhiqQWKILQL1zLxJYIsDLiCvFaTd2BhNo+xQldw2dVB
         0MTWwh7EZgx/fFOucvgPMMFOBVnYk95d3owEvT+pCreHyXioMxXlhJ8xqwuUQhLjiKsC
         Iz6/hVJJ6QtuIc788eTTIyMg4uaT52AYikRvFUjJrC5HZm2MLg6iqETiw1nDpRB+gvGB
         Nigw==
X-Gm-Message-State: ABuFfoiARAolnkm5N2SwsY0jN9cErlL0YzTjNxzFuX7zF8GSdFBaYM9v
        8kmO52sIQvmmBwtyBclR0LYt7w9mU22p5GtV7V0AIg==
X-Google-Smtp-Source: ACcGV632/Lw9CqO9U+qaxTSOCow8c6jBwKM/vPPlCAmIXvPuPIv+dsg78Rbt2ohYDNj05kbhjjhMKsL91L49O4QEu6g=
X-Received: by 2002:a17:902:a7:: with SMTP id a36-v6mr6708943pla.87.1539659584743;
 Mon, 15 Oct 2018 20:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAES_P+8_H_by1_Fk2pwn6ymJcuwf66wiarFXsm7_=uPZnnCMDw@mail.gmail.com>
 <CAES_P+_Aoufy-2JcE+h2U6KNgRkCjdeZDUNZyeFm=-eWhxdfpw@mail.gmail.com>
In-Reply-To: <CAES_P+_Aoufy-2JcE+h2U6KNgRkCjdeZDUNZyeFm=-eWhxdfpw@mail.gmail.com>
From:   noman pouigt <variksla@gmail.com>
Date:   Mon, 15 Oct 2018 20:12:53 -0700
Message-ID: <CAES_P+8jZUMRBSjaNCbWf5EHDw8r96kOXcGWf4WR6svPHcb5_w@mail.gmail.com>
Subject: Re: config EXTRA_FIRMWARE not compiling muliple files
To:     linux-kernel@vger.kernel.org, dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 7:22 PM noman pouigt <variksla@gmail.com> wrote:
>
> Hello Folks,
>
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE="first_image" "second_image"

figured out that it should be in one string as "first_image second_image"

>
> request_firmware for "first_image" is passing but for "second_image"
> the loading is not happening. Is this a known scripting issue?
>
> I get "Request firmware defered -11". Please advice.
>
> Kernel version:
>  VERSION = 4
>  PATCHLEVEL = 4
>  SUBLEVEL = 21
>  EXTRAVERSION =
>
> Thanks,
> Variksla
