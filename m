Return-Path: <kernel-hardening-return-12588-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs6CoqSBoOSsUD39d51Vw8Ri/g/6r81OqBK4PbD93FEfVwybmOdTBnD4f1AezWzdR8jHQSk
ARC-Seal: i=1; a=rsa-sha256; t=1521031471; cv=none;
        d=google.com; s=arc-20160816;
        b=ekD1+OBlZ8LY4EhgLCcemyPzdjbtObwza2lWvrFu0iCv1XyKlyaQ1GRB1K94DZ6cst
         odwts4gWtj0D+8AmBEHhgtjLXYsutUB5JSiLywnZwAnz69GFdyjnoKDh9boJdU65Ws5R
         Lo74X7vyfvQSslN+UhB5/BMAwpfY9AeFYBg9HDWaDu1NjHEfQNPSmjEeFp6R7iIC7Ayu
         7x8poN7SzZONzvWH0aukpNxv1dieHcwWfX6YzlhnKPTvCP56R090eM/ihrXDaHxDrJcb
         ayK/fmIXqHzAme9NwuIq01NUM2veuCNXr5xVpiPWVcMxhcCtTo2pgx7xKGBvsgP4R0IH
         LoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=F4ipFVVt7YmubLLxw5olsjZWmNKKTU9pzZUhBricGJU=;
        b=05TFPBSUeSkOqJS1WcLa5X6awuOqUvareupOsqlK8ltWbJxMChqfccfodz3VevpLFQ
         XHmROoXGZBHSgVK77Glo9VaR/odkaYMpy386Si0TbYQ5IrempEe0GY3aFicQlpcOVjJG
         +/ZzNlRl019l+yb0Bn8dBaozmpK45yq4e72bL2TyjKH+QF5tzjG5uWw18XAVTLHJmJgr
         z0MJOZkcSubfVqv96q5Mj/OigJ0E93gQX2+5tNW1IAjhPb5OiROfkn3hkGYcuRWZQEdE
         /1zQJk4lpBrhsxFTTDl52LOH7ZshLolV/1wwNePzW4CyvHZZhoSPI8FM6oeGMua5/KOD
         iYSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JzedblaV;
       spf=pass (google.com: domain of kernel-hardening-return-12588-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12588-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JzedblaV;
       spf=pass (google.com: domain of kernel-hardening-return-12588-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12588-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <152103045697.8738.16803220270496592360@jlahtine-desk.ger.corp.intel.com>
References: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com> <152103045697.8738.16803220270496592360@jlahtine-desk.ger.corp.intel.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 14 Mar 2018 13:43:52 +0100
Message-ID: <CAJHCu1LburVFrSX3uUhpRwSnYp-=Hm+KW-Vg_NOZG_Z5y4KmqA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: drop various VLAs in i915_debugfs.c
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, David Airlie <airlied@linux.ie>,
	Jani Nikula <jani.nikula@linux.intel.com>, Kees Cook <keescook@chromium.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853392696206560?=
X-GMAIL-MSGID: =?utf-8?q?1594917096276948778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 13:27 GMT+01:00 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>:
> CHV_SS_MAX should be good enough. Make these function scoped (so #define
> at the beginning and #undef at the end of function).
>
> Do use ARRAY_SIZE() instead of repeating.

Thank you very much for your suggestions.
Unfortunately, it seems that someone else already fixed this issue, so
I'll just drop this patch.
Best regards,

Salvatore
