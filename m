Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521986014; cv=none;
        d=google.com; s=arc-20160816;
        b=QJCWRVG0v2ylii05rm42PHv5zTWhOdNsi2w0m3w5Y1f00Wv6GUKpknyebdXM7WFL7K
         FPeGDtAGhKYPad5ipezo7KOHSZUnBN0DQjPV2zj9RSEpCAtV2GRly9YBx303xF3C/5tV
         hA5bqoHLLel7GGFvancT+v1oWQ3N2J0DRAwP/74lf+MTs/4jsdnY83uqMZ0Z0gx6ADqY
         ZoZu5nYUF7NeL0umBMQ5XJecRw38aw6F+CGv8U5//3ud6NyVb+/HE/3IZeuyBZDJoxk3
         8R5vszmvFFsLZdynTc9gugZLz9IQOsDIobGPHOi49Krnu3oSHqAjo/v0Xe7T0gL5VMCf
         GSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=aRN7uevncaoQwLryoFdNRXl5ZSA5weeE32bHXXaZayw=;
        b=fepsNyTArsRKWWo61AggLyt52ZUP7VwzD3cRJ27h0gWwbD2n8MONlom+RsfVxiMABE
         yT1Mt0k3IOYXFNKY6WCdZXaP+s8/g++kXrTes4doGesFSLYM+MY0dr15INunWXxXqFwq
         TJwXHkA1QVR41KFy/xZW7SYqx/vCYKOLaxxoHaVIdy3DuD/gVVFPTit5Sc8TKrjwNszU
         W6v0wk4T6BPtRmjg2fSCGQl4P1UL9zBz9XDxvKRo9nwMMEtO8KZQX+xnza5jtFDWFzFR
         qJbNXcBMu5/OhKRPnV2vbYLZfvVXfO7NlS5PDw6XddBfmqadsoUX1dsTy8RKwwfojC+P
         tqVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=diA9StqH;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=diA9StqH;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvyK2pX8kjoK1BIwvX8snvDKFDoHZxds/s6K17nZhIkUVv4gXGaGmSkO/fm02Ou00SFU6V/GQ==
Subject: Re: [PATCH v4] staging: bcm2835-audio: Release resources on
 module_exit()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Michael Zoran <mzoran@crowfest.net>, linux-rpi-kernel@lists.infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 devel@driverdev.osuosl.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
 <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
 <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com>
 <CAHp75VfJjCHd5U1D22NANLCA1kAoTKLnDGSQPj3ay6OhKSoZxg@mail.gmail.com>
 <4e473a93-317a-5777-7444-6deb105c8f66@gmail.com>
 <CAHp75Vc0ok40nr0OXp4JcnQ77W_BK4PvDPtOY5ObkTXfwpW9cw@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <864c8503-0226-80cf-0140-9e9e33882b22@gmail.com>
Date: Sun, 25 Mar 2018 15:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc0ok40nr0OXp4JcnQ77W_BK4PvDPtOY5ObkTXfwpW9cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594075828670099193?=
X-GMAIL-MSGID: =?utf-8?q?1595918006798049042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/25/18 15:03, Andy Shevchenko wrote:
> On Sun, Mar 25, 2018 at 1:44 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> On 03/25/18 12:33, Andy Shevchenko wrote:
>>> On Fri, Mar 23, 2018 at 9:22 PM, Kirill Marinushkin
>>> <k.marinushkin@gmail.com> wrote:
>>>> On 03/23/18 17:23, Andy Shevchenko wrote:
>>>>> After addressing above, FWIW,
>>>>>
>>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Seems you missed my tag in new version.
>>> When someone gives you a tag and you are going to send a new version
>>> (w/o drastic changes), it's your responsibility to append it
>>>
>>> I will send a new mail with it, so, this time no need to resend. Just
>>> keep it for the future contributions.
>>>
>> What is a "tag"?
>> I added in-reply-to this email, I added you as CC.
>> Isn't it enough to keep track of the versioning within a mailing list?
>>
>> Could you please clarify: what "tag" should I usually attach in addition?
> Section 13) in Submitting Patches [1] explains that.
>
> [1]: https://elixir.bootlin.com/linux/v4.16-rc6/source/Documentation/process/submitting-patches.rst
>

Thanks!
