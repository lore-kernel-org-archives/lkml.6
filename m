Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7544BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B6226869
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B6226869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeF1EMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:12:18 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40025 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeF1EMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:12:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id s47-v6so3618262qth.7;
        Wed, 27 Jun 2018 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aWmg7im17exQy4rah0WROHH0M5ShiUcRIcxOcOPKVmE=;
        b=pEz5WTvtXJ9N00GnB+OEInVKdXFjpqfcle97OdLfJguTVUhbawI7k5hGwkDre6fo7A
         JOYHtnynkeCFG4q7eYKxtd52xAHe2B/got9rENANXeDGnm9SHxbElbi+6p6SCj12jirb
         AtSZQHiZKZ/7F0opTMnmPaSx1GFSQseR1V+VNRDrhNtbkGzMzgNzljGaVITSeKR68xo9
         oJkHXTT/XtV8xPHvLQJalS6p3CCR0vlHWuI7O7vu6yuczz2DNFXBYVYvv5dKR4P3c5Wi
         DWGYHMaL5C844worG5vYC5aec6Djx3QpdaFy1wd4hK/Ix0KAwJ6rEeKAkLaKo/nxPKDm
         KWUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aWmg7im17exQy4rah0WROHH0M5ShiUcRIcxOcOPKVmE=;
        b=ZO1irrblRVJ2FoWsZ2b3USp5W0bXLKkOa9qVG5NSgO88CqA/1MU2UKnIrtY6SAZT+B
         thiKIcipbdn2mu+jo3kwPfsEORTX9wERWojdXGKfEbwz8CKdtQI3q6+EvTXF4kKR1G6a
         dzUucpZOhcbL0UU607RWZ6w8A+4w5DrvQ1E4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aWmg7im17exQy4rah0WROHH0M5ShiUcRIcxOcOPKVmE=;
        b=iTiJfMr/N6Rckd7do9Y68RsCQsLuK7bQ8IxlTmyAiqRbMiyWHLbEpYMX/lEkze59av
         O2+7VBpxFPOl9sC3g/bj/xBfKzikPdc6ZCPC3p+pxBzH5TVRx0+hLLawJ2hlhFZidbvv
         JHM4o0GTUm1lc4Kmt+KSv14K6pFAGZ08RNk7HloE1tUeY/Q0oBtt6JphNNQj9aQK1Gjb
         7h62uzaKIqLj+VcLhyexNdd1fyqkIU20OKTZKXiAJbysL9IiAd69dO+BT2UjeldtDNkv
         9mWw8t413GoBDTqJcDk7DDejq8TjU1gNqBW0MMWwdM143ztVjLiPXZbMXgjO60++w6qt
         xePw==
X-Gm-Message-State: APt69E2euB2ntzmxCsPB5DAA0C0dB1fAmv05mQErpUNrc0pQ5LpJaj1j
        8cqm0y5GHy49dwwXUt35OJ8XZnD0eHDtPlC/7Ls=
X-Google-Smtp-Source: AAOMgpe9dF27Uc4vd+e+zItSw0KVKI5pxguRwV7Nc/B3on9hKgHIQB5n0qWiunFEW3LzPo9xUn5dgjulC3My7Obt/sY=
X-Received: by 2002:ac8:679a:: with SMTP id b26-v6mr907735qtp.347.1530159136156;
 Wed, 27 Jun 2018 21:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:11:55
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-9-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-9-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:41:55 +0930
X-Google-Sender-Auth: OGgIS7P3poDCOMvNYW9-IRoOE0o
Message-ID: <CACPK8XdgZeDjz+Niyfo5UxvvHTjYXB+fWfhO768CPrUMXj0nkw@mail.gmail.com>
Subject: Re: [PATCH 08/14] fsi: master-gpio: Remove "GPIO" prefix on some definitions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Some definitions are generic to the FSI protocol or any
> give master implementation. Rename them to remove the
> "GPIO" prefix in preparation for moving them to a common
> header.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
