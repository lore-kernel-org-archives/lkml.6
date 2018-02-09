Return-Path: <will.deacon@arm.com>
X-Google-Smtp-Source: AH8x2274fJlCsMU+OTZqNRw9xTO0by2r/M3v/rZHFYtLS5HH7Yklq3RhFKFtHvsdNmAv1CEu6AL2
ARC-Seal: i=1; a=rsa-sha256; t=1518184287; cv=none;
        d=google.com; s=arc-20160816;
        b=cT4B7mKSRcxPeN65ca/TGvdzIDwZKoWJXj0ZkLCbTVgUi9wJ4JkIADKVR/n89mTqKU
         fPCRdD7Ws+Pfwuly00ot7zcQEpCyvZb8Fg4qnl0A6ZAg6TKhayr7LbUddlfPxEUuNaPi
         rfFZ6n49uooWufODSSLG2qjGPcNSwbRFCofmJMaogF6EYWuL+bxgxC0ZHouegMRCghVf
         sI+ke1HVtamTh8vABwkhrPYxDuOH3EDHR8AihwAPOQkJxqP/ar3AnGHWwJCIDAjj+F53
         vuWK9WqD/KxEXOaRq9azeHVSQpkKQBG4q/r8vtbzVZJXLRmBxwSiRLuMT7M1Rli0ln/g
         SBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ym9RxdP461NcAOC3LhT1ORCtPjfmW8dHpcG9tUqFH28=;
        b=dLJectXTWdso8ltVQl2eI3tbmJ4k+w4Qwp23iSoiz9b1NNVmaaHRrPAInDOuRWNp33
         RVuNzosOpvO400mF41pKTqW1sfoPPIHzirxu/IZi5whoCaxOJDYEyHbcIbpJbaFrAgpd
         4Xpio9clh2o+CJtnIg0r6Z+2jfzSQ9nB0FkkyA2NbL++HJcQXXOfSy8qqp0XSk3+LMxL
         MZvtxp3xBKASiwqquVbT8ljrsdXy3Kdk5SE2kqPTF5lI5s2XYFUb0zllMmiUH6qARd6F
         T3BkuDOeMCy4bTlzyss7V1VVvUWQgfi0+tOsC1WljRY7QoExSe39Cc+M5gd9gPbqraZC
         oyYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of will.deacon@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=will.deacon@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of will.deacon@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=will.deacon@arm.com
Date: Fri, 9 Feb 2018 13:51:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	ard.biesheuvel@linaro.org
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
Message-ID: <20180209135131.GC11309@arm.com>
References: <20180209134811.GB11309@arm.com>
 <20180209134957.GA1677@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209134957.GA1677@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931397541704400?=
X-GMAIL-MSGID: =?utf-8?q?1591931607410211103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 02:49:57PM +0100, Greg KH wrote:
> On Fri, Feb 09, 2018 at 01:48:11PM +0000, Will Deacon wrote:
> > Hi Greg,
> > 
> > I've put together a tag which includes all of the upstream arm64 spectre and
> > meltdown mitigations based on v4.15. Please could you consider taking this
> > into the 4.15 stable tree?
> > 
> > I understand that Ard (cc'd) is using this stack to create a version for 4.14
> > too.
> > 
> > Note that there are two commits in here that are already in stable:
> > 
> >   9c9345fb26ff [Variant 1/Spectre-v1] Documentation: Document array_index_nospec
> >   60d6c8a8e54e [Variant 1/Spectre-v1] array_index_nospec: Sanitize speculative array de-references
> > 
> > so you can skip those when applying.
> > 
> > Please shout if you run into trouble.
> 
> Ah, nice, thanks for this.  I'll use this for the next 4.15.y kernel
> release after the one I _just_ sent out for review a few minutes ago.

Cool, sorry for the unfortunate timing. This only hit mainline last night.

Will
