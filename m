Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELvbt+aHdUirSfM887Z7BUc0pfpwfDYyDkNUzcEsBYVW8WurMgKuuyEe/hFjM/YErx5Jz6G6
ARC-Seal: i=1; a=rsa-sha256; t=1519888908; cv=none;
        d=google.com; s=arc-20160816;
        b=lYKbP1pvAXkA9Wajyda3sRfD+EoSx7U5GNOaqNisQtNWUfMjO/LxGAFfDal81x49Ff
         xMHX/bZpDQ7qEbqRGyesC8ejdG32ZVelFWyW+4K0zl+hA6dxXN+OtHNYDFQlkvJZ3q0U
         KIVIw6d+D0YCWwb8xULqGPbgSsgi5qriyOXNRH3gt6Pg8t+hLDcItSbZBfn563IK+Ck3
         vAQlKF14da6zaRUCPUBASK+Z1qpB6YfsJ/mREWDtMK4UPNy1ed/FdYzN4yVipxAXpDyr
         /9NkRiRKc2mwvaDuu7kxNQrXoxwnKYUqpIh0QCRSVRm3g/N5KBY9kw9MCB68mIVO0bxZ
         JJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=DCMJGxAr1N8A9z9t8QpGpIUuvNEwG335OVa2ABvJtso=;
        b=Ih/gDRyy6/rz9cb2S4ZJKcOgLzgt9EF2soIifi5E9wYuttWwlfzBd/RwyDGr9ASIeu
         uYrNa4AD4WwfZR5kCiRnbxLGMozvOwvy6bHYFQ79p4CvCSgsc7MGwqZeqikSTGjFrrkI
         ai56WLb94D3Gkc4MTN7vp/4G5qrpDHwp53ME/zn983YaKAbx+Klwe/0mKbX0NaxLZdL0
         ZqM4bLKce/554qgXzbXgwGVB5Dnl7Axc+ShzHIpvZImd6tSY1hVkGCl/Ozes7z/5kp7B
         oNvK9bchHj2F+K/QULrPiiKHSqspXysEotFRzSP70WYR+ayz6121+1b4I6t1J6spZbf0
         dCuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [RFC PATCH v4 5/7] xen/pvh: Move Xen code for getting mem map via
 hcall out of common file
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
 <1519842483-8887-6-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <7095f9f1-c8b5-acae-44b4-4699a1e67c69@suse.com>
Date: Thu, 1 Mar 2018 08:21:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-6-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431984970161?=
X-GMAIL-MSGID: =?utf-8?q?1593719032478911102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 19:28, Maran Wilson wrote:
> We need to refactor PVH entry code so that support for other hypervisors
> like Qemu/KVM can be added more easily.
> 
> The original design for PVH entry in Xen guests relies on being able to
> obtain the memory map from the hypervisor using a hypercall. When we
> extend the PVH entry ABI to support other hypervisors like Qemu/KVM,
> a new mechanism will be added that allows the guest to get the memory
> map without needing to use hypercalls.
> 
> For Xen guests, the hypercall approach will still be supported. In
> preparation for adding support for other hypervisors, we can move the
> code that uses hypercalls into the Xen specific file. This will allow us
> to compile kernels in the future without CONFIG_XEN that are still capable
> of being booted as a Qemu/KVM guest via the PVH entry point.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
