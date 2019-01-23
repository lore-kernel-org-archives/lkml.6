Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945F2218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqPyg/aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAWSd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:33:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:33:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so1459420pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6Lj3ajVjxrCjb5DygUw9O+jOMaas1fB+IERWCPr34o=;
        b=eqPyg/aJXX26q3yK5HC1/gAXBl+jPuEzn6Cm0RXAkaVRNOuQEph8i6pchSaoQJjtWq
         EFKBd/0+gjD68Mh6KYFW0CCIOWuPxyYJEfHoJu1e5ueyKWHvX4AqRnTy0CbWU41UG4eR
         11ZHK3fPpxvPGLvzHGDZAvSjMEbkYiIUnfMPcHgS//GzgOrgCun1Dl1Ewt/ZvCpktchq
         tL50DUiAhWv/CjGQqBbIYEP3c/n+SauJiAJCcpuxaGOATx74hK7ZWC8xh5VerhmElG4R
         iya420F5VmUm5OBIhW7fUBpsHQ2Vv9Fe+DCy0atRrmdO+pd/cEM34MpZAsFw+10xWkwy
         rqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6Lj3ajVjxrCjb5DygUw9O+jOMaas1fB+IERWCPr34o=;
        b=PWw9DBV722+n8KI7ks4mo+E+YkdXbsy0Nolg287h8HHQMpzV7q2ltjKI0VufOIBUeJ
         W4RjMZl4D77FTw1h0TloY7LHmStsIvaMogaMx+EzTHTT0KZ3ThZ9zrDBLDW58jqyeTms
         h6hYbhpH4bc3th31vkEe2tn4iigD2FTciswu96wXd53ak0lLBH0iZkY+DnjLB4DbIyFn
         XlMSTepgX9V3Y8HYFaxCmjM9pSlxGAl9bEQDS74RSfcPNEroeBh3GfKJj4GrK2RU73XU
         NDZYIqg/RuWTOc3luiJk1xcaJCSh+hzX6kqD3Ee63hediOhXdlJ/NqkeTvWpIALyuuLA
         hq2g==
X-Gm-Message-State: AJcUukdf/GCptt8dFnxnSqYEXTG1IPetiY6fpq/Ej7IXgeyQi+wNPdI6
        2KUsNgsOCwWm2MurfUx81ysGXA==
X-Google-Smtp-Source: ALg8bN6iaNwA6DATgkPnBGQzv98gimGqUmSzIn+N6MpVXeN62sKvy6CEtGGGRm2b2NMF71IAm1NxWQ==
X-Received: by 2002:a63:790e:: with SMTP id u14mr2985755pgc.452.1548268407254;
        Wed, 23 Jan 2019 10:33:27 -0800 (PST)
Received: from google.com ([2620:15c:17:4:f0b1:8ff5:16a0:5f15])
        by smtp.gmail.com with ESMTPSA id d18sm27560280pfj.47.2019.01.23.10.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:33:26 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:33:22 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
Message-ID: <20190123183322.GB160275@google.com>
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
 <20190114234728.49239-1-tmroeder@google.com>
 <20190115024304.GD5141@linux.intel.com>
 <20190115175111.GB68985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115175111.GB68985@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:51:11AM -0800, Tom Roeder wrote:
> On Mon, Jan 14, 2019 at 06:43:04PM -0800, Sean Christopherson wrote:
> > On Mon, Jan 14, 2019 at 03:47:28PM -0800, Tom Roeder wrote:
> > > This changes the allocation of cached_vmcs12 to use kzalloc instead of
> > > kmalloc. This removes the information leak found by Syzkaller (see
> > > Reported-by) in this case and prevents similar leaks from happening
> > > based on cached_vmcs12.
> > 
> > Is the leak specific to vmx_set_nested_state(), e.g. can we zero out
> > the memory if copy_from_user() fails instead of taking the hit on every
> > allocation?
> 
> I don't know if the leak is specific to vmx_set_nested_state.

I've looked at the code more now, and it looks to me like there might be
other cases where the memory could leak. But I don't know enough of the
flows to be sure. The enter_vmx_operation function is called in
handle_vmon, and no data is copied from the guest immediately after
that. So, it depends on what happens after VMXON.

Even in vmx_set_nested_state, there are about 30 lines of code in
between enter_vmx_operation and copy_from_user, and there are a couple
of cases that cause vmx_set_nested_state to return with an error. So if
we want to fix this by handling all the error paths, I think it might be
cleanest to convert vmx_set_nested_state to use goto error handling,
since that would allow us to clear the allocated memory in one place.

What do you think?
