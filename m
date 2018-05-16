Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpmuEZU15Qin/ifTgQkNQbhvdZ3a/JbOy2VL6OoucvNWCkCrcItNUqfapmBfz4VQzbXavEI
ARC-Seal: i=1; a=rsa-sha256; t=1526510523; cv=none;
        d=google.com; s=arc-20160816;
        b=fbVu3GKTaTmyv1AudO3UQczIyB8Ox4XrbXbhkQw5EAzW2Yh0PhiFcX6rKuvFueekAr
         PPIQBVwPh/5bPKq6un36QX5x9dn8rej8IxNwTSkXdPvbGOaK8DyuImvtSula6vVjMHpz
         PI7QW1hUzsa+P8y/um6/vvy+O2WQajR0htuxfYuGohUlVtnZPn4Dk+myx7rXSDbb0gwz
         HxyJ5sAyCgIvg1W8iS5Lq3oTC2l37jTwLD1syL3HLGqB+eOTKOdWndwvhq+e+LEFTe6y
         iaLJ7RSv6Hw1Xh5kLdWGhz4BVUO2KdhwbZEN2IuuUNy06Rt2tqorlMGfq+lcpmF6mnCm
         jm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BYeL1KeEUktL12rTDEFPqffA5SBuronlPosQeDSr1+A=;
        b=RCwzJ+1cSBaHUMu18jju+Wm1YZ+M6WedEvahEVaTscYEIRJaUiBVpnesmt/rq5CMAb
         ooWlXP/GwaF0bTFRDJNYbwfkB4DELiZln/n5tt8omqlsmyutubicK12LlS2zZYKq9AcU
         CxbK8pwQO8S86uvmD4g25snVhc1QovxVcyivNNih1Fv1OkuA9mqnlAW0YVuLbQp0JXr5
         GeOHqU2C4ChS34iUIjDGsOIICqYP0Lf8B86fEzZ+1q9LROFvCuy5jUBD5yOlBqxlSOUp
         rV5gBRiQpi0XLuY4D/t3Djb2IUET39DQkeDA8cuKIFNXETTn8/OvHUYWKn+lnLANSgML
         HBrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=RfDLCE9s;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=SfotI4Gx;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=RfDLCE9s;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=SfotI4Gx;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Proxy: <xmx:urP8WsZfPUpSkGQC4XJnfrJlbtOCVGCnUjFhU3j6AhEpSc5hpacY7Q>
X-ME-Proxy: <xmx:urP8Wu-XJJl1_Y41aImndoI5kpE7Es3PU1bRzxalyCq4jW5Mgsdvng>
X-ME-Proxy: <xmx:urP8WpOBdAlLTzWh8b3lzIZ7BPXCv1-1eFiEiey1f6k9saoqYnTYgQ>
X-ME-Proxy: <xmx:urP8WhTehEgJAVPngXNSMZPoApSgnon762unRePno-lmJYDszIsTMw>
X-ME-Proxy: <xmx:urP8WoKXArggNTpl9wZf6NNuJfAAY--YWMzcMPL3FLkZOdSvN-TUTg>
X-ME-Proxy: <xmx:urP8WiOMv59qPF4az1HgMFe_Pl51j_MqIrNHW2CzLTtVs1bO0XY1xA>
X-ME-Sender: <xms:urP8Wp4EApcHxRm9U-xTg1VurYzeE3jpwfgnjnFcg3CqTnttLC09xw>
Date: Thu, 17 May 2018 08:41:58 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] enable early printing of hashed pointers
Message-ID: <20180516224158.GD25268@eros>
References: <1526426259-23012-1-git-send-email-me@tobin.cc>
 <20180516111348.1abf69a1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516111348.1abf69a1@gandalf.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600573966123035587?=
X-GMAIL-MSGID: =?utf-8?q?1600662298992144397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 11:13:48AM -0400, Steven Rostedt wrote:
> 
> I think the series looks good, although if Linus takes my last patch,
> it may conflict badly with the third patch. I'll have to look into that.

I applied your PR patch ontop of mainline (imitating Linus pulling) any
yes patch 3 of this set has a merge conflict.

> Anyway, Andrew, you want to take this in your tree?

I split this set up into it's current form because Ted offered to take
it through his tree.  There has been no response from him though since
doing so.  He has ack'ed the first 2 patches (that touch
drivers/char/random.c and include/linux/random.c).

Since this is not overly urgent stuff is it easier for everyone involved
if I wait until the PR to Linus goes through then rebase this, add the
other vsprintf patch back onto the set and send it all to Andrew?

Usual disclaimer about being a massive noob, please correct me if I am
out of line.  My aim is to make the job of others more simple.

thanks,
Tobin.
