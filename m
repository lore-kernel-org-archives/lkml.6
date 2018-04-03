Return-Path: <jforbes@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522796903; cv=none;
        d=google.com; s=arc-20160816;
        b=dwnPsMmO2eLh/jzLVU4oTNnxEMHvdec1WA3tDdAzEGnlz0ry5QBitYZjQSVQhH28zX
         ETxZcATSofuJClIN0KF1trN106nV35pjoQuCGNDXj1N7fnPeVsr4ygB7QI0PzJwJykxg
         L5uEM40ERpFGz3UYrCAT68Zsch7koS+aDZWCy8WQxYBzHBzRRm+r/4RWResAm+3mhs4O
         xx00cy0FQRO4RxocV0+N4wiLcMAVooC0a7lD32UW+yBJvJMbqVFvAZTGgV3uZ5e30DVC
         GF7fqZtQJgUtFEBPOmcVGZ2y+qbBgbex8xz3y8qWknb/tFgH7cH3SNAH6jT3lZSvLWWi
         XwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=4e/+XELhlmIKuQWujjGoUykDoS0AYV5waQqSY1mtJwo=;
        b=GAayiRn7oBDMNyYqRiClMeJik7arlZF8Ozf6bdM8N7Msx0VTUv6ojmJSGXlMcWz1tD
         GT2BnnwxolnTHjoCIfJ9anHC5ulGAvaSTc3YIWlDJpB3H6JJNmS9wHxpG+43S34lFUWt
         DgPN5b8/C9OFWQekxvyqrg56rbGRg+kThDw05GtHZ78bnOWY+Uj8gwCo2z0HusXGnPMw
         Ld5c6ui8I/tYI0DBIaWDrQiDwlRqUwT2fdKkm4BncP4IDkR6q+Mt1lR2XwnbZ/DrAv1F
         hn5q9LJ3XkuuP/4EUZbCkSFj+wykRmpw37tJRUR+eRT5U0Jg8R2kmxKhxbl7eIgeTcQM
         9UtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jforbes@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jforbes@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jforbes@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jforbes@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx48IjIzNfOFbv48+MJnREVpCp/edHEPirj30R3NvmKBcOgk6sRaGhJ3i2wODQXKERiYwhHWZepGFSL9mA8OrW1E=
MIME-Version: 1.0
In-Reply-To: <CALCETrXC-mL07YvGrvqaUQrbv+3fv2G9rGuQoMohaxG=QUQn2g@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com> <CALCETrXC-mL07YvGrvqaUQrbv+3fv2G9rGuQoMohaxG=QUQn2g@mail.gmail.com>
From: Justin Forbes <jforbes@redhat.com>
Date: Tue, 3 Apr 2018 18:08:22 -0500
Message-ID: <CAFbkSA3kKmSorNhYfciu2poGHFTcmQGxkL=7pqacFhe2qvCG0A@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@google.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morris <jmorris@namei.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
	joeyli <jlee@suse.com>, LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000007dda100568f9c829"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596768286081310020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000007dda100568f9c829
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 3, 2018 at 5:53 PM, Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, Apr 3, 2018 at 3:51 PM, Matthew Garrett <mjg59@google.com> wrote:
> > On Tue, Apr 3, 2018 at 3:46 PM Linus Torvalds
> > <torvalds@linux-foundation.org>
> > wrote:
> >
> >> For example, I love signed kernel modules. The fact that I love them
> >> has absolutely zero to do with secure boot, though. There is
> >> absolutely no linkage between the two issues: I use (self-)signed
> >> kernel modules simply because I think it's a good thing in general.
> >
> >> The same thing is true of some lockdown patch. Maybe it's a good thing
> >> in general. But whether it's a good thing is _entirely_ independent of
> >> any secure boot issue. I can see using secure boot without it, but I
> >> can very much also see using lockdown without secure boot.
> >
> >> The two things are simply entirely orthogonal. They have _zero_
> >> overlap. I'm not seeing why they'd be linked at all in any way.
> >
> > Lockdown is clearly useful without Secure Boot (and I intend to deploy it
> > that way for various things), but I still don't understand why you feel
> > that the common case of booting a kernel from a boot chain that's widely
> > trusted derives no benefit from it being harder to subvert that kernel
> into
> > subverting that boot chain. For cases where you're self-signing and feel
> > happy about that, you just set CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT to n
> and
> > everyone's happy?
>
> I would like to see distros that want Secure Boot to annoy users by
> enabling Lockdown be honest about the fact that it's an annoyance and
> adds very little value by having to carry a patch that was rejected by
> the upstream kernel.
>
> -Andy
>

They have been carrying those patches for *years* now. If we didn't think
there was value in it, we wouldn't be carrying them.

--0000000000007dda100568f9c829
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 3, 2018 at 5:53 PM, Andy Lutomirski <span dir=3D"ltr">&lt;<=
a href=3D"mailto:luto@kernel.org" target=3D"_blank">luto@kernel.org</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div=
 class=3D"h5">On Tue, Apr 3, 2018 at 3:51 PM, Matthew Garrett &lt;<a href=
=3D"mailto:mjg59@google.com">mjg59@google.com</a>&gt; wrote:<br>
&gt; On Tue, Apr 3, 2018 at 3:46 PM Linus Torvalds<br>
&gt; &lt;<a href=3D"mailto:torvalds@linux-foundation.org">torvalds@linux-fo=
undation.org</a><wbr>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; For example, I love signed kernel modules. The fact that I love th=
em<br>
&gt;&gt; has absolutely zero to do with secure boot, though. There is<br>
&gt;&gt; absolutely no linkage between the two issues: I use (self-)signed<=
br>
&gt;&gt; kernel modules simply because I think it&#39;s a good thing in gen=
eral.<br>
&gt;<br>
&gt;&gt; The same thing is true of some lockdown patch. Maybe it&#39;s a go=
od thing<br>
&gt;&gt; in general. But whether it&#39;s a good thing is _entirely_ indepe=
ndent of<br>
&gt;&gt; any secure boot issue. I can see using secure boot without it, but=
 I<br>
&gt;&gt; can very much also see using lockdown without secure boot.<br>
&gt;<br>
&gt;&gt; The two things are simply entirely orthogonal. They have _zero_<br=
>
&gt;&gt; overlap. I&#39;m not seeing why they&#39;d be linked at all in any=
 way.<br>
&gt;<br>
&gt; Lockdown is clearly useful without Secure Boot (and I intend to deploy=
 it<br>
&gt; that way for various things), but I still don&#39;t understand why you=
 feel<br>
&gt; that the common case of booting a kernel from a boot chain that&#39;s =
widely<br>
&gt; trusted derives no benefit from it being harder to subvert that kernel=
 into<br>
&gt; subverting that boot chain. For cases where you&#39;re self-signing an=
d feel<br>
&gt; happy about that, you just set CONFIG_LOCK_DOWN_IN_EFI_<wbr>SECURE_BOO=
T to n and<br>
&gt; everyone&#39;s happy?<br>
<br>
</div></div>I would like to see distros that want Secure Boot to annoy user=
s by<br>
enabling Lockdown be honest about the fact that it&#39;s an annoyance and<b=
r>
adds very little value by having to carry a patch that was rejected by<br>
the upstream kernel.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Andy<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">They =
have been carrying those patches for *years* now. If we didn&#39;t think th=
ere was value in it, we wouldn&#39;t be carrying them.</div><div class=3D"g=
mail_extra"><br></div></div>

--0000000000007dda100568f9c829--
