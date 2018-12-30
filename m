Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39358C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09B920855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546170679;
	bh=8ZMG0PYjeVJyMNdUddGKm6XTMXr1ZcYbR3GklIyv460=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vpRES13exgWPnA6493inGYz0JNTOTqGiZeeS0+8XrQIohhCBxS0OTzeV80PWQQqNt
	 n22+fDutXmOWIKJgLBreIQmfdoCdhGiT5niAeWGw8T6PZIxWvm3sS/q2oke4DT0NPS
	 wc8uBKQh1uFfLeg4IxI0fW1PsUEYC/IHGEMCsU8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeL3Lux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:50:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3Luw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:50:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so22882647wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 03:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZTp0DP4zvwveB93OyxnisTzZ6Y4w4Hg2DrzFPKn1LsU=;
        b=Ie42Mi33bLhlEKpPl6CXPfrFsSZPXjQQIvwP7AN1YMdobMj6FSNfHob/o86zBMT621
         NXFPufhY9El2ifofBdqbtG7yaLr7d5aRlVXIvuRaPWm4Ad5jx+fPaXIfH6fhTWll2ycU
         5kE8wg9OpAXb1ATKhM60IWsoY0ZwTkDn79GlZumGBPiuYxyuv6kf9VJiJ6T86Io1SHHO
         94HDNvvxHCp4LtNlpEKA6SKCI08f2UcTtSfVZaTvd56VSEnGZ6ZrYxb9GGmG/0rRSio7
         Hi39wucHsTsko8ve5NOWRzJ8lC5kw4FT+8I4aj3uB+7N823EeifUHYUKZB9+XEIREswk
         XuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZTp0DP4zvwveB93OyxnisTzZ6Y4w4Hg2DrzFPKn1LsU=;
        b=SZmASngyUWHmYzPwu0wvV4BmP3WjqQbudFwM4Lm5/mUR5cuJV7n5J9/cHCH75Sagoi
         HLeedJdt3N8YKiqimXKfZuP4t1BHauT6gimNbdRwf0v9hYaW0lOXuvbnkyuqhG92ivE/
         +Y7LkmMXciILJFhpOPtaTw2g2L7Ro3FIlj8QuKcdE6vI+Sg3jpB4+gGzjPTz5FXpsy7S
         h49mkRHljgXSIFDvD4b+LmzIduxguHv7auaIaSjYBLbdCkORkYJSctOFXBhComcjLcHy
         emyQ5wvbq26tjWNv5KoGmy6lQVMXw2gbqGpK1eh2f4hG9vFJWi3PyDBHWVsH/eXHD+ir
         QFgw==
X-Gm-Message-State: AA+aEWYSL5N8EU7q2nugeVDVbuwUZ6De8XR7VEmpT5xgoMnjkJ4IXc0D
        +ZAtlNKdb0nScmAoqAgrXmc=
X-Google-Smtp-Source: AFSGD/U6NcJ2jcKiF5wLF4hvGY/e3PI8FqGPdoa0v/uDiMSuQaWXnu6An97ClRJ4pmesHAuNxBAIPQ==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr27648074wme.119.1546170651092;
        Sun, 30 Dec 2018 03:50:51 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y12sm26957191wmi.7.2018.12.30.03.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 03:50:50 -0800 (PST)
Date:   Sun, 30 Dec 2018 12:50:48 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, acme@redhat.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools headers: move the nolibc header from rcutorture to
 tools/include/nolibc/
Message-ID: <20181230115048.GA16460@gmail.com>
References: <20181229180453.15889-1-w@1wt.eu>
 <20181229182508.GJ4170@linux.ibm.com>
 <20181230112502.GA16126@gmail.com>
 <20181230113841.GA17373@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230113841.GA17373@1wt.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Willy Tarreau <w@1wt.eu> wrote:

> On Sun, Dec 30, 2018 at 12:25:02PM +0100, Ingo Molnar wrote:
> Could we please also use the opportunity and move 
> > nolibc.h to a more prominent place, like in tools/include/nolibc/nolibc.h 
> > or so?
> 
> It's exactly what the last patch does, I followed your suggestion :-)

Silly me - I only looked at the series of patches and didn't see a file 
movement patch there :-)

Thanks,

	Ingo
