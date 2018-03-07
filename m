Return-Path: <kernel-hardening-return-12196-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt8H6jhnlKYAMlI4Gx+hNVeNmUAtMnDzbTO6qqsvAYGXPOUO0sV7eccVjlvOJlt6OxjR8OJ
ARC-Seal: i=1; a=rsa-sha256; t=1520431720; cv=none;
        d=google.com; s=arc-20160816;
        b=cV4ZVx/DwmMkRk1MnHtMcLPM+NjSkhk/X//XWrTyB8zioQMN2U/qmmruCtFSJQ809M
         aSqsYsZVvqdfKpIRQuX5Oh3zavioAgRjZNtYqjFMfcyqzJgUBUatdNebImTFMlaw3B1L
         BRe/sLz4Oj1+CE5Hiwe5VlXeOEXupdePCdKoFx8FoNvrXDrJcT6LE1lhJywY0ufHtXdU
         zjboShscDTqyPYrSmNTN8Yn03aYp8h+EwwNT0DB8P1NKFSe6EjdAxMQRVX+QCsXFj3o3
         EkS6glCFLIwwuHv/JUq25i9/gwhh38OHthszkAJ36eHBxX/S896A95n9i4rpNNRP58/Z
         njGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=8Q+vITd9CjNpjKsmMTHqVBpKiRLAnO/Wm7npZW1TGIM=;
        b=AJN5zBuPoy7IlKXXh6DQSwykK1xfow1HwHi4YKvUMBfxODeZcG/T/g70WKpzyJwfFx
         fDOuObzY9VCddt4oFWjbYNRBB1EEWo67MP+jGQimKJTb9HrPzsbi2xx//GHD8vEzLpxW
         HNKrb1V02tx0vNkHy8ZNlFBocKAyUfcplRNJXFwIs0vm5G66Q/rVeAw5KT9aWZPnGssB
         I76C8WSnSKBvqHZxM3EYyARgk27iGMOyWYPtpF+sxws5Rz53ALuOjFhNjM4BO3MwEWX7
         tSDauNSq77y8cyW4vSXap0xHuozE1pGMbZctVkIvucd0VwkeGVyQLG5hWEFTgU6tf3Iw
         OabA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12196-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12196-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12196-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12196-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/7] Protectable Memory
To: J Freyensee <why2jjj.linux@gmail.com>, <david@fromorbit.com>,
	<willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-5-igor.stoppa@huawei.com>
 <1b0aff92-bc6c-c815-f129-95720ec80778@gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <a21118be-a066-6ad7-4188-f50585a6f06d@huawei.com>
Date: Wed, 7 Mar 2018 16:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1b0aff92-bc6c-c815-f129-95720ec80778@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676771806146287?=
X-GMAIL-MSGID: =?utf-8?q?1594288212212518494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/03/18 05:59, J Freyensee wrote:

[...]

>> +config PROTECTABLE_MEMORY
>> +    bool
>> +    depends on MMU
> 
> 
> Curious, would you also want to depend on "SECURITY" as well, as this is 
> being advertised as a compliment to __read_only_after_init, per the file 
> header comments, as I'm assuming ro_after_init would be disabled if the 
> SECURITY Kconfig selection is *NOT* selected?

__ro_after_init is configured like this:

#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
bool rodata_enabled __ro_after_init = true;

But even if __ro_after_init and pmalloc are conceptually similar, in
practice they have - potentially - different constraints.

1) the __ro_after_init segment belongs to linear kernel memory
2) the pmalloc pools belong to vmalloc memory

There is one extra layer of indirection in pmalloc.
I am not an expert of MMUs but I suppose there might be types where it
is possible to mark pages as RO but it's not possible to have virtual
memory.

If (and this is a big "if") such MMUs exist and are supported by linux,
then __ro_after_init would be possible, while pmalloc would not be.

So it seemed more correct to focus specifically on hte enablers required
by pmalloc to perform correctly.

Open Question:

Is it ok that the API disappears in case the enablers are missing?
Or should it fall back to something else?

Dealing with lack of ReadOnly support would be pretty simple, it would
be enough to make the write-Protection conditional.

But what to do if virtual mapping is not supported?

kmalloc might not have the ability to support large requests made toward
pmalloc and this would possibly cause runtime failures.

--
igor
