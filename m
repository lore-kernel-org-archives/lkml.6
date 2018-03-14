Return-Path: <kernel-hardening-return-12595-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtX3VLKE1onXxnPFP22RMfciBSX5zLhmKqzm5pRVI750mSdOt+/6O0MYznfz2XSpDyweFqg
ARC-Seal: i=1; a=rsa-sha256; t=1521034283; cv=none;
        d=google.com; s=arc-20160816;
        b=C2ZMu/00rUgEKdiuvc0KsOAYaGqu2UKOU34UYb/cjV8dh08x94sCvSeIT1RrlNU3zx
         7Ejwpg9XKCfGiBUio0wn0hkitv/YxYjrd2S+3LY6KTsouSHQUakNtXqsZW265bTltiQb
         munXJ2OGAKQbEOuhiEbdb3Dfq0uqhT1TyXpXdxjYeDe1NJmvYnG8QNokBOiWzR8klvla
         dar+aITNdR2pXs5lAb+/ZW7eygnsc1dZ3h8EQk+oo7uHea1ObJ1OyAnm+M+ldav3uiHh
         jOv67CiRoOYBEYYnc9qYtQ2x1zlPicVlCo+B+FRh5fNcrq12mnnaZkOIVlNadelfkCXE
         MNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=UEkHQSzMP8jcqcaF3S5Uj+4eyE2GCaK7QWuiBO4NJHc=;
        b=OaGXvUOaOB/kY6qnzApY6fKOI0FzICSq5J5EDXGPHjgPWonLJNKZmOrOoJCyvSbsK5
         /ZUPhYC6yh0qZxIgnPTm2hGmeRENX0v16bJOgbWGKbNbmhDINYIoMkYvK81D00oN5qtE
         iyN2mtOqKHUrkjR/Fpziuibqw5c64eeWe4RIdPIFvHvW/+GKRPhx/ZtRCQNqcNRhSMWK
         GC7h6FtR8m8eB4EWfe2Cs+sS/rUox3ieamNDs2IeFSzkofITwusBRwrztxothqVrhyDv
         wg03HcDuTamP+5B3ORJ5X3Yg+3YV1/5iieSZRw3dipa033wnSuB0SE9Wl58vIc8fepoI
         nNQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12595-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12595-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12595-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12595-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37985401"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kernel-hardening@lists.openwall.com, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kees Cook <keescook@chromium.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: Re: [PATCH] drm/i915: drop various VLAs in i915_debugfs.c
In-Reply-To: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com>
Date: Wed, 14 Mar 2018 14:17:07 +0200
Message-ID: <87fu52n96k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853392696206560?=
X-GMAIL-MSGID: =?utf-8?q?1594920044472440297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018, Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:
> Avoid 3 VLAs[1] by using real constant expressions instead of variables.
> The compiler should be able to optimize the original code and avoid using
> any actual VLAs. Anyway this change is useful because it will avoid a false
> positives with -Wvla, it might also help the compiler generating better
> code.

Thanks for your patch. However, Chris beat you to it with:

7aa0b14ede64 ("drm/i915: Remove variable length arrays from sseu debugfs
printers")

as well as adding -Wvla to our subdir-ccflags-y to prevent more from
cropping up:

c5c2b11894f4 ("drm/i915: Warn against variable length arrays")


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
