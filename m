Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A7C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EFE20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dGxRVeMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EFE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeIHOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:32:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55343 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeIHOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:32:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so16851111wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eAekN8LQseFbt72wU1ez2zxzd68dUMfGCc0COg1rILA=;
        b=dGxRVeMGpMLPh26kxtIrpRYRIwifVQmamzTm/n55SWJpPv2GnUCsifHgWSoWLagGjT
         exSAS+fECDmlf71XCYJy8ITCW22f0ybkJG1FNxFWXWiTQx0TvO8oJ8jxRlliY5q0gmO9
         D/t5rMbbOs2QlXE1UyQbPqgmDIKFvVyRpOo3s2mbivPWuaWsk4Xjx7gFHg8CGCPZF+cy
         EtYTVbS1/Txi42r6V5+ooRRHk3zuU0YydrYlGDXuDbqiWpSxl4GhQvEdXcv9ebwAThWa
         FLHq1TIJqQ4fNQwbz4CfLZcLXf5tp5MpBXzIsZtTaHnzwKO3UTi/aiYlA8ZiGomt+F9J
         4Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eAekN8LQseFbt72wU1ez2zxzd68dUMfGCc0COg1rILA=;
        b=VZmujooueGXf7txQbzkDFRg3rxk1dBAAJHSrNvS/pzTnGCvsiJU/k6f6xCEzVfjKA8
         LPGLXN4OHR6HudI/7Pxp7bQ3FjIi49H7fbOWe6AICpCfdH++OuYjAFjGVt0oDtIlKnmN
         bPCFWqBG781evYPxk+/oQ2m5ShsZNjdZ69X41kZupsW2SoM2Yo8uLWaRDbTGe5TC5eCt
         rtrcLYda+iRAlo7AL6sj2n4cb9ugSc+cWYPtNDEH6zUeCME/MeGT1W6f2OaqCcl/xau2
         jQMjG0k5Tk3qJq3S3ty0ZGU3OE1RAhgQyTSbKAP9loPs3nwANchgrSjtmNR7jWvHaaet
         oSmA==
X-Gm-Message-State: APzg51CRcsUhNVGKTj+aW/3D6GGdUJbvKkeM2b9gWk8UqvdwAlWLIDlv
        ldHFEKnI40Oj4w4Joxro9fYngw==
X-Google-Smtp-Source: ANB0Vdbnh1LPXVz4eqsQv4RBev8+dGHcUuxVOB9s+UG1D3tcW60f4PeG9AkQu13vz6hGgiVSDlpEwA==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr7383370wmk.98.1536400060841;
        Sat, 08 Sep 2018 02:47:40 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id 184-v6sm18887621wmv.6.2018.09.08.02.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 02:47:40 -0700 (PDT)
Date:   Sat, 8 Sep 2018 11:43:31 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: Expose tagging protocol to user-space
Message-ID: <20180908094331.GB3246@nanopsycho.orion>
References: <20180907180908.3223-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907180908.3223-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Sep 07, 2018 at 08:09:02PM CEST, f.fainelli@gmail.com wrote:
>There is no way for user-space to know what a given DSA network device's
>tagging protocol is. Expose this information through a dsa/tagging
>attribute which reflects the tagging protocol currently in use.
>
>This is helpful for configuration (e.g: none behaves dramatically
>different wrt. bridges) as well as for packet capture tools when there
>is not a proper Ethernet type available.


Hmm, I wonder. It this something that varies between ports of an
individual ASIC? Or is it rather something defined per-ASIC. If so, this
looks more like a devlink-api material.
