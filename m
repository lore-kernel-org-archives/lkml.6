Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D9C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC11219E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7hUkASi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC11219E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeHRQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:00:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41904 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeHRQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:00:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so1971069pgv.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=seSIZPjUZPiwjy+3Ee1fTWgupvgxRWmea+taMEQK4UU=;
        b=j7hUkASiruhNQBJKHoJnZu7wRY5WJP2Cp9QymapihU0d0HBS2BF0bN04uLw19zOFOs
         yKxpY6VEE31ImXE13o+ssHgr8KmQEFBXgwtajJl01WlafHGybkVZvRF3RuyTzLElxMlZ
         N0u8FM3RNiRDjjZ/RITzfQV3Fca1c2111kNj6e3bKX/qcQbafuUs4lZ87NgLH1SeO11H
         ocuW1N1ufzUUa7XrQyt29ES1nP77wa2WirCi6y8ekurYoPk+Cpqyzq+qPxmFEg4b9X1O
         K5LqGLRkpgRixfTcHj3fJuG7Ab75CIRvG0C/tLqONZ1IlmVg0qiORuvC12UfaeuxogCr
         mvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=seSIZPjUZPiwjy+3Ee1fTWgupvgxRWmea+taMEQK4UU=;
        b=EQhMjWo6UsdyR1Gt2V6Sa3wnFOqf1gogVG2FzQ5GB5vQVVMn3OIeOr9n1lM5CYYfOR
         sbPprEKEoP76RQP8O/EDPAX77kChfetzInISwb5MUG/e5Mc/QlElSdAwZd6WOpXee4Pl
         HJp7M4uDhPoEDaZuGeUM30/2pVuwU2s8wcv/cDvJR0w75WVGwH5pVSKQLLR5KAwf/PyQ
         KE/DeMZ4ZWMagHgujUWwXWcag5L59EvtljX1CtJ1/i9Z4LWRyMjNvy70HjQCYzOnIKt7
         q86AHunCM/KEUa+4VvXB38LnzSje9LOZc6p1/0eoP6fY+5DtPSqS3bY+n5SdZ6J/eXlW
         Jtng==
X-Gm-Message-State: AOUpUlFBlNCJXYV2AItnkxiGSj2EUfWj00PuUfmzZqBiZMiLcrkasHYS
        5mEQMYXsMaxAhjCQvkf99hc=
X-Google-Smtp-Source: AA+uWPyzgN/A0dnqhjdDj7g4YUKIEkgz5kCltBL0pdHhR4zHhbvR9evy2v+q3aGglSoEOlwF1DMj7A==
X-Received: by 2002:a63:2e09:: with SMTP id u9-v6mr33664011pgu.294.1534596756367;
        Sat, 18 Aug 2018 05:52:36 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id 1-v6sm10390927pfm.145.2018.08.18.05.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 05:52:35 -0700 (PDT)
Date:   Sat, 18 Aug 2018 18:22:28 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: remove pci_alloc_consistent semantic to
 dectect in zalloc-simple.cocci
Message-ID: <20180818125228.GA1000@himanshu-Vostro-3559>
References: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 08:01:40PM +0800, zhong jiang wrote:
> Because pci_alloc_consistent has been deprecated. We prefer to use
> dam_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
  ^^^ typo "dma"

Also, typo in the patch subject "dectect" -> "detect"

Otherwise,

Acked-by: Himanshu Jha <himanshujha199640@gmail.com>

Thanks for cleaning up, we still have few more *_alloc/memset
in the mainline, especially in the scsi subsystem, even after
I cleaned up with two long patch series in the past.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
