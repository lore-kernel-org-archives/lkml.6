Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtAgAdllOihi/tBLDX4nBveVia/Rtwkx43BydXtb0ZikR5tP4gi1AnmaBY85ulxSGKSMMTC
ARC-Seal: i=1; a=rsa-sha256; t=1521195251; cv=none;
        d=google.com; s=arc-20160816;
        b=Uhdi7C1kpeZMTwfjxhTbr7Vp9JS+HjvyWVpuoKUOkhRnI/0xmFT8q2QvZCm28twDJY
         T+6XP9MDn2D8yl3qitQr95PH71ZhIl4YMYx3xsRNlIT5JR0DDefKQFnb7e92RfbYODpI
         nE4YUwNI9kjUDsGaS3ho0VSzTorS5kwXUu1JSoQtL+lG1NjQ3eoT5b747E3CaDUDPeUc
         ubLZj3eGNS+/5UK30IMR/luUg7MYfPJJSciFIzzWP0yXkK5IFhikWGIPLbUTHmT6oOH0
         6Zen1fqlF+x6WObkTqCfy3IhpZJG7e4UzsYXG/uqEoo/d8r8JaxB+J2ePco7qpQ8s4gu
         x1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=ESUA1eZoRpwRRPMLtx6WG/S93YJOPf6hi++m69HNHeY=;
        b=t99/44tFMzz29D8gSZ7KoTIAc06YxYQaPRHmm8Y8CbXT/firR45LFryws/iMZ0IJFC
         P5gdJreYv/hdh+tr9wmpL2cerZCD6MCF4Ek92bzclKairr8EFn2m+gUeJlvEDqRFcUHH
         sjmEUe5imk0EvZMfOopTsDgG0H2ATBZ7I1eYpe1Z6CL/v7t5Yb+FMRtsjyVoXPG5Kx8V
         sFhxx6yFQu2+AlIHjIzHwcGdmn1TpUr8WpcFqs3B0+CiW3UaiN/4Rmtuy47zyxGF3PJk
         lwmfb9CmIbQEbSFms28HpMZjXmcABi5IWkuWMEmR92rXPKgVV5oDi3LK9TY9EozMhuov
         2XAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ungQnyHs;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ungQnyHs;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeCPKOL (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 06:14:11 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33607 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeCPKOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 06:14:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180308134845.32409-1-anders.roxell@linaro.org>
References: <20180308134845.32409-1-anders.roxell@linaro.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 16 Mar 2018 15:44:03 +0530
Message-ID: <CAOuPNLj3mnUjO4aj6PC=ocO6EkEkJg-2k80xQhXMAM6Y=3Dj-w@mail.gmail.com>
Subject: Re: [PATCH] selftests/android/ion: fix heap_type may be uninitialized
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594377569744869523?=
X-GMAIL-MSGID: =?utf-8?q?1595088832229724406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 7:18 PM, Anders Roxell <anders.roxell@linaro.org> wr=
ote:
> gcc warns that 'heap_type' is not initialized if we don't come through
> any of the two 'case' statesments before:
>

OK thanks for your patch.

> ionapp_export.c:91:2: warning: =E2=80=98heap_type=E2=80=99 may be used un=
initialized in
> this function [-Wmaybe-uninitialized]
>   printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> In the current code, we initialize the heap_type to -1 before the 'case'
> statements. We also change the print_usage function to state that
> heap_type and heap_size isn't optional, they are mandatory.
>

OK

> Fixes: 47a18c42d992 ("android/ion: userspace test utility for ion buffer =
sharing")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  .../testing/selftests/android/ion/ionapp_export.c  | 23 ++++++++++++++++=
+++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/=
testing/selftests/android/ion/ionapp_export.c
> index a944e72621a9..b42f803e9d2a 100644
> --- a/tools/testing/selftests/android/ion/ionapp_export.c
> +++ b/tools/testing/selftests/android/ion/ionapp_export.c
> @@ -31,16 +31,24 @@
>
>  void print_usage(int argc, char *argv[])
>  {
> -       printf("Usage: %s [-h <help>] [-i <heap id>] [-s <size in bytes>]=
\n",
> +       printf("Usage: %s [-h <help>] -i <heap id> -s <size in bytes>\n",
>                 argv[0]);
>  }
>
> +void heap_type_error_text(void)
> +{
> +       printf("heap_type must be specified\n");
> +       printf("  need to specify -i <heap_type>\n");
> +       printf("  supported heap types 0 or 1\n");
> +}
> +

I think this error function needs to be generic.
See explanation below.


>  int main(int argc, char *argv[])
>  {
>         int opt, ret, status, heapid;
>         int sockfd, client_fd, shared_fd;
>         unsigned char *map_buf;
> -       unsigned long map_len, heap_type, heap_size, flags;
> +       unsigned long map_len, heap_size, flags;
> +       long heap_type;
>         struct ion_buffer_info info;
>         struct socket_info skinfo;
>
> @@ -50,6 +58,7 @@ int main(int argc, char *argv[])
>         }
>
>         heap_size =3D 0;
> +       heap_type =3D -1;
>         flags =3D 0;
>
>         while ((opt =3D getopt(argc, argv, "hi:s:")) !=3D -1) {
> @@ -68,7 +77,8 @@ int main(int argc, char *argv[])
>                                 heap_type =3D ION_HEAP_TYPE_SYSTEM_CONTIG=
;
>                                 break;
>                         default:
> -                               printf("ERROR: heap type not supported\n"=
);
> +                               heap_type_error_text();
> +                               print_usage(argc, argv);
>                                 exit(1);
>                         }
>                         break;
> @@ -82,8 +92,15 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> +       if (heap_type < 0) {
> +               heap_type_error_text();
> +               print_usage(argc, argv);
> +               exit(1);
> +       }
> +
>         if (heap_size <=3D 0) {
>                 printf("heap_size cannot be 0\n");
> +               printf("  need to specify -s <heap_size>\n");
>                 print_usage(argc, argv);
>                 exit(1);
>         }

I think both heap_type and heap_size error message is almost same.
How about creating a common error handler for both ?
Also it may be possible to merge both the above.
Or, another option is to make use of print_usage function itself,
instead of one more function.


> --
> 2.11.0
>
