Return-Path: <mhocko@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2922118-1519134390-2-11688645876539123624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: mhocko@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519134389; b=ICCEi4vyOr9FgQfWUnfDemp40EcI0T22XUVpG4PKA/GeNkc
    7cg1mWaX2AAOYg5AGjW9Qsg0mRch1kVjA76gsnzWbH1Gme8x5uC4on8Y7fiDDiae
    4umQBTJBRWTfLYZoB3iiMvKXj6rvpnn/ta3NR7SW+KeKwKKVEbuU7oAvoS1yxGpS
    Ipcnukc+cy1Fcqf4xO7LMTHegsTUvZ66i61qoYMwfZzDXGF/9gIVUh8SrgLIN7CT
    8xiZoQC4kH4rBYjJi3pIKjorEonoUuem/TgRaWPEm2pNPYi+FJdBn3sEetqsSRP7
    4NV+1FC26OFpZQStY0CyL685pGRWlMZA9wNANqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1519134389; bh=u6otda6l0UbYR/FD9B3kImifSk055w++dkw2c0cduv4=; b=G
    ptpGY3nOtELjiJO+SOe60+TbJ6poOwgdFUfcclvDnJko4GAUFnrNbrKhSkbKTEUg
    2Yt61OJ/zYofbUccbHmdaEME5tNIXTPfn0GO8gw7BCIzN4QXOmHrlr2YzQ/X1dJQ
    scUyL+Ugljp6V56qu5AFBPkI6eEa6wjRvy3m3ITRdhzsFrQ/8KGIOYrCXr7fkqbo
    pMxkAD+0lkcWm2IEf5gH2cQXm3TlBV0U6mo05+GKDdDNAgmThAisjNY5XtDheyRD
    s8CVhaIHml4/U49SDf63Ik2eixpbJkAtItRtvElhIcfsBFGWX1sNfixpfsqcvlUU
    c3/lf5VrGUXkcttKzi7ng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=mhocko@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=mhocko@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Date: Tue, 20 Feb 2018 14:46:23 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>,
	Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Rik van Riel <riel@redhat.com>, Laura Abbott <labbott@redhat.com>,
	Greg KH <greg@kroah.com>, Andy Lutomirski <luto@kernel.org>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RESEND][PATCH 0/3] exec: Pin stack limit during exec
Message-ID: <20180220134623.GA21134@dhcp22.suse.cz>
References: <1518638796-20819-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518638796-20819-1-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 14-02-18 12:06:33, Kees Cook wrote:
> Attempts to solve problems with the stack limit changing during exec
> continue to be frustrated[1][2]. In addition to the specific issues around
> the Stack Clash family of flaws, Andy Lutomirski pointed out[3] other
> places during exec where the stack limit is used and is assumed to be
> unchanging. Given the many places it gets used and the fact that it can be
> manipulated/raced via setrlimit() and prlimit(), I think the only way to
> handle this is to move away from the "current" view of the stack limit and
> instead attach it to the bprm, and plumb this down into the functions that
> need to know the stack limits. This series implements the approach.
> 
> Neither I nor 0-day have found issues with this series, so I'd like to
> get it into -mm for further testing.

Sorry, for the late response. All three patches make sense to me.
finalize_exec could see a much better documentation and explain what is
the semantic.

Anyway, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
