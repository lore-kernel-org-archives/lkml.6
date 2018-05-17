Return-Path: <mchehab+samsung@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882526-1526551630-2-11610933986873967685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_SOFTFAIL 0.665, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.137.202.133', Host='bombadil.infradead.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: mchehab+samsung@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526551630; b=esD0RJxnel97ktjW5M9HgCaKCpw/uNj1kXH1znXI/T/eK54l61
    5v5raqJbMaG/al2Dop3k4mmWmW9ip6+8c4TtCMNAJ/npba0hUdzpOzNpdMB/j+p5
    iVFZyJoqFS3Lts7lCfmMklG/bMnUbTI7woYKr7yBn9liw6YNy9E3EexW4mviITBj
    EZKNGb42Q5005SopJHA4nt/SRnXNDjAsxrev9cwS85dVTJ/Hh+GkuYyxS6Pa1cdL
    O1+NbI3UGYBB0CSAyxMz4GhwidFcYB+EBuSNYJDb4hpKfjzm2yMtIKWsya/ZJZi+
    Cfh1jcrhvPmszbltcbJ9ANVRah3akJjbSraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding; s=fm2; t=1526551630; bh=a2UZYeQIkFRC
    yVJfKsu3XEzrcq5NbdXLGJxDtgX5u8Y=; b=IuIg158oRybV2ED6Ey8weUUti1TC
    LYxUGXTv7dzWlYvqXzvNNwYZ7GZeSdYvbZn7GlKRYOA/hGbregoETqDPlk9KpAku
    yooAZBcYPNQjY+ghXVe6ltXPvoofoBQVNxslQrVtsBUFHqkaBghTtPc/RlpDwnQv
    9+umARxR2XMDKV+SMiDpJ91wEluDAJVAR5uSfk85MvD7Q3xg83/3CYHnCthiGH0y
    Kr/ypEXG/yOxW9YpevhRnaCeLBrkntBKWzy73T+WOk/1y+K/WI2iQP33kcXtqQY8
    r18AJ+mD3lAUQy5CFMlyx2X3tyykWBkUYQoP4vVL3u5mowbezLr+hMbnSw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=infradead.org
    header.i=@infradead.org header.b=T1CsZ64g x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=fail (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.137.202.133 (bombadil.infradead.org);
    spf=softfail smtp.mailfrom=mchehab+samsung@kernel.org
    smtp.helo=bombadil.infradead.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=bombadil.infradead.org
    x-ptr-lookup=bombadil.infradead.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=infradead.org
      header.i=@infradead.org header.b=T1CsZ64g x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=fail (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.137.202.133 (bombadil.infradead.org);
    spf=softfail smtp.mailfrom=mchehab+samsung@kernel.org
      smtp.helo=bombadil.infradead.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=bombadil.infradead.org
      x-ptr-lookup=bombadil.infradead.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPN+tfKiaWh2LguQm9m2V/+TiFf58u9Y0Ammc4JrYJ9mDcCPwI/NF0GZDF/oC/esoQtokb4Lt3Zosb5fUszmtbj8Ey5pH9/peVrCn9f8/cBDb8OUJUpR
    q3w2rffq4fyZ6rxGNVYQIHrMSUyIiQWjdyJtxRYvyCTX97Ye/9FVwEvN2FBrABOJZeO/vL7Xtjf1UdKkJiR0dqirXtIb/h3dZ8w=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=MZxK/f14Qymj8qwS1R3mCQ==:117
    a=MZxK/f14Qymj8qwS1R3mCQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=rOUgymgbAAAA:8 a=my2xUEoKdJda6X_tMesA:9 a=CjuIK1q_8ugA:10
    a=MP9ZtiD8KjrkvI0BhSjB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Thu, 17 May 2018 07:06:57 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>,
 Alan Cox <alan@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: linux-next: manual merge of the staging tree with the v4l-dvb
 tree
Message-ID: <20180517070657.642d3784@vento.lan>
In-Reply-To: <20180517141727.3119e1da@canb.auug.org.au>
References: <20180517141727.3119e1da@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Thu, 17 May 2018 14:17:27 +1000
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/media/atomisp/TODO
> 
> between commit:
> 
>   51b8dc5163d2 ("media: staging: atomisp: Remove driver")
> 
> from the v4l-dvb tree and commit:
> 
>   1bd421154821 ("staging: atomisp: Augment TODO file with GPIO work item")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 

Hi Stephen,

What do you use in order to check it? Maybe we could have some git
hook running such check, in order to prevent merging patches without
the right SOBs.

Thanks,
Mauro
