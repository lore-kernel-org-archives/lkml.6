Return-Path: <kernel-hardening-return-13108-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZo17bQ5Lv2AaYU25KIPHAegfX6sXQiIU0HLkmbTGYOdcemX4S76VME3zczuenbhxljZqoBz
ARC-Seal: i=1; a=rsa-sha256; t=1524573573; cv=none;
        d=google.com; s=arc-20160816;
        b=ByT0b6+aFfxaJW4fRUWz5FNsyMwFzCBpRaRQz/iNPrdWJSQAS6r0+dh16kXChbWX9V
         AKLzVvlYDnHWDEgZIJs3+uLmqgJTiyiHS7EM2W8bd2OdlziPJqQ8NH//kBMCewZnry/1
         D3HsPmsG6lF5wRBMa7EXw4+Z5WD4lbF6LjiGeRBIiLVP50l5csNme+sLC03VEAWoR7VG
         7sB/4RNkwQg3ywF3uTrofA2055rUhrQ7LcawH6tfDRCv+mK81WszOV8qwMExHJugy9eP
         fbh0IE/Vorw0FTJvKdNclvGNzMHRpY/mpAAqAQa93LVkS808d8JrCfQws3Cwty/CIq5A
         AKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=5k3+52svuTUdaEOmMtJOQseXhUZJdmtrkWUdMfYTV78=;
        b=TQb9kwSKAG6M2moJVdWsY017iGLqGPdHXM2lY5pvU3yxMROfW7gl7U6Lc/8M2gtZk2
         tCEnT5zFz2f9ll7oFrnTQTSCdVXR4caXKh2Krew6JcJP7FSSle33Q1mFTuGAtJFIFWrp
         zn6RbFQb6RlbAONRAhlGzk1cWJ6dC2hxUMeNNnvazUqVc3mi7Dx6D6SPeq/bJW+ubFX0
         HKOCmgUdjAMcAqpOAJ7eY1zeUBY5WQ+n0dHymetEI2RAt0fnMJUNAQYJf4Bfh1DI0ucq
         +Uz6stivG1jFTBAW4olOiEJ+IWLkDl7JBOSMUQhpGazXimGgDuuu38I9+QKv2S50XYfd
         zPNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NofXWMWb;
       spf=pass (google.com: domain of kernel-hardening-return-13108-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13108-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NofXWMWb;
       spf=pass (google.com: domain of kernel-hardening-return-13108-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13108-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
To: lazytyped <lazytyped@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com, david@fromorbit.com,
 rppt@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <c5344284-f205-8465-0b04-f6da96e21609@gmail.com>
Date: Tue, 24 Apr 2018 16:39:11 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598631260072616198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 16:32, lazytyped wrote:
> 
> 
> On 4/24/18 1:50 PM, Matthew Wilcox wrote:
>> struct modifiable_data {
>> 	struct immutable_data *d;
>> 	...
>> };
>>
>> Then allocate a new pool, change d and destroy the old pool.
> 
> With the above, you have just shifted the target of the arbitrary write
> from the immutable data itself to the pointer to the immutable data, so
> got no security benefit.
> 
> The goal of the patch is to reduce the window when stuff is writeable,
> so that an arbitrary write is likely to hit the time when data is read-only.

Indeed, that was my - poorly explained, I admit it - idea.

For example, that's the reason why I am remapping one page at a time in 
a loop, instead of doing the whole array, to limit exposure and increase 
randomness.

WRT the implementation, I'm sure there are bugs that need squashing.

But if I have overlooked some aspect in the overall design, I need 
guidance, because i still do not see what I am missing :-(

--
igor
