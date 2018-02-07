Return-Path: <jinqian@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518038709; cv=none;
        d=google.com; s=arc-20160816;
        b=ofO+Lu7Sbciq9LxU8kDJ5pmhzExjeXW4lGWrhK2S3GiQVogbnCtYDEr0POizdXRs4U
         +nfXNVasLyHF73zIJWZswHza9inQhJ4xMHeMEThjBuwvE+axE+lztLHLXS0zcymNXY5k
         nmgL5ceK9UFYuTW6oJcFCPyTpebbj4rdEpM39BgXHWS0cGg+6Qr95bn6+s6dR+dCYPEB
         3oELgSMFjMhV2wBqYrBO+CDylECLNqPl9+vnSm3TQ3H/4RCrX1vwsxPgOYr1/4XccMkO
         88bA/MOAGdHksgCITQQ+fhgbDX5LG9m2ZlBgozqxX9kJsD9+9XnrL5rzXg1sttcghRi8
         7eRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wAhdHN+nDM6CTrXZRlcz3dyI0UM1bbFDxm1M1KbdGdg=;
        b=yiuMR6HLbfj0WQfukT9z2jAeQpIkJywYLxmDjNg3oLrrsZ3kCGfOrQqe2Z0wW4g9zG
         lVS15hnuwQ1Xy6oK1N7ItIfpgM5PJVLEBL3UNjFMCSrSaw+elj3zUiH3dyA4dr1SCDCJ
         ll7OmzhHGyj3tVSu2lLJ6SOFdFOL+cetYPSsGLxEhidYI1R+3RKRmhzrP7ox4h0Aneui
         GY+RYrb2e+b0qqOHtlxuhT1OebZuimj1O70MCxeqqqMrlnGRc3CdSR09F3xr/3D9l6z5
         sXW4Ev4hkF98zZTPG1r6z/AcoUcWBelEBumjvLigdaALUqil7kwafNSx1VPhClA/Lpor
         4ZRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=IujEi/yq;
       spf=pass (google.com: domain of jinqian@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinqian@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=IujEi/yq;
       spf=pass (google.com: domain of jinqian@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinqian@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x224QLqLHH2IFUnq+hinoIqsPX0rHA8jQr3nnrx6L43Bzxg9BFGylr+HKuqYawVJAiE2Tg1x9/bikvtL7FQ6568U=
MIME-Version: 1.0
References: <20180206235354.79591-1-jinqian@android.com> <20180207200604.GB15309@kroah.com>
In-Reply-To: <20180207200604.GB15309@kroah.com>
From: Jin Qian <jinqian@google.com>
Date: Wed, 07 Feb 2018 21:24:57 +0000
Message-ID: <CAE3cK=Puf-hqXiMdQGRZf_VQ0O0mGXQjAJZtGBYoFPSPUjsdKQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] ext4/f2fs: don't put symlink in pagecache into highmem
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jin Qian <jinqian@android.com>, "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@poochiereds.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-stable <stable@vger.kernel.org>
Content-Type: multipart/alternative; boundary="001a113ad4aaf701ac0564a5edff"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591778957140204202?=
X-GMAIL-MSGID: =?utf-8?q?1591778957140204202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113ad4aaf701ac0564a5edff
Content-Type: text/plain; charset="UTF-8"

It must be some weird gerrit stuff when I cherry-pick from linux to aosp to
linux. Will keep a note for future uploads.

Thanks,
jin

On Wed, Feb 7, 2018 at 1:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:

> Some minor nits for when you send your next patch for stable:
>
> On Tue, Feb 06, 2018 at 03:53:53PM -0800, Jin Qian wrote:
> > From: Jin Qian <jinqian@google.com>
>
> The original patch was written by Al Viro, please do not take the
> original authorship off, that's not good.
>
> > partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream
> > to v4.4 to prevent virt_to_page on highmem.
> >
> > ext4_encrypted_follow_link uses kmap() for cpage
> >   caddr = kmap(cpage);
> >
> > _ext4_fname_disk_to_usr calls virt_to_page on the kmapped address.
> >   _ext4_fname_disk_to_usr()
> >     ext4_fname_decrypt()
> >       sg_init_one()
> >         sg_init_one(&src_sg, iname->name, iname->len);
> >           sg_set_page(sg, virt_to_page(buf), buflen,
> offset_in_page(buf));
> >
> > Cc: linux-stable <stable@vger.kernel.org> # 4.4.y
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jin Qian <jinqian@google.com>
> > Signed-off-by: Jin Qian <jinqian@android.com>
>
> Why did you sign off on this twice?
>
> thanks,
>
> greg k-h
>

--001a113ad4aaf701ac0564a5edff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It must be some weird gerrit stuff when I cherry-pick from=
 linux to aosp to linux. Will keep a note for future uploads.<div><br></div=
><div>Thanks,</div><div>jin<br><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Wed, Feb 7, 2018 at 1:18 PM Greg KH &lt;<a href=3D"mailto:gregk=
h@linuxfoundation.org" target=3D"_blank">gregkh@linuxfoundation.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Some minor nits for when yo=
u send your next patch for stable:<br>
<br>
On Tue, Feb 06, 2018 at 03:53:53PM -0800, Jin Qian wrote:<br>
&gt; From: Jin Qian &lt;<a href=3D"mailto:jinqian@google.com" target=3D"_bl=
ank">jinqian@google.com</a>&gt;<br>
<br>
The original patch was written by Al Viro, please do not take the<br>
original authorship off, that&#39;s not good.<br>
<br>
&gt; partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174 upstrea=
m<br>
&gt; to v4.4 to prevent virt_to_page on highmem.<br>
&gt;<br>
&gt; ext4_encrypted_follow_link uses kmap() for cpage<br>
&gt;=C2=A0 =C2=A0caddr =3D kmap(cpage);<br>
&gt;<br>
&gt; _ext4_fname_disk_to_usr calls virt_to_page on the kmapped address.<br>
&gt;=C2=A0 =C2=A0_ext4_fname_disk_to_usr()<br>
&gt;=C2=A0 =C2=A0 =C2=A0ext4_fname_decrypt()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sg_init_one()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_init_one(&amp;src_sg, iname-&gt;na=
me, iname-&gt;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_set_page(sg, virt_to_page(b=
uf), buflen, offset_in_page(buf));<br>
&gt;<br>
&gt; Cc: linux-stable &lt;<a href=3D"mailto:stable@vger.kernel.org" target=
=3D"_blank">stable@vger.kernel.org</a>&gt; # 4.4.y<br>
&gt; Signed-off-by: Al Viro &lt;<a href=3D"mailto:viro@zeniv.linux.org.uk" =
target=3D"_blank">viro@zeniv.linux.org.uk</a>&gt;<br>
&gt; Signed-off-by: Jin Qian &lt;<a href=3D"mailto:jinqian@google.com" targ=
et=3D"_blank">jinqian@google.com</a>&gt;<br>
&gt; Signed-off-by: Jin Qian &lt;<a href=3D"mailto:jinqian@android.com" tar=
get=3D"_blank">jinqian@android.com</a>&gt;<br>
<br>
Why did you sign off on this twice?<br>
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div></div></div>

--001a113ad4aaf701ac0564a5edff--
