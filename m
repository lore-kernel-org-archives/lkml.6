Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E64C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F8B2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKuXw6fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfAHFSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:18:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42451 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfAHFSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:18:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so2696365wrx.9;
        Mon, 07 Jan 2019 21:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n5JdPnvzjvgFWP5+T2mB8m4M6VgJH5RUgz8gQVlRjWU=;
        b=uKuXw6fqbP6YOSeNmD72VeMtchfX/fJqxB094BgSzJhi2l6Ckp/TmRXRmIqzF9LcVH
         T2uG5HiK4Fip6xGsct5ygo9HSCjj2gqk6Nr6falH8LaAeXXST8+kMuFdRIKj+NeJIM/3
         x7zOcQwo9Iz1+KS6CaeyvjQ3g/I37pWfkbsgiBdpsEwXdtcnSYqpZJ7QyxnHMkuksN0Y
         yCTEN8hfpwZAlgzBcfnwqo3mvVZLXHLPA4Htm8nlAhwf5Qh4kkYBXS3UiLdEm/k7jJFU
         G1dB5xQdIG1sO/mPPozeoqZISIDmBh/WNpUxZeyQmiaiYGUW+utUOS6wSl9+M/Dbnclm
         eUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n5JdPnvzjvgFWP5+T2mB8m4M6VgJH5RUgz8gQVlRjWU=;
        b=S+iOv9mAvpca89Tj1kzJKbLossquVB6fLRdXFJMY0IWye6e3wSNNQvKze5eaZ0mMph
         i/851X2UeDeig4i3do5BKv1YZ57AM9ucLKyheRlk0HSd4eX/n0inTBbUzFmex650xxLs
         rLKfphVRefkpm+jzUIoT1krGZ21C3+5TNJCRf3Hci6i4Qr8yh9NxjZ3uUlMZM41wIy/3
         oScyRlzrZ9rCaMkCu9fbkoYeQ0ustx5NSJprTvU6h8LOAdUH+IAClZO9+QttjtsXwy2/
         aJBz4hVAwNMiNe88sx3MpZ75UAqREoN4nrUa5h+a9AwQKlMu9QPzcDbVnSycFHiOFYhp
         7nfQ==
X-Gm-Message-State: AJcUukcUQ97DnBC1eRDD4LPAcxGVdnMhvWqspsJSHdprfC675cw/hi5+
        ijJDce/2v98u//IwHQv8vs0=
X-Google-Smtp-Source: ALg8bN6K5zCkv2wzaNTvAA3PsesMvuYx/1qy8IAyAGJPrE5eK8+y7VIrRa6e9n43T1umiBv7VcBmBw==
X-Received: by 2002:adf:f390:: with SMTP id m16mr231436wro.71.1546924729299;
        Mon, 07 Jan 2019 21:18:49 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y8sm8235036wmg.13.2019.01.07.21.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 21:18:48 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:18:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] nfit: Hide unused functions behind CONFIG_X86
Message-ID: <20190108051847.GA17285@flashbox>
References: <20190108045853.5471-1-natechancellor@gmail.com>
 <CAPcyv4gA=qEm81k-f80oBBo9mmPcAg6szYQvtdOWFFWgd=9A4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gA=qEm81k-f80oBBo9mmPcAg6szYQvtdOWFFWgd=9A4g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:14:05PM -0800, Dan Williams wrote:
> On Mon, Jan 7, 2019 at 8:59 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On arm64 little endian allyesconfig:
> >
> > drivers/acpi/nfit/intel.c:149:12: warning: unused function 'intel_security_unlock' [-Wunused-function]
> > static int intel_security_unlock(struct nvdimm *nvdimm,
> >            ^
> > drivers/acpi/nfit/intel.c:230:12: warning: unused function 'intel_security_erase' [-Wunused-function]
> > static int intel_security_erase(struct nvdimm *nvdimm,
> >            ^
> > drivers/acpi/nfit/intel.c:279:12: warning: unused function 'intel_security_query_overwrite' [-Wunused-function]
> > static int intel_security_query_overwrite(struct nvdimm *nvdimm)
> >            ^
> > drivers/acpi/nfit/intel.c:316:12: warning: unused function 'intel_security_overwrite' [-Wunused-function]
> > static int intel_security_overwrite(struct nvdimm *nvdimm,
> >            ^
> > 4 warnings generated.
> >
> > These functions are only used in __intel_security_ops when CONFIG_X86 is
> > set so only define these functions under that same condition.
> 
> Thanks for the report, not sure how the kbuild robot missed this. I'd
> prefer marking the functions __maybe_unused rather than expanding the
> ifdef guards.

allyesconfig defaults to big endian, which doesn't built the nfit folder
(haven't looked into the dependency chain to see why). I have been
working with Clang and have a local patch to avoid turning on big endian
mode with it for now (avoids a few other warnings for now).

I can send a v2 with that change if you would like.

Thanks for the quick reply,
Nathan
