Return-Path: <gkohli@codeaurora.org>
X-Google-Smtp-Source: AG47ELt1r4az1nPuerPhmLhlSX1bNPgwYGKSF/CqkyX3JJUgmfx2ez3/ZcFP9+e5KSHheGi4M596
ARC-Seal: i=1; a=rsa-sha256; t=1520249998; cv=none;
        d=google.com; s=arc-20160816;
        b=G7GBPjJ6e2CEJ0+eaVl3r+2iaDN6yex3bcFlcxzjnAKwte3mTXW3n1S0CNI3RzSdte
         yPI26oag5QKpfQ7j1gitXXw4kbj7zLUstp9VcVtACp1DnQOZ/wzeOo2RJiqpvl8DgmX0
         rhvrgq7J2gO7VARyutuzhk9vRBuVyreXH4zW97KVo3l0dpj44FxmSdzjB4zpXezPC6y6
         DvaGRdvsCd1vk1XtEYHebuMzR0Lr9W77iGB1a7m/6nZ053nbLWw4LQUZnrGb71QGRQdv
         kygZxNfLiUYI2tSk3QvLy5NjbmfTCvVQM6HrXiQc5o/HFjEOuwzyDuvVSAX74wCh0Pg8
         u2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=sCcucBVRfdiClkS4m7lpfMq+XjYIm1o/pTIKfDIYKYY=;
        b=rPpwUjM5cNVNAOqh3WipGcYz7Gos9Bytj97FctuCE9HCn15nCrEEAirwj1/cnBhbeE
         +7Xb6OxFn7OV48u9Z22Ck7L8/OkOALE3Igoo0vunsChlyEQoLbHxGX7Fmi8hp6wtrqF1
         Kj52j/l70D0/KC/peSay5vk96jOm8jMtrR5g4/DBc9Ke7eZM5TDMiMBZThFHycRCwm1i
         G8xNTekhB4Jq0BFVeqIQZ9blHErrqB2SRSZSefCJr4/+q/gmHyYBRxkvWTDEFfL2wrDu
         fQg8E2ydBXUtWZd/zEJ6gA2kh+gBZ0qB0AK7GZnOyFAVYVy5EFWxWNLp1itLbRMvq1eX
         I/xA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BMrP7s33;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MNrZFzqw;
       spf=pass (google.com: domain of gkohli@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=gkohli@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BMrP7s33;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MNrZFzqw;
       spf=pass (google.com: domain of gkohli@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=gkohli@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A2BC60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: Query:Regarding object poison overwritten in binder_transaction
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Riley Andrews <riandrews@android.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <4d2b6014-ea76-b489-fdde-2e058e2fac4d@codeaurora.org>
 <760538e9-dd50-6cd3-1268-bb535eb363d0@codeaurora.org>
 <20180303192736.GA22510@kroah.com>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <55a473e8-a2eb-f4d4-3d9d-d37254e18f8c@codeaurora.org>
Date: Mon, 5 Mar 2018 17:09:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303192736.GA22510@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593905383140578023?=
X-GMAIL-MSGID: =?utf-8?q?1594097662394690934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Greg,

I will check the common tree, and it seems to me a new bug , will file a 
bug if won't be able to

resolve from android-common tree.

Regards

Gaurav


On 3/4/2018 12:57 AM, Greg Kroah-Hartman wrote:
> On Sat, Mar 03, 2018 at 08:22:35PM +0530, Kohli, Gaurav wrote:
>> HI ,
>>
>> Is there any known issue of slab poisoning in binder_transaction variable on kernel 4.9,
> If you are using binder in an Android device with 4.9, please use the
> version in the android-common tree, as it has all of the newer features
> backported properly there.  You will need that for newer Android systems
> (like Android O and newer) anyway, so please try that tree.  If you
> still have problems there, please file a bug in AOSP.
>
> thanks,
>
> greg k-h

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
