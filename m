Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520450176; cv=none;
        d=google.com; s=arc-20160816;
        b=DlZP7N3I3j9Es4/BMQxn962o6agsKslLNCudPfddDg4d7EWD5uq1ekCHrxtc1BGfsb
         DzBGG7UyF2Lt5yB3TUGvZj3jq57VsbIJReeosCNRwjxO8T7SzLdGA19C8zsVORUtx7jf
         nemh0XB4U19XPmmMwDbGAreXTKbZeKmxcDeqNStO75U3qgu+sgOgeeLg/O0aKhiB9fWv
         gh7y2L8Gd3Bnh93U2I1OX+xK3u2onrCYDValwlDtI+GYBxdZ7q/UN9Q/eRJPzPFi4fMK
         Uf5dWqB5tQaxiAr1HdnVLxsIYNiMO2ECHe0blY7OmA8+t0f3ai1KfhfJODDws/KcZn8M
         mXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OjV//2bNec4Ge+777i7tPUb7sSzrNb9ZyTFOGbLgp4U=;
        b=hlRMxisLDToJBFKYInyfep8FNAFReqlz1yTTvKTrux78l9KW7+kiESOlvwNodNUweM
         sHl/FlZzZHnj4+I3AbkG6LaUpIHvjVLOY6KaINm4IOvqnSWd2HwPVKqHthlkMIhTjzGS
         iSjN7OfxbLTJFzNZTHoYkmGmTkluQtzPD+JwO9U0H3zh+Pk35tnVlZ5mo5QkqeWgxed3
         eWocRPCd3vb2zncRCDPjEG/slByJDjaNFaSqenz3+qlTrLuNgXlCkMb21LqOoj7tRCUK
         RHhhNgRrDB2dmOQYV5tsxJP5wvjiXHZ8xerpS0tAOqInsmGkKrRMMGBmXHdTUWui5n+g
         DvJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=nC4I/z/u;
       dkim=pass header.i=@chromium.org header.s=google header.b=MMjsHfMn;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=nC4I/z/u;
       dkim=pass header.i=@chromium.org header.s=google header.b=MMjsHfMn;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtUAumARO8Cc1Irp9ne8Fh/dnqcvML/wTkzp43AbqY1m/cVYt0sn5OW2e/AWoFThAW10STu2ozhgYwYHrh4vg8=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1520447904-15160-1-git-send-email-himanshujha199640@gmail.com>
References: <1520447904-15160-1-git-send-email-himanshujha199640@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 11:16:15 -0800
X-Google-Sender-Auth: wR9igA377KNfYv-AHk8aG1cXo6E
Message-ID: <CAGXu5jJXc7QSU_Vqu=gN9kAG1RV0PNmT=azScFopUBrusnn8wA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: isp1760: Use kasprintf
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594303290138728501?=
X-GMAIL-MSGID: =?utf-8?q?1594307564306397422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 10:38 AM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Use kasprintf instead of combination of kmalloc and sprintf and
> therefore avoid unnecessary computation of string length.
> Also, remove the useless local variable.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/usb/isp1760/isp1760-udc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> v2:
>    -removed the useless local variable devname.
>
> diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
> index bac4ef5..1714b22 100644
> --- a/drivers/usb/isp1760/isp1760-udc.c
> +++ b/drivers/usb/isp1760/isp1760-udc.c
> @@ -1441,7 +1441,6 @@ int isp1760_udc_register(struct isp1760_device *isp, int irq,
>                          unsigned long irqflags)
>  {
>         struct isp1760_udc *udc = &isp->udc;
> -       const char *devname;
>         int ret;
>
>         udc->irq = -1;
> @@ -1455,13 +1454,10 @@ int isp1760_udc_register(struct isp1760_device *isp, int irq,
>         if (ret < 0)
>                 return ret;
>
> -       devname = dev_name(isp->dev);
> -       udc->irqname = kmalloc(strlen(devname) + 7, GFP_KERNEL);
> +       udc->irqname = kasprintf(GFP_KERNEL, "%s (udc)", dev_name(isp->dev));
>         if (!udc->irqname)
>                 return -ENOMEM;
>
> -       sprintf(udc->irqname, "%s (udc)", devname);
> -
>         ret = request_irq(irq, isp1760_udc_irq, IRQF_SHARED | irqflags,
>                           udc->irqname, udc);
>         if (ret < 0)
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
