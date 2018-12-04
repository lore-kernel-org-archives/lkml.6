Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487CDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE08E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0edCxwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE08E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDD7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:59:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50915 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDD7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:59:08 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so13215291iti.0;
        Mon, 03 Dec 2018 19:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/TUXQkDecxV+DbVPzfICCeI9ltQTIptfUHQH4G2Ye4=;
        b=c0edCxwYAPESpWF2NSmVqyeXVzBaIo9emEa9AfsYzaz32BeHd+moiSQxQTWXiRaOdT
         zkFCVCjHl6ymm1NoC+UDYBqMZ2wVEydhjyD2/WIcnKKGUsTh4RQFEE4cOO3nfRQo4NOg
         uQ4bLzqMLgrgOrvdkPrA+qf2QMgNl/kGNfmZwyRE38et4Fk+fRKMaOq/cW+42G3keCQ7
         YqbZJDdLU4Tk+Of7JGBT+EGCFlJ3Q+0rk7meLUe2uNIotO3C/v3QVIcJXEhRupnfpy7H
         FW/Y+hclVnJmoN9BPuHJqwirDt/vPq6191W8pVjLyrEVDCGMPSa0IlqsbX95zP33lp5R
         ITaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/TUXQkDecxV+DbVPzfICCeI9ltQTIptfUHQH4G2Ye4=;
        b=avj62iWzyUdZQUC6uVLWE/y2/B/7NzHghCx+bjwreEZQYwZihd6R5crGGo3b5f6N/q
         VLleyMpVW0ueXE4KBL5WmcsLHY5HJGpuV5e0Yfua8zscR0ZOB62CE6etJeqYXJtfhfiU
         B/NBYtrCIsx3B5qqiY40bHqoReq9OBMnx6E7t2azNFdru64r55jqymJs8tgoGL2nNDJG
         daqr1OcKPruQWan0jPsWG3sbO9JMqATN4TCP1W4T/FECRguNQwSwkByEHmFkUwcAecfX
         FYd0wTG7BzW7g7SCmONfoeI3yn0dwjqo12yqC/8XajCF8oPJmQbl886jdCgZdsUoJqJu
         dQSQ==
X-Gm-Message-State: AA+aEWaqkbprCoaa4dY7A17hdgEFCxu/a/6GxnDQJ1idjpW0dNIxqvK2
        IHvCX9gEBm1R+1h+PXFzZY8hPUiQadWMjzaZR1Q=
X-Google-Smtp-Source: AFSGD/Ugup/kpqEiutCBi4meyn0ikZypRQ2hAEvAB50n6Z9sMUCqxnyscqzx83R1EEfD8ByMgvCtO+cEcFF4pbvJkS8=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr9900578itc.37.1543895947701;
 Mon, 03 Dec 2018 19:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
In-Reply-To: <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 4 Dec 2018 11:59:40 +0800
Message-ID: <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     andy.shevchenko@gmail.com
Cc:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org,
        David Box <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 3:09 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 1, 2018 at 5:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> By some reason it's not applicable.
> Please, rebase on top of our for-next branch, thanks!
For what reason?
 I thought that for-next branch has not changed much.

Yours,
Yangtao
