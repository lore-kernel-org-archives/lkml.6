Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C368C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F7A2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfuOhROo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F7A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeKIVvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:51:36 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40262 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKIVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:51:36 -0500
Received: by mail-lj1-f178.google.com with SMTP id t22-v6so1378062lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=rflrxzCANE2+CMF+2BBoy82HzVXkZo428iP6LZVWems=;
        b=pfuOhROo1Zk4zdKF4Ur7X8RozsyayJoylWsPApKUXVyolZ08O09eRRSu0CA+ufN+8c
         6B3YoUGaZRrZ+MRvZfP6XHzFmvo23hZCiQJS8vle9oeE3/Qal4i9v7qd8bQrrq3T4Yly
         PXqZoFb+1HUizvJerot3/VPt5oYFo5mFUlzoEHG95UmzDMDqDyxzDwDQQhrN/OSNG6cT
         2CMAPAeViK/N5vY66F0L3+g43KAm/q2MlrJxhyIt0oYIYADGd3WcW6NpBPHZ83FUrjHh
         tSaRiNM/Nbeb4lYGNkFNzUj7zXduPRDZ+3p10O2q4NgsjpaKF0TvnPHtM6VOt+g/JrCP
         14HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=rflrxzCANE2+CMF+2BBoy82HzVXkZo428iP6LZVWems=;
        b=kYRuNAC5UAWyF6+tPZZ8qqWqxUcJksQ0RKTic9zVO92JmFG8f1yP0AyxTjW7E2qbXM
         UkmrXgzV5oX7+XRhphR+BQ3GU0oPEFG7AOa2gbUqKX+62SMHvN6tUDJxzx+/Fmng8ykt
         DnMOVpoYYJif8SBeQzlIHxvxLAkmOBgkkdKwkX7UUJYpJL2A7gRbMD8CI5URthMgumXu
         +vOdANvpEUAdrTsRWN8szJp3fuhVNhl6Y6yVidonQ1aWSXXEhP8SQUL/Q1nhLBin8JCN
         bWrzTz91fIspEfKuG/J1lb4aq3rn7LH+OAzQ26AEJzgVxwbzxVgQb2lfKJhKUfvkM4AS
         lRQA==
X-Gm-Message-State: AGRZ1gLuu9cTrpNVOrMjygxiPlwv9eASFA5fX2nf7eT04ZpoAZh9MuM1
        KGCWFP+D4rcTJLEXr8/P1g087uBR
X-Google-Smtp-Source: AJdET5dh260X2LKBUd3keMT22zzuopmwL003qhFjTJVjBWGyITRIomXzK8WHBWMXHqB47JhgAgHO2g==
X-Received: by 2002:a2e:5555:: with SMTP id j82-v6mr5912565ljb.69.1541765473752;
        Fri, 09 Nov 2018 04:11:13 -0800 (PST)
Received: from bars (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id w16-v6sm1328329ljw.11.2018.11.09.04.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 04:11:13 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:11:12 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [bug report] armada-8040-mcbin: 4.20-rc1 boot failure
Message-ID: <20181109121112.xibwnc354wzsbovl@bars>
Reply-To: 20180921160916.12393-1-gregory.clement@bootlin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gregory,

MacchiatoBin board fails to boot v4.20-rc1 kernel built using arm64
defconfig. According to quick bisection of the board dts file, the
root cause is in dts patch enabling CPU deep idle states:
see 8ed46368776b3bc. Is there any pending fix other than reverting
deep idle state support ?

Regards,
Sergey
