Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AG47ELs6y4BsJfMQI1hk5Ih5dTdCibjxxPE0CsM34AmOlMqeCo/HRHPezFL5KLg+pcywAQnZyDwj
ARC-Seal: i=1; a=rsa-sha256; t=1519853737; cv=none;
        d=google.com; s=arc-20160816;
        b=Ydw+xNqwb+fmuDuQdpjid0PXLNh4zRAFyhYi0/E3iZWUqVujJRB2ljnOxYcVvfLztb
         EBd70286yit5Yp4hCKsRmkIZ4q89RsyeNX9UPgdnyDMlz3nJLXLipPkco5cicOoUHKyV
         WEmNWIm2Ayt5Wyc+8/CVErPXDPg9+ZjyI9CKzdfhYnDE+pHbokQoG7mXaoe4K3ik6nrS
         pNk1P9U9rJXXKmPwpuoAnUs8ReFIz0H+C1D4MQ+3/SEp1sDCKGwcafFBhf8/F1b3xu3k
         nitOu5/XV+6dLjfpOrtDBn/21MZw8r4jb6eleQHHipxhLizuyeI6VlnB8U8SzmKh+5pE
         vG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SfdizMlv7E7EL76AqxyBna6bHOjmKqtR6eHUrHfmjb4=;
        b=bWfc0Q5ZttMuMtVrtCJvhTytfsjOM1Sy3pFnY0LhxvE0XZJeu60/9q7q9bQxZ80h61
         +8OLk51otGR7qV6nFWCAq6Fbjy4/SzhBD0VU1GqcIV2Lmpji4ZjBTL4MyBzhvVRNhpTE
         iMA3j6FHF4wCYoY7y/hi/zw4mN8Xu0NASET4m+yIJX90tP0hrnwt6cyYCRHajZQnYzZz
         V+O8a8BR1u6YEGxdgTjv18B9jAjrjuFWZBfol/U5uVCYyXYHvujxyRcPnUGov7nRtHjj
         mUhPN2UK9N6RzezePiqGYEpMvCZCFM0AXZm54/+tLbIDFMaG1NK+4uM2JkkSq0mjdVok
         6ddg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [Xen-devel] [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out
 of Xen specific tree
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Maran Wilson <maran.wilson@oracle.com>
Cc: jgross@suse.com, boris.ostrovsky@oracle.com, roger.pau@citrix.com,
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
Date: Wed, 28 Feb 2018 22:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228210814.GK11576@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593682153155462084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/2018 22:08, Konrad Rzeszutek Wilk wrote:
> +obj-$(CONFIG_XEN_PVH) += pvh.o
> +obj-$(CONFIG_XEN_PVH) += pvh-head.o
> +

Probably a better place for these would be
arch/x86/platform/pvh/{enlighten.c,head.S}.  (Just because there are no
.c or .S files in arch/x86).  Maybe Xen ought to be moved under
arch/x86/platform too.

Paolo
