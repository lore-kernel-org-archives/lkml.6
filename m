Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+grIUUxi41LtvRf0I0K2M6tYrWDY89Mu/8laQqN8pgbglvQB7WywDIKBLWPTdzzyLe6274
ARC-Seal: i=1; a=rsa-sha256; t=1523890956; cv=none;
        d=google.com; s=arc-20160816;
        b=bOGS6YRIIPLbM9aJe69JCN3IpCj2enBuVPcHim8UFmyOl6XQgU7pn+Fnyg8K0UlS9E
         YD5vb/ZHtYHNNBT5D+ayB2m1EQHNKgwjQwxACAIZNwVJWeDYXn2H7ZT0s9/XZNrH6tO5
         nv3INVpg8jGcRaViFRb7Dk8OTotzyFgCB/5jMnbLTA56lYvLGR8Ik2Q22TCLIhOMsF9E
         28HSwyqvVqtZQRFS5e/vRQxLlXfbwXPtTOzKjSQvMbGE7h155hFeAzkUIaNM50uSIHus
         Ue1VnWCFOqAUZhHSHNl7iXj/rvUiREsJNFhLHVZYHk6euDNN3tIFMM3zzhUIQ+fEcgn5
         2EyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=VJ6/bvOq5mv60lJ8GVpGLQvXGWjad/HIxge97lKYLsw=;
        b=CxXgdrguXuWkDW+jfA0ikCv+r84nH4SqAgKX9eWURTlVptKpc2K4pixcxoVne92pQm
         UZpCzrOrjkvMM8uDcqTmR3FDmOHBM6SRYOZmZ+9OLSnpMFlz/Z2H4nXLaADkQEf3KM8n
         NACCIqqbNhK7WA46JBJdIj/msU00PW01BFclN5Ek0KQ2xx917Q7lMngkIAAytjHgd7q3
         IXqztWvXAvvFTEv538WmSywVPSh1g3Obq6Jv4vyOrGe/LHLKmbHHJANjj/o208wx/OGE
         B5/g2Ta89uDGaIfo466VpzSYEzrgPXDVMOEGCzjqMv1o8R1Fd69CplTYhaomBmk+tEkI
         LBVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeDPPCe (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 16 Apr 2018 11:02:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeDPPCd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Apr 2018 11:02:33 -0400
Date: Mon, 16 Apr 2018 17:02:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Libor =?utf-8?B?UGVjaMOhxI1law==?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180416150230.6ys6ya7alpodxp3d@pathway.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz>
 <c9f4b440-c672-e45f-ddcc-63548b0411e2@redhat.com>
 <alpine.LSU.2.21.1804161329040.23118@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1804161329040.23118@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597915482010528558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 2018-04-16 13:33:55, Miroslav Benes wrote:
> On Fri, 13 Apr 2018, Joe Lawrence wrote:
> > Thanks for reviewing.  I'll hold off on posting v4 until Petr (and
> > others) get a chance to comment.  Perhaps there are other tests that
> > would be helpful?

> I think it would be useful to have tests for a stack checking and a 
> consistency. Nicolai has written some lately for our internal testing, but 
> it would take some time to transform them appropriately, I think.

The future of the stack handling is not clear at the moment. We should
wait how the discussion goes before spending time on test cases for
the current behavior.

Best Regards,
Petr
