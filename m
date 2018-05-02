Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqgHvcyTzL6Ow1GgsiLSurFHtSMN/Z1MgcSJN8hUfs2Eg2ZN4rHXvGrNqL8N189IVPoWk86
ARC-Seal: i=1; a=rsa-sha256; t=1525224483; cv=none;
        d=google.com; s=arc-20160816;
        b=QLQZElN3id0DOl2Ekm4JRlGlOcff69bbdYMzeyWt3UNgjnhbt/p9S8wHrPDp8OIx9b
         VjGzvLVUq3pbCnpTtPxqShEuqUJH9l0YjPp075adWxOscXAY4bAS0t1m4Ux/pQ4k5lcg
         1Ap//XbWTmHxe0ZCYFxTn6u/onQooC7Ry7EQ3h7PV4rVgkMzhqQC2pyIhgeaPouRYXQV
         gCIhQST3yEIb76572NjPk7FrfsAMNuh6NfPqmHlXOARq5sPQJ2JjKJ3tTsYtbDXsItFV
         2sZjmP/x+biFRG4ts2/xfl/kKsFOtVmaE9SWKbtSMVJgbekXNlI88e3CfILKIN1wbmAZ
         jEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lvdkkURigbFUXoP2Mtr7y07IMuXjubb9D21KfBdp/pM=;
        b=JdhsrRKfAo+5Fcb1a3SoN0xzZq32XQinT8R2+GCugybCt5jZD5QFBKDdDzetQZ64v7
         FwCuuOBkN0CAh++UHqjsveBpKkxLqHcWqNQ8bpNX03N/VjgYl+y7OiVxtZSIWED754s3
         HGNZk9Y9JKLvv3aG2pdA6A8l92txIqnkKYhAsDKnQDbJB3E7wzQb1grLsiSVJKjQIXRq
         F2RJZ6xs9Woh6cKyIyNKZSpzPA6nJ1ea3LKsPm36ZRb1vxtShfhBAt0zglG9ct087k47
         F54fLVsKBKAzX727p/hMU0NLlaHtMN1w6RRdoBfC43hWguFPrBlOVfwbCjfwR47k7rI2
         cbRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=crAKQ6R3;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=hJ4guTEA;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=crAKQ6R3;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=hJ4guTEA;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:IRTpWgNR300y1KT9vBm0R2bMPLqMf4hgPKfFzTn_dWyMUqqiW5BU-Q>
Date: Wed, 2 May 2018 11:27:58 +1000
From: tcharding <me@tobin.cc>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line option
Message-ID: <20180502012758.GD3791@eros>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-4-git-send-email-me@tobin.cc>
 <CA+55aFzuGrp3XGhsj989XS-vAw9S9bzFUX6mNpvPaMfew6v1iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzuGrp3XGhsj989XS-vAw9S9bzFUX6mNpvPaMfew6v1iA@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599313787518863565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 01:02:34AM +0000, Linus Torvalds wrote:
> On Tue, May 1, 2018 at 4:34 PM Tobin C. Harding <me@tobin.cc> wrote:
> 
> 
> > This option should NOT be enabled on production kernels.
> 
> I think with your fixes to get_random_bytes_arch(), it's perfectly fine to
> use on production kernels (and doesn't even need a kernel command line
> option).
> 
> It was only with the "use weak crypto" (that get_random_bytes_arch() used
> to fall back on) that it was a problem. That fixed "verify that
> get_random_bytes_arch() really uses hw crypto" is certainly not weak crypto.

Ok, I'll wait to see if anyone with a more paranoid disposition adds to
this otherwise will implement as suggested.

thanks,
Tobin.
