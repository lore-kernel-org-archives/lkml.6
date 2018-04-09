Return-Path: <jlee@suse.com>
X-Google-Smtp-Source: AIpwx4/zQIPibmDWSDh0SetqjRjMIipAN7fFcniUgndM9WxkFuIFK98MXOZbzSNTHD92n6RZd/1E
ARC-Seal: i=1; a=rsa-sha256; t=1523282170; cv=none;
        d=google.com; s=arc-20160816;
        b=kE43wmjdKWBoI4lwre5+BJXTkGEm3JR/rXFpfVN4hyDw4Is2j9IbWw0ljH/eepmp+T
         J1PEpqmZQVJnN6yF3pJ6tv6VvRPi3SxzQbbtW8o/6vJccb5SeJyDanH6xMWBChPhp9WM
         SQg9rRYKwEnQRXwbIClUEf66jXfDNXLbjB5Ntjklr2YuF43O5K63PLXqGND+OvM/oYpq
         1SysAokc/9AsKq/g9KcSm55M6asm5xbIuRe/p6GPINCBDftl18LGHaBAzdbcglRHXZBu
         Ts8pkO0HSnZ1vcRlS2SxSXFzH4AWVKRp/x8xOHghfoiOegvEk9CU1ygRbovjDxQLvI8v
         e4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=q65GfyEsZ4N9z18+Sk8FVq0ZmRzi7EaQ3M1t5pklS1k=;
        b=f1ugJCyGR/VfAOjxL22Am/Vf+g/+7717gZp9YOwYLcxnUdu1L94vIW+vZKhRZ0cIaG
         Intz6VlZ8OqXzPX3zJlULj9+WsRbUrwYLKR3P9a1KTARge6wQuKBV7ovpA+bKEB4QgRw
         au7ducHaOU9mW7lx/PcXyDB5nmfRWNtpiHbm7IOutEnb1BfwwZCTSzf9a3CWCXE46vgI
         2ogiceo7PtltLr/E3jwAJt4CwJRKGaIH6HEmn8x6jAcUelHEa8WkZhfNu9E2eqCv7/PC
         uaFAGXllw//Q8cE5eKHMl/Qo6MLgovtdvSw7p0dnybBHY2PrGbLSqF8lhfdFNG20oTTI
         mitw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jlee@suse.com designates 195.135.221.5 as permitted sender) smtp.mailfrom=jlee@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jlee@suse.com designates 195.135.221.5 as permitted sender) smtp.mailfrom=jlee@suse.com
Date: Mon, 9 Apr 2018 21:55:47 +0800
From: joeyli <jlee@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morris <jmorris@namei.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Garrett <mjg59@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Justin Forbes <jforbes@redhat.com>,
	linux-man <linux-man@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180409135547.GD17840@linux-l9pv.suse>
References: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
 <20180408080742.GE7362@linux-l9pv.suse>
 <20180409034008.dyte7k5kgkbjh5is@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409034008.dyte7k5kgkbjh5is@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596848216178927191?=
X-GMAIL-MSGID: =?utf-8?q?1597277124601532339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 08:40:10PM -0700, Alexei Starovoitov wrote:
> On Sun, Apr 08, 2018 at 04:07:42PM +0800, joeyli wrote:
> > 
> > > If the only thing that folks are paranoid about is reading
> > > arbitrary kernel memory with bpf_probe_read() helper
> > > then preferred patch would be to disable it during verification
> > > when in lockdown mode
> > 
> > Sorry for I didn't fully understand your idea...
> > Do you mean that using bpf verifier to filter out bpf program that
> > uses bpf_probe_read()?
> 
> Take a look bpf_get_trace_printk_proto().
> Similarly we can add bpf_get_probe_read_proto() that
> will return NULL if lockdown is on.
> Then programs with bpf_probe_read() will be rejected by the verifier.
> 

OK, I saw check_helper_call(). Thank you for point it out.
it's good idea!

Joey Lee
