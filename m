Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45DE214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJP8oQkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45DE214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLFPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:46:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40221 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLFPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:46:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so1140115edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wo6B9gWdF8W+uMN8G+2dYiZXU0atlDKHzeVHns1HkJ4=;
        b=WJP8oQkBqL0SmSPG0MyC0NbrBRmjrVfh4F4e56dzSs//jTB9NjjUC6i52ropPIkWGY
         c5usq/U24xhas/+4IhxB/2HGG756/YkSWhoXjRInznXBzP5sjQk53SFRRri08qVUfuep
         KXDRs/dHyU0TvRL6NbBXKkMUk+hvakopIwC/fQiYEE+tLfCRhSkUCjL0ATOisOezgvde
         PYhP10rUpTqWw1JWzlHG5/wEmqDVlaF7o/IRPdGY9z46rjhjZVd3XR9wSFtx9wYtSp3d
         CYRP8hre2UEqHR+fpfPxwjM8STwmuk41/r4RHdpI8VMJKweVobDxYlEVUxqNZ117FF5/
         0LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wo6B9gWdF8W+uMN8G+2dYiZXU0atlDKHzeVHns1HkJ4=;
        b=kB8NeGkC6EEyXnoQUF7hm1nZaUD40oZweRNSC3DiMuj16pGWkdDoSOuRsoFWhRLnej
         h0BeoL7BN1myYku0sUCCf2WGqGV5nED1ZunNutRCFWmCCD29dWzJtwRgippJrRVbULY9
         WlUcyIQJMkIOvrmgvr+4wU/3s8QDRs+3IrbigJsTbPU0SWLUdFsDXf6TD1j5xXvECNGU
         JhXOTymhnZ8Y8gE98Nq6YHxeuUPV+NU3XwMHz3YBbjkowPHYeneTGbgqlEAg+9oahhpv
         949D3bzExn6i5qVui31E/RzqHjHcs8usRy2DHcjdWj5K4fzUuJiCQhXGUXP0PJZdD9vf
         veqA==
X-Gm-Message-State: AA+aEWZtDZEXLvf2AfaNWXZvZwhOlaT+aB2EApTwNR6Z4yHHRXfJ5+3I
        ZVk1TUGybEk7l09cx7DrtqFSSNbh
X-Google-Smtp-Source: AFSGD/UOhPH+Ab+ThQQqWha56sEsomhmhsLHz1MAeIdC75jxo0mnBOjn272SDDe1M2xvGVvAI5pA+A==
X-Received: by 2002:a50:a844:: with SMTP id j62mr26311478edc.2.1544111166397;
        Thu, 06 Dec 2018 07:46:06 -0800 (PST)
Received: from dell.be.48ers.dk (d528f5fe4.static.telenet.be. [82.143.95.228])
        by smtp.gmail.com with ESMTPSA id e35sm274777eda.13.2018.12.06.07.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:46:05 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gUvqm-0002Fy-Pz; Thu, 06 Dec 2018 16:46:04 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for UUID"
References: <20181205211351.5309-1-peter@korsgaard.com>
        <1544086444.5492.1.camel@suse.com> <87a7ljyppx.fsf@dell.be.48ers.dk>
        <1544092087.5492.3.camel@suse.com>
Date:   Thu, 06 Dec 2018 16:46:04 +0100
In-Reply-To: <1544092087.5492.3.camel@suse.com> (Jean Delvare's message of
        "Thu, 06 Dec 2018 11:28:07 +0100")
Message-ID: <878t1264lf.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jean" == Jean Delvare <jdelvare@suse.com> writes:

Hi,

 >> I get that - but it changes the content of sysfs entries, breaking real
 >> systems - E.G. a user space ABI regression.

 > I know it's very convenient to play the "user-space ABI regression"
 > card whenever you want a change reverted.

Sorry, I am really not trying to be difficult here, but that is exactly
what it is. A kernel upgrade broke working systems :/


 > However the interface itself did not change. The sysfs file name did
 > not change, the nature of its contents did not change. The only thing
 > which changed is the exact contents details of the file. In my
 > opinion that does not qualify as an "ABI regression".

The binary content of the sysfs file changed, and the change caused
working software to no longer work.

I get that my software is is not very commonly used. If this change
would have broken ps or top or any other well known utility looking in
/proc or /sys I guess we wouldn't have this discussion at all, but it is
still a regression.


 >> It is a cosmetic code change in the sense that no known software was
 >> broken with the upper case characters.

 > It bothered someone enough to create a ticket asking me to fix it in
 > dmidecode:
 > https://savannah.nongnu.org/bugs/index.php?53569

Yes, I am aware of that.


 > And it wouldn't make sense that the kernel uses a different format from
 > dmidecode.

I would personally be quite wary of such change for both dmidecode and
the kernel because of the risk of breaking existing utilities. I see
that Petter Reinholdtsen has the same concerns:

https://lists.nongnu.org/archive/html/dmidecode-devel/2018-04/msg00001.html

But ok, not my choice to make. I also get that dmidecode doesn't have
the same no-regression policy for its output as the kernel has.



 >> > If "cryptsetup luksOpen" does not lowercase digits before computing its
 >> > key passphrase, then it's not RFC 4122-compliant and should be fixed.
 >> 
 >> cryptsetup naturally doesn't know anything about RFC 4122. It just reads
 >> a disk encryption keyphrase which happen to include the content of
 >> id/product_uuid because of my scripts.

 > OK, so basically your script infringes RFC 4122, and instead of fixing
 > that, you ask me to stop respecting that RFC on my side.

To be clear, the RFC states:

The formal definition of the UUID string representation is
provided by the following ABNF:

hexDigit =
            "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9" /
            "a" / "b" / "c" / "d" / "e" / "f" /
            "A" / "B" / "C" / "D" / "E" / "F"

(E.G. lower case AND upper case)

And:

The hexadecimal values "a" through "f" are output as lower case
characters and are case insensitive on input.

So in other words, no conforming implementation should have any issues
handling an upper case UUID string, and the change to lower case was for
cosmetic reasons rather than to fix a parsing issue with conforming
software.


 > Out of curiosity, what's the purpose of your encryption strategy? That
 > someone who would open your computer and steal only the disk (as
 > opposed to stealing the whole computer) would be unable to read the
 > disk's contents? Do thieves really do that?


The systems are locked down, so they cannot (easily) be tricked into
revealing their secrets at runtime or boot non-trusted software. The
disk encryption protects against somebody moving the disk to another
machine and reading the secrets.

I agree that a better solution may be to store the per-device key
in E.G. a TPM instead, but that was not available for all use cases.



 >> > Nak. This is too late. Changing it again would just add confusion.
 >> 
 >> Please reconsider. 4.17 is from June, and 4.19 has only recently become
 >> LTS.

 > I can't see how this is related with kernel 4.19 becoming LTS.

Only in the sense that that LTS kernels see wider use than non-LTS
kernels (E.G. I discovered this when moving from 4.14.x to 4.19.x).


 > Look, you can imagine that I was perfectly aware of what I was doing
 > when I made that change, and that I pondered the decision carefully at
 > that time. And my decision was that the change should be made. As far
 > as I'm concerned, this ship has sailed already, sorry.

Sorry, what is the perceived risk of reverting this change? Just the
minor inconsistency between the dmidecode and sysfs output? As stated
above, the RFC requires conforming parsers to handle upper case as well.

-- 
Bye, Peter Korsgaard
