Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF93FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F1E206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7uq6GgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F1E206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeINThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:37:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37048 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeINThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:37:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id t140-v6so2218371lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JY98BbnXUumUZX6EBUifiJQCVj8G/VKQcNGSwfmBZJs=;
        b=B7uq6GgVBjMSsfBM9REUzGzbk4D8fhzWSeO1U8KmQ+eHXdRGP4wGu99uIdv4Jxep+/
         JTm87Dpf2Ww9iaok8wUL++UqUrUBfTTolrb3Ng/6G7b4RncS7kVKW9JiDDYf1bIezKdL
         l2s3LfzC33nbz9/k3voQVY7VJmZwI1iFi/idT/7icKBUg/Tk44cON6Dtc/0JSOfSsotk
         TWCAa2Nad1W2y4f5CyQ8FUG0sXKJEVFi4fvu8GTNgRXKxpsqmGN+thdg0aCpsLtBXGCH
         8cnnjF+C37oKZMkcUyPkpqfW/zvS1kdwXBZ/uwot6P0H9oqVb/MmNFv+Ebp08yIXEzYg
         9w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JY98BbnXUumUZX6EBUifiJQCVj8G/VKQcNGSwfmBZJs=;
        b=rVyOFEGoteuxwmNlrXi0EIV9JlRsW/4+E6Y7FQk7OXXmoh9C7xbLEdXWwabjim3b6R
         4v8g6aZYBxefFiq0gTEKH5LTvuQVdtUn0dQ2HYKBkALAsR6tHc7FTv6nshrxZLwnkQjK
         Zuz8x/xhpgECtYNoQa2ffqLIJq97R1gfQ9Ocd92dF8CSDhEzc2rG4/wrXAkCkBA4C5lk
         b0LRaAaALfKKABfEsNzP9trNzBWjzHK2U/3Q0vdnpJtDESBw0DHZCN3pmc01v4lYPeFO
         ni+HqOIkSX7uLdZlxn/TnGnww3V6t2z/WOKOL9ZICXNuVMLVLC8Kde4EUvAlYHT5nUHp
         pD3w==
X-Gm-Message-State: APzg51BzcXn+sjU3zIkij+AqiCFn1MrHczb4kJd9wF14C2mgxYicvw4F
        sz3c3ttg1PvSNIA6MmLXGRM=
X-Google-Smtp-Source: ANB0VdYJtmw/YeE8O2cR5qaNy8wvfYZEgmDvURWnUeacJaRIxdlMFJ2gkP9QWrEgeEFRx4a+VyIrTA==
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr8325697lfe.89.1536934988137;
        Fri, 14 Sep 2018 07:23:08 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1204438ljf.60.2018.09.14.07.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:23:07 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0p01-0005wE-W7; Fri, 14 Sep 2018 16:23:10 +0200
Date:   Fri, 14 Sep 2018 16:23:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 42/50] remove fallback to drivers for TIOCGICOUNT
Message-ID: <20180914142309.GW1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-42-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-42-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:41AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> none of them handles it anyway.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
