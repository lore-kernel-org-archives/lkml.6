Return-Path: <kirill.shutemov@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrdvlURmIFSMmUpOuf0E2NsyjX5ag6TO1jGM4d33/+EY3TpdCs6DTCAJVhp/C38a2o8WYBo
ARC-Seal: i=1; a=rsa-sha256; t=1525275414; cv=none;
        d=google.com; s=arc-20160816;
        b=gyVZxpXtZH10HLTpdQRsC2a4xWhQM832VE6ZCEcc5R+r45GpokfF/JNKXhnRDrbHDj
         RdrDKty5asND3OOvehrykg85GiI9mdaM4QbSMFVgj1JesFhy5H1XvRIbZhzm5c2Qiyfi
         x2qpLzzyh6O6OITsbxZSkRTwziWqBNDwjUi4ixrAOIWpAPeK/+DC4sWhrKXbNRkMU+P2
         7o8ITQgpfqAmBbCSVPfzFLXpObnO3YFAkCz/DXdESn0pz6a7xUCWplU9b8x1tgZCDo5/
         wUMFe09m1l68ky4vAcNur5K66JP1m7nLwvnkxcrPLqUjzh5RKlRGmMnbDwlSm8xHXCF1
         Mplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=039/Z34Eh7LoP28KCq9kf0naIXFfIpUvsiQBFVBzTQ8=;
        b=fXUNHiqqHzYkOfo2u9EC07xG8pN19slOSure9fWYBC9cVjMnp14AE2h6DY+y6MIh9E
         hoXyNPkFqtL1JFm+b4rgV9nSeXAfoBFYne/yw9tZPs0+o5fEsp0nw3IrbqWROCqw0Ui0
         TO66kwAUEezUbwRUUIERM6eymxylTE/2dfze69WwhWVX5q4QFoBev/dnJhZ8QzoayqXE
         E7OsaYuHpB/Sw1mDBF9jLCYEPuGPJarSQAP3qGAO4tACF4mJUJ+qcTbk2ojGZ1rgTccH
         yUnzyj/X7YG1kfY8889JmtB1wOWpcUMWNE27HxWp3mZjzbGemuxvXV+HQK2dO/kRkNba
         fRng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of kirill.shutemov@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=kirill.shutemov@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of kirill.shutemov@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=kirill.shutemov@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="51787309"
Date: Wed, 2 May 2018 18:36:46 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
Message-ID: <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1599367193567048245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
> > Does having a tagged address here makes any difference? I couldn't hit a
> > failure with my simple tests (LD_PRELOAD a library that randomly adds
> > tags to pointers returned by malloc).
> 
> I think you're right, follow_page_mask is only called from
> __get_user_pages, which already untagged the address. I'll remove
> untagging here.

It also called from follow_page(). Have you covered all its callers?

-- 
 Kirill A. Shutemov
