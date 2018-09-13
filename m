Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2970C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B8620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRKfPOy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B8620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeIMSxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:53:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42312 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbeIMSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:53:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so5345654qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vhaXPG+D9JJ3+1tmlkaAXLO6gN5/4pKQeja1D6L4Dg4=;
        b=NRKfPOy2bM0XFIb3sSWIkU99eO63tl6nksRyJ6hLyARkpTohRDpCJOr8b5r5ZMtbV3
         J8HpKVUvtPrbsxFZIrBR2ZyGdttZhHpSP3IjBTvqEX8hOps3P3jFmWRK0x9Ki4tiofVA
         bg59dLOhlBdvwhqyhy/OKRybIgtDU5RTELxdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vhaXPG+D9JJ3+1tmlkaAXLO6gN5/4pKQeja1D6L4Dg4=;
        b=UEE+ozJicbM0tjuo+l357yqsjWccBQu1QZZ0eroUrcDkEC5SgvbR4IvCRn9atVwn6X
         Nq05HzpbzL+lJOdvHtLvlrbxbKqpKV5m2kv2x3dkSgduZH2RnEYW1nUQMUKfiH73g2B8
         WlpA+JYvCooee38b7GTg4LTN9nlxWXm7ti8JlvppatyJSwHJRFTMg2xIydMnA9xddzIh
         defVfdhzAuqxRPc6NB14n0PG6bYJQPbnxQLHz3iXmm2s9N9hf4a/57OWNoWpd+Eq9XQR
         fCd6QotA8n7/IJzM4YRFwmp72cu9SwaXZfNv88wOsmR+EchtIJxcSvs9i9uNUS9U0Cyx
         uc2Q==
X-Gm-Message-State: APzg51B7vDR50QxBDRzThz2h24PSajVzY+pLRYQQIQzEqbZWrPqC8Xpi
        tuAtyJy8UJPppfMT0zylqq26x+VckF8jdw==
X-Google-Smtp-Source: ANB0VdbVzfEVTmyGFnpVYdvAwJ57ORxxfpPebXLW/k0boRg0R27or0pLMlF0QruS4iEsI/dujptcUg==
X-Received: by 2002:ac8:6b13:: with SMTP id w19-v6mr5291670qts.317.1536846210473;
        Thu, 13 Sep 2018 06:43:30 -0700 (PDT)
Received: from [192.168.2.120] (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.googlemail.com with ESMTPSA id f25-v6sm2794894qkh.13.2018.09.13.06.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 06:43:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: imx: improve error message
To:     Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3ef674ab-6152-dc77-6c5e-5d5d23642a9f@linaro.org>
Date:   Thu, 13 Sep 2018 15:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 11:13, Anson Huang wrote:
> Remove the duplicated "from" to improve the error message.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

