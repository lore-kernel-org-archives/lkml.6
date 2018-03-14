Return-Path: <kernel-hardening-return-12587-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvXQI7VxOvE4Jn9Z6N2vhahAyBdMLj2jxBReI+C1cVoGWv5nKteoPWBFXRWXKY4gD7GXuWC
ARC-Seal: i=1; a=rsa-sha256; t=1521031358; cv=none;
        d=google.com; s=arc-20160816;
        b=se8LRceIP1cjN38O7g+3i/tg4OLnrwdi1GNm7vCcxYhAfNkm+z5Y/O/6VRIac7kNGE
         lCUVO/rJrvFMHO2BFcnMq9S1IP+kEv12HtgoZLs6HxxW9EbmbtuJjcW9NZeaNDCKjaWg
         DjuD0QYSgd52tlzXVEAWqRTuTJvTCcVf7B2iMIjixbCurYE/9IxMnM04SbHrT2MXre+l
         m/w8JqqyxsCfkmi3C0Rt5wuTjkHMEz5oElasxaYdB8O1i4OnUoElcC/7glkgMuuqiOWQ
         e9DTebRDyqsYIZiQJMi9jbyDrteEWGlk0JFRVKmMNLe0YOMSy0TgI1V3A3ph57/x4T0p
         lU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=cV0Pu/xH4p+DPQebjc1Ung9zaOkf7FoZsPu4XY57rHU=;
        b=r3MFG3g3azP4lYKLGPf2BjoPNmNnwKoJSdvjjkfQ8mXYo1c4zeKqrQlHVyNlT+KuEU
         6lxtwb00jqyytaXz+SeoZV52bdHpWOBcCRXlETIqF1va7/fphCsvLfEUqNMcxZl5F7iL
         FD2pDtniWq0YbwHP2qIixwypGXquACKMOle5+gSQaZ8hoeAzFDhANbGyj4LhwJzrxJ3x
         ZP3XGH4MdgZ2lWyOE2ZZOycZPil+pkR6PBWlSyK5+reJVt0jfEfG8e75ISdAST8/CDpq
         AI2VQ4vy68uMQb4jV+6V5nlonK5BHxHbC0Lymuulnk1dY32v8ygzZXuW+3/00K2UJRS0
         vMTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ognl3HdO;
       spf=pass (google.com: domain of kernel-hardening-return-12587-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12587-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ognl3HdO;
       spf=pass (google.com: domain of kernel-hardening-return-12587-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12587-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <87fu52n96k.fsf@intel.com>
References: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com> <87fu52n96k.fsf@intel.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 14 Mar 2018 13:41:59 +0100
Message-ID: <CAJHCu1+OSs2h77sYFVGH=PRGpSxYY70nXcna1hDT6eUYzTkrEw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: drop various VLAs in i915_debugfs.c
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, David Airlie <airlied@linux.ie>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kees Cook <keescook@chromium.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853392696206560?=
X-GMAIL-MSGID: =?utf-8?q?1594916977694365194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 13:17 GMT+01:00 Jani Nikula <jani.nikula@linux.intel.com>:
> Thanks for your patch. However, Chris beat you to it with:
>
> 7aa0b14ede64 ("drm/i915: Remove variable length arrays from sseu debugfs
> printers")

I didn't notice it :)

> as well as adding -Wvla to our subdir-ccflags-y to prevent more from
> cropping up:
>
> c5c2b11894f4 ("drm/i915: Warn against variable length arrays")

Great!
Best regards,

Salvatore
