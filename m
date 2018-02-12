Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AH8x227m7eSteXBE/Pb56rKAqfpqWuLFolJzDJSpCkXIGOpwgtchES24BOk37pKBiOJ7j+chEN9E
ARC-Seal: i=1; a=rsa-sha256; t=1518443484; cv=none;
        d=google.com; s=arc-20160816;
        b=VHBqKYAP6VlJVgGDMP2gt4t1Wooumr5wFqvsYQk+EqoczPLmp1FtUMl/4b0Wa6L2bm
         fC6/ZmYbJCRRdk1CrHit7fy6s4h+k6r8kKPGfDSFlKLi0Ne2suTrqy7ThOhy72oOXlni
         yNweRrw2ub2xDmqjnOpYA3XNJQsKgO8J/orduqjH4TE6tDS6TZW4/5dEcny0KQghA8yt
         x08NxFTydyuLZX9v4VzNOOgEybqYFbFBGXleM8NK5d7F8Hi2CZG2CTQ5YVnTwCy971WE
         Aq/jt4SeEnemXoaWW4zAe3DcQHtZUb7l40OC5yDiHeROi9Pt6UTA9bMGGqkUqRQIfsWe
         T1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=sSSSMsbZUtaJwk7xEo5whnpD8+CwQkZ4/DnKAlqckiM=;
        b=zrb9b80cGK3NAmaRK4Sym/oFEDvHSu+HOn0Vvl5IVeWWpOpM+Gp5h7TuCDAuqaXuzc
         qTIDrskLQRFCY/YuwbSengYR0v1OFT4NNNTFB5JN+HBUIEtJ8zyPUJvBJTqdjKbCuOHJ
         ve9oYsiMywPD3K8bI6+Fjn+mDRZQF2daQggBDEfh65gxMpDOIO8K++23UX5gMgegfjr0
         3tL5VcyT9xd881uCh/UFgASZBJHeUANQkm/4VVY4uqRvZTvfm+gsoQxM8bQGAiHkBZYU
         kw4+8WIIq1+ieuAzsso95bVfDJpVOtPqQAgVM0VQoNdPbGVdkDlQSayyXj4pF5AKgcOE
         e2cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
To: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, xen-devel@lists.xenproject.org
References: <20180207234923.13544-1-prarit@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <73fb2eb7-961a-6984-deb7-4efe5ed03a7c@suse.com>
Date: Mon, 12 Feb 2018 14:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207234923.13544-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591788037595473599?=
X-GMAIL-MSGID: =?utf-8?q?1592203395251950252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08/02/18 00:49, Prarit Bhargava wrote:
> The kernel panics on PV domains because native_smp_cpus_done() is
> only called for HVM domains.
> 
> Calculate __max_logical_packages for PV domains.
> 
> Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate")
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: xen-devel@lists.xenproject.org

Committed to xen.tip for-linus-4.16


Juergen
