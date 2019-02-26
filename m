Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92850217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHqlxpl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfBZO6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:58:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43493 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBZO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:58:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so6318719pgq.10;
        Tue, 26 Feb 2019 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Ugw5U3rEFhFsPaTQK85WKxkcVggsLUqRpV986657cI=;
        b=vHqlxpl57qdXh9WvnSUU+PrDPRTMMoM0R93Z1/kqVbA06T293hiNMwrSpqMqoQLbOl
         xFrGLGrhtoMPm+1bd8FU+JEI5njG+sIgchSmLmuj9vzlzKPz3Tf/3km1xL9gbuOyPH+O
         tn70et127Z4rmKXfQJnwt+pGKBu7F94LaWPH8ISkHy+ITm9vz0yrMLPEOBROyMeftUj1
         n9uI09ffhuHsYb9XBne5C4Wd1XNADEktwZS1OLpB9G0E8tSzE6DbcoL3QvR68BOeXAdA
         UhuEYl8TKeg3eFYFSa3zHd+pbffGY+laN7kB6zyMvM+KUvJKw9ULFC/CTCwZmj+ZhKvz
         RivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Ugw5U3rEFhFsPaTQK85WKxkcVggsLUqRpV986657cI=;
        b=FKg3sD3s644jvMYLNIBbUIFwvEYUSGxqEhebcy6Y1iQtIwdwOs44HaC1xpaHm26gh3
         8eEqTgGgblYoSCEgvn0bfL1k6rOjQETbLPuCWSRc73eZbNYRb16R/cGDnNd6f5bvw7GS
         cWIz5UMnZRTVG4ilWlzTuZJT+0jqeXHhkIohx/hxRvrapQ6OPLpvJyEDFPk96Oj/WEMr
         AVlF2B3qAeuJ/o2CFauv0CEBV+yuR1Vg42aDqIelwpNwtRbqB5G9IGO1GfXjGGlCu8FI
         N6QTo86dKKrpsQF2bY/wSUeYT4qRp4rae6dLrI289c3ni1f+lu/9UdXNhkH8kCEI2yxd
         PxBg==
X-Gm-Message-State: AHQUAuZz/JTE70n9WiyLy1Qo1yFP7aLyevIcPA8GT2vKmEEB/GTnrwQH
        F9GlZYFBcKG8jC+LO6X+3GVam1ihWhk=
X-Google-Smtp-Source: AHgI3Ia8HOmNqFxAZBKbOqBe5vXpcvw96prAn8KF5mCvAjLSYOZfMsd+LJJuGhusqEnhVXf3aMfknw==
X-Received: by 2002:a63:6a88:: with SMTP id f130mr24553313pgc.114.1551193089218;
        Tue, 26 Feb 2019 06:58:09 -0800 (PST)
Received: from [192.168.1.3] ([171.221.1.102])
        by smtp.googlemail.com with ESMTPSA id s79sm3136095pfa.61.2019.02.26.06.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:58:08 -0800 (PST)
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
 <564058e0-1432-676e-2f83-c8694911d8e5@iogearbox.net>
From:   zerons <sironhide0null@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sironhide0null@gmail.com; prefer-encrypt=mutual; keydata=
 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
 y15T+hE=
Subject: Re: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in
 bpf_map_get_fd_by_id()
Message-ID: <288b6db2-b14a-4f85-b89c-d873f0f6fcd8@gmail.com>
Date:   Tue, 26 Feb 2019 22:58:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <564058e0-1432-676e-2f83-c8694911d8e5@iogearbox.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 22:44, Daniel Borkmann wrote:
> On 02/26/2019 03:15 PM, zerons wrote:
>> [ Upstream commit c91951f15978f1a0c6b65f063d30f7ea7bc6fb42 ]
> 
> Thanks for the fix! What do you mean by "upstream commit" above in this context?
> 

This patch is based on that commit, I thought I should mention this.
Sorry for the confusion.
