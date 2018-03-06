Return-Path: <jmorris@namei.org>
X-Google-Smtp-Source: AG47ELuGLBSoexV0bFqg4Rcw/KpfrDUdhpfBmPsGu+htTw7Nv7mhpk0JR736avIlrK5Jk+E/SWgX
ARC-Seal: i=1; a=rsa-sha256; t=1520374221; cv=none;
        d=google.com; s=arc-20160816;
        b=DtP/Hw+1e9kgTw0urwsNCuHGXHsB2HC7F1F7GgDH9lL3klfoF1STfJIvJpa0XrKYbK
         s8mIhT+5AHGF5ZLbg2dvCUCbRbhvUIXfH0oacZvV/cwYiUmf7GyMPkkOmPb10fj+BCcY
         6AWNCUsE0DoIeL/s6Fa8/aCFq7vwGFhO+Udadzu8Kz18Lk0jBsqMlvWS6mKVKqJiGxLa
         eagya0HQYdoJ0ApcptZ4h4/IJG9oF/GiHMuqr5LN1vyg7eM1zkalQbdpJ1KRGa23j7Po
         HvCrq4VRDOVo7trS8MdpdHtqOIGYOMpzZA/rqS65/DEOHVHAr+Aej7TuHpaAIy3LzJ1J
         A/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=QtRJlwZzoi0Zygpq34oma4RJcJhOChir3n7+t9vSv70=;
        b=UdJ3Mozf+NJOXbI5VOzAlfRO3BSVW6Fp5bhVK6DtwxqMBr3bRWNLXfsGBRvD23lRAv
         jhadSEVZ14UDB5hMWFWF6/F349YaJaMtkihasNuR06CzQIlED5UvJQ5k67Lxv9CpbGvi
         11S9FDuo5wS5ZH4Lv+dKfc6xmXxURwURLklKzy4PaJSgRVgUmxH7EcZ7vmCOBohcIT6L
         TpjzgcJYVYmZPAbTAoUVrH+xOEgpk3nTLSBxkvZo+P2UkQG3x7DKzI5YwsrO+rrdqTrp
         eV200ZyBRHMtIn0xZq6K0Cx3njI/wjjDQaTXeuPJFF8F9Q+dr0IUp1JzCl44Pn1JLOne
         z/vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Date: Wed, 7 Mar 2018 09:10:10 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        gregkh@linuxfoundation.org, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] usb,signal,security: only pass the cred, not the secid,
 to kill_pid_info_as_cred and security_task_kill
In-Reply-To: <8b1ea069-2389-5298-c187-647202762d72@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1803070909310.14366@namei.org>
References: <20170908164001.21138-1-sds@tycho.nsa.gov> <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com> <alpine.LRH.2.21.1709090808200.15026@namei.org> <CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
 <8b1ea069-2389-5298-c187-647202762d72@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1577990101774039350?=
X-GMAIL-MSGID: =?utf-8?q?1594227919470172219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 6 Mar 2018, Casey Schaufler wrote:

> On 3/6/2018 11:01 AM, Paul Moore wrote:
> > On Fri, Sep 8, 2017 at 6:09 PM, James Morris <jmorris@namei.org> wrote:
> >> On Fri, 8 Sep 2017, Paul Moore wrote:
> >>> Looks fine to me from a SELinux perspective.  If Casey and John are
> >>> happy with this I can volunteer to pull it into the selinux/next tree
> >>> (once the merge window closes), otherwise if someone else wants to
> >>> merge this my ack is below.
> >> As this impacts multiple LSMs, I'd prefer to take it via my tree.
> > What happened to this James?  As best I can tell there were never any
> > objections, and plenty of ACKs, but I don't see it in Linus' tree.
> > I'll extend my offer to merge it, but I know you expressed a desire to
> > pull this via your tree.
> 
> I was also surprised that it had not been included.
> 
> >
> > * http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003156.html
> >

Oops,

Now applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing




-- 
James Morris
<jmorris@namei.org>
