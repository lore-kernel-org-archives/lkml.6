Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526331611; cv=none;
        d=google.com; s=arc-20160816;
        b=S3Z3m9mdzm4Kwz0M5EXRRprjN2c3trGOj929HXXDgPcF03tqAefmODicn/cuR6WH9R
         boSVZxkUgo28Lg3xvALRhbImWlK33gJgz5BTZ1spMTH/4AzROqCvUfe1TIAYHd+mZ2ex
         udDIQaUjiIBGrRuPPG8yMFvDj91geXh26ztsjjc5ygbQQRNBEdu2acaXIOg7aLpRkw/3
         NVYWzO6J6ntXs+8D7QS8P5xNFEm78Ko98kswHYqK0tTaRzXYaw/AAmQyKfe0EdFrXWGL
         N9zueiYARV+bBzPYOoBY9cC7NvdPae06pdM6EzZ0c5WLeN5kfwkKyiTYj/EsrqX7zPa7
         q7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=A+3QvxIJc4nNoZszN9PxI/51yfbUuXRKpv4tO14Gh9g=;
        b=GOzGal2Y/22CfSuwg7TFC4iMYJTH9SZ3/3GeIxEIaE8FBsojQ70wM3U1Sf97gFBKXM
         7ZC5Rs30oBBrJL4QwK4Jlg923sCDRVf3tNlHcegwFgKw9S5WsXNQO1ukoltks7ZNh/Cg
         mOvPCF3O2uOu3EOmLgxcV11iHcS+DGRJPFVmXUauY11WA5by4/6a9SehIOv5eZ5gRZ7E
         t6lz7TVhR8CRixvzvaLcRHvwHIjP6Gu9MnZf40ECY3p2JQNGlbZhuXJ/IRCYKVJ8bMSA
         Gol0Q3hglHtKUBpZq2VQnIRGgX/zufYfT1JIRskqohMJzPixdyPD/YQLvND4GMHzseax
         Qq+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gA7+3jjy;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gA7+3jjy;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrNNZwBJDAPdRYXvMkSF3G0M3skemLDY1AVJMZzEgocsM42YFqmz+J6LzJzRbgeHevDm8m5mKe9PN7ZGwXZa9g=
MIME-Version: 1.0
In-Reply-To: <20180511152537.32267-3-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk> <20180511152537.32267-3-jorge.sanjuan@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 15 May 2018 00:00:11 +0300
Message-ID: <CAB=otbSF+Nqo2G-fTGTXX_cOtGmo8KrbSgcHim7EKxUZq4APzw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285489825871167?=
X-GMAIL-MSGID: =?utf-8?q?1600474696179306965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 6:25 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
> Hence, checking for pitch control as if it was UAC2 doesn't make
> any sense. Use the defined UAC3 offsets instead.

This one I already reviewed in v2 and there is no changes in v4,
so still:
Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

By the way, this patch is an independent change and can go
into v4.17-rcXX, if it's not too late for it.

Thanks,
Ruslan

>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/usb/stream.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> index 764be07474a8..6b2924533d8d 100644
> --- a/sound/usb/stream.c
> +++ b/sound/usb/stream.c
> @@ -576,7 +576,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
>
>         if (protocol == UAC_VERSION_1) {
>                 attributes = csep->bmAttributes;
> -       } else {
> +       } else if (protocol == UAC_VERSION_2) {
>                 struct uac2_iso_endpoint_descriptor *csep2 =
>                         (struct uac2_iso_endpoint_descriptor *) csep;
>
> @@ -585,6 +585,13 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
>                 /* emulate the endpoint attributes of a v1 device */
>                 if (csep2->bmControls & UAC2_CONTROL_PITCH)
>                         attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
> +       } else { /* UAC_VERSION_3 */
> +               struct uac3_iso_endpoint_descriptor *csep3 =
> +                       (struct uac3_iso_endpoint_descriptor *) csep;
> +
> +               /* emulate the endpoint attributes of a v1 device */
> +               if (le32_to_cpu(csep3->bmControls) & UAC2_CONTROL_PITCH)
> +                       attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
>         }
>
>         return attributes;
> --
> 2.11.0
>
