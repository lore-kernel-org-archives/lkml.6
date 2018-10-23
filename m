Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABECC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57411207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7W9HOnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57411207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeJXEFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:05:15 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:37100 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXEFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:05:15 -0400
Received: by mail-yb1-f177.google.com with SMTP id d18-v6so1081024yba.4;
        Tue, 23 Oct 2018 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AXOfl/RYixZle0erI+YQvqD3XHRjvE9EnhW7FE1uw4s=;
        b=a7W9HOnA9ABykPUtHtlabUoTCMNfM3zDvhAa88kQj+g5JNgfZEWp4S/UJ5yp6fEGcy
         rKg7C7GWEIzzjxn8Q+xYlVoAh6sKCl4GfkM2YrC7NJqkrq8+No5DmrWKINmg3+ftRC7y
         Gigwcva9kVX7CIplUo+Q/OXDQ32Qe9AVJ45t67M4BQYbOffwsPGrXz0rqd/vV2BsHAGU
         gewMqCFWTfK+EHs8i3Lu7tEGyRlT9kGxUKVMk4HhOacgIyTkNKysCnqEayCWRRBLq3nu
         nZPXFZAq5UHRfRF/V8lTWT7gmgtgc3YcbZJFqiSbJsIM+ZAo2nEXtmLqvnRLNO4XB9+3
         gwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AXOfl/RYixZle0erI+YQvqD3XHRjvE9EnhW7FE1uw4s=;
        b=UkWK7+S38QX79GT2O9DxL2tBUWz3fJmazSqHLj0B0gZ53o+j8Eqydr/vfdBNDdY2wG
         TDGrnI7Ueo61Bkl6qp/5VQrWsC4N9rAOkvDL3WtUAXzY2eDvXf/yw2dC9SbMjDMu8lzc
         Ij/4xLhPKPp6osUP45J5edXrqwACsMpAyqymaYBg9qpNAvCIwr+97ABBFAuKTq7BxeDA
         mweeNKTi7GBDFYOaBH6N9dwzTRnXqS2a1JFY3QcH4tO4Pj4SwNIYEWG7v17lZcKsR0tO
         C6SfFo9h2zDUml+MLPBTqDqJc+DA6AMo/XytR5A+LpadrPcLv97s7PhilMFEjJ4gemfc
         B/bw==
X-Gm-Message-State: AGRZ1gJ297C6rfX0OtV9dhRR2yqVYbbOWOHt34NuCNpfXUt0abU7JthM
        hkKuaHBgIxQoPf8DBk4gxAQ=
X-Google-Smtp-Source: AJdET5c9w0LDyIn2Hw97rAEmsmmYngjbqZh0Cuaqas0QhYLgyessSpX38n8sRtIRvzIONoS0Oan+NA==
X-Received: by 2002:a25:dbcd:: with SMTP id g196-v6mr11339087ybf.391.1540323626367;
        Tue, 23 Oct 2018 12:40:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c0bc])
        by smtp.gmail.com with ESMTPSA id e128-v6sm488188ywd.77.2018.10.23.12.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:40:24 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:40:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+a50c7541a4a55cd49b02@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, jiangshanlai@gmail.com
Subject: Re: possible deadlock in flush_workqueue (2)
Message-ID: <20181023194021.GA4182586@devbig004.ftw2.facebook.com>
References: <000000000000bfd4270578abe88b@google.com>
 <0000000000009bcd4a0578e22ebd@google.com>
 <20181023142804.GC6850@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023142804.GC6850@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 23, 2018 at 10:28:04AM -0400, Theodore Y. Ts'o wrote:
> The other, and I think better way, we could fix this is to have an
> alternate destroy_never_used_workqueue() function which skips the
> drain_workqueue().

Yeah, I'm okay with this approach.  Maybe name it
destroy_workqueue_skip_drain()?

Thanks.

-- 
tejun
