Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AB8JxZqOWcjEHqq7BUK5zfXRB+e17hnN3AKfWdKoi51KQ0XYlT2PU+0XsKmSp4e3YOJ3uFsmpDHL
ARC-Seal: i=1; a=rsa-sha256; t=1525339198; cv=none;
        d=google.com; s=arc-20160816;
        b=gbI82bE2Y7r1iWZY3ICwFTYXryCs2wnDBaggyiTjnUis203ClA4rF4f9f0ycCzqYBr
         bOsrwV9wBXDjSsR6NOIAkpl3uRaZ+zr8L39PVzNoNjFNqyUx/n14pxPITC/amljGFYe0
         VQ7U+UY/+cXqBZNkbN4+VyxoJAfpdAginmTrDbH8pN434j1O83U7JA88CHjhSUZPw1Dd
         Uc0faWlwNEtfKm0aXW9mWU0VWXgL/v0YcO6msTeEmX9ou6ZVE+nakwZ2HzAOqOISKah4
         WPkMbW3+c7YLOqCRet2jZQutIXntclg13n/vRhAqeAaNm3dAjVVVFFQyzjYLYVjmpHi7
         V5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:arc-authentication-results;
        bh=FrgCqz4wDSjBvFk8kbbt80IUg5BZAn5g4XYl5SX32IE=;
        b=lr/olNEv/iGx6/9wyVcNqhIyb3WZJMQm34zlY6mcJ5g8QJWyxq3wjusjPzwrHO4ADR
         OZcml6OEbDL947LsYRvNtYFd4fsNuAoHeiPQax4thLeQ87nkZ5XKKHXf31fY/BA2WaTI
         4j2gr1Ve17aKl+yraU8DQ1F8KenHxCca79oe4MSVOBfoLccw9BaCpuc/tZVcTinEv/UK
         Vfsg2zTbgd2wG4Jc7Ln4ije3Nru/DLTArtI7jvvn5c52Zn7LNjp386thcCdWR8PoZPZk
         KJ1gdF6rX7v9/wzFhgg5WxU9vaFvXTMkF4E6S8QomlRmapiD6Zcsh03B7kbjw0zRXZ/q
         eN5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
To: Wanpeng Li <kernellwp@gmail.com>, KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>, Dave Hansen
 <dave.hansen@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams
 <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
 Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <CANRm+CzKXA6ktG9fV4E-Q=+ZWZbS+ApUPXjogJJQErEZD2jHHQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9c228512-33b8-0df6-0c3e-4d30140d6579@redhat.com>
Date: Thu, 3 May 2018 11:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CzKXA6ktG9fV4E-Q=+ZWZbS+ApUPXjogJJQErEZD2jHHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1599434075524706108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 03:27, Wanpeng Li wrote:
> So for 1) guest->guest attacks 2) guest/ring3->host/ring3 attacks 3)
> guest/ring0->host/ring0 attacks, if IBPB is enough to protect these
> three scenarios and retpoline is not needed?

In theory yes, in practice if you want to do that IBPB is much more
expensive than retpolines, because you'd need an IBPB on vmexit or a
cache flush on vmentry.

Paolo
