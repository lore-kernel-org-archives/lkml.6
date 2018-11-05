Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8552C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9282081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY7Y31zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbeKFF7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:59:01 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42961 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKFF7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:59:01 -0500
Received: by mail-yw1-f65.google.com with SMTP id l2-v6so4228809ywb.9;
        Mon, 05 Nov 2018 12:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6ZPxgSO/lmQjvA9dVKLUdxgPZdvtVGQaQ8rKIlyWpI=;
        b=WY7Y31zVEOJYfGRpNmhj+XuH8egiUJfoNlXZIObTJ8pvbaFvDICNr2oHdpgr4dnkCT
         NgYPo9Z0MaVwTZTvd0o46Ep5tbCEL8MuS+QhUMWCVqW468sZGYVPJmbiFG2fRRgbRXC/
         w4YvhTlcD+y7zL5Kj3kAjYKUa1NFy7hJ2cKs66mVzzy0rDC8aHtgV5j5xmI+b7LTcem/
         L4SsAFwKqWq5oRHhl4uyJ95Oh52bpHARUBG1zKB4uDa/YxkIQ16+ZiXI1iLdcq9y2GcX
         oemoVxaieR2J4TLMAzZEIidEAzWh50yPmPMoFFSmE3rYVo3T8KOBxeuoBYhgQJHQo266
         or6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U6ZPxgSO/lmQjvA9dVKLUdxgPZdvtVGQaQ8rKIlyWpI=;
        b=L+BxBblvRZguyYAGQ6PowVh8RoGkDZS1R+iDAL8F237dDE4sUtO2gR1fJm7VVfG4ee
         u0ZKb4dgRXV9b5XtSSoN1U6+4qCwaiWFwv6AXTFtL8/XUoG5jv2TSy1AieSTBmYFu/jN
         sknjNmcDq6K8pa/UpRT3rHxy31ra3WItiMWiN5N4t77P11YTgTDrG1XtHZzkhZoti4cD
         OdC7vhJYsAjoiTVUzeqSBGuNAlLC4E215yB6VjNz0zwz9nVALZjDDW5d8swekErAVZir
         dQLCb7CglSuybSMzDi8JkkU8Rlr1TtPJktBipLhyddP5PSeVw8w5KmZKtely97CvAisO
         CosA==
X-Gm-Message-State: AGRZ1gJDMqx8i2xc/Mgophxq8gUpGOFGsh27HohE5mNRt5HMNWV61ilY
        j7ScacPNYxtRVhDAUuHrJeQ=
X-Google-Smtp-Source: AJdET5cGGX77FJ3u7fLVRfJD4VCVreNFL156NebsRzbWWqFuz4IsYSIHym7EDCQOlHpJQvpDxmHi0g==
X-Received: by 2002:a0d:e8c7:: with SMTP id r190-v6mr21301125ywe.90.1541450252034;
        Mon, 05 Nov 2018 12:37:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w188-v6sm10130715ywf.59.2018.11.05.12.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:37:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] bus: brcmstb_gisb: simplify getting .driver_data
Date:   Mon,  5 Nov 2018 12:37:23 -0800
Message-Id: <20181105203723.7031-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181021195958.1412-2-wsa+renesas@sang-engineering.com>
References: <20181021195958.1412-1-wsa+renesas@sang-engineering.com> <20181021195958.1412-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2018 21:59:58 +0200, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to drivers/next, thanks!
--
Florian
