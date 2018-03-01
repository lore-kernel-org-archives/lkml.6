Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELuKD3QhM9CWXEJuTyi0f354dn1kgjrCoMfwlq7Umr/mJou2ns5JVqcuXEDSa9sgGJzHTO03
ARC-Seal: i=1; a=rsa-sha256; t=1519889348; cv=none;
        d=google.com; s=arc-20160816;
        b=R+shA6YoZXm3dRqn/G4WLdPDRcE8nFgsbr8IxBlSos0XNrrQMVP2DC5PO8y9jIxklu
         GHl1l7SmxmA3cUuasRWYFN6Yd6KWz3XwrTj4pRLtUx3C7QaDXWZ42x8O3Ubp7GeebB32
         vrp5KBoPAscpT1isM7eUr92r+7NbVLkxiUf1rOJFZWfIPA+jV6+PIpnBxLTnAWgOEhNT
         +GcJAmtDSPTqcebRuWuqIzD4ibWtUh/YeSd51hHsh/hXpcVL9wotkfMXjr3RVSgQ2MDN
         LUHwuj8ao6nwDqpt+Xx1Vy8w8JctAEwVna1DMqRkfzswn3QlkWzjRAAUzisg30+tFN3S
         GRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=c5rTNC3q/hbEa3sgxK9rQ47jJRjgoyctTQkh/hVpOMs=;
        b=BsoammsEybxOts0AOZiAOoRsK18UeagxM1gPL/kPZwhCUev5iPe2QmLIIf4w5/aIUz
         n5GayPXg1pHpZdtKALi7f9t9gunSm2r8gr+ELRmnFkIff6oqFtuNXMIRW8+LWP/i3WKx
         2oMfLGBv3fIKsjaKVQK/+wKYOhzfSF2emf/RpNWnO85Q2gVhEyIWotmQPDNZS1B0cx39
         Vrxun+b8uHb/7du7VP0QtHJBi301ak6xQAGvXs/lMw0t4BLc30OqOe4mSnm4ueCrCDy0
         LcqN9T+9OouYBPibWw2fdYf2cj0TDBuzSl7Oz+l5yeOZSV3JQpxN98aRb5KJqdF6ctZr
         om7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [RFC PATCH v4 6/7] xen/pvh: Add memory map pointer to
 hvm_start_info struct
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
 <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <81b64427-4d4e-8758-436a-f2b98e3e6829@suse.com>
Date: Thu, 1 Mar 2018 08:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593671064225719544?=
X-GMAIL-MSGID: =?utf-8?q?1593719493790043599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 19:28, Maran Wilson wrote:
> The start info structure that is defined as part of the x86/HVM direct boot
> ABI and used for starting Xen PVH guests would be more versatile if it also
> included a way to pass information about the memory map to the guest. This
> would allow KVM guests to share the same entry point.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

I'm fine with this, but we need this change being accepted by the Xen
community first. So an Ack from Jan or Andrew is required as the same
change should be done on Xen side.

Juergen
