Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFFEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9920878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwIbuyeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfALBBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:01:48 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:55016 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfALBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:01:47 -0500
Received: by mail-it1-f176.google.com with SMTP id i145so5577982ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SIvrHus/HV5e2jXBHxFy3bnEECHkLQHT8AX2SuzNeg8=;
        b=XwIbuyeMmFUZqLTHpZEZhjti3xn3E91YUZol+PRI8yDkcif2ZVS1UEkgCHFTh5PQJF
         +5pwzOcDCE+1ycvi0i+IxR1BTJBda63PZI80xBPP7BRu7xT1+nJVR9wRQFZSTKWnfrIp
         bNyxEyfGgu9aXSH8efZ1RfbjkJjOKpQWGQb7YhGJTzHy3UkHDpem4x5oVvgMexi0sNaW
         3HqkeAGrWj+FmW4CynwOy4J3eaNp9YScOQLpNfA4wDLpYlqF5292esfR03o1ouqdCAj7
         EU84tmY6+qiTpqwwLal2Zz2Fmvq+yvLk+MHAza5v94LAtpMYIbYuGdy4Tk2apLCXwEop
         Z5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SIvrHus/HV5e2jXBHxFy3bnEECHkLQHT8AX2SuzNeg8=;
        b=J4fd1HFRzofjT0WN8QEStm7Wf5IdGDe5vEegUQCH4n1KA1XQkZaueTC+9RL+hhlLfi
         aOZ3e+N9NR/jG3zk2N94+w7tD0GYFp/D9qLzzRzFJlhZZLYhqv6qkX1ZzN/QqYxh1KRu
         79WpFgx+feeYHm0k3hNIjpom+sGYH6ExzdXN+kQ9rfDagsJOmPG9jHBPu24wiOTtRqi9
         QdhimSc4+ARCg1rfgpusLUV6wcsdWEW7k7SsiOGB8wEiNM56v6DvjRH9sOaEcliYoYLZ
         P4KbQuDjKmOk5f+w5CY8cbIYVKjCh4eXm3dn17IDFGDRFIIageYRu+J9nXJaDVU7iAD6
         oXGQ==
X-Gm-Message-State: AJcUukc9pd5rRO+ub/Qi39dUPTSbr40dguqg/T6gS+GGg5bJNUOoTJse
        O1AOQzpVMjwkX62AFIk/DS0zs78G5NU=
X-Google-Smtp-Source: ALg8bN7jRcW4MNeuu7feFtD10RYzro4K2GpSnqwykrQFiW0pN2Uwx5JvIaiWYUzsVnF+OBD0n4f13g==
X-Received: by 2002:a02:ba01:: with SMTP id z1mr12092163jan.100.1547254906931;
        Fri, 11 Jan 2019 17:01:46 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id 195sm1854860itm.2.2019.01.11.17.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 17:01:46 -0800 (PST)
Date:   Fri, 11 Jan 2019 18:01:39 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: ARM: config issue with ftrace function graph tracer
Message-ID: <20190112010139.GA5288@r2700x.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with the ftrace function graph tracer on a 32 bit arm
board (orangepi pc). A bisect points to the following commit:

f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")

Before this commit, if I use sunxi_defconfig and then menuconfig to enable
FTRACE and FUNCTION_TRACER then the function graph tracer works. With this
commit, and as of v5.0-rc1, doing the same as above results in a broken
function graph tracer and often an oops as well. The commit introduces a
choice group and it looks like it should default to UNWINDER_FRAME_POINTER
if FUNCTION_GRAPH_TRACER is enabled. FUNCTION_GRAPH_TRACER is enabled by
default when I enable FUNCTION_TRACER but this has no effect on the choice.
The choice always defaults to the other option which is UNWINDER_ARM. If I
manually choose UNWINDER_FRAME_POINTER then the function graph tracer works
fine.

Any idea why the default behaviour has changed?

Thanks,
Jeremy
