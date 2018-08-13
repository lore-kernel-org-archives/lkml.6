Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8497C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCB921749
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skBrzSQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCB921749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeHMQbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:31:46 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45701 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbeHMQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:31:45 -0400
Received: by mail-yw1-f66.google.com with SMTP id 139-v6so13552693ywg.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v6p5bgRbwsGHkKlV2qsgv+Uq630sBWQUYPGUX8T/1H4=;
        b=skBrzSQAvj+8wlezpxlgugtpH4+5aCIMI7QJryKZ6x6BRtJk6o4lIatjQiRUaJEQo4
         6P0oWl8HXHk5RArX8BV8+3vqKgJklhy90cUo1KZCy7UpsY3Bp/gfMF4MqbVWL3dWbrHf
         tUvcZgtKM+yk0YdmwtvLU0uRw6ec1r0ks/TzOgqbk0aMH+gXDGEE1WNifeXB4K80gz1C
         3HOz9PFpuntDotRaRfclsmprx20xz0LOECVeAQ0fzhqY7O2u2UpuZVQfnskMjEtoyErX
         rq/Qld6UmDI6UTK+RGzkZnQQ3AqGnT16MPkZKmMmEH5VdqhRro86e+vKquSi5NFr2Y9+
         Me2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6p5bgRbwsGHkKlV2qsgv+Uq630sBWQUYPGUX8T/1H4=;
        b=HUWKG4UWYqZgOhDe4wbxnEZo04GV/Xml1ObvcJo+A0CsCPDSRNl9+8OpsgbYmDKrdq
         Il6rbP7r+cChIHBXN7X5YWUPckU9Juc/Bpv0vRxWNiu9xTQn7rgB9b+IFPV/BoeB3F28
         qvbFByRVqBp6GJl14InTOuE7JVK1+myBJJrQ60AJaI4R2b+StJWt6gHsAkPvkafL7Fl8
         ARUvyxCptClGSCZNXr+Sk/9dpmKpLp+MH2zHUgZVRnNftncLTBcQ5ZHBElPw5mZA7oTK
         1CjVa5qWhblYFgiOExjwnsrndDJgASf4RiNfky/+e2mF6v0K2nOta/jx6zQAUvtnMdpN
         km8Q==
X-Gm-Message-State: AOUpUlFUSEDvitQCgXlIsOPDl0BEzl49OuJO+qQx0GATa32hCkR7ffvB
        qq0YRBH2BTXRvtF0I4UNkNk=
X-Google-Smtp-Source: AA+uWPywv0BnZ+44TMiFq9tWf0uC6vrNPAclD3ipQatQ4ABHYNzb6OQDvHLEmSbXWoyFEKOlhRiF3w==
X-Received: by 2002:a0d:ddc8:: with SMTP id g191-v6mr10034386ywe.145.1534168163278;
        Mon, 13 Aug 2018 06:49:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6555])
        by smtp.gmail.com with ESMTPSA id w143-v6sm16538695yww.49.2018.08.13.06.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 06:49:22 -0700 (PDT)
Date:   Mon, 13 Aug 2018 06:49:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: update comment about kernfs_path() return value
Message-ID: <20180813134920.GG3978217@devbig004.ftw2.facebook.com>
References: <153414312926.736358.10338941831174422783.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153414312926.736358.10338941831174422783.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 09:52:09AM +0300, Konstantin Khlebnikov wrote:
> Now it returns the length of the full path or error code.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 3abb1d90f5d9 ("kernfs: make kernfs_path*() behave in the style of strlcpy()")

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
