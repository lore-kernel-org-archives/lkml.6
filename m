Return-Path: <kernel-hardening-return-13009-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/cIak7Nzh7JAYc7uqOwJjgB1m05KsVRRWgAiqWxO0Ps7gXMG1ITGh3YepO9T68/BnTWW+g
ARC-Seal: i=1; a=rsa-sha256; t=1523872069; cv=none;
        d=google.com; s=arc-20160816;
        b=FrQ69n240jQ1zbmYfBPukVqgw401EmLQWEAFFSSREc+Ki5R1wgV8NaKu25VEESJyrH
         258UfpuGpcAH9pJ7AL4CqSWgD7IF68b1sly/PnFUdB3ZPhF0JmFcmFZsVK7zTWjTbSAI
         HYKPpBT4qkzQ0KqjD2wmLJ3PUmY9Y4L+qqlidaqevpIxuHFiNA+E61ZGoXjEOiKzvp1d
         vxLJ8+htBdkkf88+ei4MbEFWJLoiae2AlFZjIKALfPSBxvMR2F631F/lj2Jucuw036xV
         Ahvfwx3qNTl5curA/ZtPpppLsK50jzTWKrMicX/MOodBLY3HFm1/yAHIJyLLKWZN7eAS
         5U/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qVIt6qIA/r6WPJvrrHjUryd1fwA9aLYINWbSr3L0Wag=;
        b=l5df2SuhUn4PQupLW1+/hShEiOFi9Fo5MCoi0J8LNz7eho2mnH52lW5tI3tptSNHbJ
         QhzU1Xxs5khO2jyK/cAUMG5/IyN2puavyFGb5QqAuIozeCJD+7ZFEWZ4kJVUlaKbC4Fr
         0OPs/7Ga2XE75ouAfh4J87ucNTbuiMRH2ZiTAgS/cj16LWeeAmXXUwbf+xLQHysS7m4v
         CUjF7pjvJUvwtDjvlb/kENUwklp9XIlJagk3z3Eu0Q7WKGGpFj4V/P45ZjUFMeN6n1MK
         F6vILucPmEiSWe2eIhkCNWvUGwWpHkmeOQeXyMcxQmyEOqiIAl7CFaCjGLWfQN0vv/nL
         b1bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13009-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13009-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13009-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13009-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] x86/xen: Remove use of VLAs
To: Laura Abbott <labbott@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180413221146.28476-1-labbott@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <49e13c53-718f-879c-fc0d-b0f5dd7ea23d@suse.com>
Date: Mon, 16 Apr 2018 10:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413221146.28476-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1597895679725346894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/04/18 00:11, Laura Abbott wrote:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. The few VLAs in use have an upper bound based on a size
> of 64K. This doesn't produce an excessively large stack so just switch
> the upper bound.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
