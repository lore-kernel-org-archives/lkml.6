Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524576022; cv=none;
        d=google.com; s=arc-20160816;
        b=dW957VgNGdNRfkoaL+rV8lyVCeajrHED8Ucz9LWCRF48rAx8/DNZ8w1CL+bwwf2tmW
         pim6h+eYPVsxtolF0e1d27dzur1/Nh1eRy2/F1T950wH5X6Jg5czQGsvz9RlsFFUxqD3
         1feV47M0u4uM+swoNV4bJEEWWtujMQVTw2xCTdcKJcBXphfpnWZejG8MF2tWM59OhRVY
         w75EBwk8gzbn5icXz13veVNsLuVVDngkqkgkpGYIzU7ZPVjedlhSjBFmiCYRWntedT1e
         +fgbpPVgRO1epILYKVI/nZbvxZ0RDi+0dFrX4TYDaSeyQLQ2eTmxJhEsYqgmuktJVYLh
         mSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=R66Ji0noFeixG4A8SolX0OD6VGNdPZ3Xc6m+BEus8kA=;
        b=tmS6mlmPB5ezlhT68vVGEltYw3qMUYrawaZ14d+Z+JQuNLpDl+1DW87r5G6DsqUGc3
         wyEG/20+T0JmYD47Zqjqnmz8+pjwMgPB++WfoQ5/nwgprYavEwjfDKjwOV0icbXxh62a
         kqFA2SdPqpeLkshU7nj1tI9P2dPrGtWQZgtW9Utg7Oo9IOil7MFYePrYxMoJcatlPa9i
         K7fBb8wyqlL8XE0QJUwwFAKouOXQxnlTY4uHhd7ms8y0HOHjatvZRcDFN2my4OUe3taj
         F6EVpcnfjAmFKvS3xqB41ZSdndkXs1i0XbyVyUnFT4oRWqYRMwhnwqVcu/okJfFnSrrO
         0s6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4/HPoc0e+xOQfA8RTx1sH6QF1DgulOE/AkU+Vn4u757KTd04OilV2CQZ6oyUubYvgAVZPGvCQ==
Subject: Re: [PATCH] vboxvideo: fix mode_valid's return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cihangir Akturk <cakturk@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Michael Thayer <michael.thayer@oracle.com>, Peter Rosin <peda@axentia.se>,
 Keith Packard <keithp@keithp.com>, Paolo Cretaro <paolocretaro@gmail.com>,
 devel@driverdev.osuosl.org
References: <20180424131532.2559-1-luc.vanoostenryck@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5372cade-cc6f-3158-aa1b-59d2ffee341f@redhat.com>
Date: Tue, 24 Apr 2018 15:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131532.2559-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598633525042464683?=
X-GMAIL-MSGID: =?utf-8?q?1598633827784544573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 24-04-18 15:15, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thank you for the patch, looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/staging/vboxvideo/vbox_mode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
> index b265fe924..5c7ea2378 100644
> --- a/drivers/staging/vboxvideo/vbox_mode.c
> +++ b/drivers/staging/vboxvideo/vbox_mode.c
> @@ -573,7 +573,7 @@ static int vbox_get_modes(struct drm_connector *connector)
>   	return num_modes;
>   }
>   
> -static int vbox_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status vbox_mode_valid(struct drm_connector *connector,
>   			   struct drm_display_mode *mode)
>   {
>   	return MODE_OK;
> 
