Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZry80T8nM+c5YL6IHafHWGiWzIQa6FC0jIOgK82z7OIdOlJhoet1Dbk4ZvUHfT8//W8bAj2
ARC-Seal: i=1; a=rsa-sha256; t=1527085620; cv=none;
        d=google.com; s=arc-20160816;
        b=mvk1c2bDHKb6zVG3XrkGhO7nlKTBCcW5rkae8S+aH35DxATeSEZdVQMxemc378R+gf
         pBdpGmq/Dt3VjF57jYMaQ609+pmFWvuLb9tV0kaO2+eTiViuStDpFmSqFdnx0GvLsrkN
         W7C4+wHVk8W6bcPMlZEp/xG2S5ZAOS6BaMby5Lkd++sD9RgTwjCUE+bQdVfef++wBKL/
         NrEfQtJNFJUmS+bCJts2NssSRrIzhFy5/uxs18OxSgBJTGUTDo+vjjbYRoxAYIx2K40L
         WAQ8u3cDqf3/GaZyB1Q4H3hVUpDTnIah9SVrW8AgV4izkITIUDqC8UUXaCkvyHEu0UTu
         C2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=3189R8bGe+tnYiJ2j9YyCMbFDZVajvcyLNLZkWPF5Ho=;
        b=Ozp/N0CGLBrnZsCjQUF09SvbDosB8CYBdGQVDxjU3kKgrIPzRGZhLI/+Y2i1ks1QWN
         RwG7Q/HsMykhXgEkfrtjJZOzteG4wjfc7l0UgNXKfGmIuxUMLYp9fm0vISd6Inhxcr/a
         DaZ21TXnV2hgUnUkkRH1ZsVV3t+vnyq3A+kqxY13ND6vYt0WtBK4bmZ3S+JQEXoxyq1p
         hHij1peYp/uiHsJ+pu8EBzO0Oivtd7L9DAz9UOydcpyzL9lYZFIcJTqqlQ7Y4Lx2rI83
         E2byBuCqzNtKS7e5IjBK2LRuvVhDK28RrM0dAjLhe5F0IcpYphZBSclGVGNPHhzl0uA3
         2rRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lomb7NDP;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lomb7NDP;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 23 May 2018 07:26:56 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jes Sorensen <jsorensen@fb.com>
Cc: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <jkkm@fb.com>,
	rajatxjain@gmail.com
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
Message-ID: <20180523142656.GE19987@bombadil.infradead.org>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205015185558067?=
X-GMAIL-MSGID: =?utf-8?q?1601265331742413985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:20:10AM -0400, Jes Sorensen wrote:
> > +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Fix the formatting please - that gross // gibberish doesn't belong there.

Sorry, Jes.  The Chief Penguin has Spoken, and that's the preferred
syntax:

2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source: // SPDX-License-Identifier: <SPDX License Expression>

(you can dig up the discussion around this on the mailing list if you
like.  Linus actually thinks that C++ single-line comments are one of
the few things that language got right)
