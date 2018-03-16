Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521226159; cv=none;
        d=google.com; s=arc-20160816;
        b=tHQuKdX0I7YEwYOCwt1jofrJCS/LBnArxxwouzgjhAHfxQN8G7+P5e1HQKHXE2QAUX
         L8cTyJgjT7kSKKMC0bdFP+3io15Yv/+iMR1foWcjJ/wzOh+hGbenpKQjojXwzWuvzmMI
         2zzBA62Z8vdzTt8YA40pg4mK6hq+QtKHFIW6Dz62j68UJmGhTR3i0r+SGRZMhNcVaBTZ
         rFJjaZDuTwmues5FsIPqXCV91D8W40ABuJpim0h9jy4Pt5cPYn0s++acJ4634tMGQTxv
         ekXoWKEpQW+fKH4qcxlPqO/bCt5IQLtu1dSM8xbdxpErRC4H99y1gJ+UHgS+9/WEaloi
         mHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/LrG5O7Dw1qlgVJUx/uA76tGHpqDO1JmbA71gRHfuSo=;
        b=apib8KfEn+fhNbkTpjkRwzJkaOocbpt6f2eKRaAH3TmixkcaMVgmIbS6JWlA1nyF7C
         f0pCU0o8jndxDQfjIDuqjL0q/VELl3uI8A6oJI8bgGJS5YUqUvCPpUdVdOEurWjIFy3m
         A0mGFrrOaK7vX6nnSEJuqmq/VzIiWzETQzeepIkAmnF4OnuDUT/Rn9JM2a7crghWOi8X
         iowJOZQGekoauipTCYUHVuktraFx0ECbAb/5Rc/J/z/oQAH2ieqd7cwLY6fhfj1yl4nc
         E2+urjGId/ycEl5yhh4jZUXURoDtOESrS/kwH8mrysiP/1WfWFuuhb1psdWRtuPt8VUP
         waIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jN9RgAhF;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jN9RgAhF;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELue4rNRW8O87fnainLnVccT07aeKo4bHCjNQKQE5ORcnrKMER0tvBT5ZQOV0hjz0We6T6zVwc6qjy+TfyE1jSk=
MIME-Version: 1.0
References: <20180316182512.118361-1-wvw@google.com>
In-Reply-To: <20180316182512.118361-1-wvw@google.com>
From: Wei Wang <wvw@google.com>
Date: Fri, 16 Mar 2018 18:49:08 +0000
Message-ID: <CAGXk5yoVMd9B=nvob7s=niCAQ9oHAX84eupF9Eet_dAk7WTStg@mail.gmail.com>
Subject: Re: [PATCH] mm: add config for readahead window
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Todd Poynor <toddpoynor@google.com>,
	Wei Wang <wei.vince.wang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran" <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>, Huang Ying <ying.huang@intel.com>,
	Dennis Zhou <dennisz@fb.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403045c0ebed1714605678c101d"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595121241230204650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f403045c0ebed1714605678c101d
Content-Type: text/plain; charset="UTF-8"

Android devices boot time benefits by bigger readahead window setting from
init. This patch will make readahead window a config so early boot can
benefit by it as well.


On Fri, Mar 16, 2018 at 11:25 AM Wei Wang <wvw@google.com> wrote:

> From: Wei Wang <wvw@google.com>
>
> Change VM_MAX_READAHEAD value from the default 128KB to a configurable
> value. This will allow the readahead window to grow to a maximum size
> bigger than 128KB during boot, which could benefit to sequential read
> throughput and thus boot performance.
>
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  include/linux/mm.h | 2 +-
>  mm/Kconfig         | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad06d42adb1a..d7dc6125833e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2291,7 +2291,7 @@ int __must_check write_one_page(struct page *page);
>  void task_dirty_inc(struct task_struct *tsk);
>
>  /* readahead.c */
> -#define VM_MAX_READAHEAD       128     /* kbytes */
> +#define VM_MAX_READAHEAD       CONFIG_VM_MAX_READAHEAD_KB
>  #define VM_MIN_READAHEAD       16      /* kbytes (includes current page)
> */
>
>  int force_page_cache_readahead(struct address_space *mapping, struct file
> *filp,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c782e8fb7235..da9ff543bdb9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -760,3 +760,11 @@ config GUP_BENCHMARK
>           performance of get_user_pages_fast().
>
>           See tools/testing/selftests/vm/gup_benchmark.c
> +
> +config VM_MAX_READAHEAD_KB
> +       int "Default max readahead window size in Kilobytes"
> +       default 128
> +       help
> +         This sets the VM_MAX_READAHEAD value to allow the readahead
> window
> +         to grow to a maximum size of configured. Increasing this value
> will
> +         benefit sequential read throughput.
> --
> 2.16.2.804.g6dcf76e118-goog
>
>

--f403045c0ebed1714605678c101d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(34,34,34);font-family:sans-serif;=
font-size:13px;font-style:normal;font-variant-ligatures:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:0px;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline">Android devices boot time benefits by b=
igger readahead window setting from init. This patch will make readahead wi=
ndow a config so early boot can benefit by it as well.</span><br></div><br>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Mar 16, 2018 at 11:=
25 AM Wei Wang &lt;<a href=3D"mailto:wvw@google.com">wvw@google.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">From: Wei Wang &lt;<a href=
=3D"mailto:wvw@google.com" target=3D"_blank">wvw@google.com</a>&gt;<br>
<br>
Change VM_MAX_READAHEAD value from the default 128KB to a configurable<br>
value. This will allow the readahead window to grow to a maximum size<br>
bigger than 128KB during boot, which could benefit to sequential read<br>
throughput and thus boot performance.<br>
<br>
Signed-off-by: Wei Wang &lt;<a href=3D"mailto:wvw@google.com" target=3D"_bl=
ank">wvw@google.com</a>&gt;<br>
---<br>
=C2=A0include/linux/mm.h | 2 +-<br>
=C2=A0mm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++++++<br>
=C2=A02 files changed, 9 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/linux/mm.h b/include/linux/mm.h<br>
index ad06d42adb1a..d7dc6125833e 100644<br>
--- a/include/linux/mm.h<br>
+++ b/include/linux/mm.h<br>
@@ -2291,7 +2291,7 @@ int __must_check write_one_page(struct page *page);<b=
r>
=C2=A0void task_dirty_inc(struct task_struct *tsk);<br>
<br>
=C2=A0/* readahead.c */<br>
-#define VM_MAX_READAHEAD=C2=A0 =C2=A0 =C2=A0 =C2=A0128=C2=A0 =C2=A0 =C2=A0=
/* kbytes */<br>
+#define VM_MAX_READAHEAD=C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_VM_MAX_READAHEAD=
_KB<br>
=C2=A0#define VM_MIN_READAHEAD=C2=A0 =C2=A0 =C2=A0 =C2=A016=C2=A0 =C2=A0 =
=C2=A0 /* kbytes (includes current page) */<br>
<br>
=C2=A0int force_page_cache_readahead(struct address_space *mapping, struct =
file *filp,<br>
diff --git a/mm/Kconfig b/mm/Kconfig<br>
index c782e8fb7235..da9ff543bdb9 100644<br>
--- a/mm/Kconfig<br>
+++ b/mm/Kconfig<br>
@@ -760,3 +760,11 @@ config GUP_BENCHMARK<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 performance of get_user_pages_fast().<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 See tools/testing/selftests/vm/gup_bench=
mark.c<br>
+<br>
+config VM_MAX_READAHEAD_KB<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int &quot;Default max readahead window size in =
Kilobytes&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default 128<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This sets the VM_MAX_READAHEAD value to =
allow the readahead window<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to grow to a maximum size of configured.=
 Increasing this value will<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0benefit sequential read throughput.<br>
--<br>
2.16.2.804.g6dcf76e118-goog<br>
<br>
</blockquote></div>

--f403045c0ebed1714605678c101d--
