Return-Path: <jinqian@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517961372; cv=none;
        d=google.com; s=arc-20160816;
        b=o45Iv0KZn+AdR34RJFy0uwRoeMs+656V3n81PaCdmqwIw7FrdKVMKmsBWgGsdr4cm0
         +F06uqL6A10MrL2zq6hXFoc9SCb3sQw98eR+yRocOy7llIgf4+J3YIdcJkBmFGCmIK31
         v4+175MjYNM4WK3em5f/V7vIzgtyB8i1KvPXSzyvZZfcibIxgfDOrwIIM7TmUnkfprih
         azUqNi9QlYTRogdcFyrVBiyGQXttgh3dYc1hvP8P9/3sDymzrZ5vTKrJZLLzfFmLErB8
         aCRDprtY35mL46ddwsLyVth7LH9SvYSGkCQcFE6RLJQcFTODEBxmGLiE46ec7xNmE7Xr
         VNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1ytKCtqRXIfU87xup8UbvWRfsXHZq9KZF7GHQIvxunc=;
        b=I+l+vXnv/xCQgTjp3mUSXcL220SYPoSM+pOCDiF0jSOTLkdIgyzeeGuO7g4l5LBrC0
         +nytziAkK+IxZ8+9MS5OdZa7qwvubB4HFTHmXoQ0sSSamHLTREpClpK+0EZRY2PvCthK
         whidL4SDgYBUEohWzLyw5NuhSd3nwYTjNkfWUvomw95T15HHP0SSPAwsqvygRxc3AESF
         Rs+QWGiq9lJznrNx3opsuqNVFwIo8JEeA9+rPYYAQQQ42FJ/K5AKWwjkXv0H719BuBko
         staTQCxiFjrtqrN2I9JH8+1rkY7Y9Ng6QamaRHo3TydufcnzMGrcy/PjJB5T5oVlLVqM
         gspQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gifM8gZZ;
       spf=pass (google.com: domain of jinqian@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinqian@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gifM8gZZ;
       spf=pass (google.com: domain of jinqian@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinqian@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x224R/NOEyRySqzk5b39S2/F4q5i9+66nUlgN115DYAYhpfy8ArU6HEVTy5G7/j9opNhBp3GPzlit9AsfXGidZ54=
MIME-Version: 1.0
References: <20180206190938.172792-1-jinqian@android.com> <20180206203953.GC18045@kroah.com>
 <20180206231149.GC1977@thunk.org> <20180206233809.GA159960@gmail.com>
In-Reply-To: <20180206233809.GA159960@gmail.com>
From: Jin Qian <jinqian@google.com>
Date: Tue, 06 Feb 2018 23:56:01 +0000
Message-ID: <CAE3cK=OVoqSNmehRSzNjt892QMv_9vdAafU+k878yKvO2gyY9w@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] ext4: don't put symlink in pagecache into highmem
To: Eric Biggers <ebiggers3@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
	Jin Qian <jinqian@android.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@poochiereds.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403043c3f9c5dc904056493ec27"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591695075456239611?=
X-GMAIL-MSGID: =?utf-8?q?1591697864635200441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f403043c3f9c5dc904056493ec27
Content-Type: text/plain; charset="UTF-8"

Sure, uploaded https://lkml.org/lkml/2018/2/6/856. PTAL.

jin


On Tue, Feb 6, 2018 at 3:38 PM Eric Biggers <ebiggers3@gmail.com> wrote:

> On Tue, Feb 06, 2018 at 06:11:49PM -0500, Theodore Ts'o wrote:
> > On Tue, Feb 06, 2018 at 12:39:53PM -0800, Greg KH wrote:
> > > On Tue, Feb 06, 2018 at 11:09:37AM -0800, Jin Qian wrote:
> > > > From: Jin Qian <jinqian@google.com>
> > > >
> > > > partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174
> upstream
> > > > to v4.4 to prevent virt_to_page on highmem.
> > >
> > > Ted, any objection to this patch?
> >
> > No objections with my ext4 hat on.
> >
> > It should be noted though that this is a partial backport because it
> > only fixes ext4, while Al's original upstream fix addressed a much
> > larger set of file systems.  In the Android kernel the f2fs fix had
> > been backported separately.  But for the upstream kernel, it *might*
> > be the case that we should try backporting the original commit so that
> > in case there is some other general purpose distribution decides (a)
> > to base their system on 4.4, and (b) support a 32-bit kernel, they get
> > the more general bug fixes which applies for btrfs, isofs, ocfs2, nfs,
> > etc.
> >
> > I haevn't been paying attention to what LTS kernels general purpose
> > distro's are using, so I don't know how important this would be.  And
> > if there are companies like Cloudflare which are using upstream LTS
> > kernel, it seems unlikely they would want to use a 32-bit kernel,
> > so.... shrug.  Greg, I'll let you decide if you want to backport the
> > full commit or not.
> >
> > (We had a similar discussion on the AOSP kernel, and came to the
> > conclusion that we only needed to make the patch support ext4.  No one
> > was going to test the other file systems besides ext4 and f2fs,
> > anyway.  But the calculus might be different might be different for
> > the general upstream LTS kernel.)
> >
>
> Well, the main point of backporting this change is to fix symlink
> decryption on
> 32-bit systems.  So, it would be needed on both ext4 and f2fs.  Jin, it
> might be
> a good idea to fix f2fs in this patch at well, since unlike the AOSP
> kernels,
> the LTS kernels do not have the latest f2fs backported to them.
>
> I don't think backporting this change for other filesystems is particularly
> important, since if I understand correctly, the reasons that Al made the
> change
> originally were:
>
> - to allow following symlinks in RCU mode, but that's not implemented in
> old
>   kernels
>
> - to prevent a process from using up all kmaps and deadlocking the system,
> which
>   I'm not sure is a real problem (someone would need to try to put
> together a
>   reproducer), but if so it would probably just be a local device of
> service.
>
> Also if we actually backported the full commit there are follow-on fixes
> such as
> e8ecde25f5e that would be needed as well but might be missed.
>
> Thanks,
>
> - Eric
>

--f403043c3f9c5dc904056493ec27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sure, uploaded <a href=3D"https://lkml.org/lkml/2018/2/6/8=
56">https://lkml.org/lkml/2018/2/6/856</a>. PTAL.<div><br></div><div>jin<br=
><div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Feb=
 6, 2018 at 3:38 PM Eric Biggers &lt;<a href=3D"mailto:ebiggers3@gmail.com"=
>ebiggers3@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On Tue, Feb 06, 2018 at 06:11:49PM -0500, Theodore Ts&#39;o wrote:<br>
&gt; On Tue, Feb 06, 2018 at 12:39:53PM -0800, Greg KH wrote:<br>
&gt; &gt; On Tue, Feb 06, 2018 at 11:09:37AM -0800, Jin Qian wrote:<br>
&gt; &gt; &gt; From: Jin Qian &lt;<a href=3D"mailto:jinqian@google.com" tar=
get=3D"_blank">jinqian@google.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d1=
74 upstream<br>
&gt; &gt; &gt; to v4.4 to prevent virt_to_page on highmem.<br>
&gt; &gt;<br>
&gt; &gt; Ted, any objection to this patch?<br>
&gt;<br>
&gt; No objections with my ext4 hat on.<br>
&gt;<br>
&gt; It should be noted though that this is a partial backport because it<b=
r>
&gt; only fixes ext4, while Al&#39;s original upstream fix addressed a much=
<br>
&gt; larger set of file systems.=C2=A0 In the Android kernel the f2fs fix h=
ad<br>
&gt; been backported separately.=C2=A0 But for the upstream kernel, it *mig=
ht*<br>
&gt; be the case that we should try backporting the original commit so that=
<br>
&gt; in case there is some other general purpose distribution decides (a)<b=
r>
&gt; to base their system on 4.4, and (b) support a 32-bit kernel, they get=
<br>
&gt; the more general bug fixes which applies for btrfs, isofs, ocfs2, nfs,=
<br>
&gt; etc.<br>
&gt;<br>
&gt; I haevn&#39;t been paying attention to what LTS kernels general purpos=
e<br>
&gt; distro&#39;s are using, so I don&#39;t know how important this would b=
e.=C2=A0 And<br>
&gt; if there are companies like Cloudflare which are using upstream LTS<br=
>
&gt; kernel, it seems unlikely they would want to use a 32-bit kernel,<br>
&gt; so.... shrug.=C2=A0 Greg, I&#39;ll let you decide if you want to backp=
ort the<br>
&gt; full commit or not.<br>
&gt;<br>
&gt; (We had a similar discussion on the AOSP kernel, and came to the<br>
&gt; conclusion that we only needed to make the patch support ext4.=C2=A0 N=
o one<br>
&gt; was going to test the other file systems besides ext4 and f2fs,<br>
&gt; anyway.=C2=A0 But the calculus might be different might be different f=
or<br>
&gt; the general upstream LTS kernel.)<br>
&gt;<br>
<br>
Well, the main point of backporting this change is to fix symlink decryptio=
n on<br>
32-bit systems.=C2=A0 So, it would be needed on both ext4 and f2fs.=C2=A0 J=
in, it might be<br>
a good idea to fix f2fs in this patch at well, since unlike the AOSP kernel=
s,<br>
the LTS kernels do not have the latest f2fs backported to them.<br>
<br>
I don&#39;t think backporting this change for other filesystems is particul=
arly<br>
important, since if I understand correctly, the reasons that Al made the ch=
ange<br>
originally were:<br>
<br>
- to allow following symlinks in RCU mode, but that&#39;s not implemented i=
n old<br>
=C2=A0 kernels<br>
<br>
- to prevent a process from using up all kmaps and deadlocking the system, =
which<br>
=C2=A0 I&#39;m not sure is a real problem (someone would need to try to put=
 together a<br>
=C2=A0 reproducer), but if so it would probably just be a local device of s=
ervice.<br>
<br>
Also if we actually backported the full commit there are follow-on fixes su=
ch as<br>
e8ecde25f5e that would be needed as well but might be missed.<br>
<br>
Thanks,<br>
<br>
- Eric<br>
</blockquote></div></div></div>

--f403043c3f9c5dc904056493ec27--
