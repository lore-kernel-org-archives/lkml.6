Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2121535-1517565994-2-6428738356411757298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517565993; b=bZZBdzgRRBN12A76QyFhCZ+VVUbSeNc1WuYPcVwmL7yMgAM
    6G2Ea59g9CkOclhPqCJOp7QSFjCWkB5rUp+4pEZuvE2rmibYbxJ6yl1nqfhrJQZO
    UoUFlQuW8yqZotCm1QQ1/UorHBNfsvv7rQskbQvxVxE+6QaLaP5v+fQll9wIrcpr
    sPgVyI8m0Z0zPPDGZxhxGndJTYhUBvKdAN/h7Xj1P9Y9hM4fajjvA/DqERzFomZU
    JCRBszgL/OWaR/c74Gak2FwoLwa4dtwvO1gvIsfMXL/F2kEUsjxF8MvzoKWwzybR
    5vlwWpE7ZQqlyw0xHAEMi0uCfBdv5mf838zbNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517565993; bh=l4oWRtP4
    qyhEO41DySMyWb0DD6vw09gTHadCDjdo8Lo=; b=KYKadmrN3oCddvyO5OuXDRsj
    f/eejauMQNlgmvweRCuqsUPWIw1gzKr3vdqie6HagoCWF4k07FL+AK5g5fmxDGDg
    12M8iNwTiPDhv6OmANOh7C00UE/qxHFmO404hLcDfZWhOK/KmUeqKFf7Z4sEk00L
    XVR6ha9mLy2QBkY8AUI8ZUWDVXTyrNS5P/QKL2EJwhqprK61VYzL+ufmPex2RHG0
    1ZFQmdaJevY+1tFcuC3IBXGWt0x3+SBgaqk7VQdSuV5E0Zhn0Iz3wrwKnuffYXbP
    gz/4aaOOwmS3kDaVcTrnbwx+SOQxl6YQLe9cBCChER9bHRPo5Xzk4ZjRImosKQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Fri, 2 Feb 2018 11:06:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <20180202100613.GA21492@kroah.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
 <20180201180240.GA28042@kroah.com>
 <alpine.DEB.2.20.1802012045570.29994@hsp>
 <87372jkcu5.fsf@intel.com>
 <alpine.DEB.2.20.1802021054500.13838@hsp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802021054500.13838@hsp>
User-Agent: Mutt/1.9.3 (2018-01-21)
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Ozan Alpay <ozyalpy@gmail.com>,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 10:56:36AM +0100, Lukas Bulwahn wrote:
> On Fri, 2 Feb 2018, Jani Nikula wrote:
> 
> > Being brutally honest, please write shorter reports and shorter emails
> > to the lists.
> > 
> > The static analysis reports are welcome, but only when 1) we didn't
> > already fix it in linux-next, or 2) it reveals an actual bug, not just a
> > warning, warranting a backport.
> 
> That will be our policy.

Great!

Also a few other things to be aware of when working with the Linux
kernel community, and to try to answer some of your longer original
email querstions:

	- don't scatter emails to tons of lists at the same time.  If
	  you use scripts/get_maintainer.pl on a file, it will tell you
	  exactly who and what list to notify of an issue found.

	- when finding an issue, again, always check linux-next as that
	  contains up to the past 3 months of work.  Don't duplicate
	  stuff that others have already done, as that doesn't help
	  anyone out.

	- for stable kernel patches, please read:
		https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
	  as to how to report a patch to be included in a stable kernel
	  release (hint, just send the git hash to the list when it is
	  in Linus's tree and ask for it to be included, as well as what
	  trees you think it should be included in.)

	- If clang now builds the kernel "cleanly", yes, I want to take
	  warning fixes in the stable tree.  And even better yet, if you
	  keep working to ensure the tree is "clean", that would be
	  wonderful.

Hope this helps!

greg k-h

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
