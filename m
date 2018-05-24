Return-Path: <mgorman@suse.de>
X-Google-Smtp-Source: AB8JxZokJK7/P/YIF4EKu18bZ1P06WdNzH5kefcBoWDLm27P4rzMZ+VqcEJkxIglvdH6yEK7PG1W
ARC-Seal: i=1; a=rsa-sha256; t=1527172732; cv=none;
        d=google.com; s=arc-20160816;
        b=FDrbgYUtl+m/6ItBFoVogM4EWACTZhW1x6sXmOl2+C4cO+3IL1zjtnB+AEMFLlJtT/
         y/b1abAI2uojT0HdF7OsiagU/Mw24ZBeB05/VS1RMj7yfC+EFiiCGc/g3umyTfCjbNDp
         vvv7TXcLzuWe1M0Z2Xy7Csu6ice9ASlCQQFZMeGVL0QTta5jzdnUyGpCwljNR1ShyoW9
         7QDe/KzfE/7zXl4N5NC6B8nBAlqmNmIBRN+8/o7Dnx7rA9hZnmbE5m9INcDJv5EXp2Bc
         YZc4v4yM/7iz/5/FGf/0dq0Ex7vohKSMGZz3o7A3GmEbzRsq3MBPlHX77oZSX0H8UbvD
         Ue1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=W1W5BEsSwA7txvFZSIC7ysjhs5YMA6X23tD5wE+7AEo=;
        b=HVoyLkeNxmzQpbCLORam4jFfWpBkzZDoY9Pd70ZOeKl2C8irsOYvc1/pmAxEDbILeU
         QFND6vaW/TwCi4hABNHzqdBAtwup0roeSeECv+fybQCEfnb/EIqt24q02NtFkZ4Gc1wy
         vzBwV40MzU9YqIa0vnWBtIEOEREWk7SoYfGM8zIQX7Ki9+pjfdeSm9qCtObo3rf13/LS
         13mA2jXITTorE7CCvnueAPZEyoT4ZlApNuTyrZrNLluLLpsXeqvd9EdQb4vinn2/W/vg
         mclsySCCVg8Tzmom1FPJEyaSs4+7v53DIHTy1hdrBoN/aXy1xJuTrtPcUNJPqeiSuiQN
         v21Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mgorman@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mgorman@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mgorman@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mgorman@suse.de
Date: Thu, 24 May 2018 14:12:37 +0100
From: Mel Gorman <mgorman@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
Message-ID: <20180524131237.soy6jm3ji2pe66id@suse.de>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz>
 <20180524110546.GA16171@kroah.com>
 <CANsGZ6bsz-J9XB_O5+B+mmRV2CGaJ8e+Aa=N3WnE7YNARWsAnw@mail.gmail.com>
 <20180524112841.GA17626@kroah.com>
 <20180524120237.25y5dqpuvdufwiam@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180524120237.25y5dqpuvdufwiam@quack2.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338268833986557?=
X-GMAIL-MSGID: =?utf-8?q?1601356674934786476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 02:02:37PM +0200, Jan Kara wrote:
> > This is in the SLES kernel for a reason, and again, it's in the section
> > that says "this should be pushed to stable".  So if it's good enough for
> > the SLES kernel, why isn't it good enough for all users of this kernel
> > tree?
> 
> Heh, fair enough. I guess Mel in the end didn't find patches worthy enough
> to be pushed to stable tree. But at least now I know they are well tested
> with 4.4 base so they should do no harm in the stable tree so my stance is
> closer to neutral.
> 

Early on, I backported a number of performance patches to -stable with the
view to having a good baseline to compare a new mainline release with.
However, after a while some of them required unrelated backports that
would be excessive for -stable. While I could have continued backporting
some patches, I stopped as the time required to run all of the performance
tests is excessive and I was already tracking too many kernels.

-- 
Mel Gorman
SUSE Labs
