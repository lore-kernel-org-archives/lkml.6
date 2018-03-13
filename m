Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELtKnLS7CMXO2S2Izmh9kE/e3YiIZ5ZqadAWQysN5h6mYcm5br6Pt1kTyLOg8fR+2D2uPSWj
ARC-Seal: i=1; a=rsa-sha256; t=1520971286; cv=none;
        d=google.com; s=arc-20160816;
        b=TM/mdAADUMcoZcVQqtK/FWVxMNpH5Z3fyaC8JFL3aSSMoSrEoDiWYPdw4of3N6HuQz
         PCr7MRuQg2/+T3sMbjkBg9hjren43sTXwvBLj8sGNIbPBR563PlAFoq2R/v9S1Mnhj1F
         IZQ/rnI0KxEAmPo8MJmu9u2B60x3t8d+9OCdz4jRUOYHlNW18OzRn6JBN4kC7clqgJs0
         s56FaKxKrUAmK+5QlHG106dug7tozjxfRTk7ERe8+U4IyoMuw9Jov/nIzK+G5Umxl3ka
         0cv9LVCVr4q8hFuBunuEerhaN7/wx2dR4IbVggLlYO2VorjViJiSrS6QEZQZA+O21u83
         UbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=4073UvbHtxh7g7p/AJHA37wnkyKab9l3524bhBZvlCQ=;
        b=crOOASZYiDb+nR+HfzD6UQ10iurKp+0YHZJiySD/fNf3yR0Z4KRWRpIUbBqgK0zEJ+
         tcmcLhXZrDYVeDAmG9IEXcwha0cKysMKR1Vbjryg5uUVtxv5aLmy90Kl5pDa7ZkLNz/o
         eeFvK1VXxu06PkDBRfRgA4MYUS64bqykvwkCQwuNgAVa1sNs8mRslrsryXvakKV2JXBT
         iy6XsTg/zeIiJQwu/xCKZgGSvi3/4cdc16sQJDjOPFwkXeTx0bOzxT9uxWAr6g3+bGHj
         3GcHp35zuyiK3NM0HzLkDL/CG6fX+7qXLDQfYQErx+p97JQMq44Wr1trqOSEiMbUz1jq
         LX7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=DK5TuIeT;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=DK5TuIeT;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 13 Mar 2018 21:01:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Neuling <mikey@neuling.org>,
	Oliver O'Halloran <oohall@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
	Joe Perches <joe@perches.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/8] powerpc: Add barrier_nospec
Message-ID: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
References: <cover.1520965380.git.msuchanek@suse.de>
 <e1c146e5d43e8b2605af6e1330167d8e18d36f44.1520965380.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c146e5d43e8b2605af6e1330167d8e18d36f44.1520965380.git.msuchanek@suse.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848477585828051?=
X-GMAIL-MSGID: =?utf-8?q?1594853987931433698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 07:32:59PM +0100, Michal Suchanek wrote:
> Copypasta from original gmb() and rfi implementation

Actual real changelogs would be very welcome. Seeing as I've not seen
these mythical RFI patches, this leaves one quite puzzled :-)
