Return-Path: <wei.vince.wang@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521237119; cv=none;
        d=google.com; s=arc-20160816;
        b=lqSorHWleRif6X+RitD8nh4hm71fL09U/+5HOQzDwBO5hc228GIEXpZ1SelAFRi7jq
         u+zgL3KVYXORDIbqieuafJypjfSIaeO52i2tL0aeGeLKzs26Lue/PGvsdFqZkTObStR9
         Zw7NtCuh7exzeNqUyPJsycnsQnfibMMCrw8cQsF/6YaIF5aQ0IEGC0wcmL7+bg723jNv
         0jPAyy3upY1cgbj/3qGdTiRbDqt7TBxXpn5/eb4qlOt6WNSmuauCeqZ+apTXxH5jxIDf
         lKKJYBJWwgCa6xf8e4IBFBjeOITdbNDO2x5B8ufMZwhSTSmzikBakjZOkj7cpdAvBepH
         pGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fm/Ha5R5tqo3Jg54nVSb4+/osJ7GSWSI+gWNgaYtfCk=;
        b=hQ5ngB/djGMXtAQPkrOusXbPzoXJ7mTf1r0FlVPtOJDn7wrRGNd7lBNdXQ/iHVFRg4
         ZRAhcFRleWluZxJ9tdGVtOhED4NvA6zpKwp7qdzIowtGGreqph+UHNEdj78RjT7MGufm
         HnSHbFj6pJ7tPSmfApsBx9VWj/jzXjWxaGFtErv65cwrHaFZhqjFls/G6ljRf8wdJW7O
         BuBi+J9G7G9eiZZUUiRgCrW0mOYnInJt32CdUtPot+WGdOcTmqrDBInMqRozO/2xpYw2
         Iac5chldkWuPHdkH26i1K45ay4nPnT3NqN++Ld/VG5SIL2oMXHDi8Mea1eL9oAnEZalj
         tQeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KSrrFiiw;
       spf=pass (google.com: domain of wei.vince.wang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wei.vince.wang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KSrrFiiw;
       spf=pass (google.com: domain of wei.vince.wang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wei.vince.wang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELukfKMQkzWDAh2cmBg0grf05PrALbTE3AbTqCvhzdQAFs814ZR7rZWv1LCVJZhmRW7Kx87LncB+YD+/F06k3aA=
MIME-Version: 1.0
References: <20180316182512.118361-1-wvw@google.com> <20180316143306.dd98055a170497e9535cc176@linux-foundation.org>
In-Reply-To: <20180316143306.dd98055a170497e9535cc176@linux-foundation.org>
From: Wei Wang <wei.vince.wang@gmail.com>
Date: Fri, 16 Mar 2018 21:51:48 +0000
Message-ID: <CAMFybE7EKyJMmR=Ntn1UX1ZMWJ=32v9G_kYdXh4LhinDv_JO8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: add config for readahead window
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Wang <wvw@google.com>, gregkh@linuxfoundation.org,
	Todd Poynor <toddpoynor@google.com>, Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran" <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>, Huang Ying <ying.huang@intel.com>,
	Dennis Zhou <dennisz@fb.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c04e5521a064805678e9eb6"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595132733972310181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c04e5521a064805678e9eb6
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 16, 2018, 14:33 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Mar 2018 11:25:08 -0700 Wei Wang <wvw@google.com> wrote:
>
> > Change VM_MAX_READAHEAD value from the default 128KB to a configurable
> > value. This will allow the readahead window to grow to a maximum size
> > bigger than 128KB during boot, which could benefit to sequential read
> > throughput and thus boot performance.
>
> You can presently run ioctl(BLKRASET) against the block device?
>

Yeah we are doing tuning in userland after init. But this is something we
thought could help in very early stage.

>

--94eb2c04e5521a064805678e9eb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Fri, Mar 16, 2018, 14:33 Andrew Morton &lt;<a href=3D"mailto:akpm@linux-=
foundation.org">akpm@linux-foundation.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Fri, 16 Mar 2018 11:25:08 -0700 Wei Wang &lt;<a hr=
ef=3D"mailto:wvw@google.com" target=3D"_blank" rel=3D"noreferrer">wvw@googl=
e.com</a>&gt; wrote:<br>
<br>
&gt; Change VM_MAX_READAHEAD value from the default 128KB to a configurable=
<br>
&gt; value. This will allow the readahead window to grow to a maximum size<=
br>
&gt; bigger than 128KB during boot, which could benefit to sequential read<=
br>
&gt; throughput and thus boot performance.<br>
<br>
You can presently run ioctl(BLKRASET) against the block device?<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah we are =
doing tuning in userland after init. But this is something we thought could=
 help in very early stage.</div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--94eb2c04e5521a064805678e9eb6--
