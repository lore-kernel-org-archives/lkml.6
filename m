Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZoCwtDWZJOlEupP024XTH0/7z07hVwQFx6FVIx0Ucs1Ev2LZjhOoUv7oxtqIjzhEDN0Vjxy
ARC-Seal: i=1; a=rsa-sha256; t=1525367384; cv=none;
        d=google.com; s=arc-20160816;
        b=XYHlOnrnO9G4TwnQ/q+u5PYuul0H3od8qUQamFhPrOX6S8bV6f1W9ltG5hYNGW8psg
         abTXNQpBqKN7/lTUxe+g63u9chwGWMpU1wd4ABJpZlvTp607hTv+MG+cUq3Mm+KC4sIM
         wpQjMRsGQcprAwafsTEmpqDLrjfl+N2ajLMpUGngpFOM5ytHWfgbgja++OX4nAHtoEu8
         Wte9a2ScCn24TZMu0qHfLTjOprLWji0qWPmfaEqKENRuln+VqVSIH/lWpf/hSirwI3cG
         6J10hi712EMNc8X3lg569B9nNNJiPLeUKBN/zeaUfbR72bY9PCfhoc2HDtlMwyNuHoMz
         JF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vlruhQBdJctzZSaFH4vlW0vopx33qIHiKIIswieTxuw=;
        b=BTckBukvJIylUzcYyuAkdoyFIOQYrPh4mDXRIqIx19QFYjmhh21BR8Ird9sBCJAljd
         cyNYOU7UbNR2D5zmHMLxW8c1DDE8c+tlGMF51u8E6Vfa53k4Ds5Iq0aB03mNsXM86j2t
         fZxmzij4iZ6KRD+6AE0j/DpCKC/8+iUI7vVyQ3WNPQ1kc2Klm3I2LCEn9VvLL23VLtk7
         d8UGy4ZSOEZL8+s3GpbRZYurLhiyQVM9dL2wMQhPQ5zm/wqyVbwoyiM0NADs+LZq2Vrn
         rHDcpuOKFkOSPPrbASQj1UiNa+LwwbqGoDJwQiGSJE8AjgLelxC/euI14ktkTTmNKSuz
         86OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=tOPD9ZcC;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=tOPD9ZcC;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Thu, 3 May 2018 10:09:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503170920.GC26754@roeck-us.net>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
 <20180503145533.GK18390@sasha-vm>
 <20180503154911.GA26754@roeck-us.net>
 <20180503160210.GO18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503160210.GO18390@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599463630765215132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 04:02:12PM +0000, Sasha Levin wrote:
> >You are misquoting me. I am saying that it would be a bad idea to hold up
> >bug fixes after -rc4, which is quite different to saying that patches
> >don't make it into stable releases fast enough. I am perfectly happy to
> >wait a week or so for a patch to soak in _mainline_ before being applied
> >to stable.
> 
> Most bug fixes that go in at that point are fixes for previous released
> kernels, what's the harm in keeping them around for longer?
> 

The ones I am mostly concerned about are fixes for CVEs, crashes, file
system corruptions, and similar. Maybe the enterprise folks don't mind
keeping those around for a month or more even though a fix is available.
I do.

> For AUTOSEL, I'd be happy to learn of issues you encounter and address
> them in my process.
> 
> I've been submitting automatically selected patches for over a year now
> and the track record for regressions is on par with patches that are
> tagged for stable.

So far it hasn't been an issue. Or, rather, not much; with more patches
applied, the percentage of regressions may be the same, but the number
of regressions is higher. My "customers" care about the number, not about
the percentage.

However, the set of test results attached below (from last night)
_is_ a problem. I don't know what changed, but something clearly did,
to the point that I am _very_ concerned about the next set of stable
releases.

Guenter

---
For v4.14.39-580-gc8cd674:

Build results:
	total: 146 pass: 98 fail: 48
Qemu test results:
	total: 100 pass: 21 fail: 79

For v4.4.131-268-ga33ce4a:

Build results:
	total: 146 pass: 92 fail: 54
Qemu test results:
	total: 127 pass: 91 fail: 36
