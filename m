Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AIpwx49Uny74jD8HfPYo+vnaytV5MdLwNzDM2JqymhZZyJJwdO3e3uOAz/zpqhk+V2kvc9pjLVKT
ARC-Seal: i=1; a=rsa-sha256; t=1524763798; cv=none;
        d=google.com; s=arc-20160816;
        b=q6t2cN1vijFqQMqFZF1vD5pWO/75+DToRqdVOv1bUXQxuV5OqRthnHYZm7JSFiC2hA
         siIpjQsZkcMn1wOAjBJRmXTAkOTVN4zSJOrAFTFAVlC+sQcaAo9486ueqnMsLRNRFVX5
         ElDgnB2Fr+CUYGl36gY+r+U558eLXw31LFEFTnx91vIFDYC9/nXLpfPdizsC/2v1vdJc
         u6c7P9MdTyMJ9cG2ZCXi+zQFK3Xk1r/z37AGDpTqx5MuknjNaNi1znbrHCcp9TKSGSnT
         6/9amFq0eBjg3wqVQzaWuOIUZMQ1V3Si9RVM4nc6aw9xOAo/RID97eUj8q/H/vf8+FsX
         LD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=3vXV2Xx45DceMgalSAUyO3UaC43SEa+f2r8tH/8s/BU=;
        b=NvDlLctkyIhxGm10LEEPjxigTo+yMTRHK6n3y4qLijeaPfRlqEgIwG3QbkYZJMDMKo
         038C8wNpeIx/MjpjTs6nEVTJAr1EbS7WKy+3KDIkIDxof1YSiJOXT25cYDSr/xgzFAoD
         +tIvTcBCSkJKzmJ8ypaNw1f49m5RecnVJv2XQk1HhIPBK4Qh8uFrm4EBrieJvjV0O6hl
         V0BtjSqPdTQqXRljbrCGiVh+aWrpR+h//JAhD5dUrWqRlLfshIIKIvhF8INwRW0QZAeA
         G+pBHA3K0z4kJw52Jk++e0MVZKh90ZbuTmBBmj4qWd+/o7tsUvnLZj8c0OTTv1bkSkL0
         4KNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=iQ0Vg8Tr;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=iQ0Vg8Tr;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Thu, 26 Apr 2018 13:29:47 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Ingo Molnar <mingo@kernel.org>, gregkh@linuxfoundation.org,
	ben@decadent.org.uk, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jannh@google.com, carnil@debian.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180426172947.GC5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Ingo Molnar <mingo@kernel.org>, gregkh@linuxfoundation.org,
	ben@decadent.org.uk, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jannh@google.com, carnil@debian.org
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135213.491879480@linuxfoundation.org>
 <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
 <20180423071520.GC28186@kroah.com>
 <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp>
 <20180423155637.GB8194@thunk.org>
 <20180426060434.b7fwrem77ht7n5qa@gmail.com>
 <201804260653.w3Q6rwVO028104@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804260653.w3Q6rwVO028104@www262.sakura.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455339806276515?=
X-GMAIL-MSGID: =?utf-8?q?1598830724671055369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 03:53:58PM +0900, Tetsuo Handa wrote:
> Oh, pull request was already sent. Should be merged shortly.
> 
> https://marc.info/?l=linux-kernel&m=152472466201090&w=2

More testing, either before or after merging, would be greatly
appreciated.  One of the challenges is that there are a lot of systems
out there with different amounts of boot entropy available.  So this
pull request was needed to help deal with issues on crazy big machines
(CONFIG_NUMA) and crazy small laptops (old/small chromebooks
repurposed to support Ubuntu and small ARM systems) --- neither of
which I had access to when I was putting together the fixes to the
random driver.

So any feedback before 4.17 gets released would be really helpful!

Thanks!!

					- Ted
