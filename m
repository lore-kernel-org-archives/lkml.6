Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2320200-1526983387-2-15569751367781812724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526983386; b=mwD9y9RMvzcEsj2rPka+prpg+/QYRD5mHxWOMtK6H9FyG+GlTj
    lioo0mzsBkepJTtZfw4T65QU8rBkn4jah2f9FrXmyslYLUDosgW1VcxC1om5YVFp
    Ok+I2Nm6q7Z5UqJp6z6ttoOS5GqyXEe3qFaOGA7GRO1BNUNaIHixLEIw2V0B5UX0
    /F5px2sq1lc3K3qk2RUiFyQsURLczZwZySm3sdPcA4u1vkp85j8qKxf3PZArhuKd
    gveC9qx5caoCWL+U/ihnmnKHmK/0J7DmkzoSZzXyu4JwPMHNSILlRyFF1jYuzX6F
    wmKa+OfoTbnzDBVDlQK2uey20EDzNbpRt9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526983386; bh=7rmQ8O2xt17bW6iyzIxR6hygRLQZId
    5dO0Enl87nJws=; b=CgtAx9DlkrTTdBoFvx9ZBFdeUvIokCEf/bMdpwRmTJ4qvt
    b5v80VKr7eR146UZhmk38FXhGGTqgxiz4WAv07Th6KEoZcjAMhy6hQVjWkyHgxC9
    +LediEUiTWMyhshAdg5jIsJIIBNNfRRkyGXjynRR8eVkLQ2duo134n9hzAe3/Klv
    N/AwfQ7iMwkU2kKcW2NDMjfy8wdFuG4u3iztdBD+KzFHNfD11ndsaHwTj+pu5JH5
    HEHTs6tnjwALaOAG9F6yMYlW2ZvfHbAXYjB3X39zYzHDzspEV2EpF/eC2UOLfLuT
    v0p2AjWcomYfFUQO7aA5rd2qpeWVi9gfrDT2Z31w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=U1bVoZHE x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=U1bVoZHE x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNLztSjlezkQgY5ZYVs7tYbU7SchO61bQzVLKB3BD7vtqp4Pt7mLOayjUM70qCZhyX3XCX20NYgqzsLeo+uTKK+uDq9qHW7FkA41AqzQaJY75CHNUq0e
    URTNWMmnCDEYLybHIvCDsuOsl3spkIrzLJP7Qx4Jxv1k8R5zqKKh0BkkH7C+AwLDQgkep8AeGPyGyOdxHNL4YIcKrhpfCoDywjPXhuQBVFjK8dj3Cp3kuGMS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=uPpzqJ_YwVX59f6PkjcA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEVKC2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 06:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeEVKC0 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 22 May 2018 06:02:26 -0400
Date: Tue, 22 May 2018 12:02:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 01/33] usb: phy: use match_string() helper
Message-ID: <20180522100208.GC11079@kroah.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-2-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Ven5JXiaPA50K_fq33L2W+atHT81Txp3D=6j4Op1BHPGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ven5JXiaPA50K_fq33L2W+atHT81Txp3D=6j4Op1BHPGA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 01:20:01AM +0300, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> > match_string() returns the index of an array for a matching string,
> > which can be used intead of open coded variant.
> 
> > -       int err, i;
> > +       int ret;
> 
> int err;
> 
> would still work.

And it reduces churn.
