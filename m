Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEF821480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+KpTY9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEF821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbeIXWyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:54:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35166 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbeIXWyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:54:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so9273975pfh.2;
        Mon, 24 Sep 2018 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PEweLLnlA1dPmePDMhQbZaWeZDtIlVBMBm24pUR08YE=;
        b=i+KpTY9fXhBYEMrz+eRTbaMmwRm9hrW5sQu0y86MTnTDFl96jclXJald9zDHvZ3VFq
         +Ulj3VP935RlhYnkCJ5Mx6T8VeA5RyYwz9h3qF0eVO3JJh6sgnR3YrzIUCb3MCLkDio1
         XqiAaJXb/q0CxQ3aXvhF1Rsw6xwQ6oG9iWnDAe2ivORTbhSLKLz9shYr9MyXIcnJnvFI
         yox59UhaM5x//Tx2//IgJ7e0uFnmEajJGbaRxwqTI1GFEePFGYS/0cC89hXm6PPjTAEK
         dK5gFEweu/h/IkC9T9bG6ZBnD9N6Fd+q6+461ZvGWDUSK8KF/0mEDEfIrulyCPHLJgwZ
         Xr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PEweLLnlA1dPmePDMhQbZaWeZDtIlVBMBm24pUR08YE=;
        b=pxQVCaNc37HTLtRjr98mwcZx9LfXlGqTLRE7pBHmlLUTzMEw6QBmKOtT9vcYB3AuF5
         hy0rlFrFs8tJHjIdtxgDCQT+gHj/5fpFLQ2ZYflBw82PfPKQp8/aKYdpWs0nQ7bAiqBi
         5Nxzs7AxiBQUckaiOMlRY95LslovbNZNsojY/LMz1+EYpn2dxZTjFViC4Vaz853BSAnI
         dayYG7Ogag2uJh2RhDZ66qzNpbqANpEZTcswx+x+dJlk7RQsyMlRfx1vKpIPK4cDSCuH
         SdRE7oSAgUz5Tw0tvbW04HtvbRNTIcH8fY9ee9PxOcsg6w1GeBsXCaiaNmwB+kk8JUGT
         NDAA==
X-Gm-Message-State: ABuFfojhnxrmPMgCNjRYxkyCRM3w+PobeU8WkRqh0FsKqzdeiwr8MCFR
        uip2zyUdnIS8ctnkQioe/Jeu4yRE
X-Google-Smtp-Source: ANB0VdYglb1LqsVV2e+rkeAq4a5RqtkGz8G8KsJfts67qmrhuOipqmd6onFNpFNwej+9FvlDFoQX/w==
X-Received: by 2002:a62:1016:: with SMTP id y22-v6mr11187924pfi.109.1537807895761;
        Mon, 24 Sep 2018 09:51:35 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id g5-v6sm53761277pfc.77.2018.09.24.09.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 09:51:34 -0700 (PDT)
Subject: Re: [PATCH] clk: tegra: Return the exact clock rate from
 clk_round_rate
To:     ryang <decatf@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180921220149.17136-1-decatf@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f669ff16-cb4a-614f-de3c-2585d91f2b57@gmail.com>
Date:   Mon, 24 Sep 2018 19:51:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921220149.17136-1-decatf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/18 1:01 AM, ryang wrote:
> The current behavior is that clk_round_rate would return the same clock
> rate passed to it for valid PLL configurations. This change will return
> the exact rate the PLL will provide in accordance with clk API.
> 
> Signed-off-by: ryang <decatf@gmail.com>

A minor comment.. [0] require a real name, it's not even obvious whether
you're "Ryan G" or "R Yang".

[0]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
