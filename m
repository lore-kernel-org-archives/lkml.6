Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELutxSGtOxmLHAJRCfadC44CT0Qj9KIb3dnvbIpySiQzQgA9dKsv0WHAG3Zy61qGZxqEU4Wv
ARC-Seal: i=1; a=rsa-sha256; t=1521752055; cv=none;
        d=google.com; s=arc-20160816;
        b=GIu6lyiJlf7s0+x7bjmrhiw0jYaGOWqEMX+DHLsIXK9VFOHdcwVt3xhfr7sPtV5iHq
         +1reTiFdvHHlfJ2sufXy8u3HwqV3SiOtmxMwLA+GXj+lXIThw8zEEho+DI7bGwd+0x02
         Gruab8+XRa2Vn2Vpn+mcfYggrgv0ueF9yximOhVq3FWd5+2U2sxpA8r95lFynzM03KJ/
         Z6J58uQiCZ4jGVLEBA4JvidRh8Xpj697dTYiemKDIs+7ab5YJulMfgZMGBWGrXYQwD5e
         J/1U253vwjd+yp31h0DSnWnAkVXPPjlwbK81IjckrGDvTEUqSyhYxpjLm/5ivbEOi9YF
         QNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=R0YMys0B/70EEHMOv1r0m6QqAP7/SFtjc/K4RIs0DmM=;
        b=Xan+Wl+mIRj54nyDOp7fVH2l2Gs/XAqmO6pdIq7FNIgaxZr36JREedkSj2jPXtJla7
         BzFfMXOehWQ8hArF7/LzVz8KR/TJp0IIrMDJnZGk9CJK4JQ3te5hjlgcoOPCwjsdM5/S
         QWJMCUGf+8n0L59V8aCprj0JkVQP4srIMVWA1rQ7sPrcyQ6S7SKMURbCOYEqiK8Tul0R
         qJ/llCaixeotYaRmOWVrWbRjzUIXXbQUt9yXQeZXGeweo4NJC8++5eXCakLTplwrjt2A
         YyVhA1frQmVmGimRYS4td4gK0KBEsvDh1cGWi89Q73kri5C+Zi/tZ+8FDpWCWyFWnF+J
         EXIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Thu, 22 Mar 2018 20:54:13 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <ast@fb.com>
Cc: Jessica Yu <jeyu@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Djalal Harouni <tixxdz@gmail.com>,
	David Miller <davem@davemloft.net>,
	Andy Lutomirski <luto@amacapital.net>,
	Kees Cook <keescook@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@fb.com>,
	Linux API <linux-api@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Hannes Reinecke <hare@suse.com>,
	werner@suse.com
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180322205413.GA30543@wotan.suse.de>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
 <20180310140843.GP4449@wotan.suse.de>
 <20180310151652.GV4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310151652.GV4449@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1595672683296325233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 03:16:52PM +0000, Luis R. Rodriguez wrote:
> On Sat, Mar 10, 2018 at 02:08:43PM +0000, Luis R. Rodriguez wrote:
> > The alternative to this would be a simple equivalent of try_then_request_module()
> > for UMH modules: try_umhm_then_request_umh_module() or whatever. So just as I
> > argued earlier over UMH limitations, this is not the end of the world for umh
> > modules, and it doesn't mean you can't get *properly* add umh modules upstream,
> > it would *just mean* we'd be perpetuating today's (IMHO) horrible and loose
> > semantics.
> 
> I was about to suggest that perhaps a try_umhm_then_request_umh_module() or
> whatever should not be a macro -- but instead an actual routine, and we don't
> export say the simple form to avoid non-deterministic uses of it from the
> start... but the thing is *it'd have to be a macro* given that the *check* for
> the module *has to be loose*, just as try_then_request_module()...
> 
> *Ugh* gross.
> 
> Another reason for me to want an actual deterministic clean proper solution
> from the start.

I just thought of another consideration which should be made here for the long
term.

Some init systems have a timeout for kmod workers, that is the userspace
process which issues the modprobe call.

That was very well intentioned, however it ended up being nonsense, so at least
on SLE systemd we disable the timeout for kmod workers.  What others do... is
unclear to me.  Upstream wise the timeout was increased considerably, however,
*if* such timeout is in effect for users it has some implicit implications on
the number of devices a driver could support:

number_devices =          systemd_timeout                                       
                  -------------------------------------                         
                      max known probe time for driver  

I've documented the logic to these conclusions [0].

It sounds like we *do* want a full sync wait mechanism, and as I noted I think
we should fix the determinism aspect of it. Since no aliases will be supported
for usermode modules this will be much easier to support, and I can volunteer
to help with that.

However given the above... if we're going to use request_module() API (or a
really fixed deterministic version of it later) for usermode kernel modules,
the limitation above still applies.

Are these usermode modules doing all the handy work on init? Or can it be
deferred once loaded? How much loading on init should a usermode module need?

If we can ensure that these usermode modules don't take *any time at all* on
their init *from the start*, it would be wonderful and we'd end up avoiding
some really odd corner case issues later.

[0] http://www.do-not-panic.com/2015/12/linux-asynchronous-probe.html

  Luis
