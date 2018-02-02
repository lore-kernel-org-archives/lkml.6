Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x225bdTaScPYckK4jueELcsDPgGSXAuhSSU5YuQdIWq/ySVLwexdVgLyW4mlnDxi7QWuKW/KX
ARC-Seal: i=1; a=rsa-sha256; t=1517594603; cv=none;
        d=google.com; s=arc-20160816;
        b=E1J+eNKugHrOe++DZqkXX3rMOx9sviTOGfBBGJJJlF45svU30X5myDjwrBIkbdsHL8
         MW3Lbu35de8inh20P9mLNe+208QDkzDIUa5RzvqxpnwoCeu59wSR+s8E0L8vcK5n6gUd
         ek4lnzYNUdXZHW7GS/1gyexSaCGXrr88cMlibUetVG7fq072GD4W0pPx70dv/F6rQ7TY
         pVHDluOmhM6maMD/uBiGYDPCKwn+n7QhwARpEIIETiy93arzdpVsOf1T4DGlGts2rdV2
         +Gg3T5dfKqk5ok9Zo5hf8Jy/Iuep+IyAP+H4/YtyZlJr6HhpaPFyn1rPCZk40tnF9Z5r
         VOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=N9YL113VjIJhl3KXlZUphGbyGYmIbChV+fa8I5iquDg=;
        b=OSyJk2u3NERyoFnOgBD2WSIxEAz5RC4VbBZ/QUBL2h9toHxGRgHLu5y6x6JoUc0rBU
         JLNzkhkg32dQrX7eYgzvlPkW4HHZYU9ewu7doIE173CKQOuYuHjdGlXuddtXQBuNt7A8
         qYUqfiLkJxCoAoHaDwS4np3ns27GhdXx46DWlkJk3xC1kgGYr/6slus8x4wTTmcYxgAI
         eImsT7zPql3Q5WT/flz89BdeUV3iZpGXpghWtyza0KUL8oSd4twhWZ6AYxrq/beNjF9d
         2uUHMXKAjzLMAQQJBpA7VsjaiNTottwIK/euTSwpIHDwjv1/WuvPKN8ZBJ3qhJPlvZdH
         YIVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=h528EVQ0;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=h528EVQ0;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 13:02:53 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v6 5/5] KVM: SVM: Allow direct access to
 MSR_IA32_SPEC_CTRL
Message-ID: <20180202180253.GU28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-6-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517522386-18410-6-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020219
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237584685742413?=
X-GMAIL-MSGID: =?utf-8?q?1591313279061447222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:59:46PM +0100, KarimAllah Ahmed wrote:
> [ Based on a patch from Paolo Bonzini <pbonzini@redhat.com> ]
> 
> ... basically doing exactly what we do for VMX:
> 
> - Passthrough SPEC_CTRL to guests (if enabled in guest CPUID)
> - Save and restore SPEC_CTRL around VMExit and VMEntry only if the guest
>   actually used it.
> 
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> +	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },


This .always = [false|true] field keeps throwing me off.

So glad: https://www.spinics.net/lists/kvm/msg161606.html explains it better.
