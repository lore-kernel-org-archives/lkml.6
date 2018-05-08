Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2825552-1525785217-2-4887206304728214655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525785216; b=P5GNaRqAXRvz/ALAlcAXmO0AsjPq2Uhd6kzv8m7SlEWBMTTi6c
    QtPud0//vc+5VVX3ey3qUMYJ+j2xbvWtfF7N/v426hBcoyCijnNf3iMrzFEiCvH3
    4cGvg0nN0znc0K5vuu+iHX1hCScnq1vH2QvLXrshTLuMQK6lPChs70jBK20ftbvo
    28qAI8hMpjHzDx355fBuBJ72puYeT2rARtWZb5SE8QzXX0RciGAir7gFAdvbVW7H
    EhYg8iIIkcybUj62fLr64654/Qgf7xE78u6ZLDgEow5KNeVxIOkrX+XRQraKNnak
    pTZ6hHgZPNfWyzKMC4DcTjmwsNVa1jFucDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525785216; bh=fzYVM
    A/ihzenIT3CSxigz8SLU0EIah9Xfwvm8qGfUQA=; b=fR/SHMDbGwUuWhSbc5vCA
    W7GzpgXoR0UkK5D1GnqDZCdY6ITaBPUCyGjEEPZTlcyV6mErSpyE2gzIEtAG1vv2
    dlMCW1p8qbj0flP5K3KwDOSSX20/Hr9OtptrCkUgjk62M/FKRgEqdlWjQ63uNY8J
    abQgloPcV+vVlVMZziENoyyAKNY1uBpbR1u/LEDzkSb8ShhBVkj59xxP1D7AjPwf
    khZbhITF8He5L4+FOXBnZgFxO6tlJ5HcLvSiZW//oMVI3A6d/mZE58O/pB3/nij7
    WrDPU59rCOmiqo8YWC0efihCI1anylKKT3iteMMkWk8uTMMCr/riXwuoZ101cCtJ
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=umn.edu header.i=@umn.edu header.b=ljIpAeXE x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=umn.edu header.i=@umn.edu header.b=ljIpAeXE x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIZO3GGbOk9dPkdW20WaSFhW4H7AovQdy2/itWy3vK472A4vAIB5lgSdhq9l1ZJcaYySnWWl8uiLN5A1oA6NJLsKe+GtpnlxQYFKz+rCDKi147/QnjZv
    DVcx//7jJQ0yx1WHUSOU4Uh708umpKkZBra1xD5cvwCDngl3cSDEEOkX4vSZz4nPG7VP1gj3E9vIYyEQTj9nGBhbPuVvhZrIM/qPvEoQiU6tv7kf6j2Mbkm2
    sRMsoA9nvS72GAxgujQCuQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8
    a=DDOyTI_5AAAA:8 a=p1bNljYMEnfqPBFB82QA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZocKgMFgQp5m1fehwD3oAE4T1dFzMD2xp+mXUnj4a8QnfuQvgOFc+wycLcFPv6zq8m5309Qoc1qs5n9TicVBNA=
MIME-Version: 1.0
In-Reply-To: <20180508121635.mdw4jikv66iyprie@mwanda>
References: <1525300731-27324-1-git-send-email-wang6495@umn.edu>
 <20180508121635.mdw4jikv66iyprie@mwanda>
From: Wenwen Wang <wang6495@umn.edu>
Date: Tue, 8 May 2018 08:04:54 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dZFqKxFg=ez5Q7H=94HvqrO16pWH6sEmwrWgx60xCxNw@mail.gmail.com>
Message-ID: <CAAa=b7dZFqKxFg=ez5Q7H=94HvqrO16pWH6sEmwrWgx60xCxNw@mail.gmail.com>
Subject: Re: [PATCH] media: staging: atomisp: fix a potential missing-check bug
To: Dan Carpenter <dan.carpenter@oracle.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Alan Cox <alan@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
 open list <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 7:16 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, May 02, 2018 at 05:38:49PM -0500, Wenwen Wang wrote:
>> At the end of atomisp_subdev_set_selection(), the function
>> atomisp_subdev_get_rect() is invoked to get the pointer to v4l2_rect. Since
>> this function may return a NULL pointer, it is firstly invoked to check
>> the returned pointer. If the returned pointer is not NULL, then the
>> function is invoked again to obtain the pointer and the memory content
>> at the location of the returned pointer is copied to the memory location of
>> r. In most cases, the pointers returned by the two invocations are same.
>> However, given that the pointer returned by the function
>> atomisp_subdev_get_rect() is not a constant, it is possible that the two
>> invocations return two different pointers. For example, another thread may
>> race to modify the related pointers during the two invocations.
>
> You're assuming a very serious race condition exists.
>
>
>> In that
>> case, even if the first returned pointer is not null, the second returned
>> pointer might be null, which will cause issues such as null pointer
>> dereference.
>
> And then complaining that if a really serious bug exists then this very
> minor bug would exist too...  If there were really a race condition like
> that then we'd want to fix it instead.  In other words, this is not a
> real life bug fix.
>
> But it would be fine as a readability or static checker fix so that's
> fine.

Thanks for your response. From the performance perspective, this bug
should also be fixed, as the second invocation is redundant if it is
expected to return a same pointer as the first one.

Wenwen
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
