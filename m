Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELu9Hew/309mmFpCLVz5yll7/nzticWiWsOfCZ6v43/CgAbFBtqbk2BQ3/ul0zMymy9Gd9hO
ARC-Seal: i=1; a=rsa-sha256; t=1519889480; cv=none;
        d=google.com; s=arc-20160816;
        b=ZmHfs87xt5R79hgUOlwI6TUCBy8byjkwt+Ni4rWoJfzxGW4xPvrWws8rE2J3jYA0LT
         d7+U1wnmi1r3FDeX+dlIMR03OdvAKHV0FoMzv/tmQWeYbs6D/aH4lyqeLKVlLRwyJV4M
         gxQA9CNvhxAcIJX7JMB6bbhN2o/if3F6hD41ELgC0BM83XHzEi8NSWghEYOf/2gCMOK1
         bxwrPJXnOJDYgeYBvUsqxT15daBrP2axZP1DmMMwtLX/RpPo7H43JX0jylqjGd5fS+4z
         d3elfSgOLc8c8L1S2JGr967F9tBrW/DAl6L4+RGYKzvgy24cuulZnDq52bokASxbBEEe
         tT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=A5BJjP2K8j1VjHb1RrM0FnDjqvCaEv68AMFtYalSiUM=;
        b=PqR3ru7a1O5fi+FUv+tIdFTAb5UKb0XBrsFwIr0n4Yzh3MG0zbbM3a1ICX5HHWSDYC
         UnY6w4hqpJ3x4EdO3R1ZvcbDCTEXUCxGwSo4iyNerA7uts3lsq+RLzUYgDIfKVQN35U0
         dAESFhkIdBxsJQTgQzRMNtWlq3VPZqnasdNCkh+YY2pw9eZ4c4iVSmn8NUZt1QmL4v8o
         fPoUXL8LICxXPMjQz1yyFkhQFpeafbzzCizjydGHFe1WYnHF+oOK0lC34M7pyDjfRtrJ
         rdAvvAS6KH8vA8V9hBwrmVOaM1szFxx5Vx2evLncrrT6SFQTBEyyCUSoVG6hVfDeTVc8
         LyIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [RFC PATCH v4 7/7] KVM: x86: Allow Qemu/KVM to use PVH entry
 point
To: Maran Wilson <maran.wilson@oracle.com>, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, roger.pau@citrix.com, andrew.cooper3@citrix.com,
 hch@infradead.org, JBeulich@suse.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
 jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
 thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
 davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
 linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-8-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <db421f9a-f0e5-ee15-3348-20f806f7a852@suse.com>
Date: Thu, 1 Mar 2018 08:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-8-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431489579630?=
X-GMAIL-MSGID: =?utf-8?q?1593719631278741960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 19:28, Maran Wilson wrote:
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, Qemu should be able to boot directly into the
> uncompressed Linux kernel binary without the need to run firmware.
> 
> There already exists an ABI to allow this for Xen PVH guests and the ABI
> is supported by Linux and FreeBSD:
> 
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
> 
> This patch enables Qemu to use that same entry point for booting KVM
> guests.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
