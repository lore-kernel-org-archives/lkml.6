Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E8CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143B218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8gyH1xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAXKXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:23:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36084 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:23:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so5846222qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaZicjGfxE1gJlVsb8dqwXJo+bqMYyNKX+NtRrxLIv8=;
        b=i8gyH1xubYU6KYQ5A3iA11eBOy4h4NsM+AKHtgGLl3E31G60I9Jp5Zu1ooNc9MspHR
         cEnlqMf+PqG64hFjZJ4pbXr+ratWSThWH1mPUnnMNZKX/DqafgNl6JoaM7z3+kbH33g7
         HYzXFlJMk+0YVL7EQgS8touAipMvzVhRTOhRWygIDhIBrMJenm1D5gXExKjDoVhpEfqR
         m+kaVI55I1pxq8GiDb3zJmQqBEDYTo+AKaiJg+sk53FnY7dJZHTu1ddCQ0MasyeZ+nue
         06U4Ut/i2joVuuivW0Fy+6xt/1964IQZpUbg5RtoZtRp1VjsofCUXMiPe4sybcnCuASu
         nZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaZicjGfxE1gJlVsb8dqwXJo+bqMYyNKX+NtRrxLIv8=;
        b=eqQnolnM1tEfaiJxcuuf51hQT+PDmCozZsFssMDQrKdMJbNoLtrTOzrdZ6XEurn6dd
         8/PEhJ363SJf3YlQ8Ne8Kd1+QfHgbQ6HzMQHgpnOqOzJ6e8FWsutEnKETj0tBPHECdu/
         aTN4dNH0HrKjypuHgbL+PsTueMXFxQ0FehNwORLArzthy5zdFC3SQU3PSEhEdyUzy8HI
         oz59CCDdNONmK0SsLluYXGJVx7YJoZyJjt7eELeGZFtXpjWIdeqh+A9Ptdyd0kMxfsfN
         ftERy1ugOs2oEIz4dTYuCoObjhStG0jQu/iR2XLUT0c6169t8pk8KH/wYJX+02kGIsv+
         C0/g==
X-Gm-Message-State: AJcUukczfTfwWPN2R1KoEKTPYOPKZCRErE+AUVWyJC9exG+7Kv11qfHv
        ydGWqgIMP9R4LmZKAEsg1iJZQrdCla4P3B9YN2Ig8bl3
X-Google-Smtp-Source: ALg8bN7KQNk9cU7jFGRPzPy7DxFUdaANwx1aARR25xMUcSyusVFkzlbi8QSyJAV+Hnu3OeqM59z8UfHEHv2OF29AFRU=
X-Received: by 2002:ac8:296a:: with SMTP id z39mr6201399qtz.264.1548325381655;
 Thu, 24 Jan 2019 02:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAOesGMhU6wzX=sBC0iqDrzBYinP8POp=9-d4oEQoaNee-dU1zQ@mail.gmail.com>
 <20190123234817.GE1257@redhat.com> <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
 <CAFCwf10fvFAXQCGXpJHdf2bBOEJ9ZXZvoUgH9JWbNOtnmELBmg@mail.gmail.com>
In-Reply-To: <CAFCwf10fvFAXQCGXpJHdf2bBOEJ9ZXZvoUgH9JWbNOtnmELBmg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 24 Jan 2019 20:22:49 +1000
Message-ID: <CAPM=9twdfFSevH-qq7Vf1F7-nAgYvAw9XYmEKT-8LYBc403Thw@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        Olof Johansson <olof@lixom.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I know I won't be able to convince you but I want to say that I think
> your arguments for full userspace open source are not really
> technical.

There is more to keeping a kernel going than technical argument unfortunately.

I guess the question for Greg, Olof etc, is do we care about Linux the
kernel, or Linux the open source ecosystem, if the former, these sort
of accelerator shim drivers are fine, useless to anyone who doesn't
have all the magic hidden userspace, and impossible to support for
anyone else, if the latter, we should leave the cost of maintenance to
the company benefiting from it and leave maintaining it out of tree.

Simple question like If I plug your accelerator into Power or ARM64,
where do I get the port of your userspace to use it?

I'm not the final arbiter on this sort of thing, but I'm definitely
going to make sure that anyone who lands this code is explicit in
ignoring any experience we've had in this area and in the future will
gladly accept "I told you so" :-)

Dave.
