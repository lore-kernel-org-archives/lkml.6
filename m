Return-Path: <SRS0=haX1=HH=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx483FQmxVjW6S/MxsOPkO6ceXE7g8gF2AEsqsqdkBcSL8d95/zrDVdD1tRN5qjOXELVnvaVZ
ARC-Seal: i=1; a=rsa-sha256; t=1524061915; cv=none;
        d=google.com; s=arc-20160816;
        b=zBcN1nwJy1GBqRN/6wyQbdzKz/p2Mkiuuswypmyq3IbB6A79TVttvveBovw+fcCAvO
         CGTaWrrX1QS3mDkK6Bzy+nIWxNiG6OxumVoDwe14BAmR0ssvRChzFoYaCAwt3rRmk3OO
         x0bDEaXva/ajUnGzgd6y8P+0X3UnYGrTKHndvKxb/O90q+BWc+UIBb0OeR1QVPrN+Sly
         6O7PHdDzKGaiXtEYc1XKUqY32d4LikSUi2tY1WLqcAIINMVYQM4QZz/w3WtwfA/UIU6L
         LiSW7JahF2Cdb1yHHDo3W9aG2G58akf5hy0kDT8NM5DFSBEWBMj1uBv61BjnwTMSg4+V
         0ytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=ApYB0FQpJug+RTL53sWJ3DwJNiH/8Wk+hLNl4RBFOW8=;
        b=WRaejmQAo8iKICtBGIKbp3ei2DGJcsE+IQF1zDmvPgSQyYJQi3rjswcb/LNiPciXLh
         qTE7WfHLtDj5bnOQxbBfzY9Firq9QRkShDbfRC1MW/F40eCjmUqcDqMjW4UmiiYjUCKC
         vcYL5lyrj5FNupOpOkOhP/XROx0a0X/pabNJhK9zWXFpV4QF4OcN5BW7htzE0jvG6MYU
         wINsRQLE1EIq/DjNKzvChfmNJuo/BSroVGGZVYsmADE1A9tzKxAZA0qLVdkf3VtuBB77
         xUDxehbGGisjeBX7c1e9tncCzBEAVxhEbvX41qTDD46prkBRznNA1t0D+bKxULvhgTw0
         U5Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=hax1=hh=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=haX1=HH=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=hax1=hh=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=haX1=HH=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3873204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 10:31:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ahbong Chang <cwahbong@google.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Todd
 Poynor <toddpoynor@google.com>, Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] trace: add missing forward declaration
Message-ID: <20180418103152.366b42c4@gandalf.local.home>
In-Reply-To: <20180417102909.GA8057@kroah.com>
References: <20180416023626.139915-1-cwahbong@google.com>
	<20180416092444.05ec6434@gandalf.local.home>
	<CAEvWiR--DLM2Tp8-OaZSh4LV9o8x2K47c9=-+VZFoDhedy=nZQ@mail.gmail.com>
	<20180417102909.GA8057@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597868580333311001?=
X-GMAIL-MSGID: =?utf-8?q?1598094747029821393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018 12:29:09 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 17, 2018 at 02:18:47AM +0000, Ahbong Chang wrote:
> > It does not fail with any config without this fix. This is for new work.  
> 
> Then why not submit it as part of the "new work" patch series?  That's
> how dependancies are normally handled.

I consider this patch making the kernel more robust. The reason I asked
was to know if it should be marked for stable or not. If nothing
currently relies on it, I just put it into the -rc as a "make the
kernel a little more robust" change. If other code relies on it, I
mark it for stable.

I'll take this patch as more of a clean up.

Thanks!

-- Steve
