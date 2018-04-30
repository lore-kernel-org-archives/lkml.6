Return-Path: <airman.price@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525122150; cv=none;
        d=google.com; s=arc-20160816;
        b=phSgtUkaJJ75uukWCvPfal6mU6NPTC0ghZwD1vrzC7Wp6Sqd1ndOqmVBkk7H1dDhRb
         7HxAdMPPBla/vR7RqxCqVba6lQTZSxn1KLw3iN7y92i0ate60NUSr2l5M2SCMk+T8LQ8
         4KcRGk+ivsiUBIMo/w+zV9QLftyx1cVt/QEG6L8zmEGeL17iw63lV1SO1VVQ8x/C/P40
         vM16nLzI0NBURwK2Xoy5ssVWXGivsv+ACtMD41gFkn/B5q3dZ0ZO6m4S0Iz7RBfVwdVk
         rz1Uldiffxs9IxHnrF2/7c9YaNaKI6FqMuaU5+LHUiY1+qx9tu6fF165MgK+QNNYO1NU
         wBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=k26vyxh1s+XoxrfIsRAlRA9n3x441tR8947GwTfqHXU=;
        b=tdN/jcHk46aYpT3Zudw64SOQV1CI/btMacdP8xI+ipXJ9dMjtepe53Gm5PfXuMmdTN
         6xunkhskAeliOrqgWrU2ENcqWWFiSORGUJZc0jaY7mEO0f9bB+B/zQrmwPodRzdd0eBG
         fhcandlq0tSde/UgkOXRdBD5e7Q3J+QcT3WnMRXtO77rMHOc9WvkXaKFAC6tksQic5qE
         fKOeTDd+4qxPXnrSZK8/qhU7ax5QNYze9/QFRoxpDL2kgaFI5aMpLrXSIPPqCDySqtTI
         28mmQBdjInR1V/OWDzPLn73HEPVPOywdNwfUYuwted4i2V1O2Wz6wwiMY3qzV9oQuKe9
         eEoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RsR7syqF;
       spf=pass (google.com: domain of airman.price@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=airman.price@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RsR7syqF;
       spf=pass (google.com: domain of airman.price@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=airman.price@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpLC+83khH8b0ZDQmzJAWqOXn6CaLaC0BqJpqNgjPNQL4XfmcvPLWN3zGWQy4+E7+WrY68CTqRiN5s4YxdovZE=
MIME-Version: 1.0
In-Reply-To: <20180429155924.GA28565@kroah.com>
References: <CAMB+E4gS=F8kXMNTtKdLr9y-C_+NaSPQm3M1m9xC0Sbhn+hjYw@mail.gmail.com>
 <20180429155924.GA28565@kroah.com>
From: Gregory Panic <airman.price@gmail.com>
Date: Mon, 30 Apr 2018 17:02:01 -0400
Message-ID: <CAMB+E4g629=uUnT9DToSxTs0SH+toQbbYRwOsSsFsY9vYxDOrw@mail.gmail.com>
Subject: Re: RW GDT replaced by Read-Only GDT and a GPL Interface
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599206483626612187?=
X-GMAIL-MSGID: =?utf-8?q?1599206483626612187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 11:59 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 17, 2018 at 05:33:25PM -0400, Gregory Panic wrote:
>> Hi,
>>
>> I have been working on a VMX driver for a custom hypervisor which
>> depends on features that KVM is not built for.  Up until recently
>> (4.12.x), our module has been working just fine.  When we started to
>> build support for Ubuntu 18.04 (4.15.x+), we ran into an issue.
>>
>> Unfortunately the following commits broke functionality, causing
>> kernel segfaults, due to a placing the GDT in the FIXMAP area, and
>> setting that mapping to Read-Only.
>> #69218e47994da614e7af600bf06887750ab6657a
>> and
>> #45fc8757d1d2128e342b4e7ef39adedf7752faac
>>
>> Up until now, the GDT has been Read-Write, which allowed for resetting
>> the TSS to available, and then Reloading it after a VMExit.  The KVM
>> and Xen work-arounds for this were implemented by creating a GPL'd
>> interface to remap the GDT to the original Read/Write mapping and then
>> back.
>>
>> Up to this point we've been able to maintain independence from GPL,
>
> As has been stated numberous times, the lack of EXPORT_SYMBOL_GPL() does
> NOT mean that the interface you are using is not covered under the GPL
> license of the kernel.
>
> Please consult with an IP lawyer for the details if you are interested.
>
> Best of luck with your driver!
>
> greg k-h


I concede that the lack of EXPORT_SYMBOL_GPL may not imply lack of
coverage by the GPL.

However, let me clarify my issue with these patches.

These patches explicitly REMOVE a previously working (architecture-level)
functionality and seemingly PURPOSEFULLY breaks proprietary modules.

There is no middle-ground as a result of this patch.  For VMX drivers under
Linux you must now either GPL your code or subvert the security of the kernel.
This is not a good place to be.


The operation in particular is the clearing of the TSS busy bit.  This
is a primitive
operation that is well defined in the intel developers manual, and one that must
be done upon a VMExit so that the TR can be reloaded.  This can no longer be
accomplished by proprietary drivers under Linux due to its R/O GDT - except by
using an explicitly GPL'd interface.


A colleague suggested an alternative patch would be to implement a primitive
interface to clear the TSS busy bit that does not result in derivative works.

// returns previous value, or -1 if no TSS there
int change_tss_busy(uint16_t selector, bool busy);

-- 
Gregory
