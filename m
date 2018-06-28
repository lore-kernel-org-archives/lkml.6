Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92799C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8627429
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nUQMLk04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8627429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966325AbeF1NwQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:52:16 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39579 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965989AbeF1NwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:52:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id p11-v6so9111658wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9IsqMTmPfoOWC8YQ7OF+QZpnRr3INUW4vs303iXWhuk=;
        b=nUQMLk04i6l1kDurgFefITkbCqPFDDmXrWym2B8HVKjkc11CpCbTlW+YpyY909I50R
         fSsT2eGm3QlCBw6MWT3MGHg//88/8OzudickrgP3rUzVUCsT9UDWrE3MIQmOb5XqPiCy
         u/obY/1UT0ZAeCG16FsaSzgUFKqbyF3RIMGXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9IsqMTmPfoOWC8YQ7OF+QZpnRr3INUW4vs303iXWhuk=;
        b=eCijVnl9Qy/Wsz8UNQl7Ebdprgvjski6/NDlw0Sf5ytOlvbUF0ei+suiKo5MdV+knl
         S6e1fr/T8YfGq4W9ocyAoOuj3wpKzZjaauekeBQOPhyMm95Qzq0DTLENusJmomx01lgj
         RMEArI/8kP5vQDnrdbGar8zfyz83HwrH0aTExWm5jzkXBGHa0UF5FX9Emaqz3gDnzL1c
         hKKdVAglNDJF15a7ju8lgdrXqqQzyvB8/7rlrgI0/KlmKizULtdMJA8P5HtZ6WTHReqs
         ImSKeWwQJMA9lLyo5YFizz2Xc5GDa1YLuQshYuNbsklIZezs+fMunl7uxPRUoBr/odH5
         CwaA==
X-Gm-Message-State: APt69E2Dy2OKBNGN4eCE23vKfX5QyApEq4D7Mzng+hirT1E/3E9Wx3Pr
        1IDvDg4ufNVwYdlrG8UcsG38xA==
X-Google-Smtp-Source: AAOMgpeOwOJ6TedpePJkX495j7sfDWjRncvQTU9k2UNayZCP/Tg2pyIIiKk/jAs5JwmgtUsXilJKfw==
X-Received: by 2002:a1c:9788:: with SMTP id z130-v6mr8695704wmd.88.1530193933833;
        Thu, 28 Jun 2018 06:52:13 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id s3-v6sm7964962wrp.76.2018.06.28.06.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 06:52:13 -0700 (PDT)
Date:   Thu, 28 Jun 2018 15:52:06 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180628135206.GA16107@andrea>
References: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
 <Pine.LNX.4.44L0.1806280947080.1812-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806280947080.1812-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * smp_mb__after_spinlock() provides a full memory barrier between po-earlier
> > + * lock acquisitions and po-later memory accesses.
> 
> How about saying "provides the equivalent of a full memory barrier"?
> 
> The point being that smp_mb__after_spinlock doesn't have to provide an
> actual barrier; it just has to ensure the behavior is the same as if a
> full barrier were present.

Agreed; will fix in the next version.  Thanks,

  Andrea


> 
> Alan
> 
