Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B020643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE/qxRZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfBYOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:44:28 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:39920 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:44:26 -0500
Received: by mail-qk1-f178.google.com with SMTP id x6so5405848qki.6;
        Mon, 25 Feb 2019 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdDakquZYcCn3P5oCUdMsrz4w/9OoV4zDR+HADZpN9E=;
        b=LE/qxRZCpijlE5aLqmBJB2tlqs0KMKr/g2g+CJrwVh1VQ50o6xnMGoPgLiz2d5Gaw7
         yeTsxfSNt5Q/sX7Xb+U6hsul5AVxy9mmjLEMCZZe5Ff3ZiJft8aO4kBi70+LsrNdyxJI
         I2s5lUnWv0EvcYrShAD8wZXNW8qUy/XM666Z6ckSn3PbjyZPLhtdesJioR+MU+iORqQM
         q0s3ICjftVkVPkghjiAHcr5fQXr18G/Xn7fddEvudzgX7niMG48HJbgpQxq48gRlk/Rt
         XwWiVOoavJrnShNH8Od+kW+AsZb7vBAH6CrQfEKXF4GYSQxrS/dHawmtjUaw8I0llpgH
         1PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdDakquZYcCn3P5oCUdMsrz4w/9OoV4zDR+HADZpN9E=;
        b=OvLOF9UF7iaW7NS1YxzOC4x8VmkyTJmImOebyPxLor6lEbIZb2Ky+eaDunMppZQoYB
         zCf8elozjtMwVnERM8S9L5UhrMWBF3WJyEQi0WD8D5Y0jeeCYA1ra0H0e39vyNyFdkzG
         BxtD76ItPPPo3FqCMjM4d/MNbHF/WYZEp6LxNm97f/7tgmsfxvVhDe1gjVx2pirzWX3E
         1dAPXSJi8aF5uvJfHdHVJv6DaAzPYM5/Xb4D9AOlP98nYdC9sQFyNk5qpiGv/30P2Oe0
         5u68mnrIsCjvzjTzKN+uJP0Fm41pgya6No603BYTJRDmoUu8pthzI5A066Njl8/u6v0h
         ULhw==
X-Gm-Message-State: AHQUAubI2+SBheJrnyQkE9XY0K0xVFHcaWtoC6AftAw4BXpvL4YHp0rd
        ZFwFEWrgaqDkP5fClCETJCdOuK4F
X-Google-Smtp-Source: AHgI3IY9el2/DtLbil805xQTQiFTY9PNmpbL0nFiQMyrNv1M4BYTT13HfKh73wtrSKqqhyF6qedusg==
X-Received: by 2002:a37:9d56:: with SMTP id g83mr13041828qke.351.1551105865262;
        Mon, 25 Feb 2019 06:44:25 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id g24sm6898193qtc.61.2019.02.25.06.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:44:24 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 884414039C; Mon, 25 Feb 2019 11:44:21 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:44:21 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: Re: [PATCH 10/15] perf script python: add Python3 support to sctop.py
Message-ID: <20190225144421.GJ31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-11-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-11-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:14PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the sctop.py script

Applied
