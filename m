Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELt8xAEQBSRaDokl7HS6w0J9kCIpLUyHgruHLgxnN7QtYg+S5+A+6EzCThzrD9xRAbUhT/Iv
ARC-Seal: i=1; a=rsa-sha256; t=1519888834; cv=none;
        d=google.com; s=arc-20160816;
        b=y0o+qrr7dfHdvH5jz6wXZwNUQmUK/8C54WsXnRjAZW3TjZlkN1SzQP0YvsPyhzQuk3
         K35NFH61eWsgdFD7TmoYeJ19CBbWXwSSRYXEkhVThiwC1W5sx5QqG4Ob+xN+ZY8DJ37M
         gTbu2KIkpBfISNKo+vT5ur1l/yKJo67Gm1QInuczMB2lXvxV0TChi50g0OA9pAWmVEB7
         m8oigBneI/RF+hntaro99zGO3JKBmWG20YeWnCSqGZrtJERcFt2b3E6aNIr1Xi1uT3wy
         IWDqurppdjhfFBkYbXSi83rlfE5HJGaelsWIXv1/WllJaqbhF0cMaCFkeQBlDUkz0y/+
         Hhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=srnwiZDcnML3CN5RuxnGa1Y9LGMJb78Cn+2n7KLjr0k=;
        b=X3c6HIeMrXNTimHExeCg5Zv38GaVeaBX8khHiVtE+xR/M7UJQzF+JsYrS6Lg1FHfpE
         SIW0qV3C1PbAvTAQXqnXh7yO17uz2jCyofWcdjdv3/c1FEW/Sq+0fddi1LjLQvDIS+Zf
         YB2+ftXW1jJI0reNAGJEQSHVcsBgASRxca/NsddRP1UdWp/3ZsrhdZL34RASKAVKYSyO
         BbJ+zFjQA+l+6VyZzn9AyrGUdkCelL7AJDzTSDrJwf5foGJl8e4MhRVzSoIockq6a+Cq
         7Whw4Fs+vcn5JHlBs6UEze9WnGDXz6l/Gcz3CAHdDepGGkXIt2A0NvtZnt15bfFWWDQ2
         CoIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [RFC PATCH v4 4/7] xen/pvh: Move Xen specific PVH VM
 initialization out of common code
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
 <1519842483-8887-5-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <af2b37f0-b048-bf8e-525c-b9fa4fac7fc0@suse.com>
Date: Thu, 1 Mar 2018 08:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-5-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670492940069413?=
X-GMAIL-MSGID: =?utf-8?q?1593718954347019793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 19:28, Maran Wilson wrote:
> We need to refactor PVH entry code so that support for other hypervisors
> like Qemu/KVM can be added more easily.
> 
> This patch moves the small block of code used for initializing Xen PVH
> virtual machines into the Xen specific file. This initialization is not
> going to be needed for Qemu/KVM guests. Moving it out of the common file
> is going to allow us to compile kernels in the future without CONFIG_XEN
> that are still capable of being booted as a Qemu/KVM guest via the PVH
> entry point.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
