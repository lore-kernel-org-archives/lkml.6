Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AH8x225xZzGaxNzoBToTe3h20+nc/5WCGKGtDpUPZq1fr+yfELN20XJNSWB5/tXYKqIiG30JovtV
ARC-Seal: i=1; a=rsa-sha256; t=1518982735; cv=none;
        d=google.com; s=arc-20160816;
        b=ipWuC4DFQttisHJzueISy5R4Iuvy1rQU6Lk+I2yodyAavvVmslctAeDtv5ILmZDPr6
         dn4Z+20z1Kl3H2JoOp6T/U9pcDLO0pO+xj6PoObYB/y8TSXgKbhu60na9p/75brBFmC0
         WTnzDnRslTQNs0K7JWNLoYfwFPFOpgqRSic/dDMmeBykrq3CsjLDGnlCBCs95BKSI+GY
         Vri5JqVSi7epV7lhHgg7dtVL/T8Urfsiw/6jOduUSFpgG6MLE12ruEV98RP87W53BJGE
         zdOIajxN1Jeb5c4qzZ/DMp9XNFiOCjbQxWzd6r4yhmAhodufRwtONXxnNmodwLULtK82
         x+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=PSeRlbFqrjpc/ze9PsvjePVKWLu31vYmsE8cpIz4KEs=;
        b=B/Z2kvxNzpCgIPgLayCT+pHGAg8DciSlyKIGJ6lAnQA2S0S84ijbxrtJLORI7Tm0Y6
         hVAXWWjcfgRTIl+kkDGQifgdXemjdRFaoRe3sMYFXQiRlEqHjAFiHZ2mLE0kLUjdWFsL
         X+TecsKQjDbSfiZKKT2VOfO8v53UiiIho9zuZ+U48Xs2rXE7EkHejan3U9rMdcSZrKvB
         7vAwcSJTqLPVRHBX/jEL/oRfm3T+nCInjTLb6MbRG22yFIo0kYbj4IajIjnQA0P+TpE/
         iRBdeGtWelu6eq7xgSi4EmnBQyDfRk0fLbn4fsE/KIy8oDhkkHfBCoIyPR7FhfCCr7gg
         tOlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.15 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.15 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Sun, 18 Feb 2018 20:38:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Yaakov Selkowitz <yselkowi@redhat.com>, linux-ia64@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Marc Herbert <marc.herbert@intel.com>
Subject: Re: [PATCH 00/14] Add Kconfig unit tests
Message-ID: <20180218193849.GA29324@ravnborg.org>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=X9181lbe c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=nNJFIwgQenCfl4jgyecA:9 a=CjuIK1q_8ugA:10
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778603176357?=
X-GMAIL-MSGID: =?utf-8?q?1592768840268033839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro.

On Tue, Feb 06, 2018 at 09:34:40AM +0900, Masahiro Yamada wrote:
> I am applying various patches to Kconfig these days.
> 
> However, I fear regressions.  I have been thinking of unit-tests.
> 
> There are various cryptic parts in Kconfig and corner cases where
> it is difficult to notice breakage.  If unit-tests cover those,
> I will be able to apply changes more confidently.
> 
> So, here is the trial.
...

Great to see this done.
And +1 for basing this on a standard framework rather than inventing your own.

> If you have an idea for better implementation, comments are appreciated.
Nope, please continue with pytest.

	Sam
