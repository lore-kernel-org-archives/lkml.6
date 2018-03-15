Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610166-1521130554-2-14232555279059802755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521130554; b=p6aSeNrUE33ypiXA4xzcRDdTweo5UHdfYj2uRdtQM3shSSl
    ZmeyhL8iOm8Kwnizx8XcqHrheXTygAMCnUOwO+wIGHxFVbsHsATCul+CO0F5+FdU
    5+ctOYTiMxilt/rxUH5JEbqhuv8c5DeWhVskuiB4BEOCyC0WhTQjMMJDrVNvnk+6
    smVgjLSU2z6BV4yLAz41J61L9qBE6wo9RKnQYV91SvA3C+O4Fj2rMHnRcmwyZfPh
    g/vaqdiEYKxdiIZ/9twccp8lRnwGmMnH6vKISto6evJjN2RV7SJDCbl6e59D577T
    Ni56fwWPjnqTT60lYOMkvWqSxjbhpQdF9Ozkf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521130554; bh=u8vuSCYsykQje5b40iGF2Ap38HHJskE2Y8eHjAcWGxQ=; b=v
    DVQcVss+brrXf0GRz+ZoRLb7IY0vfyBdiZ0LrojQytLB2ZPYUaB1QaICYkeYBK5a
    67zNorvBjC1QiPCX1wUbrdE+R5jSK88NR5M00RLkHSYkq7dosG7EFy+s0Si3H3df
    IG0dfKvygM/LiWDS4QrR0vlccwLVUCuR70gqMODFpJRkKPY3FJsPrvdkj08LCiUp
    icWjmfG6syRGI0lDE1/DW2AdDcdg3sgX+qqM7WMDu4E6SCifgU/mQ7caNwuhCYNw
    nWEmEGpk6ScPWSzw1J6oclQk9xUxBcJ1/WjOOQSlKUo8uYIIyFlLGqJQmh/fl2j1
    86pAiEcjfQa85lUCEVo2w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kOynXttW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JzYPDlq5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kOynXttW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JzYPDlq5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeCOQPw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 12:15:52 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44963 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeCOQPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Mar 2018 12:15:51 -0400
X-Google-Smtp-Source: AG47ELs4SatO8VtqmT3ULw44f16a9JWmJFBVdXbBopafq8HJtLq5zgaLkSMl9kXirocG7hS4zHFundMZuAXAM+3Durs=
MIME-Version: 1.0
References: <20180315014817.142930-1-djkurtz@chromium.org> <398eebd9-9ec9-50ef-88ea-c3d5ae9f5d90@infradead.org>
In-Reply-To: <398eebd9-9ec9-50ef-88ea-c3d5ae9f5d90@infradead.org>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 15 Mar 2018 16:15:38 +0000
Message-ID: <CAGS+omDTVWoLGiOrMUFDOtjPDfK4gs+OiPAB6TJGoM+en7NtNw@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Fix __earlycon_table stride... again
To: Randy Dunlap <rdunlap@infradead.org>
Cc: peter@hurleysoftware.com, Rob Herring <robh@kernel.org>,
        adurbin@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        jslaby@suse.com, Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ccpol: medium
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 8:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> On 03/14/2018 06:48 PM, Daniel Kurtz wrote:
> > Commit 470ca0de69fe ("serial: earlycon: Enable earlycon without command
> > line param") added EARLYCON_TABLE().
> >
> > Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") reference=
d
> > commit 07fca0e57fca92 ("tracing: Properly align linker defined symbols"=
)
> > and tried to fix EARLYCON_TABLE() using __aligned(32).
> >
> > However, the fix copied just works around compiler behavior.  In fact,
it
> > was subsequently re-implemented for tracing using a table of pointers i=
n
> > commit 3d56e331b653 ("tracing: Replace syscall_meta_data struct array
with
> > pointer array"), commit 654986462939 ("tracepoints: Fix section
alignment
> > using pointer array") and commit e4a9ea5ee7c8 ("tracing: Replace
> > trace_event struct array with pointer array").
> >
> > Let's do the same "array of pointers to structs" approach for
> > EARLYCON_TABLE.

> Please describe what the problem is instead of just what the fix is.
> Thanks.

The problem is the same as in 99492c39f39f; the __earlycon_table stride may
be wrong depending on how the compiler decides to align the contents of
__earlycon_table.
See the other referenced patches for a detailed description of the problem
and its solution.

-Dan


> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> > Changes since v1:
> >  * Change __earlycon_table to an array of pointers.
> >
> > Note: I do not have a convenient system to test the of/fdt.c part of
this
> > patch, so would apreciate help verifying it.  Thanks!
> >
> >  drivers/of/fdt.c                  |  7 +++++--
> >  drivers/tty/serial/earlycon.c     |  6 ++++--
> >  include/asm-generic/vmlinux.lds.h |  2 +-
> >  include/linux/serial_core.h       | 21 ++++++++++++++-------
> >  4 files changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 84aa9d676375..6da20b9688f7 100644=EF=BF=BC
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -942,7 +942,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
> >       int offset;
> >       const char *p, *q, *options =3D NULL;
> >       int l;
> > -     const struct earlycon_id *match;
> > +     const struct earlycon_id **p_match;
> >       const void *fdt =3D initial_boot_params;
> >
> >       offset =3D fdt_path_offset(fdt, "/chosen");
> > @@ -969,7 +969,10 @@ int __init early_init_dt_scan_chosen_stdout(void)
> >               return 0;
> >       }
> >
> > -     for (match =3D __earlycon_table; match < __earlycon_table_end;
match++) {
> > +     for (p_match =3D __earlycon_table; p_match < __earlycon_table_end=
;
> > +          p_match++) {
> > +             const struct earlycon_id *match =3D *p_match;
> > +
> >               if (!match->compatible[0])
> >                       continue;
> >
> > diff --git a/drivers/tty/serial/earlycon.c
b/drivers/tty/serial/earlycon.c
> > index a24278380fec..22683393a0f2 100644
> > --- a/drivers/tty/serial/earlycon.c
> > +++ b/drivers/tty/serial/earlycon.c
> > @@ -169,7 +169,7 @@ static int __init register_earlycon(char *buf,
const struct earlycon_id *match)
> >   */
> >  int __init setup_earlycon(char *buf)
> >  {
> > -     const struct earlycon_id *match;
> > +     const struct earlycon_id **p_match;
> >
> >       if (!buf || !buf[0])
> >               return -EINVAL;
> > @@ -177,7 +177,9 @@ int __init setup_earlycon(char *buf)
> >       if (early_con.flags & CON_ENABLED)
> >               return -EALREADY;
> >
> > -     for (match =3D __earlycon_table; match < __earlycon_table_end;
match++) {
> > +     for (p_match =3D __earlycon_table; p_match < __earlycon_table_end=
;
> > +          p_match++) {
> > +             const struct earlycon_id *match =3D *p_match;
> >               size_t len =3D strlen(match->name);
> >
> >               if (strncmp(buf, match->name, len))
> > diff --git a/include/asm-generic/vmlinux.lds.h
b/include/asm-generic/vmlinux.lds.h
> > index 1ab0e520d6fc..e17de55c2542 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -179,7 +179,7 @@
> >  #endif
> >
> >  #ifdef CONFIG_SERIAL_EARLYCON
> > -#define EARLYCON_TABLE() STRUCT_ALIGN();                     \
> > +#define EARLYCON_TABLE() . =3D ALIGN(8);                              =
 \
> >                        VMLINUX_SYMBOL(__earlycon_table) =3D .;  \
> >                        KEEP(*(__earlycon_table))              \
> >                        VMLINUX_SYMBOL(__earlycon_table_end) =3D .;
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index b32df49a3bd5..93b7add47087 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -351,10 +351,10 @@ struct earlycon_id {
> >       char    name[16];
> >       char    compatible[128];
> >       int     (*setup)(struct earlycon_device *, const char *options);
> > -} __aligned(32);
> > +};
> >
> > -extern const struct earlycon_id __earlycon_table[];
> > -extern const struct earlycon_id __earlycon_table_end[];
> > +extern const struct earlycon_id *__earlycon_table[];
> > +extern const struct earlycon_id *__earlycon_table_end[];
> >
> >  #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
> >  #define EARLYCON_USED_OR_UNUSED      __used
> > @@ -362,12 +362,19 @@ extern const struct earlycon_id
__earlycon_table_end[];
> >  #define EARLYCON_USED_OR_UNUSED      __maybe_unused
> >  #endif
> >
> > -#define OF_EARLYCON_DECLARE(_name, compat, fn)
       \
> > -     static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name) \
> > -          EARLYCON_USED_OR_UNUSED __section(__earlycon_table)        \
> > +#define _OF_EARLYCON_DECLARE(_name, compat, fn, unique_id)           \
> > +     static const struct earlycon_id unique_id                       \
> > +          EARLYCON_USED_OR_UNUSED __initdata                         \
> >               =3D { .name =3D __stringify(_name),                      =
   \
> >                   .compatible =3D compat,                              =
 \
> > -                 .setup =3D fn  }
> > +                 .setup =3D fn  };                                    =
 \
> > +     static const struct earlycon_id EARLYCON_USED_OR_UNUSED         \
> > +             __section(__earlycon_table)                             \
> > +             * const __PASTE(__p, unique_id) =3D &unique_id
> > +
> > +#define OF_EARLYCON_DECLARE(_name, compat, fn)
       \
> > +     _OF_EARLYCON_DECLARE(_name, compat, fn,                         \
> > +                          __UNIQUE_ID(__earlycon_##_name))
> >
> >  #define EARLYCON_DECLARE(_name, fn)  OF_EARLYCON_DECLARE(_name, "", fn=
)
> >
> >


> --
> ~Randy
