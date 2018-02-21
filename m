Return-Path: <kernel-hardening-return-11858-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2271xaQbrQZSR/C5lT1vAy3hdZuoigC6XbOifC0zZt9JoYhLJzRknM+rb8wT5Do6fnCuIgMX
ARC-Seal: i=1; a=rsa-sha256; t=1519224527; cv=none;
        d=google.com; s=arc-20160816;
        b=iaTDqKq7eAjo+nomW6SnwhZjqZAz/GeieOtedHT/DKSSYEOwV7dWbjyqVxk2go4xly
         dY64YgYxbU7DBkN7Nx/LuxtnMXUYALH9CBJkGk79GaYoVzKaJ1u/PPQjxhmJYs8VEiQH
         Ss5+7IDIpoim3x2wul53Hpu2A6K3fU4YHgvBoklvsLzbtgJtFzbdwlZ5XA58gSin+4LY
         IEWTARIZ9OjbntbfgG/cxHH9/9BoteIAsavKw9QGeN4L/XsUKB/S6Camdi3otLLlCavY
         060enlHp0G7iRWgnEgWD8xHA9RrCrfOfS7hoB7IUvMy/f6rXcZb4D1ptQ0gyWmlVLhlF
         UjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=odjz7SgNHxFRJQfDLpkOKhjaXVlK7EFrHlyI3yjOIn8=;
        b=DJunOwL3gU57D/IS5Wfsh6NaoMLKIY2PlPBnUvkL5JHSyjjUCnDhMEMPTFqv2fIUN0
         U2IqczLTdoIirJCC2whWkIwrQs9T6wQECH4DGVzp9gW4adjRt4NaxQL529vAYqQMrT+s
         x5/HkfCik9gvHteHn4t0BDj4ztftK9+l907LQgyv6IQ8u5f9Pl+V/LlvYq9dqbG/5hU4
         IdNMBnOfpjpskghVi15zgxp2AtGtTqNCCAEb+gmZaAyazVuXKBG68RSeb+2pl4exuS+P
         n0G+/cZoRv3cPv5Pd7VJ+r89BR6b/mYXTOEdeCsIWViXhyvIP7mhuibajKrdyTExYtSN
         FtDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11858-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11858-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11858-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11858-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 0/2] Stackleak for arm64
To: Laura Abbott <labbott@redhat.com>, Kees Cook <keescook@chromium.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: kernel-hardening@lists.openwall.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180221011303.20392-1-labbott@redhat.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <ee58357e-4c98-ec67-60de-0f8283261727@linux.com>
Date: Wed, 21 Feb 2018 17:48:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221011303.20392-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971089304510513?=
X-GMAIL-MSGID: =?utf-8?q?1593022378781567680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.02.2018 04:13, Laura Abbott wrote:
> This is the arm64 version of the STACKLEAK plugin originall from
> grsecurity. See
> https://marc.info/?l=kernel-hardening&m=151880470609808 for the
> full x86 version. This is based on top of Kees' branch for stackleak
> and has been cleaned up to use a few macros from that branch.
> 
> Comments welcome, if there are no major objections Kees will queue this
> up to get some CI testing. This passed both of the LKDTM tests.

Hello, Laura,

Thank you. I'll take some time to learn your patches and test them on my LeMaker
HiKey board. I'll return with the feedback.

Best regards,
Alexander
