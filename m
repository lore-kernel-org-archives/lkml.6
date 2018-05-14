Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqceymRXhq3wOxV9Z2a+QUh3CYyzlCkwSqy7n2I5wEz6IJRRquW54c2wefJJT3DUWIdBbOP
ARC-Seal: i=1; a=rsa-sha256; t=1526295395; cv=none;
        d=google.com; s=arc-20160816;
        b=QFPCvZ2EMAZQvFwC9T2qegY6Nb6OymtyKBLzbcZ4APwIBng4sBA3v0ZOvDo8HjjMwo
         sxPr/DBVSTcGNYxnQJPfkhR5PiA2z7Jhb1fEHNnspsc+LxLaL0x3TJCotnGxoZ1SE2Fj
         1RYf97wV54cQgBi/zmThe77iERvzi8pXhbb8zG4lcKizUKTNSvUxyW8yLWIYxn3Ri6NQ
         nmFBxtnpuSSqWT91X5xAYn6JwCk8Pm/hCaGDyRoPHcxZSKF7D2xdImz9TCEosZAbvho9
         Sueu0/0KQR6EnQ5u9c3DDbed3g5dlaSUZpBqHQo8/mlYWUIJGt3S0HhdY1AMpAxK2nrg
         KQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0c7yoRDOlAfeimR24Go/oGWBiXxYAccbZdCyEELgEJA=;
        b=Ft9kqIwEpVgBI11lQJGGWTH0hSuqChM0jz5MBgbwmpkXWIvdGSKrbwKLtAW1PZnVWa
         t/GtVJRp8EPs1MV/r2fcV8yLlh9lTxuhdYDw8yNzvEZyOUcRS5EKWLqhsck7ILG6Cnph
         F2u+1V6mcQ3m9FEdoCV7yGVnWo0iYhJGAKe9FxD7+yYaqvsOjjmdWTvRyTxupz+7UiNM
         YPNBcpKnOhBKl7iZVB7xhbP04Dt31vOVoU3ov6v0IICHIOUztFA0yhygZyDCZto010HU
         Uv8VAgECCZDXyyVeNlsop72O1vH1Cnh7i+hLhtWO6tPzl3ugqB7ZyyKnKoFzKzLHpFyA
         C/rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="54988703"
Date: Mon, 14 May 2018 13:56:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] usb: typec: Support for Alternate Modes
Message-ID: <20180514105631.GD21435@kuha.fi.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
 <f82856a4-5841-0656-e9a5-68b035ca91df@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82856a4-5841-0656-e9a5-68b035ca91df@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600173870143891616?=
X-GMAIL-MSGID: =?utf-8?q?1600436720563042731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 02:42:47PM -0700, Guenter Roeck wrote:
> On 05/11/2018 06:18 AM, Heikki Krogerus wrote:
> > Hi,
> > 
> > This is the third version of my proposal for more complete alternate
> > mode support. In this version I'm including a proposal for the mux
> > handling. Basically, I'm proposing that every supported alternate will
> > have its own mux handle. That should allow us to support multiple
> > alternate modes at the same time. There is also a small change to how
> > I handled enter/exit mode commands. Now the alternate mode drivers
> > will need to check if Enter Mode command ACK/NAK. The ->enter callback
> > is not called in those cases separately. The typec_altmode_enter/exit
> > functions are used only when the command is initiated. Other than
> > that, only minor tuning.
> > 
> 
> I like the both the idea and the approach.

Thanks! :-)

> I browsed through the code, but I don't see anything obviously wrong
> with it. Too bad I wont have the time for an actual alternate mode
> implementation. Are you working on one, by any chance ? I would like
> to see this move forward, and an actual implementation would help
> to get there.

Yes, an alt mode implementation is definitely needed. I am working on
something, but I don't think I'm able to share anything before next
week unfortunately.


Thanks Guenter,

-- 
heikki
