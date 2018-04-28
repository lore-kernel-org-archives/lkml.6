Return-Path: <giamteckchoon@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524916478; cv=none;
        d=google.com; s=arc-20160816;
        b=D5TMuRNzE35XmjpjrLyRPqHGKcprXHRsyaLeIXTJpnIFpNxTdlVOGznYvtg2yfuH+e
         +aZahg+WBWAXicPwWMQSFJknPf2LkYKm+mgVcRsIPrKeSv23Eu1I8vvEyt9KsweZ4uih
         ybbu9R/tbKlzXcICfs0uHAO7GHSZI6pT+DY2xvpTqqJ+qMD3r9Ql0xaRzH9YOOUvUWE+
         z1uojCcdG/L8lyItPXFBYK6iIyHmi5WM9gBoZnuuNsQWLoz19aJXPwPLyYhUxV88GNOP
         RF6B2UxyMT4fIgLUyyZSaDvlFtHaw7Mi7OIEZBn0wFYCxtKuqX39w6UGfCwUnffS+BBG
         r+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=D3ew5Jerv/2efGOa8G0uosMm7HAQpGZxfLv96N9Tkzw=;
        b=Ag00DmIPuS2vDzjvq1pxclCi9wr7UKvCjaa7XQF2v0Ry3RRsHy3S0G1SXNPvFpgEy5
         oSGCvzeo21raVi7kkq+qK6rH2h0ebC0Osu7VdDUGR7wOyhPZ/gGIARwRkgF38xN+TK/q
         zVm0H5KRT3XxY9cex9OcCh1BGRujcYWZApjRFEyv/ryo22fHMpgt0HEbwAp7K9iE9+ci
         fk31zgZrg132GwmxRs21Z+jCU8ukukysd/AHSHng4/3GIOY/BVv4LRkt62BI+DdlNJ7O
         HdGKvtHWl6sBAdad4eoYPqb2Cd8s+2MvTVZtsIGqfWGSs4NiC6NhnbKPPa0vYQYuEage
         Z34A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GBgdZuhq;
       spf=pass (google.com: domain of giamteckchoon@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=giamteckchoon@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GBgdZuhq;
       spf=pass (google.com: domain of giamteckchoon@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=giamteckchoon@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZo3xg4Wc9tfofBZAbCAdpeRhKTWR32gtKRp63h/0d1TH1/ERAdn9GJCf1zLcnk0Hdag8x9wQV8AVEPk+/BxdTs=
MIME-Version: 1.0
In-Reply-To: <20180428081122.GA27926@kroah.com>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
 <84b1d534-9b9d-ff70-ead6-3f8bb70a4d4b@infradead.org> <20180428050026.GA29422@kroah.com>
 <5a56f585-d3c1-ee42-20a3-b47921f160c4@infradead.org> <20180428081122.GA27926@kroah.com>
From: Teck Choon Giam <giamteckchoon@gmail.com>
Date: Sat, 28 Apr 2018 19:54:36 +0800
Message-ID: <CAEwRVpPQeHZqXaX55nx93rZihzVMm89aSo_aiP4yU_56gkOq8w@mail.gmail.com>
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1598370592739113214?=
X-GMAIL-MSGID: =?utf-8?q?1598990821109318389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> It still fails in 4.9.96. (not #defined there)
>
> Should be fixed in 4.9.97-r1, I know .96 still had the issue.
>

Test compiled without issue for 4.9.97-rc1:

wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/snapshot/linux-stable-rc-linux-4.9.y.tar.gz
tar zxvfp linux-stable-rc-linux-4.9.y.tar.gz
cd linux-stable-rc-linux-4.9.y/
make mrproper
cp -pvf ~/config-x86_64 .config
make oldconfig
make bzImage
make V=1 -j 2 modules
make -C tools/perf V=1 HAVE_CPLUS_DEMANGLE=1 NO_DWARF=1 WERROR=0

Thanks Greg.

Regards,
Giam Teck Choon
