Return-Path: <SRS0=Cmn8=GK=gmail.com=jiangshanlai@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1105679-1521540304-2-13103349693199430957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=Cmn8=GK=gmail.com=jiangshanlai@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521540303; b=bG+hx4L5N0E0PYAVJJEaVPC0cQMQ1vlhGHvfOuQEO1BGxDf
    tk6acDxTK54AXPwfa+054vdvtpkDytNY1zm6aUHwLV7yFGZ96gdm8Sems5ru2RhB
    ZCqQso3Cyw4pxMLmy5y1kqBgLum1hgvMdKkxv9RhlGj4bW/d8lG2ODqEUXHgLzBw
    x4JAYrleS2+ZaCxd35A9P7J5l7lBS9NgOHCDRFMfRpfWey/4l1f4rB+f4vOKyx9D
    cmBLBpNuc5OnUYkkX3W1k+DY4yhaAqk2Xtaf0/Jh0t16fdh/9gN/pi4ghl/4a3NN
    g4mEQvRA3JE7TIPijgJIY2AUjMluVbeO3VgoC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1521540303; bh=XxPPZCaEeCF09WVnXne+b4KRglvDw/zqyitE9d
    xvLQ4=; b=vw/Gbu1YV9I8TcPscJaFg0+gCw6Ex12t+3N7KGlFPjOM7XsE7KslPd
    7/sK+DWck0Pn97p1jyNwd/jKSVGYDxhcUogN+HHfDtipdyaNruQACxdoono322CY
    36DUPAwbscF6ZWqVmb9ge3QPjBseAuIxiLds9lX5nhQGxdzkpckUlocJBoCO140R
    wvgN7OEcMucAWSPyYhLU/OCbVspk2/QnMwMlWZK5ePSCvr4JpC24eJSY4OANOfVt
    D+KtekNN1qGADLr7+WlL6slGGbPmKCfkD07gG5Q5pGe15gJfdhp2QZmqFhcO+t8O
    P6/hOjRrB9N3t+AwJefPuKXsBJjIUV3Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dW7pgaFa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Cmn8=GK=gmail.com=jiangshanlai@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rdqlhm1z;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dW7pgaFa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Cmn8=GK=gmail.com=jiangshanlai@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rdqlhm1z;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65F12177A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jiangshanlai@gmail.com
X-Google-Smtp-Source: AG47ELu111Lx4dr8ne6zmIVTOvpZTvDTG2jrX3j11TfMmKcB6OgfT6OwN+3X4liWp07la5zZvWea75QB4DBMqxwd+Pk=
MIME-Version: 1.0
Sender: jiangshanlai@gmail.com
In-Reply-To: <20180319164523.GB519464@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org> <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-6-tj@kernel.org> <CAJhGHyA3zte-0MWGC+DrOptprHBRroCn8fHM678iVnb-1VStLA@mail.gmail.com>
 <20180319164523.GB519464@devbig577.frc2.facebook.com>
From: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date: Tue, 20 Mar 2018 18:04:59 +0800
X-Google-Sender-Auth: R4ld3nbUJshZK4TUsUIxzmcLnfU
Message-ID: <CAJhGHyCMx-8cUzJ=_cFb4YWNXT4=HANH4CUTNRVG38YG3oc7MQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] RCU, workqueue: Implement rcu_work
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Benjamin LaHaise <bcrl@kvack.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 12:45 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Lai.
>
> On Fri, Mar 16, 2018 at 02:01:35PM +0800, Lai Jiangshan wrote:
>> > +bool flush_rcu_work(struct rcu_work *rwork)
>> > +{
>> > +       if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
>> > +               rcu_barrier();
>> > +               flush_work(&rwork->work);
>> > +               return true;
>>
>> A possible tiny improvement: check if it was already queued on wq.
>> For example:
>>
>>        if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
>>                if (!flush_work(&rwork->work)) {
>>                       rcu_barrier();
>>                       flush_work(&rwork->work);
>>                }
>>                return true;
>
> But this breaks the guarantee that flush_work waits for the latest
> queueing instance.  Please consider the following scenario.

Oh, I'm sorry I was wrong. It is so evident that
"flush_work(&rwork->work) return true"
doesn't equals to "it has been queued on wq".

To detect if "it has been queued on wq" requires
a bunch of code. It is not worthy to complicate
this function.

>
>
>  1. rcu-work is queued
>  2. rcu-work starts executing
>                                 3. rcu-work is queued again
>                                 4. rcu-work is flushed
>  5. execution finishes
>                                 6. flush finishes
>                                 7. execution finishes
>
> 6 should happen after 7 but it didn't.
>
> Thanks.
>
> --
> tejun
