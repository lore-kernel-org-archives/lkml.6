Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD95C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A5B2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bRy3HG1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A5B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJKDfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:35:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37985 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJKDfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:35:42 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so9940165ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjlOORPX3htILjjNlDuReYkmNt/OlVvzKRY3Fq/PafY=;
        b=bRy3HG1rt2KlMw9jAxDSGFJQPCtekxT9SfSwSvhhw6jOzzpVzEQr4zeuY0OslsMHo8
         fhfsEhzsa32mS1acwTNXsZ1EE3sJjFgl6IsYhb1lb9M+R8zmWBrTYW6T8hNzwx865343
         boonqhaPxA7s4EMrv99BhYZsnkiZBgm2O33SnE6a6WBn5KCW+qKYcw/mkMGVXFjopa2m
         pObhSOLNKEYaA+5+jnuYKxHikHGahLbd61Y+/tyYBsJqiDZD6E9DwTz+Nz2s5VF+uW7+
         jYBX+zdFTJ4MZSyBTxYicMfXZl+Dstw/Zkbi1GAZfPWdDjG7TziEcmsaN+4UgCR68Qun
         BCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjlOORPX3htILjjNlDuReYkmNt/OlVvzKRY3Fq/PafY=;
        b=s7HNQQGTScW7K8z7x97uSCP65q1xJoxkQv5ObFHhD6jf5QAOlCLuCz+Fkz7L2z/gwy
         S9JD/zMNhOBrCQhvJ7cAcQH1McdWsT3en2ni5SixvvuHpq+bixndktgiPyTmsFb9MEbb
         EU3KtPQdKiIgz8bnJY81Lj4ONOalcbeOGo3NFGAJhnYWQw+eM6/OaOvi892w7YjbVNCb
         TwFF770nYLruuB/+1M965lhNzdVSt5Z+vTrozU0fHpZXhOiJaiZHioFaob4gwyK+OyzD
         4dzSLkGt/yAQN39WKFD/OO+Yts4uO9Q01uxQDDhGcM8KiR63p3iW+iTs0x8BgYc+oGjr
         KdiQ==
X-Gm-Message-State: ABuFfoj8gmklDUCoOvKzKwVjkijPvFI98EHGYt2r2xktAKrGb7d0Q5z5
        9Flfx404oJU4m0tAB8BWGX82vojGc6U=
X-Google-Smtp-Source: ACcGV62xsjMWwdRNEruBJEYVbl5MmefGMSw7eL+MnXASEKFuzHumdphrOLXX0eXu0XThALWWI9WGtw==
X-Received: by 2002:a24:3795:: with SMTP id r143-v6mr2029860itr.43.1539202317178;
        Wed, 10 Oct 2018 13:11:57 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b130-v6sm8364303itb.28.2018.10.10.13.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:11:55 -0700 (PDT)
Subject: Re: [PATCH] block: remove redundant 'default n' from Kconfig-s
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb@eucas1p2.samsung.com>
 <20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h@eucas1p2.samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99a2b013-c380-b0f8-0ed1-a760b925120f@kernel.dk>
Date:   Wed, 10 Oct 2018 14:11:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 8:32 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...

Applied, thanks.

-- 
Jens Axboe

