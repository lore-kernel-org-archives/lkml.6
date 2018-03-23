Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELvPbEb4XymorLAaVtmOKhhNo++bTPni1yrGRgMIjWQlDTTKYSIOdTtNfJY1bMsaOoJAkCjh
ARC-Seal: i=1; a=rsa-sha256; t=1521809365; cv=none;
        d=google.com; s=arc-20160816;
        b=Co7oYd3e1D/XM7MwbjG5PoeqqKvdTRDU+7amcUAMi73Vtf7sslTcVJ1+Awge2eXO0S
         n2uoP17bQnqdJzFbem8G3kNVEjZ73rQEYZZxgcG9rCgN/GT25GD1MeEyL1BmmdxwQ6o1
         K4BVeF7/4/8v3WDjQpXajX7YeQ/MQD3x7tfyTE8gn78U3NbNFoS7K9e5TQuHsnm1Kr2/
         mJfKssajobRxD7lURS8fLnoTi16NQqLbjpH7AUjZpz/OmaBqPbckhAeYIe+rWG/KvYIX
         pv+7BmFtX7dkcTtNCCrpSyLHGN579xjzJxQqOxj2BGQEnVHtHmc9AAGzE03n/LBcAazK
         wr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7orINHI4+601Ya7KgoqsfTTqu+zqpdOM8kMSG4cJqJ4=;
        b=RxQ9+H+Pjdmd5CI4fYlf66hP3rkHM/6v/sJgXLdZSl9wnT+8a7j1S0+aQOqNHqQFGj
         U23RZFbpVqV0kKZ83LGqWeOFcq1uL7ShwMso85QEtB/28oKj1OOzINeUwXUez+3aYg1W
         hR4UHXG9DlUDaoHinM8SarFa6oLqSSEaLQTjQRfGyetjidFWnWG2KNRBmF+XPXZiuvXB
         LpDN2e8bJ+osQrvDEPsqPOE6XXpV3+R+ICsPxFqf6PEB8eb5tPBrlp4cSwllE+ekcmmR
         hFRfCp5ZYTBnktidVpLx5Jf9gBJnJyTNPSFVlWqhpBAJ9pQyDGCjhty6JwSKfTWxNxch
         B/EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XGcfqtIq;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XGcfqtIq;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Fri, 23 Mar 2018 05:48:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
	vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
	fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
	jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
	deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	akpm@linux-foundation.org, steve.capper@arm.com,
	punit.agrawal@arm.com, paul.burton@mips.com,
	aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
	keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
	nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
	dan.j.williams@intel.com, jack@suse.cz,
	ross.zwisler@linux.intel.com, jglisse@redhat.com,
	aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180323124806.GA5624@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595732776960572022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> Current implementation doesn't randomize address returned by mmap.
> All the entropy ends with choosing mmap_base_addr at the process
> creation. After that mmap build very predictable layout of address
> space. It allows to bypass ASLR in many cases. This patch make
> randomization of address on any mmap call.

Why should this be done in the kernel rather than libc?  libc is perfectly
capable of specifying random numbers in the first argument of mmap.
