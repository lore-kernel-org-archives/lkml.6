Return-Path: <jbeulich@suse.com>
X-Google-Smtp-Source: AG47ELsDEgsz+84zGHj5+D8+IFUvPHNtVdKXWDDEOy+KD0ouMW8x3F2G1In3Kp74iZaWvN1mE8M6
ARC-Seal: i=1; a=rsa-sha256; t=1519890123; cv=none;
        d=google.com; s=arc-20160816;
        b=cAjkp+QYNa6NL80Tukg0UFbJ5VdCUNq9wm1YDeeOIJbqleCBKixDXqzt3KlncgGUwr
         AnJC3cdQ9EsKkyLb4L0ETo/nmgFwoooVHiu8kq9MRZF5yWeQfJkfpGIXruaaW6dMuLsJ
         YG8TeNYpGkWMnzgrExgrrkwDFLQbVQ/UdiKqPlK3DOkjAq7TP43iTREIEwBnRNQy8+uM
         O7djvJ92fo7LwK4uDxtsev7WwXvkJM/oDBQk0CzhLCvw9zXgQGLQJJh4uViV4hhNC38s
         r2CddMPGr6UJrUh7iF4KUFvU3g2EEti3H5qXxLvXznbu8uPsX6X2BI9E15PmVlybWm7Z
         VhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:content-transfer-encoding:mime-version
         :in-reply-to:references:subject:cc:to:from:date:message-id
         :arc-authentication-results;
        bh=tFP13zhx08m/9IyfuBn5yudmJbO/cOkutJq113rd1v8=;
        b=nXbRHEoVTWn+hVLxYQjWxMmwiU0rKcVG+e1djWPvXoOAkEMlXktCYv5M9nJqFTZGDe
         QGLPtcJtJSDnn6u3qvt0cWFQpcgVHJRrW9JCIfk13VwceEscSt+h2UArof7cAnQyB7dl
         SxywjOBNTEvjZqRJvMPnu9Fv9TP7S60235ZcVr7L0zqI+ADs2piyDFb4NkuSqYeiteKa
         nOLM4JZitsFPt/Ozav2/oxV3DH0aYFPtHGcC8HjxsZN+Ha1U6hMDIglZxRwSLvAwEUwu
         22aydBkLhzc/E2OqtWCC1+Vs0TgaZPSmaM2Lws+RH8B0kpu2D+oAyKIg5LsaYvvFrrEn
         lMWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jbeulich@suse.com designates 137.65.248.74 as permitted sender) smtp.mailfrom=jbeulich@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jbeulich@suse.com designates 137.65.248.74 as permitted sender) smtp.mailfrom=jbeulich@suse.com
Message-Id: <5A97AEC70200007800128C14@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 01 Mar 2018 00:41:59 -0700
From: "Jan Beulich" <jbeulich@suse.com>
To: <maran.wilson@oracle.com>,"Juergen Gross" <jgross@suse.com>
Cc: <thomas.lendacky@amd.com>,<andrew.cooper3@citrix.com>,
 <roger.pau@citrix.com>, <davem@davemloft.net>, <hch@infradead.org>,
 <rdunlap@infradead.org>, <luto@kernel.org>, <mchehab@kernel.org>,
 <x86@kernel.org>, <linus.walleij@linaro.org>, <tglx@linutronix.de>,
 <dave.hansen@linux.intel.com>, <kirill.shutemov@linux.intel.com>,
 <gregkh@linuxfoundation.org>, <xen-devel@lists.xenproject.org>,
 <boris.ostrovsky@oracle.com>, <jpoimboe@redhat.com>,
 <mingo@redhat.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
 <bp@suse.de>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hpa@zytor.com>
Subject: Re: [RFC PATCH v4 6/7] xen/pvh: Add memory map pointer to
 hvm_start_info struct
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
 <81b64427-4d4e-8758-436a-f2b98e3e6829@suse.com>
In-Reply-To: <81b64427-4d4e-8758-436a-f2b98e3e6829@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593671064225719544?=
X-GMAIL-MSGID: =?utf-8?q?1593720306097030541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>>> Juergen Gross <jgross@suse.com> 03/01/18 8:29 AM >>>
>On 28/02/18 19:28, Maran Wilson wrote:
>> The start info structure that is defined as part of the x86/HVM direct =
boot
>> ABI and used for starting Xen PVH guests would be more versatile if it =
also
>> included a way to pass information about the memory map to the guest. =
This
>> would allow KVM guests to share the same entry point.
>>=20
>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
>
>I'm fine with this, but we need this change being accepted by the Xen
>community first. So an Ack from Jan or Andrew is required as the same
>change should be done on Xen side.

And for an ack to be given I continue to demand that a patch be sent =
against
the Xen tree. That said, the change looks fine to me now (as indicated =
before).

Jan
