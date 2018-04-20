Return-Path: <sergey.senozhatsky.work@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524190718; cv=none;
        d=google.com; s=arc-20160816;
        b=AgqBba2f6185Mb/KZw0PCvt/nc4BeQ7t+AT8kqDUzH/HwFJXEFwO7KKseSs/wRBS3U
         ei8Sdqvdh/840gSG79kqZsKt8lqwkOK26xwMJUjwiItmp0VrfX/Zk2O+ZAaC37tRxBT0
         F8RLiogQ2ATJTcgrTGfGKrG6MljvOlED9jgLjtXFAvW3xectZV0kHj/7K59qMuGlHMTs
         8eGtg66maXx2kCsD+BPfteWtuROTqosWxorqSxbFscyFecadh2bI2otTHGlLZv4DgFpg
         2jJwAdKDqxxXeCBHBEKV9/Eq+MGUYJ/19IwJKsSFjVR8pa3Be0ikxw/e4OUXLoPNG1cF
         X21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Uw7laTzJbeWbK4ljJJ7YAxf12YvGUybGNH4OoMat06s=;
        b=T5YhgjMnDbRTocd2Yqi8KNchKTUrECeDfXEt1UnVG3XfvQ60JvQ1joC/+zPZMMZJ3q
         PcjODEPSt8E+231OMmj4b+e+yle1oLG+b5yQlnSu0W64YsGzPlUD/+dHjMritSqcjd3f
         BD/yu4soCT83MlpK7U9Wl504mWhL8oUWPNGrJbv0nppT8PThidIAemXmqgFyhiQrA78E
         MGaB/Pyg+qoZSoRUXDextvD5VnGlu9r0Ict0whlExInk8uPXjmGQvqMpZ1MzEsPxl4LR
         GpjQ13PNi3+TnxWe8+ks+TPgMaM15/mzQV7MnHmwZ2qi4iWxJI9XmjLUQo6hxXWs0EQd
         kvfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J5rAsveE;
       spf=pass (google.com: domain of sergey.senozhatsky.work@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergey.senozhatsky.work@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J5rAsveE;
       spf=pass (google.com: domain of sergey.senozhatsky.work@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergey.senozhatsky.work@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4++0ceCJwpqUtCglFeZ2lPQWYB1z5RdKP4zEp11BOH2uilfC9Xf3shZVDoz7sRiR2A2GRzfKA==
Date: Fri, 20 Apr 2018 11:18:34 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] zram: introduce zram memory tracking
Message-ID: <20180420021834.GC6397@jagdpanzerIV>
References: <20180416090946.63057-1-minchan@kernel.org>
 <20180416090946.63057-5-minchan@kernel.org>
 <20180417145921.eac3d6379b5bade6c4f1a091@linux-foundation.org>
 <20180418012636.GA196478@rodete-desktop-imager.corp.google.com>
 <20180418140715.4af4e837d6048a82117c85bd@linux-foundation.org>
 <20180420020921.GA155841@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420020921.GA155841@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1598229807103406491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (04/20/18 11:09), Minchan Kim wrote:
[..]
> > hm, OK, can we get this info into the changelog?  
> 
> No problem. I will add as follows,
> 
> "I used the feature a few years ago to find memory hoggers in userspace
> to notice them what memory they have wasted without touch for a long time.
> With it, they could reduce unnecessary memory space. However, at that time,
> I hacked up zram for the feature but now I need the feature again so
> I decided it would be better to upstream rather than keeping it alone.
> I hope I submit the userspace tool to use the feature soon"

Shall we then just wait until you resubmit the "complete" patch set: zram
tracking + the user space tool which would parse the tracking output?

	-ss
