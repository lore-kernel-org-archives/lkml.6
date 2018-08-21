Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593292151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jg1nZkvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593292151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHVAI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:08:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35842 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeHVAI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:08:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so34495223oig.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J16GK9o+EmsgNrSQJ3LurKoxIXIe+ecOFmcI6BHO5uI=;
        b=Jg1nZkvr0ML8sc4lCRmNIYywJCYoPOe8406J+JUMrRTOgFwkGGeFwJabRLcrmo+pvf
         graVhIul0utU//I+LjbluTgisyvhZe/QTid6c2SQKWll0sLd+vIunoCzon2nfTBn29R7
         80GArlEjPTUtPVpzP4grlaAjLhcKnmVIEjv08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J16GK9o+EmsgNrSQJ3LurKoxIXIe+ecOFmcI6BHO5uI=;
        b=dADw3cZ921JtpYULLYOfCsTKfeK6GiLMb0GJwlqaOH5wKrUSsZPIbRuvkO3SuSR7gQ
         ja0d1cfQfZJZkeY9lVNO/KxjN3xbDGIxq/jmqWijWXKqmVsPi6tQDSPQL7Lrf8K40Nqe
         z1cHGskyMY7kVZVdYYzUKlqqEu+mAOD9tdIkQ0d/sKw/MXbnLaqXNB6gUbdBoQgKxIvw
         vRyTs6dtJZ+2HzWbVNSP+HzvQWmiXeQib4OnfohakOD/9hsKN2rfvVFiRJPynobrVwCG
         d6E9hYkBIaKYIxllwVXmrZLreqRERh5rC0QYoXCWSHjEOrI43rnXLF1uWqIiqrSSK1Hn
         8O+w==
X-Gm-Message-State: APzg51AXe/bFCq7EGr7FExmqtIQgyzt9XrpnsxUqf13r3f+nsSdaYKjA
        AXMjjMpGuXUex1i5H97dtofWDeKl4R+IGHUJSHM=
X-Google-Smtp-Source: ANB0VdbFsd1Nrww0c7cuSIhRMAYDuWF9eRb5GYotHJreM47KoPDpt51UEqL7hEbnQ6T1ZqSJYMSNz10cIooSNDN9m5M=
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr912529oif.3.1534884434640;
 Tue, 21 Aug 2018 13:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180821185413.GA40305@decatoncale.mtv.corp.google.com>
 <CA+55aFz3HpWHezTKtN2LswehY8=nEaofczPFzPiKram+7DHbfQ@mail.gmail.com> <20180821204241.GA138502@decatoncale.mtv.corp.google.com>
In-Reply-To: <20180821204241.GA138502@decatoncale.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Aug 2018 13:47:03 -0700
Message-ID: <CA+55aFzNE8sidccZ5q+DPW=POgpcuSYj-AncAyT5_=VH9yfobQ@mail.gmail.com>
Subject: Re: [GIT PULL] chrome-platform updates for v4.19
To:     Benson Leung <bleung@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 1:42 PM Benson Leung <bleung@google.com> wrote:
>
> > So the only actual new-to-me patch there is the SPDX identifier fix.
>
> Yes, that's correct.

Ok, good, thanks for verifying.

           Linus
