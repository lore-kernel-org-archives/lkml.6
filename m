Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67098C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5BB2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549921272;
	bh=C9R/F7imBvA2WZmpRXQNy3ucJLEpfjMyKAhT2BOcF0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N4saRcXseoe00lPSkrd4Ihe0YieharBspXV6QyCS1rGPeQ5O2uily8PkqUfRffhom
	 0G/AGXxNBUo/FIfuQngegaGf2jJ+hWAgsqGxFhnN3A1fN2YSqLhoeaVnMeEUUBbR5/
	 kjWWoa4YrhbOoJmfsvawXlK2NFhzyNkCIE3QOdXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfBKVlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:41:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37022 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKVlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:41:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so186912plr.4;
        Mon, 11 Feb 2019 13:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFNS+jtsRLPjKw6EgTN582LE4tS/HXnqbsZ3rfmrQ3M=;
        b=cqHlx/fhZ/+bdQvMNuJVL7sEbURM+vWgRIf1nb9jPbChhqZjSPgkRojNxPmtlQYB02
         pTg0RbZ89SnKxtNvZ1IJeDHGQAZ1O7XxO12rYAV4oTm1eS2uwJSzt1w71QFNA/MNHkwR
         V+COcQCSslCSOTCV7Y/rFqGvPlhFA8xDgXNLUj7nTUGk1WDbTnm9GUdNEnuP/ofJ1yyP
         iQ8LN31/4R+3wpLEp/+PAHg+A8QI94hL0YCZld32TWMjxhSKcDIu68N1NZ2xjDo990fO
         Vy3Q1tzKTRWBBP/xUplgF5p4tsmSEygAHv+vdyAzWB7Ml5STqIQxjltBTG93HaKSch6P
         QEyg==
X-Gm-Message-State: AHQUAuaW4j0/qdgfeyX16+L7eDiViC/Mf8EzpgjEdOgqH6ytUj5zypef
        f2STc9dK0zgCmifr9z2xYA4=
X-Google-Smtp-Source: AHgI3Ib/3TipNQIRg4lR4lhgQXnTFWQ3Bxaq1DGjk10WjdA15vjMbH0sXEvcZi0s5ZigahgiPH6n2Q==
X-Received: by 2002:a17:902:b701:: with SMTP id d1mr376862pls.124.1549921269770;
        Mon, 11 Feb 2019 13:41:09 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id z1sm18321612pfi.155.2019.02.11.13.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:41:08 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 13:41:06 -0800
Date:   Mon, 11 Feb 2019 13:41:06 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        longman@redhat.com, linux@dominikbrodowski.net,
        keescook@chromium.org, joe.lawrence@redhat.com,
        ebiederm@xmission.com, linux-api@vger.kernel.org
Subject: Re: + sysctl-return-einval-if-val-violates-minmax.patch added to -mm
 tree
Message-ID: <20190211214106.GW11489@garbanzo.do-not-panic.com>
References: <20190211210632.Nfd0f%akpm@linux-foundation.org>
 <20190211211716.GA31039@avx2>
 <20190211211917.kq2ahdkhoe36obhp@brauner.io>
 <20190211212523.GU11489@garbanzo.do-not-panic.com>
 <20190211213249.lta2pithpf5w6w7m@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211213249.lta2pithpf5w6w7m@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:32:50PM +0100, Christian Brauner wrote:
> On Mon, Feb 11, 2019 at 01:25:23PM -0800, Luis Chamberlain wrote:
> > On Mon, Feb 11, 2019 at 10:19:19PM +0100, Christian Brauner wrote:
> > > On Tue, Feb 12, 2019 at 12:17:16AM +0300, Alexey Dobriyan wrote:
> > > > On Mon, Feb 11, 2019 at 01:06:32PM -0800, akpm@linux-foundation.org wrote:
> > > > 
> > > > > @@ -2848,8 +2848,10 @@ static int __do_proc_doulongvec_minmax(v
> > > > 
> > > > > -			if ((min && val < *min) || (max && val > *max))
> > > > > -				continue;
> > > > > +			if ((min && val < *min) || (max && val > *max)) {
> > > > > +				err = -EINVAL;
> > > > 
> > > > I was asked to return ERANGE in kstrto*().
> > > 
> > > I think we discussed ERANGE vs EINVAL and decided EINVAL because there
> > > was precedence for other sysctls already.
> > 
> > Can you do a proper audit and see?
> 
> If you look at proc_get_long() right now you can see that when the
> buffer we use to parse the number is exceeded we return EINVAL. In short
> if you do right now:
> 
> echo 1844674407370955161600000 > /proc/sys/fs/file-max
> 
> that would exceed the buffer in proc_get_long() and you already get
> EINVAL for all such cases. If we now change this to ERANGE we would
> return:
> 
> echo 18446744073709551616      > /proc/sys/fs/file-max -> ERANGE
> echo 1844674407370955161600000 > /proc/sys/fs/file-max -> EINVAL
> 
> which would be very confusing. For consistency we should use EINVAL.
> 
> See kernel/sysctl.c:
> 
> /* We don't know if the next char is whitespace thus we may accept
>  * invalid integers (e.g. 1234...a) or two integers instead of one
>  * (e.g. 123...1). So lets not allow such large numbers. */
> if (len == TMPBUFLEN - 1)
>         return -EINVAL;

Thanks this works for me.

  Luis
