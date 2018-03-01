Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519901168; cv=none;
        d=google.com; s=arc-20160816;
        b=ZeJ51MpSzg0R3RkBkaUOM6T/6Lh++C1pW7/aXtIP8b10Go/rZw7D7Yn8RjK36JUh5f
         ZpR4gEK7YQoIoChhuJ70+CnpsFz2r4C7HOhCtDO6Naz4P61VXZ41RtKCC9yP1V4z5RX+
         LACC6hjwQhmsJYPOPnJJRgW6/FtJ8vJephJCY4f1uYNmPxf4nx2IGMSNUDuHIHQJw+rc
         c4secexoiQfTkP22ZSPqQ9xUvoiuZ9+3zDmJtO+/BUrEhCDnzqlDbho8gfvJr6Aq9evo
         qs4z4zDPX67U+dV92e+xODFdl5o56XCl9HL9wfXg/s8kHZ6hdekswmrOYVBC2BAnvI0Y
         qGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hlhSIIEK3Gvkj7YMAZRoPzXh3KZthq9+2VT4EpGLxgE=;
        b=qu1mHdbwGcmNq/rhE++90/0aTyoIC4bwAD8mTFudjayhQp6othjhwnTfVDH8MAvRok
         BJ409bthTAw8DDQmMd+2/CD3czmBaDBY8RMZEWsOk/WCwbe2LMtBRo56hT2w+b5nz7Bq
         Cb736oRqlHZQjinCQMKyHnSWRcoG4f3Vi2ZRgQ0UjUTtQp9UoxGA3hQoJOJSG1ru0tq1
         5BnkfCCi1QqhMcTFwpqYZ0PN9bqZ5PowHSh0a8p8PLfR52OPlbHyFStAQLr2PMJFkbut
         Ob21eW+H9Oo7y75C1V1SMk+D4mwANJ7SEhvT656U7YQD5fcOnsHzXj2Gp2bTjJjRwnCE
         dybw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TMjrgtGd;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TMjrgtGd;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu33r44qO9yF2ltZfRCQTswDFmPusS/v6H/YNEnBHVUYDTq2IetokG3s+4tV/kLHj2vevEm4vvhRJFsRf9+35A=
MIME-Version: 1.0
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 12:46:07 +0200
Message-ID: <CAHp75VdAEEjycTvxb=KLOsBESRfSjio1uDXfY=gR91TxCCOkVg@mail.gmail.com>
Subject: Re: [PATCH 01/12] parport: ax88796: Delete an error message for a
 failed memory allocation in parport_ax88796_probe()
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772848657448336?=
X-GMAIL-MSGID: =?utf-8?q?1593731887268848462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 9:47 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>

Greg, just to be sure this series is under your scope.
IIRC it had been sent during merge window, though it looks like your
tty tree doesn't include it yet, while even older patches, which were
sent as well during merge window, made it

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/parport/parport_ax88796.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/parport/parport_ax88796.c b/drivers/parport/parport_ax88796.c
> index 2fc91ed..ef0aec4 100644
> --- a/drivers/parport/parport_ax88796.c
> +++ b/drivers/parport/parport_ax88796.c
> @@ -281,10 +281,8 @@ static int parport_ax88796_probe(struct platform_device *pdev)
>         int ret;
>
>         dd = kzalloc(sizeof(struct ax_drvdata), GFP_KERNEL);
> -       if (dd == NULL) {
> -               dev_err(_dev, "no memory for private data\n");
> +       if (!dd)
>                 return -ENOMEM;
> -       }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (res == NULL) {
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
