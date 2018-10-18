Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E336BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp5YVzNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A591D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJSEpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:45:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45436 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:45:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so3371540wrs.12;
        Thu, 18 Oct 2018 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TLTOzP7HleIDbOL49apn4/BPnejUyTauqpxbv743E+o=;
        b=Lp5YVzNlSo1jNOKV7s3aEbFIu6g0EsLjrDRyef4/nlB5OAe3+5O4+BoG2IeHc+tiir
         X+p2K6MH9Pj526dFZ6TbsGDzqzKm4DUDEoLaG8oUdduc2y7MuY4R5VwfpW/wc/6/zVI6
         ApE5OiP6BbQhXFEgkQZzqG5lThlzaOBsv3WRN3sGma2RRgFiOmZQJ7lcVy/FZEXzSD+7
         EdOx4VVrJLE0ZEe4yimaDrApLJ5WRuvtPFkck8uC9HMWJZcAoE1oeilFY7MYZsJURFkb
         XS2Y5t4RXQ8qfHtPsS+kDT2+iKKe/6tkR0jCGiQdeaRQ3NxTSL3OX66rzyvfn3pjeYV+
         Rpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLTOzP7HleIDbOL49apn4/BPnejUyTauqpxbv743E+o=;
        b=d8hcjtyTOQPabdAktq6KouYoLPL/uI0peSxSpGNHIsTwGWe8ixePNY7S9XocLqrfGi
         wWDeqiUHB8L6yMQDGdM/IFVMi+xw2mrwRFi0nKzDQQAvLwY9x4T3jE6j0tU2UjjKRypK
         nab4udAcxZ+V2siOeFNHir79f6qWSxyKr6th1FEPrqUMO7jWc0bMGjRi7SS7acHTSv9w
         NwvS1YaBNS6Ja0FPfdOGHpLOoNmXHvrLdCdf8pLrCqusGwgPZ5z8o10ZHMj6X5G3OiMI
         EX23YIHMNqnDo8QjOLUayKGQPzfD7AuqGVY0VNqekKiR7a6hagxw9WGZYZh8fWrNN+KC
         RDRw==
X-Gm-Message-State: ABuFfojLO15lpLtmfHiKHBMxCQgddaJT0h77SIn3r34BPy712Fr4h6E5
        juUmbnyzT6krCmpGb64g1oXwCd7mqHCGHA==
X-Google-Smtp-Source: ACcGV617gM+Mq2tU15lxNgaVAiepcN2venqwpc3iw0D+Zq6BUcReWHmHCF3SPZk/+DMbb0zfyzI9MA==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr29697940wrq.225.1539895347575;
        Thu, 18 Oct 2018 13:42:27 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r16-v6sm21858094wrv.21.2018.10.18.13.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:42:27 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:42:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] clk: s2mps11: Add used attribute to s2mps11_dt_match
Message-ID: <20181018204224.GA7122@flashbox>
References: <20181018191340.30440-1-natechancellor@gmail.com>
 <153989459788.53599.2276628850158968119@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153989459788.53599.2276628850158968119@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 01:29:57PM -0700, Stephen Boyd wrote:
> Quoting Nathan Chancellor (2018-10-18 12:13:40)
> > Clang warns after commit 8985167ecf57 ("clk: s2mps11: Fix matching when
> > built as module and DT node contains compatible"):
> > 
> > drivers/clk/clk-s2mps11.c:242:34: warning: variable 's2mps11_dt_match'
> > is not needed and will not be emitted [-Wunneeded-internal-declaration]
> > static const struct of_device_id s2mps11_dt_match[] = {
> >                                  ^
> > 1 warning generated.
> > 
> > This warning happens when a variable is used in some construct that
> > doesn't require a reference to that variable to be emitted in the symbol
> > table; in this case, it's MODULE_DEVICE_TABLE, which only needs to hold
> > the data of the variable, not the variable itself.
> > 
> > $ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_dt_match
> > 00000078 000003d4 R __mod_of__s2mps11_dt_match_device_table
> > 
> > Normally, with device ID table variables, it means that the variable
> > just needs to be tied to the device declaration at the bottom of the
> > file, like s2mps11_clk_id:
> > 
> > $ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_clk_id
> > 00000000 00000078 R __mod_platform__s2mps11_clk_id_device_table
> > 00000000 00000078 r s2mps11_clk_id
> > 
> > However, because the comment above this deliberately doesn't want this
> > variable added to .of_match_table, we need to mark s2mps11_dt_match as
> > __used to silence this warning. This makes it clear to Clang that the
> > variable is used for something, even if a reference to it isn't being
> > emitted.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Just curious if this is a common occurrence? Maybe we should make a new
> MODULE_DEVICE_TABLE macro that can declare the table, struct type, and
> add in __used to the declaration like is done here? That way this gotcha
> goes away without us having to remember that the table is used or not
> used somewhere.
> 

I've only had to fix two of these warnings prior to this one, running
arm64 and x86_64 defconfig/allyesconfig builds but as soon as options like
CONFIG_OF or CONFIG_ACPI get turned off, it can happen quite frequently
because things like of_match_ptr and ACPI_PTR turn into NULL, meaning the
variable doesn't have a reference in the symbol table anymore. It would
definitely be nice to avoid having to paper the warnings up.

> Anyway, I'll apply this patch to clk-next.
> 

Thanks!
Nathan
