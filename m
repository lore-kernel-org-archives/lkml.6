Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9C0BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B902208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFJ6qDTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B902208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeFLLG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:06:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32892 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeFLLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:06:55 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so35390966lfy.0;
        Tue, 12 Jun 2018 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhPo4x9uYe2CoNJTBkCFjCnbpbyEmhHhreCIPWv7qB8=;
        b=eFJ6qDTkxr/IadjyLilfFmfmb9e5FbliK6zzOJ10fBQOBBAdjlR4RAMNoBZmUGl40N
         m1/SJsZsb7lSuT+vAr8mmXuR0l9l1gyt9YWL0NA1YZ8gUNV+LjMav/Of7d3Iw++TkmmN
         EsPeq6H3LWEuJ4JKSwufde0UfVlxTzMwjtpFRRRucxkmpSsXXcBxfPJPg5HMqfeWlRBz
         mZ4Ure9SEDvVZP1WnKUtQ6p1XRNSLY+iKKbeccBAq5xZzhdOEabxmJMV/Jh81F+6t+J0
         68hustHlZrb9wfThm4M+wIT4/CIl7o84ZkyfacGcmRw1Xf5q5N2z6/VWhU3EcYCkYaKJ
         GZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhPo4x9uYe2CoNJTBkCFjCnbpbyEmhHhreCIPWv7qB8=;
        b=qECy+fBo67xgjPFNrqO3gadzaWTv2xnvvuyu+Gb4BKtMc3gePb1P03dkKfV+cC8ChR
         UdY/MhXgPKMSn5KRpfa8AzCAF88yYPA2+L7A6nV34lyQYxJpZYgTtfYE8td/26toMze6
         x1iTBCgEvDZ/9V/X0aMqUdPDHV7D2rQ7jpSFK51YwirLBYNYF9lxTrJI23qiRqcPp3OT
         3bWpSB7qkOZ1M4QK8KQ/0KFDI/lZWGHzt44dOptv0f91PfimOQMt9g7FtOewWeLTj7ly
         O2+fHr9lPOiY3ioSEyJngsg7JWtkWHz7YO3iVwTw0p2hn9ZQzaTE6j36cNA5GUutYhVz
         yCwQ==
X-Gm-Message-State: APt69E1aXtJHV21Cgm+I5aoXOeoYZ9ObDhsBBpSr6kTCROxUPMm0Fgl1
        hPUdlLM+bTWenRt0+wSAbFk=
X-Google-Smtp-Source: ADUXVKLp5wWrl2AkpzdlHFNlQA9mGfVJ3pGS9oQWm9phEnpCLItBVmt3zWVaPb9+Oxav0XLUbePu5g==
X-Received: by 2002:a19:9390:: with SMTP id w16-v6mr1918389lfk.70.1528801613864;
        Tue, 12 Jun 2018 04:06:53 -0700 (PDT)
Received: from dimapc.localnet ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id q78-v6sm147912lfd.35.2018.06.12.04.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 04:06:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: tegra: emc: Avoid out-of-bounds bug
Date:   Tue, 12 Jun 2018 14:06:51 +0300
Message-ID: <2271626.NalpgXIy8M@dimapc>
In-Reply-To: <152878956397.16708.14349666570210193783@swboyd.mtv.corp.google.com>
References: <20180605121232.7121-1-digetx@gmail.com> <152878956397.16708.14349666570210193783@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12 June 2018 10:46:03 MSK Stephen Boyd wrote:
> Quoting Dmitry Osipenko (2018-06-05 05:12:32)
> 
> > Apparently there was an attempt to avoid out-of-bounds accesses when there
> > is only one memory timing available, but there is a typo in the code that
> > neglects that attempt.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Fixes: tag?

This is kinda a minor fix for an issue that shouldn't happen because today 
AFAIK nothing on Tegra imposes the max/min clock rate constraints. There is no 
need to backport this patch.


