Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELuERKO/9LdiUfj957UPVwWTg9cVjgrb9UJa0oai09Ny/q6vupnm4ZPsVCBuKbPfP1vVahpE
ARC-Seal: i=1; a=rsa-sha256; t=1520278822; cv=none;
        d=google.com; s=arc-20160816;
        b=M7rx2qC2/zeI1WQmeCy4o0TT5kpXvluIQIK6V/C+kwStZR7AgcLhzRR9RlC7UloVpI
         l60mEnDsf/O20AtpuVJN7gx5e3+e3y+DxEPF87nKSw9MQrltDmhdw0nXWCZVI3RihTg1
         NiDDUDctp32j4Mjr6AjdeGcGlG/SffOT0W8U2XT26cPy2gKwRTiokJlVWk1YXyfjY/su
         enDtcPRpt+8iI74u32v4b9xK6fNpjS5OHOCwofFNb7FK1bjEwX7EBXvPCOMn34dM+HkY
         9VNDU12AP6KAxp7c3pV9O/lmCEWbm44N/m/Y6546tqO+9NRkuumotUaW8mCzI9wHKOvZ
         GQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=2RySOwNPl6wrRecuvGdF0snMp7d0x5kFwoOuLCdsNMo=;
        b=Ii/3zp59TqfNlnTKCOpl6D46IU5xP1+AItvdXRJehrMVl0FviyZ8YGp17b8fm0vfZQ
         BVliEDaZHPxltlo14TnQyLB6jxxUT2q7N9vUNS/kTmGYNfoKDTkl1OzjVsOz+bkEz4PV
         nW47uYEiaE0BwleySVIEK+DXYkaBPNgU8vPd/+ilR6qHWorNMimKnZ/piz/YjJGmF/KJ
         NCrIzgEBDhYmuVi56e3+e/4ZoPcmdoiuqJH7tzxVnIYV4VPnwpv60ZpYkX3i5IwzecXS
         qp5IWXzqyPHU7+CE+19XVu4gTC+fwD94/FD1kDwv2+739lTjx0OudSf6xrn8QkJ611wz
         W3Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32582706"
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in
 syscall_trace_enter()
To: Alexander Popov <alex.popov@linux.com>,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin"
 <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Garnier <thgarnie@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Juergen Gross <jgross@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
Date: Mon, 5 Mar 2018 11:40:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520107232-14111-5-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594127886787842388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/03/2018 12:00 PM, Alexander Popov wrote:
> @@ -128,6 +134,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
>  
>  	do_audit_syscall_entry(regs, arch);
>  
> +	erase_kstack();
>  	return ret ?: regs->orig_ax;
>  }

This seems like an odd place to be clearing the stack.  Why was it done her?
