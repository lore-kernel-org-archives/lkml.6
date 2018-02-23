Return-Path: <kernel-hardening-return-11937-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtp32HYXSSSglEvxhgEp9sVVDoLO/2zOVA7fynYUjHB8gd+muzfgxz+7FUkPe/o7vbK+6ky
ARC-Seal: i=1; a=rsa-sha256; t=1519426074; cv=none;
        d=google.com; s=arc-20160816;
        b=IFrfjplpvAmXC3j869ToferVc/QAjHcACk9GaFiTuxz/sGaN0NhWvZHhhmB+A/VHSd
         50RchvIr9jfm5NGyQa/tQVBOublCzS0E/8JcftFJ5WJRbYsnWFE2eliZzzZ05qUv/Vvo
         bJcxgB+wiyTbVutuOT0I+YqZomTtj08aG2yIX4X6Ru/mDHFffjL7nKO/KkN9EtGNVPHx
         OccnACqOICmwbwXMP4jB78cylA1+O9GtP7O2i4VCRv3pCgiNafKd5kaLHayq8nbXeppx
         zOeTbOHaKE4r27ygJSYQtzlz9AXr7qmHaGjdnr3Os7zI2f7RqaluA9B++PeShd/HNM4U
         UUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=SefxM5Tdq4P47leHPJ+gEjJCbHM2xsHy9igR9FkhswA=;
        b=0tm0xSFCbZI8yAs1u2Z24VK0QOZAxLTbaWtXVCFfT/Jn7NfwNIWhGRL1uUiTJji3ZT
         YGuCrku7k0vYE8fp7xy4nzcsoeM+B0hjJ42vMztfpkmzRHISDwRhyNn32JA3f4WJx2ab
         jzXpmf4iQEFby/ijIWCkpI/fCeJSLk5xVbG/cSRHS8avw1H9sA/YY+GiqFxqLdb8a6Cy
         92sAwhFTzPX3x6YB6hrQvNvKYjCEVhP0DCpYY6LFPhpuyRS/HLmjL482hqlJI0id25Zp
         8+0MkJ0c/YA8+V5ZJx9xd4pHsysXXB3AbgOQDSdleCcwk9R2yIStm2Toyqw0FzCWv66J
         fQ7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N9XBhJdY;
       spf=pass (google.com: domain of kernel-hardening-return-11937-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11937-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N9XBhJdY;
       spf=pass (google.com: domain of kernel-hardening-return-11937-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11937-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/7] genalloc: selftest
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-3-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
Date: Fri, 23 Feb 2018 14:42:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223144807.1180-3-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203665689840629?=
X-GMAIL-MSGID: =?utf-8?q?1593233715124898549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> +	locations[action->location] = gen_pool_alloc(pool, action->size);
> +	BUG_ON(!locations[action->location]);

Again, I'd think it through if you really want to use BUG_ON() or not:

https://lwn.net/Articles/13183/
https://lkml.org/lkml/2016/10/4/1

Thanks,
Jay
