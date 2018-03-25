Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521983022; cv=none;
        d=google.com; s=arc-20160816;
        b=DhXDVEb6weFNolxFDy/DmsB6X/KRtpUXh1kWiKuYMnJzoYtCupFmYZHTpaQaPr8oeF
         e/+CuKoi41HzeQP56A9s5QsBYJZkw0r3NKFemIi3rI1NEyPFE+cp3bvX5eeVp7FIN/nX
         4+5qFfDq5DYSvEkF4KIZCgckqpy/E/TwayozLfXP2WJj1sBeaLSlF57B1dSxDSr4KrWP
         4MokPYi6h3bAQFHvB1Sr9zPTcDznV8Z8a6SAN/y3G7+mqNblg1jK/69W5CVrkJ0EK7nm
         O0VT4eh61IiI3vUtp0OEJb949fw8IKh5MK82xaguVqCEFWQJS1Qp1Uaf4jRSpdRAMEY2
         9zFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3wtziEwVKLBWkpNJ2pfBFo3GRsu/vXSUGI5UW4h1MR0=;
        b=q6RTwnN+an5GH7M9dACJP2gSuA/E1/3eLRNR5CspoeQ7YqCDA6b7DSbwSTNSbukHXd
         JbMLCxzqem/W28yNEd0O7OD9JTF4SvTHxqyftD9VHPrFLEeqFiAw3UcwHuvqmsgrfhxP
         3ZTwYsQh9awrXQLY8Z/nfTfNx4g2sfxZhg4+c9ENKM/LuD5ATQvZ9vqianVssEGeNGFh
         xYrAo/gqyVCaqolVBdRIG6dzDCaoZhsP3cQ+J8t6GwlDRLNW6F5NyxhZHT1wmQNfIbH/
         li5U5SAlxlq2IPMfzXtTeVgdCXP2aYCMIUOCGiHYbh2pqCkDo7OSVVe2cZav+rmoSg6M
         KSlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PsH00cHS;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PsH00cHS;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvwLmJtm4pALODPWzmn0TqpSpSs7YYFJdGOG76OSA2FgefStYCUhkrjlbOCfhisC3ue2naDHSBAR9Zjt4IdgBA=
MIME-Version: 1.0
In-Reply-To: <4e473a93-317a-5777-7444-6deb105c8f66@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com> <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
 <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com> <CAHp75VfJjCHd5U1D22NANLCA1kAoTKLnDGSQPj3ay6OhKSoZxg@mail.gmail.com>
 <4e473a93-317a-5777-7444-6deb105c8f66@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 25 Mar 2018 16:03:41 +0300
Message-ID: <CAHp75Vc0ok40nr0OXp4JcnQ77W_BK4PvDPtOY5ObkTXfwpW9cw@mail.gmail.com>
Subject: Re: [PATCH v4] staging: bcm2835-audio: Release resources on module_exit()
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Michael Zoran <mzoran@crowfest.net>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, devel@driverdev.osuosl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594075828670099193?=
X-GMAIL-MSGID: =?utf-8?q?1595914870178877119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 25, 2018 at 1:44 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> On 03/25/18 12:33, Andy Shevchenko wrote:
>> On Fri, Mar 23, 2018 at 9:22 PM, Kirill Marinushkin
>> <k.marinushkin@gmail.com> wrote:
>>> On 03/23/18 17:23, Andy Shevchenko wrote:
>>>> After addressing above, FWIW,
>>>>
>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Seems you missed my tag in new version.
>> When someone gives you a tag and you are going to send a new version
>> (w/o drastic changes), it's your responsibility to append it
>>
>> I will send a new mail with it, so, this time no need to resend. Just
>> keep it for the future contributions.
>>
>
> What is a "tag"?
> I added in-reply-to this email, I added you as CC.
> Isn't it enough to keep track of the versioning within a mailing list?
>
> Could you please clarify: what "tag" should I usually attach in addition?

Section 13) in Submitting Patches [1] explains that.

[1]: https://elixir.bootlin.com/linux/v4.16-rc6/source/Documentation/process/submitting-patches.rst

-- 
With Best Regards,
Andy Shevchenko
