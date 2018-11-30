Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F27EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1BF20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="blcHFeX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1BF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLALH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:07:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45935 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLALHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:07:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so5297722lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dAYI4KyhnvqXkFgdjqiJWThf+63O6HKZ7I4pZknoanw=;
        b=blcHFeX6tDzo9oQyU4LqLvDuir87okX1xMdBlyvQAbXip7BsCW21YOeGbf4XGLfcTU
         /HkgszVtCgNIErV2KkyNkDECRbddhAIIi/zwFKeNbBogZAqdrr7YjxQrgL/HJU9QGQSv
         ZzzBYaAHLWyh4GSKfs/ZMcv2aqFGmqruMn9h4BXrDe7CXtJckFxHt2Lg/14ppn4/GloP
         S79lsunX2UrNJUa5ZE7QZkwIMelPX2s7fNRwy5gYH6r+OarWoPV9yAnp6NiNi7dCZ7nX
         Iiw50ApdBwof8miXbjxC6wU9DeWlJQdQoyHmsSlToJqc2Smj8fOa/JCT63tHxOg6hJWq
         N/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dAYI4KyhnvqXkFgdjqiJWThf+63O6HKZ7I4pZknoanw=;
        b=uLDzu6nfg4kVW5YzauEKbkn7QB3R2F9HRqcmaUYfFm+MajV6Tpkly1mMjZnyYm3hB4
         fys0wNUauqFE//FmamHK5XvLllWL7M1H0QbS0gIjI1UoZp4x3jQp3CATzMCy0dXGUmFS
         vO7PFHQxYu3ww2yoBVLDWpZVdd+xrIKklkEgX65YeBnNgsIxbjQNaklzLZCrtdJesdol
         gXj1h6GhWCtLh5arjqBhpdRkr7C+JwCsklu+pUS4ecrKYUAosm67lxJLj8VdtsKaANDx
         7ITDceDY56xCmyin0bVhpkks8YP99Zv0KivCrnY6lE+Wp3pNKM7Bb12bdbd2UnFxNQ3f
         hSgQ==
X-Gm-Message-State: AA+aEWYYWtCjgC4btfdjY6u1Z7/h1nNlTkY00tKyYSWc+Xp7PZ0m/u3T
        PiEkC+V73VHqxI67bnm/lEbocg==
X-Google-Smtp-Source: AFSGD/WH+OjoytO9KcJ63eLT8sHh4MKcJp7zEnjugBCgorCcM9zbEEVflhIiahcw+MSnmAH4mGkZ4w==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr4571981lfe.127.1543622211049;
        Fri, 30 Nov 2018 15:56:51 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id g4-v6sm1045747lji.17.2018.11.30.15.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:56:49 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:10:45 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/20] dt-bindings: mrvl,mmp-timer: add clock
Message-ID: <20181130231045.alnf4amcvog6zxfg@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-2-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:05PM +0100, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - Made the clock optional, to keep compatibility with DTs without it

Applied, thanks.


-Olof
