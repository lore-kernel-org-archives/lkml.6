Return-Path: <kernel-hardening-return-12596-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt7gT/2fZvOOvOKyIslyNmSeXiRIueG/ZBAh3SkHNyLPJ59S1TAIvddCTjixwlv7tWTfTdE
ARC-Seal: i=1; a=rsa-sha256; t=1521034291; cv=none;
        d=google.com; s=arc-20160816;
        b=iBrrc+ulo84nwAbj4k9ltFdm8OyF6tLl7FkOvP9znHWzmUEgAKiCg9+dTyGstLi15P
         UK7d7EtncSKAREiKCL4wZj1CA0DHNhA646cT7tTvBCcAoRI/DVc8/cNMTjofD8sGRUql
         kuoDjay8Vgm9GWh85xYn7Ct81b6lkVtv6s5CQ/FLNTAFyg88v0Ivqe0c5Lechr+afwZ5
         6LS1Sen1lSfGNSVBeaqkmGwZVQVJbKTQPt1Q2Dy8aKI+YnhjOPFlnvvgcKyUs+KQI0xf
         ukYAJYo3Q2ocP1vBh/yPnQ82TAc+Q34i/v59tRETFZuxS1gq9okTnTpiOit75x0fezvH
         e2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to
         :organization:from:to:content-transfer-encoding:mime-version
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=myeFNld/2GDmwOCeAUxyY0pVz95UkcOpS0etsE+fWgc=;
        b=B4xBtIEniZodnr+U7JgSGfArZQBSvPSjM7d42ydchY6xJFG7POgkCeoUpFoaU1W55G
         SwCip98oVVLhvYjLryFusHoQ6fAMwIxxPfdO8qkiNSkA7MbubdIoDVyNJP68Bq3BD/dL
         0+sUmIWHxle44ESXImN2+m8b4thuL7hBnBK1jGWsbUnhacsInqJOgTWwT6SRahHwmz44
         3ZEwHCOz+23DaJ4hkA/Iz34J4RPpP1MqFogGLaJZBMTA4m0l/YsXJQz78uWq1YX859gc
         8GvHPgORedFNuNNGGY4Ut7PZWGhdp4uYEDiq9MEwEq6DA8dIfT9yajE/zO4tef2oZLtS
         fVnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12596-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12596-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12596-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12596-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="25168499"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 kernel-hardening@lists.openwall.com, David Airlie <airlied@linux.ie>,
 Jani Nikula <jani.nikula@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <152103045697.8738.16803220270496592360@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: drop various VLAs in i915_debugfs.c
Date: Wed, 14 Mar 2018 14:27:37 +0200
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853392696206560?=
X-GMAIL-MSGID: =?utf-8?q?1594920052400846472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Salvatore Mesoraca (2018-03-13 21:51:28)
> Avoid 3 VLAs[1] by using real constant expressions instead of variables.
> The compiler should be able to optimize the original code and avoid using
> any actual VLAs. Anyway this change is useful because it will avoid a fal=
se
> positives with -Wvla, it might also help the compiler generating better
> code.
> =

> [1] https://lkml.org/lkml/2018/3/7/621
> =

> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> =

> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i=
915_debugfs.c
> index e968aea..bf0a8e3 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -4259,19 +4259,20 @@ static ssize_t cur_wm_latency_write(struct file *=
file, const char __user *ubuf,
>                         i915_cache_sharing_get, i915_cache_sharing_set,
>                         "%llu\n");
>  =

> +#define CHERRYVIEW_SS_MAX 2

CHV_SS_MAX should be good enough. Make these function scoped (so #define
at the beginning and #undef at the end of function).

Do use ARRAY_SIZE() instead of repeating.

Regards, Joonas
