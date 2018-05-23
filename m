Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AB8JxZrb4XAaUozdAV6Mmi82FA4vz3JBKh9qXYg4kI0Unt92X1JLnFi3lTs3swbDfR716OYVBDdP
ARC-Seal: i=1; a=rsa-sha256; t=1527103755; cv=none;
        d=google.com; s=arc-20160816;
        b=h+cZ/kSaxGixNg6xNn1CVIEPYsl2R3CkOR1WPchM7LVZ9F9OPhiVOMpmFgB+exilYd
         vVNumE0NUjy5f6BZrzaYOpIVdRR1Q0Zy9hqrFZmG9b3ghdEKONdXIJBmBvR9TxdlS/3P
         IVzORp1xPjLuE4NVevKeuzSDIlUYkey5XhJlxaiO3kAPizADb1OMrgChtZdHzLfzPcmy
         jZcrzw4OpVi1mPBpJoFFGk7Tm6KUPbIv4kljr/klosc0o/D3kRw7yM0Y4vDmJWLqNNXh
         ZMA68h7Np376+KfMo+DrcN2MgFqSHFLLuOvK7jFkTFUtNDSzCKUr0VhzLajjpZU9jnMh
         vvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DOFvpMmWj+HKvM5SUBRkkfdjZPpVoTYYDCRk5o0fMp4=;
        b=pHicWnauNO2QtpFkYRqqGY7zQITvbfo3ErHvjE9FWYHAI/WAhcNG5oFeIRKG2rubgV
         ezMs0syivPGKKWZb/9Xu93qUbsCNALKfaUwkujM3h15PlVSBJoqJvZi2QucF2QMv4um4
         THSgHIaKtd6tTG5M04LL/SG9fvnV8985a5+NmZyfqLxczTLxXzWNbxPRywmGm0gJzvE9
         MFDiE9CHuqBXtKba5iohqnfo+ZiIS6phE6Q9a12vGus2G0j4j0UGwMATGUerQdB86Ao6
         0Qpc/O+ue1Lqbe/rpRTDK2ByLFwse4GxkQVoIgYfC6Ng7mX+MksXiFQ6oZRPIaNlxO9K
         WSJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mhhh1U7l;
       spf=pass (google.com: domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mhhh1U7l;
       spf=pass (google.com: domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
In-Reply-To: <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org> <20180523164023.GA24671@rob-hp-laptop>
 <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 May 2018 14:28:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
Message-ID: <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, sdharia@quicinc.com, girishm@quicinc.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1601284347605293820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 1:11 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 23/05/18 17:40, Rob Herring wrote:
>>>
>>> +
>>> +- qcom,ngd-id
>>> +       Usage: required
>>> +       Value type: <u32>
>>> +       Definition: ngd instance id in the controller
>>
>> Why do you need this?
>>
> Please ignore my comment from previous reply.
>
> There are more than one instances of ngd in this slim controller.
> We need this to make sure we are programming the correct one.

Doesn't the parent-child relationship of devices on the bus provide
that? If you mean to provide consistent numbering to userspace, then
that's not a DT problem (nor one that Linux plans to solve).

> We also need this instance ID during powering it up using QMI.

Wouldn't that be a QMI ID?

Rob
