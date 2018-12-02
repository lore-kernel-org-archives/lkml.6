Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A6C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC68120834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNNh2bKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC68120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbeLBDY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:24:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLBDY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:24:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so4670094pfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 19:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k8osN1xdCpQNn131Rcwni4zIsVvAL4CM/kp0HHL7zFk=;
        b=FNNh2bKzi4psuRRMGsGSC3qRXqRan9rClTcY9yXRgs+Q9PRoAxFApQLA0pyBcQABNg
         MIMghWqPyRXLVNf8O6R1PSeY6lnCdV36i4bsXNsLhNg5WTj9QZMByqz3at6gHL6N1R9x
         C4nzSKZkeVDLW6sT5Agyy8Ae2ucZI3XAnm9k0SJFHpPh+ekLV3gtuynnJuMbehYWMNSV
         lT/iyVB7gyx1MLL7lxmaap8u724uH8P4vjbcv5VjQQkWArRr+Tr+gBIBPP5AkMhjIoGB
         pe0i8r21ffee6Rhrpyst1G3nlKrHsdZTY7yaYQHm2M8qACHFz+IF8Qi1YkeaFFUuB8w3
         sS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8osN1xdCpQNn131Rcwni4zIsVvAL4CM/kp0HHL7zFk=;
        b=ddWL7pORwnTk6QcwoXcwyQeNqwYR6bx2dX6TOsEesKgP2ctqLVRqqNqQcu50Li5yI7
         di30iVQDe5MQUsAJgTgatUZoNFNWFR1qyyd18LQfIAnACgWtukxXGsmAFtejEOn/O8bN
         w7OkOGtUneQIOsvkJJ0FnjFbfAsaJAdulm0gImIhnlXi7AzVuEbaT0wtpmGSbPGuNqxo
         cMUOu9zI5ysS9X3kEQWnSdhsiW3fdwgYN8lzmLDpYnmaWdyzdCr2No20jg1cZLey2WrY
         bFLQrmifgNyERu280mY15pnscflgZHw+4aHR8GxSkcbxz13VftxRLm0CVeWaUZTAm/vZ
         5DEA==
X-Gm-Message-State: AA+aEWYlU7opkvhu+RUR1CUMqKN2Okx6y2YBt/HLDtyyhanFmxQja21W
        9tezsuw+DSjZHlAx0jbL5lalBExA
X-Google-Smtp-Source: AFSGD/XYczh/qGJ51VscW4Ak/ca7ehFlwzaDq2xzgZiUO8WOJcjCy2P0GzmlT9QtmWZceIcoSc7PlA==
X-Received: by 2002:a63:4815:: with SMTP id v21mr8151017pga.308.1543721064330;
        Sat, 01 Dec 2018 19:24:24 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id t29sm17160232pfa.158.2018.12.01.19.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 19:24:23 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 2 Dec 2018 12:24:20 +0900
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RFC 14/15] lib: replace **** with a hug
Message-ID: <20181202032420.GA542@tigerII.localdomain>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
 <20181130144111.067d447e@gandalf.local.home>
 <20181130205939.GC22338@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130205939.GC22338@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/30/18 12:59), Jarkko Sakkinen wrote:
> On Fri, Nov 30, 2018 at 02:41:11PM -0500, Steven Rostedt wrote:
> > Since the code has been greatly modified since that comment was added,
> > I would say the comment is simply out of date.
> > 
> > Just nuke the comment, and that will be an accurate change with or
> > without CoC.
> 
> Thanks, will do.

Well, nuking the comment is OK.

Could you please help me understand one thing:
  Linus has made a comment; in his own words, about his own
  code. Why would anyone be offended by this?


More importantly, if this is now non-CoC-complaint, will I face
any penalties for
	"Yikes! I'm a moron; my patch broke NMI printk, sorry!"
email?

	-ss
