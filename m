Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZrTPkn+EtSIOl05RD5bfMYPUFyvTbQFt2MjDvI7UH58brKa4pXQ5v0BtE3y1fI+sX9SXH3Q
ARC-Seal: i=1; a=rsa-sha256; t=1525358940; cv=none;
        d=google.com; s=arc-20160816;
        b=q0ukQgNOpQZeH4bCGn9I3V5EAGITAA1KGCfCyaY3N81/eDISAAcaSu3V0pZmeD0FVF
         8lbR4MA8d2QZ4AQTCEZSx8j9nF3kdDLBx22/K+AYN0DENSOiQTOd+1zVkUwmFWwRZJL2
         IOVWnWG6UFAfnc8s/KGo98UMcGvuR/HJl0KDEDOIzJNSEE46d/2GBolAIjEumvvk80D3
         zmeTvlUYc2BrUyv9Ju+6hJ6ZOFrJFTGTw8o/qnJpf8E6+h7ogLSo4qe0a1wmRrmVAd0L
         8VcYGS/9+T6axhTAzVGzd8cIMQYkJLua6k9jOlhmra/JGW5BHr8ABSFB6WH1jibr2rak
         QgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lMu9L+xLorzBOih6RwF8FO+kiaCZfiPegwo0c7Qnswc=;
        b=fKt6ogXW4V8JvXKbSmEFLU/zj+Dc0d2KOq2jqCli5i5ifIMztHn3ihAeQDdNYOxyPK
         kj0CfnUaOHRw1mE1ZD5kNfcly1ZP1VGIjDOrrld52qnTPAgXQ+CvJKJrdKR4yuI4LKym
         IHYH89tZnOrvQ7o7D2fEgxjwM9Hf+D8TnVUBYf9Ct7oJoxLfkkSxj+JbVUh8FrDCvWMa
         Hd9MHHCqVRtZ6w/PguKCrejikoC5kwpbzIRZGuPMrk3G3gqUMN2PL3rO3dKP7vHihsRJ
         Ypn3dmbu+RJmN0k5g8NMPbu4edepAxs75Tn8W/+6EtQ9YOTwboO2syYgd6rfdTPZeRDz
         yysQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 16:48:50 +0200
From: Willy Tarreau <w@1wt.eu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jani Nikula <jani.nikula@intel.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503144850.GC23311@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <877eol808s.fsf@intel.com>
 <1525357984.3225.12.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525357984.3225.12.camel@HansenPartnership.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599454775613183467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 07:33:04AM -0700, James Bottomley wrote:
> They're definitely for bug fixes, but there's a spectrum: obvious bug
> fixes with no side effects are easy to justify.  More complex bug fixes
> run the risk of having side effects which introduce other bugs, so
> could potentially destabilize the -rc process.  In SCSI we tend to look
> at what the user visible effects of the bug are in the post -rc5 region
> and if they're slight or wouldn't be visible to most users, we'll hold
> them over.  If the fix looks complex and we're not sure we caught the
> ramifications, we often add it to the merge window tree with a cc to
> stable and a note saying to wait X weeks before actually adding to the
> stable tree just to make sure no side effects show up with wider
> testing.  So, as with most things, it's a judgment call for the
> maintainer.

For me this is the right, and responsible way to deal with bug fixes.
Self-control is much more efficient than random rejection and favors
a good analysis.

Willy
