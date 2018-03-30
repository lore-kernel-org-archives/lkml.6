Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AIpwx4/EtHiFrYZIxNZdC1yeeuT1HCiqhCgcdoGiEwpik6Q/xVZ5INVH2mmjDUIf9jhiel7iJmQP
ARC-Seal: i=1; a=rsa-sha256; t=1522416974; cv=none;
        d=google.com; s=arc-20160816;
        b=XfUx6AOyUolvlutm/imHvOeHQs18qQ6no3V1rLRuEx9CMaDzT0Itx9vng+f/TObzdB
         hkqkVuUXcPpEzeI9/Ml2+gyvZT7TbUVGlPlNNNXNJfjduLKmQ8GeV2BT65OajOOqS6ir
         h1PzzFfZgIegeG9RFTXkqN+RjO+xq0Of2WDpcKJlbOVpqXJgjEIlvUo8da/AIXy+FNiO
         SXdV3Fwa/hXaZNed8m/2gZYOsi2FjyqonksVts7rLhgvn/9SJ1lxLWnMN77e4aqeGscg
         Rnc/tmiJcZQN8YythdOJnK2hmIbu5yMJv98FKUFw2CUEstYeyLUayb8ZjnG9JJpzV0Cp
         DEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=unLrJkcKTk4y8YOSC9S+MVfHaBZqaDdQtlIp+z/u4xQ=;
        b=kAKy6TDr+F3+DNbZ6eN06kwIq0zW8Aai2c5U8p6ZC7pzsRaOuG6gr37o2UAgKtmlz+
         Ni+wv/FddKA13QBAdsPt9R/Mgkvd3XuhWRO73hrZeBEIHlP2C6np301rS6V7OPdf0NRQ
         xQKaCaAb0A4nHBMnZlU4Pv5VdkXwHZOmZ14676wXc/hz/Gn1v0/ZhRyvvoaALHRVheMB
         jrniGS99jGNFXpZoeLWboXtiVoATBt2acOy7FCklCkLymU78Yh2s2kkQoKNRT7RKCeIT
         THDvCVsXemlmpBq8gkqv23zaK10PWakuylpWyB4AgOULbIFyrFPL+arLig3D8mDv630Y
         yReQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Fri, 30 Mar 2018 09:33:48 -0400
From: Rich Felker <dalias@libc.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ilya Smith <blackzert@gmail.com>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
	linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
	jhogan@kernel.org, ralf@linux-mips.org, jejb@parisc-linux.org,
	deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
	mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
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
	willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180330133348.GR1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180330075508.GA21798@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330075508.GA21798@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596369901168758070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:55:08AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Current implementation doesn't randomize address returned by mmap.
> > All the entropy ends with choosing mmap_base_addr at the process
> > creation. After that mmap build very predictable layout of address
> > space. It allows to bypass ASLR in many cases. This patch make
> > randomization of address on any mmap call.
> 
> How will this interact with people debugging their application, and
> getting different behaviours based on memory layout?
> 
> strace, strace again, get different results?

Normally gdb disables ASLR for the process when invoking a program to
debug. I don't see why that would be terribly useful with strace but
you can do the same if you want.

Rich
