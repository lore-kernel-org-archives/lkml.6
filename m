Return-Path: <dave.stevenson@raspberrypi.org>
X-Google-Smtp-Source: AB8JxZpGJGfKDD31R5n2C9zFb328IhtONeKUhCBfyXmttgtgjr+FWo52T53HDc1DnOM7uz0asI3Q
ARC-Seal: i=1; a=rsa-sha256; t=1526030481; cv=none;
        d=google.com; s=arc-20160816;
        b=HflTjq0tzMcl6OEmGPzQtuWzqkYBi0YRFmN9T/Q0pI0ZTMzrIit/e04R+LUudN6xnH
         rVUAUxqKhtqfK0jtn/lyqEEFY9eFEKXzE963vOavr5QrjkwcEK0gNWiKSwUI6XHBjAo6
         /VWhVirHHAZP67sqJdg3PjXfIMI18AEqXmZk1lf+1bsrPKoVhGDaLPv/zJXd/MGNL1Sc
         kcQPg5LTh3rRX6qN145U/VtN22DbMixiachmBMpE6scm7E8ewiuFNPt7p2ENQ/Qweiba
         SdNk4yz67ugziXHdtvs+1Lce1JZmaA0v0Mb3L1dont25UNvHM4VJEXbJJaQzp2V/d2px
         lPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=iw7ZuniUn2Y5itOVXBUBMsEQOvX3MBOq/fuB8QWJGTU=;
        b=tMCbkBROb5/EC+6FOzUhrYh+79Z/z4fpIaoXZZXbt6koREECO8pt/z+SALy8p6/XhP
         kZyfJASlrJLfPnj6hHg867s4xxDDj5SMvVqkdsJ2yCe/bhDd5OiA6OG6tadf6evRBsAX
         bQOa6VMJPC7mxCeDj8n2pKRKOxhB45h8fLlSpYYUBaRyMCIXWjyLoNVsYo7/6Uq9WDCC
         56jPTIztSNkzUpPaisYhqnutoYjR2IF8+HXRH0p6oJ4JihLIpYN2ABuuYz4/I9/jDLhe
         5lv6+El1ydohXGnUQ9Mou5CL7E9s5tSzH4iWF0Kuj5QjjQbnd0v5KXe+6dvt7R63/H/X
         W2kg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=CdmqREX9;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=vlT6JNxm;
       spf=pass (google.com: domain of dave.stevenson@raspberrypi.org designates 91.207.212.211 as permitted sender) smtp.mailfrom=dave.stevenson@raspberrypi.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=raspberrypi.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=CdmqREX9;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=vlT6JNxm;
       spf=pass (google.com: domain of dave.stevenson@raspberrypi.org designates 91.207.212.211 as permitted sender) smtp.mailfrom=dave.stevenson@raspberrypi.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=raspberrypi.org
MIME-Version: 1.0
In-Reply-To: <1525993965-4317-1-git-send-email-stschake@gmail.com>
References: <1525993965-4317-1-git-send-email-stschake@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.org>
Date: Fri, 11 May 2018 10:21:18 +0100
Message-ID: <CAAoAYcMYF+zudHy-_EYH9RHzH41xhuifaD0gj+Uowt7FZVk+gw@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: Add TODO for removing overlay support
To: Stefan Schake <stschake@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600120678772051411?=
X-GMAIL-MSGID: =?utf-8?q?1600158938500366708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11 May 2018 at 00:12, Stefan Schake <stschake@gmail.com> wrote:
> The overlay code is non-functional since it relies on firmware control
> of the HVS.
>
> Signed-off-by: Stefan Schake <stschake@gmail.com>
> ---
> Dave, does this match your understanding?

Yes, the overlay only works if you are not running the vc4 driver,
therefore dropping it is sensible for the mainline kernel.

>  drivers/staging/vc04_services/bcm2835-camera/TODO | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
> index 0ab9e88..770fea6 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/TODO
> +++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
> @@ -32,3 +32,11 @@ We should have VCHI create a platform device once it's initialized,
>  and have this driver bind to it, so that we automatically load the
>  v4l2 module after VCHI loads.
>
> +5) Remove overlay support.
> +
> +We advertise support for a V4L2 overlay implemented through the
> +ril.video_render component. This component is non-functional with an
> +upstream kernel since the VC4 DRM driver controls the HVS, not the
> +firmware. Once we have dma-buf support, the same functionality with
> +improved control can be achieved through the DRM interface. We should
> +therefore remove all V4L2 overlay functionality from the driver.
> --
> 2.7.4
>
