Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AC02081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z53+jPoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AC02081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeKBXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:09:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeKBXJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:09:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id h2-v6so2097214wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iCC8eMZ/Eb68QY0yed/muBdd6WhTmsSjcbyYEcpUhvc=;
        b=Z53+jPoTdUZDJFMONOyvF3lUzCD8epr8mC90CsPYDPCrRFYM0YkJMdilyPXvnOhTZW
         e5HsFKHBksp3pB+nf/o3qu1uaz4ZE7OyOYo6a2KIg6NDQd4V34h1YkfOXcC2YSsrbd3H
         i0vlvKGh+TAWWcWSxvzyrm5sQ/xnEfLJbA41k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iCC8eMZ/Eb68QY0yed/muBdd6WhTmsSjcbyYEcpUhvc=;
        b=Bo4gm6NM88fZuajzar158l98cMTnMn1kQRYmMWocY+ddqZTis2pBdSa6e7gscTeCuc
         FXFJ/oCPRds9emGgneq1ctpCL3yMFGswLM8r3At8IomeUv5C9Cz2bufBU4ZlcXNzjLj/
         7ljfjVefzyGObCEk4k2CmnImbTuVvPkoksXbLT10czSjPlC9KxwZwFVIy3k3JcTUpy80
         J69FugcO8vkgbju1JdEKD6VoZLToH5eTu9yTGJsPxOSNP6EqKU5d/Cgk2eZIV0V55LEs
         LJeU56AbW/6h542Np8lwe/ozjkSONVCdMvUmkcxajIQnj37bF3ZWYFbGd5GK3ZDKu3LD
         ov+Q==
X-Gm-Message-State: AGRZ1gLst8kkj1NjfLSLLh5zG1lH5rZsjokGEwDbX1bcLypzVkuUGWon
        QnKmj+KGE1emS1tLvJqXvJy6kA==
X-Google-Smtp-Source: AJdET5eXic94FrfwXY90h6CywldCGa3n0rRqAukJUy7dkptj+pSwPXArINII4MQC2XoZzC7NiZ2Pgg==
X-Received: by 2002:a1c:dc42:: with SMTP id t63-v6mr58049wmg.17.1541167329845;
        Fri, 02 Nov 2018 07:02:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t77-v6sm44643925wme.18.2018.11.02.07.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 07:02:08 -0700 (PDT)
Date:   Fri, 2 Nov 2018 22:02:03 +0800
From:   leo.yan@linaro.org
To:     Mike Leach <mike.leach@linaro.org>
Cc:     acme@redhat.com, jolsa@kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181102140203.GC3983@leoy-ThinkPad-X240s>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
 <CAJ9a7ViZGSAXsw7TBKaRqzYSqBuJiizdkCoMFzwkPMrstL+eJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7ViZGSAXsw7TBKaRqzYSqBuJiizdkCoMFzwkPMrstL+eJA@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, Nov 02, 2018 at 01:08:40PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> My understanding is that when we decode CoreSight trace - be it on the
> system that generated it, or off target device on a separate host
> system, we are using the dso files in .debug/ as these represent the
> memory layout at the time trace was recorded.
> 
> If I look into a recent session copied up to my linux box from DB410,
> is see ~/.debug/\[kernel.kallsyms\]/ee80c1f3a434469f6174e1cf4bb5583d83a013dc/kallsyms
> - which seems to me to be the relevant symbol file to use rather than
> the live one generated by /proc/kallsyms. I don't really want to use
> the local /proc/kallsyms on my x86 linux box when decoding an ARM
> trace captured elsewhere.
> 
> So perhaps the problem to be solved is not how to use /proc/kallsyms
> if no vmlinux is supplied to the script, but ensure that the
> [kernel.kallsyms] is used?

Yes, this is good point, the subject should be changed to:
"Question: perf dso support for kallsyms".

I think I made a mistake in my previous email, so clarify it:

~/.debug/\[kernel.kallsyms\]/$BUILDID/kallsyms should has higher
priority than /proc/kallsyms, by default the perf tool should use
kallsyms file under ~/.debug folder.  I also tried to manually specify
the kallsyms file with the command "perf script --kallsyms ./kallsyms",
for both cases perf fails to parse symbols for any kernel address.

Thanks,
Leo Yan
