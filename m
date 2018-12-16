Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF9B206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d05wh8SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeLPXfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:35:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40647 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbeLPXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:35:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so5415364pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=a2W2Erohv2kN1VDg1izFU8S9EnOS9gkcFOLAHDQ1PWI=;
        b=d05wh8SRaVQJodD5iplqgKPG8oSHs3aViY+not3uTNBNxpIKOOP3tEhYOrGOBPnDHl
         /OfxBH7d92IHlFEaX41xYQj1sWtrQ/vZW9en8mmmkvKAgi9qzpdVy2Nf+omtMLMHgMWO
         B5M+b/mrgeG7FG/V+g3IFGAjOKZ2W8LKwYPyWpCrIzKsxJ2/bS3iNC6fbKuWqj8sfKny
         NxVVB8wM1FFZYJww+rseq1DDUxYrrkrrl5llkjB5XTA/D9DkyssG74Ki69T8E04s+478
         qQ8oQrErsJk5JsiIxBairMHTEuCXNaBNaKmM/Rc+iGY3ZXURux2x2iZdagckH6CPpJxX
         s1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=a2W2Erohv2kN1VDg1izFU8S9EnOS9gkcFOLAHDQ1PWI=;
        b=CBP0qvJbEGXBUjqI8U0pIpMKNOyYtsPOUBt0IcBWicLB8FLF+4T9Ol4xhqJfkTL94f
         d6hwD/9A4tIsrpj66HgdIvv2AC1h8ViA3UOlleIhZlyKTKwGO6YLfttfpYxTgQd0Nkhz
         qLKL4/Oj//JauuPfAXWWqLqZChDtiYAOzXMty9UAaZBlP95Z6reCk28ITmTE3oeEcOi5
         Al4NBR8KqjUexYcOilTeU19kq6D7OK9QkEAicL7S5Pp4d69EIwsO2erx4Bpp813gXySO
         /LwZojSaORcGFdsKd9BNX/poK4ZhvkEZLZmNjt0eO/XRS8vvayl8seVIe6Lhszz/gK0z
         vFHA==
X-Gm-Message-State: AA+aEWYOG8jBCk7LQRPpSxxJeL2U91wQSdosQ2dFB3MRFPmzbosU2C2j
        CYWxckyzgq487jLqfrQhsedfTw==
X-Google-Smtp-Source: AFSGD/VSe6tpgshFdVu6u/+4e/zr889PgKO2jZP7I1hFsiU/wLbRCOpLHFlmQZgplVFRQ6ZSYeRNWQ==
X-Received: by 2002:a63:dd55:: with SMTP id g21mr10105713pgj.86.1545003344128;
        Sun, 16 Dec 2018 15:35:44 -0800 (PST)
Received: from ?IPv6:2607:f598:b382:d300::14ef? ([2607:f598:b382:d300::14ef])
        by smtp.gmail.com with ESMTPSA id x28sm19933524pge.66.2018.12.16.15.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 15:35:43 -0800 (PST)
Subject: Re: [PATCH 0/7] arch: riscv: add DT file support, starting with the
 SiFive HiFive-U
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
From:   Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <41dac7a1-3f66-6a3f-8a68-206688e5bd9e@sifive.com>
Date:   Sun, 16 Dec 2018 15:35:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. along with the PRCI patches which are under review.

Will repost these such that the files that depend on the new clock
headers are at the end of this series.  Then we can send those last two
patches after the clock merge in the merge window, assuming the PRCI
patches make it.


- Paul

On 12/14/18 9:21 PM, Paul Walmsley wrote:
> Applies on v4.20-rc6.
