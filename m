Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELsjStFRh7SjE8atyl1is5e1OZSDkC2Q6X1srcY4t7Nloe42J+WfmLag109jpzdY092Sxueg
ARC-Seal: i=1; a=rsa-sha256; t=1519884683; cv=none;
        d=google.com; s=arc-20160816;
        b=Krzv/jI9BxPj1EldGKZrlXBIrGLc6jN87rhWDrmfJXe3+opdI+S7LS6FgIVfbmxvC+
         s0fBwBJ7i3XpYdeXvQHc5stgIXpmRKaSRPLS60dnXweg7eFJsx6UfKsmoMB63TfOd0nK
         NJmCOfnw3a1acD7tRgrn6zeEv7Tb2cLBmEQ6zS4wjFv6eHnMVQBN12xU5US+B/sROeII
         gLLXRNDrJI1B9Nw9qOQDk1hnkNzJ8TnujLQXKpgfx/sy4M5WKcyoOYK28YBmP14lllz3
         1lsjifu8Snyo+e/6Z60HMUVMRxAS3+YkoHW0/03JdUlpCoCoaqoe/pJTQ035zKBNuCGg
         4vrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+fyK/hqgzMcgUBQ+8VBTNmjrH3NWtYmr+H970an/vb8=;
        b=tqSbc7f47HbFKoBGV08DYaBogyc1dASegoXJ9jgNmz1Sjada5TH7CVC7y2wcwMMLMt
         w4lIMposP9imZSTrHw+Azl2MgNU2G5w7iRU1DtUsqIUqu4ip1vy4DSDXssfzyAsQ+OCK
         4FQgkAzaUDKmhzyFusz4JVV63AkKUQX2oFa7r2QBaHEa7D62ZUmJtos8ImDzHQKMslTv
         FXtHfbit5KBXBPLbA6WaCuH8s9vIoUcvWa5ugLcyOIYPdiBRUtncIhk5r9kVlUKq9Ste
         0ZoQ3ppkXM0J57KyqR1k4PhOoYiETPPUrNVW/LySeNLP8RLSdfq3KUjAuG9omj90S51p
         xQ6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [Xen-devel] [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out
 of Xen specific tree
To: Paolo Bonzini <pbonzini@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Maran Wilson <maran.wilson@oracle.com>
Cc: boris.ostrovsky@oracle.com, roger.pau@citrix.com,
 andrew.cooper3@citrix.com, hch@infradead.org, JBeulich@suse.com,
 x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thomas.lendacky@amd.com,
 dave.hansen@linux.intel.com, rkrcmar@redhat.com, gregkh@linuxfoundation.org,
 mchehab@kernel.org, hpa@zytor.com, linus.walleij@linaro.org,
 mingo@redhat.com, rdunlap@infradead.org, luto@kernel.org,
 jpoimboe@redhat.com, tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
 <20180228210814.GK11576@char.us.oracle.com>
 <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <20f82d4c-9591-7770-aeca-0331a7940f5d@suse.com>
Date: Thu, 1 Mar 2018 07:11:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593714601493022226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 22:35, Paolo Bonzini wrote:
> On 28/02/2018 22:08, Konrad Rzeszutek Wilk wrote:
>> +obj-$(CONFIG_XEN_PVH) += pvh.o
>> +obj-$(CONFIG_XEN_PVH) += pvh-head.o
>> +
> 
> Probably a better place for these would be
> arch/x86/platform/pvh/{enlighten.c,head.S}.  (Just because there are no
> .c or .S files in arch/x86).

Right.

> Maybe Xen ought to be moved under
> arch/x86/platform too.

And hyperv and kvm, too?

No, I think arch/x86/xen/ is fine.


Juergen
